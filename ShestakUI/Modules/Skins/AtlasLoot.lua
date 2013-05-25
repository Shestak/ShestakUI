local T, C, L, _ = unpack(select(2, ...))
if C.skins.atlasloot ~= true then return end

----------------------------------------------------------------------------------------
--	AtlasLoot skin(by Camealion)
----------------------------------------------------------------------------------------
local function AL_OnShow(self, event, ...)
	AtlasLootPanel:SetPoint("TOP", AtlasLootDefaultFrame, "BOTTOM", 0, -1)
	AtlasLootQuickLooksButton:SetPoint("BOTTOM", AtlasLootItemsFrame, "BOTTOM", 53, 33)
	AtlasLootPanelSearch_Box:ClearAllPoints()
	AtlasLootPanelSearch_Box:SetPoint("BOTTOMRIGHT", AtlasLootPanel, "BOTTOM", 0, 27)
	AtlasLootPanelSearch_SearchButton:SetPoint("LEFT", AtlasLootPanelSearch_Box, "RIGHT", 5, 0)
	AtlasLootPanelSearch_SelectModuel:SetPoint("LEFT", AtlasLootPanelSearch_SearchButton, "RIGHT", 3, 0)
	AtlasLootPanelSearch_ClearButton:SetPoint("LEFT", AtlasLootPanelSearch_SelectModuel, "RIGHT", 3, 0)
	AtlasLootPanelSearch_LastResultButton:SetPoint("LEFT", AtlasLootPanelSearch_ClearButton, "RIGHT", 3, 0)
	AtlasLoot10Man25ManSwitch:SetPoint("BOTTOM", AtlasLootItemsFrame, "BOTTOM", -130, 4)
	if AtlasLoot_PanelButton_2 then AtlasLoot_PanelButton_2:SetPoint("LEFT", AtlasLoot_PanelButton_1, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_3 then AtlasLoot_PanelButton_3:SetPoint("LEFT", AtlasLoot_PanelButton_2, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_4 then AtlasLoot_PanelButton_4:SetPoint("LEFT", AtlasLoot_PanelButton_3, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_5 then AtlasLoot_PanelButton_5:SetPoint("LEFT", AtlasLoot_PanelButton_4, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_7 then AtlasLoot_PanelButton_7:SetPoint("LEFT", AtlasLoot_PanelButton_6, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_8 then AtlasLoot_PanelButton_8:SetPoint("LEFT", AtlasLoot_PanelButton_7, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_9 then AtlasLoot_PanelButton_9:SetPoint("LEFT", AtlasLoot_PanelButton_8, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_10 then AtlasLoot_PanelButton_10:SetPoint("LEFT", AtlasLoot_PanelButton_9, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_12 then AtlasLoot_PanelButton_12:SetPoint("LEFT", AtlasLoot_PanelButton_11, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_13 then AtlasLoot_PanelButton_13:SetPoint("LEFT", AtlasLoot_PanelButton_12, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_14 then AtlasLoot_PanelButton_14:SetPoint("LEFT", AtlasLoot_PanelButton_13, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_15 then AtlasLoot_PanelButton_15:SetPoint("LEFT", AtlasLoot_PanelButton_14, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_17 then AtlasLoot_PanelButton_17:SetPoint("LEFT", AtlasLoot_PanelButton_16, "RIGHT", 3, 0) end
	if AtlasLoot_PanelButton_18 then AtlasLoot_PanelButton_18:SetPoint("LEFT", AtlasLoot_PanelButton_17, "RIGHT", 3, 0) end
	AtlasLootCompareFrameSortButton_Rarity:SetPoint("LEFT", AtlasLootCompareFrameSortButton_Name, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_1:SetPoint("LEFT", AtlasLootCompareFrameSortButton_Rarity, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_2:SetPoint("LEFT", AtlasLootCompareFrameSortButton_1, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_3:SetPoint("LEFT", AtlasLootCompareFrameSortButton_2, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_4:SetPoint("LEFT", AtlasLootCompareFrameSortButton_3, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_5:SetPoint("LEFT", AtlasLootCompareFrameSortButton_4, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_6:SetPoint("LEFT", AtlasLootCompareFrameSortButton_5, "RIGHT", 1, 0)
	AtlasLootCompareFrame_CloseButton2:SetPoint("BOTTOMRIGHT", AtlasLootCompareFrame, "BOTTOMRIGHT", -7, 10)
	AtlasLootCompareFrame_WishlistButton:SetPoint("RIGHT", AtlasLootCompareFrame_CloseButton2, "LEFT", -1, 0)
	AtlasLootCompareFrameSearch_SearchButton:SetPoint("LEFT", AtlasLootCompareFrameSearch_Box, "RIGHT", 5, 0)
	AtlasLootCompareFrameSearch_SelectModuel:SetPoint("LEFT", AtlasLootCompareFrameSearch_SearchButton, "RIGHT", 5, 0)
	AtlasLootPanelSearch_Box:SetHeight(16)
end

local function Nine_IsThere(Self, event, ...)
	for i = 1, 9 do
		local f = _G["AtlasLootCompareFrameSortButton_"..i]
		f:SetWidth(44)
	end

	local StripAllTextures = {
		"AtlasLootCompareFrameSortButton_7",
		"AtlasLootCompareFrameSortButton_8",
		"AtlasLootCompareFrameSortButton_9",
	}

	local SetTemplateD = {
		"AtlasLootCompareFrameSortButton_7",
		"AtlasLootCompareFrameSortButton_8",
		"AtlasLootCompareFrameSortButton_9",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, object in pairs(SetTemplateD) do
		_G[object]:SetTemplate("Default")
	end

	AtlasLootCompareFrameSortButton_7:SetPoint("LEFT", AtlasLootCompareFrameSortButton_6, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_8:SetPoint("LEFT", AtlasLootCompareFrameSortButton_7, "RIGHT", 1, 0)
	AtlasLootCompareFrameSortButton_9:SetPoint("LEFT", AtlasLootCompareFrameSortButton_8, "RIGHT", 1, 0)
end

local function Compare_OnShow(self, event, ...)
	for i = 1, 6 do
		local f = _G["AtlasLootCompareFrameSortButton_"..i]
		f:SetWidth(67)
	end

	local Nine = AtlasLootCompareFrameSortButton_9
	if Nine ~= nil then
		Nine:SetScript("OnUpdate", Nine_IsThere)
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	if not IsAddOnLoaded("AtlasLoot") then return end

	local FrameShow = AtlasLootDefaultFrame
	FrameShow:SetScript("OnUpdate", AL_OnShow)

	local CompareFrameShow = AtlasLootCompareFrame
	CompareFrameShow:SetScript("OnUpdate", Compare_OnShow)

	local StripAllTextures = {
		"AtlasLootDefaultFrame",
		"AtlasLootItemsFrame",
		"AtlasLootPanel",
		"AtlasLootCompareFrame",
		"AtlasLootCompareFrame_ScrollFrameMainFilterScrollChildFrame",
		"AtlasLootCompareFrame_ScrollFrameItemFrameScrollChildFrame",
		"AtlasLootCompareFrame_ScrollFrameItemFrame",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item1",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item2",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item3",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item4",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item5",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item6",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item7",
		"AtlasLootCompareFrame_ScrollFrameItemFrame_Item8",
		"AtlasLootCompareFrame_ScrollFrameMainFilter",
		"AtlasLootCompareFrame_Wishlist",
		"AtlasLootCompareFrameSortButton_Name",
		"AtlasLootCompareFrameSortButton_Rarity",
		"AtlasLootCompareFrameSortButton_1",
		"AtlasLootCompareFrameSortButton_2",
		"AtlasLootCompareFrameSortButton_3",
		"AtlasLootCompareFrameSortButton_4",
		"AtlasLootCompareFrameSortButton_5",
		"AtlasLootCompareFrameSortButton_6",
	}

	local SetTemplate = {
		"AtlasLootDefaultFrame",
		"AtlasLootCompareFrame",
		"AtlasLootItemsFrame",
		"AtlasLootCompareFrameSortButton_Name",
		"AtlasLootCompareFrameSortButton_Rarity",
		"AtlasLootCompareFrameSortButton_1",
		"AtlasLootCompareFrameSortButton_2",
		"AtlasLootCompareFrameSortButton_3",
		"AtlasLootCompareFrameSortButton_4",
		"AtlasLootCompareFrameSortButton_5",
		"AtlasLootCompareFrameSortButton_6",
		"AtlasLootCompareFrame_Wishlist",
	}

	local buttons = {
		"AtlasLoot_AtlasInfoFrame_ToggleALButton",
		"AtlasLootPanelSearch_SearchButton",
		"AtlasLootDefaultFrame_CompareFrame",
		"AtlasLootPanelSearch_ClearButton",
		"AtlasLootPanelSearch_LastResultButton",
		"AtlasLoot10Man25ManSwitch",
		"AtlasLootItemsFrame_BACK",
		"AtlasLootCompareFrameSearch_ClearButton",
		"AtlasLootCompareFrameSearch_SearchButton",
		"AtlasLootCompareFrame_WishlistButton",
		"AtlasLootCompareFrame_CloseButton2",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, object in pairs(SetTemplate) do
		_G[object]:SetTemplate("Transparent")
	end

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end

	for i = 1, 18 do
		local f = _G["AtlasLoot_PanelButton_"..i]
		if f then
			f:SkinButton()
		end
	end

	for i = 1, 15 do
		local f = _G["AtlasLootCompareFrameMainFilterButton"..i]
		if f then
			f:StripTextures()
		end
	end

	for i = 1, 30 do
		local icon = _G["AtlasLootItem_"..i.."_Icon"]
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	AtlasLootPanel:CreateBackdrop("Transparent")
	AtlasLootPanel.backdrop:SetPoint("TOPLEFT", AtlasLootPanel, "TOPLEFT", 0, 0)
	AtlasLootPanel.backdrop:SetPoint("BOTTOMRIGHT", AtlasLootPanel, "BOTTOMRIGHT", 0, -3)

	T.SkinCloseButton(AtlasLootDefaultFrame_CloseButton)
	T.SkinCloseButton(AtlasLootDefaultFrame_LockButton, nil, "-")
	AtlasLootDefaultFrame_LockButton:ClearAllPoints()
	AtlasLootDefaultFrame_LockButton:SetPoint("RIGHT", AtlasLootDefaultFrame_CloseButton, "LEFT", -3, 0)
	T.SkinCloseButton(AtlasLootCompareFrame_CloseButton)
	T.SkinCloseButton(AtlasLootCompareFrame_CloseButton_Wishlist)

	T.SkinNextPrevButton(AtlasLootQuickLooksButton)
	T.SkinNextPrevButton(AtlasLootItemsFrame_NEXT)
	T.SkinNextPrevButton(AtlasLootItemsFrame_PREV)
	T.SkinNextPrevButton(AtlasLootPanelSearch_SelectModuel)
	AtlasLootPanelSearch_SelectModuel:SetSize(CharacterFrameExpandButton:GetWidth() + 2, CharacterFrameExpandButton:GetWidth() + 2)
	T.SkinNextPrevButton(AtlasLootCompareFrameSearch_SelectModuel)

	T.SkinDropDownBox(AtlasLootDefaultFrame_ModuleSelect, 225)
	T.SkinDropDownBox(AtlasLootDefaultFrame_InstanceSelect, 225)
	T.SkinDropDownBox(AtlasLootCompareFrameSearch_StatsListDropDown, 240)
	T.SkinDropDownBox(AtlasLootCompareFrame_WishlistDropDown, 200)

	T.SkinEditBox(AtlasLootPanelSearch_Box)
	T.SkinEditBox(AtlasLootCompareFrameSearch_Box)

	T.SkinCheckBox(AtlasLootFilterCheck)
	T.SkinCheckBox(AtlasLootItemsFrame_Heroic)
	T.SkinCheckBox(AtlasLootItemsFrame_RaidFinder)
	T.SkinCheckBox(AtlasLootItemsFrame_Thunderforged)
	T.SkinCheckBox(AtlasLootCompareFrameSearch_FilterCheck)

	T.SkinScrollBar(AtlasLootCompareFrame_ScrollFrameItemFrameScrollBar)
	T.SkinScrollBar(AtlasLootCompareFrame_WishlistScrollFrameScrollBar)
end)