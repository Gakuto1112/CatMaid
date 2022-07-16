---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPage Page アクションホイールのメインページ
---@field ConfigPage Page アクションホイールの設定ページ
---@field ActionWheelClass.ActionCount number アクション再生中は0より大きくなるカウンター

ActionWheelClass = {}

MainPage = action_wheel:createPage("main_page")
ConfigPage = action_wheel:createPage("config_page")
ActionWheelClass.ActionCount = 0


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
	animation["main"]["wave_tail"]:play() --TODO: 尻尾を振らないオプションも考慮する。
	models.models.main.Avatar.Head:setRot(0, 0, 0)
end

events.TICK:register(function()
	if animation["main"]["sit_down"]:getPlayState() == "PLAYING" and not canSitDown() then
		standUp()
		animation["main"]["sit_down_first_person_fix"]:stop()
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
MainPage:newAction(1):title("「ニャー」と鳴く（スマイル）"):color(255 / 255, 85 / 255, 255 / 255):item("cod"):hoverColor(1, 1, 1):onLeftClick(function()
	if ActionWheelClass.ActionCount == 0 then
		local playerPos = player:getPos()
		MeowClass.playMeow(General.isTired() and "WEAK" or "NORMAL", 1)
		EyesAndMouthClass.setEmotion("CLOSED", "CLOSED", "OPENED", 20, false)
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
MainPage:newAction(2):title("「ニャー」と鳴く（ウィンク）"):color(255 / 255, 85 / 255, 255 / 255):item("cod"):hoverColor(1, 1, 1):onLeftClick(function()
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
MainPage:newAction(3):title("「ニャー」と鳴く（キラキラ）"):color(255 / 255, 85 / 255, 255 / 255):item("cod"):hoverColor(1, 1, 1):onLeftClick(function()
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
MainPage:newAction(4):title("おすわり"):color(255 / 255, 85 / 255, 255 / 255):item("oak_stairs"):hoverColor(1, 1, 1):onLeftClick(function()
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
MainPage:newAction(5):title("ブルブル"):color(255 / 255, 85 / 255, 255 / 255):item("water_bucket"):hoverColor(1, 1, 1)

--アクション6. 設定を開く
MainPage:newAction(6):title("設定（クリック）"):color(200 / 255, 200 / 255, 200 / 255):item("comparator"):hoverColor(1, 1, 1)

action_wheel:setPage(MainPage)

return ActionWheelClass