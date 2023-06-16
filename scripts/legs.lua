---@class LegsClass 脚を制御するクラス

LegsClass = {}

events.TICK:register(function ()
	local rightLeg = models.models.main.Avatar.Torso.Body.BodyBottom.Legs.RightLeg
	local leftLeg = models.models.main.Avatar.Torso.Body.BodyBottom.Legs.LeftLeg
	if ArmsClass.isSneaking then
		for _, armPart in ipairs({rightLeg, leftLeg}) do
			armPart:setPos(0, 4, -4)
			armPart:setRot(30, 0, 0)
		end
	else
		for _, armPart in ipairs({rightLeg, leftLeg}) do
			armPart:setPos(0, 0, 0)
			armPart:setRot(0, 0, 0)
		end
	end
end)

return LegsClass