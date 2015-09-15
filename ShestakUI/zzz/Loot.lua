--拾取自動確認
local T, C, L, _ = unpack(select(2, ...))
if  C.zzz.Loot ~= true then return end

local aotuClick = CreateFrame("Frame")
   aotuClick:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
   aotuClick:RegisterEvent("CONFIRM_LOOT_ROLL")
   aotuClick:RegisterEvent("LOOT_BIND_CONFIRM")      
   aotuClick:SetScript("OnEvent", function(self, event, ...)
      for i = 1, STATICPOPUP_NUMDIALOGS do
        local frame = _G["StaticPopup"..i]
        if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") and frame:IsVisible() then 
        StaticPopup_OnClick(frame, 1) 
        end
      end
   end)