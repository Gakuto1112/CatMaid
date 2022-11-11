---@class ArmorClass 防具の表示を制御するクラス
---@field ArmorClass.HideArmor boolean 防具を隠すかどうか
---@field HideArmorPrev boolean 前チックに防具を隠すかどうか

---@alias ArmorType
---| "HELMET"
---| "CHESTPLATE"
---| "LEGGINGS"
---| "BOOTS"

ArmorClass = {}

ArmorClass.HideArmor = ConfigClass.loadConfig("hideArmor", true)
HideArmorPrev = ArmorClass.HideArmor

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
	models.models.armor.Avatar.Body.Arms.RightArm:setVisible(models.models.main.Avatar.Body.Arms.RightArm:getVisible() and armorEnabled)
	models.models.armor.Avatar.Body.Arms.LeftArm:setVisible(models.models.main.Avatar.Body.Arms.LeftArm:getVisible() and armorEnabled)
	if models.models.main.Avatar.Body.Arms.RightArm:getVisible() and armorEnabled then
		models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate:setVisible(true)
		models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom:setVisible(true)
	else
		models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate:setVisible(false)
		models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom:setVisible(false)
	end
	if models.models.main.Avatar.Body.Arms.LeftArm:getVisible() and armorEnabled then
		models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate:setVisible(true)
		models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom:setVisible(true)
	else
		models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate:setVisible(false)
		models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom:setVisible(false)
	end
end

events.TICK:register(function()
	if not ArmorClass.HideArmor then
		local helmet = models.models.armor.Avatar.Head.Helmet
		local chetplate = {models.models.armor.Avatar.Body.Chestplate, models.models.armor.Avatar.Body.BodyBottom.ChestplateBottom, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom}
		local leggings = {models.models.armor.Avatar.Body.Leggings, models.models.armor.Avatar.Body.BodyBottom.LeggingsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLeggings, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightLeggingsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLeggings, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftLeggingsBottom}
		local boots = {models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightBoots, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightBootsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftBootsBottom}
		local helmetItem = player:getItem(6)
		local helmetItemType = General.hasItem(helmetItem)
		if not SummerFeatureClass.SummerFeature or (helmetItemType ~= "minecraft:leather_helmet" and helmetItemType ~= "minecraft:turtle_helmet")  then
			helmet:setVisible(setArmor(helmetItem, "HELMET", {helmet}, {helmet.HelmetOverlay}))
		else
			helmet:setVisible(false)
			helmet.HelmetOverlay:setVisible(false)
		end
		if setArmor(player:getItem(5), "CHESTPLATE", chetplate, {models.models.armor.Avatar.Body.Chestplate.ChestplateOverlay, models.models.armor.Avatar.Body.BodyBottom.ChestplateBottom.ChestplateBottomOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom.RightChestplateBottomOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom.LeftChestplateBottomOverlay}) then
			for i = 1, 2 do
				chetplate[i]:setVisible(true)
			end
			setArmArmor(true)
		else
			for i = 1, 2 do
				chetplate[i]:setVisible(false)
			end
			setArmArmor(false)
		end
		if setArmor(player:getItem(4),"LEGGINGS", leggings, {models.models.armor.Avatar.Body.Leggings.LeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.LeggingsBottom.LeggingsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLeggings.RightLeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLeggings.LeftLeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) then
			for _, armorPart in ipairs(leggings) do
				armorPart:setVisible(true)
			end
		else
			for _, armorPart in ipairs(leggings) do
				armorPart:setVisible(false)
			end
		end
		if setArmor(player:getItem(3), "BOOTS", boots, {models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightBoots.RightBootsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightBootsBottom.RightBootsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftBoots.LeftBootsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftBootsBottom.LeftBootsBottomOverlay}) then
			for _, armorPart in ipairs(boots) do
				armorPart:setVisible(true)
			end
		else
			for _, armorPart in ipairs(boots) do
				armorPart:setVisible(false)
			end
		end
		if ArmsClass.isSneaking then
			for _, armorPart in ipairs({models.models.armor.Avatar.Body.Arms.RightArm, models.models.armor.Avatar.Body.Arms.LeftArm}) do
				armorPart:setPos(0, 3, 0)
				armorPart:setRot(30, 0, 0)
			end
		else
			for _, armorPart in ipairs({models.models.armor.Avatar.Body.Arms.RightArm, models.models.armor.Avatar.Body.Arms.LeftArm}) do
				armorPart:setPos(0, 0, 0)
				armorPart:setRot(0, 0, 0)
			end
		end
		models.models.armor.Avatar.Head:setParentType(player:getPose() == "SLEEPING" and "None" or "Head")
	elseif HideArmorPrev then
		for _, modelPart in ipairs({models.models.armor.Avatar.Head.Helmet, models.models.armor.Avatar.Body.Chestplate, models.models.armor.Avatar.Body.BodyBottom.ChestplateBottom, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom, models.models.armor.Avatar.Body.Leggings, models.models.armor.Avatar.Body.BodyBottom.LeggingsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLeggings, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightLeggingsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLeggings, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftLeggingsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightBoots, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightBootsBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftBootsBottom, models.models.armor.Avatar.Head.Helmet.HelmetOverlay, models.models.armor.Avatar.Body.Chestplate.ChestplateOverlay, models.models.armor.Avatar.Body.BodyBottom.ChestplateBottom.ChestplateBottomOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom.RightChestplateBottomOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom.LeftChestplateBottomOverlay, models.models.armor.Avatar.Body.Leggings.LeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.LeggingsBottom.LeggingsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLeggings.RightLeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLeggings.LeftLeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftLeggingsBottom.LeftLeggingsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightBoots.RightBootsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightBootsBottom.RightBootsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftBoots.LeftBootsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftBootsBottom.LeftBootsBottomOverlay}) do
			modelPart:setVisible(false)
		end
	end
	HideArmorPrev = ArmorClass.HideArmor
end)

models.models.armor:setVisible(not ArmorClass.HideArmor)
for _, armorPart in ipairs({models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplate}) do
	armorPart:setVisible(not ArmorClass.HideArmor)
end
for _, modelPart in ipairs({models.models.armor.Avatar.Body.BodyBottom, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLeggings, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLeggings, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom}) do
	modelPart:setParentType("None")
end
for _, overlayPart in ipairs({models.models.armor.Avatar.Head.Helmet.HelmetOverlay, models.models.armor.Avatar.Body.Chestplate.ChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightChestplate.RightChestplateOverlay, models.models.armor.Avatar.Body.Arms.RightArm.RightArmBottom.RightChestplateBottom.RightChestplateBottomOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftChestplate.LeftChestplateOverlay, models.models.armor.Avatar.Body.Arms.LeftArm.LeftArmBottom.LeftChestplateBottom.LeftChestplateBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightBoots.RightBootsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightBootsBottom.RightBootsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftBoots.LeftBootsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftBootsBottom.LeftBootsBottomOverlay}) do
	overlayPart:setPrimaryTexture("resource", "minecraft:textures/models/armor/leather_layer_1_overlay.png")
end
for _, overlayPart in ipairs({models.models.armor.Avatar.Body.Leggings.LeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLeggings.RightLeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLeggings.LeftLeggingsOverlay, models.models.armor.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
	overlayPart:setPrimaryTexture("resource", "minecraft:textures/models/armor/leather_layer_2_overlay.png")
end

return ArmorClass