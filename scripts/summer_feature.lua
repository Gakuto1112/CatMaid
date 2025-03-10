---@class SummerFeatureClass 夏機能（水着スキン）を制御するクラス
---@field ChangeUVList table UVを変更するモデルパーツのリスト
---@field HiddenPartList table 夏機能が有効の時に隠されるパーツのリスト
---@field BikiniSkirtList table ビキニスカートのパーツのリスト

SummerFeatureClass = {}

ChangeUVList = {models.models.main.Avatar.Torso.Body.Body, models.models.main.Avatar.Torso.Body.BodyLayer, models.models.main.Avatar.Torso.Body.BodyBottom.BodyBottom, models.models.main.Avatar.Torso.Body.BodyBottom.BodyBottomLayer, models.models.main.Avatar.Torso.Arms.RightArm.RightArm, models.models.main.Avatar.Torso.Arms.RightArm.RightArmLayer, models.models.main.Avatar.Torso.Arms.RightArm.RightArmBottom.RightArmBottom, models.models.main.Avatar.Torso.Arms.RightArm.RightArmBottom.RightArmBottomLayer, models.models.main.Avatar.Torso.Arms.LeftArm.LeftArm, models.models.main.Avatar.Torso.Arms.LeftArm.LeftArmLayer, models.models.main.Avatar.Torso.Arms.LeftArm.LeftArmBottom.LeftArmBottom, models.models.main.Avatar.Torso.Arms.LeftArm.LeftArmBottom.LeftArmBottomLayer, models.models.main.Avatar.Torso.Body.BodyBottom.Legs.RightLeg.RightLeg, models.models.main.Avatar.Torso.Body.BodyBottom.Legs.RightLeg.RightLegLayer, models.models.main.Avatar.Torso.Body.BodyBottom.Legs.LeftLeg.LeftLeg, models.models.main.Avatar.Torso.Body.BodyBottom.Legs.LeftLeg.LeftLegLayer}
HiddenPartList = {models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Apron, models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.BackRibbon, models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Skirt3, models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Skirt3Layer}
BikineSkirtList = {models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Skirt1, models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Skirt1Layer, models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Skirt2, models.models.main.Avatar.Torso.Body.BodyBottom.Skirt.Skirt2Layer}
SummerFeatureClass.SummerFeature = false

---夏機能の設定
---@param value boolean 有効かどうか
function SummerFeatureClass.setSummerFeature(value)
	for _, modelPart in ipairs(ChangeUVList) do
		modelPart:setUVPixels(value and 64 or 0, 0)
	end
	for _, modelPart in ipairs(HiddenPartList) do
		modelPart:setVisible(not value)
	end
	models.models.main.Avatar.Torso.Body.BodyBottom.Skirt:setPos(0, value and -2 or 0, 0)
	if value then
		BikineSkirtList[1]:setUVPixels(84, 0)
		BikineSkirtList[2]:setUVPixels(72, 0)
		BikineSkirtList[3]:setUVPixels(84, 0)
		BikineSkirtList[4]:setUVPixels(42, 11)
	else
		for _, modelPart in ipairs(BikineSkirtList) do
			modelPart:setUVPixels(0, 0)
		end
	end
	SummerFeatureClass.SummerFeature = value
end

events.TICK:register(function()
	local whiteHat = models.models.summer_features.Head.WhiteHat
	local snorkel = models.models.summer_features.Head.Snorkel
	if not SummerFeatureClass.SummerFeature then
		for _, modelPart in ipairs(HiddenPartList) do
			modelPart:setVisible(not string.find(General.hasItem(player:getItem(5)), "chestplate$") or ArmorClass.ShowArmor)
		end
		whiteHat:setVisible(false)
		snorkel:setVisible(false)
	else
		local helmetItem = player:getItem(6)
		local helmetItemType = General.hasItem(helmetItem)
		if helmetItemType == "minecraft:leather_helmet" then
			snorkel:setVisible(false)
			whiteHat:setVisible(true)
			if helmetItem.tag.display ~= nil then
				if helmetItem.tag.display.color ~= nil then
					whiteHat.WhiteHatBelt:setColor(vectors.intToRGB(helmetItem.tag.display.color))
				else
					whiteHat.WhiteHatBelt:setColor(160 / 255, 101 / 255, 64 / 255)
				end
			else
				whiteHat.WhiteHatBelt:setColor(160 / 255, 101 / 255, 64 / 255)
			end
			whiteHat:setSecondaryRenderType(helmetItem:hasGlint() and (client:getVersion() == "1.21.4" and "GLINT2" or "GLINT") or nil)
		elseif helmetItemType == "minecraft:turtle_helmet" then
			whiteHat:setVisible(false)
			snorkel:setVisible(true)
			snorkel:setPos(0, player:isUnderwater() and 0 or 4, 0)
			snorkel:setSecondaryRenderType(helmetItem:hasGlint() and (client:getVersion() == "1.21.4" and "GLINT2" or "GLINT") or nil)
		else
			whiteHat:setVisible(false)
			snorkel:setVisible(false)
		end
		models.models.summer_features.Head:setParentType(player:getPose() == "SLEEPING" and "None" or "Head")
	end
end)

return SummerFeatureClass