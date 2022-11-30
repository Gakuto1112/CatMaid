---@class WardenClass ウォーデンに怯える機能を制御するクラス
---@field AttackKey Keybind 攻撃ボタン（怯えている時に素手の攻撃を表示させる用）
---@field WardenNearbyData table 前チックにウォーデンが近くにいたかどうかを調べる為にウォーデン情報を格納するテーブル
---@field RightHandItemTypeData table アイテムの持ち替え検出の為に右手のアイテムの情報を格納するテーブル
---@field LeftHandItemTypeData table アイテムの持ち替え検出の為に左手のアイテムの情報を格納するテーブル
---@field FirstPersonData table 視点切り替え検出の為に視点情報を格納するテーブル
---@field AttackCount integer 攻撃している間を計るカウンター
---@field WardenClass.WardenNearby boolean ウォーデンが近くにいるかどうか（=暗闇デバフを受けているかどうか）

WardenClass = {}

AttackKey = keybinds:newKeybind(LanguageClass.getTranslate("key__attack"), keybinds:getVanillaKey("key.attack"))
WardenNearbyData = {}
RightHandItemTypeData = {}
LeftHandItemTypeData = {}
FirstPersonData = {}
AttackCount = 0
WardenClass.WardenNearby = false

AttackKey.onPress = function()
	local leftHanded = player:isLeftHanded()
	if not action_wheel:isEnabled() and WardenClass.WardenNearby and ((General.hasItem(player:getHeldItem(leftHanded)) == "none" and not leftHanded) or (General.hasItem(player:getHeldItem(not leftHanded)) == "none" and leftHanded)) then
		pings.attack()
	end
end

--ping関数
function pings.attack()
	AttackCount = 6
end

events.TICK:register(function()
	WardenClass.WardenNearby = General.getStatusEffect("darkness") and true or false
	local leftHanded = player:isLeftHanded()
	local rightHandItemType = General.hasItem(player:getHeldItem(leftHanded))
	local leftHandItemType = General.hasItem(player:getHeldItem(not leftHanded))
	local firstPerson = renderer:isFirstPerson()
	if WardenClass.WardenNearby then
		if not WardenNearbyData[1] then
			General.setAnimations("PLAY", "afraid")
		end
		if General.isTired then
			FacePartsClass.setEmotion("SURPLISED_TIRED", "SURPLISED_TIRED", "CLOSED", 0, false)
		else
			FacePartsClass.setEmotion("SURPLISED", "SURPLISED", "CLOSED", 0, false)
		end
		local isSleeping = player:getPose() == "SLEEPING"
		if rightHandItemType == "none" and not isSleeping and ((AttackCount <= 0 and not firstPerson) or leftHanded) then
			if not WardenNearbyData[1] or SleepClass.SleepData[1] or RightHandItemTypeData[1] ~= "none" or ((AttackCount == 0 or FirstPersonData[1]) and not leftHanded) then
				General.setAnimations("PLAY", "right_hide_bell")
			end
			General.setParentTypeWithArmor("RIGHT", "Body")
		else
			General.setAnimations("STOP", "right_hide_bell")
			General.setParentTypeWithArmor("RIGHT", "RightArm")
		end
		if leftHandItemType == "none" and not isSleeping and ((AttackCount <= 0 and not firstPerson) or not leftHanded) then
			if not WardenNearbyData[1] or SleepClass.SleepData[1] or LeftHandItemTypeData[1] ~= "none" or ((AttackCount == 0 or FirstPersonData[1]) and leftHanded) then
				General.setAnimations("PLAY", "left_hide_bell")
			end
			General.setParentTypeWithArmor("LEFT", "Body")
		else
			General.setAnimations("STOP", "left_hide_bell")
			General.setParentTypeWithArmor("LEFT", "LeftArm")
		end
	else
		General.setAnimations("STOP", "afraid")
		General.setAnimations("STOP", "right_hide_bell")
		General.setAnimations("STOP", "left_hide_bell")
		if AFKClass.TouchBellCount == 0 then
			General.setParentTypeWithArmor("RIGHT", "RightArm")
		end
		if AFKClass.TouchBellCount == 0 then
			General.setParentTypeWithArmor("LEFT", "LeftArm")
		end
	end
	table.insert(WardenNearbyData, WardenClass.WardenNearby)
	table.insert(RightHandItemTypeData, rightHandItemType)
	table.insert(LeftHandItemTypeData, leftHandItemType)
	table.insert(FirstPersonData, firstPerson)
	for _, dataTable in ipairs({WardenNearbyData, RightHandItemTypeData, LeftHandItemTypeData, FirstPersonData}) do
		if #dataTable == 3 then
			table.remove(dataTable, 1)
		end
	end
	AttackCount = AttackCount > -1 and AttackCount - 1 or AttackCount
end)

return WardenClass