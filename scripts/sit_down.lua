---@class SitDownClass おすわりアクションを制御するクラス

SitDownClass = {}

CameraYOffset = 0

---現在座れる状況かを返す。
---@return boolean
function SitDownClass.canSitDown()
	if player then
		---@diagnostic disable-next-line: undefined-field
		return player:getPose() == "STANDING" and player:isOnGround() and not player:getVehicle() and not player:isMoving(true) and not WardenClass.WardenNearby
	else
		return false
	end
end

---座る
function SitDownClass.sitDown()
	General.setAnimations("PLAY", "sit_down")
	General.setAnimations("STOP", "stand_up")
	General.setAnimations("STOP", "wave_tail")
end

--座っている状態から立ち上がる
function SitDownClass.standUp()
	General.setAnimations("PLAY", "stand_up")
	General.setAnimations("STOP", "sit_down")
	if ConfigClass.WaveTail then
		General.setAnimations("PLAY", "wave_tail")
	end
end

events.WORLD_RENDER:register(function ()
	local playState = animations["models.main"]["sit_down"]:getPlayState()
	if (playState == "PLAYING" or playState == "HOLDING") and CameraYOffset > -0.5 then
		CameraYOffset = math.max(CameraYOffset - 0.5 / client:getFPS() * 6, -0.5)
	elseif playState ~= "PLAYING" and playState ~= "HOLDING" and CameraYOffset < 0 then
		CameraYOffset = math.min(CameraYOffset + 0.5 / client:getFPS() * 6, 0)
	end
	renderer:offsetCameraPivot(0, CameraYOffset, 0)
end)

---@diagnostic disable-next-line: undefined-field
events.DAMAGE:register(function ()
	local playState = animations["models.main"]["sit_down"]:getPlayState()
	if playState == "PLAYING" or playState == "HOLDING" then
		SitDownClass.standUp()
	end
end)

return SitDownClass