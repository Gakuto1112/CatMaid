---@class LanguageClass アバターの表示言語を管理するクラス
---@field LanguageData table 言語データ

LanguageClass = {}

LanguageData = {
	en = {
		message__config_unavailable = "\n§c§l*** NOTE ***§r\nAs of 7/16/2022, Figura does not have a function to save data to be able to load later.\nIt means that it is impossible to create config system like when pre-write.\nInsted of that, please change configs by editing config file (/sripts/config.lua) directly.",
		message__custom_sound_unavailable = "§cNo permission to play custom sounds!§rAn alternative sound will be used as bell sound.",
		action_wheel__enable = "switch to §aenable",
		action_wheel__disable = "switch to §cdisable",
		action_wheel__main__action_1__title = "Meow (smile)",
		action_wheel__main__action_2__title = "Meow (wink)",
		action_wheel__main__action_3__title = "Meow (shine)",
		action_wheel__main__action_4__title = "Sit down",
		action_wheel__main__action_5__title = "Body shake",
		action_wheel__main__action_6__title = "§bSummer feature§r: ",
		action_wheel__main__action_7__title = "Cinematic mode",
		action_wheel__main__action_8__title = "Avatar config (unavailable)",
		action_wheel__cinematic__action_1__title = "Camera pitch (scroll)",
		action_wheel__cinematic__action_2__title = "Camera roll (scroll)",
		action_wheel__cinematic__action_3__title = "Camera yaw (scroll)",
		action_wheel__cinematic__action_4__title = "Reset camera",
		action_wheel__cinematic__action_5__title = "Exit cinematic mode",
		key__jump = "Jump",
		key__attack = "Attack",
		key__afk_check = "for AFK check"
	},
	jp = {
		message__config_unavailable = "\n§c§l*** NOTE ***§r\n2022/7/16現在、Rewrite版には、データを保存して後で読み出せるようにする機能が搭載されていません。\nつまり、Prewrite版のような設定ページが現在は作成できません！\n代わりに、設定ファイル（/sripts/config.lua）を直接編集して設定値を変更して下さい。",
		message__custom_sound_unavailable = "§cカスタムサウンドを再生する権限がありません！§r鈴の音は代替サウンドが使用されます。",
		action_wheel__enable = "§aオン§rにする",
		action_wheel__disable = "§cオフ§rにする",
		action_wheel__main__action_1__title = "「ニャー」と鳴く（スマイル）",
		action_wheel__main__action_2__title = "「ニャー」と鳴く（ウィンク）",
		action_wheel__main__action_3__title = "「ニャー」と鳴く（キラキラ）",
		action_wheel__main__action_4__title = "おすわり",
		action_wheel__main__action_5__title = "ブルブル",
		action_wheel__main__action_6__title = "§b夏機能§r：",
		action_wheel__main__action_7__title = "シネマティックモード",
		action_wheel__main__action_8__title = "アバター設定（使用不可）",
		action_wheel__cinematic__action_1__title = "カメラピッチ（スクロール）",
		action_wheel__cinematic__action_2__title = "カメラロール（スクロール）",
		action_wheel__cinematic__action_3__title = "カメラヨー（スクロール）",
		action_wheel__cinematic__action_4__title = "カメラリセット",
		action_wheel__cinematic__action_5__title = "シネマティックモード終了",
		key__jump = "ジャンプ",
		key__attack = "攻撃",
		key__afk_check = "AFK復帰判定用"
	}
}

---翻訳キーに対する訳文を返す。設定言語が存在しない場合は英語の文が返される。また、指定したキーの訳が無い場合は英語->キーそのままが返される。
---@param keyName string 翻訳キー
---@return string
function LanguageClass.getTranslate(keyName)
	local language = LanguageData[ConfigClass.Language] and ConfigClass.Language or "en"
	return LanguageData[language][keyName] and LanguageData[language][keyName] or (LanguageData["en"][keyName] and LanguageData["en"][keyName] or keyName)
end

return LanguageClass