---@class AFKClass 放置時の挙動を制御するクラス
---@field keyList table AFK復帰判定の為に使用するキーを格納するテーブル
---@field LookRotPrevRender number 前チックのlookRot
---@field RightItemTypePrevTick string 前チックの右手のアイテムの種類
---@field LeftItemTypePrevTick string 前チックの左手のアイテムの種類
---@field SitDownWhenSleepy boolean 眠くなり始めた時に座っていたかどうか
---@field AFKClass.AFKCount integer 放置するとインクリメントされるカウンター
---@field AFKClass.TouchBellCount integer 鈴を弄っている時間を計るカウンター

AFKClass = {}

keyList = {}
LookRotPrevTick = 0
RightItemTypePrevTick = "none"
LeftItemTypePrevTick = "none"
SitDownWhenSleepy = false
AFKClass.AFKCount = 0
AFKClass.TouchBellCount = 0

events.TICK:register(function()
	local keyPressed = false
	for _, key in ipairs(keyList) do
		if key:isPressed() then
			keyPressed = true
			break
		end
	end
	local lookDir = player:getLookDir()
	local lookRot = math.deg(math.atan2(lookDir.z, lookDir.x))
	local lookRotDelta = lookRot - LookRotPrevTick
	local leftHanded = player:isLeftHanded()
	local rightHandItemType = General.hasItem(player:getHeldItem(leftHanded))
	local leftHandItemType = General.hasItem(player:getHeldItem(not leftHanded))
	if not keyPressed and lookRotDelta == 0 and player:getPose() == "STANDING" and not WardenClass.WardenNearby and HurtClass.Damaged == "NONE" and rightHandItemType == RightItemTypePrevTick and leftHandItemType == LeftItemTypePrevTick and ConfigClass.AFKAction then
		if not client.isPaused() then
			if AFKClass.AFKCount >= 6000 then
				if AFKClass.AFKCount == 6000 then
					General.playAnimationWithArmor("afk_sleep")
				end
				EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 1, false)
				if (AFKClass.AFKCount - 6000) % 65 == 0 then
					sound:playSound("minecraft:entity.cat.purr", player:getPos(), 1, 1)
				end
			elseif AFKClass.AFKCount >= 5400 then
				if AFKClass.AFKCount == 5400 then
					General.playAnimationWithArmor("afk_sleepy")
					if player:isOnGround() then
						if animation["main"]["sit_down"]:getPlayState() == "PLAYING" then
							SitDownWhenSleepy = true
						else
							ActionWheelClass.sitDown()
							SitDownWhenSleepy = false
						end
					end
				end
				EyesAndMouthClass.setEmotion("SLEEPY", "SLEEPY", "CLOSED", 1, false)
			elseif AFKClass.AFKCount % 300 == 0 and AFKClass.AFKCount > 0 then
				if (rightHandItemType == "none") ~= (leftHandItemType == "none") then
					General.playAnimationWithArmor("afk_touch_bell")
					if rightHandItemType == "none" then
						animation["alternative_arms"]["afk_right_bell"]:play()
						AFKClass.TouchBellCount = 67
					else
						animation["alternative_arms"]["afk_left_bell"]:play()
						AFKClass.TouchBellCount = -67
					end
				else
					if leftHanded then
						if leftHandItemType ~= "minecraft:cake" then
							General.playAnimationWithArmor("afk_touch_bell")
							animation["alternative_arms"]["afk_left_bell"]:play()
							AFKClass.TouchBellCount = -67
						elseif rightHandItemType ~= "minecraft:cake" then
							General.playAnimationWithArmor("afk_touch_bell")
							animation["alternative_arms"]["afk_right_bell"]:play()
							AFKClass.TouchBellCount = 67
						end
					else
						if rightHandItemType ~= "minecraft:cake" then
							General.playAnimationWithArmor("afk_touch_bell")
							animation["alternative_arms"]["afk_right_bell"]:play()
							AFKClass.TouchBellCount = 67
						else
							General.playAnimationWithArmor("afk_touch_bell")
							animation["alternative_arms"]["afk_left_bell"]:play()
							AFKClass.TouchBellCount = -67
						end
					end
				end
			end
			AFKClass.AFKCount = AFKClass.AFKCount >= 0 and AFKClass.AFKCount + 1 or AFKClass.AFKCount
		end
	elseif AFKClass.AFKCount >= 5400 then
		General.stopAnimationWithArmor("afk_sleepy")
		General.stopAnimationWithArmor("afk_sleep")
		if not SitDownWhenSleepy then
			ActionWheelClass.standUp()
		end
		EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 10, true)
		MeowClass.playMeow("HURT", 1)
		AFKClass.AFKCount = -30
	else
		General.stopAnimationWithArmor("afk_touch_bell")
		animation["alternative_arms"]["afk_right_bell"]:stop()
		animation["alternative_arms"]["afk_left_bell"]:stop()
		if AFKClass.AFKCount > 0 then
			AFKClass.AFKCount = 0
		end
		AFKClass.TouchBellCount = 0
	end
	AFKClass.AFKCount = AFKClass.AFKCount < 0 and AFKClass.AFKCount + 1 or AFKClass.AFKCount
	local firstPerson = renderer:isFirstPerson()
	if AFKClass.TouchBellCount > 0 then
		if not firstPerson or leftHanded then
			models.models.main.Avatar.Body.Arms.RightArm:setVisible(false)
		end
		models.models.alternative_arms.Body.Arms.RightArm:setVisible(true)
	elseif AFKClass.TouchBellCount < 0 then
		if not firstPerson or not leftHanded then
			models.models.main.Avatar.Body.Arms.LeftArm:setVisible(false)
		end
		models.models.alternative_arms.Body.Arms.LeftArm:setVisible(true)
	end
	local touchBellCountAbs = math.abs(AFKClass.TouchBellCount)
	if touchBellCountAbs == 23 or touchBellCountAbs == 39 then
		BellSoundClass.playBellSound()
	end
	if AFKClass.AFKCount >= -20 and AFKClass.AFKCount < 0 then
		if AFKClass.AFKCount == -20 then
			ActionWheelClass.bodyShake()
		end
		if AFKClass.AFKCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(meta:getMaxParticles() / 4, 4) do
				particle:addParticle("minecraft:splash", playerPos.x, playerPos.y + 2, playerPos.z)
			end
		end
	end
	LookRotPrevTick = lookRot
	RightItemTypePrevTick = rightHandItemType
	LeftItemTypePrevTick = leftHandItemType
	AFKClass.TouchBellCount = AFKClass.TouchBellCount ~= 0 and (AFKClass.TouchBellCount > 0 and AFKClass.TouchBellCount - 1 or AFKClass.TouchBellCount + 1) or 0
end)

if ConfigClass.AFKAction then
	for index, keyName in ipairs({"key.playerlist", "figura.config.action_wheel_button", "key.sneak", "key.hotbar.1", "key.hotbar.2", "key.hotbar.3", "key.hotbar.4", "key.hotbar.5", "key.hotbar.6", "key.hotbar.7", "key.hotbar.8", "key.hotbar.9", "key.sprint", "key.togglePerspective", "key.spectatorOutlines", "key.left", "key.chat", "key.pickItem", "key.socialInteractions", "key.fullscreen", "key.attack", "key.smoothCamera", "key.advancements", "key.use", "key.loadToolbarActivator", "key.forward", "key.right", "key.screenshot", "key.back", "key.swapOffhand", "key.command", "key.saveToolbarActivator", "key.inventory", "key.jump", "key.drop"}) do
		table.insert(keyList, keybind:create(LanguageClass.getTranslate("key__afk_check").."_"..index, keybind:getVanillaKey(keyName)))
	end
end

return AFKClass