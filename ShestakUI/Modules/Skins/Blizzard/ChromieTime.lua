local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Chromie Time skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ChromieTimeFrame
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:SetTemplate("Transparent")
	frame.Background:Hide()

	frame.SelectButton:SkinButton()

	local Title = frame.Title
	Title:DisableDrawLayer("BACKGROUND")

	local InfoFrame = frame.CurrentlySelectedExpansionInfoFrame
	InfoFrame:DisableDrawLayer("BACKGROUND")
	InfoFrame:CreateBackdrop("Overlay")
	InfoFrame.backdrop:SetPoint("BOTTOMRIGHT", 2, -10)
	InfoFrame.Name:SetTextColor(1, .8, 0)
	InfoFrame.Description:SetTextColor(1, 1, 1)

	InfoFrame.PortraitBorder:SetAlpha(0)
	InfoFrame.Portrait:SetTexCoord(0.01022494887526, 0.98977505112474, 0.01968503937008, 0.98031496062992)

	InfoFrame.ArtBackdrop = CreateFrame("Frame", nil, InfoFrame)
	InfoFrame.ArtBackdrop:SetFrameLevel(InfoFrame:GetFrameLevel() - 1)
	InfoFrame.ArtBackdrop:SetPoint("TOPLEFT", InfoFrame.Portrait, -2, 2)
	InfoFrame.ArtBackdrop:SetPoint("BOTTOMRIGHT", InfoFrame.Portrait, 2, -2)
	InfoFrame.ArtBackdrop:SetTemplate("Default")

	hooksecurefunc(ChromieTimeExpansionButtonMixin, "SetupButton", function(self)
		if not self.ArtBackdrop then
			self.ArtBackdrop = CreateFrame("Frame", nil, self)
			self.ArtBackdrop:SetFrameLevel(self:GetFrameLevel() - 1)
			self.ArtBackdrop:SetPoint("TOPLEFT", self.Background, -2, 2)
			self.ArtBackdrop:SetPoint("BOTTOMRIGHT", self.Background, 2, -2)
			self.ArtBackdrop:SetTemplate("Default")
			self.Background:SetTexCoord(0.01602564102564, 0.97109826589595, 0.02890173410405, 0.97109826589595)
			self:SetNormalTexture(0)
			if self.SetHighlightTexture then
				local highlight = self:CreateTexture()
				highlight:SetColorTexture(1, 1, 1, 0.3)
				highlight:SetPoint("TOPLEFT", self.Background, 0, 0)
				highlight:SetPoint("BOTTOMRIGHT", self.Background, 0, 0)
				self:SetHighlightTexture(highlight)
			end
		end
	end)

	hooksecurefunc(ChromieTimeExpansionButtonMixin, "OnClick", function(self)
		self:SetNormalTexture(0)
		self.ArtBackdrop:SetBackdropBorderColor(1, 1, 0)
	end)

	hooksecurefunc(ChromieTimeExpansionButtonMixin, "ClearSelection", function(self)
		self:SetNormalTexture(0)
		self.ArtBackdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	end)
end

T.SkinFuncs["Blizzard_ChromieTimeUI"] = LoadSkin