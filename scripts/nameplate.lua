---@class NameplateClass ネームプレート（プレイヤーの名前）を制御するクラス

NameplateClass = {}

events.TICK:register(function()
	if animations["models.main"]["sit_down"]:getPlayState() == "PLAYING" then
		nameplate.ENTITY:setPos(0, -0.5, 0)
	else
		nameplate.ENTITY:setPos(0, 0, 0)
	end
end)

if ConfigClass.UseSkinName and ConfigClass.SkinName ~= "" then
	for _, nameplatePart in ipairs({nameplate.CHAT, nameplate.ENTITY, nameplate.LIST}) do
		nameplatePart:setText(ConfigClass.SkinName)
	end
end

return NameplateClass