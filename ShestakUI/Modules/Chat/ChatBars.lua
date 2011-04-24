local T, C, L = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.chat_bar ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBar(FavChatBar by Favorit)
----------------------------------------------------------------------------------------
local cbar = CreateFrame("Frame", "favchat", favchat)
cbar:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
cbar:RegisterEvent("ADDON_LOADED")

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

function cbar:YG(button)
	if button == "RightButton" then
		ChatFrame_OpenChat("/y ", SELECTED_DOCK_FRAME)
	else
		ChatFrame_OpenChat("/3 ", SELECTED_DOCK_FRAME)
	end
end

function cbar:Style()
	favchat:ClearAllPoints()
	favchat:SetParent(UIParent)

	sw = CreateFrame("Button", "sw", favchat)
	sw:ClearAllPoints()
	sw:SetParent(favchat)
	sw:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, C.chat.background and C.chat.height + 13 or C.chat.height + 5)
	sw:Width(16)
	sw:Height(16)
	sw:SetTemplate()
	sw:SetBackdropBorderColor(0.7, 0.33, 0.82, 1)
	sw:RegisterForClicks("AnyUp")
	sw:SetScript("OnClick", cbar.SW)
	swtex = sw:CreateTexture(nil, "ARTWORK")
	swtex:SetTexture(C.media.blank)
	swtex:SetVertexColor(0.8, 0.8, 0.8, 1)
	swtex:Point("TOPLEFT", sw, "TOPLEFT", 2, -2)
	swtex:Point("BOTTOMRIGHT", sw, "BOTTOMRIGHT", -2, 2)
	
	go = CreateFrame("Button", "go", favchat)
	go:ClearAllPoints()
	go:SetParent(favchat)
	go:Point("TOP", sw, "BOTTOM", 0, C.chat.background and -9 or -8)
	go:Width(16)
	go:Height(16)
	go:SetTemplate()
	go:SetBackdropBorderColor(0, 0.54, 0, 1)
	go:RegisterForClicks("AnyUp")
	go:SetScript("OnClick", cbar.GO)
	gotex = sw:CreateTexture(nil, "ARTWORK")
	gotex:SetTexture(C.media.blank)
	gotex:SetVertexColor(0, 0.8, 0, 1)
	gotex:Point("TOPLEFT", go, "TOPLEFT", 2, -2)
	gotex:Point("BOTTOMRIGHT", go, "BOTTOMRIGHT", -2, 2)
	
	rp = CreateFrame("Button", "rp", favchat)
	rp:ClearAllPoints()
	rp:SetParent(favchat)
	rp:Point("TOP", go, "BOTTOM", 0, C.chat.background and -9 or -8)
	rp:Width(16)
	rp:Height(16)
	rp:SetTemplate()
	rp:SetBackdropBorderColor(0.8, 0.4, 0.1, 1)
	rp:RegisterForClicks("AnyUp")
	rp:SetScript("OnClick", cbar.RP)
	rptex = rp:CreateTexture(nil, "ARTWORK")
	rptex:SetTexture(C.media.blank)
	rptex:SetVertexColor(0.11, 0.5, 0.7, 1)
	rptex:Point("TOPLEFT", rp, "TOPLEFT", 2, -2)
	rptex:Point("BOTTOMRIGHT", rp, "BOTTOMRIGHT", -2, 2)

	gt = CreateFrame("Button", "gt", favchat)
	gt:ClearAllPoints()
	gt:SetParent(favchat)
	gt:Point("TOP", rp, "BOTTOM", 0, C.chat.background and -9 or -8)
	gt:Width(16)
	gt:Height(16)
	gt:SetTemplate()
	gt:SetBackdropBorderColor(0.7, 0.7, 0, 1)
	gt:RegisterForClicks("AnyUp")
	gt:SetScript("OnClick", cbar.GT)
	gttex = rp:CreateTexture(nil, "ARTWORK")
	gttex:SetTexture(C.media.blank)
	gttex:SetVertexColor(0.93, 0.8, 0.8, 1)
	gttex:Point("TOPLEFT", gt, "TOPLEFT", 2, -2)
	gttex:Point("BOTTOMRIGHT", gt, "BOTTOMRIGHT", -2, 2)

	yg = CreateFrame("Button", "yg", favchat)
	yg:ClearAllPoints()
	yg:SetParent(favchat)
	yg:Point("TOP", gt, "BOTTOM", 0, C.chat.background and -9 or -8)
	yg:Width(16)
	yg:Height(16)
	yg:SetTemplate()
	yg:SetBackdropBorderColor(0.7, 0.13, 0.13, 1)
	yg:RegisterForClicks("AnyUp")
	yg:SetScript("OnClick", cbar.YG)
	ygtex = rp:CreateTexture(nil, "ARTWORK")
	ygtex:SetTexture(C.media.blank)
	ygtex:SetVertexColor(0.5, 1, 0.83, 1)
	ygtex:Point("TOPLEFT", yg, "TOPLEFT", 2, -2)
	ygtex:Point("BOTTOMRIGHT", yg, "BOTTOMRIGHT", -2, 2)
end

function cbar:ADDON_LOADED(event, name)
	self:Style()
end