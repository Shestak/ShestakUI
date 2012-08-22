local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("Quartz") then return end
local Q3 = LibStub("AceAddon-3.0"):GetAddon("Quartz3")
local SkinQuartz = CreateFrame("Frame")
SkinQuartz:RegisterEvent("PLAYER_ENTERING_WORLD")
SkinQuartz:SetScript("OnEvent", function(self)
	Quartz3DB.namespaces.Latency.profiles.Default.lagfontsize = 8
	Quartz3DB.namespaces.Latency.profiles.Default.lagfont = "Hooge"
	Quartz3DB.profiles.Default.modules.Buff = false

	SkinQuartzBar = function(self, bar)
		for _, bars in ipairs({Quartz3CastBarPlayer, Quartz3CastBarFocus, Quartz3CastBarTarget, Quartz3CastBarPet}) do
			bars:SetTemplate("Transparent")
			bars.Bar:SetStatusBarTexture(C.media.texture)
			bars.TimeText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bars.TimeText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			bars.Text:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bars.Text:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end

	local template = Q3.CastBarTemplate.template

	template.ApplySettings_ = template.ApplySettings
	template.ApplySettings = function (self)
		self:ApplySettings_()
		self:SetWidth(self.config.w + 2 * 2)
		self:SetHeight(self.config.h + 2 * 2)

		self.Bar:SetFrameStrata("HIGH")
		self:SetFrameStrata("HIGH")
	end
	template.UNIT_SPELLCAST_NOT_INTERRUPTIBLE_ = template.UNIT_SPELLCAST_NOT_INTERRUPTIBLE
	template.UNIT_SPELLCAST_NOT_INTERRUPTIBLE = function(self, event, unit)
		self:UNIT_SPELLCAST_NOT_INTERRUPTIBLE_(event, unit)
		SkinQuartzBar(self)
	end
	template.UNIT_SPELLCAST_START_ = template.UNIT_SPELLCAST_START
	template.UNIT_SPELLCAST_START = function(self, event, unit)
		self:UNIT_SPELLCAST_START_(event, unit)
		SkinQuartzBar(self)
	end
	template.UNIT_SPELLCAST_CHANNEL_START_ = template.UNIT_SPELLCAST_CHANNEL_START
	template.UNIT_SPELLCAST_CHANNEL_START = function(self, event, unit)
		self:UNIT_SPELLCAST_CHANNEL_START_(event, unit)
		SkinQuartzBar(self)
	end

	Q3:ApplySettings()
end)

--if (not IsInRaid() and GetNumGroupMembers() > MAX_PARTY_MEMBERS) then
--IsInRaid()
--IsInGroup()
--[[
/script BlackMarket_LoadUI() ShowUIPanel(BlackMarketFrame)
/script LoadAddOn("Blizzard_ItemUpgradeUI") ShowUIPanel(ItemUpgradeFrame)
function T.SkinScrollBar(f)
	local frame = f:GetName()

	if _G[frame.."Track"] then _G[frame.."Track"]:Hide() end
	if _G[frame.."BG"] then _G[frame.."BG"]:Hide() end
	if _G[frame.."Top"] then _G[frame.."Top"]:Hide() end
	if _G[frame.."Middle"] then _G[frame.."Middle"]:Hide() end
	if _G[frame.."Bottom"] then _G[frame.."Bottom"]:Hide() end

	local bu = _G[frame.."ThumbTexture"]
	local up = _G[frame.."ScrollUpButton"]
	local down = _G[frame.."ScrollDownButton"]

	bu:SetAlpha(0)
	bu:SetWidth(17)
	bu:SetHeight(22)

	bu.bg = CreateFrame("Frame", nil, f)
	bu.bg:SetTemplate("Overlay")
	bu.bg:SetPoint("TOPLEFT", bu, 0, -3)
	bu.bg:SetPoint("BOTTOMRIGHT", bu, 0, 3)

	up:SetWidth(17)
	up:SkinButton()
	up:SetDisabledTexture(C.media.blank)

	down:SetWidth(17)
	down:SkinButton()
	down:SetDisabledTexture(C.media.blank)

	local dis1 = up:GetDisabledTexture()
	dis1:SetVertexColor(0.6, 0.6, 0.6, 0.4)
	dis1:SetDrawLayer("OVERLAY")
	dis1:SetPoint("TOPLEFT", up, 2, -2)
	dis1:SetPoint("BOTTOMRIGHT", up, -2, 2)

	local dis2 = down:GetDisabledTexture()
	dis2:SetVertexColor(0.6, 0.6, 0.6, 0.4)
	dis2:SetDrawLayer("OVERLAY")
	dis2:SetPoint("TOPLEFT", down, 2, -2)
	dis2:SetPoint("BOTTOMRIGHT", down, -2, 2)
end]]