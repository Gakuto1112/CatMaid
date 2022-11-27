---@class TailAndEarsClass 尻尾と耳を制御するクラス
---@field TailAndEarsClass.CatTypeID table CatTypeとIDを紐づけるテーブル
---@field TailAndEarsClass.CatType integer 現在の猫の種類
---@field EarBendCount integer 耳を曲げるアニメーションを再生するタイミングを計るカウンター

TailAndEarsClass = {}

TailAndEarsClass.CatTypeID = {"original", "all_black", "black", "british_shorthair", "calico", "gley_tabby", "jellie", "ocelot", "persian", "ragdoll", "red", "siamese", "tabby", "white"}
TailAndEarsClass.CatType = ConfigClass.loadConfig("catType", 1)
EarBendCount = 0

---ネコの種類を設定する。
---@param newCat number 新しい猫の種類
function TailAndEarsClass.setCatType(newCat)
	for _, modelPart in ipairs({models.models.main.Avatar.Head.Ears, models.models.skull.Skull.Ears}) do
		modelPart:setUVPixels((newCat - 1) * 8, 0)
	end
end

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
	local rightEar = models.models.main.Avatar.Head.Ears.RightEar
	local leftEar = models.models.main.Avatar.Head.Ears.LeftEar
	if condition == 0 or WetClass.WetCount > 0 then
		rightEar:setRot(-30, 0, 0)
		leftEar:setRot(-30, 0, 0)
	elseif condition == 1 then
		rightEar:setRot(-15, 0, 0)
		leftEar:setRot(-15, 0, 0)
	else
		rightEar:setRot(0, 0, 0)
		leftEar:setRot(0, 0, 0)
	end
	--尻尾
	local gamemode = player:getGamemode()
	local tail1 = {models.models.main.Avatar.Body.BodyBottom.Tail, models.models.player_hands.Avatar.Body.Tail}
	local tail2 = {models.models.main.Avatar.Body.BodyBottom.Tail.Tail1.Tail2, models.models.player_hands.Avatar.Body.Tail.Tail1.Tail2}
	if condition == 2 or player:getPose() == "SLEEPING" or animations["models.main"]["sit_down"]:getPlayState() == "PLAYING" or gamemode == "CREATIVE" or gamemode == "SPECTATOR" then
		for _, modelPart in ipairs(tail1) do
			modelPart:setRot(0, 0, 0)
		end
		for _, modelPart in ipairs(tail2) do
			modelPart:setRot(0, 0, 0)
		end
		animations["models.main"]["wave_tail"]:speed(1)
		animations["models.player_hands"]["wave_tail"]:speed(1)
	elseif condition == 1 then
		for _, modelPart in ipairs(tail1) do
			modelPart:setRot(40, 0, 0)
		end
		for _, modelPart in ipairs(tail2) do
			modelPart:setRot(-15, 0, 0)
		end
		animations["models.main"]["wave_tail"]:speed(0.75)
		animations["models.player_hands"]["wave_tail"]:speed(0.75)
	else
		for _, modelPart in ipairs(tail1) do
			modelPart:setRot(90, 0, 0)
		end
		for _, modelPart in ipairs(tail2) do
			modelPart:setRot(0, 0, 0)
		end
		animations["models.main"]["wave_tail"]:speed(0.5)
		animations["models.player_hands"]["wave_tail"]:speed(0.75)
	end

	--耳曲げ
	if EarBendCount == 300 then
		animations["models.main"][player:isLeftHanded() and "left_ear_bend" or "right_ear_bend"]:play()
		EarBendCount = 0
	elseif not client.isPaused() then
		EarBendCount = EarBendCount + 1
	end
end)

if TailAndEarsClass.CatType > 1 then
	TailAndEarsClass.setCatType(TailAndEarsClass.CatType)
end

if ConfigClass.loadConfig("waveTail", true) then
	General.setAnimations("PLAY", "wave_tail")
end

return TailAndEarsClass