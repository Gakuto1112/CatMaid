--設定値
SkinName = "Vinny"

--変数
MeowSound = true --鳴き声を発するかどうか
BellSound = true --ベルを鳴らすかどうか
WegTail = true --尻尾のアニメーションを再生するかどうか
HideArmor = false --防具を非表示にするかどうか
AutoShake = true --自動でブルブルするかどうか
UseSkinName = false --スキン名を使用するかどうか
ShowNameWarning = true --名前表示関する注意を表示するかどうか
WalkDistance = 0 --移動距離（鈴のサウンドに使用）
VelocityYPrev = 0 --前チックのy方向の速度
HealthPercentagePrev = 0 --前チックのHPの割合
MaxHealthPrev = 0 --前チックの最大HP
VelocityData = {{}, {}, {}} --速度データ：1. 横, 2. 縦, 3. 角速度
VelocityAverage = {0, 0, 0} --速度の平均値：1. 横, 2. 縦, 3. 角速度
TickLookRotPrev = 0 --前チックの向いている方向（tick()用）
LookRotPrev = 0 --前チックの向いている方向
Fps = 60 --FPS、初期値60、20刻み
FpsCountData = {0, 0} --FPSを計測するためのデータ：1. tick, 2. render
JumpBellCooldown = 0 --ジャンプした時の鈴の音のクールダウン
FavoriteFood = {"minecraft:cod", "minecraft:salmon", "minecraft:cooked_cod", "minecraft:cooked_salmon"} --食べる時にニッコリさせる食べ物
AnimationCount = 0 --耳のアニメーションのタイミング変数
MeowCount = 300 --鳴き声のカウント
EatCount = 0 --食べ物を食べるカウント
EmotionCount = 0 --エモートカウント
EmotionState = {0, 0, 0} --エモートの内部状態：0. 右目, 1. 左目, 2. 口
WinkCount = 200 --瞬きのカウント
AnimationPrev = "" --前チックのアニメーション
EmoteActionCount = 0 --ニャーと鳴くアクションのカウント
SneakPrev = false --前チックのスニークの状態
SleepSoundCount = 0 --寝る時の音声カウント
SweatCount = 0 --汗のカウント
WardenNearbyPrev = false --前チックにワーデンが近くにいるかどうか
AttackKey = keybind.getRegisteredKeybind("key.attack") --攻撃ボタン
AttackKeyPressedPrev = false --前チックに攻撃ボタンを押していたかどうか
AttackAnimationCount = 0 --飛行時の攻撃モーションのアニメーションのカウンター
HeldItemPrev = {} --前チックに手に持っているアイテム：1. メインハンド, 2. オフハンド
KeyBinds = {} --キーバインドのリスト
AFKCount = 0 --放置時間のカウント
TouchBellCount = -1 --鈴を弄る時に、鈴の音を同期させるためのカウンター
SleepStage = 0 --睡眠のステージ：0. 起きている, 1. うとうと, 2. 立ち寝
SleepStagePrev = 0 --前チックの睡眠のステージ
AwakeAnimationCount = -1 --寝起きアニメーションのカウント
SitDown = false --座っているアニメーションかどうか
SitDownWhenSleepy = false --眠い時に座っていたかどうか
WetCount = 0 --濡れているカウント
WetDropCount = 0 --濡れている時の水滴のパーティクルのカウント
WetBodyShakeCount = 0 --濡れている時に体を震わせた時の水しぶきのパーティクルのカウント
AutoShakeCount = 20 --自動ブルブルまでのカウント
HairRenderLimit = math.ceil(8192 / meta.getRenderLimit()) --髪の描画リミット（処理のスキップ頻度）
HairRenderCount = 0 --髪の描画カウント
ParticleLimit = meta.getParticleLimit() --パーティクル数の制限値
CanPlayCustomSound = meta.getCanHaveCustomSounds() --カスタムサウンドが再生できるかどうか
ActionWheelCount = 0 --アクションホイールでアニメーションするためのカウンター
IsInSettings = false --設定画面にいるかどうか
CameraOffset = 0 --座る時のカメラの位置オフセット

--腕
rightArm = model.Avatar.RightArm
leftArm = model.Avatar.LeftArm
AlternativeRightArm = model.Avatar.Body.AlternativeArm.RightAlternativeArm
AlternativeLeftArm = model.Avatar.Body.AlternativeArm.LeftAlternativeArm

--ケーキ
RightCake = AlternativeRightArm.RightAlternativeArmBottom.RightCake
LeftCake = AlternativeLeftArm.LeftAlternativeArmBottom.LeftCake

--防具パーツ
Helmet = model.Avatar.Head.Helmet.Helmet
HelmetOverlay = model.Avatar.Head.Helmet.HelmetOverlay
Chestplate = {model.Avatar.Body.Chestplate.Chestplate, rightArm.RightChestplate.RightChestplate, leftArm.LeftChestplate.LeftChestplate, AlternativeRightArm.RightAlternativeChestplate.RightAlternativeChestplate, AlternativeRightArm.RightAlternativeArmBottom.RightAlternativeChestplateBottom.RightAlternativeChestplateBottom, AlternativeLeftArm.LeftAlternativeChestplate.LeftAlternativeChestplate, AlternativeLeftArm.LeftAlternativeArmBottom.LeftAlternativeChestplateButtom.LeftAlternativeChestplateBottom}
ChestplateOverlay = {model.Avatar.Body.Chestplate.ChestplateOverlay, rightArm.RightChestplate.RightChestplateOverlay, leftArm.LeftChestplate.LeftChestplateOverlay, AlternativeRightArm.RightAlternativeChestplate.RightAlternativeChestplateOverlay, AlternativeRightArm.RightAlternativeArmBottom.RightAlternativeChestplateBottom.RightAlternativeChestplateOverlayBottom, AlternativeLeftArm.LeftAlternativeChestplate.LeftAlternativeChestplateOverlay, AlternativeLeftArm.LeftAlternativeArmBottom.LeftAlternativeChestplateButtom.LeftAlternativeChestplateOverlayBottom}
Leggings = {model.Avatar.Body.Pants.Pants, model.Avatar.RightLeg.RightPants.RightPants, model.Avatar.LeftLeg.LeftPants.LeftPants}
LeggingsOverlay = {model.Avatar.Body.Pants.PantsOverlay, model.Avatar.RightLeg.RightPants.RightPantsOverlay, model.Avatar.LeftLeg.LeftPants.LeftPantsOverlay}
Boots = {model.Avatar.RightLeg.RightBoots.RightBoots, model.Avatar.LeftLeg.LeftBoots.LeftBoots}
BootsOverlay = {model.Avatar.RightLeg.RightBoots.RightBootsOverlay, model.Avatar.LeftLeg.LeftBoots.LeftBootsOverlay}

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

function playMeow(soundName, volume, pitch)
	--声で発する前提でサウンド再生
	local underwater = player.isUnderwater()
	local playerPos = player.getPos()
	if player.getAir() > 0 or player.getStatusEffect("minecraft:water_breathing") then
		if underwater then
			sound.playSound(soundName, playerPos, {volume * 0.2, pitch})
			sound.playSound("block.bubble_column.upwards_ambient", playerPos, {1, 1})
			for _ = 1, 4 do
				particle.addParticle("minecraft:bubble_column_up", {playerPos.x, playerPos.y + 1.5, playerPos.z, 0, 0, 0})
			end
		else
			sound.playSound(soundName, playerPos, {volume, pitch})
		end
	end
end

function setEmotion(rightEye, leftEye, mouth, count)
	--[[表情ID

		目：0. 通常, 1. ビックリ（ダメージを受けた時）, 2. 疲労（低HPの時）, 3. 目を閉じる（寝ている時やスマイル等）, 4. 不等号の目（><、笛吹く時用）
		口：0. 通常（閉じている）, 1. 開いている（スマイル）

		それぞれ負の数で、前の状態を維持する。

	]]
	if rightEye >= 0 then
		EmotionState[1] = rightEye
	end
	model.Avatar.Head.FaceParts.RightEye.RightEyeBase.setUV{(EmotionState[1] * 3) / 48, 0 / 96}
	model.Avatar.Head.FaceParts.RightEye.RightEyeLight.setUV{(EmotionState[1] * 3) / 48, 3 / 96}
	if leftEye >= 0 then
		EmotionState[2] = leftEye
	end
	model.Avatar.Head.FaceParts.LeftEye.LeftEyeBase.setUV{(EmotionState[2] * 3) / 48, 0 / 96}
	model.Avatar.Head.FaceParts.LeftEye.LeftEyeLight.setUV{(EmotionState[2] * 3) / 48, 3 / 96}
	if mouth >= 0 then
		EmotionState[3] = mouth
	end
	model.Avatar.Head.FaceParts.Mouth.setUV{(EmotionState[3] * 3) / 48, 0 / 96}
	EmotionCount = count
end

function refuseEmotion()
	animation["refuse_emote"].play()
	setEmotion(5, 5, 0, 30)
	EmoteActionCount = 30
	SweatCount = 30
end

function isPlayingEmoteAnimation()
	return animation["right_meow"].isPlaying() or animation["left_meow"].isPlaying() or SweatCount > 0 or animation["shake"].isPlaying() or animation["refuse_emote"].isPlaying()
end

function playBellSound(volume)
	if BellSound then
		local playerPos = player.getPos()
		local volumeCoefficient = 1
		if player.isUnderwater() then
			volumeCoefficient = 0.2
		end
		if CanPlayCustomSound then
			sound.playCustomSound("Bell", playerPos, {volume * volumeCoefficient, 1})
		else
			sound.playSound("minecraft:entity.experience_orb.pickup", playerPos, {volume / 2 * volumeCoefficient, 1.5})
		end
	end
end

function playWetSound()
	if not player.isTouchingWater() and WetCount > 0 then
		sound.playSound("minecraft:entity.cod.flop", player.getPos(), {WetCount / 1200, 1})
	end
end

function canSitDown()
	local velocity = player.getVelocity()
	return player.getAnimation() == "STANDING" and player.isOnGround() and not player.getVehicle() and math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2)) == 0
end

function bodyShake()
	--体をブルブル震えさせる
	sound.playSound("minecraft:entity.wolf.shake", player.getPos(), {1, 1.5})
	animation["shake"].play()
	setEmotion(5, 5, 0, 20)
end

function hasItem(heldItem)
	if heldItem ~= nil then
		if heldItem.getType() == "minecraft:air" then
			return false
		else
			return true
		end
	else
		return false
	end
end

function hasCake(heldItem)
	if heldItem ~= nil then
		if heldItem.getType() == "minecraft:cake" then
			return true
		else
			return false
		end
	else
		return false
	end
end

function setActionWheel(openSettings, wardenNeardy)
	IsInSettings = openSettings
	if IsInSettings then
		--アクションホイール（設定画面）
		--アクション1: 鳴き声の切り替え
		if MeowSound then
			action_wheel.SLOT_1.setTitle("鳴き声：§cオフ§rにする")
			action_wheel.SLOT_1.setColor({0 / 255, 170 / 255, 0 / 255})
			action_wheel.SLOT_1.setHoverColor({85 / 255, 255 / 255, 85 / 255})
		else
			action_wheel.SLOT_1.setTitle("鳴き声：§aオン§rにする")
			action_wheel.SLOT_1.setColor({170 / 255, 0 / 255, 0 / 255})
			action_wheel.SLOT_1.setHoverColor({255 / 255, 85 / 255, 85 / 255})
		end
		action_wheel.SLOT_1.setItem("minecraft:player_head{\"SkullOwner\":\"MHF_Ocelot\"}")
		action_wheel.SLOT_1.setFunction(function()
			if MeowSound then
				action_wheel.SLOT_1.setTitle("鳴き声：§aオン§rにする")
				action_wheel.SLOT_1.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_1.setHoverColor({255 / 255, 85 / 255, 85 / 255})
			else
				action_wheel.SLOT_1.setTitle("鳴き声：§cオフ§rにする")
				action_wheel.SLOT_1.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_1.setHoverColor({85 / 255, 255 / 255, 85 / 255})
			end
			MeowSound = not MeowSound
			ping.setMeowSound(MeowSound)
			data.save("MeowSound", MeowSound)
		end)

		--アクション2： 鈴の音の切り替え
		if BellSound then
			if not CanPlayCustomSound then
				print("カスタムサウンドを再生する権限がありません。鈴の音は代替の音が使用されます。")
			end
			action_wheel.SLOT_2.setTitle("鈴の音：§cオフ§rにする")
			action_wheel.SLOT_2.setColor({0 / 255, 170 / 255, 0 / 255})
			action_wheel.SLOT_2.setHoverColor({85 / 255, 255 / 255, 85 / 255})
		else
			action_wheel.SLOT_2.setTitle("鈴の音：§aオン§rにする")
			action_wheel.SLOT_2.setColor({170 / 255, 0 / 255, 0 / 255})
			action_wheel.SLOT_2.setHoverColor({255 / 255, 85 / 255, 85 / 255})
		end
		action_wheel.SLOT_2.setItem("minecraft:bell")
		action_wheel.SLOT_2.setFunction(function()
			if BellSound then
				action_wheel.SLOT_2.setTitle("鈴の音：§aオン§rにする")
				action_wheel.SLOT_2.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_2.setHoverColor({255 / 255, 85 / 255, 85 / 255})
			else
				if not CanPlayCustomSound then
					print("カスタムサウンドを再生する権限がありません。鈴の音は代替の音が使用されます。")
				end
				action_wheel.SLOT_2.setTitle("鈴の音：§cオフ§rにする")
				action_wheel.SLOT_2.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_2.setHoverColor({85 / 255, 255 / 255, 85 / 255})
				end
			BellSound = not BellSound
			ping.setBellSound(BellSound)
			data.save("BellSound", BellSound)
		end)

		--アクション3： 尻尾のアニメーションの切り替え
		if WegTail then
			action_wheel.SLOT_3.setTitle("尻尾振り：§cオフ§rにする")
			action_wheel.SLOT_3.setColor({0 / 255, 170 / 255, 0 / 255})
			action_wheel.SLOT_3.setHoverColor({85 / 255, 255 / 255, 85 / 255})
		else
			action_wheel.SLOT_3.setTitle("尻尾振り：§aオン§rにする")
			action_wheel.SLOT_3.setColor({170 / 255, 0 / 255, 0 / 255})
			action_wheel.SLOT_3.setHoverColor({255 / 255, 85 / 255, 85 / 255})
		end
		action_wheel.SLOT_3.setItem("minecraft:feather")
		action_wheel.SLOT_3.setFunction(function()
			if WegTail then
				action_wheel.SLOT_3.setTitle("尻尾振り：§aオン§rにする")
				action_wheel.SLOT_3.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_3.setHoverColor({255 / 255, 85 / 255, 85 / 255})
			else
				action_wheel.SLOT_3.setTitle("尻尾振り：§cオフ§rにする")
				action_wheel.SLOT_3.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_3.setHoverColor({85 / 255, 255 / 255, 85 / 255})
			end
			WegTail = not WegTail
			ping.setWegTail(WegTail)
			data.save("WegTail", WegTail)
		end)

		--アクション4: 防具の表示/非表示
		if HideArmor then
			action_wheel.SLOT_4.setTitle("防具：§a表示§rする")
			action_wheel.SLOT_4.setColor({170 / 255, 0 / 255, 0 / 255})
			action_wheel.SLOT_4.setHoverColor({255 / 255, 85 / 255, 85 / 255})
		else
			action_wheel.SLOT_4.setTitle("防具：§c非表示§rにする")
			action_wheel.SLOT_4.setColor({0 / 255, 170 / 255, 0 / 255})
			action_wheel.SLOT_4.setHoverColor({85 / 255, 255 / 255, 85 / 255})
		end
		action_wheel.SLOT_4.setItem("minecraft:iron_chestplate")
		action_wheel.SLOT_4.setFunction(function()
			if HideArmor then
				action_wheel.SLOT_4.setTitle("防具：§c非表示§rにする")
				action_wheel.SLOT_4.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_4.setHoverColor({85 / 255, 255 / 255, 85 / 255})
			else
				action_wheel.SLOT_4.setTitle("防具：§a表示§rする")
				action_wheel.SLOT_4.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_4.setHoverColor({255 / 255, 85 / 255, 85 / 255})
			end
			HideArmor = not HideArmor
			ping.setHideArmor(HideArmor)
			data.save("HideArmor", HideArmor)
		end)

		--アクションバー5: 自動ブルブル
		if AutoShake then
			action_wheel.SLOT_5.setTitle("自動ブルブル：§cオフ§rにする")
			action_wheel.SLOT_5.setColor({0 / 255, 170 / 255, 0 / 255})
			action_wheel.SLOT_5.setHoverColor({85 / 255, 255 / 255, 85 / 255})
		else
			action_wheel.SLOT_5.setTitle("自動ブルブル：§aオン§rにする")
			action_wheel.SLOT_5.setColor({170 / 255, 0 / 255, 0 / 255})
			action_wheel.SLOT_5.setHoverColor({255 / 255, 85 / 255, 85 / 255})
		end
		action_wheel.SLOT_5.setItem("minecraft:water_bucket")
		action_wheel.SLOT_5.setFunction(function()
			if AutoShake then
				action_wheel.SLOT_5.setTitle("自動ブルブル：§aオン§rにする")
				action_wheel.SLOT_5.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_5.setHoverColor({255 / 255, 85 / 255, 85 / 255})
			else
				action_wheel.SLOT_5.setTitle("自動ブルブル：§cオフ§rにする")
				action_wheel.SLOT_5.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_5.setHoverColor({85 / 255, 255 / 255, 85 / 255})
			end
			AutoShake = not AutoShake
			ping.setAutoShake(AutoShake)
			data.save("AutoShake", AutoShake)
		end)

		--アクションバー6: 名前の変更（スキン名を使用するかどうか）
		if SkinName ~= "" then
			if UseSkinName then
				action_wheel.SLOT_6.setTitle("名前：§cプレイヤー名§rにする")
				action_wheel.SLOT_6.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_6.setHoverColor({85 / 255, 255 / 255, 85 / 255})
			else
				action_wheel.SLOT_6.setTitle("名前：§aスキン名§rにする")
				action_wheel.SLOT_6.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_6.setHoverColor({255 / 255, 85 / 255, 85 / 255})
			end
			action_wheel.SLOT_6.setItem("minecraft:name_tag")
			action_wheel.SLOT_6.setFunction(function()
			local playerName = player.getName()
			if UseSkinName then
				action_wheel.SLOT_6.setTitle("名前：§aスキン名§rにする")
				action_wheel.SLOT_6.setColor({170 / 255, 0 / 255, 0 / 255})
				action_wheel.SLOT_6.setHoverColor({255 / 255, 85 / 255, 85 / 255})
				print("あなたは§a"..playerName.."§rと表示されます。")
			else
				action_wheel.SLOT_6.setTitle("名前：§aプレイヤー名§rにする")
				action_wheel.SLOT_6.setColor({0 / 255, 170 / 255, 0 / 255})
				action_wheel.SLOT_6.setHoverColor({85 / 255, 255 / 255, 85 / 255})
				print("あなたは§a"..SkinName.."§rと表示されます。")
				if ShowNameWarning then
					print("[§c注意§r] この名前（§a"..SkinName.."§r）はFiguraを導入しているかつ、あなたの信用度を§eTrusted§r以上に設定しているプレイヤーのみに表示されます。それ以外のプレイヤーには通常通り§a"..playerName.."§rと表示されます。また、サーバー側にはこの名前（§a"..SkinName.."§r）は反映されません。§7このメッセージは再び表示されません。")
					ShowNameWarning = false
					data.save("ShowNameWarning", ShowNameWarning)
				end
			end
			UseSkinName = not UseSkinName
			ping.setUseSkinName(UseSkinName)
			data.save("UseSkinName", UseSkinName)
			end)
		else
			action_wheel.SLOT_6.setFunction()
			UseSkinName = false
		end

		--アクション8：設定を閉じる
		action_wheel.SLOT_8.setTitle("閉じる（クリック）")
		action_wheel.SLOT_8.setItem("minecraft:barrier")
		action_wheel.SLOT_8.setColor({200 / 255, 200 / 255, 200 / 255})
		action_wheel.SLOT_8.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		action_wheel.SLOT_8.setFunction(function()
			setActionWheel(false, player.getStatusEffect("minecraft:darkness"))
		end)

		--未使用のアクション
		for _, unusedAction in ipairs({action_wheel.SLOT_7}) do
			unusedAction.setTitle()
			unusedAction.setItem()
			unusedAction.setColor()
			unusedAction.setHoverColor()
			unusedAction.setFunction()
		end
	else
		--アクションホイール（一般）
		--アクション1： 「ニャー」と鳴く（ネコのサウンド再生、スマイル）。
		if wardenNeardy then
			action_wheel.SLOT_1.setTitle("§7「ニャー」と鳴く（スマイル）")
			action_wheel.SLOT_1.setColor({21 / 255, 21 / 255, 21 / 255})
			action_wheel.SLOT_1.setHoverColor({0 / 255, 0 / 255, 0 / 255})
		else
			action_wheel.SLOT_1.setTitle("「ニャー」と鳴く（スマイル）")
			action_wheel.SLOT_1.setColor({255 / 255, 85 / 255, 255 / 255})
			action_wheel.SLOT_1.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		end
		action_wheel.SLOT_1.setTexture("Custom")
		action_wheel.SLOT_1.setTextureScale({0.1, 0.06875})
		action_wheel.SLOT_1.setFunction(function()
			ping.meow(0)
		end)

		--アクション2： 「ニャー」と鳴く（ネコのサウンド再生、ウィンク）。
		if wardenNeardy then
			action_wheel.SLOT_2.setTitle("§7「ニャー」と鳴く（ウィンク）")
			action_wheel.SLOT_2.setColor({21 / 255, 21 / 255, 21 / 255})
			action_wheel.SLOT_2.setHoverColor({0 / 255, 0 / 255, 0 / 255})
		else
			action_wheel.SLOT_2.setTitle("「ニャー」と鳴く（ウィンク）")
			action_wheel.SLOT_2.setColor({255 / 255, 85 / 255, 255 / 255})
			action_wheel.SLOT_2.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		end
		action_wheel.SLOT_2.setTexture("Custom")
		action_wheel.SLOT_2.setTextureScale({0.1, 0.06875})
		action_wheel.SLOT_2.setFunction(function()
			ping.meow(1)
		end)

		--アクション3：ビックリする
		if wardenNeardy then
			action_wheel.SLOT_3.setTitle("§7ビックリする")
			action_wheel.SLOT_3.setColor({21 / 255, 21 / 255, 21 / 255})
			action_wheel.SLOT_3.setHoverColor({0 / 255, 0 / 255, 0 / 255})
		else
			action_wheel.SLOT_3.setTitle("ビックリする")
			action_wheel.SLOT_3.setColor({255 / 255, 85 / 255, 255 / 255})
			action_wheel.SLOT_3.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		end
		action_wheel.SLOT_3.setTexture("Custom")
		action_wheel.SLOT_3.setTextureScale({0.1, 0.06875})
		action_wheel.SLOT_3.setFunction(function()
			ping.surprise()
		end)

		--アクション4：座る
		if wardenNeardy then
			action_wheel.SLOT_4.setTitle("§7おすわり")
			action_wheel.SLOT_4.setColor({21 / 255, 21 / 255, 21 / 255})
			action_wheel.SLOT_4.setHoverColor({0 / 255, 0 / 255, 0 / 255})
		else
			action_wheel.SLOT_4.setTitle("おすわり")
			action_wheel.SLOT_4.setColor({255 / 255, 85 / 255, 255 / 255})
			action_wheel.SLOT_4.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		end
		action_wheel.SLOT_4.setItem("minecraft:oak_stairs")
		action_wheel.SLOT_4.setFunction(function()
			ping.sitDown()
		end)

		--アクション5：体をブルブル振る
		if wardenNeardy then
			action_wheel.SLOT_5.setTitle("§7ブルブル")
			action_wheel.SLOT_5.setColor({21 / 255, 21 / 255, 21 / 255})
			action_wheel.SLOT_5.setHoverColor({0 / 255, 0 / 255, 0 / 255})
		else
			action_wheel.SLOT_5.setTitle("ブルブル")
			action_wheel.SLOT_5.setColor({255 / 255, 85 / 255, 255 / 255})
			action_wheel.SLOT_5.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		end
		action_wheel.SLOT_5.setItem("minecraft:water_bucket")
		action_wheel.SLOT_5.setFunction(function()
			ping.bodyShake()
		end)

		--アクション8：設定を開く
		action_wheel.SLOT_8.setTitle("設定（クリック）")
		action_wheel.SLOT_8.setItem("minecraft:comparator")
		action_wheel.SLOT_8.setColor({200 / 255, 200 / 255, 200 / 255})
		action_wheel.SLOT_8.setHoverColor({255 / 255, 255 / 255, 255 / 255})
		action_wheel.SLOT_8.setFunction(function()
			setActionWheel(true, player.getStatusEffect("minecraft:darkness"))
		end)

		--未使用のアクション
		for _, unusedAction in ipairs({action_wheel.SLOT_6, action_wheel.SLOT_7}) do
			unusedAction.setTitle()
			unusedAction.setItem()
			unusedAction.setColor()
			unusedAction.setHoverColor()
			unusedAction.setFunction()
		end
	end
end

--ping関数
function ping.setMeowSound(boolToSet)
	MeowSound = boolToSet
end

function ping.setBellSound(boolToSet)
	BellSound = boolToSet
end

function ping.setWegTail(boolToSet)
	WegTail = boolToSet
	if WegTail then
		animation["wag_tail"].play()
	else
		animation["wag_tail"].stop()
	end
end

function ping.setHideArmor(boolToSet)
	HideArmor = boolToSet
end

function ping.setAutoShake(boolToSet)
	AutoShake = boolToSet
end

function ping.setUseSkinName(boolToSet)
	UseSkinName = boolToSet
	if UseSkinName then
		for _, namePlate in pairs(nameplate) do
			namePlate.setText(SkinName)
		end
	else
		for _, namePlate in pairs(nameplate) do
			namePlate.setText(player.getName())
		end
	end
end

function ping.punch()
	AttackAnimationCount = 6
end

function ping.meow(emotionType)
	if not isPlayingEmoteAnimation() then
		local gamemode = player.getGamemode()
		local playerPos = player.getPos()
		local tired = (player.getHealthPercentage() <= 0.2 or player.getFood() <= 6) and (gamemode == "SURVIVAL" or gamemode == "ADVENTURE")
		if player.getStatusEffect("minecraft:darkness") then
			refuseEmotion()
		else
			if tired then
				playMeow("minecraft:entity.cat.stray_ambient", 1, 1.5)
			else
				playMeow("minecraft:entity.cat.ambient", 1, 1.5)
			end
			particle.addParticle("minecraft:heart", {playerPos.x, playerPos.y + 2, playerPos.z, 0, 0, 0})
			if player.isLeftHanded() then
				animation["left_meow"].play()
				if emotionType == 1 then
					if tired then
						setEmotion(4, 2, 1, 20)
					else
						setEmotion(4, 0, 1, 20)
					end
				end
			else
				animation["right_meow"].play()
				if emotionType == 1 then
					if tired then
						setEmotion(2, 4, 1, 20)
					else
						setEmotion(0, 4, 1, 20)
					end
				end
			end
			if emotionType == 0 then
				setEmotion(4, 4, 1, 20)
			end
			EmoteActionCount = 20
		end
	end
end

function ping.surprise()
	if not isPlayingEmoteAnimation() then
		if player.getStatusEffect("minecraft:darkness") then
			refuseEmotion()
		else
			playMeow("minecraft:entity.cat.hurt", 1, 1.5)
			setEmotion(1, 1, 0, 20)
			EmoteActionCount = 20
			SweatCount = 20
		end
	end
end

function ping.sitDown()
	if player.getStatusEffect("minecraft:darkness") then
		refuseEmotion()
	elseif canSitDown() then
		if SitDown then
			animation["stand_up"].play()
			animation["sit_down"].stop()
		else
			animation["sit_down"].play()
			animation["stand_up"].stop()
		end
		playBellSound(0.5)
		playWetSound()
		SitDown = not SitDown
	end
end

function ping.bodyShake()
	if not isPlayingEmoteAnimation() then
		if player.getStatusEffect("minecraft:darkness") then
			refuseEmotion()
		else
			bodyShake()
			if WetCount > 0 and not player.isWet() then
				WetBodyShakeCount = 20
				WetCount = 20
			end
			EmoteActionCount = 20
		end
	end
end

function ping.touchBell()
	local mainHeldItem = player.getHeldItem(1)
	local offHeldItem = player.getHeldItem(2)
	local leftHanded = player.isLeftHanded()
	if hasItem(mainHeldItem) ~= hasItem(offHeldItem) then
		if (hasCake(mainHeldItem) and not leftHanded) or (hasItem(offHeldItem) and leftHanded) then
			leftArm.setEnabled(false)
			AlternativeLeftArm.setEnabled(true)
			animation["afk_left_bell"].play()
		else
			rightArm.setEnabled(false)
			AlternativeRightArm.setEnabled(true)
			animation["afk_right_bell"].play()
		end
		TouchBellCount = 0
	else
		if not leftHanded and not hasCake(mainHeldItem) then
			rightArm.setEnabled(false)
			AlternativeRightArm.setEnabled(true)
			animation["afk_right_bell"].play()
			TouchBellCount = 0
		elseif leftHanded and not hasCake(mainHeldItem) then
			leftArm.setEnabled(false)
			AlternativeLeftArm.setEnabled(true)
			animation["afk_left_bell"].play()
			TouchBellCount = 0
		end
	end
end

function ping.stopTouchBell()
	if animation["afk_right_bell"].isPlaying() then
		animation["afk_right_bell"].stop()
		rightArm.setEnabled(true)
		AlternativeRightArm.setEnabled(false)
	elseif animation["afk_left_bell"].isPlaying() then
		animation["afk_left_bell"].stop()
		leftArm.setEnabled(true)
		AlternativeLeftArm.setEnabled(false)
	end
	TouchBellCount = -1
end

function ping.sleepy()
	animation["afk_sleepy"].play()
	SleepStage = 1
end

function ping.sleep()
	animation["afk_sleep"].play()
	SleepStage = 2
end

function ping.backFromAFK()
	local mainHeldItem = player.getHeldItem(1)
	local offHeldItem = player.getHeldItem(2)
	local leftHanded = player.isLeftHanded()
	if not player.getStatusEffect("minecraft:darkness") then
		if (not hasCake(mainHeldItem) and not leftHanded) or (not hasCake(offHeldItem) and leftHanded) then
			rightArm.setEnabled(true)
			AlternativeRightArm.setEnabled(false)
		end
		if (not hasCake(offHeldItem) and not leftHanded) or (not hasCake(mainHeldItem) and leftHanded) then
			leftArm.setEnabled(true)
			AlternativeLeftArm.setEnabled(false)
		end
	end
	animation["afk_right_bell"].stop()
	animation["afk_left_bell"].stop()
	animation["afk_sleepy"].stop()
	animation["afk_sleep"].stop()
	if SleepStage ~= 0 then
		AwakeAnimationCount = 30
		SleepStage = 0
	end
end

--設定の読み込み
MeowSound = loadBoolean(MeowSound, "MeowSound")
ping.setMeowSound(MeowSound)
BellSound = loadBoolean(BellSound, "BellSound")
ping.setBellSound(BellSound)
WegTail = loadBoolean(WegTail, "WegTail")
ping.setWegTail(WegTail)
HideArmor = loadBoolean(HideArmor, "HideArmor")
ping.setHideArmor(HideArmor)
AutoShake = loadBoolean(AutoShake, "AutoShake")
ping.setAutoShake(AutoShake)
UseSkinName = loadBoolean(UseSkinName, "UseSkinName")
ping.setUseSkinName(UseSkinName)
ShowNameWarning = loadBoolean(ShowNameWarning, "ShowNameWarning")

--全てのキーのキーバインドの取得
for _, keyName in ipairs(keybind.getRegisteredKeyList()) do
	table.insert(KeyBinds, keybind.getRegisteredKeybind(keyName))
end

--デフォルトのプレイヤーモデルの非表示
for _, vanillaModel in pairs(vanilla_model) do
	vanillaModel.setEnabled(false)
end

--代替の腕の非表示
AlternativeRightArm.setEnabled(false)
AlternativeLeftArm.setEnabled(false)

--バニラ防具の非表示
armor_model.HELMET.setEnabled(false)
armor_model.CHESTPLATE.setEnabled(false)
armor_model.LEGGINGS.setEnabled(false)
armor_model.BOOTS.setEnabled(false)

--テクスチャサイズの変更とテクスチャの設定
model.Avatar.Head.FaceParts.RightEye.setTextureSize({48, 96})
model.Avatar.Head.FaceParts.LeftEye.setTextureSize({48, 96})
model.Avatar.Head.FaceParts.Mouth.setTextureSize({48, 96})
Helmet.setTextureSize({64, 32})
HelmetOverlay.setTextureSize({64, 32})
HelmetOverlay.setTexture("Resource", "minecraft:textures/models/armor/leather_layer_1_overlay.png")
for index, chestplatePart in ipairs(Chestplate) do
	chestplatePart.setTextureSize({64, 32})
	ChestplateOverlay[index].setTextureSize({64, 32})
	ChestplateOverlay[index].setTexture("Resource", "minecraft:textures/models/armor/leather_layer_1_overlay.png")
end
for index, legginsPart in ipairs(Leggings) do
	legginsPart.setTextureSize({64, 32})
	LeggingsOverlay[index].setTextureSize({64, 32})
	LeggingsOverlay[index].setTexture("Resource", "minecraft:textures/models/armor/leather_layer_2_overlay.png")
end
for index, bootsPart in ipairs(Boots) do
	bootsPart.setTextureSize({64, 32})
	BootsOverlay[index].setTextureSize({64, 32})
	BootsOverlay[index].setTexture("Resource", "minecraft:textures/models/armor/leather_layer_1_overlay.png")
end
for _, cakePlatePart in ipairs({RightCake.RightCakePlate, LeftCake.LeftCakePlate}) do
	cakePlatePart.setTextureSize({16, 16})
	cakePlatePart.setTexture("Resource", "minecraft:textures/block/spruce_planks.png")
end
for _, cakePart in ipairs({RightCake, LeftCake}) do
	cakePart.Cake.setTextureSize({48, 96})
	cakePart.setEnabled(false)
	cakePart.setEnabled(false)
end

--パーツのUVの再設定
for _, part in ipairs({AlternativeRightArm.RightAlternativeArm, AlternativeRightArm.RightAlternativeArmLayer, AlternativeLeftArm.LeftAlternativeArm, AlternativeLeftArm.LeftAlternativeArmLayer, Chestplate[4], ChestplateOverlay[4], Chestplate[6], ChestplateOverlay[6]}) do
	local downUVData = part.getUVData("DOWN")
	part.setUVData("DOWN", {downUVData.x - downUVData.z - 4, 0, downUVData.z, 4})
end
for _, part in ipairs({AlternativeRightArm.RightAlternativeArmBottom.RightAlternativeArmBottom, AlternativeRightArm.RightAlternativeArmBottom.RightAlternativeArmLayerBottom, AlternativeLeftArm.LeftAlternativeArmBottom.LeftAlternativeArmBottom, AlternativeLeftArm.LeftAlternativeArmBottom.LeftAlternativeArmLayerBottom, Chestplate[5], ChestplateOverlay[5], Chestplate[7], ChestplateOverlay[7]}) do
	local upUVData = part.getUVData("UP")
	local downUVData = part.getUVData("DOWN")
	part.setUVData("UP", {upUVData.x - upUVData.z, upUVData.y - 6, downUVData.z, 4})
	part.setUVData("DOWN", {downUVData.x - downUVData.z - 4, downUVData.y - 6, downUVData.z, 4})
end

--望遠鏡の調整
spyglass_model.RIGHT_SPYGLASS.setPos({-0.5, 1.5, 0})
spyglass_model.LEFT_SPYGLASS.setPos({0.5, 1.5, 0})

--アクションホイール
setActionWheel(false, false)

function tick()
	--[[鈴の音

		- xz平面上を1.8m移動する毎に再生する。
		- ジャンプした時など（前チックのy方向の移動方向が0以下かつ、現在のy方向の移動方向が0より大きい）も再生する。
		- スニーキング時、水中にいる時は音量5分の1（スニークでジャンプした時は通常の音量）。
		- ウォーデンが近くにいる時は、音量10分の1（鈴を押さえて音が出ないようにしている）。
		- 乗り物に乗っている時、滑空時、非接地時は再生しない。

	]]
	local velocity = player.getVelocity()
	local playerSpeed = math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2))
	local playerPos = player.getPos()
	local underwater = player.isUnderwater()
	local wardenNearby = player.getStatusEffect("minecraft:darkness")
	local sneaking = player.isSneaking()
	local onGround = player.isOnGround()
	WalkDistance = WalkDistance + playerSpeed
	if WalkDistance >= 1.8 then
		if not player.getVehicle() and player.getAnimation() ~= "FALL_FLYING" and onGround then
			if wardenNearby then
				playBellSound(0.05)
			elseif sneaking then
				playBellSound(0.1)
			else
				playBellSound(0.5)
			end
			playWetSound()
		end
		WalkDistance = 0
	end
	if VelocityYPrev <= 0 and velocity.y > 0 and JumpBellCooldown == 0 then
		if wardenNearby then
			playBellSound(0.05)
		else
			playBellSound(0.5)
		end
		playWetSound()
		JumpBellCooldown = 10
	end

	--耳のアニメーション
	local leftHanded = player.isLeftHanded()
	if AnimationCount == 300 then
		if leftHanded then
			animation["left_ear_bend"].play()
		else
			animation["right_ear_bend"].play()
		end
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
	local tired = false
	local playerAnimation = player.getAnimation()
	local rightEar = model.Avatar.Head.Ears.RightEar
	local leftEar = model.Avatar.Head.Ears.LeftEar
	local tail1 = model.Avatar.Body.Tail
	local tail2 = model.Avatar.Body.Tail.Tail1.Tail2
	if WetCount > 0 then
		rightEar.setRot({-30, 0, 0})
		leftEar.setRot({-30, 0, 0})
	end
	if (healthPercentage > 0.5 and foodPercentage > 0.5) or gamemode == "CREATIVE" or gamemode == "SPECTATOR" then
		if WetCount == 0 then
			rightEar.setRot({0, 0, 0})
			leftEar.setRot({0, 0, 0})
		end
		tail1.setRot({0, 0, 0})
		tail2.setRot({0, 0, 0})
		animation["wag_tail"].setSpeed(1)
		if EmotionCount == 0 then
			setEmotion(0, 0, 0, 0)
		end
	elseif healthPercentage > 0.2 and foodPercentage > 0.3 then
		if WetCount == 0 then
			rightEar.setRot({-15, 0, 0})
			leftEar.setRot({-15, 0, 0})
		end
		if playerAnimation ~= "SLEEPING" then
			tail1.setRot({40, 0, 0})
			tail2.setRot({-15, 0, 0})
		end
		animation["wag_tail"].setSpeed(0.75)
		if EmotionCount == 0 then
			setEmotion(0, 0, 0, 0)
		end
	else
		rightEar.setRot({-30, 0, 0})
		leftEar.setRot({-30, 0, 0})
		if playerAnimation ~= "SLEEPING" then
			tail1.setRot({90, 0, 0})
			tail2.setRot({0, 0, 0})
		end
		animation["wag_tail"].setSpeed(0.5)
		if EmotionCount == 0 then
			setEmotion(2, 2, 0, 0)
		end
		tired = true
	end

	--被ダメージ時、猫のサウンド再生
	local maxHealth = player.getMaxHealth()
	local air = player.getAir()
	local damageTaken = 0
	if healthPercentage < HealthPercentagePrev and healthPercentage > 0 and maxHealth == MaxHealthPrev then
		if air > 0 and not wardenNearby then
			playMeow("minecraft:entity.cat.hurt", 1, 1.5)
		end
		setEmotion(1, 1, 0, 8)
		damageTaken = 1
	end
	if player.getDeathTime() == 1 and air > 0 then
		if air > 0 then
			playMeow("minecraft:entity.ocelot.death", 1, 1.5)
		end
		setEmotion(1, 1, 0, 20)
		damageTaken = 2
	end

	--スニーク時にスカートをずらす
	local skirt = model.Avatar.Body.Skirt
	if SneakPrev and not player.isFlying() then
		skirt.setRot({15, 0, 0})
	else
		skirt.setRot({0, 0, 0})
	end

	--腕の基準点の調整
	if animation["shake"].isPlaying() then
		if SitDown then
			rightArm.setPos({-0.2, -1.1, 1})
			leftArm.setPos({0.2, -1.1, 1})
		else
			rightArm.setPos({0, 0, 0})
			leftArm.setPos({0, 0, 0})
		end
		rightArm.setPivot({-5.5, 0, 0})
		leftArm.setPivot({5.5, 0, 0})
	else
		rightArm.setPos({0, 0, 0})
		leftArm.setPos({0, 0, 0})
		rightArm.setPivot({0.5, 0, 0})
		leftArm.setPivot({-0.5, 0, 0})
	end

	--お座りアニメーションの自動解除
	if not canSitDown() and SitDown then
		animation["stand_up"].play()
		animation["sit_down"].stop()
		SitDown = false
	end

	--ウォーデンが近くにいる時（≒暗闇デバフを受けている時）、怯える。
	local mainHeldItem = player.getHeldItem(1)
	local offHeldItem = player.getHeldItem(2)
	if wardenNearby and playerAnimation ~= "SLEEPING" then
		if EmotionCount == 0 then
			setEmotion(1, 1, 0, 0)
		end
		if AttackAnimationCount > 0 then
			if leftHanded then
				leftArm.setEnabled(true)
				AlternativeLeftArm.setEnabled(false)
			else
				rightArm.setEnabled(true)
				AlternativeRightArm.setEnabled(false)
			end
		elseif mainHeldItem ~= nil then
			local mainHeldItemType = mainHeldItem.getType()
			if mainHeldItemType == "minecraft:cake" then
				if leftHanded then
					animation["left_hide_bell"].stop()
				else
					animation["right_hide_bell"].stop()
				end
			elseif mainHeldItemType ~= "minecraft:air" then
				if leftHanded then
					leftArm.setEnabled(true)
					AlternativeLeftArm.setEnabled(false)
				else
					rightArm.setEnabled(true)
					AlternativeRightArm.setEnabled(false)
				end
			else
				if leftHanded then
					leftArm.setEnabled(false)
					AlternativeLeftArm.setEnabled(true)
				else
					rightArm.setEnabled(false)
					AlternativeRightArm.setEnabled(true)
				end
			end
		else
			if leftHanded then
				leftArm.setEnabled(false)
				AlternativeLeftArm.setEnabled(true)
			else
				rightArm.setEnabled(false)
				AlternativeRightArm.setEnabled(true)
			end
		end
		if not WardenNearbyPrev or AnimationPrev == "SLEEPING" then
			setActionWheel(IsInSettings, wardenNearby)
			animation["afraid"].play()
			animation["right_hide_bell"].play()
			animation["left_hide_bell"].play()
		end
		if offHeldItem ~= nil then
			local offHeldItemType = offHeldItem.getType()
			if offHeldItemType == "minecraft:cake" then
				if leftHanded then
					animation["right_hide_bell"].stop()
				else
					animation["left_hide_bell"].stop()
				end
			elseif offHeldItemType ~= "minecraft:air" then
				if leftHanded then
					rightArm.setEnabled(true)
					AlternativeRightArm.setEnabled(false)
				else
					leftArm.setEnabled(true)
					AlternativeLeftArm.setEnabled(false)
				end
			else
				if leftHanded then
					rightArm.setEnabled(false)
					AlternativeRightArm.setEnabled(true)
				else
					leftArm.setEnabled(false)
					AlternativeLeftArm.setEnabled(true)
				end
			end
		else
			if leftHanded then
				rightArm.setEnabled(false)
				AlternativeRightArm.setEnabled(true)
			else
				leftArm.setEnabled(false)
				AlternativeLeftArm.setEnabled(true)
			end
		end
	elseif WardenNearbyPrev then
		setActionWheel(IsInSettings, wardenNearby)
		rightArm.setEnabled(true)
		leftArm.setEnabled(true)
		AlternativeRightArm.setEnabled(false)
		AlternativeLeftArm.setEnabled(false)
		animation["afraid"].stop()
		animation["right_hide_bell"].stop()
		animation["left_hide_bell"].stop()
	end

	--アクションホイールのテクスチャ設定
	local function setActionWheelTexture(actionSlot, id)
		actionSlot.setUV({(id % 2) * 16 + 56, math.floor(id / 2) * 22 + 124}, {16, 22}, {96, 192})
	end
	if not IsInSettings then
		if wardenNearby then
			if not WardenNearbyPrev then
				setActionWheelTexture(action_wheel.SLOT_1, 1)
				setActionWheelTexture(action_wheel.SLOT_2, 1)
				setActionWheelTexture(action_wheel.SLOT_3, 1)
			end
		else
			if ActionWheelCount < 20 then
				setActionWheelTexture(action_wheel.SLOT_1, 0)
				setActionWheelTexture(action_wheel.SLOT_2, 0)
				setActionWheelTexture(action_wheel.SLOT_3, 0)
			else
				setActionWheelTexture(action_wheel.SLOT_1, 2)
				setActionWheelTexture(action_wheel.SLOT_2, 3)
				setActionWheelTexture(action_wheel.SLOT_3, 4)
			end
		end
	else
		action_wheel.SLOT_1.setTexture()
		action_wheel.SLOT_2.setTexture()
		action_wheel.SLOT_3.setTexture()
	end

	--ケーキの持ち方
	if playerAnimation ~= "SLEEPING" and playerAnimation ~= "SWIMMING" and playerAnimation ~= "FALL_FLYING" then
		if (hasCake(mainHeldItem) and not leftHanded) or (hasCake(offHeldItem) and leftHanded) then
			rightArm.setEnabled(false)
			AlternativeRightArm.setEnabled(true)
			RightCake.setEnabled(true)
			if leftHanded then
				if offHeldItem ~= nil then
					if offHeldItem.hasGlint() then
						RightCake.Cake.setShader("Glint")
					else
						RightCake.Cake.setShader("None")
					end
				else
					RightCake.Cake.setShader("None")
				end
			else
				if mainHeldItem ~= nil then
					if mainHeldItem.hasGlint() then
						RightCake.Cake.setShader("Glint")
					else
						RightCake.Cake.setShader("None")
					end
				else
					RightCake.Cake.setShader("None")
				end
			end
			local initialHold = (not hasCake(HeldItemPrev[1]) and not leftHanded) or (not hasCake(HeldItemPrev[2]) and leftHanded)
			if initialHold or AnimationPrev == "SLEEPING" or AnimationPrev == "SWIMMING" or AnimationPrev == "FALL_FLYING" then
				if initialHold then
					local cakeRandom = math.random()
					if cakeRandom >= 0.99 then
						local cakePos = RightCake.Cake.partToWorldPos({-6, -6, 4})
						RightCake.Cake.setUV({0 / 48, 22 / 96})
						for _ = 0, 29 do
							particle.addParticle("minecraft:smoke", {cakePos.x + math.random() * 0.5 - 0.25, cakePos.y, cakePos.z + math.random() * 0.5 - 0.25, 0, 0, 0})
						end
						sound.playSound("minecraft:block.lava.extinguish", playerPos, {1, 1})
						if not wardenNearby then
							setEmotion(1, 1, 0, 20)
						end
					elseif cakeRandom >= 0.95 then
						RightCake.Cake.setUV({0 / 48, 11 / 96})
						if not wardenNearby then
							if player.getAir() >= 0 or player.getStatusEffect("minecraft:water_breathing") then
								if tired then
									playMeow("minecraft:entity.cat.stray_ambient", 1, 1.5)
								else
									playMeow("minecraft:entity.cat.ambient", 1, 1.5)
								end
								EmoteActionCount = 20
							end
							setEmotion(4, 4, 1, 20)
						end
					else
						RightCake.Cake.setUV({0 / 48, 0 / 96})
					end
				end
				held_item_model.RIGHT_HAND.setEnabled(false)
				animation["afk_right_bell"].stop()
				animation["right_cake"].play()
			end
		else
			RightCake.setEnabled(false)
			if wardenNearby then
				if (hasCake(HeldItemPrev[1]) and not leftHanded) or (hasCake(HeldItemPrev[2]) and leftHanded) then
					held_item_model.RIGHT_HAND.setEnabled(true)
					animation["right_cake"].stop()
					animation["right_hide_bell"].play()
				end
			else
				if (hasCake(HeldItemPrev[1]) and not leftHanded) or (hasCake(HeldItemPrev[2]) and leftHanded) then
					rightArm.setEnabled(true)
					AlternativeRightArm.setEnabled(false)
					held_item_model.RIGHT_HAND.setEnabled(true)
					animation["right_cake"].stop()
				end
			end
		end
		if (hasCake(offHeldItem) and not leftHanded) or (hasCake(mainHeldItem) and leftHanded) then
			leftArm.setEnabled(false)
			AlternativeLeftArm.setEnabled(true)
			LeftCake.setEnabled(true)
			if leftHanded then
				if mainHeldItem ~= nil then
					if mainHeldItem.hasGlint() then
						LeftCake.Cake.setShader("Glint")
					else
						LeftCake.Cake.setShader("None")
					end
				else
					LeftCake.Cake.setShader("None")
				end
			else
				if offHeldItem ~= nil then
					if offHeldItem.hasGlint() then
						LeftCake.Cake.setShader("Glint")
					else
						LeftCake.Cake.setShader("None")
					end
				else
					LeftCake.Cake.setShader("None")
				end
			end
			local initialHold = (not hasCake(HeldItemPrev[2]) and not leftHanded) or (not hasCake(HeldItemPrev[1]) and leftHanded)
			if initialHold or AnimationPrev == "SLEEPING" or AnimationPrev == "SWIMMING" or AnimationPrev == "FALL_FLYING" then
				if initialHold then
					local cakeRandom = math.random()
					if cakeRandom >= 0.99 then
						local cakePos = LeftCake.Cake.partToWorldPos({6, -6, 4})
						LeftCake.Cake.setUV({0 / 48, 22 / 96})
						for _ = 0, 29 do
							particle.addParticle("minecraft:smoke", {cakePos.x + math.random() * 0.5 - 0.25, cakePos.y, cakePos.z + math.random() * 0.5 - 0.25, 0, 0, 0})
						end
						sound.playSound("minecraft:block.lava.extinguish", playerPos, {1, 1})
						if not wardenNearby then
							setEmotion(1, 1, 0, 20)
						end
					elseif cakeRandom >= 0.95 then
						LeftCake.Cake.setUV({0 / 48, 11 / 96})
						if not wardenNearby then
							if player.getAir() >= 0 or player.getStatusEffect("minecraft:water_breathing") then
								if tired then
									playMeow("minecraft:entity.cat.stray_ambient", 1, 1.5)
								else
									playMeow("minecraft:entity.cat.ambient", 1, 1.5)
								end
								EmoteActionCount = 20
							end
							setEmotion(4, 4, 1, 20)
						end
					else
						LeftCake.Cake.setUV({0 / 48, 0 / 96})
					end
				end
				held_item_model.LEFT_HAND.setEnabled(false)
				animation["afk_left_bell"].stop()
				animation["left_cake"].play()
			end
		else
			LeftCake.setEnabled(false)
			if wardenNearby then
				if (hasCake(HeldItemPrev[2]) and not leftHanded) or (hasCake(HeldItemPrev[1]) and leftHanded) then
					held_item_model.LEFT_HAND.setEnabled(true)
					animation["left_cake"].stop()
					animation["left_hide_bell"].play()
				end
			else
				if (hasCake(HeldItemPrev[2]) and not leftHanded) or (hasCake(HeldItemPrev[1]) and leftHanded) then
					leftArm.setEnabled(true)
					AlternativeLeftArm.setEnabled(false)
					held_item_model.LEFT_HAND.setEnabled(true)
					animation["left_cake"].stop()
				end
			end
		end
	else
		rightArm.setEnabled(true)
		AlternativeRightArm.setEnabled(false)
		leftArm.setEnabled(true)
		AlternativeLeftArm.setEnabled(false)
		held_item_model.RIGHT_HAND.setEnabled(true)
		held_item_model.LEFT_HAND.setEnabled(true)
		animation["right_cake"].stop()
		animation["left_cake"].stop()
	end

	--特定のアイテム使用時に片眼を瞑る。
	local closeEyeItems = {"minecraft:bow", "minecraft:trident", "minecraft:spyglass"}
	local usingItem = player.isUsingItem()
	local activeHand = player.getActiveHand()

	local function hasCloseEyeItems(heldItem)
		if heldItem ~= nil then
			for _, item in ipairs(closeEyeItems) do
				if item == heldItem.getType() then
					return true
				end
			end
			return false
		end
		return false
	end

	if ((hasCloseEyeItems(mainHeldItem) and activeHand == "MAIN_HAND" and not leftHanded) or (hasCloseEyeItems(offHeldItem) and activeHand == "OFF_HAND" and leftHanded)) and usingItem and EmotionCount == 0 then
		setEmotion(-1, 4, 0, 0)
	elseif ((hasCloseEyeItems(offHeldItem) and activeHand == "OFF_HAND" and not leftHanded) or (hasCloseEyeItems(mainHeldItem) and activeHand == "MAIN_HAND" and leftHanded)) and usingItem and EmotionCount == 0 then
		setEmotion(4, -1, 0, 0)
	end

	local horn
	local activeItem = player.getActiveItem()
	if activeItem ~= nil then
		local activeItemAction = activeItem.getUseAction()
		if activeItemAction == "EAT" and not wardenNearby then
			--特定の食べ物を食べる時にニッコリさせる。
			local foodFound = false
			for _, food in ipairs(FavoriteFood) do
				if food == activeItem.getType() then
					foodFound = true
					EatCount = EatCount + 1
					if EmotionCount == 0 then
						setEmotion(4, 4, 0, 0)
					end
				end
			end
			if not foodFound then
				EatCount = 0
			end
		else
			EatCount = 0
		end
		if activeItemAction == "TOOT_HORN" then
			setEmotion(5, 5, 0, 0)
			horn = true
		else
			horn = false
		end
	else
		EatCount = 0
		horn = false
	end
	if EatCount == 32 then
		if tired then
			playMeow("minecraft:entity.cat.stray_ambient", 1, 1.5)
		else
			playMeow("minecraft:entity.cat.ambient", 1, 1.5)
		end
		particle.addParticle("minecraft:heart", {playerPos.x, playerPos.y + 2, playerPos.z, 0, 0, 0})
		setEmotion(4, 4, 1, 20)
		EatCount = 0
	end

	--寝ている時に目と閉じる
	if playerAnimation == "SLEEPING" or SleepStage == 2 then
		if SleepSoundCount == 0 then
			sound.playSound("minecraft:entity.cat.purr", playerPos , {1, 1})
			SleepSoundCount = 65
		else
			SleepSoundCount = SleepSoundCount - 1
		end
		if AnimationPrev ~= "SLEEPING" and SleepStage ~= 2 then
			if (hasItem(mainHeldItem) and not leftHanded) or (hasItem(offHeldItem) and leftHanded) then
				rightArm.setRot({-15, 0, 0})
			end
			if (hasItem(offHeldItem) and not leftHanded) or (hasItem(mainHeldItem) and leftHanded) then
				leftArm.setRot({-15, 0, 0})
			end
			tail1.setRot({0, 0, 0})
			tail2.setRot({0, 0, 0})
			camera.FIRST_PERSON.setPos({0, 0.1, 0.2})
			camera.FIRST_PERSON.setRot({30, 180, 0})
			elytra_model.RIGHT_WING.setPos({8, 0, -2})
			elytra_model.LEFT_WING.setPos({-8, 0, -2})
			elytra_model.RIGHT_WING.setRot({0, math.rad(180), 0})
			elytra_model.LEFT_WING.setRot({0, math.rad(180), 0})
			animation["wag_tail"].cease()
			animation["sleep"].play()
		end
		if EmotionCount == 0 then
			setEmotion(4, 4, 0, 0)
		end
	elseif AnimationPrev == "SLEEPING" then
		rightArm.setRot({0, 0, 0})
		leftArm.setRot({0, 0, 0})
		camera.FIRST_PERSON.setPos({0, 0, 0})
		camera.FIRST_PERSON.setRot({0, 0, 0})
		for _, elytraModel in pairs(elytra_model) do
			elytraModel.setPos({0, 0, 0})
			elytraModel.setRot({0, 0, 0})
		end
		if WegTail then
			animation["wag_tail"].play()
		end
		animation["sleep"].stop()
	else
		SleepSoundCount = 0
	end

	--暗視が付与されている時は夜目にする（目を光らせる）。
	local nightVision = player.getStatusEffect("minecraft:night_vision")
	local function setLightEye(lightLevel)
		if lightLevel == 0 then
			model.Avatar.Head.FaceParts.RightEye.RightEyeLight.setLight()
			model.Avatar.Head.FaceParts.LeftEye.LeftEyeLight.setLight()
		else
			local blockLightLevel = world.getLightLevel(playerPos)
			model.Avatar.Head.FaceParts.RightEye.RightEyeLight.setLight({math.max(lightLevel, blockLightLevel)})
			model.Avatar.Head.FaceParts.LeftEye.LeftEyeLight.setLight({math.max(lightLevel, blockLightLevel)})
		end
	end

	if nightVision ~= nil then
		if nightVision.duration <= 200 then
			local tmp = math.floor(nightVision.duration % 10 - 4.5)
			if tmp < 0 then
				tmp = tmp + 1
			end
			setLightEye(math.abs(math.floor(tmp)) * 2 + 7)
		else
			setLightEye(15)
		end
	else
		setLightEye(0)
	end

	--防具の設定
	local function setArmor(armorItem, partName, armorParts, armorOverlayParts)
		if not HideArmor then
			local armorItemType = armorItem.getType()
			local textureNumber = "1"
			if partName == "leggings" then
				textureNumber = "2"
			end
			local materialName = string.match(armorItemType, ":.+_")
			if materialName ~= nil then
				materialName = string.sub(materialName, 2, string.len(materialName) - 1)
				if armorItemType == "minecraft:"..materialName.."_"..partName then
					if materialName == "golden" then
						materialName = "gold"
					end
					for _, armorPart in ipairs(armorParts) do
						armorPart.setEnabled(true)
						armorPart.setTexture("Resource", "minecraft:textures/models/armor/"..materialName.."_layer_"..textureNumber..".png")
					end
					if materialName == "leather" then
						local tag = armorItem.getTag()
						local armorColor
						if tag.display ~= nil then
							armorColor = vectors.intToRGB(tag.display.color)
						else
							armorColor = {160 / 255, 101 / 255, 64 / 255}
						end
						for index, armorPart in ipairs(armorParts) do
							armorPart.setColor(armorColor)
							armorOverlayParts[index].setEnabled(true)
						end
					else
						for index, armorPart in ipairs(armorParts) do
							armorPart.setColor({1, 1, 1})
							armorOverlayParts[index].setEnabled(false)
						end
					end
					if armorItem.hasGlint() then
						for index, armorPart in ipairs(armorParts) do
							armorPart.setShader("Glint")
							armorOverlayParts[index].setShader("Glint")
						end
					else
						for index, armorPart in ipairs(armorParts) do
							armorPart.setShader("None")
							armorOverlayParts[index].setShader("None")
						end
					end
				else
					for index, armorPart in ipairs(armorParts) do
						armorPart.setEnabled(false)
						armorOverlayParts[index].setEnabled(false)
					end
				end
			else
				for index, armorPart in ipairs(armorParts) do
					armorPart.setEnabled(false)
					armorOverlayParts[index].setEnabled(false)
				end
			end
		else
			for index, armorPart in ipairs(armorParts) do
				armorPart.setEnabled(false)
				armorOverlayParts[index].setEnabled(false)
			end
		end
	end

	setArmor(player.getEquipmentItem(6), "helmet", {Helmet}, {HelmetOverlay})
	setArmor(player.getEquipmentItem(5), "chestplate", Chestplate, ChestplateOverlay)
	setArmor(player.getEquipmentItem(4), "leggings", Leggings, LeggingsOverlay)
	setArmor(player.getEquipmentItem(3), "boots", Boots, BootsOverlay)

	--チェストプレート着用の場合は髪をずらす。
	local frontHair = model.Avatar.Body.Hairs.FrontHair
	local backHair = model.Avatar.Body.Hairs.BackHair
	local backRibbon = model.Avatar.Body.Skirt.BackRibbon
	if string.find(player.getEquipmentItem(5).getType(), "chestplate$") and not HideArmor then
		frontHair.setPos({0, 0, -1.1})
		backHair.setPos({0, 0, 1.1})
		skirt.setEnabled(false)
		backRibbon.setEnabled(false)
	else
		frontHair.setPos({0, 0, 0})
		backHair.setPos({0, 0, 0})
		skirt.setEnabled(true)
		backRibbon.setEnabled(true)
	end

	--濡れる処理
	if player.isTouchingWater() then
		WetCount = 1200
	elseif player.isInRain() then
		WetCount = math.min(WetCount + 4, 1200)
	else
		WetCount = math.max(WetCount - 1, 0)
	end
	if WetCount > 0 then
		if WetDropCount == 5 then
			if not player.isWet() then
				for _ = 1, math.min(ParticleLimit / 4, 4) do
					particle.addParticle("minecraft:falling_water", {playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5, 0, 0, 0})
				end
			end
			WetDropCount = 0
		else
			WetDropCount = WetDropCount + 1
		end
	end
	if WetBodyShakeCount > 0 then
		if WetBodyShakeCount % 5 == 0 then
			for _ = 1, math.min(ParticleLimit / 4, 8) do
				particle.addParticle("minecraft:splash", {playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5, 0, 0, 0})
			end
		end
		WetBodyShakeCount = WetBodyShakeCount - 1
	end

	--自動ブルブル
	if AutoShake and not player.isWet() and WetCount > 0 and not animation["shake"].isPlaying() and playerAnimation ~= "SLEEPING" then
		if AutoShakeCount == 0 then
			ping.bodyShake()
		else
			AutoShakeCount = AutoShakeCount - 1
		end
	else
		AutoShakeCount = 20
	end

	--放置中の処理
	local keypressed = false
	for _, keyBind in ipairs(KeyBinds) do
		if keyBind.isPressed() then
			keypressed = true
			break
		end
	end

	local lookDir = player.getLookDir()
	local lookRot = math.deg(math.atan2(lookDir.z, lookDir.x))
	local guiName = client.getOpenScreen()
	local lookRotDelta = 0
	if guiName ~= "クラフト" and guiName ~= "Crafting" and guiName ~= "class_481" and guiName ~= "Figura Menu" and guiName ~= "Figuraメニュー" then
		lookRotDelta = lookRot - TickLookRotPrev
	else
		lookRotDelta = 0
	end

	local function hasSameItemType(heldItemId)
		--0. メインハンド, 1. オフハンド
		local heldItem
		if heldItemId == 0 then
			heldItem = mainHeldItem
		elseif heldItemId == 1 then
			heldItem = offHeldItem
		end
		if heldItem == nil and HeldItemPrev[heldItemId + 1] == nil then
			return true
		elseif heldItem == nil or HeldItemPrev[heldItemId + 1] == nil then
			return false
		else
			if heldItem.getType() == HeldItemPrev[heldItemId + 1].getType() then
				return true
			else
				return false
			end
		end
	end

	if lookRotDelta == 0 and not keypressed and playerAnimation == "STANDING" and not wardenNearby and not wet and damageTaken == 0 and hasSameItemType(0) and hasSameItemType(1) then
		if AFKCount <= 6000 then
			AFKCount = AFKCount + 1
		end
		if AFKCount == 6000 then
			ping.sleep()
		elseif AFKCount == 5400 then
			if onGround then
				SitDownWhenSleepy = SitDown
				if not SitDown then
					ping.sitDown()
				end
			end
			ping.sleepy()
		elseif AFKCount % 600 == 0 then
			ping.touchBell()
		end
	else
		if animation["afk_right_bell"].isPlaying() or animation["afk_left_bell"].isPlaying() then
			ping.stopTouchBell()
		end
		if SleepStage ~= 0 then
			if not SitDownWhenSleepy then
				ping.sitDown()
			end
			ping.backFromAFK()
		end
		AFKCount = 0
	end

	--チック終了処理
	VelocityYPrev = velocity.y
	AnimationCount = AnimationCount + 1
	HealthPercentagePrev = healthPercentage
	MaxHealthPrev = maxHealth
	AnimationPrev = playerAnimation
	SneakPrev = sneaking
	WardenNearbyPrev = wardenNearby
	HeldItemPrev[1] = mainHeldItem
	HeldItemPrev[2] = offHeldItem
	TickLookRotPrev = lookRot
	FpsCountData[1] = FpsCountData[1] + 1
	if JumpBellCooldown > 0 then
		JumpBellCooldown = JumpBellCooldown - 1
	end
	local actionWheelOpen = action_wheel.isOpen()
	if actionWheelOpen and not wardenNearby and not IsInSettings then
		if ActionWheelCount == 40 then
			ActionWheelCount = 0
		else
			ActionWheelCount = ActionWheelCount + 1
		end
	else
		ActionWheelCount = 0
	end
	if not actionWheelOpen and IsInSettings then
		setActionWheel(false, wardenNearby)
	end
	if EmotionCount > 0 then
		EmotionCount = EmotionCount - 1
	end
	if MeowCount == 0 then
		--時々ニャーニャー鳴く。
		if MeowSound and playerAnimation ~= "SLEEPING" and EmoteActionCount == 0 and not underwater and not horn and not wardenNearby and AFKCount > 0 and SleepStage == 0 and not animation["shake"].isPlaying() then
			if tired then
				playMeow("minecraft:entity.cat.stray_ambient", 1, 1.5)
			else
				if math.random() >= 0.7 then
					playMeow("minecraft:entity.cat.purreow", 1, 1.5)
				else
					playMeow("minecraft:entity.cat.ambient", 0.5, 1.5)
				end
			end
			if EmotionCount == 0 then
				setEmotion(-1, -1, 1, 20)
			end
		end
		MeowCount = 300
	else
		MeowCount = MeowCount - 1
	end
	if WinkCount == 0 then
		if EmotionCount == 0 and not horn then
			setEmotion(4, 4, 0, 1)
		end
		WinkCount = 200
	else
		WinkCount = WinkCount - 1
	end
	if EmoteActionCount > 0 then
		EmoteActionCount = EmoteActionCount - 1
	end
	if SweatCount > 0 then
		if SweatCount % 5 == 0 then
			for _ = 1, math.min(ParticleLimit / 4, 4) do
				particle.addParticle("minecraft:splash", {playerPos.x, playerPos.y + 2, playerPos.z, 0, 0, 0})
			end
		end
		SweatCount = SweatCount - 1
	end
	local attackKeyPressed = AttackKey.isPressed()
	if attackKeyPressed and not AttackKeyPressedPrev and mainHeldItem == nil and wardenNearby then
		ping.punch()
	end
	if AttackAnimationCount > 0 then
		AttackAnimationCount = AttackAnimationCount - 1
	end
	AttackKeyPressedPrev = attackKeyPressed
	if TouchBellCount >= 0 then
		if TouchBellCount == 27 or TouchBellCount == 43 then
			playBellSound(0.5)
		end
		if TouchBellCount == 67 then
			if (not hasCake(mainHeldItem) and not leftHanded) or (not hasCake(offHeldItem) and leftHanded) then
				rightArm.setEnabled(true)
				AlternativeRightArm.setEnabled(false)
			end
			if (not hasCake(offHeldItem) and not leftHanded) or (not hasCake(mainHeldItem) and leftHanded) then
				leftArm.setEnabled(true)
				AlternativeLeftArm.setEnabled(false)
			end
			TouchBellCount = -1
		else
			TouchBellCount = TouchBellCount + 1
		end
	end
	if SleepStage == 1 then
		setEmotion(3, 3, 0, 0)
	end
	SleepStagePrev = SleepStage
	if AwakeAnimationCount >= 0 then
		if damageTaken == 2 then
			AwakeAnimationCount = -1
		elseif AwakeAnimationCount == 30 then
			if damageTaken == 0 then
				playMeow("minecraft:entity.cat.hurt", 1, 1.5)
			end
			setEmotion(1, 1, 0, 10)
		elseif AwakeAnimationCount == 20 then
			bodyShake()
			SweatCount = 20
		end
		AwakeAnimationCount = AwakeAnimationCount - 1
	end
end

function render()
	--FPS計測
	if FpsCountData[1] == 1 then
		Fps = FpsCountData[2] * 20
		FpsCountData = {0, 0}
	end

	--髪のアニメーション
	--直近1秒間の横方向、縦方向の移動速度の平均を求める（横方向の場合、前に動いているか、後ろに動いているかも考慮する）。
	local lookDir = player.getLookDir()
	local lookRot = math.deg(math.atan2(lookDir.z, lookDir.x))
	local playerAnimation = player.getAnimation()
	if HairRenderCount >= HairRenderLimit - 1 then
		local velocity = player.getVelocity()
		local velocityRot = math.deg(math.atan2(velocity.z, velocity.x))
		local playerSpeed = math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2))
		local bodyYaw = (player.getBodyYaw() - 270) % 360
		local directionAbs = math.abs(velocityRot - bodyYaw)
		if math.min(directionAbs, 360 - directionAbs) >= 90 then
			playerSpeed = -playerSpeed
		end
		if velocityRot < 0 then
			velocityRot = 360 + velocityRot
		end
		if velocityRot == velocityRot then
			local sneakOffset = 0
			if player.isSneaking() then
				sneakOffset = -0.19
			end
			local data = playerSpeed + sneakOffset
			VelocityAverage[1] = (#VelocityData[1] * VelocityAverage[1] + data) / (#VelocityData[1] + 1)
			table.insert(VelocityData[1], data)
		else
			VelocityAverage[1] = (#VelocityData[1] * VelocityAverage[1]) / (#VelocityData[1] + 1)
			table.insert(VelocityData[1], 0)
		end
		VelocityAverage[2] = (#VelocityData[2] * VelocityAverage[2] + velocity.y) / (#VelocityData[2] + 1)
		table.insert(VelocityData[2], velocity.y)
		local guiName = client.getOpenScreen()
		if guiName ~= "クラフト" and guiName ~= "Crafting" and guiName ~= "class_481" and guiName ~= "Figura Menu" and guiName ~= "Figuraメニュー" then
			local lookRotDelta = math.abs(lookRot - LookRotPrev)
			if lookRotDelta >= 180 then
				lookRotDelta = 360 - lookRotDelta
			end
			local data = lookRotDelta * Fps
			VelocityAverage[3] = (#VelocityData[3] * VelocityAverage[3] + data) / (#VelocityData[3] + 1)
			table.insert(VelocityData[3], data)
		else
			VelocityAverage[3] = (#VelocityData[3] * VelocityAverage[3]) / (#VelocityData[3] + 1)
			table.insert(VelocityData[3], 0)
		end
		for index, velocityTable in ipairs(VelocityData) do
			while #velocityTable > Fps * 0.25 / HairRenderLimit do
				if #velocityTable >= 2 then
					VelocityAverage[index] = (#velocityTable * VelocityAverage[index] - velocityTable[1]) / (#velocityTable - 1)
				end
				table.remove(velocityTable, 1)
			end
		end
		--求めた平均から髪の角度を決定する。
		local hairLimit
		local chestItemType = player.getEquipmentItem(5).getType()
		if chestItemType == "minecraft:elytra" then
			hairLimit = {{13, 80}, {0, 0}}
		elseif string.find(chestItemType, "chestplate$") and not HideArmor then
			hairLimit = {{0, 80}, {-80, 0}}
		else
			hairLimit = {{13, 80}, {-80, -13}}
		end
		local frontHair = model.Avatar.Body.Hairs.FrontHair
		local backHair = model.Avatar.Body.Hairs.BackHair
		if playerAnimation == "FALL_FLYING" then
			frontHair.setRot({math.min(math.max(hairLimit[1][2] - math.sqrt(VelocityAverage[1] ^ 2 + VelocityAverage[2] ^ 2) * 80, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
			backHair.setRot({hairLimit[2][2], 0, 0})
		elseif playerAnimation == "SWIMMING" then
			frontHair.setRot({math.min(math.max(hairLimit[1][2] - math.sqrt(VelocityAverage[1] ^ 2 + VelocityAverage[2] ^ 2) * 320, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
			backHair.setRot({hairLimit[2][2], 0, 0})
		else
			if math.floor(VelocityAverage[2] * 100 + 0.5) / 100 < 0 then
				frontHair.setRot({math.min(math.max(-VelocityAverage[1] * 160 - VelocityAverage[2] * 80, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
				backHair.setRot({math.min(math.max(-VelocityAverage[1] * 160 + VelocityAverage[2] * 80, hairLimit[2][1]), hairLimit[2][2]), 0, 0})
			else
				frontHair.setRot({math.min(math.max(-VelocityAverage[1] * 160 + VelocityAverage[3] * 0.05, hairLimit[1][1]), hairLimit[1][2]), 0, 0})
				backHair.setRot({math.min(math.max(-VelocityAverage[1] * 160 - VelocityAverage[3] * 0.05, hairLimit[2][1]), hairLimit[2][2]), 0, 0})
			end
		end
		HairRenderCount = 0
	end

	--一人称視点の時はバニラ腕の強制表示
	local firstPerson = renderer.isFirstPerson()
	if firstPerson then
		rightArm.setEnabled(true)
		leftArm.setEnabled(true)
		AlternativeRightArm.setEnabled(false)
		AlternativeLeftArm.setEnabled(false)
	end

	--寝ている時かつ一人称視点の時、頭を非表示
	local head = model.Avatar.Head
	if playerAnimation == "SLEEPING" and firstPerson then
		head.setEnabled(false)
	else
		head.setEnabled(true)
	end

	--レンダー終了処理
	FpsCountData[2] = FpsCountData[2] + 1
	LookRotPrev = lookRot
	HairRenderCount = HairRenderCount + 1
end

function world_render()
	--座る時のカメラの位置調整
	if SitDown and CameraOffset > -0.5 then
		CameraOffset = math.max(CameraOffset - 0.5 / Fps * 6, -0.5)
		for _, cameraPart in pairs(camera) do
			cameraPart.setPos({0, CameraOffset, 0})
		end
	elseif not SitDown and CameraOffset < 0 then
		CameraOffset = math.min(CameraOffset + 0.5 / Fps * 6, 0)
		for _, cameraPart in pairs(camera) do
			cameraPart.setPos({0, CameraOffset, 0})
		end
	end
end