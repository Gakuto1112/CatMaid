---@class EyesAndMouthClass 目と口を制御するクラス
---@field RightEyeLight CustomModelPart 右目の光る部分
---@field LeftEyeLight CustomModelPart 左目の光る部分
---@field EyeTypeID table EyeTypeとIDを紐付けるテーブル
---@field MouthTypeID table MouthTypeとIDを紐付けるテーブル
---@field BlinkCount integer 瞬きのタイミングを計るカウンター
---@field EmotionCount integer エモーションの時間を計るカウンター

---@alias EyeType
---| "NONE"
---| "NORMAL"
---| "SHINE"
---| "SURPLISED"
---| "SURPLISED_TIRED"
---| "INTIMIDATE"
---| "INTIMIDATE_TIRED"
---| "DEPRESSED"
---| "DEPRESSED_TIRED"
---| "TIRED"
---| "SLEEPY"
---| "CLOSED"
---| "UNEQUAL"

---@alias MouthType
---| "NONE"
---| "CLOSED"
---| "OPENED"
---| "TOOTH"

EyesAndMouthClass = {}

RightEyeLight = models.models.main.Avatar.Head.FaceParts.RightEye.RightEyeLight
LeftEyeLight = models.models.main.Avatar.Head.FaceParts.LeftEye.LeftEyeLight
EyeTypeID = {NONE = -1, NORMAL = 0, SHINE = 1, SURPLISED = 2, SURPLISED_TIRED = 3, INTIMIDATE = 4, INTIMIDATE_TIRED = 5, DEPRESSED = 6, DEPRESSED_TIRED = 7, TIRED = 8, SLEEPY = 9, CLOSED = 10, UNEQUAL = 11}
MouthTypeID = {NONE = -1, CLOSED = 0, OPENED = 1, TOOTH = 2}
BlinkCount = 0
EyesAndMouthClass.EmotionCount = 0

---表情を設定する。
---@param rightEye EyeType 設定する右目の名前（"NONE"にすると変更されない）
---@param leftEye EyeType 設定する左目の名前（"NONE"にすると変更されない）
---@param mouth MouthType 設定する口の名前（"NONE"にすると変更されない）
---@param duration integer この表情を有効にする時間
---@param force boolean trueにすると以前のエモーションが再生中でも強制的に現在のエモーションを適用させる。
function EyesAndMouthClass.setEmotion(rightEye, leftEye, mouth, duration, force)
	if EyesAndMouthClass.EmotionCount == 0 or force then
		--右目
		if EyeTypeID[rightEye] >= 0 then
			models.models.main.Avatar.Head.FaceParts.RightEye.RightEyeBase:setUVPixels(EyeTypeID[rightEye] * 6, 0)
			RightEyeLight:setUVPixels(EyeTypeID[rightEye] * 6, 0)
		end
		--左目
		if EyeTypeID[leftEye] >= 0 then
			models.models.main.Avatar.Head.FaceParts.LeftEye.LeftEyeBase:setUVPixels(EyeTypeID[leftEye] * 6, 0)
			LeftEyeLight:setUVPixels(EyeTypeID[leftEye] * 6, 0)
		end
		--口
		if MouthTypeID[mouth] >= 0 then
			models.models.main.Avatar.Head.FaceParts.Mouth:setUVPixels(MouthTypeID[mouth] * 4, 0)
		end
		EyesAndMouthClass.EmotionCount = duration
	end
end

events.TICK:register(function()
	if EyesAndMouthClass.EmotionCount == 0 then
		if General.isTired() then
			EyesAndMouthClass.setEmotion("TIRED", "TIRED", "CLOSED", 0, false)
		else
			EyesAndMouthClass.setEmotion("NORMAL", "NORMAL", "CLOSED", 0, false)
		end
	end
	if BlinkCount == 200 then
		EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "NONE", 2, false)
		BlinkCount = 0
	elseif client.isPaused() then
		BlinkCount = BlinkCount + 1
	end
	EyesAndMouthClass.EmotionCount = EyesAndMouthClass.EmotionCount > 0 and EyesAndMouthClass.EmotionCount - 1 or EyesAndMouthClass.EmotionCount

	--目を光らせる
	local nightVision = General.getStatusEffect("night_vision")
	local playerPos = player:getPos()
	local lightLevel = world.getLightLevel(playerPos.x, playerPos.y + 1, playerPos.z)
	if nightVision then
		if nightVision.duration <= 200 then
			local eyeLight = math.max(math.abs(nightVision.duration % 10 - 4.5) * 2 + 6, lightLevel)
			RightEyeLight:setLight(eyeLight)
			LeftEyeLight:setLight(eyeLight)
		else
			RightEyeLight:setLight(15)
			LeftEyeLight:setLight(15)
		end
	else
		RightEyeLight:setLight()
		LeftEyeLight:setLight()
	end
end)

return EyesAndMouthClass