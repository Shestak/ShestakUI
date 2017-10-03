local T, C, L, _ = unpack(select(2, ...))
if C.skins.weak_auras ~= true then return end

----------------------------------------------------------------------------------------
--	WeakAuras skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("WeakAuras") then return end

	local function Skin_WeakAuras(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Default")
		end

		if frame.icon then
			frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			frame.icon.SetTexCoord = T.dummy
		end

		if frame.bar then
			frame.bar.fg:SetTexture(C.media.texture)
			frame.bar.bg:SetTexture(C.media.texture)
		end

		if frame.stacks then
			frame.stacks:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
			frame.stacks:SetShadowOffset(C.media.cooldown_timers_font_shadow and 1 or 0, C.media.cooldown_timers_font_shadow and -1 or 0)
		end

		if frame.text then
			frame.text:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
			frame.text:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
		end

		if frame.text2 then
			frame.text2:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
			frame.text2:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
		end

		if frame.timer then
			frame.timer:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
			frame.timer:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
		end
	end

	for weakAura, _ in pairs(WeakAuras.regions) do
		if WeakAuras.regions[weakAura].regionType == "icon" or WeakAuras.regions[weakAura].regionType == "aurabar" then
			Skin_WeakAuras(WeakAuras.regions[weakAura].region)
		end
	end
end)