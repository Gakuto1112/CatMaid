---@class Utils 便利な関数の詰め合わせクラス
---@field SneakTickTmp boolean SneakPrevTickに正しい値を入れるためのtmp変数
---@field SneakPrevTick boolean 前チックにスニークしていたかどうか

Utils = {}

SneakTickTmp = false
Utils.SneakPrevTick = false

---渡された数値が非数（NaN）かどうか返す
---@param num number 非数（NaN）かどうか判定する通知
---@return boolean
function Utils.isNan(num)
	return num ~= num
end

---渡されたlistの中にkeyが存在するかどうか返す
---@param list table keyを探すリスト
---@param key any listの中から探し出す要素
---@return boolean
function Utils.tableFind(list, key)
	if list == nil or key == nil then
		return false
	end
	for _, object in ipairs(list) do
		if object == key then
			return true
		end
	end
	return false
end

---渡されたItemStackのアイテムタイプを返す。nilや"minecraft:air"の場合は"none"と返す。
---@param item ItemStack アイテムタイプを調べるItemStack
---@return string
function Utils.hasItem(item)
	if item == nil then
		return "none"
	else
		return item.id == "minecraft:air" and "none" or item.id
	end
end

---プレイヤーが疲れているか（HPが4以下又は満腹度が6以下）かどうか返す。
---@return boolean
function Utils.isTired()
	return player:getHealth() <= 4 or player:getFood() <= 6
end

events.TICK:register(function()
	Utils.SneakPrevTick = SneakTickTmp
	SneakTickTmp = player:isSneaking()
end)

return Utils