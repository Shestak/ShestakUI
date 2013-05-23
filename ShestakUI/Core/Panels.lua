local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Bottom bars anchor
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", oUF_PetBattleFrameHider)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.bottom_bars))
bottombaranchor:SetWidth((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.bottombars == 2 then
	bottombaranchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		bottombaranchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
	else
		bottombaranchor:SetHeight((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	end
else
	bottombaranchor:SetHeight(C.actionbar.button_size)
end
bottombaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars anchor
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", oUF_PetBattleFrameHider)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.right_bars))
rightbaranchor:SetHeight((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.rightbars == 1 then
	rightbaranchor:SetWidth(C.actionbar.button_size)
elseif C.actionbar.rightbars == 2 then
	rightbaranchor:SetWidth((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.rightbars == 3 then
	rightbaranchor:SetWidth((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Split bar anchor
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", oUF_PetBattleFrameHider)
	SplitBarLeft:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -C.actionbar.button_space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", oUF_PetBattleFrameHider)
	SplitBarRight:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", C.actionbar.button_space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar anchor
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", oUF_PetBattleFrameHider)
petbaranchor:SetFrameStrata("LOW")
if C.actionbar.rightbars > 0 then
	if C.actionbar.petbar_horizontal == true then
		petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), (C.actionbar.button_size + C.actionbar.button_space), unpack(C.position.pet_horizontal))
	else
		petbaranchor:CreatePanel("Invisible", C.actionbar.button_size + 3, (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
	end
else
	petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size + C.actionbar.button_space), (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), unpack(C.position.right_bars))
end

----------------------------------------------------------------------------------------
--	Stance bar anchor
----------------------------------------------------------------------------------------
local shiftanchor = CreateFrame("Frame", "ShapeShiftBarAnchor", oUF_PetBattleFrameHider)
shiftanchor:RegisterEvent("PLAYER_LOGIN")
shiftanchor:RegisterEvent("PLAYER_ENTERING_WORLD")
shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
shiftanchor:SetScript("OnEvent", function(self, event, ...)
	local forms = GetNumShapeshiftForms()
	if forms > 0 then
		if C.actionbar.stancebar_horizontal ~= true then
			shiftanchor:SetWidth(C.actionbar.button_size + 3)
			shiftanchor:SetHeight((C.actionbar.button_size * forms) + ((C.actionbar.button_space * forms) - 3))
			shiftanchor:SetPoint("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
		else
			shiftanchor:SetWidth((C.actionbar.button_size * forms) + ((C.actionbar.button_space * forms) - 3))
			shiftanchor:SetHeight(C.actionbar.button_size)
			shiftanchor:SetPoint("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
		end
	end
end)

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 4, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 1)
	chatbd:SetBackdropBorderColor(unpack(C["media"].border_color))
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)

	if C.chat.tabs_mouseover ~= true then
		local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
		chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3)
		chattabs:SetBackdropBorderColor(unpack(C["media"].border_color))
		chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
	end

else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel("ClassColor", 1, C.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
	leftpanel:SetAlpha(0)
end

----------------------------------------------------------------------------------------
--	Top panel
----------------------------------------------------------------------------------------
if C.toppanel.enable ~= true then return end

local toppanelanchor = CreateFrame("Frame", "TopPanelAnchor", oUF_PetBattleFrameHider)
toppanelanchor:SetPoint(unpack(C.position.top_panel))
toppanelanchor:SetSize(C.toppanel.width, C.toppanel.height / 2)

local toppanel = CreateFrame("Frame", "TopPanel", oUF_PetBattleFrameHider)
toppanel:SetPoint("CENTER", toppanelanchor, "CENTER", 0, 0)
toppanel:SetSize(C.toppanel.width, C.toppanel.height)
toppanel:SetTemplate("Transparent")

if C.toppanel.mouseover == true then
	toppanel:SetAlpha(0)
	toppanel:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		toppanel:SetAlpha(1)
	end)
	toppanel:SetScript("OnLeave", function()
		toppanel:SetAlpha(0)
	end)
end

-- Edit by Oz of shestakdotorg --
