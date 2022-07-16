--クラスのインスタンス化
General = require("scripts/general")
--パーツ別クラス
HairPhysicsClass = require("scripts/hair_physics")
TailAndEarsClass = require("scripts/tail_and_ears")
EyesAndMouthClass = require("scripts/eyes_and_mouth")
BellSoundClass = require("scripts/bell_sound")
SkirtClass = require("scripts/skirt")
--機能別クラス
MeowClass = require("scripts/meow")
HurtClass = require("scripts/hurt")

--初期化処理
vanilla_model.PLAYER:setVisible(false)