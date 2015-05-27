local parent, ns = ...
local oUF = ns.oUF

if select(2, UnitClass("player")) ~= "ROGUE" then return end

local ANTICIPATION = GetSpellInfo(115189)

local function UpdateBar(self, elapsed)
	if not self.expirationTime then return end
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 0.5 then	
		local timeLeft = self.expirationTime - GetTime()
		if timeLeft > 0 then
			self:SetValue(timeLeft)
		else
			self:SetScript("OnUpdate", nil)
		end
	end		
end

local Update = function(self, event)
	local unit = self.unit or "player"
	local bar = self.Anticipation
	if(bar.PreUpdate) then bar:PreUpdate(event) end

	local name, _, _, count, _, start, timeLeft = UnitBuff(unit, ANTICIPATION)
	local charges, maxCharges = 0, 5
	if(name) then
		charges = count or 0
		duration = start
		expirationTime = timeLeft
	end

	if(charges < 1) then
		bar:Hide()
	else
		bar:Show()
	end

	if bar:IsShown() then		
		for i = 1, maxCharges do
			if start and timeLeft then
				bar[i]:SetMinMaxValues(0, start)
				bar[i].duration = start
				bar[i].expirationTime = timeLeft
			end
			
			if i <= charges then
				bar[i]:Show()
				bar[i]:SetValue(start)
				bar[i]:SetScript("OnUpdate", UpdateBar)
			else
				bar[i]:Hide()
				bar[i]:SetValue(0)
				bar[i]:SetScript("OnUpdate", nil)
			end
		end		
	end
	
	if(bar.PostUpdate) then
		return bar:PostUpdate(event, charges, maxCharges)
	end
end


local Path = function(self, ...)
	return (self.Anticipation.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self, unit)
	local bar = self.Anticipation

	if(bar) then
		self:RegisterEvent("UNIT_AURA", Path)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Path)
		bar.__owner = self
		bar.ForceUpdate = ForceUpdate

		for i = 1, 5 do
			if not bar[i]:GetStatusBarTexture() then
				bar[i]:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			bar[i]:SetFrameLevel(bar:GetFrameLevel() + 1)
			bar[i]:GetStatusBarTexture():SetHorizTile(false)
			
			if bar[i].bg then
				bar[i]:SetMinMaxValues(0, 1)
				bar[i]:SetValue(0)
				bar[i].bg:SetAlpha(0.2)
				bar[i].bg:SetAllPoints()
			end		
		end
		
		return true;
	end	
end

local function Disable(self,unit)
	local bar = self.Anticipation

	if(bar) then
		self:UnregisterEvent("UNIT_AURA", Path)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Path)
		bar:Hide()
	end
end
			
oUF:AddElement("Anticipation",Path,Enable,Disable)
