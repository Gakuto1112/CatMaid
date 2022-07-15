---@class EyesAndMouthClass 目と口を制御するクラス
---@field EyeTypeID table EyeTypeとIDを紐付けるテーブル
---@field MouthTypeID table MouthTypeとIDを紐付けるテーブル
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

EyeTypeID = {NONE = -1, NORMAL = 0, SHINE = 1, SURPLISED = 2, TIRED = 3, SLEEPY = 4, CLOSED = 5, UNEQUAL = 6}
MouthTypeID = {NONE = -1, CLOSED = 0, OPENED = 1}
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
			models.models.main.Avatar.Head.FaceParts.RightEye.RightEyeLight:setUVPixels(EyeTypeID[rightEye] * 6, 0)
		end
		--左目
		if EyeTypeID[leftEye] >= 0 then
			models.models.main.Avatar.Head.FaceParts.LeftEye.LeftEyeBase:setUVPixels(EyeTypeID[leftEye] * 6, 0)
			models.models.main.Avatar.Head.FaceParts.LeftEye.LeftEyeLight:setUVPixels(EyeTypeID[leftEye] * 6, 0)
		end
		--口
		if MouthTypeID[mouth] >= 0 then
			models.models.main.Avatar.Head.FaceParts.Mouth:setUVPixels(MouthTypeID[mouth] * 4, 0)
		end
	end
	EyesAndMouthClass.EmotionCount = duration
end

events.TICK:register(function()
	EyesAndMouthClass.EmotionCount = EyesAndMouthClass.EmotionCount > 0 and EyesAndMouthClass.EmotionCount - 1 or EyesAndMouthClass.EmotionCount
end)

return EyesAndMouthClass