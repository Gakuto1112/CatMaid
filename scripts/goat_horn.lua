---@class GoatHornClass ヤギの角笛を吹く時の挙動を制御するクラス
---@field GoatHornClass.Horn boolean ヤギの角笛を吹いている時はtrueになる。

GoatHornClass = {}

GoatHornClass.Horn = false

events.TICK:register(function()
	GoatHornClass.Horn = General.hasItem(player:getActiveItem()) == "minecraft:goat_horn"
	if GoatHornClass.Horn then
		FacePartsClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 1, true)
	end
end)

return GoatHornClass