---@class ConfigClass アバター設定を管理するクラス
---@field DefaultValues table 読み込んだ値のデフォルト値を保持するテーブル
---@field IsSynced boolean アバターの設定がホストと同期されたかどうか
---@field NextSyncCount integer 次の同期pingまでのカウンター

ConfigClass = {}
DefaultValues = {}
IsSynced = host:isHost()
NextSyncCount = 0

---設定を読み出す
---@param keyName string 読み出す設定の名前
---@param defaultValue any 該当の設定が無い場合や、ホスト外での実行の場合はこの値が返される。
---@return any data 読み出した値
function ConfigClass.loadConfig(keyName, defaultValue)
	if host:isHost() then
		local data = config:load(keyName)
		DefaultValues[keyName] = defaultValue
		if data ~= nil then
			return data
		else
			return defaultValue
		end
	else
		return defaultValue
	end
end

---設定を保存する
---@param keyName string 保存する設定の名前
---@param value any 保存する値
function ConfigClass.saveConfig(keyName, value)
	if host:isHost() then
		if DefaultValues[keyName] == value then
			config:save(keyName, nil)
		else
			config:save(keyName, value)
		end
	end
end

events.TICK:register(function ()
	if NextSyncCount == 0 then
		--pings.syncAvatarConfig(ActionWheelClass.CurrentPlayerNameState, ActionWheelClass.CurrentCostumeState, WetClass.AutoShake, ArmorClass.ShowArmor, UmbrellaClass.UmbrellaSound)
		NextSyncCount = 300
	else
		NextSyncCount = NextSyncCount - 1
	end
end)

if host:isHost() then
	config:name("Cat_maid")
end

return ConfigClass