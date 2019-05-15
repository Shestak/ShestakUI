local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Gossip skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frames = {
		"Quest",
		"Gossip"
	}

	local panels = {
		"Greeting",
		"Detail",
		"Progress",
		"Reward"
	}

	local buttons = {
		QuestFrameGreetingGoodbyeButton,
		GossipFrameGreetingGoodbyeButton,
		QuestFrameDeclineButton,
		QuestFrameAcceptButton,
		QuestFrameGoodbyeButton,
		QuestFrameCompleteButton,
		QuestFrameCancelButton,
		QuestFrameCompleteQuestButton
	}

	local StripAllTextures = {
		"GossipFrame",
		-- "GossipFrameInset",
		"GossipFrameGreetingPanel"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local KillTextures = {
		"GossipFramePortrait"
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		"QuestFrameGreetingGoodbyeButton",
		"GossipFrameGreetingGoodbyeButton",
		"QuestFrameDeclineButton",
		"QuestFrameAcceptButton",
		"QuestFrameGoodbyeButton",
		"QuestFrameCompleteButton",
		"QuestFrameCancelButton",
		"QuestFrameCompleteQuestButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton(true)
	end

	for i = 1, NUMGOSSIPBUTTONS do
		obj = select(3, _G["GossipTitleButton"..i]:GetRegions())
		obj:SetTextColor(1, 1, 1)
		obj:SetShadowOffset(1, -1)
	end

	GossipGreetingText:SetTextColor(1, 1, 1)
	GossipGreetingText:SetShadowOffset(1, -1)

	GossipFrame:CreateBackdrop("Transparent")
	GossipFrame.backdrop:SetAllPoints()
	GossipFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	GossipFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 66)

	T.SkinCloseButton(GossipFrameCloseButton, GossipFrame.backdrop)

	GossipGreetingScrollFrame:ClearAllPoints()
	GossipGreetingScrollFrame:SetPoint("TOPLEFT", GossipFrame, "TOPLEFT", 22, -76)
	GossipGreetingScrollFrame:StripTextures()
	T.SkinScrollBar(GossipGreetingScrollFrameScrollBar)

	NPCFriendshipStatusBar:StripTextures()
	NPCFriendshipStatusBar:SetStatusBarTexture(C.media.texture)
	NPCFriendshipStatusBar:CreateBackdrop("Overlay")
	NPCFriendshipStatusBar.icon:SetPoint("TOPLEFT", -30, 7)

	-- Extreme hackage, blizzard makes button text on quest frame use hex color codes for some reason
	hooksecurefunc("GossipFrameUpdate", function()
		for i = 1, NUMGOSSIPBUTTONS do
			local button = _G["GossipTitleButton"..i]

			if button:GetFontString() then
				if button:GetFontString():GetText() and button:GetFontString():GetText():find("|cff000000") then
					button:GetFontString():SetText(string.gsub(button:GetFontString():GetText(), "|cff000000", "|cffFFFF00"))
				end
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)