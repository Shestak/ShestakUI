local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Contribution skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "Blizzard_ContributionUI" then
		ContributionTooltip:StripTextures()
		ContributionTooltip:SetTemplate("Transparent")

		ContributionBuffTooltip:StripTextures()
		ContributionBuffTooltip:SetTemplate("Transparent")
	end
end)

if C.skins.blizzard_frames ~= true then return end

local function LoadSkin()

end

T.SkinFuncs["Blizzard_ContributionUI"] = LoadSkin