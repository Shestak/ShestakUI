local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Multi ItemRefTooltip
----------------------------------------------------------------------------------------
local tips = {[1] = _G["ItemRefTooltip"]}
local types = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true, instancelock = true, currency = true}

local CreateTip = function(link)
	for k, v in ipairs(tips) do
		for i, tip in ipairs(tips) do
			if tip:IsShown() and tip.link == link then
				tip.link = nil
				HideUIPanel(tip)
				return
			end
		end
		if not v:IsShown() then
			v.link = link
			return v
		end
	end

	local num = #tips + 1
	local tip = CreateFrame("GameTooltip", "ItemRefTooltip"..num, UIParent, "GameTooltipTemplate")
	tip:SetTemplate("Transparent")
	tip:SetPoint("BOTTOM", 0, 80)
	tip:SetSize(128, 64)
	tip:EnableMouse(true)
	tip:SetMovable(true)
	tip:SetClampedToScreen(true)
	tip:RegisterForDrag("LeftButton")
	tip:SetScript("OnDragStart", function(self) self:StartMoving() end)
	tip:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	tip:HookScript("OnShow", function(self)
		self:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
		self:SetBackdropBorderColor(unpack(C.media.border_color))
	end)

	local close = CreateFrame("Button", "ItemRefTooltip"..num.."CloseButton", tip)
	close:SetScript("OnClick", function(self) HideUIPanel(tip) end)
	T.SkinCloseButton(close)

	table.insert(UISpecialFrames, tip:GetName())

	tip.link = link
	tips[num] = tip

	return tip
end

local ShowTip = function(tip, link)
	ShowUIPanel(tip)
	if not tip:IsShown() then
		tip:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	tip:SetHyperlink(link)
end

local _SetItemRef = SetItemRef
function SetItemRef(...)
	local link = ...
	local handled = strsplit(":", link)
	if not IsModifiedClick() and handled and types[handled] then
		local tip = CreateTip(link)
		if tip then
			ShowTip(tip, link)
		end
	else
		return _SetItemRef(...)
	end
end