---@class BurnClass 火だるまになった時に黒こげになる機能を制御するクラス
---@field BurnCount integer 焦げの具合を決定するカウンター
---@field SmokeCount integer 煙を出すタイミングを計るカウンター

BurnClass = {}

BurnCount = 0
SmokeCount = 0

---焦げ具合を設定する。
---@param burn integer 焦げ具合
function setBurn(burn)
	for _, modelPart in ipairs({models.models.main.Avatar.Head.Head, models.models.main.Avatar.Head.HatLayer, models.models.main.Avatar.Head.Ears, models.models.main.Avatar.Body, models.models.main.Avatar.RightLeg, models.models.main.Avatar.LeftLeg, models.models.cakes, models.models.summer_features, models.models.armor}) do
		modelPart:setColor(burn, burn, burn)
	end
end

events.TICK:register(function()
	local gamemode = player:getGamemode()
	if not client:isPaused() then
		if (gamemode == "SURVIVAL" or gamemode == "ADVENTURE") and not General.getStatusEffect("fire_resistance") and ConfigClass.BurnEffect then
			BurnCount = player:isInLava() and math.min(BurnCount + 20, 1200) or (player:isOnFire() and math.min(BurnCount + 4, 1200) or (player:isInWater() and math.max(BurnCount - 20, 0) or (player:isInRain() and math.max(BurnCount - 4, 0)) or math.max(BurnCount - 1, 0)))
		else
			BurnCount = math.max(BurnCount - 1, 0)
		end
	end
	if gamemode == "SURVIVAL" or gamemode == "ADVENTURE" then
		setBurn(1 - BurnCount / 1333)
		if BurnCount > 0 then
			if SmokeCount == 5 then
				local playerPos = player:getPos()
				for _ = 1, math.min(meta:getMaxParticles() / 4, 16) do
					particle:addParticle("minecraft:smoke", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
				end
				SmokeCount = 0
			else
				SmokeCount = SmokeCount + 1
			end
		else
			SmokeCount = 0
		end
	else
		setBurn(1)
		SmokeCount = 0
	end
end)

events.WORLD_TICK:register(function()
	if ConfigClass.BurnEffect and not player:exists() then
		BurnCount = 0
	end
end)

return BurnClass