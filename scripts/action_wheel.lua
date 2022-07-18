---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPage Page アクションホイールのメインページ
---@field CinematicPage Page シネマティックモードモードの操作ページ
---@field ActionWheelClass.ActionCount integer アクション再生中は0より大きくなるカウンター
---@field TerrorSweatCount integer エモートを拒否する時にかく汗のタイミングを計るカウンター

ActionWheelClass = {}

MainPage = action_wheel:createPage("main_page")
CinematicPage = action_wheel:createPage("cinematic_mode_page")
ActionWheelClass.ActionCount = 0
ShakeSplashCount = 0
TerrorSweatCount = 0

---アクションを実行する。ウォーデンが近くにいる時は拒否アクションを実行する。
---@param action function
function runAction(action)
	if ActionWheelClass.ActionCount == 0 then
		if WardenClass.WardenNearby then
			if not GoatHornClass.Horn then
				General.playAnimationWithArmor("refuse_emote")
				EyesAndMouthClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 30, true)
				ActionWheelClass.ActionCount = 30
				TerrorSweatCount = 30
			end
		else
			action()
		end
	end
end

---現在座れる状況かを返す。
---@return boolean
function canSitDown()
	if player:exists() then
		local velocity = player:getVelocity()
		return player:getPose() == "STANDING" and player:isOnGround() and not player:getVehicle() and math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2)) == 0 and HurtClass.Damaged == "NONE" and not WardenClass.WardenNearby
	else
		return false
	end
end

---座る
function ActionWheelClass.sitDown()
	vanilla_model.HELD_ITEMS:setVisible(false) --FIXME: BBmodelに手持ちアイテムのキーワードが存在しないので、暫定処理として手持ちアイテムを非表示にする。
	General.playAnimationWithArmor("sit_down")
	animation["alternative_arms"]["sit_down"]:play()
	General.stopAnimationWithArmor("stand_up")
	animation["alternative_arms"]["stand_up"]:stop()
	animation["main"]["wave_tail"]:stop()
end

--座っている状態から立ち上がる
function ActionWheelClass.standUp()
	vanilla_model.HELD_ITEMS:setVisible(true)
	General.playAnimationWithArmor("stand_up")
	animation["alternative_arms"]["stand_up"]:play()
	General.stopAnimationWithArmor("sit_down")
	animation["alternative_arms"]["sit_down"]:stop()
	if ConfigClass.WaveTail then
		animation["main"]["wave_tail"]:play()
	end
	models.models.main.Avatar.Head:setRot(0, 0, 0)
end

---ブルブル
function ActionWheelClass.bodyShake()
	General.playAnimationWithArmor("shake")
	animation["alternative_arms"]["shake"]:play()
	sound:playSound("minecraft:entity.wolf.shake", player:getPos(), 1, 1.5)
	EyesAndMouthClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 20, true)
	if WetClass.WetCount > 0 then
		ShakeSplashCount = 20
		WetClass.WetCount = 20
	end
	ActionWheelClass.ActionCount = 20
end

events.TICK:register(function()
	local actionTitles = {LanguageClass.getTranslate("action_wheel__main__action_1__title"), LanguageClass.getTranslate("action_wheel__main__action_2__title"), LanguageClass.getTranslate("action_wheel__main__action_3__title"), LanguageClass.getTranslate("action_wheel__main__action_4__title"), LanguageClass.getTranslate("action_wheel__main__action_5__title")}
	local action4 = MainPage:getAction(4)
	if WardenClass.WardenNearby then
		for index, actionName in ipairs(actionTitles) do
			MainPage:getAction(index):title("§7"..actionName):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255)
		end
	else
		for index, actionName in ipairs(actionTitles) do
			if index == 4 then
				if canSitDown() then
					action4:title(actionName):color(1, 85 / 255, 1):toggleColor(1, 85 / 255, 1):hoverColor(1, 1, 1)
				else
					action4:title("§7"..actionName):color(42 / 255, 42 / 255, 42 / 255):toggleColor(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255)
				end
			else
				MainPage:getAction(index):title(actionName):color(1, 85 / 255, 1):hoverColor(1, 1, 1)
			end
		end
	end
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" and not canSitDown() then
		ActionWheelClass.standUp()
		animation["main"]["sit_down_first_person_fix"]:stop()
	end
	if ShakeSplashCount > 0 then
		if ShakeSplashCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(meta:getMaxParticles() / 4, 4) do
				particle:addParticle("minecraft:splash", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
			end
		end
		ShakeSplashCount = ShakeSplashCount - 1
	end
	ActionWheelClass.ActionCount = ActionWheelClass.ActionCount > 0 and ActionWheelClass.ActionCount - 1 or ActionWheelClass.ActionCount
	if TerrorSweatCount > 0 then
		if TerrorSweatCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(meta:getMaxParticles() / 4, 4) do
				particle:addParticle("minecraft:splash", playerPos.x, playerPos.y + 2, playerPos.z)
			end
		end
		TerrorSweatCount = TerrorSweatCount - 1
	end
end)

events.RENDER:register(function()
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" then
		models.models.main.Avatar.Head:setRot(10 * (1 - math.abs(player:getLookDir().y)) * (renderer:isCameraBackwards() and 1 or -1), 0, 0)
	end
end)

events.WORLD_RENDER:register(function()
	MainPage:getAction(4):toggled(canSitDown() and MainPage:getAction(4):isToggled())
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" and renderer:isFirstPerson() then
		animation["main"]["sit_down_first_person_fix"]:play()
	else
		animation["main"]["sit_down_first_person_fix"]:stop()
	end
end)

--メインページのアクションの設定
MainPage:newAction()

--アクション1. 「ニャー」と鳴く（スマイル）
MainPage:newAction(1):item("cod"):onLeftClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
			EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			if player:isLeftHanded() then
				General.playAnimationWithArmor("left_meow")
			else
				General.playAnimationWithArmor("right_meow")
			end
			ActionWheelClass.ActionCount = 20
		end
	end)
end)

--アクション2. 「ニャー」と鳴く（ウィンク）
MainPage:newAction(2):item("cod"):onLeftClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			if player:isLeftHanded() then
				EyesAndMouthClass.setEmotion("NONE", "CLOSED", "OPENED", 20, true)
				General.playAnimationWithArmor("left_meow")
			else
				EyesAndMouthClass.setEmotion("CLOSED", "NONE", "OPENED", 20, true)
				General.playAnimationWithArmor("right_meow")
			end
			ActionWheelClass.ActionCount = 20
		end
	end)
end)

--アクション3. 「ニャー」と鳴く（キラキラ）
MainPage:newAction(3):item("cod"):onLeftClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			if General.isTired() then
				MeowClass.playMeow("WEAK", 1)
				EyesAndMouthClass.setEmotion("TIRED", "TIRED", "OPENED", 20, true)
			else
				MeowClass.playMeow("NORMAL", 1)
				EyesAndMouthClass.setEmotion("SHINE", "SHINE", "OPENED", 20, true)
			end
			ActionWheelClass.ActionCount = 20
		end
	end)
end)

--アクション4. おすわり
MainPage:newToggle(4):item("oak_stairs"):onToggle(function()
	runAction(function()
		if canSitDown() then
			ActionWheelClass.sitDown()
		end
	end)
end):onUntoggle(function()
	ActionWheelClass.standUp()
end)

--アクション5. ブルブル
MainPage:newAction(5):item("water_bucket"):onLeftClick(function()
	runAction(function()
		ActionWheelClass.bodyShake()
	end)
end)

--アクション6. シネマティックモード
MainPage:newAction(6):title(LanguageClass.getTranslate("action_wheel__main__action_6__title")):color(85 / 255, 1, 1):hoverColor(1, 1, 1):item("painting"):onLeftClick(function()
	CinematicModeClass.CinematicMode = true
	action_wheel:setPage(CinematicPage)
end)

--アクション7. 設定を開く
MainPage:newAction(7):title("§7"..LanguageClass.getTranslate("action_wheel__main__action_7__title")):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255):item("comparator"):onLeftClick(function()
	print(LanguageClass.getTranslate("message__config_unavailable"))
end)

--シネマティックモードのページのアクションの設定
--アクション1. ピッチ調整
CinematicPage:newScroll(1):title(LanguageClass.getTranslate("action_wheel__cinematic__action_1__title").." "..ConfigClass.CinematicModeCamera.PitchInit):color(1, 85 / 255, 85 / 255):hoverColor(1, 1, 1):item("painting"):onScroll(function(direction)
	CinematicModeClass.addCameraPitch(direction == 1 and 5 or -5)
	CinematicPage:getAction(1):title(LanguageClass.getTranslate("action_wheel__cinematic__action_1__title").." "..CinematicModeClass.CameraRot[1])
end)

--アクション2. ロール調整
CinematicPage:newScroll(2):title(LanguageClass.getTranslate("action_wheel__cinematic__action_2__title").." "..ConfigClass.CinematicModeCamera.RollInit):color(85 / 255, 1, 85 / 255):hoverColor(1, 1, 1):item("painting"):onScroll(function(direction)
	CinematicModeClass.addCameraRoll(direction == 1 and 5 or -5)
	CinematicPage:getAction(2):title(LanguageClass.getTranslate("action_wheel__cinematic__action_2__title").." "..CinematicModeClass.CameraRot[2])
end)

--アクション3. ヨー調整
CinematicPage:newScroll(3):title(LanguageClass.getTranslate("action_wheel__cinematic__action_3__title").." "..ConfigClass.CinematicModeCamera.YawInit):color(85 / 255, 85 / 255, 1):hoverColor(1, 1, 1):item("painting"):onScroll(function(direction)
	CinematicModeClass.addCameraYaw(direction == 1 and 5 or -5)
	CinematicPage:getAction(3):title(LanguageClass.getTranslate("action_wheel__cinematic__action_3__title").." "..CinematicModeClass.CameraRot[3])
end)

--アクション4. カメラリセット
CinematicPage:newAction(4):title(LanguageClass.getTranslate("action_wheel__cinematic__action_4__title")):color(170 / 255, 0, 170 / 255):hoverColor(1, 1, 1):item("painting"):onLeftClick(function()
	CinematicModeClass.resetCamera()
	CinematicPage:getAction(1):title(LanguageClass.getTranslate("action_wheel__cinematic__action_1__title").." "..ConfigClass.CinematicModeCamera.PitchInit)
	CinematicPage:getAction(2):title(LanguageClass.getTranslate("action_wheel__cinematic__action_2__title").." "..ConfigClass.CinematicModeCamera.RollInit)
	CinematicPage:getAction(3):title(LanguageClass.getTranslate("action_wheel__cinematic__action_3__title").." "..ConfigClass.CinematicModeCamera.YawInit)
end)


--アクション5. シネマティックモード終了
CinematicPage:newAction(5):title(LanguageClass.getTranslate("action_wheel__cinematic__action_5__title")):color(200 / 255, 200 / 255, 200 /255):hoverColor(1, 1, 1):item("barrier"):onLeftClick(function()
	CinematicModeClass.CinematicMode = false
	action_wheel:setPage(MainPage)
end)

action_wheel:setPage(MainPage)

return ActionWheelClass