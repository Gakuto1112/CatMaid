---@class FavoriteFoodClass お気に入りの食べ物を食べた時の挙動を制御するクラス
---@field FavoriteFoods table お気に入りの食べ物を定義するテーブル
---@field FavoriteFoodClass.FoodEatCount integer 食べ終わりのタイミングを計るためのカウンター
---@field FavoriteFoodClass.SatisfyCount integer お気に入りの食べ物を食べた後ゴロゴロ言うタイミングを計るカウンター

FavoriteFoodClass = {}

FavoriteFoods = {"minecraft:cod", "minecraft:salmon", "minecraft:cooked_cod", "minecraft:cooked_salmon"}
FavoriteFoodClass.FoodEatCount = 0
FavoriteFoodClass.SatisfyCount = 0

events.TICK:register(function()
	local isPaused = client:isPaused()
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
				FavoriteFoodClass.SatisfyCount = 170
			end
			FavoriteFoodClass.FoodEatCount = FavoriteFoodClass.FoodEatCount + 1
		else
			FavoriteFoodClass.FoodEatCount = 0
			if (General.tableFind(FavoriteFoods, General.hasItem(player:getHeldItem(false))) or General.tableFind(FavoriteFoods, General.hasItem(player:getHeldItem(true)))) and not General.isTired() and EyesAndMouthClass.EmotionCount == 0 then
				EyesAndMouthClass.setEmotion("SHINE", "SHINE", "CLOSED", 1, false)
			end
		end
		if FavoriteFoodClass.SatisfyCount > 0 and FavoriteFoodClass.SatisfyCount <= 130 and FavoriteFoodClass.SatisfyCount % 65 == 0 and not isPaused then
			if player:getAir() > 0 then
				sound:playSound("minecraft:entity.cat.purr", player:getPos(), player:isUnderwater() and 0.2 or 1, 1)
			end
		end
	else
		FavoriteFoodClass.FoodEatCount = 0
		FavoriteFoodClass.SatisfyCount = 0
	end
	if not isPaused then
		FavoriteFoodClass.SatisfyCount = math.max(FavoriteFoodClass.SatisfyCount - 1, 0)
	end
end)

return FavoriteFoodClass