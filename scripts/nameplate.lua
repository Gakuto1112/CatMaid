---@class NameplateClass ネームプレート（プレイヤーの名前）を制御するクラス
---@field SkinName string プレイヤーの表示名

NameplateClass = {}
SkinName = ConfigClass.loadConfig("skinName", "")

events.TICK:register(function()
	if animations["models.main"]["sit_down"]:getPlayState() == "PLAYING" then
		nameplate.ENTITY:setPos(0, -0.5, 0)
	else
		nameplate.ENTITY:setPos(0, 0, 0)
	end
end)

if SkinName ~= "" then
	nameplate.ALL:setText(SkinName)
end

return NameplateClass