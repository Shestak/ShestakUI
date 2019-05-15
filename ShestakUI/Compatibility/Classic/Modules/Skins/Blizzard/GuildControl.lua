local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return else return end -- incomplete

----------------------------------------------------------------------------------------
--	GuildControlUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	GuildControlUI:StripTextures()
	GuildControlUIHbar:StripTextures()
	GuildControlUI:SetTemplate("Transparent")
	GuildControlUI:ClearAllPoints()
	GuildControlUI:SetPoint("TOPLEFT", GuildFrame, "TOPRIGHT", 3, 0)
	GuildControlUI:SetFrameLevel(GuildControlUI:GetFrameLevel() + 2)

	local function SkinGuildRanks()
		for i = 1, GuildControlGetNumRanks() do
			local rankFrame = _G["GuildControlUIRankOrderFrameRank"..i]
			if rankFrame then
				rankFrame.downButton:SkinButton()
				rankFrame.upButton:SkinButton()
				rankFrame.deleteButton:SkinButton()

				if not rankFrame.nameBox.backdrop then
					T.SkinEditBox(rankFrame.nameBox)
				end

				rankFrame.nameBox.backdrop:SetPoint("TOPLEFT", -2, -4)
				rankFrame.nameBox.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)
			end
		end
	end
	hooksecurefunc("GuildControlUI_RankOrder_Update", SkinGuildRanks)

	T.SkinDropDownBox(GuildControlUINavigationDropDown)
	T.SkinDropDownBox(GuildControlUIRankSettingsFrameRankDropDown, 180)
	GuildControlUINavigationDropDownButton:SetWidth(20)
	GuildControlUIRankSettingsFrameRankDropDownButton:SetWidth(20)

	for i = 1, NUM_RANK_FLAGS do
		if _G["GuildControlUIRankSettingsFrameCheckbox"..i] then
			T.SkinCheckBox(_G["GuildControlUIRankSettingsFrameCheckbox"..i])
		end
	end

	GuildControlUIRankOrderFrameNewButton:SkinButton()

	T.SkinEditBox(GuildControlUIRankSettingsFrameGoldBox)
	GuildControlUIRankSettingsFrameGoldBox.backdrop:SetPoint("TOPLEFT", -2, -4)
	GuildControlUIRankSettingsFrameGoldBox.backdrop:SetPoint("BOTTOMRIGHT", 2, 4)
	GuildControlUIRankSettingsFrameGoldBox:StripTextures()

	GuildControlUIRankBankFrameInset:StripTextures()
	GuildControlUIRankBankFrameInsetScrollFrame:StripTextures()

	hooksecurefunc("GuildControlUI_BankTabPermissions_Update", function()
		local numTabs = GetNumGuildBankTabs()
		if numTabs < MAX_BUY_GUILDBANK_TABS then
			numTabs = numTabs + 1
		end
		for i = 1, numTabs do
			local tab = _G["GuildControlBankTab"..i.."Owned"]
			local purchase = _G["GuildControlBankTab"..i.."BuyPurchaseButton"]
			local icon = tab.tabIcon
			local editbox = tab.editBox

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			T.SkinCheckBox(_G["GuildControlBankTab"..i.."OwnedViewCheck"])
			T.SkinCheckBox(_G["GuildControlBankTab"..i.."OwnedDepositCheck"])
			T.SkinCheckBox(_G["GuildControlBankTab"..i.."OwnedUpdateInfoCheck"])
			T.SkinEditBox(editbox)

			if purchase:GetNumRegions() < 9 then
				purchase:SkinButton()
			end
		end
	end)

	T.SkinDropDownBox(GuildControlUIRankBankFrameRankDropDown, 180)
	GuildControlUIRankBankFrameRankDropDownButton:SetWidth(20)

	T.SkinCloseButton(GuildControlUICloseButton)
end

T.SkinFuncs["Blizzard_GuildControlUI"] = LoadSkin