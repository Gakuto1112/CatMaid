---@class AlternativeArmsClass アニメーション用の代替の腕を制御するクラス
---@field AlternativeArmsRoot CustomModelPart 代替の腕のルートパス

AlternativeArmsClass = {}

AlternativeArmsRoot = models.models.alternative_arms

for _, modelPart in ipairs({AlternativeArmsRoot, AlternativeArmsRoot.Body.Arms.RightArm.RightArmBottom.RightCake, AlternativeArmsRoot.Body.Arms.LeftArm.LeftArmBottom.LeftCake}) do
	modelPart:setVisible(false)
end
for _, modelPart in ipairs({AlternativeArmsRoot.Body.Arms.RightArm, AlternativeArmsRoot.Body.Arms.RightArm.RightArmBottom, AlternativeArmsRoot.Body.Arms.LeftArm, AlternativeArmsRoot.Body.Arms.LeftArm.LeftArmBottom}) do
	modelPart:setParentType("None")
end
for _, cakePlate in ipairs({AlternativeArmsRoot.Body.Arms.RightArm.RightArmBottom.RightCake.RightCakePlate, AlternativeArmsRoot.Body.Arms.LeftArm.LeftArmBottom.LeftCake.LeftCakePlate}) do
	cakePlate:setPrimaryTexture("resource", "minecraft:textures/block/spruce_planks.png")
end

return AlternativeArmsClass