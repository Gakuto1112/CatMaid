--変数
BellSound = true --ベルを鳴らすかどうか
WegTail = true --尻尾のアニメーションを再生するかどうか
HideArmor = false --防具を非表示にするかどうか
AnimationCount = 0 --耳のアニメーションのタイミング変数
WalkDistance = 0 --移動距離（鈴のサウンドに使用）
VelocityYPrev = 0 --前チックのy方向の速度
HealthPercentagePrev = 0 --前チックのHPの割合
VelocityData = {{}, {}} --速度データ：1. 横, 2. 縦
Fps = 60 --FPS、初期値60、20刻み
FpsCountData = {0, 0} --FPSを計測するためのデータ：1. tick, 2. render

function loadBoolean(variableToLoad, name)
	local loadData = data.load(name)
	if loadData ~= nil then
		if loadData == "true" then
			return true
		else
			return false
		end
	else
		return variableToLoad
	end
end

function getTableAverage(tagetTable)
	local sum = 0
	for index, value in ipairs(tagetTable) do
		sum = sum + value
	end
	return sum / #tagetTable
end

--設定の読み込み
BellSound = loadBoolean(BellSound, "BellSound")
WegTail = loadBoolean(WegTail, "WegTail")
HideArmor = loadBoolean(HideArmor, "HideArmor")
print(BellSound)

--デフォルトのプレイヤーモデルを削除
for key, vanillaModel in pairs(vanilla_model) do
	vanillaModel.setEnabled(false)
end

--望遠鏡の調整
spyglass_model.RIGHT_SPYGLASS.setPos({-0.5, 1, 0})
spyglass_model.LEFT_SPYGLASS.setPos({0.5, 1.5, 0})

--尻尾のアニメーション
animation["wag_tail"].setLoopMode("LOOP")
animation["wag_tail"].start()

--アクションホイール
--アクション1： 「ニャー」と鳴く（ネコのサウンド再生）。
action_wheel.SLOT_1.setTitle("「ニャー」と鳴く§c♥")
action_wheel.SLOT_1.setItem("minecraft:cod")
action_wheel.SLOT_1.setColor({255/255, 85/255, 255/255})
action_wheel.SLOT_1.setHoverColor({255/255, 255/255, 255/255})
action_wheel.SLOT_1.setFunction(function()
	local vector = player.getPos()
	sound.playSound("minecraft:entity.cat.ambient", player.getPos(), {1, 1.5})
	particle.addParticle("minecraft:heart", {vector.x, vector.y + 2, vector.z, 0, 0, 0})
end)

--アクション2： 鈴の音の切り替え
if BellSound then
	action_wheel.SLOT_2.setTitle("鈴の音：§cオフ§rにする")
else
	action_wheel.SLOT_2.setTitle("鈴の音：§aオン§rにする")
end
action_wheel.SLOT_2.setItem("minecraft:bell")
action_wheel.SLOT_2.setColor({200/255, 200/255, 200/255})
action_wheel.SLOT_2.setHoverColor({255/255, 255/255, 255/255})
action_wheel.SLOT_2.setFunction(function()
	if BellSound then
		action_wheel.SLOT_2.setTitle("鈴の音：§aオン§rにする")
		data.save("BellSound", false)
	else
		action_wheel.SLOT_2.setTitle("鈴の音：§cオフ§rにする")
		data.save("BellSound", true)
	end
	BellSound = not BellSound
end)

--アクション3： 尻尾のアニメーションの切り替え
if WegTail then
	action_wheel.SLOT_3.setTitle("尻尾振り：§cオフ§rにする")
else
	action_wheel.SLOT_3.setTitle("尻尾振り：§aオン§rにする")
	animation["wag_tail"].cease()
end
action_wheel.SLOT_3.setItem("minecraft:feather")
action_wheel.SLOT_3.setColor({200/255, 200/255, 200/255})
action_wheel.SLOT_3.setHoverColor({255/255, 255/255, 255/255})
action_wheel.SLOT_3.setFunction(function()
	if WegTail then
		action_wheel.SLOT_3.setTitle("尻尾振り：§aオン§rにする")
		animation["wag_tail"].cease()
		data.save("WegTail", false)
	else
		action_wheel.SLOT_3.setTitle("尻尾振り：§cオフ§rにする")
		animation["wag_tail"].start()
		data.save("WegTail", true)
	end
	WegTail = not WegTail
end)

--アクション4: 防具の表示/非表示
if HideArmor then
	action_wheel.SLOT_4.setTitle("防具：§a表示§rする")
	for key, armorPart in pairs(armor_model) do
		armorPart.setEnabled(false)
	end
else
	action_wheel.SLOT_4.setTitle("防具：§c非表示§rにする")
end
action_wheel.SLOT_4.setItem("minecraft:iron_chestplate")
action_wheel.SLOT_4.setColor({200/255, 200/255, 200/255})
action_wheel.SLOT_4.setHoverColor({255/255, 255/255, 255/255})
action_wheel.SLOT_4.setFunction(function()
	if HideArmor then
		action_wheel.SLOT_4.setTitle("防具：§c非表示§rにする")
		for key, armorPart in pairs(armor_model) do
			armorPart.setEnabled(true)
		end
		data.save("HideArmor", false)
	else
		action_wheel.SLOT_4.setTitle("防具：§a表示§rする")
		for key, armorPart in pairs(armor_model) do
			armorPart.setEnabled(false)
		end
		data.save("HideArmor", true)
	end
	HideArmor = not HideArmor
end)

function tick()
	--[[鈴の音

		- xz平面上を1.8m移動する毎に再生する。
		- ジャンプした時など（前チックのy方向の移動方向が0以下かつ、現在のy方向の移動方向が0より大きい）も再生する。
		- スニーキング時、水中にいる時は音量5分の1。
		- 乗り物に乗っている時、滑空時、非接地時は再生しない。

	]]
	local velocity = player.getVelocity()
	local playerSpeed = math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2))
	if BellSound then
		local sneaking = player.isSneaking()
		local underwater = player.isUnderwater()
		WalkDistance = WalkDistance + playerSpeed
		if WalkDistance >= 1.8 then
			if not player.getVehicle() and player.getAnimation() ~= "FALL_FLYING" and player.isOnGround() then
				if sneaking or underwater then
					sound.playCustomSound("Bell", player.getPos(), {0.1, 1})
				else
					sound.playCustomSound("Bell", player.getPos(), {0.5, 1})
				end
			end
			WalkDistance = 0
		end
		if VelocityYPrev <= 0 and velocity.y > 0 then
			if sneaking or underwater then
				sound.playCustomSound("Bell", player.getPos(), {0.1, 1})
			else
				sound.playCustomSound("Bell", player.getPos(), {0.5, 1})
			end
		end
		VelocityYPrev = velocity.y
	end

	--耳のアニメーション
	if AnimationCount >= 300 then
		animation["right_ear_bend"].start()
		AnimationCount = 0
	end

	--[[現在のHPと満腹度から尻尾の角度を決定。

		現在のHP	現在の満腹度	尻尾の状態	アニメーション速度
		100% - 51%	100% - 51%	尻尾立ち	100%
		50% - 21%	50% - 31%	尻尾ちょい下げ	75%
		20% - 0%	30% - 0%	尻尾下げ	50%
		
	]]
	local gamemode = player.getGamemode()
	local healthPercentage = player.getHealthPercentage()
	local foodPercentage = player.getFood() / 20
	local tail1 = model.Body.Tail
	local tail2 = model.Body.Tail.Tail1.Tail2
	if (healthPercentage > 0.5 and foodPercentage > 0.5) or gamemode == "CREATIVE" or gamemode == "SPECTATOR" then
		tail1.setRot({0, 0, 0})
		tail2.setRot({0, 0, 0})
		animation["wag_tail"].setSpeed(1)
	elseif healthPercentage > 0.2 and foodPercentage > 0.3 then
		tail1.setRot({40, 0, 0})
		tail2.setRot({-15, 0, 0})
		animation["wag_tail"].setSpeed(0.75)
	else
		tail1.setRot({90, 0, 0})
		tail2.setRot({0, 0, 0})
		animation["wag_tail"].setSpeed(0.5)
	end

	--猫のサウンド再生
	if healthPercentage < HealthPercentagePrev and healthPercentage > 0 then
		sound.playSound("minecraft:entity.cat.hurt", player.getPos(), {1, 1.5})
	end
	if player.getDeathTime() == 1 then
		sound.playSound("minecraft:entity.cat.death", player.getPos(), {1, 1.5})
	end

	--チック終了処理
	AnimationCount = AnimationCount + 1
	HealthPercentagePrev = healthPercentage
	FpsCountData[1] = FpsCountData[1] + 1
end

function render(delta)
	--FPS計測
	if FpsCountData[1] >= 1 then
		Fps = FpsCountData[2] * 20
		FpsCountData = {0, 0}
	end

	--髪のアニメーション
	--チェストプレート着用の場合は髪をずらす。
	local frontHair = model.Body.Hairs.FrontHair
	local backHair = model.Body.Hairs.BackHair
	if string.find(player.getEquipmentItem(5).getType(), "chestplate$") and not HideArmor then
		frontHair.setPos({0, 0, -1.1})
		backHair.setPos({0, 0, 1.1})
	else
		frontHair.setPos({0, 0, 0})
		backHair.setPos({0, 0, 0})
	end

	--直近1秒間の横方向、縦方向の移動速度の平均を求める（横方向の場合、前に動いているか、後ろに動いているかも考慮する）。
	local velocity = player.getVelocity()
	local playerSpeed = math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2))
	local velocityRot = math.atan(velocity.z / playerSpeed, velocity.x / playerSpeed)
	local lookDir = player.getLookDir()
	local playerAnimation = player.getAnimation()
	if velocityRot == velocityRot then
		if velocityRot * math.atan(lookDir.z, lookDir.x) > 0 then
			table.insert(VelocityData[1], playerSpeed)
		else
			table.insert(VelocityData[1], -playerSpeed)
		end
	else
		table.insert(VelocityData[1], 0)
	end
	table.insert(VelocityData[2], velocity.y)
	for index, velocityTable in ipairs(VelocityData) do
		while #velocityTable > Fps * 0.25 do
			table.remove(velocityTable, 1)
		end
	end
	--求めた平均から髪の角度を決定する。
	local hairLimit
	if player.getEquipmentItem(5).getType() == "minecraft:elytra" then
		hairLimit = {{0, 80}, {0, 0}}
	else
		hairLimit = {{0, 80}, {-80, 0}}
	end
	local horizontalAverage = getTableAverage(VelocityData[1])
	local verticalAverage = getTableAverage(VelocityData[2])
	local frontHair = model.Body.Hairs.FrontHair
	local backHair = model.Body.Hairs.BackHair
	if playerAnimation == "FALL_FLYING" then
		frontHair.setRot({(1 -math.max(lookDir.y, 0)) * 80 - math.min(math.max(horizontalAverage * 80 - verticalAverage * 80, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
		backHair.setRot({0, 0, 0})
	elseif playerAnimation == "SWIMMING" then
		frontHair.setRot({(1 -math.max(lookDir.y, 0)) * 80 - math.min(math.max(horizontalAverage * 320 - verticalAverage * 320, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
		backHair.setRot({0, 0, 0})
	else
		if verticalAverage < 0 then
			frontHair.setRot({math.min(math.max(-horizontalAverage * 160 - verticalAverage * 80, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
			backHair.setRot({math.min(math.max(-horizontalAverage * 160 + verticalAverage * 80, hairLimit[2][1]), hairLimit[2][2]), 0, 0})
		else
			frontHair.setRot({math.min(math.max(-horizontalAverage * 160, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
			backHair.setRot({math.min(math.max(-horizontalAverage * 160, hairLimit[2][1]), hairLimit[2][2]), 0, 0})
		end
	end

	--レンダー終了処理
	FpsCountData[2] = FpsCountData[2] + 1
end