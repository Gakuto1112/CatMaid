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
	local leftHanded = player:isLeftHanded()
	local rightHandItemType = General.hasItem(player:getHeldItem(not leftHanded))
	local leftHandItemType = General.hasItem(player:getHeldItem(leftHanded))
	local isSleeping = player:getPose() == "SLEEPING"
	if isSleeping then
		if not SleepClass.SleepData[1] then
			General.setAnimations("PLAY", "sleep")
			if not WardenClass.WardenNearby then
				FacePartsClass.setEmotion("SLEEPY", "SLEEPY", "CLOSED", 40, true)
			end
		end
		head:setParentType("None")
		if renderer:isFirstPerson() then
			head:setVisible(false)
		else
			local sleepBlock = world.getBlockState(player:getPos())
			if string.find(sleepBlock.id, "^minecraft:.+bed$") then
				local facingValue = {north = 180, east = -90, south = 0, west = 90}
				if renderer:isCameraBackwards() then
					renderer:setCameraRot(30, -80 + facingValue[sleepBlock.properties["facing"]], 0)
				else
					renderer:setCameraRot(30, 100 + facingValue[sleepBlock.properties["facing"]], 0)
				end
			end
		end
		if rightHandItemType ~= "none" then
			rightArm:setRot(-15, 0, 0)
		else
			rightArm:setRot(0, 0, 0)
		end
		if leftHandItemType ~= "none" then
			leftArm:setRot(-15, 0, 0)
		else
			leftArm:setRot(0, 0, 0)
		end
		if not WardenClass.WardenNearby then
			FacePartsClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 1, false)
		end
		if SleepCount >= 40 and not WardenClass.WardenNearby then
			if (SleepCount - 40) % 65 == 0 then
				MeowClass.playMeow("PURR", 1)
			end
		end
		General.setAnimations("STOP", "wave_tail")
		SleepCount = SleepCount + 1
	else
		if SleepClass.SleepData[1] and ConfigClass.WaveTail then
			General.setAnimations("PLAY", "wave_tail")
		end
		head:setVisible(true)
		head:setParentType("Head")
		renderer:setCameraRot()
		if not WardenClass.WardenNearby then
			if rightHandItemType ~= "minecraft:cake" and animations["models.main"]["sit_down"]:getPlayState() ~= "PLAYING" then
				if not ArmsClass.isSneaking then
					rightArm:setRot(0, 0, 0)
				end
			end
			if leftHandItemType ~= "minecraft:cake" and animations["models.main"]["sit_down"]:getPlayState() ~= "PLAYING" then
				if not ArmsClass.isSneaking then
					leftArm:setRot(0, 0, 0)
				end
			end
		end
		General.setAnimations("STOP", "sleep")
		SleepCount = 0
	end
	table.insert(SleepClass.SleepData, isSleeping)
	if #SleepClass.SleepData == 3 then
		table.remove(SleepClass.SleepData, 1)
	end
end)

return SleepClass