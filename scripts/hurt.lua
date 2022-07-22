---@class HurtClass ダメージを受けたり、死亡した時に処理を行うクラス
---@field HealthData table ダメージを受けたかどうか判定する為にHP情報を格納するテーブル
---@field HurtClass.Damaged DamageType ダメージを受けたかどうかが格納される変数

---@alias DamageType
---| "NONE"
---| "DAMAGED"
---| "DIED"

HurtClass = {}

HealthData = {}
HurtClass.Damaged = "NONE"

events.TICK:register(function()
	local health = player:getHealth()
	table.insert(HealthData, health)
	if #HealthData == 3 then
		table.remove(HealthData, 1)
	end
	if health < HealthData[1] then
		if health == 0 then
			EyesAndMouthClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 20, true)
			MeowClass.playMeow("DEATH", 1)
			HurtClass.Damaged = "DEATH"
		else
			if General.isTired() then
				EyesAndMouthClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 8, true)
			else
				EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 8, true)
			end
			MeowClass.playMeow("HURT",  WardenClass.WardenNearby and 0.1 or 1)
			HurtClass.Damaged = "DAMAGED"
		end
	else
		HurtClass.Damaged = "NONE"
	end
end)

return HurtClass