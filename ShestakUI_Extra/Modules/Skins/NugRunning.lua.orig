local T, C, L = unpack(ShestakUI)
if C.extra_skins.nug_running ~= true then return end

----------------------------------------------------------------------------------------
--	NugRunning skin(by MrRuben5)
----------------------------------------------------------------------------------------
local NRSkin = CreateFrame("Frame")
NRSkin:RegisterEvent("ADDON_LOADED")
NRSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("NugRunning") then return end

	local NugRunning = NugRunning
	local TimerBar = NugRunning and NugRunning.TimerBar

	-- Creates timerbar
	local _ConstructTimerBar = NugRunning.ConstructTimerBar
	function NugRunning.ConstructTimerBar(w, h)
		local f = _ConstructTimerBar(w, h)

		f:SetBackdrop(nil)

		local ic = f.icon:GetParent()
		ic:CreateBackdrop("Default")

		f.bar:CreateBackdrop("Default")

		f.bar:SetStatusBarTexture(C.media.texture)
		f.bar:GetStatusBarTexture():SetDrawLayer("ARTWORK")
		f.bar.bg:SetTexture(C.media.texture)
		f.bar.bg:SetAlpha(0.3)

		f.timeText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		f.timeText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		f.spellText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		f.spellText:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		f.stacktext:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		f.stacktext:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

		TimerBar.Resize(f, w, h)

		return f
	end

	-- Resizes timerbar
	local _Resize = TimerBar.Resize
	function TimerBar.Resize(f, w, h)
		_Resize(f, w, h)

		local ic = f.icon:GetParent()
		ic:ClearAllPoints()
		ic:Point("TOPLEFT", f, 1, -1)
		ic:Point("BOTTOMLEFT", f, 1, 0)

		f.bar:ClearAllPoints()
		f.bar:Point("TOPRIGHT", f, -1, -1)
		f.bar:Point("BOTTOMRIGHT", f, -1, 0)
		f.bar:Point("LEFT", ic, "RIGHT", 5, 0)

		f.timeText:SetJustifyH("RIGHT")
		f.timeText:ClearAllPoints()
		f.timeText:Point("RIGHT", 1, 0)

		f.spellText:SetJustifyH("LEFT")
		f.spellText:ClearAllPoints()
		f.spellText:Point("LEFT", 2, 0)
		f.spellText:SetWidth(f.bar:GetWidth() - 10)
	end
end)