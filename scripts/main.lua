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
ArmorClass = require("scripts/armor")
NameplateClass = require("scripts/nameplate")
--機能別クラス
ActionWheelClass = require("scripts/action_wheel")
MeowClass = require("scripts/meow")
HurtClass = require("scripts/hurt")
FavoriteFoodClass = require("scripts/favorite_food")
WetClass = require("scripts/wet")
AFKClass = require("scripts/afk")
SleepClass = require("scripts/sleep")
WardenClass = require("scripts/warden")
CakeClass = require("scripts/cake")
GoatHornClass = require("scripts/goat_horn")

--初期化処理
vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)