---@class CakeClass ケーキの持ち方を制御するクラス
---@field RightHandItemTypeData table アイテムの持ち替え検出の為に右手のアイテムの情報を格納するテーブル
---@field LeftHandItemTypeData table アイテムの持ち替え検出の為に左手のアイテムの情報を格納するテーブル

CakeClass = {}

RightHandItemTypeData = {false}
LeftHandItemTypeData = {false}

events.TICK:register(function()
	local rightArm = models.models.main.Avatar.Body.Arms.RightArm
	local leftArm = models.models.main.Avatar.Body.Arms.LeftArm
	local rightAlternativeArm = models.models.alternative_arms.Body.Arms.RightArm
	local leftAlternativeArm = models.models.alternative_arms.Body.Arms.LeftArm
	local rightItem = vanilla_model.RIGHT_ITEM
	local leftItem = vanilla_model.LEFT_ITEM
	local rightCake = rightAlternativeArm.RightArmBottom.RightCake
	local leftCake = leftAlternativeArm.LeftArmBottom.LeftCake
	local rightCakeBody = rightCake.Cake
	local leftCakeBody = leftCake.Cake
	local leftHanded = player:isLeftHanded()
	local rightHeldItem = player:getHeldItem(leftHanded)
	local leftHeldItem = player:getHeldItem(not leftHanded)
	local rightHandItemType = General.hasItem(rightHeldItem)
	local leftHandItemType = General.hasItem(leftHeldItem)
	if rightHandItemType == "minecraft:cake" then
		rightArm:setVisible(false)
		rightAlternativeArm:setVisible(true)
		rightItem:setVisible(false)
		rightCake:setVisible(true)
		rightCakeBody:setSecondaryRenderType(rightHeldItem:hasGlint() and "GLINT" or nil)
		if RightHandItemTypeData[1] ~= "minecraft:cake" then
			local randamCake = math.random()
			if randamCake >= 0.99 then
				rightCakeBody:setUVPixels(0, 44)
				sound:playSound("minecraft:block.lava.extinguish", player:getPos(), 1, 1)
				EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
			elseif randamCake >= 0.95 then
				rightCakeBody:setUVPixels(0, 22)
				if not WardenClass.WardenNearby then
					MeowClass.playMeow("NORMAL", 1)
					EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
				end
			else
				rightCakeBody:setUVPixels(0, 0)
			end
			animation["alternative_arms"]["right_cake"]:play()
		end
	else
		if not WardenClass.WardenNearby then
			rightArm:setVisible(true)
			rightAlternativeArm:setVisible(false)
		end
		rightItem:setVisible(true)
		rightCake:setVisible(false)
		rightCakeBody:setSecondaryRenderType(nil)
		animation["alternative_arms"]["right_cake"]:stop()
	end
	if leftHandItemType == "minecraft:cake" then
		leftArm:setVisible(false)
		leftAlternativeArm:setVisible(true)
		leftItem:setVisible(false)
		leftCake:setVisible(true)
		leftCakeBody:setSecondaryRenderType(leftHeldItem:hasGlint() and "GLINT" or nil)
		if LeftHandItemTypeData[1] ~= "minecraft:cake" then
			local randamCake = math.random()
			if randamCake >= 0.99 then
				leftCakeBody:setUVPixels(0, 44)
				sound:playSound("minecraft:block.lava.extinguish", player:getPos(), 1, 1)
				EyesAndMouthClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
			elseif randamCake >= 0.95 then
				leftCakeBody:setUVPixels(0, 22)
				if not WardenClass.WardenNearby then
					MeowClass.playMeow("NORMAL", 1)
					EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
				end
			else
				leftCakeBody:setUVPixels(0, 0)
			end
			animation["alternative_arms"]["left_cake"]:play()
		end
	else
		if not WardenClass.WardenNearby then
			leftArm:setVisible(true)
			leftAlternativeArm:setVisible(false)
		end
		leftItem:setVisible(true)
		leftCake:setVisible(false)
		leftCakeBody:setSecondaryRenderType(nil)
		animation["alternative_arms"]["left_cake"]:stop()
	end
	table.insert(RightHandItemTypeData, rightHandItemType)
	table.insert(LeftHandItemTypeData, leftHandItemType)
	for _, dataTable in ipairs({RightHandItemTypeData, LeftHandItemTypeData}) do
		if #dataTable == 3 then
			table.remove(dataTable, 1)
		end
	end
end)

return CakeClass