---@class General 他の複数のクラスが参照するフィールドや関数を定義するクラス
---@field SneakData table 前チックにスニークしていたかどうかを調べる為にスニーク情報を格納するテーブル

---@alias AnimationState
---| "PLAY"
---| "STOP"

---@alias ArmType
---| "RIGHT"
---| "LEFT"

General = {}

SneakData = {}

---渡されたlistの中にkeyが存在するかどうか返す
---@param list table keyを探すリスト
---@param key any listの中から探し出す要素
---@return boolean
function General.tableFind(list, key)
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
function General.hasItem(item)
	if item == nil then
		return "none"
	else
		return item.id == "minecraft:air" and "none" or item.id
	end
end

---指定されたステータス効果の情報を返す。指定されたステータス効果が付与されていない場合はnilが返される。
---@param name string ステータス効果
---@return table|nil
function General.getStatusEffect(name)
	for _, effect in ipairs(player:getStatusEffects()) do
		if effect.name == "effect.minecraft."..name then
			return effect
		end
	end
	return nil
end

---前チックにスニークしていたかどうかを返す。
---@return boolean
function General.getSneakPrevTick()
	return SneakData[1]
end

---プレイヤーが疲れているか（HPが4以下又は満腹度が6以下）かどうか返す。
---@return boolean
function General.isTired()
	local gamemode = player:getGamemode()
	return (player:getHealth() <= 4 or player:getFood() <= 6 or player:getFrozenTicks() == 140) and (gamemode == "SURVIVAL" or gamemode == "ADVENTURE")
end

--防具モデルと同時に描画タイプを変更する。
---@param armType ArmType 右腕か左腕か
---@param parentType ParentTypes 描画タイプ
function General.setParentTypeWithArmor(armType, parentType)
	local arm = armType == "LEFT" and "LeftArm" or "RightArm"
	for _, modelPart in ipairs({models.models.main.Avatar.Body.Arms[arm], models.models.armor.Avatar.Body.Arms[arm]}) do
		modelPart:setParentType(parentType)
	end
end

--複数のモデルファイルのアニメーションを同時に制御する。
---@param animationState AnimationState アニメーションの設定値
---@param animationName string アニメーションの名前
function General.setAnimations(animationState, animationName)
	local modelFiles = models.models:getChildren()
	if animationState == "PLAY" then
		for _, modelPart in ipairs(modelFiles) do
			if animations[modelPart.name] ~= nil then
				local targetAnimation = animations[modelPart.name][animationName]
				if targetAnimation ~= nil then
					targetAnimation:play()
				end
			end
		end
	else
		for _, modelPart in ipairs(modelFiles) do
			if animations[modelPart.name] ~= nil then
				local targetAnimation = animations[modelPart.name][animationName]
				if targetAnimation ~= nil then
					targetAnimation:stop()
				end
			end
		end
	end
end

events.TICK:register(function()
	table.insert(SneakData, player:isSneaking())
	if #SneakData == 3 then
		table.remove(SneakData, 1)
	end
end)

return General