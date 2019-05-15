local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	LossOfControl skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local IconBackdrop = CreateFrame("Frame", nil, LossOfControlFrame)
	IconBackdrop:SetTemplate("Default")
	IconBackdrop:ClearAllPoints()
	IconBackdrop:SetPoint("TOPLEFT", LossOfControlFrame.Icon, -2, 2)
	IconBackdrop:SetPoint("BOTTOMRIGHT", LossOfControlFrame.Icon, 2, -2)
	IconBackdrop:SetFrameLevel(LossOfControlFrame:GetFrameLevel() - 1)

	LossOfControlFrame:StripTextures()
	LossOfControlFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	LossOfControlFrame.AbilityName:ClearAllPoints()

	hooksecurefunc("LossOfControlFrame_SetUpDisplay", function(self)
		self.Icon:ClearAllPoints()
		self.Icon:SetPoint("CENTER", self, "CENTER", 0, 0)

		self.AbilityName:ClearAllPoints()
		self.AbilityName:SetPoint("BOTTOM", self, 0, -28)
		self.AbilityName.scrollTime = nil

		self.TimeLeft.NumberText:ClearAllPoints()
		self.TimeLeft.NumberText:SetPoint("BOTTOM", self, 4, -58)
		self.TimeLeft.NumberText.scrollTime = nil

		self.TimeLeft.SecondsText:ClearAllPoints()
		self.TimeLeft.SecondsText:SetPoint("BOTTOM", self, 0, -80)
		self.TimeLeft.SecondsText.scrollTime = nil

		if self.Anim:IsPlaying() then
			self.Anim:Stop()
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)