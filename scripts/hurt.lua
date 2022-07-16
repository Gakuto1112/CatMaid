---@class HurtClass ダメージを受けたり、死亡した時に処理を行うクラス
---@field HealthData table ダメージを受けたかどうか判定する為にHP情報を格納するテーブル

HurtClass = {}

HealthData = {}

events.TICK:register(function()
	local health = player:getHealth()
	table.insert(HealthData, health)
	if #HealthData == 3 then
		table.remove(HealthData, 1)
	end
	if health < HealthData[1] then
		if health == 0 then
			EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "NONE", 20, true)
			MeowClass.playMeow("DEATH", 1)
		else
			EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "NONE", 8, true)
			MeowClass.playMeow("HURT", 1)
		end
	end
end)

return HurtClass