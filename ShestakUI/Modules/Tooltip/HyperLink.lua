local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.tooltip.enable ~= true or IsAddOnLoaded("tekKompare") then return end

----------------------------------------------------------------------------------------
--	Based on tekKompare(by Tekkub)
----------------------------------------------------------------------------------------
local orig1, orig2, GameTooltip = {}, {}, GameTooltip
local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true, instancelock = true, currency = true}

local function OnHyperlinkEnter(frame, link, ...)
	local linktype = link:match("^([^:]+)")
	if linktype and linktype == "battlepet" then
		GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT", -3, 0)
		GameTooltip:Show()
		local _, speciesID, level, breedQuality, maxHealth, power, speed = strsplit(":", link)
		BattlePetToolTip_Show(tonumber(speciesID), tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed))
	elseif linktype and linktypes[linktype] then
		GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT", -3, 0)
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end

	if orig1[frame] then return orig1[frame](frame, link, ...) end
end

local function OnHyperlinkLeave(frame, link, ...)
	if not T.classic then
		if BattlePetTooltip:IsShown() then
			BattlePetTooltip:Hide()
		else
			GameTooltip:Hide()
		end
	else
		GameTooltip:Hide()
	end

	if orig1[frame] then return orig1[frame](frame, link, ...) end
end

for i = 1, NUM_CHAT_WINDOWS do
	local frame = _G["ChatFrame"..i]
	orig1[frame] = frame:GetScript("OnHyperlinkEnter")
	frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)

	orig2[frame] = frame:GetScript("OnHyperlinkLeave")
	frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
end