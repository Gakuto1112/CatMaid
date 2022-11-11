---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPages table アクションホイールのメインページのテーブル
---@field CurrentMainPage integer 現在のメインページのページ数
---@field ConfigPage Page アバター設定のページ
---@field IsOpenActionWheelPrev boolean 前チックにアクションホイールを開けていたかどうか
---@field ActionCancelFunction function 現在再生中のアクションをキャンセルする処理
---@field ActionWheelClass.ActionCount integer アクション再生中は0より大きくなるカウンター
---@field SweatCount integer 汗のタイミングを計るカウンター
---@field HeadPatAnimationCount integer 頭をナデナデするアクションのタイミングを計るカウンター
---@field TailPatAnimationCount integer 尻尾をナデナデするアクションのタイミングを計るカウンター
---@field ActionWheelClass.CurrentCatType integer プレイヤーの現在のネコの種類を示す：1. オリジナル, 2. 完全黒, 3. 黒, 4. ブリティッシュショートヘアー, 5. 三毛猫, 6. 灰トラ, 7. ジェリー, 8. ヤマネコ, 9. ペルシャ猫, 10. ラグドール, 11. 赤, 12. シャムネコ, 13. トラ, 14. 白
---@field CatType integer プレイヤーの猫の種類を示す：1. オリジナル, 2. 完全黒, 3. 黒, 4. ブリティッシュショートヘアー, 5. 三毛猫, 6. 灰トラ, 7. ジェリー, 8. ヤマネコ, 9. ペルシャ猫, 10. ラグドール, 11. 赤, 12. シャムネコ, 13. トラ, 14. 白
---@field ActionWheelClass.CurrentBellVolume number 鈴の現在の音量
---@field CurrentBellVolume number 鈴の音量

ActionWheelClass = {}

MainPages = {action_wheel:createPage("main_page_1"), action_wheel:createPage("main_page_2")}
CurrentMainPage = 1
ConfigPage = action_wheel:createPage()
IsOpenActionWheelPrev = false
ActionWheelClass.ActionCount = 0
ActionCancelFunction = nil
ShakeSplashCount = 0
SweatCount = 0
HeadPatAnimationCount = -1
TailPatAnimationCount = -1
ActionWheelClass.CurrentCatType = 1
CatType = ActionWheelClass.CurrentCatType
ActionWheelClass.CurrentBellVolume = 0.1
BellVolume = ActionWheelClass.CurrentBellVolume

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
				FacePartsClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 30, true)
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

function setCatTypeActionTitle()
	if CatType == ActionWheelClass.CurrentCatType then
		ConfigPage:getAction(1):title(LanguageClass.getTranslate("action_wheel__config__action_1__title").."§b"..LanguageClass.getTranslate("cat_type__"..TailAndEarsClass.CatTypeID[CatType]))
	else
		ConfigPage:getAction(1):title(LanguageClass.getTranslate("action_wheel__config__action_1__title").."§b"..LanguageClass.getTranslate("cat_type__"..TailAndEarsClass.CatTypeID[CatType]).."\n§7"..LanguageClass.getTranslate("action_wheel__close_to_confirm"))
	end
end

function setBellVolumeTitle()
	if BellVolume == ActionWheelClass.CurrentBellVolume then
		ConfigPage:getAction(2):title(LanguageClass.getTranslate("action_wheel__config__action_2__title").."§b"..math.round((BellVolume * 100))..LanguageClass.getTranslate("unit__percent"))
	else
		ConfigPage:getAction(2):title(LanguageClass.getTranslate("action_wheel__config__action_2__title").."§b"..math.round((BellVolume * 100))..LanguageClass.getTranslate("unit__percent").."\n§7"..LanguageClass.getTranslate("action_wheel__close_to_confirm"))
	end
end

--ブルブル
function ActionWheelClass.bodyShake()
	ActionCancelFunction = function()
		General.setAnimations("STOP", "shake")
		ShakeSplashCount = 0
	end
	General.setAnimations("PLAY", "shake")
	sounds:playSound("minecraft:entity.wolf.shake", player:getPos(), 1, 1.5)
	FacePartsClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 20, true)
	if WetClass.WetCount > 0 and not player:isWet() then
		ShakeSplashCount = 20
		WetClass.WetCount = 20
	end
	ActionWheelClass.ActionCount = 20
end

--ping関数
function pings.main1_action1_left()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired and "WEAK" or "NORMAL", 1)
			FacePartsClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
			particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			General.setAnimations("PLAY", "left_meow")
			ActionWheelClass.ActionCount = 20
		end
	end, function()
		General.setAnimations("STOP", "left_meow")
	end, false)
end

function pings.main1_action1_right()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired and "WEAK" or "NORMAL", 1)
			FacePartsClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
			particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			General.setAnimations("PLAY", "right_meow")
			ActionWheelClass.ActionCount = 20
		end
	end, function()
		General.setAnimations("STOP", "right_meow")
	end, false)
end

function pings.main1_action2_left()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired and "WEAK" or "NORMAL", 1)
			particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			FacePartsClass.setEmotion("NONE", "CLOSED", "OPENED", 20, true)
			General.setAnimations("PLAY", "left_meow")
			ActionWheelClass.ActionCount = 20
		end
	end, function()
		General.setAnimations("STOP", "left_meow")
	end, false)
end

function pings.main1_action2_right()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			MeowClass.playMeow(General.isTired and "WEAK" or "NORMAL", 1)
			particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			FacePartsClass.setEmotion("CLOSED", "NONE", "OPENED", 20, true)
			General.setAnimations("PLAY", "right_meow")
			ActionWheelClass.ActionCount = 20
		end
	end, function()
		General.setAnimations("STOP", "right_meow")
	end, false)
end

function pings.main1_action3()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			if General.isTired then
				MeowClass.playMeow("WEAK", 1)
				FacePartsClass.setEmotion("TIRED", "TIRED", "OPENED", 20, true)
			else
				MeowClass.playMeow("NORMAL", 1)
				FacePartsClass.setEmotion("SHINE", "SHINE", "OPENED", 20, true)
			end
			ActionWheelClass.ActionCount = 20
		end
	end, nil, false)
end

function pings.main1_action4()
	runAction(function()
		if not GoatHornClass.Horn then
			local playerPos = player:getPos()
			particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
			if General.isTired then
				MeowClass.playMeow("WEAK", 1)
				FacePartsClass.setEmotion("TIRED", "TIRED", "OPENED", 20, true)
			else
				MeowClass.playMeow("NORMAL", 1)
				FacePartsClass.setEmotion("UNEQUAL", "UNEQUAL", "OPENED", 20, true)
			end
			ActionWheelClass.ActionCount = 20
		end
	end, nil, false)
end

function pings.main1_action5_left()
	runAction(function()
		MeowClass.playMeow("HURT", 1)
		if General.isTired then
			FacePartsClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 20, true)
		else
			FacePartsClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
		end
		SweatCount = 20
		ActionWheelClass.ActionCount = 20
	end, function()
		SweatCount = 0
	end, false)
end

function pings.main1_action5_right()
	runAction(function()
		MeowClass.playMeow("HURT", 1)
		if General.isTired then
			FacePartsClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 20, true)
		else
			FacePartsClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
		end
		FacePartsClass.setComplexion("PALE", 20, true)
		SweatCount = 20
		ActionWheelClass.ActionCount = 20
	end, function()
		SweatCount = 0
	end, false)
end

function pings.main1_action6_left()
	runAction(function()
		local playerPos = player:getPos()
		for _ = 1, math.min(avatar:getMaxParticles(), 8) do
			particles:addParticle("minecraft:angry_villager", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
		end
		MeowClass.playMeow("HISS", 0.5)
		if General.isTired then
			FacePartsClass.setEmotion("INTIMIDATE_TIRED", "INTIMIDATE_TIRED", "CLOSED", 40, true)
		else
			FacePartsClass.setEmotion("INTIMIDATE", "INTIMIDATE", "CLOSED", 40, true)
		end
		General.setAnimations("PLAY", "intimidate")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "intimidate")
	end, false)
end

function pings.main1_action6_right()
	runAction(function()
		local playerPos = player:getPos()
		for _ = 1, math.min(avatar:getMaxParticles(), 16) do
			particles:addParticle("minecraft:angry_villager", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
		end
		MeowClass.playMeow("HISS", 1)
		if General.isTired then
			FacePartsClass.setEmotion("INTIMIDATE_TIRED", "INTIMIDATE_TIRED", "TOOTH", 40, true)
		else
			FacePartsClass.setEmotion("INTIMIDATE", "INTIMIDATE", "TOOTH", 40, true)
		end
		General.setAnimations("PLAY", "intimidate")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "intimidate")
	end, false)
end

function pings.main1_action7_left()
	runAction(function()
		MeowClass.playMeow("HURT", 0.5)
		if General.isTired then
			FacePartsClass.setEmotion("DEPRESSED_TIRED", "DEPRESSED_TIRED", "CLOSED", 40, true)
		else
			FacePartsClass.setEmotion("DEPRESSED", "DEPRESSED", "CLOSED", 40, true)
		end
		General.setAnimations("PLAY", "depressed")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "depressed")
	end, false)
end

function pings.main1_action7_right()
	runAction(function()
		MeowClass.playMeow("HURT", 0.5)
		if General.isTired then
			FacePartsClass.setEmotion("DEPRESSED_TIRED", "DEPRESSED_TIRED", "CLOSED", 40, true)
		else
			FacePartsClass.setEmotion("DEPRESSED", "DEPRESSED", "CLOSED", 40, true)
		end
		FacePartsClass.setComplexion("PALE", 40, true)
		General.setAnimations("PLAY", "depressed")
		ActionWheelClass.ActionCount = 40
	end, function()
		General.setAnimations("STOP", "depressed")
	end, false)
end

function pings.main2_action1()
	runAction(function()
		if player:getPose() == "STANDING" then
			General.setAnimations("PLAY", "pat_head")
			models.models.player_hands.Avatar.Head.PlayerHand1:setVisible(true)
			sounds:playSound("entity.item.pickup", player:getPos(), 1, 0.5)
			HeadPatAnimationCount = 0
			ActionWheelClass.ActionCount = 145
		end
	end, function()
		General.setAnimations("STOP", "pat_head")
		models.models.player_hands.Avatar.Head.PlayerHand1:setVisible(false)
		HeadPatAnimationCount = -1
	end)
end

function pings.main2_action2()
	runAction(function()
		if player:getPose() == "STANDING" then
			General.setAnimations("PLAY", "pat_tail")
			models.models.player_hands.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2:setVisible(true)
			sounds:playSound("entity.item.pickup", player:getPos(), 1, 0.5)
			TailPatAnimationCount = 0
			ActionWheelClass.ActionCount = 80
		end
	end, function()
		General.setAnimations("STOP", "pat_tail")
		General.setAnimations("STOP", "intimidate")
		models.models.player_hands.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2:setVisible(false)
		TailPatAnimationCount = -1
	end)
end

function pings.main2_action3_toggle()
	runAction(function()
		if SitDownClass.canSitDown() then
			BellSoundClass.playBellSound()
			SitDownClass.sitDown()
		end
	end, nil, not WardenClass.WardenNearby)
end

function pings.main2_action3_untoggle()
	BellSoundClass.playBellSound()
	SitDownClass.standUp()
end

function pings.main2_action4()
	runAction(function()
		ActionWheelClass.bodyShake()
	end, function()
		General.setAnimations("STOP", "shake")
		ShakeSplashCount = 0
	end, false)
end

function pings.main2_action5_toggle()
	SummerFeatureClass.setSummerFeature(true)
end

function pings.main2_action5_untoggle()
	SummerFeatureClass.setSummerFeature(false)
end

function pings.config_action1(catType)
	TailAndEarsClass.setCatType(catType)
	ActionWheelClass.CurrentCatType = catType
	if host:isHost() then
		setCatTypeActionTitle()
	end
end

function pings.config_action2(volume)
	BellSoundClass.BellVolume = volume
	ActionWheelClass.CurrentBellVolume = volume
	if host:isHost() then
		setBellVolumeTitle()
	end
end

function pings.config_action3_toggle()
	MeowClass.MeowSound = true
end

function pings.config_action3_untoggle()
	MeowClass.MeowSound = false
end

function pings.config_action4_toggle()
	General.setAnimations("PLAY", "wave_tail")
end

function pings.config_action4_untoggle()
	General.setAnimations("STOP", "wave_tail")
end

function pings.config_action5_toggle()
	ArmorClass.HideArmor = true
end

function pings.config_action5_untoggle()
	ArmorClass.HideArmor = false
end

function pings.config_action6_toggle()
	WetClass.AutoShake = true
end

function pings.config_action6_untoggle()
	WetClass.AutoShake = false
end

function pings.config_action7_toggle()
	AFKClass.AFKAction = true
end

function pings.config_action7_untoggle()
	AFKClass.AFKAction = false
end

events.TICK:register(function()
	if WardenClass.WardenNearby or ActionWheelClass.ActionCount > 0 then
		for i = 1, 7 do
			setActionEnabled(1, i, false)
		end
		for i = 1, 4 do
			setActionEnabled(2, i, false)
		end
	else
		for i = 1, 7 do
			setActionEnabled(1, i, true)
		end
		for i = 1, 2 do
			setActionEnabled(2, i, player:getPose() == "STANDING")
		end
		setActionEnabled(2, 4, true)
	end
	setActionEnabled(2, 3, not WardenClass.WardenNearby and SitDownClass.canSitDown())
	if (WardenClass.WardenNearby or HurtClass.Damaged ~= "NONE") and ActionWheelClass.ActionCount > 0 and ActionCancelFunction ~= nil then
		ActionCancelFunction()
		ActionWheelClass.ActionCount = 0
	end
	if animations["models.main"]["sit_down"]:getPlayState() == "PLAYING" and not SitDownClass.canSitDown() then
		SitDownClass.standUp()
		animations["models.main"]["sit_down_first_person_fix"]:stop()
	end
	if ShakeSplashCount > 0 then
		if ShakeSplashCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(avatar:getMaxParticles() / 4, 4) do
				particles:addParticle("minecraft:splash", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
			end
		end
		ShakeSplashCount = ShakeSplashCount - 1
	end
	ActionWheelClass.ActionCount = ActionWheelClass.ActionCount > 0 and not client:isPaused() and ActionWheelClass.ActionCount - 1 or ActionWheelClass.ActionCount
	if SweatCount > 0 then
		if SweatCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(avatar:getMaxParticles() / 4, 4) do
				particles:addParticle("minecraft:splash", playerPos.x, playerPos.y + 2, playerPos.z)
			end
		end
		SweatCount = SweatCount - 1
	end
	local isOpenActionWheel = action_wheel:isEnabled()
	if not isOpenActionWheel and IsOpenActionWheelPrev then
		if CatType ~= ActionWheelClass.CurrentCatType then
			pings.config_action1(CatType)
			print(LanguageClass.getTranslate("action_wheel__config__action_1__done_first")..LanguageClass.getTranslate("cat_type__"..TailAndEarsClass.CatTypeID[CatType])..LanguageClass.getTranslate("action_wheel__config__action_1__done_last"))
		end
		if BellVolume ~= ActionWheelClass.CurrentBellVolume then
			pings.config_action2(BellVolume)
			print(LanguageClass.getTranslate("action_wheel__config__action_2__done_first")..math.round(BellVolume * 100)..LanguageClass.getTranslate("unit__percent")..LanguageClass.getTranslate("action_wheel__config__action_2__done_last"))
		end
		action_wheel:setPage(MainPages[CurrentMainPage])
	end
	if not client:isPaused() then
		if HeadPatAnimationCount >= 0 then
			if HeadPatAnimationCount == 145 then
				models.models.player_hands.Avatar.Head.PlayerHand1:setVisible(false)
				sounds:playSound("entity.item.pickup", player:getPos(), 1, 0.5)
				HeadPatAnimationCount = -1
			else
				if HeadPatAnimationCount == 55 then
					FacePartsClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 40, true)
				elseif HeadPatAnimationCount == 95 then
					local playerPos = player:getPos()
					MeowClass.playMeow(General.isTired and "WEAK" or "NORMAL", 1)
					particles:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
					FacePartsClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
				elseif HeadPatAnimationCount == 115 then
					FacePartsClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 22, true)
				end
				HeadPatAnimationCount = HeadPatAnimationCount + 1
			end
		elseif TailPatAnimationCount >= 0 then
			if TailPatAnimationCount == 80 then
				models.models.player_hands.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2:setVisible(false)
				sounds:playSound("entity.item.pickup", player:getPos(), 1, 0.5)
				TailPatAnimationCount = -1
			else
				if TailPatAnimationCount == 19 then
					MeowClass.playMeow("HURT", 1)
					if General.isTired then
						FacePartsClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 21, true)
					else
						FacePartsClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 21, true)
					end
					FacePartsClass.setComplexion("ASHAMED", 20, true)
				elseif TailPatAnimationCount == 40 then
					local playerPos = player:getPos()
					MeowClass.playMeow("HISS", 1)
					for _ = 1, math.min(avatar:getMaxParticles(), 8) do
						particles:addParticle("minecraft:angry_villager", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
					end
					if General.isTired then
						FacePartsClass.setEmotion("INTIMIDATE_TIRED", "INTIMIDATE_TIRED", "TOOTH", 40, true)
					else
						FacePartsClass.setEmotion("INTIMIDATE", "INTIMIDATE", "TOOTH", 40, true)
					end
					General.setAnimations("PLAY", "intimidate")
				end
				TailPatAnimationCount = TailPatAnimationCount + 1
			end
		end
	end
	MainPages[2]:getAction(5):title(LanguageClass.getTranslate("action_wheel__main_2__action_5__title")..LanguageClass.getTranslate("action_wheel__toggle_off")):toggleTitle(LanguageClass.getTranslate("action_wheel__main_2__action_5__title")..LanguageClass.getTranslate("action_wheel__toggle_on"))
	MainPages[2]:getAction(7):title(LanguageClass.getTranslate("action_wheel__main_2__action_7__title"))
	for index, mainPage in ipairs(MainPages) do
		mainPage:getAction(8):title(LanguageClass.getTranslate("action_wheel__main__page_switch__title")..index.."/"..#MainPages)
	end
	IsOpenActionWheelPrev = isOpenActionWheel
end)

events.WORLD_RENDER:register(function()
	MainPages[2]:getAction(3):toggled(SitDownClass.canSitDown() and MainPages[2]:getAction(3):isToggled())
	if animations["models.main"]["sit_down"]:getPlayState() == "PLAYING" and renderer:isFirstPerson() then
		animations["models.main"]["sit_down_first_person_fix"]:play()
	else
		animations["models.main"]["sit_down_first_person_fix"]:stop()
	end
end)

--メインページのアクションの設定
--アクション1-1. 「ニャー」と鳴く（スマイル）
MainPages[1]:newAction(1):item("cod"):onLeftClick(function()
	pings.main1_action1_left()
end):onRightClick(function()
	pings.main1_action1_right()
end)

--アクション1-2. 「ニャー」と鳴く（ウィンク）
MainPages[1]:newAction(2):item("cod"):onLeftClick(function()
	pings.main1_action2_left()
end):onRightClick(function()
	pings.main1_action2_right()
end)

--アクション1-3. 「ニャー」と鳴く（キラキラ）
MainPages[1]:newAction(3):item("cod"):onLeftClick(function()
	pings.main1_action3()
end)

--アクション1-4. 「ニャー」と鳴く（> <）
MainPages[1]:newAction(4):item("cod"):onLeftClick(function()
	pings.main1_action4()
end)

--アクション1-5. 驚く
MainPages[1]:newAction(5):item("cod"):onLeftClick(function()
	pings.main1_action5_left()
end):onRightClick(function()
	pings.main1_action5_right()
end)

--アクション1-6. 威嚇
MainPages[1]:newAction(6):item("cod"):onLeftClick(function()
	pings.main1_action6_left()
end):onRightClick(function()
	pings.main1_action6_right()
end)

--アクション1-7. しょんぼり
MainPages[1]:newAction(7):item("cod"):onLeftClick(function()
	pings.main1_action7_left()
end):onRightClick(function()
	pings.main1_action7_right()
end)

--アクション2-1. ナデナデ（頭）
MainPages[2]:newAction(1):item("feather"):onLeftClick(function()
	pings.main2_action1()
end)

--アクション2-2. ナデナデ（尻尾）
MainPages[2]:newAction(2):item("feather"):onLeftClick(function()
	pings.main2_action2()
end)

--アクション2-3. おすわり
MainPages[2]:newAction(3):toggleColor(1, 85 / 255, 1):item("oak_stairs"):onToggle(function()
	pings.main2_action3_toggle()
end):onUntoggle(function()
	pings.main2_action3_untoggle()
end)

--アクション2-4. ブルブル
MainPages[2]:newAction(4):item("water_bucket"):onLeftClick(function()
	pings.main2_action4()
end)

--アクション2-5. 夏機能
MainPages[2]:newAction(5):item("bucket"):toggleItem("tropical_fish_bucket"):color(170 / 255, 0, 0):toggleColor(0, 170 / 255, 0):hoverColor(1, 1, 1):onToggle(function()
	pings.main2_action5_toggle()
end):onUntoggle(function()
	pings.main2_action5_untoggle()
end)

--アクション2-7. 設定を開く
MainPages[2]:newAction(7):color(200 / 255, 200 / 255, 200 / 255):hoverColor(1, 1, 1):item("comparator"):onLeftClick(function()
	action_wheel:setPage(ConfigPage)
end)

--アクション8（共通）. ページ切り替え
for _, mainPage in ipairs(MainPages) do
	mainPage:newAction(8):color(200 / 255, 200 / 255, 200 / 255):hoverColor(1, 1, 1):item("arrow"):onScroll(function(direction)
		CurrentMainPage = CurrentMainPage - direction
		CurrentMainPage = CurrentMainPage < 1 and CurrentMainPage + #MainPages or (CurrentMainPage > #MainPages and CurrentMainPage - #MainPages or CurrentMainPage)
		action_wheel:setPage(MainPages[CurrentMainPage])
	end)
end

--アバターの設定のアクション設定
--アクション1. ネコの種類の設定
ConfigPage:newAction(1):color(200 / 255, 200 / 255, 200 / 255):hoverColor(1, 1, 1):item("ocelot_spawn_egg"):onScroll(function(direction)
	if direction == -1 then
		CatType = CatType == #TailAndEarsClass.CatTypeID and 1 or CatType + 1
	else
		CatType = CatType == 1 and #TailAndEarsClass.CatTypeID or CatType - 1
	end
	setCatTypeActionTitle()
end)

--アクション2. 鈴の音量
ConfigPage:newAction(2):color(200 / 255, 200 / 255, 200 / 255):hoverColor(1, 1, 1):item("bell"):onScroll(function(direction)
	if direction == -1 then
		BellVolume = BellVolume > 0.95 and 1 or BellVolume + 0.05
	else
		BellVolume = BellVolume < 0.05 and 0 or BellVolume - 0.05
	end
	setBellVolumeTitle()
end)

--アクション3. 猫の鳴き声
ConfigPage:newAction(3):title(LanguageClass.getTranslate("action_wheel__config__action_3__title")..LanguageClass.getTranslate("action_wheel__toggle_off")):toggleTitle(LanguageClass.getTranslate("action_wheel__config__action_3__title")..LanguageClass.getTranslate("action_wheel__toggle_on")):item("note_block"):color(170 / 255, 0, 0):hoverColor(1, 85 / 255, 85 / 255):toggleColor(0, 170 / 255, 0):onToggle(function ()
	pings.config_action3_toggle()
	ConfigPage:getAction(3):hoverColor(85 / 255, 1, 85 / 255)
end):onUntoggle(function ()
	pings.config_action3_untoggle()
	ConfigPage:getAction(3):hoverColor(1, 85 / 255, 85 / 255)
end)
if ConfigClass.MeowSound then
	local action = ConfigPage:getAction(3)
	action:toggled(true)
	action:hoverColor(85 / 255, 1, 85 / 255)
end

--アクション4. 尻尾を振る
ConfigPage:newAction(4):title(LanguageClass.getTranslate("action_wheel__config__action_4__title")..LanguageClass.getTranslate("action_wheel__toggle_off")):toggleTitle(LanguageClass.getTranslate("action_wheel__config__action_4__title")..LanguageClass.getTranslate("action_wheel__toggle_on")):item("feather"):color(170 / 255, 0, 0):hoverColor(1, 85 / 255, 85 / 255):toggleColor(0, 170 / 255, 0):onToggle(function ()
	pings.config_action4_toggle()
	ConfigPage:getAction(4):hoverColor(85 / 255, 1, 85 / 255)
end):onUntoggle(function ()
	pings.config_action4_untoggle()
	ConfigPage:getAction(4):hoverColor(1, 85 / 255, 85 / 255)
end)
if ConfigClass.WaveTail then
	local action = ConfigPage:getAction(4)
	action:toggled(true)
	action:hoverColor(85 / 255, 1, 85 / 255)
end

--アクション5. 防具を隠す
ConfigPage:newAction(5):title(LanguageClass.getTranslate("action_wheel__config__action_5__title")..LanguageClass.getTranslate("action_wheel__toggle_off")):toggleTitle(LanguageClass.getTranslate("action_wheel__config__action_5__title")..LanguageClass.getTranslate("action_wheel__toggle_on")):item("iron_chestplate"):color(170 / 255, 0, 0):hoverColor(1, 85 / 255, 85 / 255):toggleColor(0, 170 / 255, 0):onToggle(function ()
	pings.config_action5_toggle()
	ConfigPage:getAction(5):hoverColor(85 / 255, 1, 85 / 255)
end):onUntoggle(function ()
	pings.config_action5_untoggle()
	ConfigPage:getAction(5):hoverColor(1, 85 / 255, 85 / 255)
end)
if ConfigClass.HideArmor then
	local action = ConfigPage:getAction(5)
	action:toggled(true)
	action:hoverColor(85 / 255, 1, 85 / 255)
end

--アクション6. 自動ブルブル
ConfigPage:newAction(6):title(LanguageClass.getTranslate("action_wheel__config__action_6__title")..LanguageClass.getTranslate("action_wheel__toggle_off")):toggleTitle(LanguageClass.getTranslate("action_wheel__config__action_6__title")..LanguageClass.getTranslate("action_wheel__toggle_on")):item("water_bucket"):color(170 / 255, 0, 0):hoverColor(1, 85 / 255, 85 / 255):toggleColor(0, 170 / 255, 0):onToggle(function ()
	pings.config_action6_toggle()
	ConfigPage:getAction(6):hoverColor(85 / 255, 1, 85 / 255)
end):onUntoggle(function ()
	pings.config_action6_untoggle()
	ConfigPage:getAction(6):hoverColor(1, 85 / 255, 85 / 255)
end)
if ConfigClass.AutoShake then
	local action = ConfigPage:getAction(6)
	action:toggled(true)
	action:hoverColor(85 / 255, 1, 85 / 255)
end

--アクション7. AFKアクション
ConfigPage:newAction(7):title(LanguageClass.getTranslate("action_wheel__config__action_7__title")..LanguageClass.getTranslate("action_wheel__toggle_off")):toggleTitle(LanguageClass.getTranslate("action_wheel__config__action_7__title")..LanguageClass.getTranslate("action_wheel__toggle_on")):item("red_bed"):color(170 / 255, 0, 0):hoverColor(1, 85 / 255, 85 / 255):toggleColor(0, 170 / 255, 0):onToggle(function ()
	pings.config_action7_toggle()
	ConfigPage:getAction(7):hoverColor(85 / 255, 1, 85 / 255)
end):onUntoggle(function ()
	pings.config_action7_untoggle()
	ConfigPage:getAction(7):hoverColor(1, 85 / 255, 85 / 255)
end)
if ConfigClass.AFKAction then
	local action = ConfigPage:getAction(7)
	action:toggled(true)
	action:hoverColor(85 / 255, 1, 85 / 255)
end

setCatTypeActionTitle()
setBellVolumeTitle()
action_wheel:setPage(MainPages[1])

return ActionWheelClass