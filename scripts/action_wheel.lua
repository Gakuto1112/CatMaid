---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPages table アクションホイールのメインページのテーブル
---@field CinematicPage Page シネマティックモードモードの操作ページ
---@field CurrentMainPage integer 現在のメインページのページ数
---@field ActionWheelClass.ActionCount integer アクション再生中は0より大きくなるカウンター
---@field TerrorSweatCount integer エモートを拒否する時にかく汗のタイミングを計るカウンター

ActionWheelClass = {}

MainPages = {action_wheel:createPage("main_page_1"), action_wheel:createPage("main_page_2")}
CinematicPage = action_wheel:createPage("cinematic_mode_page")
CurrentMainPage = 1
ActionWheelClass.ActionCount = 0
ShakeSplashCount = 0
TerrorSweatCount = 0

---アクションを実行する。ウォーデンが近くにいる時は拒否アクションを実行する。
---@param action function
function runAction(action)
	if ActionWheelClass.ActionCount == 0 then
		if WardenClass.WardenNearby then
			if not GoatHornClass.Horn then
				General.setAnimations("PLAY", "refuse_emote")
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
	General.setAnimations("PLAY", "sit_down")
	General.setAnimations("STOP", "stand_up")
	animations["main"]["wave_tail"]:stop()
end

--座っている状態から立ち上がる
function ActionWheelClass.standUp()
	vanilla_model.HELD_ITEMS:setVisible(true)
	General.setAnimations("PLAY", "stand_up")
	General.setAnimations("STOP", "sit_down")
	if ConfigClass.WaveTail then
		animations["main"]["wave_tail"]:play()
	end
	models.models.main.Avatar.Head:setRot(0, 0, 0)
end

---ブルブル
function ActionWheelClass.bodyShake()
	General.setAnimations("PLAY", "shake")
	sound:playSound("minecraft:entity.wolf.shake", player:getPos(), 1, 1.5)
	EyesAndMouthClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 20, true)
	if WetClass.WetCount > 0 and not player:isWet() then
		ShakeSplashCount = 20
		WetClass.WetCount = 20
	end
	ActionWheelClass.ActionCount = 20
end

events.TICK:register(function()
	local actionTitles1 = {LanguageClass.getTranslate("action_wheel__main_1__action_1__title"), LanguageClass.getTranslate("action_wheel__main_1__action_2__title"), LanguageClass.getTranslate("action_wheel__main_1__action_3__title")}
	local actionTitles2 = {LanguageClass.getTranslate("action_wheel__main_2__action_1__title"), LanguageClass.getTranslate("action_wheel__main_2__action_2__title")}
	local sitDownAction = MainPages[2]:getAction(1)
	if WardenClass.WardenNearby then
		for index, actionName in ipairs(actionTitles1) do
			MainPages[1]:getAction(index):title("§7"..actionName):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255)
		end
		for index, actionName in ipairs(actionTitles2) do
			MainPages[2]:getAction(index):title("§7"..actionName):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255)
		end
	else
		for index, actionName in ipairs(actionTitles1) do
			MainPages[1]:getAction(index):title(actionName):color(1, 85 / 255, 1):hoverColor(1, 1, 1)
		end
		for index, actionName in ipairs(actionTitles2) do
			if index == 1 then
				if canSitDown() then
					sitDownAction:title(actionName):color(1, 85 / 255, 1):toggleColor(1, 85 / 255, 1):hoverColor(1, 1, 1)
				else
					sitDownAction:title("§7"..actionName):color(42 / 255, 42 / 255, 42 / 255):toggleColor(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255)
				end
			else
				MainPages[2]:getAction(index):title(actionName):color(1, 85 / 255, 1):hoverColor(1, 1, 1)
			end
		end
	end
	if animations["main"]["sit_down"]:getPlayState() == "PLAYING" and not canSitDown() then
		ActionWheelClass.standUp()
		animations["main"]["sit_down_first_person_fix"]:stop()
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
	local headRotationList = {models.models.main.Avatar.Head, models.models.armor.Avatar.Head, models.models.summer_features.Head}
	if animations["main"]["sit_down"]:getPlayState() == "PLAYING" then
		local headRot = 10 * (1 - math.abs(player:getLookDir().y)) * (renderer:isCameraBackwards() and 1 or -1)
		for _, modelPart in ipairs(headRotationList) do
			modelPart:setRot(headRot, 0, 0)
		end
	else
		for _, modelPart in ipairs(headRotationList) do
			modelPart:setRot(0, 0, 0)
		end
	end
end)

events.WORLD_RENDER:register(function()
	MainPages[2]:getAction(1):toggled(canSitDown() and MainPages[2]:getAction(1):isToggled())
	if animations["main"]["sit_down"]:getPlayState() == "PLAYING" and renderer:isFirstPerson() then
		animations["main"]["sit_down_first_person_fix"]:play()
	else
		animations["main"]["sit_down_first_person_fix"]:stop()
	end
end)

--メインページのアクションの設定
--アクション1-1. 「ニャー」と鳴く（スマイル）
MainPages[1]:newAction(1):item("cod"):onLeftClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
			EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			General.setAnimations("PLAY", "left_meow")
			ActionWheelClass.ActionCount = 20
		end
	end)
end):onRightClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
			EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			General.setAnimations("PLAY", "right_meow")
			ActionWheelClass.ActionCount = 20
		end
	end)
end)

--アクション1-2. 「ニャー」と鳴く（ウィンク）
MainPages[1]:newAction(2):item("cod"):onLeftClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			EyesAndMouthClass.setEmotion("NONE", "CLOSED", "OPENED", 20, true)
			General.setAnimations("PLAY", "left_meow")
			ActionWheelClass.ActionCount = 20
		end
	end)
end):onRightClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			EyesAndMouthClass.setEmotion("CLOSED", "NONE", "OPENED", 20, true)
			General.setAnimations("PLAY", "right_meow")
			ActionWheelClass.ActionCount = 20
		end
	end)
end)

--アクション1-3. 「ニャー」と鳴く（キラキラ）
MainPages[1]:newAction(3):item("cod"):onLeftClick(function()
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

--アクション2-1. おすわり
MainPages[2]:newToggle(1):item("oak_stairs"):onToggle(function()
	runAction(function()
		if canSitDown() then
			ActionWheelClass.sitDown()
		end
	end)
end):onUntoggle(function()
	ActionWheelClass.standUp()
end)

--アクション2-2. ブルブル
MainPages[2]:newAction(2):item("water_bucket"):onLeftClick(function()
	runAction(function()
		ActionWheelClass.bodyShake()
	end)
end)

--アクション2-3. 夏機能
MainPages[2]:newToggle(3):title(LanguageClass.getTranslate("action_wheel__main_2__action_3__title")..LanguageClass.getTranslate("action_wheel__enable")):toggleTitle(LanguageClass.getTranslate("action_wheel__main_2__action_3__title")..LanguageClass.getTranslate("action_wheel__disable")):item("bucket"):toggleItem("tropical_fish_bucket"):color(170 / 255, 0, 0):toggleColor(0, 170 / 255, 0):hoverColor(1, 1, 1):onToggle(function()
	SummerFeatureClass.setSummerFeature(true)
end):onUntoggle(function()
	SummerFeatureClass.setSummerFeature(false)
end)

--アクション2-4. シネマティックモード
MainPages[2]:newAction(4):title(LanguageClass.getTranslate("action_wheel__main_2__action_4__title")):color(85 / 255, 1, 1):hoverColor(1, 1, 1):item("painting"):onLeftClick(function()
	CinematicModeClass.CinematicMode = true
	action_wheel:setPage(CinematicPage)
end)

--アクション2-5. 設定を開く
MainPages[2]:newAction(5):title("§7"..LanguageClass.getTranslate("action_wheel__main_2__action_5__title")):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255):item("comparator"):onLeftClick(function()
	print(LanguageClass.getTranslate("message__config_unavailable"))
end)

--アクション8（共通）. ページ切り替え
for index, mainPage in ipairs(MainPages) do
	mainPage:newScroll(8):title(LanguageClass.getTranslate("action_wheel__main__page_switch__title")..index.."/"..#MainPages):color(200 / 255, 200 / 255, 200 / 255):hoverColor(1, 1, 1):item("arrow"):onScroll(function(direction)
		CurrentMainPage = CurrentMainPage - direction
		CurrentMainPage = CurrentMainPage < 1 and CurrentMainPage + #MainPages or (CurrentMainPage > #MainPages and CurrentMainPage - #MainPages or CurrentMainPage)
		action_wheel:setPage(MainPages[CurrentMainPage])
	end)
end

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
	action_wheel:setPage(MainPages[2])
end)

action_wheel:setPage(MainPages[1])

return ActionWheelClass