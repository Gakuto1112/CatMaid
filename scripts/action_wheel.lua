---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPages table アクションホイールのメインページのテーブル
---@field CinematicPage Page シネマティックモードモードの操作ページ
---@field CurrentMainPage integer 現在のメインページのページ数
---@field ActionCancelFunction function 現在再生中のアクションをキャンセルする処理
---@field ActionWheelClass.ActionCount integer アクション再生中は0より大きくなるカウンター
---@field SweatCount integer 汗のタイミングを計るカウンター
---@field PatAnimationCount integer ナデナデするアクションのタイミングを計るカウンター

ActionWheelClass = {}

MainPages = {action_wheel:createPage("main_page_1"), action_wheel:createPage("main_page_2")}
CinematicPage = action_wheel:createPage("cinematic_mode_page")
CurrentMainPage = 1
ActionWheelClass.ActionCount = 0
ActionCancelFunction = nil
ShakeSplashCount = 0
SweatCount = 0
PatAnimationCount = -1

---アクションの色の有効色/無効色の切り替え
---@param pageNumber integer アクションのページの番号
---@param actionNumber integer pageNumber内のアクションの番号
---@param enabled boolean 有効色か無効色か
function setActionEnabled(pageNumber, actionNumber, enabled)
	if enabled then
		MainPages[pageNumber]:getAction(actionNumber):title(LanguageClass.getTranslate("action_wheel__main_"..pageNumber.."__action_"..actionNumber.."__title")):color(1, 85 / 255, 1):hoverColor(1, 1, 1)
	else
		MainPages[pageNumber]:getAction(actionNumber):title("§7"..LanguageClass.getTranslate("action_wheel__main_"..pageNumber.."__action_"..actionNumber.."__title")):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255)
	end
end

---アクションを実行する。ウォーデンが近くにいる時は拒否アクションを実行する。
---@param action function 実行するアクションの関数
---@param actionCancelFunction function アクションのキャンセル処理の関数
---@param ignoreCooldown boolean アニメーションのクールダウンを無視するかどうか
function runAction(action, actionCancelFunction, ignoreCooldown)
	if ActionWheelClass.ActionCount == 0 or ignoreCooldown then
		if WardenClass.WardenNearby then
			if not GoatHornClass.Horn then
				General.setAnimations("PLAY", "refuse_emote")
				EyesAndMouthClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 30, true)
				ActionCancelFunction = nil
				ActionWheelClass.ActionCount = 30
				SweatCount = 30
			end
		else
			action()
			ActionCancelFunction = actionCancelFunction
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
	ActionCancelFunction = function()
		General.setAnimations("STOP", "shake")
		ShakeSplashCount = 0
	end
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
	if WardenClass.WardenNearby or ActionWheelClass.ActionCount > 0 then
		for i = 1, 7 do
			setActionEnabled(1, i, false)
		end
		for i = 1, 3 do
			setActionEnabled(2, i, false)
		end
	else
		for i = 1, 7 do
			setActionEnabled(1, i, true)
		end
		setActionEnabled(2, 1, player:getPose() == "STANDING")
		setActionEnabled(2, 3, true)
	end
	setActionEnabled(2, 2, not WardenClass.WardenNearby and canSitDown())
	if (WardenClass.WardenNearby or HurtClass.Damaged ~= "NONE") and ActionWheelClass.ActionCount > 0 and ActionCancelFunction ~= nil then
		ActionCancelFunction()
		ActionWheelClass.ActionCount = 0
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
	if SweatCount > 0 then
		if SweatCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(meta:getMaxParticles() / 4, 4) do
				particle:addParticle("minecraft:splash", playerPos.x, playerPos.y + 2, playerPos.z)
			end
		end
		SweatCount = SweatCount - 1
	end
	if PatAnimationCount >= 0 then
		if PatAnimationCount == 145 then
			models.models.player_hands.Avatar.Head.PlayerHand1:setVisible(false)
			sound:playSound("entity.item.pickup", player:getPos(), 1, 0.5)
			PatAnimationCount = -1
		else
			if PatAnimationCount == 55 then
				EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 40, true)
			elseif PatAnimationCount == 95 then
				local playerPos = player:getPos()
				MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
				particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
				EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
			elseif PatAnimationCount == 115 then
				EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 22, true)
			end
			PatAnimationCount = PatAnimationCount + 1
		end
	end
end)

events.RENDER:register(function()
	local headRotationList = {models.models.main.Avatar.Head, models.models.armor.Avatar.Head, models.models.summer_features.Head, models.models.player_hands.Avatar.Head}
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
	MainPages[2]:getAction(2):toggled(canSitDown() and MainPages[2]:getAction(2):isToggled())
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
	end, function()
		General.setAnimations("STOP", "left_meow")
	end, false)
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
	end, function()
		General.setAnimations("STOP", "right_meow")
	end, false)
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
	end, function()
		General.setAnimations("STOP", "left_meow")
	end, false)
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
	end, function()
		General.setAnimations("STOP", "right_meow")
	end, false)
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
	end, nil, false)
end)

--アクション1-4. 「ニャー」と鳴く（> <）
MainPages[1]:newAction(4):item("cod"):onLeftClick(function()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			if General.isTired() then
				MeowClass.playMeow("WEAK", 1)
				EyesAndMouthClass.setEmotion("TIRED", "TIRED", "OPENED", 20, true)
			else
				MeowClass.playMeow("NORMAL", 1)
				EyesAndMouthClass.setEmotion("UNEQUAL", "UNEQUAL", "OPENED", 20, true)
			end
			ActionWheelClass.ActionCount = 20
		end
	end, nil, false)
end)

--アクション1-5. 驚く
MainPages[1]:newAction(5):item("cod"):onLeftClick(function()
	runAction(function()
		MeowClass.playMeow("HURT", 1)
		if General.isTired() then
			EyesAndMouthClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 20, true)
		else
			EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
		end
		SweatCount = 20
		ActionWheelClass.ActionCount = 20
	end, function()
		SweatCount = 0
	end, false)
end)

--アクション1-6. 威嚇
MainPages[1]:newAction(6):item("cod"):onLeftClick(function()
	runAction(function()
		local playerPos = player:getPos()
		for _ = 1, math.min(meta:getMaxParticles(), 8) do
			particle:addParticle("minecraft:angry_villager", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
		end
		MeowClass.playMeow("HISS", 0.5)
		if General.isTired() then
			EyesAndMouthClass.setEmotion("INTIMIDATE_TIRED", "INTIMIDATE_TIRED", "CLOSED", 40, true)
		else
			EyesAndMouthClass.setEmotion("INTIMIDATE", "INTIMIDATE", "CLOSED", 40, true)
		end
		General.setAnimations("PLAY", "intimidate")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "intimidate")
	end, false)
end):onRightClick(function()
	runAction(function()
		local playerPos = player:getPos()
		for _ = 1, math.min(meta:getMaxParticles(), 16) do
			particle:addParticle("minecraft:angry_villager", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
		end
		MeowClass.playMeow("HISS", 1)
		if General.isTired() then
			EyesAndMouthClass.setEmotion("INTIMIDATE_TIRED", "INTIMIDATE_TIRED", "TOOTH", 40, true)
		else
			EyesAndMouthClass.setEmotion("INTIMIDATE", "INTIMIDATE", "TOOTH", 40, true)
		end
		General.setAnimations("PLAY", "intimidate")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "intimidate")
	end, false)
end)

--アクション1-7. しょんぼり
MainPages[1]:newAction(7):item("cod"):onLeftClick(function()
	runAction(function()
		MeowClass.playMeow("HURT", 0.5)
		if General.isTired() then
			EyesAndMouthClass.setEmotion("DEPRESSED_TIRED", "DEPRESSED_TIRED", "CLOSED", 40, true)
		else
			EyesAndMouthClass.setEmotion("DEPRESSED", "DEPRESSED", "CLOSED", 40, true)
		end
		General.setAnimations("PLAY", "depressed")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "depressed")
	end, false)
end)

--アクション2-1. ナデナデ（頭）
MainPages[2]:newAction(1):item("feather"):onLeftClick(function()
	runAction(function()
		if player:getPose() == "STANDING" then
			General.setAnimations("PLAY", "pat_head")
			models.models.player_hands.Avatar.Head.PlayerHand1:setVisible(true)
			sound:playSound("entity.item.pickup", player:getPos(), 1, 0.5)
			PatAnimationCount = 0
			ActionWheelClass.ActionCount = 145
		end
	end, function()
		General.setAnimations("STOP", "pat_head")
		models.models.player_hands.Avatar.Head.PlayerHand1:setVisible(false)
		PatAnimationCount = -1
	end)
end)

--アクション2-2. おすわり
MainPages[2]:newToggle(2):toggleColor(1, 85 / 255, 1):item("oak_stairs"):onToggle(function()
	runAction(function()
		if canSitDown() then
			BellSoundClass.playBellSound()
			ActionWheelClass.sitDown()
		end
	end, nil, not WardenClass.WardenNearby)
end):onUntoggle(function()
	BellSoundClass.playBellSound()
	ActionWheelClass.standUp()
end)

--アクション2-3. ブルブル
MainPages[2]:newAction(3):item("water_bucket"):onLeftClick(function()
	runAction(function()
		ActionWheelClass.bodyShake()
	end, function()
		General.setAnimations("STOP", "shake")
		ShakeSplashCount = 0
	end, false)
end)

--アクション2-4. 夏機能
MainPages[2]:newToggle(4):title(LanguageClass.getTranslate("action_wheel__main_2__action_4__title")..LanguageClass.getTranslate("action_wheel__enable")):toggleTitle(LanguageClass.getTranslate("action_wheel__main_2__action_3__title")..LanguageClass.getTranslate("action_wheel__disable")):item("bucket"):toggleItem("tropical_fish_bucket"):color(170 / 255, 0, 0):toggleColor(0, 170 / 255, 0):hoverColor(1, 1, 1):onToggle(function()
	SummerFeatureClass.setSummerFeature(true)
end):onUntoggle(function()
	SummerFeatureClass.setSummerFeature(false)
end)

--アクション2-5. シネマティックモード
MainPages[2]:newAction(5):title(LanguageClass.getTranslate("action_wheel__main_2__action_5__title")):color(85 / 255, 1, 1):hoverColor(1, 1, 1):item("painting"):onLeftClick(function()
	CinematicModeClass.CinematicMode = true
	action_wheel:setPage(CinematicPage)
end)

--アクション2-6. 設定を開く
MainPages[2]:newAction(6):title("§7"..LanguageClass.getTranslate("action_wheel__main_2__action_6__title")):color(42 / 255, 42 / 255, 42 / 255):hoverColor(1, 85 / 255, 85 / 255):item("comparator"):onLeftClick(function()
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