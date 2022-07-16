---@class WardenClass ウォーデンに怯える機能を制御するクラス
---@field AttackKey Keybind 攻撃ボタン（怯えている時に素手の攻撃を表示させる用）
---@field WardenNearbyData table 前チックにウォーデンが近くにいたかどうかを調べる為にウォーデン情報を格納するテーブル
---@field RightHandItemTypeData table アイテムの持ち替え検出の為に右手のアイテムの情報を格納するテーブル
---@field LeftHandItemTypeData table アイテムの持ち替え検出の為に左手のアイテムの情報を格納するテーブル
---@field AttackCount integer 攻撃している間を計るカウンター
---@field WardenClass.WardenNearby boolean ウォーデンが近くにいるかどうか（=暗闇デバフを受けているかどうか）

WardenClass = {}

AttackKey = keybind:create("攻撃", keybind:getVanillaKey("key.attack"))
WardenNearbyData = {}
RightHandItemTypeData = {}
LeftHandItemTypeData = {}
AttackCount = 0
WardenClass.WardenNearby = false

AttackKey.onPress = function()
	if not action_wheel:isEnabled() then
		AttackCount = 6
	end
end

events.TICK:register(function()
	WardenClass.WardenNearby = General.getStatusEffect("darkness") and true or false
	local rightArm = models.models.main.Avatar.Body.Arms.RightArm
	local leftArm = models.models.main.Avatar.Body.Arms.LeftArm
	local rightAlternativeArm = models.models.alternative_arms.Body.AlternativeArm.RightAlternativeArm
	local leftAlternativeArm = models.models.alternative_arms.Body.AlternativeArm.LeftAlternativeArm
	local leftHanded = player:isLeftHanded()
	local rightHandItemType = General.hasItem(player:getHeldItem(leftHanded))
	local leftHandItemType = General.hasItem(player:getHeldItem(not leftHanded))
	if WardenClass.WardenNearby then
		if not WardenNearbyData[1] then
			animation["main"]["afraid"]:play()
			animation["alternative_arms"]["afraid"]:play()
		end
		if rightHandItemType == "none" and (AttackCount <= 0 or leftHanded) then
			if not WardenNearbyData[1] or RightHandItemTypeData[1] ~= "none" or (AttackCount == 0 and not leftHanded) then
				animation["alternative_arms"]["right_hide_bell"]:play()
			end
			rightArm:setVisible(false)
			rightAlternativeArm:setVisible(true)
		else
			animation["alternative_arms"]["right_hide_bell"]:stop()
			rightArm:setVisible(true)
			rightAlternativeArm:setVisible(false)
		end
		if leftHandItemType == "none" and (AttackCount <= 0 or not leftHanded) then
			if not WardenNearbyData[1] or LeftHandItemTypeData[1] ~= "none" or (AttackCount == 0 and leftHanded) then
				animation["alternative_arms"]["left_hide_bell"]:play()
			end
			leftArm:setVisible(false)
			leftAlternativeArm:setVisible(true)
		else
			animation["alternative_arms"]["left_hide_bell"]:stop()
			leftArm:setVisible(true)
			leftAlternativeArm:setVisible(false)
		end
	else
		animation["main"]["afraid"]:stop()
		animation["alternative_arms"]["afraid"]:stop()
		animation["alternative_arms"]["right_hide_bell"]:stop()
		animation["alternative_arms"]["left_hide_bell"]:stop()
		rightArm:setVisible(true)
		rightAlternativeArm:setVisible(false)
		leftArm:setVisible(true)
		leftAlternativeArm:setVisible(false)
	end
	table.insert(WardenNearbyData, WardenClass.WardenNearby)
	table.insert(RightHandItemTypeData, rightHandItemType)
	table.insert(LeftHandItemTypeData, leftHandItemType)
	for _, dataTable in ipairs({WardenNearbyData, RightHandItemTypeData, LeftHandItemTypeData}) do
		if #dataTable == 3 then
			table.remove(dataTable, 1)
		end
	end
	AttackCount = AttackCount > -1 and AttackCount - 1 or AttackCount
end)

return WardenClass