---@class ArmorClass 防具の表示を制御するクラス
---@field ArmorRoot CustomModelPart 防具モデルのルートパス

ArmorClass = {}

ArmorRoot = models.models.armor

events.TICK:register(function()
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
end)

ArmorRoot:setVisible(not ConfigClass.HideArmor)
for _, modelPart in ipairs({ArmorRoot.Avatar.RightLeg.RightLeggings, ArmorRoot.Avatar.LeftLeg.LeftLeggings}) do
	modelPart:setParentType("None")
end

return ArmorClass