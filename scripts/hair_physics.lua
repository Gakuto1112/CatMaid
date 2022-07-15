---@class HairPhysicsClass 髪をたなびかせるクラス
---@field FrontHair CustomModelPart 前髪
---@field BackHair CustomModelPart 後ろ髪
---@field Utils Utils ユーティリティクラス
---@field HairRenderCount integer 髪の物理演算を計算した回数、上限計算に用いる。
---@field HairRenderLimit integer Renderの命令数上限に対する、髪の物理演算の頻度の係数
---@field VelocityData table 速度データ：1. 横, 2. 縦, 3. 角速度
---@field VelocityAverage table 速度の平均値：1. 横, 2. 縦, 3. 角速度
---@field LookRotPrevRender number 前レンダーチックのlookRot

HairPhysicsClass = {}

FrontHair = models.models.main.Avatar.Body.Hairs.FrontHair
BackHair = models.models.main.Avatar.Body.Hairs.BackHair

Utils = require("scripts/utils")
HairRenderCount = 0
HairRenderLimit = math.ceil(8192 / meta:getMaxWorldRenderCount())
VelocityData = {{}, {}, {}}
VelocityAverage = {0, 0, 0}
LookRotPrevRender = 0

events.TICK:register(function()
	if string.find(Utils.hasItem(player:getItem(5)), "chestplate$") then --TODO: 防具表示/非表示オプションも考慮する。
		FrontHair:setPos(0, 0, -1.1)
		BackHair:setPos(0, 0, 1.1)
	else
		FrontHair:setPos(0, 0, 0)
		BackHair:setPos(0, 0, 0)
	end
end)

events.RENDER:register(function()
	--髪の物理演算（もどき）
	--直近1秒間のxz方向、y方向の移動速度の平均を求める（xz方向の場合、前に動いているか、後ろに動いているかも考慮する）。
	local lookDir = player:getLookDir()
	local lookRot = math.deg(math.atan2(lookDir.z, lookDir.x))
	if HairRenderCount >= HairRenderLimit - 1 then
		local FPS = client:getFPS()
		local velocity = player:getVelocity()
		local velocityRot = math.deg(math.atan2(velocity.z, velocity.x))
		velocityRot = velocityRot < 0 and 360 + velocityRot or velocityRot
		local bodyYaw = (player:getBodyYaw() - 270) % 360
		local directionAbs = math.abs(velocityRot - bodyYaw)
		local playerSpeedData = math.min(directionAbs, 360 - directionAbs) >= 90 and -math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) or math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) + (Utils.SneakPrevTick and -0.19 or 0)
		VelocityAverage[1] = (#VelocityData[1] * VelocityAverage[1] + playerSpeedData) / (#VelocityData[1] + 1)
		table.insert(VelocityData[1], playerSpeedData)
		VelocityAverage[2] = (#VelocityData[2] * VelocityAverage[2] + velocity.y) / (#VelocityData[2] + 1)
		table.insert(VelocityData[2], velocity.y)
		if not Utils.tableFind({"クラフト", "Crafting", "class_481", "Wardrobe", "Trust"}, client:getScreen()) then
			local lookRotDelta = math.abs(lookRot - LookRotPrevRender)
			lookRotDelta = lookRotDelta >= 180 and 360 - lookRotDelta or lookRotDelta
			local lookRotDeltaData = lookRotDelta * FPS
			VelocityAverage[3] = (#VelocityData[3] * VelocityAverage[3] + lookRotDeltaData) / (#VelocityData[3] + 1)
			table.insert(VelocityData[3], lookRotDeltaData)
		else
			VelocityAverage[3] = (#VelocityData[3] * VelocityAverage[3]) / (#VelocityData[3] + 1)
			table.insert(VelocityData[3], 0)
		end
		--古いデータの切り捨て
		for index, velocityTable in ipairs(VelocityData) do
			while #velocityTable > FPS * 0.25 / HairRenderLimit do
				if #velocityTable >= 2 then
					VelocityAverage[index] = (#velocityTable * VelocityAverage[index] - velocityTable[1]) / (#velocityTable - 1)
				end
				table.remove(velocityTable, 1)
			end
		end
		--求めた平均から髪の角度を決定する。
		local hairLimit
		local chestItemType = Utils.hasItem(player:getItem(5))
		if chestItemType == "minecraft:elytra" then
			hairLimit = {{13, 80}, {0, 0}}
		elseif string.find(chestItemType, "chestplate$") then --TODO: 防具表示/非表示オプションも考慮する。
			hairLimit = {{0, 80}, {-80, 0}}
		else
			hairLimit = {{13, 80}, {-80, -13}}
		end
		local playerPose = player:getPose()
		if playerPose == "FALL_FLYING" then
			FrontHair:setRot(math.min(math.max(hairLimit[1][2] - math.sqrt(VelocityAverage[1] ^ 2 + VelocityAverage[2] ^ 2) * 80, hairLimit[1][1]), hairLimit[1][2]), 0, 0)
			BackHair:setRot({hairLimit[2][2], 0, 0})
		elseif playerPose == "SWIMMING" then
			FrontHair:setRot(math.min(math.max(hairLimit[1][2] - math.sqrt(VelocityAverage[1] ^ 2 + VelocityAverage[2] ^ 2) * 320, hairLimit[1][1]), hairLimit[1][2]), 0, 0)
			BackHair:setRot(hairLimit[2][2], 0, 0)
		else
			if math.floor(VelocityAverage[2] * 100 + 0.5) / 100 < 0 then
				FrontHair:setRot(math.min(math.max(-VelocityAverage[1] * 160 - VelocityAverage[2] * 80, hairLimit[1][1]), hairLimit[1][2]), 0, 0)
				BackHair:setRot(math.min(math.max(-VelocityAverage[1] * 160 + VelocityAverage[2] * 80, hairLimit[2][1]), hairLimit[2][2]), 0, 0)
			else
				FrontHair:setRot(math.min(math.max(-VelocityAverage[1] * 160 + VelocityAverage[3] * 0.05, hairLimit[1][1]), hairLimit[1][2]), 0, 0)
				BackHair:setRot(math.min(math.max(-VelocityAverage[1] * 160 - VelocityAverage[3] * 0.05, hairLimit[2][1]), hairLimit[2][2]), 0, 0)
			end
		end
		HairRenderCount = 0
	else
		HairRenderCount = HairRenderCount + 1
	end
	LookRotPrevRender = lookRot
end)

return HairPhysicsClass