---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPage Page アクションホイールのメインページ
---@field ActionWheelClass.ActionCount number アクション再生中は0より大きくなるカウンター

ActionWheelClass = {}

MainPage = action_wheel:createPage("main_page")
ActionWheelClass.ActionCount = 0
ShakeSplashCount = 0

---現在座れる状況かを返す。
---@return boolean
function canSitDown()
	local velocity = player:getVelocity()
	return player:getPose() == "STANDING" and player:isOnGround() and not player:getVehicle() and math.sqrt(math.abs(velocity.x ^ 2 + velocity.z ^ 2)) == 0 and HurtClass.Damaged == "NONE"
end

--座っている状態から立ち上がる
function standUp()
	vanilla_model.HELD_ITEMS:setVisible(true)
	animation["main"]["stand_up"]:play()
	animation["main"]["sit_down"]:stop()
	if ConfigClass.WaveTail then
		animation["main"]["wave_tail"]:play()
	end
	models.models.main.Avatar.Head:setRot(0, 0, 0)
end

---ブルブル
function ActionWheelClass.bodyShake()
	animation["main"]["shake"]:play()
	sound:playSound("minecraft:entity.wolf.shake", player:getPos(), 1, 1.5)
	EyesAndMouthClass.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 20, true)
	if WetClass.WetCount > 0 then
		ShakeSplashCount = 20
		WetClass.WetCount = 20
	end
	ActionWheelClass.ActionCount = 20
end

events.TICK:register(function()
	if not action_wheel:isEnabled() then
		action_wheel:setPage(MainPage)
	end
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" and not canSitDown() then
		standUp()
		animation["main"]["sit_down_first_person_fix"]:stop()
	end
	if ShakeSplashCount > 0 then
		if ShakeSplashCount % 5 == 0 then
			local playerPos = player:getPos()
			for _ = 1, math.min(meta:getMaxParticles() / 4, 4) do
				particle:addParticle("minecraft:splash", playerPos.x + math.random() - 0.5, playerPos.y + math.random() + 0.5, playerPos.z + math.random() - 0.5)
			end
		end
		ShakeSplashCount = ShakeSplashCount - 1
	end
	ActionWheelClass.ActionCount = ActionWheelClass.ActionCount > 0 and ActionWheelClass.ActionCount - 1 or ActionWheelClass.ActionCount
end)

events.RENDER:register(function()
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" then
		models.models.main.Avatar.Head:setRot(10 * (1 - math.abs(player:getLookDir().y)) * (renderer:isCameraBackwards() and 1 or -1), 0, 0)
	end
end)

events.WORLD_RENDER:register(function()
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" and renderer:isFirstPerson() then
		animation["main"]["sit_down_first_person_fix"]:play()
	else
		animation["main"]["sit_down_first_person_fix"]:stop()
	end
end)

--メインページのアクションの設定
MainPage:newAction()

--TODO: ウォーデンが近くにいる時は、アクションを拒否する。
--アクション1. 「ニャー」と鳴く（スマイル）
MainPage:newAction(1):title("「ニャー」と鳴く（スマイル）"):color(255 / 255, 85 / 255, 255 / 255):hoverColor(1, 1, 1):item("cod"):onLeftClick(function()
	if ActionWheelClass.ActionCount == 0 then
		local playerPos = player:getPos()
		MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
		EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, true)
		particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
		if player:isLeftHanded() then
			animation["main"]["left_meow"]:play()
		else
			animation["main"]["right_meow"]:play()
		end
		ActionWheelClass.ActionCount = 20
	end
end)

--アクション2. 「ニャー」と鳴く（ウィンク）
MainPage:newAction(2):title("「ニャー」と鳴く（ウィンク）"):color(255 / 255, 85 / 255, 255 / 255):hoverColor(1, 1, 1):item("cod"):onLeftClick(function()
	if ActionWheelClass.ActionCount == 0 then
		local playerPos = player:getPos()
		MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
		particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
		if player:isLeftHanded() then
			EyesAndMouthClass.setEmotion("NONE", "CLOSED", "OPENED", 20, true)
			animation["main"]["left_meow"]:play()
		else
			EyesAndMouthClass.setEmotion("CLOSED", "NONE", "OPENED", 20, true)
			animation["main"]["right_meow"]:play()
		end
		ActionWheelClass.ActionCount = 20
	end
end)

--アクション3. 「ニャー」と鳴く（キラキラ）
MainPage:newAction(3):title("「ニャー」と鳴く（キラキラ）"):color(255 / 255, 85 / 255, 255 / 255):hoverColor(1, 1, 1):item("cod"):onLeftClick(function()
	if ActionWheelClass.ActionCount == 0 then
		local playerPos = player:getPos()
		particle:addParticle("minecraft:heart", playerPos.x, playerPos.y + 2, playerPos.z)
		if General.isTired() then
			MeowClass.playMeow("WEAK", 1)
			EyesAndMouthClass.setEmotion("TIRED", "TIRED", "OPENED", 20, true)
		else
			MeowClass.playMeow("NORMAL", 1)
			EyesAndMouthClass.setEmotion("SHINE", "SHINE", "OPENED", 20, true)
		end
		ActionWheelClass.ActionCount = 20
	end
end)

--アクション4. おすわり
MainPage:newAction(4):title("おすわり"):color(255 / 255, 85 / 255, 255 / 255):hoverColor(1, 1, 1):item("oak_stairs"):onLeftClick(function()
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" then
		standUp()
	elseif canSitDown() then
		vanilla_model.HELD_ITEMS:setVisible(false) --FIXME: BBmodelに手持ちアイテムのキーワードが存在しないので、暫定処理として手持ちアイテムを非表示にする。
		animation["main"]["sit_down"]:play()
		animation["main"]["stand_up"]:stop()
		animation["main"]["wave_tail"]:stop()
	end
end)

--アクション5. ブルブル
MainPage:newAction(5):title("ブルブル"):color(255 / 255, 85 / 255, 255 / 255):hoverColor(1, 1, 1):item("water_bucket"):onLeftClick(function()
	if ActionWheelClass.ActionCount == 0 then
		ActionWheelClass.bodyShake()
	end
end)

--アクション6. 設定を開く
MainPage:newAction(6):title("§7設定（使用不可）"):color(42 / 255, 42 / 255, 42 / 255):hoverColor(255 / 255, 85 / 255, 85 / 255):item("comparator"):onLeftClick(function()
	print("\n§c§l*** NOTE ***§r\n2022/7/16現在、Rewrite版には、データを保存して後で読み出せるようにする機能が搭載されていません。\nつまり、Prewrite版のような設定ページが現在は作成できません！\n代わりに、設定ファイル（/sripts/config.lua）を直接編集して設定値を変更して下さい。")
end)

action_wheel:setPage(MainPage)

return ActionWheelClass