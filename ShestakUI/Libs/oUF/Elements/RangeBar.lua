local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe_class_bar.range ~= true then return end

----------------------------------------------------------------------------------------
--	RangeBar for Priest (by m2jest1c)
----------------------------------------------------------------------------------------
local parent, ns = ...
local oUF = ns.oUF

local Items = {
	["Friend"] = {
		37727,	-- 5
		32321,	-- 10
		1251,	-- 15
		21519,	-- 20
		31463,	-- 25
		1180,	-- 30
		18904,	-- 35
		34471,	-- 40
		},
	["Enemy"] = {
		37727,	-- 5
		32321,	-- 10
		33069,	-- 15
		10645,	-- 20
		31463,	-- 25
		835,	-- 30
		18904,	-- 35
		28767,	-- 40
		},
	}
	
local Colors = {
	{0.3, 0.3, 0.9},	-- 0-5
	{0.3, 0.9, 0.9},	-- 5-10
	{0.3, 0.9, 0.9},	-- 10-15
	{0.9, 0.9, 0.3},	-- 15-20
	{0.9, 0.9, 0.3},	-- 20-25
	{0.3, 0.9, 0.3},	-- 25-30
	{0.9, 0.9, 0.3},	-- 30-35
	{0.9, 0.9, 0.3},	-- 35-40
	{1, 0, 0},			-- >40
	}

local Update = function(self, event, unit)
	local rb = self.RangeBar
	if(rb.PreUpdate) then
		rb:PreUpdate()
	end
	
	rb:SetMinMaxValues(0, 7)
	
	local Target
	
	if UnitCanAssist("player", "target") and UnitIsUnit("target", "player") == nil then
		Target = Items.Friend
		rb:Show()
	elseif UnitCanAttack("player", "target") then
		Target = Items.Enemy
		rb:Show()
	else
		rb:Hide()
	end
	
	local timer = 0
	rb:SetScript("OnUpdate", function(self, elapsed)	
		timer = timer + elapsed
		if timer >= .20 then
		
			local Distance = 0
			
			for key, item in pairs(Target) do
				if IsItemInRange(item, "target") == 0 then
					Distance = key
				end
			end
			
			for key, color in pairs(Colors) do
				local r, g, b = unpack(color)
				if Distance == key - 1 then
					rb:SetStatusBarColor(r, g, b)
					if rb.bg then rb.bg:SetVertexColor(r, g, b, 0.2) end
				end
			end

			rb:SetValue(Distance)

			timer = 0
		end
	end)
end

local Path = function(self, ...)
	return (self.RangeBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local Enable = function(self)
	local rb = self.RangeBar
	if rb then
		rb.__owner = self
		rb.ForceUpdate = ForceUpdate
		
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path)
			
		return true
	end
end

local Disable = function(self)
	local rb = self.RangeBar
	if rb then
		self:UnregisterEvent("PLAYER_TARGET_CHANGED", Path)
	end
end

oUF:AddElement("RangeBar", Path, Enable, Disable)