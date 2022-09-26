events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	General = require("scripts/general")
	ConfigClass = require("scripts/config")
	LanguageClass = require("scripts/language")

	--パーツ別クラス
	ArmsClass = require("scripts/arms")
	LegsClass = require("scripts/legs")
	ElytraClass = require("scripts/elytra")
	HairPhysicsClass = require("scripts/hair_physics")
	TailAndEarsClass = require("scripts/tail_and_ears")
	FacePartsClass = require("scripts/face_parts")
	BellSoundClass = require("scripts/bell_sound")
	SkirtClass = require("scripts/skirt")
	ArmorClass = require("scripts/armor")
	NameplateClass = require("scripts/nameplate")
	PlayerHandsClass = require("scripts/player_hands")

	--機能別クラス
	ActionWheelClass = require("scripts/action_wheel")
	SitDownClass = require("scripts/sit_down")
	MeowClass = require("scripts/meow")
	HurtClass = require("scripts/hurt")
	EffectClass = require("scripts/effect")
	FoodClass = require("scripts/food")
	WetClass = require("scripts/wet")
	AFKClass = require("scripts/afk")
	SleepClass = require("scripts/sleep")
	WardenClass = require("scripts/warden")
	CakeClass = require("scripts/cake")
	CinematicModeClass = require("scripts/cinematic_mode")
	GoatHornClass = require("scripts/goat_horn")
	SummerFeatureClass = require("scripts/summer_feature")

	--初期化処理
	for _, vanillaModel in ipairs({vanilla_model.PLAYER, vanilla_model.ARMOR}) do
		vanillaModel:setVisible(false)
	end
	for _, modelPart in ipairs({models.models.main.Avatar.Body.BodyBottom, models.models.main.Avatar.Body.Arms.RightArm.RightArmBottom, models.models.main.Avatar.Body.Arms.LeftArm.LeftArmBottom, models.models.main.Avatar.Body.BodyBottom.Legs.RightLeg.RightLegBottom, models.models.main.Avatar.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom}) do
		modelPart:setParentType("None")
	end
end)