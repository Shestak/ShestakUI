local T, C, L, _ = unpack(select(2, ...))
if C.automation.open_items ~= true then return end

----------------------------------------------------------------------------------------
--	Auto opening of items in bag (kAutoOpen by Kellett)
----------------------------------------------------------------------------------------
local frame, atBank, atMail, atMerchant = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

function frame:Register(event, func)
	self:RegisterEvent(event)
	self[event] = function(...)
		func(...)
	end
end

frame:Register("BANKFRAME_OPENED", function()
	atBank = true
end)

frame:Register("BANKFRAME_CLOSED", function()
	atBank = false
end)

frame:Register("GUILDBANKFRAME_OPENED", function()
	atBank = true
end)

frame:Register("GUILDBANKFRAME_CLOSED", function()
	atBank = false
end)

frame:Register("MAIL_SHOW", function()
	atMail = true
end)

frame:Register("MAIL_CLOSED", function()
	atMail = false
end)

frame:Register("MERCHANT_SHOW", function()
	atMerchant = true
end)

frame:Register("MERCHANT_CLOSED", function()
	atMerchant = false
end)

frame:Register("BAG_UPDATE_DELAYED", function()
	if atBank or atMail or atMerchant then return end
	for bag = 0, 4 do
		for slot = 0, GetContainerNumSlots(bag) do
			local _, _, locked, _, _, lootable, _, _, _, id = GetContainerItemInfo(bag, slot)
			if lootable and not locked and id and T.OpenItems[id] then
				print("|cffff0000"..OPENING..": "..GetContainerItemLink(bag, slot).."|cffff0000.|r")
				UseContainerItem(bag, slot)
				return
			end
		end
	end
end)