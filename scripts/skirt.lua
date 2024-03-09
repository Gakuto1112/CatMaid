---@class メイドスカートを制御するクラス

SkirtClass = {}

events.TICK:register(function()
	local skirt = models.models.main.Avatar.Torso.Body.BodyBottom.Skirt
	if string.find(General.hasItem(player:getItem(5)), "chestplate$") and not ArmorClass.ShowArmor then
		skirt:setVisible(false)
	else
		skirt:setVisible(true)
		skirt:setRot(((player:isCrouching() and not not General.Flying) or player:getVehicle()) and 15 or 0, 0, 0)
	end
end)

return SkirtClass