---@class SleepClass ベッドで寝る時の挙動を制御するクラス
---@field SleepClass.SleepData table 寝た瞬間を検出する為にポーズデータを格納するテーブル
---@field SleepCount integer 寝ている間はインクリメントされ続けるカウンター

SleepClass = {}

SleepClass.SleepData = {}
SleepCount = 0

events.TICK:register(function()
	local head = models.models.main.Avatar.Head
	local rightArm = models.models.main.Avatar.Body.Arms.RightArm
	local leftArm = models.models.main.Avatar.Body.Arms.LeftArm
	local rightItem = vanilla_model.RIGHT_ITEM
	local leftItem = vanilla_model.LEFT_ITEM
	local rightHandItemType = General.hasItem(player:getHeldItem(not leftHanded))
	local leftHandItemType = General.hasItem(player:getHeldItem(leftHanded))
	local isSleeping = player:getPose() == "SLEEPING"
	if isSleeping then
		if not SleepClass.SleepData[1] then
			General.playAnimationWithArmor("sleep")
			if not WardenClass.WardenNearby then
				EyesAndMouthClass.setEmotion("SLEEPY", "SLEEPY", "CLOSED", 40, true)
			end
		end
		if renderer:isFirstPerson() then
			head:setVisible(false)
		end
		if rightHandItemType ~= "none" then
			rightArm:setRot(-15, 0, 0)
			rightItem:setVisible(false)
		else
			rightArm:setRot(0, 0, 0)
			rightItem:setVisible(true)
		end
		if leftHandItemType ~= "none" then
			leftArm:setRot(-15, 0, 0)
			leftItem:setVisible(false)
		else
			leftArm:setRot(0, 0, 0)
			leftItem:setVisible(true)
		end
		EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 1, false)
		if SleepCount >= 40 and not WardenClass.WardenNearby then
			if (SleepCount - 40) % 65 == 0 then
				MeowClass.playMeow("PURR", 1)
			end
		end
		animation["main"]["wave_tail"]:stop()
		SleepCount = SleepCount + 1
	else
		if SleepClass.SleepData[1] and ConfigClass.WaveTail then
			animation["main"]["wave_tail"]:play()
		end
		head:setVisible(true)
		if not WardenClass.WardenNearby then
			if rightHandItemType ~= "minecraft:cake" and animation["main"]["sit_down"]:getPlayState() ~= "PLAYING" then
				if not ArmsClass.isSneaking then
					rightArm:setRot(0, 0, 0)
				end
				rightItem:setVisible(true)
			end
			if leftHandItemType ~= "minecraft:cake" and animation["main"]["sit_down"]:getPlayState() ~= "PLAYING" then
				if not ArmsClass.isSneaking then
					leftArm:setRot(0, 0, 0)
				end
				leftItem:setVisible(true)
			end
		end
		General.stopAnimationWithArmor("sleep")
		SleepCount = 0
	end
	table.insert(SleepClass.SleepData, isSleeping)
	if #SleepClass.SleepData == 3 then
		table.remove(SleepClass.SleepData, 1)
	end
end)

return SleepClass