local T, C, L, _ = unpack(select(2, ...))
if C.loot.auto_confirm_de ~= true then return end

----------------------------------------------------------------------------------------
--	Disenchant confirmation(tekKrush by Tekkub)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
frame:RegisterEvent("CONFIRM_LOOT_ROLL")
frame:RegisterEvent("LOOT_BIND_CONFIRM")
frame:SetScript("OnEvent", function(self, event, id)
	if GetNumGroupMembers() == 0 then
		local elapsed = 0
		self:SetScript("OnUpdate", function(self, elap)
			elapsed = elapsed + elap
			if elapsed < 0.2 then
				StaticPopup_Hide("LOOT_BIND")
				return
			end
			elapsed = 0
			ConfirmLootSlot(id)
			self:SetScript("OnUpdate", nil)
		end)
	else
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local frame = _G["StaticPopup"..i]
			if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
		end
	end
end)