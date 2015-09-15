--3D全身模型，固定位置
local T, C, L, _ = unpack(select(2, ...))
if C.zzz.Model_enable ~= true then return end

local myaddon = CreateFrame("Frame", "myaddon", UIParent)
myaddon:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", 21, 2)		--位置
myaddon:SetScale(1.5)  
myaddon:SetSize(1, 1)
--[[ 调试位置用
myaddon:SetBackdrop({
		bgFile = "Interface\\AddOns\\zzz\\media\\texture",
		insets = {left = 3, right = 3, top = 3, bottom = 3},
		edgeFile = "Interface\\AddOns\\zzz\\media\\GlowTex",
		edgeSize = 4,
	})
	myaddon:SetBackdropColor(0, 0, 0, .3)
	myaddon:SetBackdropBorderColor(0, 0, 0, 1)
]]--
myaddon:RegisterEvent("PLAYER_REGEN_ENABLED")
myaddon:RegisterEvent("PLAYER_REGEN_DISABLED")
myaddon:HookScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
		self:Show()
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:Hide()
	end
end)
local Model = CreateFrame("PlayerModel", "Model", myaddon)
Model:SetSize(380, 380)		--模型框体大小
Model:SetPoint("BOTTOMRIGHT", myaddon, "TOPRIGHT", 0, 0) 
Model:SetCamera(1) 
Model:SetFrameStrata("BACKGROUND") 
Model:SetFrameLevel(0) 
Model:RegisterEvent("PLAYER_TARGET_CHANGED")
Model:SetScript("OnEvent", function(self)
    if UnitExists("target") then
        self:SetUnit("target")
        self:Show()
    else
        self:ClearModel()
        self:Hide()
    end
end)

--模型旋转
if C.zzz.Model_rotate == true then
	Model:SetScript("OnUpdate", function(self, elapsed)
		if IsAltKeyDown() then
			self:SetFacing(self:GetFacing())	
		else
			self:SetFacing(self:GetFacing() + math.pi * elapsed / 5)
		end
	end)
end

--框体点击移动
if C.zzz.Model_drag == true then
	function Model:OnDrag()
		self:EnableMouse(true)
		self:SetMovable(true)
		self:RegisterForDrag("LEFTBUTTON")
		self:SetScript("OnDragStart", function(self)
			self:StartMoving()
		end)
		self:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		end)
	end
	Model:OnDrag()
end