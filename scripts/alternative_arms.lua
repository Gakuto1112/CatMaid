---@class AlternativeArmsClass アニメーション用の代替の腕を制御するクラス

AlternativeArmsClass = {}

for _, modelPart in ipairs({models.models.alternative_arms, models.models.alternative_arms.Body.Arms.RightArm.RightArmBottom.RightCake, models.models.alternative_arms.Body.Arms.LeftArm.LeftArmBottom.LeftCake}) do
	modelPart:setVisible(false)
end
for _, modelPart in ipairs({models.models.alternative_arms.Body.Arms.RightArm, models.models.alternative_arms.Body.Arms.RightArm.RightArmBottom, models.models.alternative_arms.Body.Arms.LeftArm, models.models.alternative_arms.Body.Arms.LeftArm.LeftArmBottom}) do
	modelPart:setParentType("None")
end
for _, cakePlate in ipairs({models.models.alternative_arms.Body.Arms.RightArm.RightArmBottom.RightCake.RightCakePlate, models.models.alternative_arms.Body.Arms.LeftArm.LeftArmBottom.LeftCake.LeftCakePlate}) do
	cakePlate:setPrimaryTexture("resource", "minecraft:textures/block/spruce_planks.png")
end

return AlternativeArmsClass