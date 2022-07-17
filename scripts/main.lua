--クラスのインスタンス化
General = require("scripts/general")
ConfigClass = require("scripts/config")
--パーツ別クラス
ArmsClass = require("scripts/arms")
AlternativeArmsClass = require("scripts/alternative_arms")
HairPhysicsClass = require("scripts/hair_physics")
TailAndEarsClass = require("scripts/tail_and_ears")
EyesAndMouthClass = require("scripts/eyes_and_mouth")
BellSoundClass = require("scripts/bell_sound")
SkirtClass = require("scripts/skirt")
NameplateClass = require("scripts/nameplate")
--機能別クラス
ActionWheelClass = require("scripts/action_wheel")
MeowClass = require("scripts/meow")
HurtClass = require("scripts/hurt")
WetClass = require("scripts/wet")
WardenClass = require("scripts/warden")
CakeClass = require("scripts/cake")

--初期化処理
vanilla_model.PLAYER:setVisible(false)
if ConfigClass.HideArmor then
	vanilla_model.ARMOR:setVisible(false)
end