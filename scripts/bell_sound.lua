---@class BellSoundClass 鈴の音を制御するクラス
---@field JumpKey Keybind ジャンプボタン（ジャンプ時に鈴を鳴らす用）
---@field WalkDistance number 鈴を鳴らす用の歩いた距離
---@field VelocityYData table ジャンプしたかどうかを判定する為にy方向の速度を格納するテーブル
---@field OnGroundData table 前チックに着地していたかを判定する為に着地情報を格納するテーブル

BellSoundClass = {}

JumpKey = keybind:create(LanguageClass.getTranslate("key__jump"), keybind:getVanillaKey("key.jump"))
WalkDistance = 0
VelocityYData = {}
OnGroundData = {}

---プレイヤーの位置で鈴の音を再生する。
function BellSoundClass.playBellSound()
	local playerPos = player:getPos()
	if ConfigClass.BellSound then
		local volume = WardenClass.WardenNearby and 0.0125 or ((player:isSneaking() or player:isUnderwater()) and 0.025 or 0.05)
		if avatar:canUseCustomSounds() then
			sounds:playSound("bell", playerPos, volume, 1)
		else
			sounds:playSound("minecraft:entity.experience_orb.pickup", playerPos, volume, 1.5)
		end
	end
	if not player:isInWater() then
		sounds:playSound("minecraft:entity.cod.flop", playerPos, WetClass.WetCount / 1200, 1)
	end
end

events.TICK:register(function()
	local velocity = player:getVelocity()
	local onGround = player:isOnGround()
	if not client:isPaused() then
		WalkDistance = WalkDistance + math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2))
		if WalkDistance >= 1.8 then
			if not player:getVehicle() and onGround then
				BellSoundClass.playBellSound()
			end
			WalkDistance = 0
		end
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

if not avatar:canUseCustomSounds() then
	print(LanguageClass.getTranslate("message__custom_sound_unavailable"))
end

return BellSoundClass