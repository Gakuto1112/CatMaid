---@class CakeClass ケーキの持ち方を制御するクラス
---@field RightHandItemTypeData table アイテムの持ち替え検出の為に右手のアイテムの情報を格納するテーブル
---@field LeftHandItemTypeData table アイテムの持ち替え検出の為に左手のアイテムの情報を格納するテーブル

CakeClass = {}

RightHandItemTypeData = {false}
LeftHandItemTypeData = {false}

events.TICK:register(function()
	local rightItem = vanilla_model.RIGHT_ITEM
	local leftItem = vanilla_model.LEFT_ITEM
	local rightCake = models.models.cakes.Body.RightCake
	local leftCake = models.models.cakes.Body.LeftCake
	local rightCakeBody = rightCake.Cake
	local leftCakeBody = leftCake.Cake
	local leftHanded = player:isLeftHanded()
	local rightHeldItem = player:getHeldItem(leftHanded)
	local leftHeldItem = player:getHeldItem(not leftHanded)
	local rightHandItemType = General.hasItem(rightHeldItem)
	local leftHandItemType = General.hasItem(leftHeldItem)
	local isSleeping = player:getPose() == "SLEEPING"
	if rightHandItemType == "minecraft:cake" and not isSleeping then
		General.setParentTypeWithArmor("RIGHT", "Body")
		rightItem:setVisible(false)
		rightCake:setVisible(true)
		rightCakeBody:setSecondaryRenderType(rightHeldItem:hasGlint() and (client:getVersion() == "1.21.4" and "GLINT2" or "GLINT") or nil)
		if RightHandItemTypeData[1] ~= "minecraft:cake" or SleepClass.SleepData[1] then
			if RightHandItemTypeData[1] ~= "minecraft:cake" then
				local randamCake = math.random()
				if randamCake >= 0.99 then
					rightCakeBody:setUVPixels(0, 44)
					sounds:playSound("minecraft:block.lava.extinguish", player:getPos(), 1, 1)
					FacePartsClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
				elseif randamCake >= 0.95 then
					rightCakeBody:setUVPixels(0, 22)
					if not WardenClass.WardenNearby then
						MeowClass.playMeow("NORMAL", 1)
						FacePartsClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
					end
				else
					rightCakeBody:setUVPixels(0, 0)
				end
			end
			General.setAnimations("PLAY", "right_cake")
		end
	else
		if not WardenClass.WardenNearby and AFKClass.TouchBellCount <= 0 then
			General.setParentTypeWithArmor("RIGHT", "RightArm")
		end
		rightItem:setVisible(true)
		rightCake:setVisible(false)
		rightCakeBody:setSecondaryRenderType(nil)
		General.setAnimations("STOP", "right_cake")
	end
	if leftHandItemType == "minecraft:cake" and not isSleeping then
		General.setParentTypeWithArmor("LEFT", "Body")
		leftItem:setVisible(false)
		leftCake:setVisible(true)
		leftCakeBody:setSecondaryRenderType(leftHeldItem:hasGlint() and (client:getVersion() == "1.21.4" and "GLINT2" or "GLINT") or nil)
		if LeftHandItemTypeData[1] ~= "minecraft:cake" or SleepClass.SleepData[1] then
			if LeftHandItemTypeData[1] ~= "minecraft:cake" then
				local randamCake = math.random()
				if randamCake >= 0.99 then
					leftCakeBody:setUVPixels(0, 44)
					sounds:playSound("minecraft:block.lava.extinguish", player:getPos(), 1, 1)
					FacePartsClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 20, true)
				elseif randamCake >= 0.95 then
					leftCakeBody:setUVPixels(0, 22)
					if not WardenClass.WardenNearby then
						MeowClass.playMeow("NORMAL", 1)
						FacePartsClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
					end
				else
					leftCakeBody:setUVPixels(0, 0)
				end
			end
			General.setAnimations("PLAY", "left_cake")
		end
	else
		if not WardenClass.WardenNearby and AFKClass.TouchBellCount >= 0 then
			General.setParentTypeWithArmor("LEFT", "LeftArm")
		end
		leftItem:setVisible(true)
		leftCake:setVisible(false)
		leftCakeBody:setSecondaryRenderType(nil)
		General.setAnimations("STOP", "left_cake")
	end
	table.insert(RightHandItemTypeData, rightHandItemType)
	table.insert(LeftHandItemTypeData, leftHandItemType)
	for _, dataTable in ipairs({RightHandItemTypeData, LeftHandItemTypeData}) do
		if #dataTable == 3 then
			table.remove(dataTable, 1)
		end
	end
end)

for _, cakePlate in ipairs({models.models.cakes.Body.RightCake.RightCakePlate, models.models.cakes.Body.LeftCake.LeftCakePlate}) do
	cakePlate:setPrimaryTexture("resource", "minecraft:textures/block/spruce_planks.png")
end

return CakeClass