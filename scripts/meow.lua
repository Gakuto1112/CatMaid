---@class MeowClass 猫の鳴き声を制御するクラス
---@field MeowNameID table MeowNameとサウンド名を紐付けるテーブル
---@field MeowCount integer 時々ニャーニャー鳴くタイミングを計るカウンター

---@alias MeowName
---| "NORMAL"
---| "PURREOW"
---| "WEAK"
---| "HURT"
---| "DEATH"

MeowClass = {}

MeowNameID = {NORMAL = "minecraft:entity.cat.ambient", PURREOW = "minecraft:entity.cat.purreow", WEAK = "minecraft:entity.cat.stray_ambient", HURT = "minecraft:entity.cat.hurt", DEATH = "minecraft:entity.ocelot.death"}
MeowCount = 0

---猫の鳴き声を再生する。
---@param soundName MeowName 再生する音声名
---@param volume number 音量。0から1。
function MeowClass.playMeow(soundName, volume)
	local playerPos = player:getPos()
	if player:getAir() > 0 or General.getStatusEffect("water_breathing") then
		if player:isUnderwater() then
			sound:playSound(MeowNameID[soundName], playerPos, volume * 0.2, 1.5)
			sound:playSound("block.bubble_column.upwards_ambient", playerPos, 1, 1)
			for _ = 1, 4 do
				particle:addParticle("minecraft:bubble_column_up", playerPos.x, playerPos.y + 1.5, playerPos.z)
			end
		else
			sound:playSound(MeowNameID[soundName], playerPos, volume, 1.5)
		end
	end
end

events.TICK:register(function()
	if ConfigClass.MeowSound then
		if MeowCount == 300 then
			if player:getPose() ~= "SLEEPING" and EyesAndMouthClass.EmotionCount == 0 and not player:isUnderwater() then --TODO: 鳴くのをスキップする条件の追加: ウォーデンが近くにいる時、放置時、角笛を吹く時など
				if General.isTired() then
					MeowClass.playMeow("WEAK", 1)
				else
					if math.random() >= 0.7 then
						MeowClass.playMeow("PURREOW", 1)
					else
						MeowClass.playMeow("NORMAL", 0.5)
					end
				end
			end
			EyesAndMouthClass.setEmotion("NONE", "NONE", "OPENED", 20, false)
			MeowCount = 0
		elseif not client:isPaused() then
			MeowCount = MeowCount + 1
		end
	end
end)

return MeowClass