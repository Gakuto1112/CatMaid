---@class TailAndEarsClass 尻尾と耳を制御するクラス
---@field EarBendCount integer 耳を曲げるアニメーションを再生するタイミングを計るカウンター

TailAndEarsClass = {}

EarBendCount = 0
---尻尾振りを再生する。
function TailAndEarsClass.startTailWave()
	animation["main"]["wave_tail"]:play()
end

---尻尾振りを止める。
function TailAndEarsClass.stopTailWave()
	animation["main"]["wave_tail"]:stop()
end

events.TICK:register(function()
	local rightEar = models.models.main.Avatar.Head.Ears.RightEar
	local leftEar = models.models.main.Avatar.Head.Ears.LeftEar
	local tail1 = models.models.main.Avatar.Body.Tail
	local tail2 = models.models.main.Avatar.Body.Tail.Tail1.Tail2
	local gamemode = player:getGamemode()
	local condition --0. 低HP、低満腹度, 1. 中HP、中満腹度, 2. 高HP、高満腹度
	if (player:getHealth() / player:getMaxHealth() > 0.5 and player:getFood() > 10) or gamemode == "CREATIVE" or gamemode == "SPECTATOR" then
		condition = 2
	elseif not Utils.isTired() then
		condition = 1
	else
		condition = 0
	end
	--耳
	if condition == 0 then --TODO: 濡れた場合も考慮する。
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
	if condition == 2 or player:getPose() == "SLEEPING" then --TODO: おすわりアクションの場合も考慮する。 --TODO: アニメーションの速度変更関数が実装された時に、conditionに応じて尻尾の速度を変更する。
		tail1:setRot(0, 0, 0)
		tail2:setRot(0, 0, 0)
	elseif condition == 1 then
		tail1:setRot(40, 0, 0)
		tail2:setRot(-15, 0, 0)
	else
		tail1:setRot(90, 0, 0)
		tail2:setRot(0, 0, 0)
	end

	--耳曲げ
	if EarBendCount == 300 then
		animation["main"][player:isLeftHanded() and "left_ear_bend" or "right_ear_bend"]:play()
		EarBendCount = 0
	else
		EarBendCount = EarBendCount + 1
	end
end)

TailAndEarsClass.startTailWave() --TODO: 尻尾振りのオプションも考慮する。

return TailAndEarsClass