local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Binding skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ClickBindingFrame
	T.SkinFrame(frame)

	frame.TutorialButton.Ring:Hide()
	frame.TutorialButton:SetPoint("TOPLEFT", frame, "TOPLEFT", -12, 12)

	local function updateNewGlow(self)
		if self.NewOutline:IsShown() then
			self.backdrop:SetBackdropBorderColor(0, 0.8, 0)
		else
			self.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end

	local function HandleScrollChild(self)
		for i = 1, self.ScrollTarget:GetNumChildren() do
			local button = select(i, self.ScrollTarget:GetChildren())
			local icon = button and button.Icon
			if icon and not icon.IsSkinned then
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", -4, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)

				icon:SkinIcon(true)
				icon:SetSize(32, 32)
				icon:ClearAllPoints()
				icon:SetPoint("TOPLEFT", button, "TOPLEFT", 3, -7)

				button.Background:Hide()

				button.DeleteButton:SkinButton()
				button.DeleteButton:SetSize(20, 20)
				button.FrameHighlight:SetInside(button.backdrop)
				button.FrameHighlight:SetColorTexture(1, 1, 1, 0.3)

				button.NewOutline:SetTexture("")
				hooksecurefunc(button, "Init", updateNewGlow)

				icon.IsSkinned = true
			end
		end
	end

	hooksecurefunc(frame.ScrollBox, "Update", HandleScrollChild)

	frame.ScrollBar:StripTextures()
	frame.ScrollBar.Background:Hide()
	frame.ScrollBoxBackground:Hide()

	local buttons = {
		"ResetButton",
		"AddBindingButton",
		"SaveButton"
	}

	for _, v in pairs(buttons) do
		frame[v]:SkinButton(true)
	end

	local tutorial = frame.TutorialFrame
	tutorial.NineSlice:StripTextures()
	tutorial:CreateBackdrop("Transparent")
	tutorial.backdrop:SetInside()
end

T.SkinFuncs["Blizzard_ClickBindingUI"] = LoadSkin