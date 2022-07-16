---@class WardenClass ウォーデンに怯える機能を制御するクラス
---@field WardenClass.WardenNearby boolean ウォーデンが近くにいるかどうか（=暗闇デバフを受けているかどうか）


WardenClass = {}

WardenClass.WardenNearby = false

events.TICK:register(function()
	WardenClass.WardenNearby = General.getStatusEffect("darkness") and true or false
end)

return WardenClass