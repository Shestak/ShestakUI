local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
function T.NewYearCheck()
	local month = tonumber(date("%m"))
	local day = tonumber(date("%d"))
	if month == 1 and day == 1 then
		return true
	else
		return false
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if T.NewYearCheck() == true then
		T.Delay(15, print, "|cffffff00Happy New Year. From Shestak.|r")
		T.Delay(16, T.InfoTextShow, "Happy New Year. From Shestak.")
	end
	self:UnregisterAllEvents()
end)