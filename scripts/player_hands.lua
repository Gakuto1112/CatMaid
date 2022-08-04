---@class PlayerHandsClass アクション用のプレイヤーの腕を制御するクラス
---@field PlayerHandsRoot CustomModelPart プレイヤーの手のモデルのルート

PlayerHandsClass = {}

PlayerHandsRoot = models.models.player_hands

events.TICK:register(function()
	local main = nil
	local overlay = nil
	if player:getModelType() == "DEFAULT" then
		main = {PlayerHandsRoot.Avatar.Head.PlayerHand1.Classic1.Classic1, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2.Classic2}
		overlay = {PlayerHandsRoot.Avatar.Head.PlayerHand1.Classic1.Classic1Layer, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2.Classic2.Classic2Layer}
	else
		main = {PlayerHandsRoot.Avatar.Head.PlayerHand1.Slim1.Slim1, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2.Slim2}
		overlay = {PlayerHandsRoot.Avatar.Head.PlayerHand1.Slim1.Slim1Layer, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2.Slim2.Slim2Layer}
	end
	if player:isLeftHanded() then
		for _, modelPart in ipairs(main) do
			modelPart:setUVPixels(-8, 32)
		end
		for _, modelPart in ipairs(overlay) do
			modelPart:setUVPixels(8, 16)
		end
	else
		for _, modelPart in ipairs(main) do
			modelPart:setUVPixels(0, 0)
		end
		for _, modelPart in ipairs(overlay) do
			modelPart:setUVPixels(0, 0)
		end
	end
end)

PlayerHandsRoot:setPrimaryTexture("skin")
for _, modelPart in ipairs({PlayerHandsRoot.Avatar.Head.PlayerHand1, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2}) do
	modelPart:setVisible(false)
end
if player:getModelType() == "DEFAULT" then
	for _, modelPart in ipairs({PlayerHandsRoot.Avatar.Head.PlayerHand1.Slim1, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2.Slim2}) do
		modelPart:setVisible(false)
	end
else
	for _, modelPart in ipairs({PlayerHandsRoot.Avatar.Head.PlayerHand1.Classic1, PlayerHandsRoot.Avatar.Body.Tail.Tail1.Tail2.PlayerHand2.Classic2}) do
		modelPart:setVisible(false)
	end
end

return PlayerHandsClass