local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator, timeLeft)
	if initiator ~= "player" then
		PlaySound("ReadyCheck", "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	ALT+Click to buy a stack
----------------------------------------------------------------------------------------
hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, button)
	if MerchantFrame.selectedTab == 1 then
		if IsAltKeyDown() then
			local id = self:GetID()
			local quantity = select(4, GetMerchantItemInfo(id))
			local extracost = select(7, GetMerchantItemInfo(id))
			if not extracost then
				local stack
				if quantity > 1 then
					stack = quantity * GetMerchantItemMaxStack(id)
				else
					stack = GetMerchantItemMaxStack(id)
				end
				local amount = 1
				if self.count < stack then
					amount = stack / self.count
				end
				if self.numInStock ~= -1 and self.numInStock < amount then
					amount = self.numInStock
				end
				local money = GetMoney()
				if (self.price * amount) > money then
					amount = floor(money / self.price)
				end
				if amount > 0 then
					BuyMerchantItem(id, amount)
				end
			end
		end
	end
end)

local function IsMerchantButtonOver()
	return GetMouseFocus():GetName() and GetMouseFocus():GetName():find("MerchantItem%d")
end

GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if MerchantFrame:IsShown() and IsMerchantButtonOver() then
		for i = 2, GameTooltip:NumLines() do
			if _G["GameTooltipTextLeft"..i]:GetText():find("<[sS]hift") then
				GameTooltip:AddLine("|cff00ff00<"..L_MISC_BUY_STACK..">|r")
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if C.misc.afk_spin_camera == true then
	local SpinCam = CreateFrame("Frame")

	local OnEvent = function(self, event, unit)
		if event == "PLAYER_FLAGS_CHANGED" then
			if unit == "player" then
				if UnitIsAFK(unit) then
					SpinStart()
				else
					SpinStop()
				end
			end
		elseif event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		end
	end
	SpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", OnEvent)

	function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		UIParent:Show()
	end
end

----------------------------------------------------------------------------------------
--	Custom Lag Tolerance(by Elv22)
----------------------------------------------------------------------------------------
if C.general.custom_lagtolerance == true then
	InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset:Hide()
	InterfaceOptionsCombatPanelReducedLagTolerance:Hide()

	local customlag = CreateFrame("Frame")
	local int = 5
	local LatencyUpdate = function(self, elapsed)
		int = int - elapsed
		if int < 0 then
			if GetCVar("reducedLagTolerance") ~= tostring(1) then SetCVar("reducedLagTolerance", tostring(1)) end
			if select(3, GetNetStats()) ~= 0 and select(3, GetNetStats()) <= 400 then
				SetCVar("maxSpellStartRecoveryOffset", tostring(select(3, GetNetStats())))
			end
			int = 5
		end
	end
	customlag:SetScript("OnUpdate", LatencyUpdate)
	LatencyUpdate(customlag, 10)
end

----------------------------------------------------------------------------------------
--	Remove Boss Emote spam during BG(ArathiBasin SpamFix by Partha)
----------------------------------------------------------------------------------------
if C.misc.hide_bg_spam == true then
	local Fixer = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame

	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN or GetZoneText() == L_ZONE_GILNEAS then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end

	Fixer:RegisterEvent("PLAYER_ENTERING_WORLD")
	Fixer:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Fixer:SetScript("OnEvent", DisableSpam)
end

----------------------------------------------------------------------------------------
--	Undress button in auction dress-up frame(by Nefarion)
----------------------------------------------------------------------------------------
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetHeight(22)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:SetScript("OnClick", function(this)
	this.model:Undress()
	PlaySound("gsTitleOptionOK")
end)
strip.model = DressUpModel

strip:RegisterEvent("AUCTION_HOUSE_SHOW")
strip:RegisterEvent("AUCTION_HOUSE_CLOSED")

strip:SetScript("OnEvent", function(this)
	if AuctionFrame:IsVisible() and this.model ~= SideDressUpModel then
		this:SetParent(SideDressUpModel)
		this:ClearAllPoints()
		this:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
		this.model = SideDressUpModel
	elseif this.model ~= DressUpModel then
		this:SetParent(DressUpModel)
		this:ClearAllPoints()
		this:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		this.model = DressUpModel
	end
end)

----------------------------------------------------------------------------------------
--	GuildTab in FriendsFrame
----------------------------------------------------------------------------------------
local n = FriendsFrame.numTabs + 1
local gtframe = CreateFrame("Button", "FriendsFrameTab"..n, FriendsFrame, "FriendsFrameTabTemplate")
gtframe:SetID(n)
gtframe:SetText(GUILD)
gtframe:SetPoint("LEFT", _G["FriendsFrameTab"..n - 1], "RIGHT", -15, 0)
gtframe:RegisterForClicks("AnyUp")
gtframe:SetScript("OnClick", function()
	if IsInGuild() then
		if not GuildFrame then
			LoadAddOn("Blizzard_GuildUI")
		end
		ToggleGuildFrame()
		GuildFrame_TabClicked(GuildFrameTab2)
	else
		if not LookingForGuildFrame then
			LoadAddOn("Blizzard_LookingForGuildUI")
		end
		if not LookingForGuildFrame then return end
		LookingForGuildFrame_Toggle()
	end
end)
PanelTemplates_SetNumTabs(FriendsFrame, n)
PanelTemplates_EnableTab(FriendsFrame, n)

----------------------------------------------------------------------------------------
--	Switch layout mouseover button on minimap
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "SwitchLayout", UIParent)
button:SetTemplate("Transparent")
button:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
if C.actionbar.toggle_mode == true then
	button:Point("TOPLEFT", Minimap, "TOPRIGHT", 3, -18)
else
	button:Point("TOPLEFT", Minimap, "TOPRIGHT", 3, 2)
end
button:Size(19)
button:SetAlpha(0)

local texture = button:CreateTexture(nil, "OVERLAY")
texture:SetTexture("Interface\\LFGFrame\\LFGROLE")
texture:SetPoint("TOPLEFT", button, 2, -2)
texture:SetPoint("BOTTOMRIGHT", button, -2, 2)

button:SetScript("OnClick", function()
	if IsAddOnLoaded("ShestakUI_DPS") then
		DisableAddOn("ShestakUI_DPS")
		EnableAddOn("ShestakUI_Heal")
		ReloadUI()
	elseif IsAddOnLoaded("ShestakUI_Heal") then
		DisableAddOn("ShestakUI_Heal")
		EnableAddOn("ShestakUI_DPS")
		ReloadUI()
	elseif not IsAddOnLoaded("ShestakUI_Heal") and not IsAddOnLoaded("ShestakUI_DPS") then
		EnableAddOn("ShestakUI_Heal")
		ReloadUI()
	end
end)

button:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	button:FadeIn()
end)

button:SetScript("OnLeave", function()
	button:FadeOut()
end)

button:RegisterEvent("PLAYER_LOGIN")
button:SetScript("OnEvent", function(self)
	if IsAddOnLoaded("ShestakUI_DPS") then
		texture:SetTexCoord(0.25, 0.5, 0, 1)
	elseif IsAddOnLoaded("ShestakUI_Heal") then
		texture:SetTexCoord(0.75, 1, 0, 1)
	elseif not IsAddOnLoaded("ShestakUI_Heal") and not IsAddOnLoaded("ShestakUI_DPS") then
		texture:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01")
		texture:SetTexCoord(0.2, 0.8, 0.2, 0.8)
	end
end)

----------------------------------------------------------------------------------------
--	Misclicks for some popup
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE_XREALM.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.PET_BATTLE_QUEUE_PROPOSE_MATCH.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_BATTLEFIELD_ENTRY.button2 = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil

----------------------------------------------------------------------------------------
--	Fix SearchLFGLeave() taint
----------------------------------------------------------------------------------------
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function(self, elapsed)
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)

----------------------------------------------------------------------------------------
--	Fix LFRBrowseFrameList/LFRQueueFrameSpecificList scroll frames
----------------------------------------------------------------------------------------
LFRBrowseFrameListScrollFrame:ClearAllPoints()
LFRBrowseFrameListScrollFrame:SetPoint("TOPLEFT", LFRBrowseFrameListButton1, "TOPLEFT", 0, 0)
LFRBrowseFrameListScrollFrame:SetPoint("BOTTOMRIGHT", LFRBrowseFrameListButton19, "BOTTOMRIGHT", 5, -2)
LFRQueueFrameSpecificListScrollFrame:ClearAllPoints()
LFRQueueFrameSpecificListScrollFrame:SetPoint("TOPLEFT", LFRQueueFrameSpecificListButton1, "TOPLEFT", 0, 0)
LFRQueueFrameSpecificListScrollFrame:SetPoint("BOTTOMRIGHT", LFRQueueFrameSpecificListButton14, "BOTTOMRIGHT", 0, -2)