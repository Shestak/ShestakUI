local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_gcd ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_GCD(by ALZA)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local starttime, duration, usingspell
local GetTime = GetTime

local function OnUpdateSpark(self)
	self.Spark:ClearAllPoints()
	local elapsed = GetTime() - starttime
	local perc = elapsed / duration
	if perc > 1 then
		self:Hide()
		return
	else
		self.Spark:SetPoint("CENTER", self, "LEFT", self.width * perc, 0)
	end
end

local function OnHide(self)
	self:SetScript("OnUpdate", nil)
	usingspell = nil
end

local function OnShow(self)
	self:SetScript("OnUpdate", OnUpdateSpark)
end

local function Update(self)
	local bar = self.GCD
	local start, dur = GetSpellCooldown(61304)
	if dur and dur > 0 and dur <= 2 then
		usingspell = 1
		starttime = start
		duration = dur
		bar:Show()
		return
	elseif usingspell == 1 and dur == 0 then
		bar:Hide()
	end
end

local function Enable(self)
	local element = self.GCD
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		element.width = element:GetWidth()
		element:Hide()

		element.Spark = element:CreateTexture(nil, "OVERLAY")
		element.Spark:SetTexture(C.media.blank)
		element.Spark:SetVertexColor(unpack(element.Color))
		element.Spark:SetHeight(element.Height)
		element.Spark:SetWidth(element.Width)
		element.Spark:SetBlendMode("ADD")

		element:SetScript("OnShow", OnShow)
		element:SetScript("OnHide", OnHide)

		self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", Update, true)

		return true
	end
end

local function Disable(self)
	local element = self.GCD
	if(element) then
		element:Hide()

		self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN", Update)
	end
end


oUF:AddElement("GCD", Update, Enable, Disable)