local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Bottom bars anchor
----------------------------------------------------------------------------------------
local BottomBarAnchor = CreateFrame("Frame", "ActionBarAnchor", T_PetBattleFrameHider)
BottomBarAnchor:CreatePanel("Invisible", 1, 1, unpack(C.position.bottom_bars))
BottomBarAnchor:SetWidth((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.bottombars == 2 then
	BottomBarAnchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		BottomBarAnchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
	else
		BottomBarAnchor:SetHeight((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	end
else
	BottomBarAnchor:SetHeight(C.actionbar.button_size)
end
BottomBarAnchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars anchor
----------------------------------------------------------------------------------------
local RightBarAnchor = CreateFrame("Frame", "RightActionBarAnchor", T_PetBattleFrameHider)
RightBarAnchor:CreatePanel("Invisible", 1, 1, unpack(C.position.right_bars))
RightBarAnchor:SetHeight((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.rightbars == 1 then
	RightBarAnchor:SetWidth(C.actionbar.button_size)
elseif C.actionbar.rightbars == 2 then
	RightBarAnchor:SetWidth((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.rightbars == 3 then
	RightBarAnchor:SetWidth((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
else
	RightBarAnchor:Hide()
end
RightBarAnchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Split bar anchor
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", T_PetBattleFrameHider)
	SplitBarLeft:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -C.actionbar.button_space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", T_PetBattleFrameHider)
	SplitBarRight:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", C.actionbar.button_space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar anchor
----------------------------------------------------------------------------------------
local PetBarAnchor = CreateFrame("Frame", "PetActionBarAnchor", T_PetBattleFrameHider)
if C.actionbar.petbar_horizontal == true then
	PetBarAnchor:CreatePanel("Invisible", (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), (C.actionbar.button_size + C.actionbar.button_space), unpack(C.position.pet_horizontal))
elseif C.actionbar.rightbars > 0 then
	PetBarAnchor:CreatePanel("Invisible", C.actionbar.button_size + C.actionbar.button_space, (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), "RIGHT", RightBarAnchor, "LEFT", 0, 0)
else
	PetBarAnchor:CreatePanel("Invisible", (C.actionbar.button_size + C.actionbar.button_space), (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), unpack(C.position.right_bars))
end
PetBarAnchor:SetFrameStrata("LOW")
RegisterStateDriver(PetBarAnchor, "visibility", "[pet,novehicleui,nopossessbar,nopetbattle] show; hide")

----------------------------------------------------------------------------------------
--	Stance bar anchor
----------------------------------------------------------------------------------------
local StanceAnchor = CreateFrame("Frame", "StanceBarAnchor", T_PetBattleFrameHider)
if C.actionbar.stancebar_horizontal == true then
	if C.actionbar.petbar_horizontal == true then
		StanceAnchor:SetPoint(C.position.stance_bar[1], C.position.stance_bar[2], C.position.stance_bar[3], C.position.stance_bar[4], C.position.stance_bar[5] - (C.actionbar.button_size + C.actionbar.button_space))
	else
		StanceAnchor:SetPoint(unpack(C.position.stance_bar))
	end
	StanceAnchor:SetWidth((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
	StanceAnchor:SetHeight(C.actionbar.button_size)
else
	if C.actionbar.petbar_horizontal == true then
		StanceAnchor:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2)
	else
		StanceAnchor:SetPoint("RIGHT", PetActionBarAnchor:IsShown() and "PetActionBarAnchor" or "RightActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2)
		PetBarAnchor:HookScript("OnShow", function() StanceAnchor:SetPoint("RIGHT", "PetActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2) end)
		PetBarAnchor:HookScript("OnHide", function() StanceAnchor:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2) end)
	end
	StanceAnchor:SetWidth(C.actionbar.button_size + C.actionbar.button_space)
	StanceAnchor:SetHeight((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
end

StanceAnchor:RegisterEvent("PLAYER_LOGIN")
StanceAnchor:SetScript("OnEvent", function()
	local forms = GetNumShapeshiftForms()
	if forms > 0 then
		if C.actionbar.stancebar_horizontal == true then
			StanceAnchor:SetWidth((C.actionbar.button_size * forms) + (C.actionbar.button_space * (forms - 1)))
		else
			StanceAnchor:SetHeight((C.actionbar.button_size * forms) + (C.actionbar.button_space * (forms - 1)))
		end
	end
end)

----------------------------------------------------------------------------------------
--	Bottom line
----------------------------------------------------------------------------------------
local bottompanel = CreateFrame("Frame", "BottomPanel", UIParent)
bottompanel:CreatePanel("ClassColor", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:SetPoint("LEFT", UIParent, "LEFT", 21, 0)
bottompanel:SetPoint("RIGHT", UIParent, "RIGHT", -21, 0)

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 4, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 1)
	chatbd:SetBackdropBorderColor(unpack(C.media.classborder_color))
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)

	if C.chat.tabs_mouseover ~= true then
		local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
		chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3)
		chattabs:SetBackdropBorderColor(unpack(C.media.classborder_color))
		chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
	end
else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel("ClassColor", 1, C.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
end

----------------------------------------------------------------------------------------
--	Top panel
----------------------------------------------------------------------------------------
if C.toppanel.enable ~= true then return end

C.toppanel.height = C.toppanel.height + ((C.font.stats_font_size - 8) * 7)
C.toppanel.width = C.toppanel.width + ((C.font.stats_font_size - 8) * 3)

local toppanelanchor = CreateFrame("Frame", "TopPanelAnchor", T_PetBattleFrameHider)
toppanelanchor:SetPoint(unpack(C.position.top_panel))
toppanelanchor:SetSize(C.toppanel.width, C.toppanel.height / 2)

local toppanel = CreateFrame("Frame", "TopPanel", T_PetBattleFrameHider)
toppanel:SetPoint("CENTER", toppanelanchor, "CENTER", 0, 0)
toppanel:SetSize(C.toppanel.width, C.toppanel.height / 2)
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

local r, g, b = unpack(C.media.classborder_color)
toppanel.bgl = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgl:SetPoint("RIGHT", toppanel, "CENTER", 0, 0)
toppanel.bgl:SetSize(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgl:SetTexture(C.media.blank)
toppanel.bgl:SetGradientAlpha("HORIZONTAL", r, g, b, 0, r, g, b, 0.1)

toppanel.bgr = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgr:SetPoint("LEFT", toppanel, "CENTER", 0, 0)
toppanel.bgr:SetSize(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgr:SetTexture(C.media.blank)
toppanel.bgr:SetGradientAlpha("HORIZONTAL", r, g, b, 0.1, r, g, b, 0)

toppanel.tbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tbl:SetSize(C.toppanel.width / 2, 3)
toppanel.tbl:SetTexture(C.media.blank)
toppanel.tbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.tcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tcl:SetSize(C.toppanel.width / 2, 1)
toppanel.tcl:SetTexture(C.media.blank)
toppanel.tcl:SetGradientAlpha("HORIZONTAL", r, g, b, 0, r, g, b, 1)

toppanel.tbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tbr:SetSize(C.toppanel.width / 2, 3)
toppanel.tbr:SetTexture(C.media.blank)
toppanel.tbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.tcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tcr:SetSize(C.toppanel.width / 2, 1)
toppanel.tcr:SetTexture(C.media.blank)
toppanel.tcr:SetGradientAlpha("HORIZONTAL", r, g, b, 1, r, g, b, 0)

toppanel.bbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bbl:SetSize(C.toppanel.width / 2, 3)
toppanel.bbl:SetTexture(C.media.blank)
toppanel.bbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.bcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bcl:SetSize(C.toppanel.width / 2, 1)
toppanel.bcl:SetTexture(C.media.blank)
toppanel.bcl:SetGradientAlpha("HORIZONTAL", r, g, b, 0, r, g, b, 1)

toppanel.bbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bbr:SetSize(C.toppanel.width / 2, 3)
toppanel.bbr:SetTexture(C.media.blank)
toppanel.bbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.bcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bcr:SetSize(C.toppanel.width / 2, 1)
toppanel.bcr:SetTexture(C.media.blank)
toppanel.bcr:SetGradientAlpha("HORIZONTAL", r, g, b, 1, r, g, b, 0)