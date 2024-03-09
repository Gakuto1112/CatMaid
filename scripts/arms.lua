---@class 腕を制御するクラス
---@field isSneaking boolean スニークしていて、腕の補正が必要かどうかを返す。
---@field Flying boolean クリエイティブ飛行のフラグ

ArmsClass = {}

ArmsClass.isSneaking = false

events.TICK:register(function()
	ArmsClass.isSneaking = player:isCrouching() and not General.Flying and not renderer:isFirstPerson()
end)

events.RENDER:register(function ()
	if animations["models.main"]["sit_down"]:getPlayState() == "PLAYING" and player:isUsingItem() then
		local rightArm = models.models.main.Avatar.Torso.Arms.RightArm
		local leftArm = models.models.main.Avatar.Torso.Arms.LeftArm
		local activeHand = player:getActiveHand()
		local leftHanded = player:isLeftHanded()
		local adjustArmItemList = {"minecraft:bow", "minecraft:crossbow", "minecraft:trident", "minecraft:shield", "minecraft:spyglass"}
		if ((activeHand == "OFF_HAND" and leftHanded) or (activeHand == "MAIN_HAND" and not leftHanded)) and General.tableFind(adjustArmItemList, General.hasItem(player:getHeldItem(leftHanded))) then
			rightArm:setRot(-35, -10, -10)
		else
			rightArm:setRot(0, 0, 0)
		end
		if ((activeHand == "MAIN_HAND" and leftHanded) or (activeHand == "OFF_HAND" and not leftHanded)) and General.tableFind(adjustArmItemList, General.hasItem(player:getHeldItem(not leftHanded))) then
			leftArm:setRot(-35, 10, 10)
		else
			leftArm:setRot(0, 0, 0)
		end
	end
end)

return ArmsClass