local T, C, L = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.chat_bar ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBar(FavChatBar by Favorit)
----------------------------------------------------------------------------------------
local cbar = CreateFrame("Frame", "ChatBar", UIParent)
cbar:CreatePanel("Invisible", 16, C.chat.background and C.chat.height + 5 or C.chat.height + 1, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, C.chat.background and 24 or 20)

function cbar:SW(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/w ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/s ", SELECTED_DOCK_FRAME)
	end
end

function cbar:GO(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/o ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/g ", SELECTED_DOCK_FRAME)
	end
end

function cbar:RP(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/raid ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/p ", SELECTED_DOCK_FRAME)
	end
end

function cbar:GT(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/2 ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/1 ", SELECTED_DOCK_FRAME)
	end
end

function cbar:LG(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/4 ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/3 ", SELECTED_DOCK_FRAME)
	end
end

function cbar:YR(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/y ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/rw ", SELECTED_DOCK_FRAME)
	end
end

local function CreateButton(f, c)
	f:Width(16)
	f:Height(16)
	f:SetTemplate()
	f:RegisterForClicks("AnyUp")
	f:SetScript("OnClick", c)

	f.t = f:CreateTexture(nil, "ARTWORK")
	f.t:SetTexture(C.media.blank)
	f.t:Point("TOPLEFT", f, "TOPLEFT", 2, -2)
	f.t:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
end

local sw = CreateFrame("Button", "sw", ChatBar)
CreateButton(sw, cbar.SW)
sw:Point("TOP", ChatBar, "TOP", 0, 0)
sw:SetBackdropBorderColor(0.7, 0.33, 0.82, 1)
sw.t:SetVertexColor(0.8, 0.8, 0.8, 1)

local go = CreateFrame("Button", "go", ChatBar)
CreateButton(go, cbar.GO)
go:Point("TOP", sw, "BOTTOM", 0, C.chat.background and -4 or -3)
go:SetBackdropBorderColor(0, 0.54, 0, 1)
go.t:SetVertexColor(0, 0.8, 0, 1)

local rp = CreateFrame("Button", "rp", ChatBar)
CreateButton(rp, cbar.RP)
rp:Point("TOP", go, "BOTTOM", 0, C.chat.background and -4 or -3)
rp:SetBackdropBorderColor(0.8, 0.4, 0.1, 1)
rp.t:SetVertexColor(0.11, 0.5, 0.7, 1)

local gt = CreateFrame("Button", "gt", ChatBar)
CreateButton(gt, cbar.GT)
gt:Point("TOP", rp, "BOTTOM", 0, C.chat.background and -4 or -3)
gt:SetBackdropBorderColor(0.7, 0.7, 0, 1)
gt.t:SetVertexColor(0.93, 0.8, 0.8, 1)

local lg = CreateFrame("Button", "lg", ChatBar)
CreateButton(lg, cbar.LG)
lg:Point("TOP", gt, "BOTTOM", 0, C.chat.background and -4 or -3)
lg:SetBackdropBorderColor(0.5, 1, 0.83, 1)
lg.t:SetVertexColor(1, 0.75, 0.75, 1)

local yr = CreateFrame("Button", "yr", ChatBar)
CreateButton(yr, cbar.YR)
yr:Point("TOP", lg, "BOTTOM", 0, C.chat.background and -4 or -3)
yr:SetBackdropBorderColor(0.96, 0.2, 0.2, 1)
yr.t:SetVertexColor(1, 0.3, 0, 1)