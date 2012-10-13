local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BonusRoll skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BonusRollFrame:StripTextures()
	BonusRollFrame:CreateBackdrop("Transparent")
	BonusRollFrame.backdrop:Point("TOPLEFT", BonusRollFrame, "TOPLEFT", -9, 6)
	BonusRollFrame.backdrop:Point("BOTTOMRIGHT", BonusRollFrame, "BOTTOMRIGHT", 5, -6)

	BonusRollFrame.PromptFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BonusRollFrame.PromptFrame.IconBackdrop = CreateFrame("Frame", nil, BonusRollFrame.PromptFrame)
	BonusRollFrame.PromptFrame.IconBackdrop:SetTemplate("Default")
	BonusRollFrame.PromptFrame.IconBackdrop:SetFrameLevel(BonusRollFrame.PromptFrame.IconBackdrop:GetFrameLevel() - 1)
	BonusRollFrame.PromptFrame.IconBackdrop:SetPoint("TOPLEFT", BonusRollFrame.PromptFrame.Icon, -2, 2)
	BonusRollFrame.PromptFrame.IconBackdrop:SetPoint("BOTTOMRIGHT", BonusRollFrame.PromptFrame.Icon, 2, -2)

	BonusRollFrame.PromptFrame.Timer.Bar:SetTexture(1, 1, 1)

	BonusRollMoneyWonFrame:StripTextures()
	BonusRollMoneyWonFrame:CreateBackdrop("Transparent")
	BonusRollMoneyWonFrame.backdrop:Point("TOPLEFT", BonusRollMoneyWonFrame, "TOPLEFT", -9, 6)
	BonusRollMoneyWonFrame.backdrop:Point("BOTTOMRIGHT", BonusRollMoneyWonFrame, "BOTTOMRIGHT", 5, -6)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)