---@class SummerFeatureClass 夏機能（水着スキン）を制御するクラス
---@field ChangeUVList table UVを変更するモデルパーツのリスト
---@field HiddenPartList table 夏機能が有効の時に隠されるパーツのリスト
---@field BikiniSkirtList table ビキニスカートのパーツのリスト
---@field SummerFeatureClass.SummerFeature boolean 夏機能が有効かどうか

SummerFeatureClass = {}

ChangeUVList = {models.models.main.Avatar.Body.Body, models.models.main.Avatar.Body.BodyLayer, models.models.main.Avatar.Body.Arms, models.models.main.Avatar.RightLeg, models.models.main.Avatar.RightLeg, models.models.main.Avatar.LeftLeg, models.models.alternative_arms.Body.Arms.RightArm.RightArm, models.models.alternative_arms.Body.Arms.RightArm.RightArmLayer, models.models.alternative_arms.Body.Arms.RightArm.RightArmBottom.RightArmBottom, models.models.alternative_arms.Body.Arms.RightArm.RightArmBottom.RightArmBottomLayer, models.models.alternative_arms.Body.Arms.LeftArm.LeftArm, models.models.alternative_arms.Body.Arms.LeftArm.LeftArmLayer, models.models.alternative_arms.Body.Arms.LeftArm.LeftArmBottom.LeftArmBottom, models.models.alternative_arms.Body.Arms.LeftArm.LeftArmBottom.LeftArmBottomLayer}
HiddenPartList = {models.models.main.Avatar.Body.Skirt.BackRibbon, models.models.main.Avatar.Body.Skirt.Skirt3, models.models.main.Avatar.Body.Skirt.Skirt3Layer}
BikineSkirtList = {models.models.main.Avatar.Body.Skirt.Skirt1, models.models.main.Avatar.Body.Skirt.Skirt1Layer, models.models.main.Avatar.Body.Skirt.Skirt2, models.models.main.Avatar.Body.Skirt.Skirt2Layer}
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
	models.models.main.Avatar.Body.Skirt:setPos(0, value and -2 or 0, 0)
	if value then
		BikineSkirtList[1]:setUVPixels(84, 0)
		BikineSkirtList[2]:setUVPixels(72, 0)
		BikineSkirtList[3]:setUVPixels(84, 0)
		BikineSkirtList[4]:setUVPixels(42, 11)
	else
		BikineSkirtList[1]:setUVPixels(0, 0)
		BikineSkirtList[2]:setUVPixels(0, 0)
		BikineSkirtList[3]:setUVPixels(0, 0)
		BikineSkirtList[4]:setUVPixels(0, 0)
	end
	SummerFeatureClass.SummerFeature = value
end

events.TICK:register(function()
	if not SummerFeatureClass.SummerFeature then
		for _, modelPart in ipairs(HiddenPartList) do
			modelPart:setVisible(not string.find(General.hasItem(player:getItem(5)), "chestplate$") or ConfigClass.HideArmor)
		end
	end
end)

return SummerFeatureClass