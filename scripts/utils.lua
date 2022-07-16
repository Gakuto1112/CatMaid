---@class Utils 便利な関数の詰め合わせクラス
---@field SneakData table 前チックにスニークしていたかどうかを調べる為にスニーク情報を格納するテーブル
---@field HealthData table ダメージを受けたかどうか判定する為にHP情報を格納するテーブル

---@alias DamageType
---| "NONE"
---| "DAMAGED"
---| "DIED"

Utils = {}

SneakData = {}
HealthData = {}

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

---指定されたステータス効果の情報を返す。指定されたステータス効果が付与されていない場合はnilが返される。
---@param name string ステータス効果
---@return table|nil
function Utils.getStatusEffect(name)
	for _, effect in ipairs(player:getStatusEffects()) do
		if effect.name == "effect.minecraft."..name then
			return effect
		end
	end
	return nil
end

---前チックにスニークしていたかどうかを返す。
---@return boolean
function Utils.getSneakPrevTick()
	return SneakData[1]
end

---ダメージを受けたかどうかを返す。
---@return DamageType
function Utils.getDamaged()
	local health = player:getHealth()
	return health < HealthData[1] and (health == 0 and "DIED" or "DAMAGED") or "NONE"
end

---プレイヤーが疲れているか（HPが4以下又は満腹度が6以下）かどうか返す。
---@return boolean
function Utils.isTired()
	return player:getHealth() <= 4 or player:getFood() <= 6
end

events.TICK:register(function()
	table.insert(SneakData, player:isSneaking())
	table.insert(HealthData, player:getHealth())
	for _, dataTable in ipairs({SneakData, HealthData}) do
		if #dataTable == 3 then
			table.remove(dataTable, 1)
		end
	end
end)

return Utils