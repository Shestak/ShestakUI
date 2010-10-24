----------------------------------------------------------------------------------------
--	Battlefield score frame
----------------------------------------------------------------------------------------
if WorldStateAlwaysUpFrame then
	WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
	WorldStateAlwaysUpFrame:SetFrameLevel(0)
	WorldStateAlwaysUpFrame:ClearAllPoints()
	WorldStateAlwaysUpFrame:SetPoint(unpack(SettingsCF["position"].attempt))
	WorldStateAlwaysUpFrame.SetPoint = SettingsDB.dummy
end

----------------------------------------------------------------------------------------
--	Force readycheck warning 
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator, timeLeft)
	if initiator ~= "player" then
		PlaySound("ReadyCheck")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	ALT+Click to buy a stack
----------------------------------------------------------------------------------------
hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, button)
    if MerchantFrame.selectedTab == 1 then
        --if IsAltKeyDown() and button=="RightButton" then
		if IsAltKeyDown() then
            local id=self:GetID()
            local extracost = select(7, GetMerchantItemInfo(id))
            if not extracost then
                local stack = select(8, GetItemInfo(self.link))
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

----------------------------------------------------------------------------------------
--	Auto decline duels
----------------------------------------------------------------------------------------
if SettingsCF["misc"].auto_decline_duel == true then
    local dd = CreateFrame("Frame")
    dd:RegisterEvent("DUEL_REQUESTED")
    dd:SetScript("OnEvent", function(self, event, name)
		HideUIPanel(StaticPopup1)
		CancelDuel()
		SettingsDB.InfoTextShow(L_INFO_DUEL..name)
		print(format("|cffffff00"..L_INFO_DUEL..name.."."))
    end)
end

----------------------------------------------------------------------------------------
--	Check Flask(Flasked North by v6o)
----------------------------------------------------------------------------------------
local checkflask = CreateFrame("Frame")
checkflask:SetScript("OnEvent", function(self, event, ...)
	local PlayerGUID = UnitGUID("player")
	local _, CombatEvent, _, _, _, DestGUID, _, _, SpellID = ...
	if CombatEvent == "SPELL_AURA_APPLIED" and DestGUID == PlayerGUID then
		if SpellID == 67016 then
			SettingsDB.InfoTextShow(L_FLASK_SPD)
		elseif SpellID == 67017 then
			SettingsDB.InfoTextShow(L_FLASK_AP)
		elseif SpellID == 67018 then
			SettingsDB.InfoTextShow(L_FLASK_STR)
		end
	end
end)
checkflask:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

----------------------------------------------------------------------------------------
--	Protection from hidden windows auction at the opening of other windows(by Fernir)
----------------------------------------------------------------------------------------
--[[
local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("ADDON_LOADED")
eventframe:SetScript("OnEvent", function(self, event, addon)
    if addon == "Blizzard_AuctionUI" then
        AuctionFrame:SetMovable(true)
        AuctionFrame:SetClampedToScreen(true)
        AuctionFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
        AuctionFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)

        local handleAuctionFrame = function(self)
            if AuctionFrame:GetAttribute("UIPanelLayout-enabled") then
                if AuctionFrame:IsVisible() then
                    AuctionFrame.Hide = function() end
                    HideUIPanel(AuctionFrame)
                    AuctionFrame.Hide = nil
                end
                AuctionFrame:SetAttribute("UIPanelLayout-enabled", nil)
            else
                if AuctionFrame:IsVisible() then
                    AuctionFrame.IsShown = function() end
                    ShowUIPanel(AuctionFrame)
                    AuctionFrame.IsShown = nil
                end
            end
        end
        hooksecurefunc("AuctionFrame_Show", handleAuctionFrame)
        hooksecurefunc("AuctionFrame_Hide", handleAuctionFrame)
      
      self:UnregisterEvent"ADDON_LOADED"
      self:SetScript("OnEvent", nil)
    end
end)]]

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if SettingsCF["misc"].afk_spin_camera == true then
	local SpinCam = CreateFrame("Frame")

	local OnEvent = function(self, event, unit)
		if (event == "PLAYER_FLAGS_CHANGED") then
			if unit == "player" then
				if UnitIsAFK(unit) then
					SpinStart()
				else
					SpinStop()
				end
			end
		elseif (event == "PLAYER_LEAVING_WORLD") then
			SpinStop()
		end
	end
	SpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", OnEvent)

	function SpinStart()
		spinning = true
		--SaveView(4)
		--ResetView(5)
		--SetView(5)
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		--SetView(4)
		UIParent:Show()
	end
end