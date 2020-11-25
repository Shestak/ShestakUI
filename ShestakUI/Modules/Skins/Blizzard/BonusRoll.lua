local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BonusRoll skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- /run BonusRollFrame_StartBonusRoll(242969,"test",40,515,79,14)
	BonusRollFrame:StripTextures()
	BonusRollFrame:CreateBackdrop("Transparent")
	BonusRollFrame.backdrop:SetFrameLevel(0)
	BonusRollFrame.backdrop:SetPoint("TOPLEFT", BonusRollFrame, "TOPLEFT", -9, 6)
	BonusRollFrame.backdrop:SetPoint("BOTTOMRIGHT", BonusRollFrame, "BOTTOMRIGHT", 5, -6)

	BonusRollFrame.PromptFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BonusRollFrame.PromptFrame.Icon:SetSize(50, 50)
	BonusRollFrame.PromptFrame.Icon:ClearAllPoints()
	BonusRollFrame.PromptFrame.Icon:SetPoint("LEFT", BonusRollFrame, 0, 6)

	BonusRollFrame.PromptFrame.IconBackdrop = CreateFrame("Frame", nil, BonusRollFrame.PromptFrame)
	BonusRollFrame.PromptFrame.IconBackdrop:SetTemplate("Default")
	BonusRollFrame.PromptFrame.IconBackdrop:SetFrameLevel(BonusRollFrame.PromptFrame.IconBackdrop:GetFrameLevel() - 1)
	BonusRollFrame.PromptFrame.IconBackdrop:SetPoint("TOPLEFT", BonusRollFrame.PromptFrame.Icon, -2, 2)
	BonusRollFrame.PromptFrame.IconBackdrop:SetPoint("BOTTOMRIGHT", BonusRollFrame.PromptFrame.Icon, 2, -2)

	BonusRollFrame.PromptFrame.Timer:CreateBackdrop("Default")
	BonusRollFrame.PromptFrame.Timer:SetStatusBarTexture(C.media.texture)
	BonusRollFrame.PromptFrame.Timer:SetPoint("BOTTOMLEFT", BonusRollFrame.PromptFrame, "BOTTOMLEFT", 0, 1)

	BonusRollFrame.SpecRing:SetTexture("")
	BonusRollFrame.SpecIcon:SetPoint("TOPLEFT", BonusRollFrame, "TOPLEFT", 0, -3)
	BonusRollFrame.SpecIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	-- BonusRollFrame.SpecIcon:SetTexture("Interface\\Icons\\spell_nature_brilliance")

	BonusRollFrame.SpecIcon.b = CreateFrame("Frame", nil, BonusRollFrame)
	BonusRollFrame.SpecIcon.b:SetFrameLevel(6)
	BonusRollFrame.SpecIcon.b:SetTemplate("Default")
	BonusRollFrame.SpecIcon.b:SetPoint("TOPLEFT", BonusRollFrame.SpecIcon, "TOPLEFT", -2, 2)
	BonusRollFrame.SpecIcon.b:SetPoint("BOTTOMRIGHT", BonusRollFrame.SpecIcon, "BOTTOMRIGHT", 2, -2)
	BonusRollFrame.SpecIcon:SetParent(BonusRollFrame.SpecIcon.b)

	hooksecurefunc(BonusRollFrame.SpecIcon, "Hide", function(specIcon)
		if specIcon.b and specIcon.b:IsShown() then
			specIcon.b:Hide()
		end
	end)

	hooksecurefunc(BonusRollFrame.SpecIcon, "Show", function(specIcon)
		if specIcon.b and not specIcon.b:IsShown() and specIcon:GetTexture() ~= nil then
			specIcon.b:Show()
		end
	end)

	-- Skin currency icons
	hooksecurefunc("BonusRollFrame_StartBonusRoll", function()
		local ccf, pfifc = BonusRollFrame.CurrentCountFrame.Text, BonusRollFrame.PromptFrame.InfoFrame.Cost
		local text1, text2 = ccf and ccf:GetText(), pfifc and pfifc:GetText()
		if text1 and text1:find("|t") then ccf:SetText(text1:gsub("|T(.-):.-|t", "|T%1:16:16:0:0:64:64:5:59:5:59|t")) end
		if text2 and text2:find("|t") then pfifc:SetText(text2:gsub("|T(.-):.-|t", "|T%1:16:16:0:0:64:64:5:59:5:59|t")) end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)