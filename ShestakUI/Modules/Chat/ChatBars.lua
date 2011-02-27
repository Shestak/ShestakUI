if SettingsCF.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBar(FavChatBar by Favorit)
----------------------------------------------------------------------------------------
if SettingsCF.chat.chat_bar == true then
	local cbar = CreateFrame("Frame", "favchat", favchat)
	cbar:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
	cbar:RegisterEvent("ADDON_LOADED")

	function cbar:SW(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/w ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/s ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:GO(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/o ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/g ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:RP(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/raid ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/p ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:GT(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/2 ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/1 ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:YG(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/y ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/3 ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:Style()
		favchat:ClearAllPoints()
		favchat:SetParent(UIParent)

		sw = CreateFrame("Button", "sw", favchat)
		sw:ClearAllPoints()
		sw:SetParent(favchat)
		sw:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, SettingsCF.chat.background and SettingsCF.chat.height + 12 or SettingsCF.chat.height + 4)
		sw:SetWidth(SettingsDB.Scale(14))
		sw:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(sw)
		sw:SetBackdropBorderColor(0.7, 0.33, 0.82, 1)
		sw:RegisterForClicks("AnyUp")
		sw:SetScript("OnClick", cbar.SW)
		swtex = sw:CreateTexture(nil, "ARTWORK")
		swtex:SetTexture(SettingsCF.media.blank)
		swtex:SetVertexColor(0.8, 0.8, 0.8, 1)
		swtex:SetPoint("TOPLEFT", sw, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		swtex:SetPoint("BOTTOMRIGHT", sw, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		
		go = CreateFrame("Button", "go", favchat)
		go:ClearAllPoints()
		go:SetParent(favchat)
		go:SetPoint("TOP", sw, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		go:SetWidth(SettingsDB.Scale(14))
		go:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(go)
		go:SetBackdropBorderColor(0, 0.54, 0, 1)
		go:RegisterForClicks("AnyUp")
		go:SetScript("OnClick", cbar.GO)
		gotex = sw:CreateTexture(nil, "ARTWORK")
		gotex:SetTexture(SettingsCF.media.blank)
		gotex:SetVertexColor(0, 0.8, 0, 1)
		gotex:SetPoint("TOPLEFT", go, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		gotex:SetPoint("BOTTOMRIGHT", go, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		
		rp = CreateFrame("Button", "rp", favchat)
		rp:ClearAllPoints()
		rp:SetParent(favchat)
		rp:SetPoint("TOP", go, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		rp:SetWidth(SettingsDB.Scale(14))
		rp:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(rp)
		rp:SetBackdropBorderColor(0.8, 0.4, 0.1, 1)
		rp:RegisterForClicks("AnyUp")
		rp:SetScript("OnClick", cbar.RP)
		rptex = rp:CreateTexture(nil, "ARTWORK")
		rptex:SetTexture(SettingsCF.media.blank)
		rptex:SetVertexColor(0.11, 0.5, 0.7, 1)
		rptex:SetPoint("TOPLEFT", rp, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		rptex:SetPoint("BOTTOMRIGHT", rp, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))

		gt = CreateFrame("Button", "gt", favchat)
		gt:ClearAllPoints()
		gt:SetParent(favchat)
		gt:SetPoint("TOP", rp, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		gt:SetWidth(SettingsDB.Scale(14))
		gt:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(gt)
		gt:SetBackdropBorderColor(0.7, 0.7, 0, 1)
		gt:RegisterForClicks("AnyUp")
		gt:SetScript("OnClick", cbar.GT)
		gttex = rp:CreateTexture(nil, "ARTWORK")
		gttex:SetTexture(SettingsCF.media.blank)
		gttex:SetVertexColor(0.93, 0.8, 0.8, 1)
		gttex:SetPoint("TOPLEFT", gt, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		gttex:SetPoint("BOTTOMRIGHT", gt, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))

		yg = CreateFrame("Button", "yg", favchat)
		yg:ClearAllPoints()
		yg:SetParent(favchat)
		yg:SetPoint("TOP", gt, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		yg:SetWidth(SettingsDB.Scale(14))
		yg:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(yg)
		yg:SetBackdropBorderColor(0.7, 0.13, 0.13, 1)
		yg:RegisterForClicks("AnyUp")
		yg:SetScript("OnClick", cbar.YG)
		ygtex = rp:CreateTexture(nil, "ARTWORK")
		ygtex:SetTexture(SettingsCF.media.blank)
		ygtex:SetVertexColor(0.5, 1, 0.83, 1)
		ygtex:SetPoint("TOPLEFT", yg, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		ygtex:SetPoint("BOTTOMRIGHT", yg, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end

	function cbar:ADDON_LOADED(event, name)
		self:Style()
	end
end