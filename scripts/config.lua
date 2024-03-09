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

--ping関数
---アバター設定を他Figuraクライアントと同期する。
---@param catType integer 猫の種類
---@param bellVolume number 鈴の音量
---@param meowSound boolean 猫の鳴き声
---@param waveTail boolean 尻尾を振るかどうか
---@param hideArmor boolean 防具を隠すかどうか
---@param autoShake boolean 自動ブルブル
---@param AFKAction boolean AFKアクション
function pings.syncAvatarConfig(catType, bellVolume, meowSound, waveTail, hideArmor, autoShake, AFKAction, wardenNearby)
	if not IsSynced then
		TailAndEarsClass.setCatType(catType)
		BellSoundClass.BellVolume = bellVolume
		MeowClass.MeowSound = meowSound
		General.setAnimations(waveTail and "PLAY" or "STOP", "wave_tail")
		ArmorClass.ShowArmor = hideArmor
		WetClass.AutoShake = autoShake
		AFKClass.AFKAction = AFKAction
		WardenClass.WardenNearby = wardenNearby
	end
end

events.TICK:register(function ()
	if host:isHost() then
		if NextSyncCount == 0 then
			pings.syncAvatarConfig(ActionWheelClass.CurrentCatType, ActionWheelClass.CurrentBellVolume, MeowClass.MeowSound, animations["models.main"]["wave_tail"]:getPlayState() == "PLAYING", ArmorClass.ShowArmor, WetClass.AutoShake, AFKClass.AFKAction, WardenClass.WardenNearby)
			NextSyncCount = 300
		else
			NextSyncCount = NextSyncCount - 1
		end
	end
end)

if host:isHost() then
	config:name("Cat_maid")
end

return ConfigClass