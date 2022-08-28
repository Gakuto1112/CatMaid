---@class TailAndEarsClass 尻尾と耳を制御するクラス
---@field RightEar CustomModelPart 右耳
---@field LeftEar CustomModelPart 左耳
---@field Tail1 table 尻尾（付け根の方）
---@field Tail2 table 尻尾（先っぽの方）
---@field CatTypeID table CatTypeとIDを紐づけるテーブル
---@field EarBendCount integer 耳を曲げるアニメーションを再生するタイミングを計るカウンター

TailAndEarsClass = {}

RightEar = models.models.main.Avatar.Head.Ears.RightEar
LeftEar = models.models.main.Avatar.Head.Ears.LeftEar
Tail1 = {models.models.main.Avatar.Body.BodyBottom.Tail, models.models.player_hands.Avatar.Body.Tail}
Tail2 = {models.models.main.Avatar.Body.BodyBottom.Tail.Tail1.Tail2, models.models.player_hands.Avatar.Body.Tail.Tail1.Tail2}
CatTypeID = {ORIGINAL = 0, ALL_BLACK = 1, BLACK = 2, BRITISH_SHORTHAIR = 3, CALICO = 4, GLEY_TABBY = 5, JELLIE = 6, OCELOT = 7, PERSIAN = 8, RAGDOLL = 9, RED = 10, SIAMESE = 11, TABBY = 12, WHITE = 13}
EarBendCount = 0

events.TICK:register(function()
	local condition --0. 低HP、低満腹度, 1. 中HP、中満腹度, 2. 高HP、高満腹度
	if player:getHealth() / player:getMaxHealth() > 0.5 and player:getFood() > 10 and player:getFrozenTicks() < 140 then
		condition = 2
	elseif not General.isTired then
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
	local gamemode = player:getGamemode()
	if condition == 2 or player:getPose() == "SLEEPING" or animations["main"]["sit_down"]:getPlayState() == "PLAYING" or gamemode == "CREATIVE" or gamemode == "SPECTATOR" then
		for _, modelPart in ipairs(Tail1) do
			modelPart:setRot(0, 0, 0)
		end
		for _, modelPart in ipairs(Tail2) do
			modelPart:setRot(0, 0, 0)
		end
		animations["main"]["wave_tail"]:speed(1)
		animations["player_hands"]["wave_tail"]:speed(1)
	elseif condition == 1 then
		for _, modelPart in ipairs(Tail1) do
			modelPart:setRot(40, 0, 0)
		end
		for _, modelPart in ipairs(Tail2) do
			modelPart:setRot(-15, 0, 0)
		end
		animations["main"]["wave_tail"]:speed(0.75)
		animations["player_hands"]["wave_tail"]:speed(0.75)
	else
		for _, modelPart in ipairs(Tail1) do
			modelPart:setRot(90, 0, 0)
		end
		for _, modelPart in ipairs(Tail2) do
			modelPart:setRot(0, 0, 0)
		end
		animations["main"]["wave_tail"]:speed(0.5)
		animations["player_hands"]["wave_tail"]:speed(0.75)
	end

	--耳曲げ
	if EarBendCount == 300 then
		animations["main"][player:isLeftHanded() and "left_ear_bend" or "right_ear_bend"]:play()
		EarBendCount = 0
	elseif not client.isPaused() then
		EarBendCount = EarBendCount + 1
	end
end)

for _, modelPart in ipairs({RightEar, LeftEar, Tail1[1].Tail1.Tail1, Tail2[1].Tail2, Tail1[1].Tail1.TailSection1, Tail1[1].Tail1.TailSection2, Tail2[1].TailSection3, Tail2[1].TailSection4}) do
	modelPart:setUVPixels(CatTypeID[ConfigClass.CatType] * 8, 0)
end

if ConfigClass.WaveTail then
	General.setAnimations("PLAY", "wave_tail")
end

return TailAndEarsClass