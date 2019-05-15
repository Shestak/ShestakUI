local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.announcements.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Check Safari Hat
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "PetSafariButton", UIParent, "SecureActionButtonTemplate, ActionButtonTemplate")
button:Hide()
button:SetAttribute("type", "toy")
button:SetAttribute("toy", 92738)
button:SetTemplate("Default")
button:StyleButton()
button:SetNormalTexture(nil)
button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
button.icon:ClearAllPoints()
button.icon:SetPoint("TOPLEFT", 2, -2)
button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
button.icon:SetTexture("Interface\\Icons\\inv_helm_cloth_petsafari_a_01")

button:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	GameTooltip:SetToyByItemID(92738)
end)

button:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:SetScript("OnEvent", function()
	button:Hide()
	local name = GetSpellInfo(158486)
	if PlayerHasToy(92738) and not T.CheckPlayerBuff(name) then
		local maxlevel = true
		for i = 1, 3 do
			local level = C_PetBattles.GetLevel(1, i)
			if level and level < 25 then
				maxlevel = false
			end
		end
		if maxlevel then return end
		button:SetPoint("BOTTOM", PetBattleBarHolder, "TOP", 0, 27)
		button:Show()
		PlaySound(SOUNDKIT.RAID_WARNING, "master")
		RaidNotice_AddMessage(RaidWarningFrame, RESISTANCE_NONE.." "..GetSpellLink(158486).."!", ChatTypeInfo["RAID_WARNING"])
		print("|cffff3300"..RESISTANCE_NONE.." "..GetSpellLink(158486).."|cffff3300!|r")
	end
end)