local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Soulbinds skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = SoulbindViewer
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:CreateBackdrop("Transparent")
	frame.Background:Hide()

	frame.CommitConduitsButton:SkinButton()
	frame.ActivateSoulbindButton:SkinButton()

	local function SkinConduitList(frame)
		local header = frame.CategoryButton.Container
		if not header.backdrop then
			header:DisableDrawLayer("BACKGROUND")
			header:CreateBackdrop("Overlay")
			header.backdrop:SetPoint("TOPLEFT", 2, 0)
			header.backdrop:SetPoint("BOTTOMRIGHT", 15, 0)
		end

		for button in frame.pool:EnumerateActive() do
			if not button.styled then
				for _, element in ipairs(button.Hovers) do
					local _, sublevel = element:GetDrawLayer()
					if sublevel == 4 then -- Highlight texture
						element:SetColorTexture(1, 1, 1, 0.3)
						element:SetPoint("TOPLEFT", button, "TOPLEFT", 11, 0)
					end
				end
				button.PendingBackground:SetColorTexture(0.9, 0.8, 0.1, 0.3)
				button.PendingBackground:SetPoint("TOPLEFT", button, "TOPLEFT", 11, 0)

				button.styled = true
			end
		end
	end

	local numChildrenStyled = 0
	hooksecurefunc(SoulbindViewer.ConduitList.ScrollBox, "Update", function(self)
		local numChildren = self.ScrollTarget:GetNumChildren()
		if numChildren > numChildrenStyled then
			for i = 1, numChildren do
				local list = select(i, self.ScrollTarget:GetChildren())
				if list and not list.hooked then
					hooksecurefunc(list, "Layout", SkinConduitList)
					list.hooked = true
				end
			end

			numChildrenStyled = numChildren
		end
	end)
end

T.SkinFuncs["Blizzard_Soulbinds"] = LoadSkin