---@class WetClass 濡れ機能を制御するクラス
---@field WetCount integer 濡れの度合いを計るカウンター
---@field AutoShake boolean 自動ブルブルが有効かどうか
---@field AutoShakeCount integer 自動ブルブルまでの時間を計るカウンター

WetClass = {}

WetClass.WetCount = 0
WetClass.AutoShake = ConfigClass.loadConfig("autoShake", true)
AutoShakeCount = 0

events.TICK:register(function()
	if player:isWet() then
		WetClass.WetCount = player:isInWater() and 1200 or WetClass.WetCount + 4
		AutoShakeCount = 0
	elseif WetClass.WetCount > 0 then
		if WetClass.WetCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(avatar:getMaxParticles() / 4 , 4) * math.ceil(WetClass.WetCount / 300) / 4 do
				particles:newParticle("minecraft:falling_water", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
			end
		end
		local paused = client:isPaused()
		if WetClass.AutoShake and not WardenClass.WardenNearby and animations["models.main"]["shake"]:getPlayState() ~= "PLAYING" then
			if AutoShakeCount == 20 then
				ActionWheelClass.bodyShake()
				AutoShakeCount = 0
			elseif not paused then
				AutoShakeCount = AutoShakeCount + 1
			end
		end
		if not paused then
			WetClass.WetCount = WetClass.WetCount - 1
		end
	end
end)

return WetClass