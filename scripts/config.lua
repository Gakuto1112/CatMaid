---@class ConfigClass アバター設定を管理するクラス
---@field ConfigClass.SkinName string このスキンの名前
---@field ConfigClass.MeowSound boolean 定期的にニャーニャー鳴くかどうか
---@field ConfigClass.BellSound boolean 鈴の音を鳴らすかどうか
---@field ConfigClass.WaveTail boolean 尻尾を振るかどうか
---@field ConfigClass.HideArmor boolean 防具を隠すかどうか
---@field ConfigClass.AutoShake boolean 水から上がった際に自動でブルブルアクションを実行するかどうか
---@field ConfigClass.UseSkinName boolean スキン名を使用するかどうか

ConfigClass = {}

--[[
	*** NOTE ***
	2022/7/16現在、Rewrite版には、データを保存して後で読み出せるようにする機能が搭載されていません。
	つまり、Prewrite版のような設定ページが現在は作成できません！
	代わりに、下の設定値を直接変更して下さい。
	何が何を表しているのか、有効か値は何かは、上の"@field"を参照して下さい。
]]

ConfigClass.SkinName = "Vinny"
ConfigClass.MeowSound = true
ConfigClass.BellSound = true
ConfigClass.WaveTail = true
ConfigClass.HideArmor = true
ConfigClass.AutoShake = true
ConfigClass.UseSkinName = true

--- *** 設定フィールド終了 ***

return ConfigClass