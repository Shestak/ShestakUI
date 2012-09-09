local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.preform_av ~= true then return end

----------------------------------------------------------------------------------------
--	PreformAVEnabler skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("PreformAVEnabler") then return end

	PreformAVEnablerFrame:StripTextures()
	PreformAVEnablerFrame:SetClampedToScreen(true)
	PreformAVEnablerFrame:SetTemplate("Transparent")

	T.SkinCheckBox(PreformAVEnablerButtonizeCheckButton)

	PreformAVEnablerPVPBGButton:SkinButton()
	PreformAVEnablerPVPBGButton:SetText("Preform AV")
	PreformAVEnablerPVPBGButton:Point("BOTTOMLEFT", PVPFrameLeftButton, "BOTTOMRIGHT", 3, 0)
	PreformAVEnablerPVPBGButton:Point("BOTTOMRIGHT", PVPFrameRightButton, "BOTTOMLEFT", -3, 0)
	PreformAVEnablerFrameCloseButton:SkinButton()
	PreformAVEnablerFrameStatusButton:SkinButton()
end)