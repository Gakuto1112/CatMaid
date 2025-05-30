events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	General = require("scripts/general")
	StringUtils = require("scripts.string_utils")
	ConfigClass = require("scripts/config")
	LanguageClass = require("scripts/language")

	--パーツ別クラス
	ArmsClass = require("scripts/arms")
	LegsClass = require("scripts/legs")
	HairPhysicsClass = require("scripts/hair_physics")
	TailAndEarsClass = require("scripts/tail_and_ears")
	FacePartsClass = require("scripts/face_parts")
	BellSoundClass = require("scripts/bell_sound")
	SkirtClass = require("scripts/skirt")
	ArmorClass = require("scripts/armor")
	NameplateClass = require("scripts/nameplate")
	PlayerHandsClass = require("scripts/player_hands")

	--機能別クラス
	UpdateChecker = require("scripts.update_checker")
	ActionWheelClass = require("scripts/action_wheel")
	SitDownClass = require("scripts/sit_down")
	MeowClass = require("scripts/meow")
	EffectClass = require("scripts/effect")
	FoodClass = require("scripts/food")
	WetClass = require("scripts/wet")
	AFKClass = require("scripts/afk")
	SleepClass = require("scripts/sleep")
	WardenClass = require("scripts/warden")
	CakeClass = require("scripts/cake")
	GoatHornClass = require("scripts/goat_horn")
	SummerFeatureClass = require("scripts/summer_feature")

	--初期化処理
	for _, vanillaModel in ipairs({vanilla_model.PLAYER, vanilla_model.CHESTPLATE, vanilla_model.LEGGINGS, vanilla_model.BOOTS}) do
		vanillaModel:setVisible(false)
	end
	for _, modelPart in ipairs({models.models.main.Avatar.Torso.Body.BodyBottom, models.models.main.Avatar.Torso.Arms.RightArm.RightArmBottom, models.models.main.Avatar.Torso.Arms.LeftArm.LeftArmBottom, models.models.main.Avatar.Torso.Body.BodyBottom.Legs.RightLeg.RightLegBottom, models.models.main.Avatar.Torso.Body.BodyBottom.Legs.LeftLeg.LeftLegBottom}) do
		modelPart:setParentType("None")
	end
end)

--ENTITY_INITを待たず読み込むクラス
DynamicHeadModels = require("scripts.dynamic_head_models")