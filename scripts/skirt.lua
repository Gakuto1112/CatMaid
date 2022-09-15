---@class メイドスカートを制御するクラス

SkirtClass = {}

events.TICK:register(function()
	local skirt = models.models.main.Avatar.Body.BodyBottom.Skirt
	if string.find(General.hasItem(player:getItem(5)), "chestplate$") and not ConfigClass.HideArmor then
		skirt:setVisible(false)
	else
		skirt:setVisible(true)
		skirt:setRot(((player:getPose() == "CROUCHING" and not player:isFlying()) or player:getVehicle()) and 15 or 0, 0, 0)
	end
end)

return SkirtClass