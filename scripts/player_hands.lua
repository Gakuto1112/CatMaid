---@class PlayerHandsClass アクション用のプレイヤーの腕を制御するクラス
---@field PlayerHandsRoot CustomModelPart プレイヤーの手のモデルのルート

PlayerHandsClass = {}

PlayerHandsRoot = models.models.player_hands

events.TICK:register(function()
	local main = nil
	local overlay = nil
	if player:getModelType() == "DEFAULT" then
		main = PlayerHandsRoot.Avatar.Head.PlayerHand1.Classic.Classic1
		overlay = PlayerHandsRoot.Avatar.Head.PlayerHand1.Classic.Classic1Layer
	else
		main = PlayerHandsRoot.Avatar.Head.PlayerHand1.Slim.Slim1
		overlay = PlayerHandsRoot.Avatar.Head.PlayerHand1.Slim.Slim1Layer
	end
	if player:isLeftHanded() then
		main:setUVPixels(-8, 32)
		overlay:setUVPixels(8, 16)
	else
		for _, modelPart in ipairs({main, overlay}) do
			modelPart:setUVPixels(0, 0)
		end
	end
end)

PlayerHandsRoot:setPrimaryTexture("skin")
PlayerHandsRoot.Avatar.Head.PlayerHand1:setVisible(false)
if player:getModelType() == "DEFAULT" then
	PlayerHandsRoot.Avatar.Head.PlayerHand1.Slim:setVisible(false)
else
	PlayerHandsRoot.Avatar.Head.PlayerHand1.Classic:setVisible(false)
end

return PlayerHandsClass