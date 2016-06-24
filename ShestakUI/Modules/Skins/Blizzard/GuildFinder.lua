local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	LookingForGuildUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Checkboxes
	local checkbox = {
		"LookingForGuildPvPButton",
		"LookingForGuildWeekendsButton",
		"LookingForGuildWeekdaysButton",
		"LookingForGuildRPButton",
		"LookingForGuildRaidButton",
		"LookingForGuildQuestButton",
		"LookingForGuildDungeonButton"
	}

	for _, v in pairs(checkbox) do
		T.SkinCheckBox(_G[v])
	end

	-- Backdrops
	local backdrop = {
		"LookingForGuildInterestFrame",
		"LookingForGuildAvailabilityFrame",
		"LookingForGuildRolesFrame",
		"LookingForGuildCommentFrame"
	}

	for _, v in pairs(backdrop) do
		_G[v]:StripTextures()
	end

	T.SkinCheckBox(LookingForGuildTankButton.checkButton)
	T.SkinCheckBox(LookingForGuildHealerButton.checkButton)
	T.SkinCheckBox(LookingForGuildDamagerButton.checkButton)

	-- Other frames
	LookingForGuildFrameInset:StripTextures(false)
	LookingForGuildFrame:StripTextures()
	LookingForGuildFrame:SetTemplate("Transparent")
	LookingForGuildBrowseButton_LeftSeparator:Kill()
	LookingForGuildRequestButton_RightSeparator:Kill()
	T.SkinScrollBar(LookingForGuildBrowseFrameContainerScrollBar)
	LookingForGuildBrowseButton:SkinButton()
	LookingForGuildRequestButton:SkinButton()
	T.SkinCloseButton(LookingForGuildFrameCloseButton)
	LookingForGuildCommentInputFrame:CreateBackdrop("Overlay")
	LookingForGuildCommentInputFrame:StripTextures(false)
	GuildFinderRequestMembershipFrame:StripTextures(true)
	GuildFinderRequestMembershipFrame:SetTemplate("Transparent")
	GuildFinderRequestMembershipFrameAcceptButton:SkinButton()
	GuildFinderRequestMembershipFrameCancelButton:SkinButton()
	GuildFinderRequestMembershipFrameInputFrame:StripTextures()
	GuildFinderRequestMembershipFrameInputFrame:SetTemplate("Overlay")

	-- Container buttons
	for i = 1, 5 do
		local b = _G["LookingForGuildBrowseFrameContainerButton"..i]
		local t = _G["LookingForGuildAppsFrameContainerButton"..i]

		b:SetTemplate("Overlay")
		b:StyleButton()
		b.selectedTex:SetDrawLayer("ARTWORK")
		b.selectedTex:SetColorTexture(1, 0.82, 0, 0.3)
		b.selectedTex:SetPoint("TOPLEFT", 2, -2)
		b.selectedTex:SetPoint("BOTTOMRIGHT", -2, 2)

		if i ~= 1 then
			b:SetPoint("TOPLEFT", _G["LookingForGuildBrowseFrameContainerButton"..i - 1], "BOTTOMLEFT", 0, -2)
		end

		t:SetBackdrop(nil)
	end

	-- Tabs
	for i = 1, 3 do
		T.SkinTab(_G["LookingForGuildFrameTab"..i], true)
	end
end

T.SkinFuncs["Blizzard_LookingForGuildUI"] = LoadSkin