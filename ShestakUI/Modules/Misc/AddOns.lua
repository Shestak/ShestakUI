local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Based on aLoad(by Fernir)
----------------------------------------------------------------------------------------
local loadf = CreateFrame("Frame", "aLoadFrame", UIParent)
loadf:Width(400)
loadf:Height(400)
loadf:Point("BOTTOM", UIParent, "BOTTOM", 0, 317)
loadf:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "aLoadFrame")
loadf:Hide()
loadf:SetScript("OnHide", function(self) ShowUIPanel(GameMenuFrame) end)

local title = loadf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -8)
title:SetText(ADDONS)

local scrollf = CreateFrame("ScrollFrame", "aLoadScroll", loadf, "UIPanelScrollFrameTemplate")
local mainf = CreateFrame("Frame", "aLoadMain", scrollf)

scrollf:Point("TOPLEFT", loadf, "TOPLEFT", 10, -30)
scrollf:Point("BOTTOMRIGHT", loadf, "BOTTOMRIGHT", -28, 40)
scrollf:SetScrollChild(mainf)

local reloadb = CreateFrame("Button", "aLoadReload", loadf, "UIPanelButtonTemplate")
reloadb:Width(150)
reloadb:Height(22)
reloadb:Point("BOTTOM", 0, 10)
reloadb:SetText(L_ALOAD_RL)
reloadb:SetScript("OnClick", function() ReloadUI() end)

local addonf = CreateFrame("Frame", "AddonSets", loadf)
addonf:Width(400)
addonf:Height(44)
addonf:Point("TOP", loadf, "BOTTOM", 0, -5)
addonf:SetFrameStrata("DIALOG")

local addonset1 = CreateFrame("Button", "AddonSet1", addonf, "UIPanelButtonTemplate")
addonset1:Width(60)
addonset1:Height(22)
addonset1:Point("BOTTOMLEFT", 7, 10)
addonset1:SetText(PARTY)
addonset1:SetScript("OnClick", function() T.RunSlashCmd("/addons party") end)

local addonset2 = CreateFrame("Button", "AddonSet2", addonf, "UIPanelButtonTemplate")
addonset2:Width(60)
addonset2:Height(22)
addonset2:Point("LEFT", addonset1, "RIGHT", 5, 0)
addonset2:SetText(RAID)
addonset2:SetScript("OnClick", function() T.RunSlashCmd("/addons raid") end)

local addonset3 = CreateFrame("Button", "AddonSet3", addonf, "UIPanelButtonTemplate")
addonset3:Width(60)
addonset3:Height(22)
addonset3:Point("LEFT", addonset2, "RIGHT", 5, 0)
addonset3:SetText(QUESTS_LABEL)
addonset3:SetScript("OnClick", function() T.RunSlashCmd("/addons quest") end)

local addonset4 = CreateFrame("Button", "AddonSet4", addonf, "UIPanelButtonTemplate")
addonset4:Width(60)
addonset4:Height(22)
addonset4:Point("LEFT", addonset3, "RIGHT", 5, 0)
addonset4:SetText(L_ALOAD_TRADE)
addonset4:SetScript("OnClick", function() T.RunSlashCmd("/addons trade") end)

local addonset5 = CreateFrame("Button", "AddonSet5", addonf, "UIPanelButtonTemplate")
addonset5:Width(60)
addonset5:Height(22)
addonset5:Point("LEFT", addonset4, "RIGHT", 5, 0)
addonset5:SetText(PVP)
addonset5:SetScript("OnClick", function() T.RunSlashCmd("/addons pvp") end)

local addonset6 = CreateFrame("Button", "AddonSet6", addonf, "UIPanelButtonTemplate")
addonset6:Width(60)
addonset6:Height(22)
addonset6:Point("LEFT", addonset5, "RIGHT", 5, 0)
addonset6:SetText(L_ALOAD_SOLO)
addonset6:SetScript("OnClick", function() T.RunSlashCmd("/addons solo") end)

local closeb = CreateFrame("Button", nil, loadf, "UIPanelCloseButton")
closeb:Point("TOPRIGHT", loadf, "TOPRIGHT", 2, 0)
closeb:SetScript("OnClick", function() loadf:Hide() end)

local makeList = function()
	local self = mainf
	self:Point("TOPLEFT", scrollf, "TOPLEFT", 0, 0)
	self:Width(scrollf:GetWidth())
	self:Height(scrollf:GetHeight())
	self.addons = {}
	for i = 1, GetNumAddOns() do
		self.addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(self.addons)

	local oldb

	for i, v in pairs(self.addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)

		if name then
			local bf = _G[v.."_cbf"] or CreateFrame("Button", v.."_cbf", self)
			if i == 1 then
				bf:Point("TOPLEFT", self, "TOPLEFT", 2, -2)
				bf:Point("BOTTOMRIGHT", self, "TOPRIGHT", -2, -20)
			else
				bf:Point("TOPLEFT", oldb, "BOTTOMLEFT", 0, 0)
				bf:Point("BOTTOMRIGHT", oldb, "BOTTOMRIGHT", 0, -20)
			end
			
			bf:EnableMouse(true)
			bf:SetBackdrop({bgFile = C.media.blank})
			bf:SetBackdropColor(0, 0, 0, 0)
	
			local maketool = function(self, v)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
				GameTooltip:AddLine(title)
				if notes then
					GameTooltip:AddLine(notes, 1, 1, 1)
				end
				if GetAddOnDependencies(v) then
					local s = "|cffff2200"..L_ALOAD_DEP
					for i = 1, select("#", GetAddOnDependencies(v)) do
						s = s..select(i, GetAddOnDependencies(v))
						if i > 1 then s = s..", " end
					end
					s = s.."|r"
					GameTooltip:AddLine(s, _, _, _, 1)
				end
				GameTooltip:Show()
			end
			
			bf:SetScript("OnEnter", function(self)
				self:SetBackdropColor(0, 1, 0, 0.25)
				maketool(self, v)
			end)
			
			bf:SetScript("OnLeave", function(self)
				self:SetBackdropColor(0, 0, 0, 0)
				GameTooltip:Hide()
			end)
			
			oldb = bf

			local cb = _G[v.."_cb"] or CreateFrame("CheckButton", v.."_cb", bf, "OptionsCheckButtonTemplate")
			cb:Width(16)
			cb:Height(16)
			cb:SetScript("OnClick", function()
				local _, _, _, enabled = GetAddOnInfo(name)
				if enabled then
					DisableAddOn(name)
				else
					EnableAddOn(name)
				end
			end)
			cb:SetChecked(enabled)
			cb:Point("LEFT", 4, 0)

			cb:SetScript("OnEnter", function()
				bf:SetBackdropColor(0, 1, 0, 0.25)
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
SLASH_ALOAD2 = "/фдщфв"
SlashCmdList.ALOAD = function(msg)
   loadf:Show()
end

local showb = CreateFrame("Button", "GameMenuButtonAddonManager", GameMenuFrame, "GameMenuButtonTemplate")
showb:SetText(ADDONS)
showb:Point("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -1)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + showb:GetHeight())
if T.patch < string.format("%s", "4.1.0") then
	GameMenuButtonSoundOptions:Point("TOP", showb, "BOTTOM", 0, -1)
else
	GameMenuButtonUIOptions:Point("TOP", showb, "BOTTOM", 0, -1)
end

showb:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	loadf:Show()
end)

if not IsAddOnLoaded("ShestakUI_Config") then return end
local guib = CreateFrame("Button", "GameMenuButtonSettingsGUI", GameMenuFrame, "GameMenuButtonTemplate")
guib:SetText("ShestakUI")
guib:Point("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -23)

GameMenuFrame:Height(GameMenuFrame:GetHeight() + guib:GetHeight())
if T.patch < string.format("%s", "4.1.0") then
	GameMenuButtonSoundOptions:Point("TOP", guib, "BOTTOM", 0, -1)
else
	GameMenuButtonUIOptions:Point("TOP", guib, "BOTTOM", 0, -1)
end

guib:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfigMain or not UIConfigMain:IsShown() then
		CreateUIConfig()
	else
		UIConfigMain:Hide()
	end
end)