local T, C, L, _ = unpack(select(2, ...))
if C.skins.npcscan ~= true then return end

----------------------------------------------------------------------------------------
--	NPCScan skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("_NPCScan") then return end
	_NPCScanButton:StripTextures()
	_NPCScanButton:SetTemplate("Transparent")
	_NPCScanButton:SetScale(1)

	_NPCScanTest:SkinButton()

	local checkboxes = {
		"_NPCScanConfigCacheWarningsCheckbox",
		"_NPCScanConfigPrintTimeCheckbox",
		"_NPCScanConfigUnmuteCheckbox",
		"_NPCScanSearchAchievementAddFoundCheckbox"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G[checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	for i = 1, _NPCScanButton:GetNumChildren() do
		local close = select(i, _NPCScanButton:GetChildren())
		if close.GetPushedTexture and close:GetPushedTexture() and not close:GetName() then
			close:StripTextures()
			close:SetPoint("TOPRIGHT", 4, 4)
			close:SetScale(1)

			close:CreateBackdrop("Overlay")
			close.backdrop:SetPoint("TOPLEFT", 8, -8)
			close.backdrop:SetPoint("BOTTOMRIGHT", -8, 8)

			close.text = close:FontString(nil, C.media.normal_font, 17)
			close.text:SetPoint("CENTER", 0, 1)
			close.text:SetText("x")

			close:HookScript("OnEnter", function(self)
				close.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
				if close.backdrop.overlay then
					close.backdrop.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
				end
			end)

			close:HookScript("OnLeave", function(self)
				close.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				if close.backdrop.overlay then
					close.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
			end)
		end

		local text = select(4, _NPCScanButton:GetRegions())
		text:SetTextColor(1, 1, 0)
		text:SetShadowOffset(1, -1)
	end
end)