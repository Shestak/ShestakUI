local T, C, L = unpack(ShestakUI)
if C.extra_general.poison ~= true or T.class ~= "ROGUE" then return end

----------------------------------------------------------------------------------------
--	One-click poison enchant(oApplication by Haste)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Button", "OCPoison", UIParent, "SecureActionButtonTemplate AutoCastShineTemplate")
local macro = "/stopcasting\n/use %s\n/use [button:1] 16; [button:2] 17; [button:3] 18;"
local tip = GameTooltip
local orig = tip:GetScript("OnTooltipSetItem")

for _, v in ipairs(frame.sparkles) do
	v:SetWidth(v:GetWidth() * 3)
	v:SetHeight(v:GetHeight() * 3)
end

local GetID = function(item)
	if type(item) == "number" then
		return item
	elseif type(item) == "string" then
		local _, _, id = string.find(item, "item:(%d+):%d+:%d+:%d+")
		if id then return
			tonumber(id)
		end
	end
end

local S = function() return not TradeFrame:IsShown() and not BankFrame:IsShown() and not MerchantFrame:IsShown() and not MailFrame:IsShown() and not InCombatLockdown() and IsAltKeyDown() end
local E = "20844 43230 43234 8984 8985 22053 22055 43231 43235 3775 6949 6950 10920 10921 10922 2892 43232 10918 2893 5237 8926 8927 22054 21927 8928 43233 6947 34861 6530 7307 6529 6532 6533"

local OnShow = function(self, ...)
	if self and orig then orig(self, ...) end
	local name, id = self:GetItem()

	if name and id then
		id = GetID(id)
		if id and E:match(id.."%s") and S() then
			frame:ClearAllPoints()
			frame:SetAttribute("macrotext", macro:format(name))
			frame:SetAllPoints(GetMouseFocus())
			AutoCastShine_AutoCastStart(frame, 0, 1, 0)
			frame:Show()
		end
	end
end

frame:SetFrameStrata("TOOLTIP")
frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
frame:SetScript("OnLeave", function(self) self:Hide() end)
frame:SetAttribute("*type*", "macro")
frame:SetScript("OnEvent", function(self, event, key, state)
	if event == "MODIFIER_STATE_CHANGED" then
		if key == "LALT" or key == "RALT" then
			if not InCombatLockdown() and self:IsShown() then
				self:ClearAllPoints()
				self:Hide()
				AutoCastShine_AutoCastStop(frame)
			end
		end
	else
		self:ClearAllPoints()
		self:Hide()
		AutoCastShine_AutoCastStop(frame)
	end
end)
frame:RegisterEvent("MODIFIER_STATE_CHANGED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")

tip:SetScript("OnTooltipSetItem", OnShow)