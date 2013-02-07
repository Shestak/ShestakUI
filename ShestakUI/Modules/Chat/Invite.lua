local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Invite player(by Zork)
----------------------------------------------------------------------------------------
local origSetItemRef = SetItemRef
SetItemRef = function(link, text, ...)
	local linkType = string.sub(link, 1, 6)
	if IsAltKeyDown() and linkType == "player" then
		local name = string.match(link, "player:([^:]+)")
		InviteUnit(name)
		return nil
	end
	return origSetItemRef(link, text, ...)
end