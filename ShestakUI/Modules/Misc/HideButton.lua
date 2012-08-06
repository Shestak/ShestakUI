local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--  HideButton : a button to hide your chat and minimap
----------------------------------------------------------------------------------------
local HideB = CreateFrame("Frame", "HideB", UIParent)
HideB:CreatePanel("ClassColor", 18, 18, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -1, 0)

HideB:SetAlpha(0)
HideB:SetScript("OnEnter", function() HideB:SetAlpha(1) end)
HideB:SetScript("OnLeave", function() HideB:SetAlpha(0) end)

HideB.ChatIsShown = true
HideB.MinimapIsShown = true
HideB.ActiveTabs = {[1] = true}

-- Hide Chat
HideB.HideChat = function(frame)
    GeneralDockManager:Hide()
    if C.chat.background == true then
        ChatBackground:Hide()
        ChatTabsPanel:Hide()
    else
        LeftPanel:Hide()
    end
    if C.chat.chat_bar == true then
        ChatBar:Hide()
    end

    for i = 1, NUM_CHAT_WINDOWS do
        local f = _G["ChatFrame"..i]
        if f then
            f.Show = T.dummy
            if f.minimized then
                local fm =_G["ChatFrame"..i.."Minimized"]
                if fm then
                    fm:Hide()
                end
                frame.ActiveTabs[i] = false
            elseif f:IsVisible() then
                frame.ActiveTabs[i] = true
                f:Hide()
            else
                frame.ActiveTabs[i] = false
            end
        end
    end

    for i = 1, NUM_CHAT_WINDOWS do
        local f = _G["ChatFrame"..i.."Tab"]
        if f then
            if frame.ActiveTabs[i] == true and f:IsVisible() then
                f:Hide()
            end
        end
    end
    frame.ChatIsShown = false
end

-- Show Chat
HideB.ShowChat = function(frame)
    GeneralDockManager:Show()
    if C.chat.background == true then
        ChatBackground:Show()
        ChatTabsPanel:Show()
    else
        LeftPanel:Show()
    end
    if C.chat.chat_bar == true then
        ChatBar:Show()
    end 
    
    for i = 1, NUM_CHAT_WINDOWS do
        local f = _G["ChatFrame"..i]
        if f then
            f.Show = nil
            if f.minimized then
                local fm =_G["ChatFrame"..i.."Minimized"]
                if fm then
                    fm:Show()
                end
            elseif frame.ActiveTabs[i] == true then
                f:Show()
            end  
        end
    end
    
    for i = 1, NUM_CHAT_WINDOWS do  
        local f = _G["ChatFrame"..i.."Tab"]
        if f then
            if frame.ActiveTabs[i] == true then
                f:Show()
            end
        end
    end
    frame.ChatIsShown = true
end

HideB.ChatT = function(frame)
    if HideB.ChatIsShown == true then
        HideB:HideChat()
    else
        HideB:ShowChat()
    end
end

-- Hide Minimap
HideB.HideMinimap = function(frame)
    if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
    MinimapAnchor.Show = T.dummy
    MinimapAnchor:Hide()
    frame.MinimapIsShown = false
end

-- Show Minimap
HideB.ShowMinimap = function(frame)
    if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
    MinimapAnchor.Show = nil
    MinimapAnchor:Show()
    frame.MinimapIsShown = true
end

HideB.MapT = function(frame)
    if HideB.MinimapIsShown == true then
        HideB:HideMinimap()
    else
        HideB:ShowMinimap()
    end
end

-- Clicker
HideB:SetScript("OnMouseUp", function(frame, button)
    if button == "LeftButton" then
        HideB:ChatT()
    elseif button == "RightButton" then
        HideB:MapT()
    elseif button == "MiddleButton" then
        HideB:ChatT()
        HideB:MapT()
    end
end)