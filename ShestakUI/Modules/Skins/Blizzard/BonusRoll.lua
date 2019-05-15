local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BonusRoll skin
----------------------------------------------------------------------------------------
local function LoadSkin()
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
	BonusRollFrame.PromptFrame.Timer.Bar:SetColorTexture(1, 1, 1)
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

	hooksecurefunc("BonusRollFrame_StartBonusRoll", function()
		BonusRollFrame.SpecIcon.b:SetShown(BonusRollFrame.SpecIcon:IsShown() and BonusRollFrame.SpecIcon:GetTexture() ~= nil)
	end)

	BonusRollMoneyWonFrame:StripTextures()
	BonusRollMoneyWonFrame:CreateBackdrop("Transparent")
	BonusRollMoneyWonFrame.backdrop:SetPoint("TOPLEFT", BonusRollMoneyWonFrame, "TOPLEFT", -9, 6)
	BonusRollMoneyWonFrame.backdrop:SetPoint("BOTTOMRIGHT", BonusRollMoneyWonFrame, "BOTTOMRIGHT", 5, -6)

	BonusRollLootWonFrame:StripTextures()
	BonusRollLootWonFrame:CreateBackdrop("Transparent")
	BonusRollLootWonFrame.backdrop:SetPoint("TOPLEFT", BonusRollLootWonFrame, "TOPLEFT", -9, 6)
	BonusRollLootWonFrame.backdrop:SetPoint("BOTTOMRIGHT", BonusRollLootWonFrame, "BOTTOMRIGHT", 5, -6)
	
	T.SkinHelpBox(BonusRollFrame.PromptFrame.EncounterJournalLinkButtonHelp)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
