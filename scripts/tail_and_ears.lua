---@class TailAndEarsClass 尻尾と耳を制御するクラス
---@field RightEar CustomModelPart 右耳
---@field LeftEar CustomModelPart 左耳
---@field Tail1 CustomModelPart 尻尾（付け根の方）
---@field Tail2 CustomModelPart 尻尾（先っぽの方）
---@field CatTypeID table CatTypeとIDを紐づけるテーブル
---@field EarBendCount integer 耳を曲げるアニメーションを再生するタイミングを計るカウンター

TailAndEarsClass = {}

RightEar = models.models.main.Avatar.Head.Ears.RightEar
LeftEar = models.models.main.Avatar.Head.Ears.LeftEar
Tail1 = models.models.main.Avatar.Body.Tail
Tail2 = models.models.main.Avatar.Body.Tail.Tail1.Tail2
CatTypeID = {ORIGINAL = 0, ALL_BLACK = 1, BLACK = 2, BRITISH_SHORTHAIR = 3, CALICO = 4, GLEY_TABBY = 5, JELLIE = 6, OCELOT = 7, PERSIAN = 8, RAGDOLL = 9, RED = 10, SIAMESE = 11, TABBY = 12, WHITE = 13}
EarBendCount = 0

events.TICK:register(function()
	local gamemode = player:getGamemode()
	local condition --0. 低HP、低満腹度, 1. 中HP、中満腹度, 2. 高HP、高満腹度
	if ((player:getHealth() / player:getMaxHealth() > 0.5 and player:getFood() > 10) or gamemode == "CREATIVE" or gamemode == "SPECTATOR") and player:getFrozenTicks() < 140 then
		condition = 2
	elseif not General.isTired() then
		condition = 1
	else
		condition = 0
	end
	--耳
	if condition == 0 or WetClass.WetCount > 0 then
		RightEar:setRot(-30, 0, 0)
		LeftEar:setRot(-30, 0, 0)
	elseif condition == 1 then
		RightEar:setRot(-15, 0, 0)
		LeftEar:setRot(-15, 0, 0)
	else
		RightEar:setRot(0, 0, 0)
		LeftEar:setRot(0, 0, 0)
	end
	--尻尾
	if condition == 2 or player:getPose() == "SLEEPING" or animation["main"]["sit_down"]:getPlayState() == "PLAYING" then --TODO: アニメーションの速度変更関数が実装された時に、conditionに応じて尻尾の速度を変更する。
		Tail1:setRot(0, 0, 0)
		Tail2:setRot(0, 0, 0)
	elseif condition == 1 then
		Tail1:setRot(40, 0, 0)
		Tail2:setRot(-15, 0, 0)
	else
		Tail1:setRot(90, 0, 0)
		Tail2:setRot(0, 0, 0)
	end

	--耳曲げ
	if EarBendCount == 300 then
		animation["main"][player:isLeftHanded() and "left_ear_bend" or "right_ear_bend"]:play()
		EarBendCount = 0
	elseif not client.isPaused() then
		EarBendCount = EarBendCount + 1
	end
end)

RightEar:setUVPixels(CatTypeID[ConfigClass.CatType] * 8, 0)
LeftEar:setUVPixels(CatTypeID[ConfigClass.CatType] * 8, 0)
Tail1.Tail1.Tail1:setUVPixels(CatTypeID[ConfigClass.CatType] * 8, 0)
Tail2.Tail2:setUVPixels(CatTypeID[ConfigClass.CatType] * 8, 0)

if ConfigClass.WaveTail then
	animation["main"]["wave_tail"]:play()
end

return TailAndEarsClass