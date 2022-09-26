---@class ElytraClass エリトラのモデルを制御するクラス

ElytraClass = {}

events.TICK:register(function()
	vanilla_model.ELYTRA:setVisible(player:getPose() ~= "SLEEPING" and animations["models.main"]["sit_down"]:getPlayState() ~= "PLAYING")
end)

return ElytraClass