local T, C, L = unpack(ShestakUI)
if C.extra_bar.light_macro ~= true then return end

----------------------------------------------------------------------------------------
--	Light macro button when proc spell(LightMyMacro by Adirelle)
----------------------------------------------------------------------------------------
local overlayedSpells = {}

hooksecurefunc("ActionButton_HideOverlayGlow", function(button)
	if button.__LAB_Version then return end
	local actionType, actionParam = GetActionInfo(button.action)
	if actionType == "macro" and overlayedSpells[GetMacroSpell(actionParam) or false] then
		return ActionButton_ShowOverlayGlow(button)
	end
end)

hooksecurefunc("ActionButton_OnEvent",  function(button, event, id)
	if event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then
		local spell, actionType, actionParam = GetSpellInfo(id), GetActionInfo(button.action)
		local show = event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"
		overlayedSpells[spell] = show
		if actionType == "macro" and GetMacroSpell(actionParam) == spell then
			if show then
				return ActionButton_ShowOverlayGlow(button)
			else
				return ActionButton_HideOverlayGlow(button)
			end
		end
	end
end)
