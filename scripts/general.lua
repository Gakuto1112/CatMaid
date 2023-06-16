---@class General 他の複数のクラスが参照するフィールドや関数を定義するクラス
---@field General.isTired boolean 疲れている（低HP、低満腹度）かどうか

---@alias AnimationState
---| "PLAY"
---| "STOP"

---@alias ArmType
---| "RIGHT"
---| "LEFT"

General = {}

General.isTired = false
General.Flying = false


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
	for _, effect in ipairs(host:getStatusEffects()) do
		if effect.name == "effect.minecraft."..name then
			return effect
		end
	end
	return nil
end

--防具モデルと同時に描画タイプを変更する。
---@param armType ArmType 右腕か左腕か
---@param parentType ModelPart.parentType 描画タイプ
function General.setParentTypeWithArmor(armType, parentType)
	local arm = armType == "LEFT" and "LeftArm" or "RightArm"
	for _, modelPart in ipairs({models.models.main.Avatar.Torso.Arms[arm], models.models.armor.Avatar.Body.Arms[arm]}) do
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
			local animationsInModel = animations["models."..modelPart:getName()]
			if animationsInModel then
				local targetAnimation = animations["models."..modelPart:getName()][animationName]
				if targetAnimation then
					targetAnimation:play()
				end
			end
		end
	else
		for _, modelPart in ipairs(modelFiles) do
			local animationsInModel = animations["models."..modelPart:getName()]
			if animationsInModel then
				local targetAnimation = animations["models."..modelPart:getName()][animationName]
				if targetAnimation then
					targetAnimation:stop()
				end
			end
		end
	end
end

--ping関数
--ping関数
---クリエイティブ飛行のフラグを設定する。
---@param flying boolean 新たに設定する値
function pings.setFlying(flying)
	General.Flying = flying
end

events.TICK:register(function()
	if host:isHost() then
		---@diagnostic disable-next-line: undefined-field
		local flying = host:isFlying()
		if flying ~= General.Flying then
			pings.setFlying(flying)
		end
	end
	local gamemode = player:getGamemode()
	General.isTired = (player:getHealth() / player:getMaxHealth() <= 0.2 or player:getFood() <= 6 or player:getFrozenTicks() == 140) and (gamemode == "SURVIVAL" or gamemode == "ADVENTURE")
end)

return General