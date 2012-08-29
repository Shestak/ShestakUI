local T, C, L = unpack(ShestakUI)
if C.extra_skins.quartz ~= true then return end

----------------------------------------------------------------------------------------
--	Quartz skin(Not Ready)
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("Quartz") then return end
local Q3 = LibStub("AceAddon-3.0"):GetAddon("Quartz3")
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self)
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