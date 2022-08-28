---@class CinematicModeClass シネマティックモードを制御するクラス
---@field CinematicModeClass.CinematicMode boolean シネマティックモードが有効かどうか
---@field CinematicModeClass.CameraRot table カメラの向き情報: 1. ピッチ, 2. ロール, 3. ヨー

CinematicModeClass = {}

CinematicModeClass.CinematicMode = false
CinematicModeClass.CameraRot = {0, 0, 0}

---カメラのピッチに渡された角度を加える。
---@param deg integer 加える角度
function CinematicModeClass.addCameraPitch(deg)
	CinematicModeClass.CameraRot[1] = math.min(math.max(CinematicModeClass.CameraRot[1] + deg, -90), 90)
end

---カメラのロールに渡された角度を加える。
---@param deg integer 加える角度
function CinematicModeClass.addCameraRoll(deg)
	CinematicModeClass.CameraRot[2] = math.min(math.max(CinematicModeClass.CameraRot[2] + deg, -180), 180)
end

---カメラのヨーに渡された角度を加える。
---@param deg integer 加える角度
function CinematicModeClass.addCameraYaw(deg)
	CinematicModeClass.CameraRot[3] = (CinematicModeClass.CameraRot[3] + deg) % 360
end

---カメラの向きリセット
function CinematicModeClass.resetCamera()
	CinematicModeClass.CameraRot = {ConfigClass.CinematicModeCamera.PitchInit, ConfigClass.CinematicModeCamera.RollInit, ConfigClass.CinematicModeCamera.YawInit}
end

events.WORLD_RENDER:register(function()
	if CinematicModeClass.CinematicMode and not renderer:isFirstPerson() then
		renderer:setCameraRot(renderer:isCameraBackwards() and -CinematicModeClass.CameraRot[1] or CinematicModeClass.CameraRot[1], CinematicModeClass.CameraRot[3], CinematicModeClass.CameraRot[2])
	elseif not player then
		renderer:setCameraRot()
	elseif player:getPose() ~= "SLEEPING" then
		renderer:setCameraRot()
	end
end)

CinematicModeClass.resetCamera()

return CinematicModeClass