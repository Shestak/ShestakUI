local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Gossip skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"GossipFrame",
		"GossipFrameInset",
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
		"GossipFrameGreetingGoodbyeButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton(true)
	end

	local function ColorGossipText()
		local buttons = _G.GossipFrame.buttons
		if buttons and next(buttons) then
			for _, button in ipairs(buttons) do
				local str = button:GetFontString()
				if str then
					str:SetTextColor(1, 1, 1)
					str:SetShadowOffset(1, -1)

					if str:GetText() and str:GetText():find("|cff000000") then
						str:SetText(string.gsub(str:GetText(), "|cff000000", "|cffFFFF00"))
					end
				end
			end
		end
	end

	GossipGreetingText:SetTextColor(1, 1, 1)
	GossipGreetingText:SetShadowOffset(1, -1)

	GossipFrame:CreateBackdrop("Transparent")
	GossipFrame.backdrop:SetAllPoints()

	T.SkinCloseButton(GossipFrameCloseButton, GossipFrame.backdrop)

	GossipGreetingScrollFrame:StripTextures()
	T.SkinScrollBar(GossipGreetingScrollFrameScrollBar)

	NPCFriendshipStatusBar:StripTextures()
	NPCFriendshipStatusBar:SetStatusBarTexture(C.media.texture)
	NPCFriendshipStatusBar:CreateBackdrop("Overlay")
	NPCFriendshipStatusBar.icon:SetPoint("TOPLEFT", -30, 7)

	-- Extreme hackage, blizzard makes button text on quest frame use hex color codes for some reason
	hooksecurefunc("GossipFrameUpdate", function()
		ColorGossipText()
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)