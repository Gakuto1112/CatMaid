---@class MeowClass 猫の鳴き声を制御するクラス
---@field MeowNameID table MeowNameとサウンド名を紐付けるテーブル
---@field MeowClass.MeowSound boolean 猫の鳴き声を有効にするかどうか
---@field MeowCount integer 時々ニャーニャー鳴くタイミングを計るカウンター

---@alias MeowName
---| "NORMAL"
---| "PURREOW"
---| "PURR"
---| "WEAK"
---| "HISS"
---| "HURT"
---| "DEATH"

MeowClass = {}

MeowNameID = {NORMAL = {name = "minecraft:entity.cat.ambient", pitch = 1.5}, PURREOW = {name = "minecraft:entity.cat.purreow", pitch = 1.5}, PURR = {name = "minecraft:entity.cat.purr", pitch = 1}, WEAK = {name = "minecraft:entity.cat.stray_ambient", pitch = 1.5}, HISS = {name = "minecraft:entity.cat.hiss", pitch = 1}, HURT = {name = "minecraft:entity.cat.hurt", pitch = 1.5}, DEATH = {name = "minecraft:entity.ocelot.death", pitch = 1.5}}
MeowClass.MeowSound = ConfigClass.loadConfig("meowSound", true)
MeowCount = 0

---猫の鳴き声を再生する。
---@param soundName MeowName 再生する音声名
---@param volume number 音量。0から1。
function MeowClass.playMeow(soundName, volume)
	if host:getAir() > 0 or General.getStatusEffect("water_breathing") then
		pings.meow(soundName, volume)
	end
end

--ping関数
function pings.meow(soundName, volume)
	local playerPos = player:getPos()
	if player:isUnderwater() then
		sounds:playSound(MeowNameID[soundName]["name"], playerPos, volume * 0.2, MeowNameID[soundName]["pitch"])
		sounds:playSound("block.bubble_column.upwards_ambient", playerPos, 1, 1)
		for _ = 1, 4 do
			particles:newParticle("minecraft:bubble_column_up", playerPos.x, playerPos.y + 1.5, playerPos.z)
		end
	else
		sounds:playSound(MeowNameID[soundName]["name"], playerPos, volume, MeowNameID[soundName]["pitch"])
	end
end

events.TICK:register(function()
	if MeowClass.MeowSound then
		if MeowCount == 300 then
			if player:getPose() ~= "SLEEPING" and FacePartsClass.EmotionCount == 0 and not player:isUnderwater() and FoodClass.FoodEatCount == 0 and FoodClass.SatisfyCount == 0 and not WardenClass.WardenNearby and not GoatHornClass.Horn and AFKClass.AFKCount < 5400 then
				if General.isTired then
					MeowClass.playMeow("WEAK", 1)
				else
					if math.random() >= 0.7 then
						MeowClass.playMeow("PURREOW", 1)
					else
						MeowClass.playMeow("NORMAL", 0.5)
					end
				end
				FacePartsClass.setEmotion("NONE", "NONE", "OPENED", 20, false)
			end
			MeowCount = 0
		elseif not client:isPaused() then
			MeowCount = MeowCount + 1
		end
	end
end)

return MeowClass