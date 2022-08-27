---@class LanguageClass アバターの表示言語を管理するクラス
---@field LanguageData table 言語データ
---@field ActiveLanguage string 設定言語

LanguageClass = {}

LanguageData = {
	en = {
		message__config_unavailable = "\n§c§l*** NOTE ***§r\nAs of 7/16/2022, Figura does not have a function to save data to be able to load later.\nIt means that it is impossible to create config system like when pre-write.\nInsted of that, please change configs by editing config file (/sripts/config.lua) directly.",
		message__custom_sound_unavailable = "§cNo permission to play custom sounds!§rAn alternative sound will be used as bell sound.",
		action_wheel__enable = "switch to §aenable",
		action_wheel__disable = "switch to §cdisable",
		action_wheel__main__page_switch__title = "page switch (scroll): ",
		action_wheel__main_1__action_1__title = "Smile",
		action_wheel__main_1__action_2__title = "Wink",
		action_wheel__main_1__action_3__title = "Shine",
		action_wheel__main_1__action_4__title = "Unequal eye",
		action_wheel__main_1__action_5__title = "Surprised",
		action_wheel__main_1__action_6__title = "Intimidate",
		action_wheel__main_1__action_7__title = "Depressed",
		action_wheel__main_2__action_1__title = "Pat (head)",
		action_wheel__main_2__action_2__title = "Pat (tail)",
		action_wheel__main_2__action_3__title = "Sit down",
		action_wheel__main_2__action_4__title = "Body shake",
		action_wheel__main_2__action_5__title = "§bSummer feature§r: ",
		action_wheel__main_2__action_6__title = "Cinematic mode",
		action_wheel__main_2__action_7__title = "Avatar config (unavailable)",
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
		action_wheel__main__page_switch__title = "ページ切り替え（スクロール）：",
		action_wheel__main_1__action_1__title = "スマイル",
		action_wheel__main_1__action_2__title = "ウィンク",
		action_wheel__main_1__action_3__title = "キラキラ",
		action_wheel__main_1__action_4__title = "不等号目",
		action_wheel__main_1__action_5__title = "ビックリ",
		action_wheel__main_1__action_6__title = "威嚇",
		action_wheel__main_1__action_7__title = "しょんぼり",
		action_wheel__main_2__action_1__title = "ナデナデ（頭）",
		action_wheel__main_2__action_2__title = "ナデナデ (尻尾)",
		action_wheel__main_2__action_3__title = "おすわり",
		action_wheel__main_2__action_4__title = "ブルブル",
		action_wheel__main_2__action_5__title = "§b夏機能§r：",
		action_wheel__main_2__action_6__title = "シネマティックモード",
		action_wheel__main_2__action_7__title = "アバター設定（使用不可）",
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
ActiveLanguage = "en"

---翻訳キーに対する訳文を返す。設定言語が存在しない場合は英語の文が返される。また、指定したキーの訳が無い場合は英語->キーそのままが返される。
---@param keyName string 翻訳キー
---@return string
function LanguageClass.getTranslate(keyName)
	return LanguageData[ActiveLanguage][keyName] and LanguageData[ActiveLanguage][keyName] or (LanguageData["en"][keyName] and LanguageData["en"][keyName] or keyName)
end

events.WORLD_TICK:register(function ()
	ActiveLanguage = client:getActiveLang() == "ja_jp" and "jp" or "en"
end)

return LanguageClass