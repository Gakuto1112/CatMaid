---@class AlternativeArmsClass アニメーション用の代替の腕を制御するクラス

AlternativeArmsClass = {}

models.models.alternative_arms:setVisible(false)
models.models.alternative_arms.Body.Arms.RightArm:setParentType("None")
models.models.alternative_arms.Body.Arms.RightArm.RightArmBottom:setParentType("None")
models.models.alternative_arms.Body.Arms.LeftArm:setParentType("None")
models.models.alternative_arms.Body.Arms.LeftArm.LeftArmBottom:setParentType("None")

return AlternativeArmsClass