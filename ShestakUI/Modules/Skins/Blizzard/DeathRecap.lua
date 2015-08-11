local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DeathRecap skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DeathRecapFrame:StripTextures()
	T.SkinCloseButton(DeathRecapFrame.CloseXButton)
	DeathRecapFrame:SetTemplate("Transparent")

	for i = 1, 5 do
		local iconBorder = DeathRecapFrame["Recap"..i].SpellInfo.IconBorder
		local icon = DeathRecapFrame["Recap"..i].SpellInfo.Icon
		iconBorder:SetAlpha(0)
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		DeathRecapFrame["Recap"..i].SpellInfo:CreateBackdrop("Default")
		icon:SetParent(DeathRecapFrame["Recap"..i].SpellInfo.backdrop)
	end

	for i = 1, DeathRecapFrame:GetNumChildren() do
		local child = select(i, DeathRecapFrame:GetChildren())
		if child:GetObjectType() == "Button" and child.GetText and child:GetText() == CLOSE then
			child:SkinButton(true)
		end
	end
end

T.SkinFuncs["Blizzard_DeathRecap"] = LoadSkin