local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------

-- To move the Extra Action Button 1
local function ShowButton()
       ExtraActionBarFrame:Show()
       ExtraActionBarFrame:SetAlpha(1)
       ExtraActionButton1:Show()
       ExtraActionButton1:SetAlpha(1)
       ExtraActionButton1.icon:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")
       ExtraActionButton1.icon:Show()
       ExtraActionButton1.icon:SetAlpha(1)
end

SLASH_EXTRABUTTON1 = "/eb"
SlashCmdList["EXTRABUTTON"] = function(msg)
       if msg == "hide" then
               ExtraActionBarFrame:Hide()
       else
               ShowButton()
       end
end

-- edit by Oz of shestak. org --
