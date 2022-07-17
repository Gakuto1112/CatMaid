---@class ElytraClass エリトラのモデルを制御するクラス

ElytraClass = {}

events.TICK:register(function()
	vanilla_model.ELYTRA:setVisible(player:getPose() ~= "SLEEPING" and animation["main"]["sit_down"]:getPlayState() ~= "PLAYING")
end)

return ElytraClass