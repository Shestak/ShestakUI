local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
--[[
L.Faq_CONTENT_TEXT_FIELD_9_1
L.Faq_CONTENT_TEXT_TITLE_9 = "|cff00AAFFWall of Glory|r"
:RegisterEvent("RAID_ROSTER_UPDATE") -- assistant changes
/script BlackMarket_LoadUI() ShowUIPanel(BlackMarketFrame)
/script LoadAddOn("Blizzard_ItemUpgradeUI") ShowUIPanel(ItemUpgradeFrame)
function T.SkinScrollBar(f)
	local frame = f:GetName()

	if _G[frame.."Track"] then _G[frame.."Track"]:Hide() end
	if _G[frame.."BG"] then _G[frame.."BG"]:Hide() end
	if _G[frame.."Top"] then _G[frame.."Top"]:Hide() end
	if _G[frame.."Middle"] then _G[frame.."Middle"]:Hide() end
	if _G[frame.."Bottom"] then _G[frame.."Bottom"]:Hide() end

	local bu = _G[frame.."ThumbTexture"]
	local up = _G[frame.."ScrollUpButton"]
	local down = _G[frame.."ScrollDownButton"]

	bu:SetAlpha(0)
	bu:SetWidth(17)
	bu:SetHeight(22)

	bu.bg = CreateFrame("Frame", nil, f)
	bu.bg:SetTemplate("Overlay")
	bu.bg:SetPoint("TOPLEFT", bu, 0, -3)
	bu.bg:SetPoint("BOTTOMRIGHT", bu, 0, 3)

	up:SetWidth(17)
	up:SkinButton()
	up:SetDisabledTexture(C.media.blank)

	down:SetWidth(17)
	down:SkinButton()
	down:SetDisabledTexture(C.media.blank)

	local dis1 = up:GetDisabledTexture()
	dis1:SetVertexColor(0.6, 0.6, 0.6, 0.4)
	dis1:SetDrawLayer("OVERLAY")
	dis1:SetPoint("TOPLEFT", up, 2, -2)
	dis1:SetPoint("BOTTOMRIGHT", up, -2, 2)

	local dis2 = down:GetDisabledTexture()
	dis2:SetVertexColor(0.6, 0.6, 0.6, 0.4)
	dis2:SetDrawLayer("OVERLAY")
	dis2:SetPoint("TOPLEFT", down, 2, -2)
	dis2:SetPoint("BOTTOMRIGHT", down, -2, 2)
end]]