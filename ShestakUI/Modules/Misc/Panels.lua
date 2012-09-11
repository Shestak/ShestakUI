local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Bottom bars panel
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", UIParent)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.bottom_bars))
bottombaranchor:Width((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.bottombars == 2 then
	bottombaranchor:Height((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		bottombaranchor:Height((C.actionbar.button_size * 2) + C.actionbar.button_space)
	else
		bottombaranchor:Height((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	end
else
	bottombaranchor:Height(C.actionbar.button_size)
end
bottombaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars panel
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", UIParent)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.right_bars))
rightbaranchor:Height((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.rightbars == 1 then
	rightbaranchor:Width(C.actionbar.button_size)
elseif C.actionbar.rightbars == 2 then
	rightbaranchor:Width((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.rightbars == 3 then
	rightbaranchor:Width((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("BACKGROUND")

----------------------------------------------------------------------------------------
--	Split bar panels
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", UIParent)
	SplitBarLeft:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -C.actionbar.button_space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", UIParent)
	SplitBarRight:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 2), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", C.actionbar.button_space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar panel
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", UIParent)
if C.actionbar.rightbars > 0 then
	if C.actionbar.petbar_horizontal == true then
		petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), (C.actionbar.button_size + C.actionbar.button_space), unpack(C.position.pet_horizontal))
	else
		petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size + C.actionbar.button_space), (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
	end
else
	petbaranchor:CreatePanel("Invisible", (C.actionbar.button_size + C.actionbar.button_space), (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), unpack(C.position.right_bars))
end

----------------------------------------------------------------------------------------
--	Stance bar panel
----------------------------------------------------------------------------------------
if C.actionbar.stancebar_hide ~= true then
	local shiftanchor = CreateFrame("Frame", "ShapeShiftBarAnchor", UIParent)
	shiftanchor:RegisterEvent("PLAYER_LOGIN")
	shiftanchor:RegisterEvent("PLAYER_ENTERING_WORLD")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	shiftanchor:SetScript("OnEvent", function(self, event, ...)
		local forms = GetNumShapeshiftForms()
		if forms > 0 then
			if C.actionbar.stancebar_horizontal ~= true then
				shiftanchor:Width(C.actionbar.button_size)
				shiftanchor:Height((C.actionbar.button_size * forms) + ((C.actionbar.button_space * forms) - 3 ))
				shiftanchor:Point("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
			else
				shiftanchor:Width((C.actionbar.button_size * forms) + ((C.actionbar.button_space * forms) - 3))
				shiftanchor:Height(C.actionbar.button_size)
				shiftanchor:Point("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Bottom panel
----------------------------------------------------------------------------------------
local bottompanel = CreateFrame("Frame", "BottomPanel", UIParent)
bottompanel:CreatePanel("Default", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:Point("LEFT", UIParent, "LEFT", 21, 0)
bottompanel:Point("RIGHT", UIParent, "RIGHT", -21, 0)

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 4, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 1)
	chatbd:SetBackdropBorderColor(unpack(C.media.border_color))
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)

	local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
	chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3)
	chattabs:SetBackdropBorderColor(unpack(C.media.border_color))
	chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel("Default", 1, C.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
end

local rightpanel = CreateFrame("Frame", "RightPanel", UIParent)
rightpanel:CreatePanel("Default", 1, 133, "BOTTOMRIGHT", bottompanel, "RIGHT", 0, 0)

----------------------------------------------------------------------------------------
--	Top panel
----------------------------------------------------------------------------------------
if C.toppanel.enable ~= true then return end

-- Create anchor
local toppanelanchor = CreateFrame("Frame", "TopPanelAnchor", UIParent)
toppanelanchor:Point(unpack(C.position.top_panel))
toppanelanchor:Size(C.toppanel.width, C.toppanel.height / 2)

local toppanel = CreateFrame("Frame", "TopPanel", UIParent)
toppanel:Point("CENTER", toppanelanchor, "CENTER", 0, 0)
toppanel:Size(C.toppanel.width, C.toppanel.height / 2)
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

toppanel.bgl = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgl:Point("RIGHT", toppanel, "CENTER", 0, 0)
toppanel.bgl:Size(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgl:SetTexture(C.media.blank)
toppanel.bgl:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0, T.color.r, T.color.g, T.color.b, 0.1)

toppanel.bgr = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgr:Point("LEFT", toppanel, "CENTER", 0, 0)
toppanel.bgr:Size(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgr:SetTexture(C.media.blank)
toppanel.bgr:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0.1, T.color.r, T.color.g, T.color.b, 0)

toppanel.tbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbl:Point("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tbl:Size(C.toppanel.width / 2, 3)
toppanel.tbl:SetTexture(C.media.blank)
toppanel.tbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.tcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcl:Point("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tcl:Size(C.toppanel.width / 2, 1)
toppanel.tcl:SetTexture(C.media.blank)
toppanel.tcl:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0, T.color.r, T.color.g, T.color.b, 1)

toppanel.tbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbr:Point("LEFT", toppanel, "TOP", 0, 0)
toppanel.tbr:Size(C.toppanel.width / 2, 3)
toppanel.tbr:SetTexture(C.media.blank)
toppanel.tbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.tcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcr:Point("LEFT", toppanel, "TOP", 0, 0)
toppanel.tcr:Size(C.toppanel.width / 2, 1)
toppanel.tcr:SetTexture(C.media.blank)
toppanel.tcr:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 1, T.color.r, T.color.g, T.color.b, 0)

toppanel.bbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbl:Point("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bbl:Size(C.toppanel.width / 2, 3)
toppanel.bbl:SetTexture(C.media.blank)
toppanel.bbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.bcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcl:Point("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bcl:Size(C.toppanel.width / 2, 1)
toppanel.bcl:SetTexture(C.media.blank)
toppanel.bcl:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0, T.color.r, T.color.g, T.color.b, 1)

toppanel.bbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbr:Point("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bbr:Size(C.toppanel.width / 2, 3)
toppanel.bbr:SetTexture(C.media.blank)
toppanel.bbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.bcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcr:Point("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bcr:Size(C.toppanel.width / 2, 1)
toppanel.bcr:SetTexture(C.media.blank)
toppanel.bcr:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 1, T.color.r, T.color.g, T.color.b, 0)