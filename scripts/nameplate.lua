---@class NameplateClass ネームプレート（プレイヤーの名前）を制御するクラス

NameplateClass = {}

if ConfigClass.UseSkinName and ConfigClass.SkinName ~= "" then
	for _, nameplatePart in pairs(nameplate) do
		nameplatePart:setText(ConfigClass.SkinName)
	end
end

return NameplateClass