local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MissingLootFrame skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	_G["MissingLootFrame"]:SetTemplate("Transparent")
	_G["MissingLootFrameCorner"]:Kill()
	_G["MissingLootFrameItem1NameFrame"]:Kill()

	T.SkinCloseButton(_G["MissingLootFramePassButton"])

	--[[_G["MissingLootFrameItem1"]:StyleButton()
	_G["MissingLootFrameItem1"]:SetTemplate("Default")
	_G["MissingLootFrameItem1NameFrame"]:Kill()
	_G["MissingLootFrameItem1IconQuestTexture"]:Kill()]]

	--[[local numItems = GetNumMissingLootItems()

	for index = 1, numItems do
		local itemButton = _G["MissingLootFrameItem"..i]

		itemButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		itemButton.icon:ClearAllPoints()
		itemButton.icon:Point("TOPLEFT", 2, -2)
		itemButton.icon:Point("BOTTOMRIGHT", -2, 2)

		itemButton:StyleButton()
		itemButton:SetTemplate("Default")
		_G["MissingLootFrameItem"..i.."NameFrame"]:Kill()
	end]]
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)