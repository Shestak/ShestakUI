local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.quartz ~= true then return end

----------------------------------------------------------------------------------------
--	Quartz skin(Not Ready)
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("Quartz") then return end
local Q3 = LibStub("AceAddon-3.0"):GetAddon("Quartz3")
if not Q3 then return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	Quartz3DB.namespaces.Latency.profiles.Default.lagfontsize = 8
	Quartz3DB.namespaces.Latency.profiles.Default.lagfont = "Hooge"
	Quartz3DB.namespaces.Player.profiles.Default.icongap = 7
	Quartz3DB.profiles.Default.modules.Buff = false
	Quartz3DB.profiles.Default.borderalpha = 0
	Quartz3DB.profiles.Default.backgroundalpha = 0

	SkinQuartzBar = function(self, bar)
		if not self.IconBorder then
			self.IconBorder = CreateFrame("Frame", nil, self)
			self.IconBorder:CreateBackdrop("Default")
			self.IconBorder:SetPoint("TOPLEFT", self.Icon, "TOPLEFT", 0, 0)
			self.IconBorder:SetPoint("BOTTOMRIGHT", self.Icon, "BOTTOMRIGHT", 0, 0)
		end
		if self.config.hideicon then
			self.IconBorder:Hide()
		else
			self.IconBorder:Show()
		end
		if not self.Bar.backdrop then
			self.Bar:CreateBackdrop("Transparent")
		end
		self.Bar:SetStatusBarTexture(C.media.texture)
		self.TimeText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		self.TimeText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		self.Text:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		self.Text:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
	end

	local template = Q3.CastBarTemplate.template

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
end)