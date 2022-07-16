---@class BellSoundClass 鈴の音を制御するクラス
---@field JumpKey Keybind ジャンプボタン（ジャンプ時に鈴を鳴らす用）
---@field WalkDistance number 鈴を鳴らす用の歩いた距離
---@field VelocityYData table ジャンプしたかどうかを判定する為にy方向の速度を格納するテーブル
---@field OnGroundData table 前チックに着地していたかを判定する為に着地情報を格納するテーブル

BellSoundClass = {}

JumpKey = keybind:create("ジャンプ", keybind:getVanillaKey("key.jump"))
WalkDistance = 0
VelocityYData = {}
OnGroundData = {}

---プレイヤーの位置で鈴の音を再生する。
function BellSoundClass.playBellSound()
	local volume = (player:isSneaking() or player:isUnderwater()) and 0.1 or 0.5 --TODO: ウォーデンが付近にいる場合も考慮する。
	sound:playSound("bell", player:getPos(), volume, 1)
end

events.TICK:register(function()
	local velocity = player:getVelocity()
	local onGround = player:isOnGround()
	WalkDistance = WalkDistance + math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2))
	if WalkDistance >= 1.8 then
		if not player:getVehicle() and player:getPose() ~= "FALL_FLYING" and onGround then
			BellSoundClass.playBellSound()
		end
		WalkDistance = 0
	end
	table.insert(VelocityYData, velocity.y)
	table.insert(OnGroundData, onGround)
	for _, dataTable in ipairs({VelocityYData, OnGroundData}) do
		if #dataTable == 3 then
			table.remove(dataTable, 1)
		end
	end
	if JumpKey:isPressed() and OnGroundData[1] and velocity.y > 0 and VelocityYData[1] <= 0 then
		BellSoundClass.playBellSound()
	end
end)

return BellSoundClass