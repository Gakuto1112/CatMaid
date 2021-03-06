---@class 腕を制御するクラス
---@field ArmsClass.isSneaking boolean スニークしていて、腕の補正が必要かどうかを返す。

ArmsClass = {}

ArmsClass.isSneaking = false

events.TICK:register(function()
	ArmsClass.isSneaking = player:isSneaking() and not player:isFlying() and player:getPose() == "CROUCHING" and not renderer:isFirstPerson()
	local rightArm = models.models.main.Avatar.Body.Arms.RightArm
	local leftArm = models.models.main.Avatar.Body.Arms.LeftArm
	if ArmsClass.isSneaking then
		for _, armPart in ipairs({rightArm, leftArm}) do
			armPart:setPos(0, 3, 0)
			armPart:setRot(30, 0, 0)
		end
	else
		for _, armPart in ipairs({rightArm, leftArm}) do
			armPart:setPos(0, 0, 0)
			armPart:setRot(0, 0, 0)
		end
	end
end)

for _, modelPart in ipairs({models.models.main.Avatar.Body.Arms.RightArm.RightArmBottom, models.models.main.Avatar.Body.Arms.LeftArm.LeftArmBottom}) do
	modelPart:setParentType("None")
end

return ArmsClass