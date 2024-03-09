---@class FoodClass お気に入りの食べ物を食べた時の挙動を制御するクラス
---@field FavoriteFoods table お気に入りの食べ物を定義するテーブル
---@field FoodClass.FoodEatCount integer 食べ終わりのタイミングを計るためのカウンター
---@field FoodClass.SatisfyCount integer お気に入りの食べ物を食べた後ゴロゴロ言うタイミングを計るカウンター

FoodClass = {}

FavoriteFoods = {"minecraft:cod", "minecraft:salmon", "minecraft:cooked_cod", "minecraft:cooked_salmon"}
FoodClass.FoodEatCount = 0
FoodClass.SatisfyCount = 0

events.TICK:register(function()
	local isPaused = client:isPaused()
	if player:getPose() ~= "SLEEPING" and not WardenClass.WardenNearby then
		local activeItem = player:getActiveItem()
		if General.tableFind(FavoriteFoods, General.hasItem(activeItem)) then
			FacePartsClass.setEmotion("CLOSED", "CLOSED", "CLOSED", 1, false)
			if FoodClass.FoodEatCount == activeItem:getUseDuration() - 2 then
				local playerPos = player:getPos()
				FacePartsClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
				MeowClass.playMeow(General.isTired and "WEAK" or "NORMAL", 1)
				particles:newParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
				FoodClass.FoodEatCount = 0
				FoodClass.SatisfyCount = 170
			end
			FoodClass.FoodEatCount = FoodClass.FoodEatCount + 1
		else
			FoodClass.FoodEatCount = 0
			if General.tableFind({"minecraft:rotten_flesh", "minecraft:poisonous_potato", "minecraft:spider_eye", "minecraft:suspicious_stew", "minecraft:pufferfish"}, General.hasItem(activeItem)) and FacePartsClass.ComplexionCount == 0 then
				FacePartsClass.setComplexion("PALE", 0, false)
			end
			if (General.tableFind(FavoriteFoods, General.hasItem(player:getHeldItem(false))) or General.tableFind(FavoriteFoods, General.hasItem(player:getHeldItem(true)))) and not General.isTired and FacePartsClass.EmotionCount == 0 then
				FacePartsClass.setEmotion("SHINE", "SHINE", "CLOSED", 1, false)
			end
		end
		if FoodClass.SatisfyCount > 0 and FoodClass.SatisfyCount <= 130 and FoodClass.SatisfyCount % 65 == 0 and not isPaused then
			MeowClass.playMeow("PURR", 1)
		end
	else
		FoodClass.FoodEatCount = 0
		FoodClass.SatisfyCount = 0
	end
	if not isPaused then
		FoodClass.SatisfyCount = math.max(FoodClass.SatisfyCount - 1, 0)
	end
end)

events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
    if path ~= nil and math.abs(pos:copy():sub(player:getPos()):length() - player:getVelocity():length()) < 0.2 then
        if id == "minecraft:entity.generic.eat" and player:getActiveItem():isFood() then
			sounds:playSound("minecraft:entity.cat.eat", pos, 1, 1)
			return true
		elseif id == "minecraft:entity.player.burp" then
			sounds:playSound("minecraft:entity.player.burp", pos, 1, 2)
			return true
        end
    end
end)

return FoodClass