---@class EffectClass ステータス効果による挙動を制御するクラス

EffectClass = {}

events.TICK:register(function()
	for _, effect in ipairs(player:getStatusEffects()) do
		local splitTable = {}
		for matchString in string.gmatch(effect.name, "([^\\.]+)") do
			table.insert(splitTable, matchString)
		end
		if General.tableFind({"bad_omen", "blindness", "darkness", "hunger", "mining_fatigue",  "nausea", "poison", "slowness", "weakness", "wither"}, splitTable[3]) and FacePartsClass.ComplexionCount == 0 then
			FacePartsClass.setComplexion("PALE", 0, false)
			break;
		end
	end
end)

return EffectClass