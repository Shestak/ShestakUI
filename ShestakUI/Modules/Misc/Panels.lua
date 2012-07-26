local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Action Bar button size/spacings
----------------------------------------------------------------------------------------
T.buttonsize = T.Scale(C.actionbar.button_size)
T.buttonspacing = T.Scale(C.actionbar.button_space)

----------------------------------------------------------------------------------------
--	Bottom bars panel
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", UIParent)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.bottom_bars))
bottombaranchor:Width((T.buttonsize * 12) + (T.buttonspacing * 11))
if C.actionbar.bottombars == 2 then
	bottombaranchor:Height((T.buttonsize * 2) + T.buttonspacing)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		bottombaranchor:Height((T.buttonsize * 2) + T.buttonspacing)
	else
		bottombaranchor:Height((T.buttonsize * 3) + (T.buttonspacing * 2))
	end
else
	bottombaranchor:Height(T.buttonsize)
end
bottombaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars panel
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", UIParent)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(C.position.right_bars))
rightbaranchor:Height((T.buttonsize * 12) + (T.buttonspacing * 11))
if C.actionbar.rightbars == 1 then
	rightbaranchor:Width(T.buttonsize)
elseif C.actionbar.rightbars == 2 then
	rightbaranchor:Width((T.buttonsize * 2) + T.buttonspacing)
elseif C.actionbar.rightbars == 3 then
	rightbaranchor:Width((T.buttonsize * 3) + (T.buttonspacing * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("BACKGROUND")

----------------------------------------------------------------------------------------
--	Split bar panels
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", UIParent)
	SplitBarLeft:CreatePanel("Invisible", (T.buttonsize * 3) + (T.buttonspacing * 2), (T.buttonsize * 2) + T.buttonspacing, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -T.buttonspacing, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", UIParent)
	SplitBarRight:CreatePanel("Invisible", (T.buttonsize * 3) + (T.buttonspacing * 2), (T.buttonsize * 2) + T.buttonspacing, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", T.buttonspacing, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar panel
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", UIParent)
if C.actionbar.rightbars > 0 then
	if C.actionbar.petbar_horizontal == true then
		petbaranchor:CreatePanel("Invisible", (T.buttonsize * 10) + (T.buttonspacing * 9), (T.buttonsize + T.buttonspacing), unpack(C.position.pet_horizontal))
	else
		petbaranchor:CreatePanel("Invisible", (T.buttonsize + T.buttonspacing), (T.buttonsize * 10) + (T.buttonspacing * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
	end
else
	petbaranchor:CreatePanel("Invisible", (T.buttonsize + T.buttonspacing), (T.buttonsize * 10) + (T.buttonspacing * 9), unpack(C.position.right_bars))
end

----------------------------------------------------------------------------------------
--	Stance bar panel
----------------------------------------------------------------------------------------
if not C.actionbar.shapeshift_hide then
	local shiftanchor = CreateFrame("Frame", "ShapeShiftBarAnchor", UIParent)
	shiftanchor:RegisterEvent("PLAYER_LOGIN")
	shiftanchor:RegisterEvent("PLAYER_ENTERING_WORLD")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	shiftanchor:SetScript("OnEvent", function(self, event, ...)
		local forms = GetNumShapeshiftForms()
		if forms > 0 then
			if C.actionbar.shapeshift_horizontal ~= true then
				shiftanchor:Width(T.buttonsize)
				shiftanchor:Height((T.buttonsize * forms) + ((T.buttonspacing * forms) - 3 ))
				shiftanchor:Point("TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT")
			else
				shiftanchor:Width((T.buttonsize * forms) + ((T.buttonspacing * forms) - 3))
				shiftanchor:Height(T.buttonsize)
				shiftanchor:Point("TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT")
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 4, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 2)
	chatbd:SetBackdropBorderColor(unpack(C["media"].border_color))
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)

	local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
	chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3)
	chattabs:SetBackdropBorderColor(unpack(C["media"].border_color))
	chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel("ClassColor", 1, C.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
	leftpanel:SetAlpha(0)
end

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

local borderr, borderg, borderb = unpack(C["media"].border_color)
toppanel.bgl = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgl:Point("RIGHT", toppanel, "CENTER", 0, 0)
toppanel.bgl:Size(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgl:SetTexture(C.media.blank)
toppanel.bgl:SetGradientAlpha("HORIZONTAL", borderr, borderg, borderb, 0, borderr, borderg, borderb, 0.1)

toppanel.bgr = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgr:Point("LEFT", toppanel, "CENTER", 0, 0)
toppanel.bgr:Size(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgr:SetTexture(C.media.blank)
toppanel.bgr:SetGradientAlpha("HORIZONTAL", borderr, borderg, borderb, 0.1, borderr, borderg, borderb, 0)

toppanel.tbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbl:Point("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tbl:Size(C.toppanel.width / 2, 3)
toppanel.tbl:SetTexture(C.media.blank)
toppanel.tbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.tcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcl:Point("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tcl:Size(C.toppanel.width / 2, 1)
toppanel.tcl:SetTexture(C.media.blank)
toppanel.tcl:SetGradientAlpha("HORIZONTAL", borderr, borderg, borderb, 0, borderr, borderg, borderb, 1)

toppanel.tbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbr:Point("LEFT", toppanel, "TOP", 0, 0)
toppanel.tbr:Size(C.toppanel.width / 2, 3)
toppanel.tbr:SetTexture(C.media.blank)
toppanel.tbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.tcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcr:Point("LEFT", toppanel, "TOP", 0, 0)
toppanel.tcr:Size(C.toppanel.width / 2, 1)
toppanel.tcr:SetTexture(C.media.blank)
toppanel.tcr:SetGradientAlpha("HORIZONTAL", borderr, borderg, borderb, 1, borderr, borderg, borderb, 0)

toppanel.bbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbl:Point("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bbl:Size(C.toppanel.width / 2, 3)
toppanel.bbl:SetTexture(C.media.blank)
toppanel.bbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.bcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcl:Point("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bcl:Size(C.toppanel.width / 2, 1)
toppanel.bcl:SetTexture(C.media.blank)
toppanel.bcl:SetGradientAlpha("HORIZONTAL", borderr, borderg, borderb, 0, borderr, borderg, borderb, 1)

toppanel.bbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbr:Point("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bbr:Size(C.toppanel.width / 2, 3)
toppanel.bbr:SetTexture(C.media.blank)
toppanel.bbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.bcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcr:Point("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bcr:Size(C.toppanel.width / 2, 1)
toppanel.bcr:SetTexture(C.media.blank)
toppanel.bcr:SetGradientAlpha("HORIZONTAL", borderr, borderg, borderb, 1, borderr, borderg, borderb, 0)

-- edit by Oz of shestak. org --