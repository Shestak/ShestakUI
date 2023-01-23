local T, C, L, _ = unpack(select(2, ...))
if C.skins.weak_auras ~= true then return end

----------------------------------------------------------------------------------------
--	WeakAuras skin
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("WeakAuras") then return end

local i = 0
local function Skin_WeakAuras(frame, type)
	if not frame.styled then
		if type == "icon" then
			frame.b = CreateFrame("Frame", nil, frame)
			frame.b:CreateBackdrop("Transparent")
			frame.b:SetInside(frame)
			frame.b.backdrop:SetBackdropColor(0, 0, 0, 0)
			frame.b.backdrop:HookScript("OnUpdate", function(self)
				self:SetAlpha(frame.icon:GetAlpha())
			end)
			frame.icon:SetAllPoints(frame.b)
			frame.styled = true
		elseif type == "aurabar" then
			if i < 50 then
				frame.bar:CreateBackdrop("Transparent")
				frame.bar.backdrop:SetBackdropColor(0, 0, 0, 0)
			else
				frame.bar:CreateBackdrop("Default")
			end
			i = i + 1

			frame.styled = true
		end
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

hooksecurefunc(WeakAuras.regionPrototype, "create", function(region)
	if region.regionType == "icon" or region.regionType == "aurabar" then
		Skin_WeakAuras(region, region.regionType)
	end

end)
hooksecurefunc(WeakAuras.regionPrototype, "modifyFinish", function(_, region)
	if region.regionType == "icon" or region.regionType == "aurabar" then
		Skin_WeakAuras(region, region.regionType)
	end
end)