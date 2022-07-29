---@class ArmorClass 防具の表示を制御するクラス
---@field ModelRoot CustomModelPart モデルのルートパス
---@field ArmorRoot CustomModelPart 防具モデルのルートパス

---@alias ArmorType
---| "HELMET"
---| "CHESTPLATE"
---| "LEGGINGS"
---| "BOOTS"

ArmorClass = {}

ModelRoot = models.models.main
ArmorRoot = models.models.armor

---防具の設定。有効な防具であれば、trueを返す。
---@param armorItem ItemStack 対象の防具のアイテムスタック
---@param armorType ArmorType 設定する防具の種類
---@param armorPartList table 設定する防具のモデルのパーツリスト
---@param overlayPartList table 設定する防具のオーバーレイのパーツリスト
---@return boolean
function setArmor(armorItem, armorType, armorPartList, overlayPartList)
	if string.find(armorItem.id, "^minecraft:.+_"..string.lower(armorType)) then
		local material = string.match(armorItem.id, ":.+_")
		local glint = armorItem:hasGlint()
		material = string.sub(material, 2, string.len(material) - 1)
		if material == "leather" then
			if armorItem.tag.display ~= nil then
				if armorItem.tag.display.color ~= nil then
					for _, armorPart in ipairs(armorPartList) do
						armorPart:setColor(vectors.intToRGB(armorItem.tag.display.color))
					end
				else
					for _, armorPart in ipairs(armorPartList) do
						armorPart:setColor(160 / 255, 101 / 255, 64 / 255)
					end
				end
			else
				for _, armorPart in ipairs(armorPartList) do
					armorPart:setColor(160 / 255, 101 / 255, 64 / 255)
				end
			end
			for _, overlayPart in ipairs(overlayPartList) do
				overlayPart:setVisible(true)
				overlayPart:setSecondaryRenderType(glint and "GLINT" or nil)
			end
		else
			for _, armorPart in ipairs(armorPartList) do
				armorPart:setColor(1, 1, 1)
			end
			for _, overlayPart in ipairs(overlayPartList) do
				overlayPart:setVisible(false)
			end
		end
		for _, armorPart in ipairs(armorPartList) do
			armorPart:setPrimaryTexture("resource", "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_"..(armorType == "LEGGINGS" and 2 or 1)..".png")
			armorPart:setSecondaryRenderType(glint and "GLINT" or nil)
		end
		return true
	else
		for _, overlayPart in ipairs(overlayPartList) do
			overlayPart:setVisible(false)
		end
		return false
	end
end

---腕の防具を設定する。腕が表示されているかどうかも考慮される。
---@param armorEnabled  boolean 防具を表示するかどうか
function setArmArmor(armorEnabled)
	ArmorRoot.Avatar.Body.Arms.RightArm:setVisible(ModelRoot.Avatar.Body.Arms.RightArm:getVisible() and armorEnabled)
	ArmorRoot.Avatar.Body.Arms.LeftArm:setVisible(ModelRoot.Avatar.Body.Arms.LeftArm:getVisible() and armorEnabled)
	if ModelRoot.Avatar.Body.Arms.RightArm:getVisible() and armorEnabled then
		ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate:setVisible(true)
		ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom:setVisible(true)
	else
		ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate:setVisible(false)
		ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom:setVisible(false)
	end
	if ModelRoot.Avatar.Body.Arms.LeftArm:getVisible() and armorEnabled then
		ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate:setVisible(true)
		ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom:setVisible(true)
	else
		ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate:setVisible(false)
		ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom:setVisible(false)
	end
end

events.TICK:register(function()
	if not ConfigClass.HideArmor then
		local helmet = ArmorRoot.Avatar.Head.Helmet
		local chetplate = {ArmorRoot.Avatar.Body.Chestplate, ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate, ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate, ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom}
		local leggings = {ArmorRoot.Avatar.Body.Leggings, ArmorRoot.Avatar.RightLeg.RightLeggings, ArmorRoot.Avatar.LeftLeg.LeftLeggings}
		local boots = {ArmorRoot.Avatar.RightLeg.RightBoots, ArmorRoot.Avatar.LeftLeg.LeftBoots}
		local helmetItem = player:getItem(6)
		if not SummerFeatureClass.SummerFeature or General.hasItem(helmetItem) ~= "minecraft:leather_helmet" then
			helmet:setVisible(setArmor(helmetItem, "HELMET", {helmet}, {helmet.HelmetOverlay}))
		else
			helmet:setVisible(false)
			helmet.HelmetOverlay:setVisible(false)
		end
		if setArmor(player:getItem(5), "CHESTPLATE", chetplate, {ArmorRoot.Avatar.Body.Chestplate.ChestplateOverlay, ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom.RightChestplateBottomOverlay, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom.LeftChestplateBottomOverlay}) then
			chetplate[1]:setVisible(true)
			setArmArmor(true)
		else
			chetplate[1]:setVisible(false)
			setArmArmor(false)
		end
		if setArmor(player:getItem(4),"LEGGINGS", leggings, {ArmorRoot.Avatar.Body.Leggings.LeggingsOverlay, ArmorRoot.Avatar.RightLeg.RightLeggings.RightLeggingsOverlay, ArmorRoot.Avatar.LeftLeg.LeftLeggings.LeftLeggingsOverlay}) then
			for _, armorPart in ipairs(leggings) do
				armorPart:setVisible(true)
			end
		else
			for _, armorPart in ipairs(leggings) do
				armorPart:setVisible(false)
			end
		end
		if setArmor(player:getItem(3), "BOOTS", boots, {ArmorRoot.Avatar.RightLeg.RightBoots.RightBootsOverlay, ArmorRoot.Avatar.LeftLeg.LeftBoots.LeftBootsOverlay}) then
			for _, armorPart in ipairs(boots) do
				armorPart:setVisible(true)
			end
		else
			for _, armorPart in ipairs(boots) do
				armorPart:setVisible(false)
			end
		end
		if ArmsClass.isSneaking then
			for _, armorPart in ipairs({ArmorRoot.Avatar.Body.Arms.RightArm, ArmorRoot.Avatar.Body.Arms.LeftArm}) do
				armorPart:setPos(0, 3, 0)
				armorPart:setRot(30, 0, 0)
			end
		else
			for _, armorPart in ipairs({ArmorRoot.Avatar.Body.Arms.RightArm, ArmorRoot.Avatar.Body.Arms.LeftArm}) do
				armorPart:setPos(0, 0, 0)
				armorPart:setRot(0, 0, 0)
			end
		end
	end
end)

ArmorRoot:setVisible(not ConfigClass.HideArmor)
for _, armorPart in ipairs({ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate, ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplate}) do
	armorPart:setVisible(not ConfigClass.HideArmor)
end
for _, modelPart in ipairs({ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom, ArmorRoot.Avatar.RightLeg.RightLeggings, ArmorRoot.Avatar.LeftLeg.LeftLeggings}) do
	modelPart:setParentType("None")
end
for _, overlayPart in ipairs({ArmorRoot.Avatar.Head.Helmet.HelmetOverlay, ArmorRoot.Avatar.Body.Chestplate.ChestplateOverlay, ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, ArmorRoot.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, ArmorRoot.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom.RightChestplateBottomOverlay, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, ArmorRoot.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom.LeftChestplateBottomOverlay, ArmorRoot.Avatar.RightLeg.RightBoots.RightBootsOverlay, ArmorRoot.Avatar.LeftLeg.LeftBoots.LeftBootsOverlay}) do
	overlayPart:setPrimaryTexture("resource", "minecraft:textures/models/armor/leather_layer_1_overlay.png")
end
for _, overlayPart in ipairs({ArmorRoot.Avatar.Body.Leggings.LeggingsOverlay, ArmorRoot.Avatar.RightLeg.RightLeggings.RightLeggingsOverlay, ArmorRoot.Avatar.LeftLeg.LeftLeggings.LeftLeggingsOverlay}) do
	overlayPart:setPrimaryTexture("resource", "minecraft:textures/models/armor/leather_layer_2_overlay.png")
end

return ArmorClass