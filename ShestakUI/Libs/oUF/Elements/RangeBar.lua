local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe_class_bar.range ~= true then return end

----------------------------------------------------------------------------------------
--	RangeBar for Priest (by m2jest1c)
----------------------------------------------------------------------------------------
local parent, ns = ...
local oUF = ns.oUF

local RangeUpdateFrame

local FriendItems = {
	37727,	-- 5
	32321,	-- 10
	1251,	-- 15
	21519,	-- 20
	31463,	-- 25
	1180,	-- 30
	18904,	-- 35
	34471,	-- 40
	}
local EnemyItems = {
	37727,	-- 5
	32321,	-- 10
	33069,	-- 15
	10645,	-- 20
	31463,	-- 25
	835,	-- 30
	18904,	-- 35
	28767,	-- 40
	}
	
local Target = nil
local Distance = 0

local Update = function(self, event, unit)
	if UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle") then return end
	local rb = self.RangeBar
	if(rb.PreUpdate) then
		rb:PreUpdate()
	end
	
	rb.Bar:SetMinMaxValues(0, 7)
	
	local timer = 0
	local UpdateDistance = function(self, elapsed)
		timer = timer + elapsed
		if timer >= .20 then
			if UnitCanAssist("player", "target") and UnitName("target") ~= T.name then
				Target = FriendItems
				rb:Show()
			elseif UnitCanAttack("player", "target") then
				Target = EnemyItems
				rb:Show()
			else
				rb:Hide()
			end
			if Target ~= nil then
				for key, item in pairs(Target) do
					if IsItemInRange(item, "target") == 0 then
						Distance = key
					end
				end
			end
			
			if Distance == 5 then
				rb.Bar:SetStatusBarColor(0.3, 0.9, 0.3)
			elseif Distance == 8 then
				rb.Bar:SetStatusBarColor(0.9, 0.3, 0.3)
			else	
				rb.Bar:SetStatusBarColor(0.9, 0.9, 0.3)
			end
			
			rb.Bar:SetValue(Distance)
			
			Distance = 0
			timer = 0
		end
	end
	
	RangeUpdateFrame = CreateFrame("FRAME")
	RangeUpdateFrame:SetScript("OnUpdate", UpdateDistance)
	
	Target = nil
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