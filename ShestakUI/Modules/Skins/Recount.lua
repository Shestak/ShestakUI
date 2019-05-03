local T, C, L, _ = unpack(select(2, ...))
if C.skins.recount ~= true or not IsAddOnLoaded("Recount") then return end

----------------------------------------------------------------------------------------
--	Recount skin
----------------------------------------------------------------------------------------
local Recount = _G.Recount

local function SkinFrame(frame)
	frame.bgMain = CreateFrame("Frame", nil, frame)
	if frame ~= Recount.MainWindow then
		frame.bgMain:SetTemplate("Transparent")
		T.SkinCloseButton(frame.CloseButton)
		frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -11)
	end
	if frame == Recount.MainWindow then
		frame.Title:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -15)
		frame.Title:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		frame.Title:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, -9)
	end
	frame.bgMain:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	frame.bgMain:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	frame.bgMain:SetPoint("TOP", frame, "TOP", 0, -7)
	frame.bgMain:SetFrameLevel(frame:GetFrameLevel())
	frame:SetBackdrop(nil)
end

local function SkinButton(frame, text)
	if frame.SetNormalTexture then frame:SetNormalTexture("") end
	if frame.SetHighlightTexture then frame:SetHighlightTexture("") end
	if frame.SetPushedTexture then frame:SetPushedTexture("") end

	if not frame.text then
		frame:FontString("text", C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		frame.text:SetPoint("CENTER")
		frame.text:SetText(text)
	end

	frame:HookScript("OnEnter", function(self) self.text:SetTextColor(T.color.r, T.color.g, T.color.b) end)
	frame:HookScript("OnLeave", function(self) self.text:SetTextColor(1, 1, 1) end)
end

-- Override bar textures
Recount.UpdateBarTextures = function()
	for _, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(C.media.texture)
		v.StatusBar:GetStatusBarTexture():SetHorizTile(false)
		v.StatusBar:GetStatusBarTexture():SetVertTile(false)

		v.background = v.StatusBar:CreateTexture("$parentBackground", "BACKGROUND")
		v.background:SetAllPoints(v.StatusBar)
		v.background:SetTexture(C.media.texture)
		v.background:SetVertexColor(0.15, 0.15, 0.15, 0.75)

		v.overlay = CreateFrame("Frame", nil, v.StatusBar)
		v.overlay:SetTemplate("Default")
		v.overlay:SetFrameStrata("BACKGROUND")
		v.overlay:SetPoint("TOPLEFT", -2, 2)
		v.overlay:SetPoint("BOTTOMRIGHT", 2, -2)

		v.LeftText:ClearAllPoints()
		v.LeftText:SetPoint("LEFT", v.StatusBar, "LEFT", 2, 0)
		v.LeftText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		v.LeftText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

		v.RightText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		v.RightText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end
end
Recount.SetBarTextures = Recount.UpdateBarTextures

-- Fix bar textures as they're created
Recount.SetupBar_ = Recount.SetupBar
Recount.SetupBar = function(self, bar)
	self:SetupBar_(bar)
	bar.StatusBar:SetStatusBarTexture(C.media.texture)
end

-- Skin frames when they're created
Recount.CreateFrame_ = Recount.CreateFrame
Recount.CreateFrame = function(self, Name, Title, Height, Width, ShowFunc, HideFunc)
	local frame = self:CreateFrame_(Name, Title, Height, Width, ShowFunc, HideFunc)
	SkinFrame(frame)
	return frame
end

-- Skin some others frame, not available outside Recount
Recount.AddWindow_ = Recount.AddWindow
Recount.AddWindow = function(_, frame)
	Recount:AddWindow_(frame)

	if frame.YesButton then
		frame:SetTemplate("Transparent")
		frame.YesButton:SkinButton()
		frame.NoButton:SkinButton()
	end

	if frame.ReportButton then
		frame.ReportButton:SkinButton()
	end
end

-- Skin existing frames
if Recount.MainWindow then SkinFrame(Recount.MainWindow) end
if Recount.ConfigWindow then SkinFrame(Recount.ConfigWindow) end
if Recount.GraphWindow then SkinFrame(Recount.GraphWindow) end
if Recount.DetailWindow then SkinFrame(Recount.DetailWindow) end
if Recount.ResetFrame then SkinFrame(Recount.ResetFrame) end
if _G["Recount_Realtime_!RAID_DAMAGE"] then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGE"].Window) end
if _G["Recount_Realtime_!RAID_HEALING"] then SkinFrame(_G["Recount_Realtime_!RAID_HEALING"].Window) end
if _G["Recount_Realtime_!RAID_HEALINGTAKEN"] then SkinFrame(_G["Recount_Realtime_!RAID_HEALINGTAKEN"].Window) end
if _G["Recount_Realtime_!RAID_DAMAGETAKEN"] then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGETAKEN"].Window) end
if _G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"] then SkinFrame(_G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"].Window) end
if _G["Recount_Realtime_FPS_FPS"] then SkinFrame(_G["Recount_Realtime_FPS_FPS"].Window) end
if _G["Recount_Realtime_Latency_LAG"] then SkinFrame(_G["Recount_Realtime_Latency_LAG"].Window) end
if _G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"] then SkinFrame(_G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"].Window) end
if _G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"] then SkinFrame(_G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"].Window) end

-- Update Textures
Recount:UpdateBarTextures()
Recount.MainWindow.ConfigButton:HookScript("OnClick", function() Recount:UpdateBarTextures() end)

-- Reskin Dropdown
Recount.MainWindow.FileButton:HookScript("OnClick", function() if LibDropdownFrame0 then LibDropdownFrame0:SetTemplate("Transparent") end end)

-- Reskin Buttons
SkinButton(Recount.MainWindow.CloseButton, "X")
SkinButton(Recount.MainWindow.RightButton, ">")
SkinButton(Recount.MainWindow.LeftButton, "<")
SkinButton(Recount.MainWindow.ResetButton, "R")
SkinButton(Recount.MainWindow.FileButton, "F")
SkinButton(Recount.MainWindow.ConfigButton, "C")
SkinButton(Recount.MainWindow.ReportButton, "S")

-- Force some default profile options
if not RecountDB then RecountDB = {} end
if not RecountDB["profiles"] then RecountDB["profiles"] = {} end
if not RecountDB["profiles"][T.name.." - "..GetRealmName()] then RecountDB["profiles"][T.name.." - "..T.realm] = {} end
if not RecountDB["profiles"][T.name.." - "..GetRealmName()]["MainWindow"] then RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"] = {} end

RecountDB["profiles"][T.name.." - "..T.realm]["Locked"] = true
RecountDB["profiles"][T.name.." - "..T.realm]["Scaling"] = 1
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["RowHeight"] = 12
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["RowSpacing"] = 7
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["ShowScrollbar"] = false
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["HideTotalBar"] = true
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["Position"]["x"] = 284
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["Position"]["y"] = -281
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["Position"]["w"] = 221
--RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["Position"]["h"] = 158
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindow"]["BarText"]["NumFormat"] = 3
RecountDB["profiles"][T.name.." - "..T.realm]["MainWindowWidth"] = 221
--RecountDB["profiles"][T.name.." - "..T.realm]["MainWindowHeight"] = 158
RecountDB["profiles"][T.name.." - "..T.realm]["ClampToScreen"] = true
RecountDB["profiles"][T.name.." - "..T.realm]["Font"] = "Calibri"