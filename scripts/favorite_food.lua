---@class FavoriteFoodClass お気に入りの食べ物を食べた時の挙動を制御するクラス
---@field FavoriteFoods table お気に入りの食べ物を定義するテーブル
---@field FavoriteFoodClass.FoodEatCount integer 食べ終わりのタイミングを計るためのカウンター

FavoriteFoodClass = {}

FavoriteFoods = {"minecraft:cod", "minecraft:salmon", "minecraft:cooked_cod", "minecraft:cooked_salmon"}
FavoriteFoodClass.FoodEatCount = 0

events.TICK:register(function()
	if player:getPose() ~= "SLEEPING" and not WardenClass.WardenNearby then
		local activeItem = player:getActiveItem()
		if General.tableFind(FavoriteFoods, General.hasItem(activeItem)) then
			EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 1, false)
			if FavoriteFoodClass.FoodEatCount == activeItem:getUseDuration() - 2 then
				local playerPos = player:getPos()
				EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
				MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
				particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
				FavoriteFoodClass.FoodEatCount = 0
			end
			FavoriteFoodClass.FoodEatCount = FavoriteFoodClass.FoodEatCount + 1
		else
			FavoriteFoodClass.FoodEatCount = 0
			if (General.tableFind(FavoriteFoods, General.hasItem(player:getHeldItem(false))) or General.tableFind(FavoriteFoods, General.hasItem(player:getHeldItem(true)))) and not General.isTired() and EyesAndMouthClass.EmotionCount == 0 then
				EyesAndMouthClass.setEmotion("SHINE", "SHINE", "CLOSED", 1, false)
			end
		end
	else
		FavoriteFoodClass.FoodEatCount = 0
	end
end)

return FavoriteFoodClass