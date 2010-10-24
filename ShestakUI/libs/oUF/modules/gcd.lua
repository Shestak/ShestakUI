if SettingsCF["unitframe"].plugins_gcd ~= true then return end
local _, ns = ...
local oUF = ns.oUF or oUF

local starttime, duration, usingspell, spellid
local GetTime = GetTime

local spells = {
    ["DEATHKNIGHT"] = 45902,
    ["DRUID"] = 1126,
    ["HUNTER"] = 1978,
    ["MAGE"] = 133,
    ["PALADIN"] = 635,
    ["PRIEST"] = 21562,
    ["ROGUE"] = 1752,
    ["SHAMAN"] = 331,
    ["WARRIOR"] = 7386,
    ["WARLOCK"] = 686,
}

local _, class = UnitClass("player")
local spell = GetSpellInfo(spells[class])

local Enable = function(self)
	if(not self.GCD) then return end
	local bar = self.GCD
	local width = bar:GetWidth()
	bar:Hide()

	bar.spark = bar:CreateTexture(nil, "DIALOG")
	bar.spark:SetTexture(SettingsCF["media"].blank)
	bar.spark:SetVertexColor(unpack(bar.Color))
	bar.spark:SetHeight(bar.Height)
	bar.spark:SetWidth(bar.Width)
	bar.spark:SetBlendMode("ADD")

	local function OnUpdateSpark()
		bar.spark:ClearAllPoints()
		local elapsed = GetTime() - starttime
		local perc = elapsed / duration
		if(perc>1) then
			return bar:Hide()
		else
			bar.spark:SetPoint("CENTER", bar, "LEFT", width * perc, 0)
		end
	end

	local function OnHide()
		bar:SetScript("OnUpdate", nil)
		usingspell = nil
    end

	local function OnShow()
		bar:SetScript("OnUpdate", OnUpdateSpark)
    end

	local function UpdateGCD()
		if(spellid) then
			local start, dur = GetSpellCooldown(spellid, "spell")
			if(dur and dur>0 and dur<=2) then
				usingspell = 1
				starttime = start
				duration = dur
				bar:Show()
				return
			elseif(usingspell==1 and dur==0) then
				bar:Hide()
			end
		else
			for tab = 2, 4 do
				local _, _, offset, numSpells = GetSpellTabInfo(tab)
				for i = (1+offset), (offset+numSpells) do
					local tempspell = GetSpellBookItemName(i, "spell")
					if(tempspell == spell) then
						spellid = i
                    end
                end
            end
		end
	end

	bar:SetScript("OnShow", OnShow)
	bar:SetScript("OnHide", OnHide)

	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", UpdateGCD)
end

oUF:AddElement("GCD", UpdateGCD, Enable)