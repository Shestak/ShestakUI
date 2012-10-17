local addon, ns = ...
local cargBags = ns.cargBags
local T, C = unpack(ShestakUI)
local L = cBnivL

------------------------------------------
-- MyContainer specific
------------------------------------------
local cbNivaya = cargBags:GetImplementation("Nivaya")
local MyContainer = cbNivaya:GetContainerClass()

local GetNumFreeSlots = function(bagType)
    local free, max = 0, 0
    if bagType == "bag" then
        for i = 0,4 do
            free = free + GetContainerNumFreeSlots(i)
            max = max + GetContainerNumSlots(i)
        end
    else
        local containerIDs = {-1,5,6,7,8,9,10,11}
        for _,i in next, containerIDs do    
            free = free + GetContainerNumFreeSlots(i)
            max = max + GetContainerNumSlots(i)
        end
    end
    return free, max
end

local QuickSort;
do
    local func = function(v1, v2)
        if (v1 == nil) or (v2 == nil) then return (v1 and true or false) end
        if v1[1] == -1 or v2[1] == -1 then
            return v1[1] > v2[1] -- empty slots last
        elseif v1[2] ~= v2[2] then
            return v1[2] > v2[2] -- higher quality first
        elseif v1[1] ~= v2[1] then
            return v1[1] > v2[1] -- group identical item ids
        else
            return v1[4] > v2[4] -- full/larger stacks first
        end
    end;
    QuickSort = function(tbl) table.sort(tbl, func) end
end

function MyContainer:OnContentsChanged()

	local col, row = 0, 0
    local yPosOffs = self.Caption and 20 or 0
    local isEmpty = true

    local tName = self.name
    local tBankBags = string.find(tName, "cBniv_Bank%a+")
    local tBank = tBankBags or (tName == "cBniv_Bank")

    local buttonIDs = {}
  	for i, button in pairs(self.buttons) do
        local item = cbNivaya:GetItemInfo(button.bagID, button.slotID)
        if item.link then
            local _,_,tQ = GetItemInfo(item.link)
            local _,cnt = GetContainerItemInfo(button.bagID, button.slotID)
            buttonIDs[i] = { item.id, tQ, button, cnt }
        else
            buttonIDs[i] = { -1, -2, button, -1 }
        end
    end
    if (tBank and cBnivCfg.SortBank) or (not tBank and cBnivCfg.SortBags) then QuickSort(buttonIDs) end

	for _, v in ipairs(buttonIDs) do
        local button = v[3]
		button:ClearAllPoints()
      
        local xPos = col * (C.bag.button_size + C.bag.button_space)
        local yPos = (-1 * row * (C.bag.button_size + C.bag.button_space)) - yPosOffs

        button:SetPoint("TOPLEFT", self, "TOPLEFT", xPos, yPos)
        if(col >= self.Columns-1) then
            col = 0
            row = row + 1
        else
            col = col + 1
        end
        isEmpty = false
    end

    if cBnivCfg.CompressEmpty then
        local xPos = col * (C.bag.button_size + C.bag.button_space)
        local yPos = (-1 * row * (C.bag.button_size + C.bag.button_space)) - yPosOffs

        local tDrop = self.DropTarget
        if tDrop then
            tDrop:ClearAllPoints()
            tDrop:SetPoint("TOPLEFT", self, "TOPLEFT", xPos, yPos)
            if(col >= self.Columns-1) then
                col = 0
                row = row + 1
            else
                col = col + 1
            end
        end
        
        cB_Bags.main.EmptySlotCounter:SetText(GetNumFreeSlots("bag"))
        cB_Bags.bank.EmptySlotCounter:SetText(GetNumFreeSlots("bank"))
    end
    
	-- This variable stores the size of the item button container
	self.ContainerHeight = (row + (col > 0 and 1 or 0)) * (C.bag.button_size + C.bag.button_space)

	if (self.UpdateDimensions) then self:UpdateDimensions() end -- Update the bag's height
    local t = (tName == "cBniv_Bag") or (tName == "cBniv_Bank")
    if (not tBankBags and cB_Bags.main:IsShown() and not (t)) or (tBankBags and cB_Bags.bank:IsShown()) then 
        if isEmpty then self:Hide() else self:Show() end 
    end

    cB_BagHidden[tName] = (not t) and isEmpty or false
    cbNivaya:UpdateAnchors(self)
    collectgarbage("collect")    
end

function MyContainer:OnButtonAdd(button)
    if not button.Border then return end
 
    local _,bagType = GetContainerNumFreeSlots(button.bagID)
    if bagType and bagType > 4 then
        button.Border:SetVertexColor(0, 1, 0)        -- Profession bags
    else
        button.Border:SetVertexColor(1, 1, 1)        -- Normal bags
    end
end

local resetNewItems = function(self)
	cB_KnownItems = {}
	for i = 0,4 do
		local tNumSlots = GetContainerNumSlots(i)
		if tNumSlots > 0 then for j = 1,tNumSlots do
			local tLink = GetContainerItemLink(i,j)
			if tLink then
				local tName = GetItemInfo(tLink)
				local _,tStackCount = GetContainerItemInfo(i,j)
				if cB_KnownItems[tName] then
					cB_KnownItems[tName] = cB_KnownItems[tName] + tStackCount
				else
					cB_KnownItems[tName] = tStackCount
				end
			end
		end end
	end
    cbNivaya:UpdateBags()
end

local UpdateDimensions = function(self)
	local height = 0			-- Normal margin space
	if self.BagBar and self.BagBar:IsShown() then
		height = height + 43	-- Bag button space
	end
	if self.Space then
		height = height + 16	-- additional info display space
	end
	if self.bagToggle then
		height = height + 24
	end
	if self.Caption then	    -- Space for captions
		height = height + 20
	end
	self:SetHeight(self.ContainerHeight + height)
end

local SetFrameMovable = function(f, v)
    f:SetMovable(true)
    f:SetUserPlaced(true)
    f:RegisterForClicks("LeftButton", "RightButton")
    if v then 
        f:SetScript("OnMouseDown", function() 
            f:ClearAllPoints() 
            f:StartMoving() 
        end)
        f:SetScript("OnMouseUp",  f.StopMovingOrSizing)
    else
        f:SetScript("OnMouseDown", nil)
        f:SetScript("OnMouseUp", nil)
    end
end

local createTextButton = function (name, parent, width, height)
	local button = CreateFrame("Button", nil, parent)
	button:SetNormalFontObject(GameFontHighlightSmall)
	button:SetText(name)
	button:SetWidth(width)
	button:SetHeight(height)
	--button:SetScript("OnEnter", buttonEnter)
	--button:SetScript("OnLeave", buttonLeave)
	button:SkinButton()
	return button
end

local GetFirstFreeSlot = function(bagtype)
    if bagtype == "bag" then
        for i = 0,4 do
            local t = GetContainerNumFreeSlots(i)
            if t > 0 then
                local tNumSlots = GetContainerNumSlots(i)
                for j = 1,tNumSlots do
                    local tLink = GetContainerItemLink(i,j)
                    if not tLink then return i,j end
                end
            end
        end
    else
        local containerIDs = {-1,5,6,7,8,9,10,11}
        for _,i in next, containerIDs do
            local t = GetContainerNumFreeSlots(i)
            if t > 0 then
                local tNumSlots = GetContainerNumSlots(i)
                for j = 1,tNumSlots do
                    local tLink = GetContainerItemLink(i,j)
                    if not tLink then return i,j end
                end
            end
        end    
    end
    return false
end

function MyContainer:OnCreate(name, settings)
    settings = settings or {}
    self.Settings = settings

    local tBag, tBank = (name == "cBniv_Bag"), (name == "cBniv_Bank")
    local tBankBags = string.find(name, "Bank")
	self:EnableMouse(true)
    
	self.UpdateDimensions = UpdateDimensions
    
	self:SetFrameStrata("HIGH")
	tinsert(UISpecialFrames, self:GetName()) -- Close on "Esc"

	if tBag or tBank then 
        SetFrameMovable(self, cBnivCfg.Unlocked) 
    end

    self.Columns = (tBank and not cBnivCfg.FilterBank) and C.bag.bank_columns or C.bag.bag_columns
	self.ContainerHeight = 0
	self:UpdateDimensions()
	self:SetWidth((C.bag.button_size + C.bag.button_space) * self.Columns)

	-- The frame background
	local background = CreateFrame("Frame", nil, self)
	background:SetTemplate("Transparent")
	background:SetFrameStrata("HIGH")
    background:SetFrameLevel(1)
	background:SetPoint("TOPLEFT", -6, 6)
	background:SetPoint("BOTTOMRIGHT", 3, -3)

	-- Caption and close button
	local caption = background:CreateFontString(background, "OVERLAY", "GameFontNormal")
	caption:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
	caption:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
	if(caption) then
		local t = L.bagCaptions[self.name] or (tBankBags and strsub(self.name, 5))
		if not t then t = self.name end
        if self.Name == "cBniv_ItemSets" then t=ItemSetCaption..t end
		caption:SetText(t)
		caption:SetPoint("TOPLEFT", 8, -6)
		self.Caption = caption
        
        if tBag or tBank then
            local close = CreateFrame("Button", nil, self, "UIPanelCloseButton")
			if C.skins.blizzard_frames == true then
				T.SkinCloseButton(close, nil, nil, true)
				close:SetPoint("TOPRIGHT", -1, 2)
				close:SetWidth(14)
				close:SetHeight(14)
			else
				close:SetPoint("TOPRIGHT", 5, 7)
				close:SetWidth(24)
				close:SetHeight(24)
			end
            close:SetScript("OnClick", function(self) if cbNivaya:AtBank() then CloseBankFrame() else CloseAllBags() end end)
        end
	end
    
    -- mover buttons
    if (settings.isCustomBag) then

        local moveLR = function(dir)
            local idx = -1
            for i,v in ipairs(cB_CustomBags) do if v.name == name then idx = i end end
            if (idx == -1) then return end

            local tcol = (cB_CustomBags[idx].col + ((dir == "left") and 1 or -1)) % 2
            cB_CustomBags[idx].col = tcol
            cbNivaya:CreateAnchors()
        end

        local moveUD = function(dir)
            local idx = -1
            for i,v in ipairs(cB_CustomBags) do if v.name == name then idx = i end end
            if (idx == -1) then return end

            local pos = idx
            local d = (dir == "up") and 1 or -1
            repeat 
                pos = pos + d
            until 
                (not cB_CustomBags[pos]) or (cB_CustomBags[pos].col == cB_CustomBags[idx].col)

            if (cB_CustomBags[pos] ~= nil) then
                local ele = cB_CustomBags[idx]
                cB_CustomBags[idx] = cB_CustomBags[pos]
                cB_CustomBags[pos] = ele
                cbNivaya:CreateAnchors()
            end
        end        

        local rightBtn = createTextButton(">", self, 20, 20)
        rightBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -40, 2)
        rightBtn:SetScript("OnClick", function() moveLR("right") end)

        local leftBtn = createTextButton("<", self, 20, 20)
        leftBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -62, 2)
        leftBtn:SetScript("OnClick", function() moveLR("left") end)

        local downBtn = createTextButton("v", self, 20, 20)
        downBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -84, 2)
        downBtn:SetScript("OnClick", function() moveUD("down") end)

        local upBtn = createTextButton("^", self, 20, 20)
        upBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -106, 2)
        upBtn:SetScript("OnClick", function() moveUD("up") end)

        self.rightBtn = rightBtn
        self.leftBtn = leftBtn
        self.downBtn = downBtn
        self.upBtn = upBtn
    end
        
    local tBtnOffs = 0
  	if tBag or tBank then
		 -- Bag bar for changing bags
		local bagType = tBag and "bags" or "bank"
        
        local tS = tBag and "backpack+bags" or "bank"
        local tI = tBag and 4 or 7
        
		local bagButtons = self:SpawnPlugin("BagBar", tS)
    	bagButtons:SetSize(bagButtons:LayoutButtons("grid", tI))
        bagButtons.highlightFunction = function(button, match) button:SetAlpha(match and 1 or 0.1) end
        bagButtons:SetScale(1)
        bagButtons.isGlobal = true
        
		if tBag then
			bagButtons:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -23, 27)
		else
			bagButtons:SetPoint("BOTTOM", self, "BOTTOM", 1, 27)
		end
        bagButtons:Hide()
        self.BagBar = bagButtons
		
		-- We don't need the bag bar every time, so let's create a toggle button for them to show
        self.bagToggle = CreateFrame("CheckButton", nil, self)
		self.bagToggle:SetWidth(40)
		self.bagToggle:SetHeight(12)
		self.bagToggle:SetPoint("CENTER", self)
        self.bagToggle:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
        self.bagToggle:SetScript("OnClick", function()
			if(self.BagBar:IsShown()) then self.BagBar:Hide() else self.BagBar:Show() end
			self:UpdateDimensions()
		end)
		
		local bagToggleText = self.bagToggle:CreateFontString(nil, "OVERLAY")
		bagToggleText:SetPoint("CENTER", self.bagToggle)
		bagToggleText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		bagToggleText:SetFontObject(GameFontNormalSmall)
		bagToggleText:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		bagToggleText:SetText(cBnivL.Bags)

		-- Button to reset new items:
        if tBag and cBnivCfg.NewItems then
            local resetBtn = CreateFrame("CheckButton", nil, self)
			resetBtn:SetWidth(70)
			resetBtn:SetHeight(15)
			resetBtn:SetPoint("CENTER", self)
            resetBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -22-tBtnOffs, 2)
            resetBtn:SetScript("OnClick", function() resetNewItems(self) end)
			
			local resetBtnText = resetBtn:CreateFontString(nil, "OVERLAY")
			resetBtnText:SetPoint("CENTER", resetBtn)
			resetBtnText:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			resetBtnText:SetFontObject(GameFontNormalSmall)
			resetBtnText:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
			resetBtnText:SetText(L.ResetNew)
        end
    end

    -- Item drop target
    if (tBag or tBank) then
        self.DropTarget = CreateFrame("Button", nil, self, "ItemButtonTemplate")
        self.DropTarget:SetWidth(C.bag.button_size)
        self.DropTarget:SetHeight(C.bag.button_size)
		self.DropTarget:SetHighlightTexture("")
		self.DropTarget:SetPushedTexture("")
		self.DropTarget:SetNormalTexture("")
		self.DropTarget:SetTemplate("Transparent")
        
		self.DropTarget:HookScript('OnEnter', function()
			self.oldColor = {self.DropTarget:GetBackdropBorderColor()}
			self.DropTarget:SetBackdropBorderColor(1, 1, 1)
		end)
		self.DropTarget:HookScript('OnLeave', function()
			self.DropTarget:SetBackdropBorderColor(unpack(self.oldColor))
		end)
		
        local DropTargetProcessItem = function()
            if CursorHasItem() then
                local bID, sID = GetFirstFreeSlot(tBag and "bag" or "bank")
                if bID then PickupContainerItem(bID, sID) end
            end
        end
        self.DropTarget:SetScript("OnMouseUp", DropTargetProcessItem)
        self.DropTarget:SetScript("OnReceiveDrag", DropTargetProcessItem)
        
        local fs = self:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		fs:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		fs:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		fs:SetParent(self.DropTarget)
        fs:SetTextColor(1,1,1)
        fs:SetJustifyH("LEFT")
        fs:SetPoint("BOTTOMRIGHT", self.DropTarget, "BOTTOMRIGHT", 0, 1)
        self.EmptySlotCounter = fs
        
        if cBnivCfg.CompressEmpty then 
            self.DropTarget:Show()
            self.EmptySlotCounter:Show()
        else
            self.DropTarget:Hide()
            self.EmptySlotCounter:Hide()
        end
    end
    
    if tBag then
        local infoFrame = CreateFrame("Button", nil, self)
        infoFrame:SetPoint("BOTTOMLEFT", -3, 0)
        infoFrame:SetPoint("BOTTOMRIGHT", -100, 0)
        infoFrame:SetHeight(15)

        -- Search bar
        local search = self:SpawnPlugin("SearchBar", infoFrame)
        search.isGlobal = true
        search.highlightFunction = function(button, match) button:SetAlpha(match and 1 or 0.1) end
        
        local caption = background:CreateFontString(infoFrame, "OVERLAY", "GameFontNormalSmall")
		caption:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		caption:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		caption:SetText(L.Search)
		caption:SetPoint("LEFT", infoFrame, 3, -2)
        
        -- The money display
        --local money = self:SpawnPlugin("TagDisplay", "[money]", self)
        --money:SetPoint("BOTTOMLEFT", 2, 2)
    end
    
	self:SetScale(1)
	return self
end

------------------------------------------
-- MyButton specific
------------------------------------------
local MyButton = cbNivaya:GetItemButtonClass()
MyButton:Scaffold("Default")

function MyButton:OnAdd()
    self:SetScript('OnMouseUp', function(self, mouseButton)
        if (mouseButton == 'RightButton') and (IsAltKeyDown()) then
            local tID = GetContainerItemID(self.bagID, self.slotID)
            if tID then 
                cbNivCatDropDown.itemName = GetItemInfo(tID)
                cbNivCatDropDown.itemID = tID
                ToggleDropDownMenu(1, nil, cbNivCatDropDown, self, 0, 0)
            end
        end
    end)
end

------------------------------------------
-- BagButton specific
------------------------------------------
local BagButton = cbNivaya:GetClass("BagButton", true, "BagButton")

function BagButton:OnCreate() self:GetCheckedTexture():SetVertexColor(1, 0.8, 0, 0.8) end