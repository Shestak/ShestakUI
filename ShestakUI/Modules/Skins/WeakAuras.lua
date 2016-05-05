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
			frame.stacks:SetFont(C.font.filger_font, select(2, frame.stacks:GetFont()), C.font.filger_font_style)
			frame.stacks:SetShadowOffset(C.media.filger_font_shadow and 1 or 0, C.media.filger_font_shadow and -1 or 0)
		end

		if frame.timer then
			frame.timer:SetFont(C.font.filger_font, select(2, frame.timer:GetFont()), C.font.filger_font_style)
			frame.timer:SetShadowOffset(C.font.filger_font_shadow and 1 or 0, C.font.filger_font_shadow and -1 or 0)
		end

		if frame.text then
			frame.text:SetFont(C.font.filger_font, select(2, frame.text:GetFont()), C.font.filger_font_style)
			frame.text:SetShadowOffset(C.font.filger_font_shadow and 1 or 0, C.font.filger_font_shadow and -1 or 0)
		end
	end

	for weakAura, _ in pairs(WeakAuras.regions) do
		if WeakAuras.regions[weakAura].regionType == "icon" or WeakAuras.regions[weakAura].regionType == "aurabar" then
			Skin_WeakAuras(WeakAuras.regions[weakAura].region)
		end
	end
end)