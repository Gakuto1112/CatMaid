---@class メイドスカートを制御するクラス

SkirtClass = {}

events.TICK:register(function()
	local skirt = models.models.main.Avatar.Body.Skirt
	if string.find(General.hasItem(player:getItem(5)), "chestplate$") and not ConfigClass.HideArmor then
		skirt:setVisible(false)
	else
		skirt:setVisible(true)
		skirt:setRot(General.getSneakPrevTick() and player:getPose() == "CROUCHING" and not player:isFlying() and 15 or 0, 0, 0)
	end
end)

return SkirtClass