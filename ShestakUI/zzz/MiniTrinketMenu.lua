local T, C, L, _ = unpack(select(2, ...))
if  C.zzz.MiniTrinketMenu ~= true then return end

--[[
	This mod simply pops out a menu of trinkets when you mouseover a macro
	that contains "#show 13" or "#show 14".  Selecting a trinket in the
	menu will equip it to that slot.
	
	For more features look for its big brother TrinketMenu or its bigger
	brother ItemRack.  Those handle automated swaps, combat queues, etc.

	Step 1: If you don't have one already, make a macro like this:

			#showtooltip 13
			#show 13
			/use 13

	Step 2: Make sure you choose the Red Question Mark macro icon
	Step 3: Put the macro anywhere on an action bar.
	Step 4: Hover the mouse over that macro and you should see all
			trinkets in your bags.
	Step 5: Click a trinket in the menu to equip it.

	1.13, 3/4/09 - testing method for displaying/hiding menu without an OnUpdate (Gametooltip hide/show)
	1.12, 8/30/08 - fix for nil error on some bars, faster menu popout
	1.11, 8/21/08 - button number checked (.+)(%d+) to (.-)(%d+)
	1.1, 8/20/08 - /mtm will close any open menu, loosened check for vertical, tooltip
	1.0, 8/19/08 - initial release
]]

local f = CreateFrame("Frame","MiniTrinketMenu")
f.version = "1.11"
f.frequency = .25
f.timer = 0

function f:OnUpdate(elapsed)
	f.timer = f.timer + elapsed
	if f.timer > f.frequency then
		f.timer = 0
		local focus = GetMouseFocus()
		if focus and focus:GetAttribute("type")=="action" then
			local actionId = focus:GetAttribute("action")
			if focus.action or actionId then
				actionId = focus.action and focus.action or actionId
				local actionType,actionInfo = GetActionInfo(actionId)
				if actionType=="macro" then
					local slot = tonumber(string.match(select(3,GetMacroInfo(actionInfo)) or "","%#show (%d+)"))
					if slot==13 or slot==14 then
						if slot~=f.MenuOpen then
							f.MenuOpen = slot
							f:BuildMenu(focus)
						end
						return
					end
				end
			end
		end
		if MiniTrinketMenuButton1 and MiniTrinketMenuButton1:IsVisible() and (not focus or (focus and not focus.TrinketID)) then
			f:CloseMenu()
		end
	end
end
-- f:SetScript("OnUpdate",f.OnUpdate)

GameTooltip:HookScript("OnShow",function() f:OnUpdate(1) end)
GameTooltip:HookScript("OnHide",function() f:OnUpdate(1) end)

function f:Toggle()
	if f:IsVisible() then
		f:Hide()
	else
		f:Show()
	end
	ChatFrame1:AddMessage("MiniTrinketMenu "..f.version.." is now "..(f:IsVisible() and "|cFF00FF00ON" or "|cFFFF0000OFF"))
end
SLASH_MiniTrinketMenu1 = "/minitrinketmenu"
SLASH_MiniTrinketMenu2 = "/mtm"
SlashCmdList["MiniTrinketMenu"] = f.Toggle

function f:GetMenuDocking(button)
	local buttonName = button:GetName()
	if not buttonName then
		return
	end
	local orient = "HORIZONTAL"
	local buttonStub,buttonNumber = string.match(buttonName,"(.-)(%d+)")
	buttonNumber = tonumber(buttonNumber)
	if buttonNumber then
		local function near(v1,v2)
			if v1 and v2 then return math.abs(v2-v1)<16 end
		end
		local candidate1 = getglobal(buttonStub..(buttonNumber-1))
		local candidate2 = getglobal(buttonStub..(buttonNumber+1))
		if (candidate1 and near(candidate1:GetLeft(),button:GetLeft())) or
			(candidate2 and near(candidate2:GetLeft(),button:GetLeft())) then
			orient = "VERTICAL"
		end
	end

	local buttonTop,buttonLeft = button:GetTop(),button:GetLeft()
	local midHeight,midWidth = UIParent:GetHeight()/2,UIParent:GetWidth()/2

	if buttonTop>midHeight and orient=="HORIZONTAL" then -- on a horizontal bar in top half of screen
		if buttonLeft<midWidth then
			return "TOPLEFT", "BOTTOMLEFT", 36,0, 0,-36
		else
			return "TOPRIGHT", "BOTTOMRIGHT", -36,0, 0,-36
		end
	elseif buttonLeft<=midWidth and orient=="VERTICAL" then -- on a vertical bar in left half of screen
		if buttonTop>midHeight then
			return "TOPLEFT", "TOPRIGHT", 0,-40, 40,0
		else
			return "BOTTOMLEFT", "BOTTOMRIGHT", 0,40, 40,0
		end
	elseif buttonLeft>midWidth and orient=="VERTICAL" then -- on a vertical bar in right half of screen
		if buttonTop>midHeight then
			return "TOPRIGHT", "TOPLEFT", 0,-36, -36,0
		else
			return "BOTTOMRIGHT", "BOTTOMLEFT", 0,36, -36,0
		end
	else -- all other conditions, assume button is on a horizontal bar in bottom half of screen
		if buttonLeft>midWidth then
			return "BOTTOMRIGHT", "TOPRIGHT", -36,0, 0,36
		else
			return "BOTTOMLEFT", "TOPLEFT", 36,0, 0,36
		end
	end
end

function f:OnTooltip(button,item)
	GameTooltip:SetOwner(button,"ANCHOR_LEFT")
	local name,_,quality = GetItemInfo(item)
	if name and quality then
		GameTooltip:SetText(select(4,GetItemQualityColor(quality))..name)
		GameTooltip:Show()
	end
end

function f:CreateButton(idx,itemID)
	local buttonName = "MiniTrinketMenuButton"..idx
	local button = getglobal(buttonName)
	if not button then
		button = getglobal(buttonName) or CreateFrame("Button",buttonName,UIParent,"ActionButtonTemplate")
		button:SetScale(.85)
		button:SetFrameStrata("DIALOG")
		button:SetScript("OnClick",function() EquipItemByName(button.TrinketID,f.MenuOpen) f:CloseMenu() end)
		button:SetScript("OnEnter",function() f:OnTooltip(button,button.TrinketID) end)
		button:SetScript("OnLeave",function() GameTooltip:Hide() end)
	end
	getglobal(buttonName.."Icon"):SetTexture(select(10,GetItemInfo(itemID)))
	button.TrinketID = itemID
	button:ClearAllPoints()
	return button
end

function f:NumberOfTrinketsInBags()
	local count,item = 0
	for i=0,4 do
		for j=1,GetContainerNumSlots(i) do
			item = GetContainerItemLink(i,j)
			if item and select(9,GetItemInfo(item))=="INVTYPE_TRINKET" then
				count = count + 1
			end
		end
	end
	return count
end

function f:BuildMenu(button)
	local relativeFrom,relativeTo,addx,addy,addxwrap,addywrap = f:GetMenuDocking(button)
	local xstart,ystart = 0,0 -- these values change only when a row wraps
	local xpos,ypos = xstart,ystart -- these values change for every new button
	local menuButton
	local wrapat = 1
	local wraplimit = 1
	local numTrinkets = f:NumberOfTrinketsInBags()
	if numTrinkets > 18 then
		wraplimit = 4
	elseif numTrinkets > 9 then
		wraplimit = 3
	elseif numTrinkets > 4 then
		wraplimit = 2
	end

	local trinketIdx,item = 1
	for i=0,4 do
		for j=1,GetContainerNumSlots(i) do
			item = GetContainerItemLink(i,j)
			if item and select(9,GetItemInfo(item))=="INVTYPE_TRINKET" then
				menuButton = f:CreateButton(trinketIdx,item)
				menuButton:SetPoint(relativeFrom,button,relativeTo,xpos,ypos)
				menuButton:Show()
				xpos=xpos+addx
				ypos=ypos+addy
				wrapat = wrapat + 1
				if wrapat>wraplimit then
					xstart=xstart+addxwrap
					ystart=ystart+addywrap
					xpos = xstart
					ypos = ystart
					wrapat = 1
				end
				trinketIdx = trinketIdx + 1
			end
		end
	end
end

function f:CloseMenu()
	local idx = 1
	while getglobal("MiniTrinketMenuButton"..idx) do
		getglobal("MiniTrinketMenuButton"..idx):Hide()
		idx = idx + 1
	end
	f.MenuOpen = nil
end
