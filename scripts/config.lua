---@class ConfigClass アバター設定を管理するクラス
---@field ConfigClass.CatType CatType 耳と尻尾のテクスチャの名前 The name of texture of ears and tails.
---@field ConfigClass.SkinName string このスキンの名前 This avatar's skin name
---@field ConfigClass.MeowSound boolean 定期的にニャーニャー鳴くかどうか Whether or not meow regularly.
---@field ConfigClass.BellVolume number 鈴の音量 Bell sound volume.
---@field ConfigClass.WaveTail boolean 尻尾を振るかどうか Whether or not wave tail.
---@field ConfigClass.HideArmor boolean 防具を隠すかどうか Whether or not hide armors.
---@field ConfigClass.AutoShake boolean 水から上がった際に自動でブルブルアクションを実行するかどうか Whether or not run body shake action automately after out of the water.
---@field ConfigClass.AFKAction boolean 放置している時に専用アニメーションを再生するかどうか Whether or not play dedicated animations when you are AFK.
---@field ConfigClass.BurnEffect boolean 黒焦げの視覚効果を有効にするかどうか Whether or not enable burn effect.
---@field ConfigClass.UseSkinName boolean スキン名を使用するかどうか Whether or not use skin name.

ConfigClass = {}

--[[
	*** NOTE ***
	2022/7/16現在、Rewrite版には、データを保存して後で読み出せるようにする機能が搭載されていません。
	つまり、Prewrite版のような設定ページが現在は作成できません！
	代わりに、下の設定値を直接変更して下さい。
	何が何を表しているのか、有効か値は何かは、上の"@field"を参照して下さい。
]]

ConfigClass.CatType = "ORIGINAL"
ConfigClass.SkinName = "Vinny"
ConfigClass.MeowSound = true
ConfigClass.BellVolume = 0.1
ConfigClass.WaveTail = true
ConfigClass.HideArmor = true
ConfigClass.AutoShake = true
ConfigClass.AFKAction = true
ConfigClass.UseSkinName = true

--- *** 設定フィールド終了 ***

return ConfigClass