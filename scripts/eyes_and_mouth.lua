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
---| "TIRED"
---| "SLEEPY"
---| "CLOSED"
---| "UNEQUAL"

---@alias MouthType
---| "NONE"
---| "CLOSED"
---| "OPENED"

EyesAndMouthClass = {}

RightEyeLight = models.models.main.Avatar.Head.FaceParts.RightEye.RightEyeLight
LeftEyeLight = models.models.main.Avatar.Head.FaceParts.LeftEye.LeftEyeLight
EyeTypeID = {NONE = -1, NORMAL = 0, SHINE = 1, SURPLISED = 2, TIRED = 3, SLEEPY = 4, CLOSED = 5, UNEQUAL = 6}
MouthTypeID = {NONE = -1, CLOSED = 0, OPENED = 1}
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
	end
	EyesAndMouthClass.EmotionCount = duration
end

events.TICK:register(function()
	local damaged = Utils.getDamaged()
	if damaged == "DAMAGED" then
		EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "NONE", 8, true)
	elseif damaged == "DIED" then
		EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "NONE", 20, true)
	end
	if EyesAndMouthClass.EmotionCount == 0 then
		if Utils.isTired() then
			EyesAndMouthClass.setEmotion("TIRED", "TIRED", "CLOSED", 0, false)
		else
			EyesAndMouthClass.setEmotion("NORMAL", "NORMAL", "CLOSED", 0, false)
		end
	end
	if BlinkCount == 200 then
		EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "NONE", 2, false)
		BlinkCount = 0
	else
		BlinkCount = BlinkCount + 1
	end
	EyesAndMouthClass.EmotionCount = EyesAndMouthClass.EmotionCount > 0 and EyesAndMouthClass.EmotionCount - 1 or EyesAndMouthClass.EmotionCount

	--目を光らせる
	--[[
	--NOTE: CustomModelPart:setLight()がリセットできないので、リセットできるようになるまで、コメントアウトしておく。
	--TODO: リセットできるようになったら、下のFIXMEを修正してコメントアウトを外す。
	local nightVision = Utils.getStatusEffect("night_vision")
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
		RightEyeLight:setLight() --FIXME: リセット処理を書く。
		LeftEyeLight:setLight() --FIXME: リセット処理を書く。
	end
	]]
end)

return EyesAndMouthClass