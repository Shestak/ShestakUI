---------------------------
-- Class Icons Portraits --
---------------------------

local parent, ns = ...
local oUF = ns.oUF

if not oUF then return end

local Update = function(self, event)
	local _, class = UnitClass(self.unit)
	local icon = self.ClassIcon

	if class then
		local left, right, top, bottom = unpack(CLASS_BUTTONS[class])

		left = left + (right - left) * 0.09
		right = right - (right - left) * 0.09
		top = top + (bottom - top) * 0.09
		bottom = bottom - (bottom - top) * 0.09

		icon:SetTexCoord(left, right, top, bottom)
		icon:Show()
	else
		icon:Hide()
	end
end

local Enable = function(self)
	local cicon = self.ClassIcon

	if cicon then
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", Update)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Update)

		cicon:SetTexture[[Interface\WorldStateFrame\Icons-Classes]]

		return true
	end
end

local Disable = function(self)
	local ricon = self.ClassIcon

	if ricon then
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED", Update)
		self:UnregisterEvent("PLAYER_TARGET_CHANGED", Update)
	end
end

oUF:AddElement("ClassIcon", Update, Enable, Disable)

-- Edit by Oz of shestakdotorg --
