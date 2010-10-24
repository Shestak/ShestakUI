----------------------------------------------------------------------------------------
--	Based on aLoad
----------------------------------------------------------------------------------------
local function SetModifiedBackdrop(self)
	self:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	self.bg:SetVertexColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 0.3)
end

local function SetOriginalBackdrop(self)
	self:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	self.bg:SetVertexColor(0.1, 0.1, 0.1, 1)
end

local function SkinButton(f)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")
	SettingsDB.SkinPanel(f)
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end

local loadf = CreateFrame("Frame", "aLoadFrame", UIParent)
loadf:SetWidth(400)
loadf:SetHeight(400)
loadf:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 312)
loadf:EnableMouse(true)
loadf:SetMovable(true)
loadf:SetUserPlaced(true)
loadf:SetClampedToScreen(true)
loadf:SetScript("OnMouseDown", function(self) self:StartMoving() end)
loadf:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
loadf:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "aLoadFrame")
SettingsDB.SkinFadedPanel(loadf)
loadf:Hide()

local title = loadf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -8)
title:SetText(ADDONS)

local scrollf = CreateFrame("ScrollFrame", "aLoadScroll", loadf, "UIPanelScrollFrameTemplate")
local mainf = CreateFrame("Frame", nil, scrollf)

scrollf:SetPoint("TOPLEFT", loadf, "TOPLEFT", 10, -30)
scrollf:SetPoint("BOTTOMRIGHT", loadf, "BOTTOMRIGHT", -28, 40)
scrollf:SetScrollChild(mainf)

local reloadb = CreateFrame("Button", nil, loadf, "UIPanelButtonTemplate")
reloadb:SetWidth(150)
reloadb:SetHeight(22)
reloadb:SetPoint("BOTTOM", 0, 10)
reloadb:SetText(L_ALOAD_RL)
reloadb:SetScript("OnClick", function() ReloadUI() end)
SkinButton(reloadb)

local addonf = CreateFrame("Frame", "AddonSets", loadf)
addonf:SetWidth(400)
addonf:SetHeight(44)
addonf:SetPoint("TOP", loadf, "BOTTOM", 0, -5)
addonf:SetFrameStrata("DIALOG")
SettingsDB.SkinFadedPanel(addonf)

local addonset1 = CreateFrame("Button", nil, addonf, "UIPanelButtonTemplate")
addonset1:SetWidth(60)
addonset1:SetHeight(22)
addonset1:SetPoint("BOTTOMLEFT", 7, 10)
addonset1:SetText(PARTY)
addonset1:SetScript("OnClick", function()
	for i in pairs(SettingsCF["addon"].raid) do
		DisableAddOn(SettingsCF["addon"].raid[i])
	end
	for i in pairs(SettingsCF["addon"].party) do
		EnableAddOn(SettingsCF["addon"].party[i])
	end
	for i in pairs(SettingsCF["addon"].pvp) do
		DisableAddOn(SettingsCF["addon"].pvp[i])
	end
	for i in pairs(SettingsCF["addon"].quest) do
		DisableAddOn(SettingsCF["addon"].quest[i])
	end
	for i in pairs(SettingsCF["addon"].trade) do
		DisableAddOn(SettingsCF["addon"].trade[i])
	end
	ReloadUI()
end)
SkinButton(addonset1)

local addonset2 = CreateFrame("Button", nil, addonf, "UIPanelButtonTemplate")
addonset2:SetWidth(60)
addonset2:SetHeight(22)
addonset2:SetPoint("LEFT", addonset1, "RIGHT", 5, 0)
addonset2:SetText(RAID)
addonset2:SetScript("OnClick", function()
	for i in pairs(SettingsCF["addon"].raid) do
		EnableAddOn(SettingsCF["addon"].raid[i])
	end
	for i in pairs(SettingsCF["addon"].party) do
		DisableAddOn(SettingsCF["addon"].party[i])
	end
	for i in pairs(SettingsCF["addon"].pvp) do
		DisableAddOn(SettingsCF["addon"].pvp[i])
	end
	for i in pairs(SettingsCF["addon"].quest) do
		DisableAddOn(SettingsCF["addon"].quest[i])
	end
	for i in pairs(SettingsCF["addon"].trade) do
		DisableAddOn(SettingsCF["addon"].trade[i])
	end
	ReloadUI()
end)
SkinButton(addonset2)

local addonset3 = CreateFrame("Button", nil, addonf, "UIPanelButtonTemplate")
addonset3:SetWidth(60)
addonset3:SetHeight(22)
addonset3:SetPoint("LEFT", addonset2, "RIGHT", 5, 0)
addonset3:SetText(QUESTS_LABEL)
addonset3:SetScript("OnClick", function()
	for i in pairs(SettingsCF["addon"].raid) do
		DisableAddOn(SettingsCF["addon"].raid[i])
	end
	for i in pairs(SettingsCF["addon"].party) do
		DisableAddOn(SettingsCF["addon"].party[i])
	end
	for i in pairs(SettingsCF["addon"].pvp) do
		DisableAddOn(SettingsCF["addon"].pvp[i])
	end
	for i in pairs(SettingsCF["addon"].quest) do
		EnableAddOn(SettingsCF["addon"].quest[i])
	end
	for i in pairs(SettingsCF["addon"].trade) do
		DisableAddOn(SettingsCF["addon"].trade[i])
	end
	ReloadUI()
end)
SkinButton(addonset3)

local addonset4 = CreateFrame("Button", nil, addonf, "UIPanelButtonTemplate")
addonset4:SetWidth(60)
addonset4:SetHeight(22)
addonset4:SetPoint("LEFT", addonset3, "RIGHT", 5, 0)
addonset4:SetText(L_ALOAD_TRADE)
addonset4:SetScript("OnClick", function()
	for i in pairs(SettingsCF["addon"].raid) do
		DisableAddOn(SettingsCF["addon"].raid[i])
	end
	for i in pairs(SettingsCF["addon"].party) do
		DisableAddOn(SettingsCF["addon"].party[i])
	end
	for i in pairs(SettingsCF["addon"].pvp) do
		DisableAddOn(SettingsCF["addon"].pvp[i])
	end
	for i in pairs(SettingsCF["addon"].quest) do
		DisableAddOn(SettingsCF["addon"].quest[i])
	end
	for i in pairs(SettingsCF["addon"].trade) do
		EnableAddOn(SettingsCF["addon"].trade[i])
	end
	ReloadUI()
end)
SkinButton(addonset4)

local addonset5 = CreateFrame("Button", nil, addonf, "UIPanelButtonTemplate")
addonset5:SetWidth(60)
addonset5:SetHeight(22)
addonset5:SetPoint("LEFT", addonset4, "RIGHT", 5, 0)
addonset5:SetText(PVP)
addonset5:SetScript("OnClick", function()
	for i in pairs(SettingsCF["addon"].raid) do
		DisableAddOn(SettingsCF["addon"].raid[i])
	end
	for i in pairs(SettingsCF["addon"].party) do
		DisableAddOn(SettingsCF["addon"].party[i])
	end
	for i in pairs(SettingsCF["addon"].pvp) do
		EnableAddOn(SettingsCF["addon"].pvp[i])
	end
	for i in pairs(SettingsCF["addon"].quest) do
		DisableAddOn(SettingsCF["addon"].quest[i])
	end
	for i in pairs(SettingsCF["addon"].trade) do
		DisableAddOn(SettingsCF["addon"].trade[i])
	end
	ReloadUI()
end)
SkinButton(addonset5)

local addonset6 = CreateFrame("Button", nil, addonf, "UIPanelButtonTemplate")
addonset6:SetWidth(60)
addonset6:SetHeight(22)
addonset6:SetPoint("LEFT", addonset5, "RIGHT", 5, 0)
addonset6:SetText(L_ALOAD_SOLO)
addonset6:SetScript("OnClick", function()
	for i in pairs(SettingsCF["addon"].raid) do
		DisableAddOn(SettingsCF["addon"].raid[i])
	end
	for i in pairs(SettingsCF["addon"].party) do
		DisableAddOn(SettingsCF["addon"].party[i])
	end
	for i in pairs(SettingsCF["addon"].pvp) do
		DisableAddOn(SettingsCF["addon"].pvp[i])
	end
	for i in pairs(SettingsCF["addon"].quest) do
		DisableAddOn(SettingsCF["addon"].quest[i])
	end
	for i in pairs(SettingsCF["addon"].trade) do
		DisableAddOn(SettingsCF["addon"].trade[i])
	end
	ReloadUI()
end)
SkinButton(addonset6)

local closeb = CreateFrame("Button", nil, loadf, "UIPanelCloseButton")
closeb:SetPoint("TOPRIGHT", loadf, "TOPRIGHT", 2, 0)
closeb:SetScript("OnClick", function()
	loadf:Hide()
end)

local makeList = function()
	local self = mainf
	SettingsDB.SkinFadedPanel(scrollf)
	self:SetPoint("TOPLEFT")
	self:SetWidth(scrollf:GetWidth())
	self:SetHeight(scrollf:GetHeight())
	self.addons = {}
	for i=1, GetNumAddOns() do
		self.addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(self.addons)

	local oldb

	for i,v in pairs(self.addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)

		if name then
			local bf = _G[v.."_cbf"] or CreateFrame("Button", v.."_cbf", self)
			if i == 1 then
				bf:SetPoint("TOPLEFT", self, "TOPLEFT", 2, -2)
				bf:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -2, -20)
			else
				bf:SetPoint("TOPLEFT", oldb, "BOTTOMLEFT", 0, 0)
				bf:SetPoint("BOTTOMRIGHT", oldb, "BOTTOMRIGHT", 0, -20)
			end
			
			bf:EnableMouse(true)
			
			bf:SetBackdrop({
				bgFile = "Interface\\Buttons\\WHITE8x8",
			})
			bf:SetBackdropColor(0, 0, 0, 0)
	
			local maketool = function(self, v)
				local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
				
				local s = title.."|n"
				if notes then s = "|cffffff00"..s.."|r".."|cffffffff"..notes.."|r|n" end
				if (GetAddOnDependencies(v)) then
					s = "|cffff4400Dependencies: "
					for i = 1, select("#", GetAddOnDependencies(v)) do
						s = s..select(i, GetAddOnDependencies(v))
						if (i > 1) then s=s..", " end
					end
					s = s.."|r"
				end
				GameTooltip:AddLine(s,_,_,_,1)
				GameTooltip:Show()
			end
			
			bf:SetScript("OnEnter", function(self)
				self:SetBackdropColor(0, 1, 0, .25)
				maketool(self, v)
			end)
			
			bf:SetScript("OnLeave", function(self)
				self:SetBackdropColor(0, 0, 0, 0)
				GameTooltip:Hide()
			end)
			
			oldb = bf

			local cb = _G[v.."_cb"] or CreateFrame("CheckButton", v.."_cb", bf, "OptionsCheckButtonTemplate")
			cb:SetWidth(16)
			cb:SetHeight(16)
			cb:SetScript("OnClick", function()
				local _, _, _, enabled = GetAddOnInfo(name)
				if enabled then
					DisableAddOn(name)
				else
					EnableAddOn(name)
				end
			end)
			cb:SetChecked(enabled)
			cb:SetPoint("LEFT", 4, 0)

			cb:SetScript("OnEnter", function()
				bf:SetBackdropColor(0, 1, 0, .25)
				maketool(cb, v)
			end)
			
			cb:SetScript("OnLeave", function()
				bf:SetBackdropColor(0, 0, 0, 0)
				GameTooltip:Hide()
			end)
			
			local fs = _G[v.."_fs"] or bf:CreateFontString(v.."_fs", "OVERLAY", "GameFontNormal")
			fs:SetText(title)

			fs:SetJustifyH("LEFT")
			fs:SetPoint("TOPLEFT", cb, "TOPRIGHT", 0, 0)
			fs:SetPoint("BOTTOMRIGHT", bf, "BOTTOMRIGHT", 0, 0)
			
			bf:SetScript("OnClick", function(self)
				cb:Click()
			end)
		end
	end
end

makeList()

-- Slash command
SLASH_ALOAD1 = "/aload"
SLASH_ALOAD2 = "/al"
SlashCmdList["ALOAD"] = function (msg)
   loadf:Show()
end

local showb = CreateFrame("Button", "GameMenuButtonAddonManager", GameMenuFrame, "GameMenuButtonTemplate")
showb:SetText(ADDONS)
showb:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -1)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + showb:GetHeight())
GameMenuButtonSoundOptions:SetPoint("TOP", showb, "BOTTOM", 0, -1)

showb:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	loadf:Show()
end)

if not IsAddOnLoaded("ShestakUI_Config") then return end
local guib = CreateFrame("Button", "GameMenuButtonSettingsGUI", GameMenuFrame, "GameMenuButtonTemplate")
guib:SetText("ShestakUI")
guib:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -23)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + guib:GetHeight())
GameMenuButtonSoundOptions:SetPoint("TOP", guib, "BOTTOM", 0, -1)

guib:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfig or not UIConfig:IsShown() then
		CreateUIConfig()
	else
		UIConfig:Hide()
	end
end)