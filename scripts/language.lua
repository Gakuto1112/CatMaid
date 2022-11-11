---@class LanguageClass アバターの表示言語を管理するクラス
---@field LanguageData table 言語データ
---@field ActiveLanguage string 設定言語

LanguageClass = {}

LanguageData = {
	en = {
		message__custom_sound_unavailable = "§cNo permission to play custom sounds!§rAn alternative sound will be used as bell sound.",
		unit__percent = "%",
		cat_type__original = "Original",
		cat_type__all_black = "All black",
		cat_type__black = "Black",
		cat_type__british_shorthair = "British shorthair",
		cat_type__calico = "Calico",
		cat_type__gley_tabby = "Gray tabby",
		cat_type__jellie = "Jellie",
		cat_type__ocelot = "Ocelot",
		cat_type__persian = "Persian",
		cat_type__ragdoll = "Ragdoll",
		cat_type__red = "Red",
		cat_type__siamese = "Siamese",
		cat_type__tabby = "Tabby",
		cat_type__white = "White",
		action_wheel__toggle_off = "§coff",
		action_wheel__toggle_on = "§aon",
		action_wheel__main__page_switch__title = "page switch (scroll): ",
		action_wheel__close_to_confirm = "(Close action wheel to confirm.)",
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
		action_wheel__main_2__action_7__title = "Avatar config",
		action_wheel__config__action_1__title = "Cat type §7(scroll)§r: ",
		action_wheel__config__action_1__done_first = "Changed cat type to §b",
		action_wheel__config__action_1__done_last = "§r!",
		action_wheel__config__action_2__title = "Bell sound §7(scroll)§r: ",
		action_wheel__config__action_2__done_first = "Changed bell sound to §b",
		action_wheel__config__action_2__done_last = "§r!",
		action_wheel__config__action_3__title = "Meow sound: ",
		action_wheel__config__action_4__title = "Wag tail: ",
		action_wheel__config__action_5__title = "Hide armor: ",
		action_wheel__config__action_6__title = "Auto shake: ",
		action_wheel__config__action_7__title = "AFK action: ",
		key__jump = "Jump",
		key__attack = "Attack",
		key__afk_check = "for AFK check"
	},
	jp = {
		message__custom_sound_unavailable = "§cカスタムサウンドを再生する権限がありません！§r鈴の音は代替サウンドが使用されます。",
		unit__percent = "%",
		cat_type__original = "オリジナル",
		cat_type__all_black = "真っ黒",
		cat_type__black = "黒",
		cat_type__british_shorthair = "ブリティッシュショートヘアー",
		cat_type__calico = "ミケネコ",
		cat_type__gley_tabby = "灰トラ",
		cat_type__jellie = "ジェリー",
		cat_type__ocelot = "ヤマネコ",
		cat_type__persian = "ペルシャ",
		cat_type__ragdoll = "ラグドール",
		cat_type__red = "赤",
		cat_type__siamese = "シャム",
		cat_type__tabby = "トラ",
		cat_type__white = "白",
		action_wheel__toggle_off = "§cオフ",
		action_wheel__toggle_on = "§aオン",
		action_wheel__main__page_switch__title = "ページ切り替え（スクロール）：",
		action_wheel__close_to_confirm = "（アクションホイールを閉じて確定）",
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
		action_wheel__main_2__action_7__title = "アバター設定",
		action_wheel__config__action_1__title = "ネコの種類 §7（スクロール）§r: ",
		action_wheel__config__action_1__done_first = "ネコの種類を§b",
		action_wheel__config__action_1__done_last = "§rに変更しました。",
		action_wheel__config__action_2__title = "鈴の音量 §7（スクロール）§r: ",
		action_wheel__config__action_2__done_first = "鈴の音量を§b",
		action_wheel__config__action_2__done_last = "§rに変更しました。",
		action_wheel__config__action_3__title = "ネコの鳴き声：",
		action_wheel__config__action_4__title = "尻尾を振る：",
		action_wheel__config__action_5__title = "防具を隠す：",
		action_wheel__config__action_6__title = "自動ブルブル：",
		action_wheel__config__action_7__title = "AFKアクション：",
		key__jump = "ジャンプ",
		key__attack = "攻撃",
		key__afk_check = "AFK復帰判定用"
	}
}
ActiveLanguage = client:getActiveLang() == "ja_jp" and "jp" or "en"

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