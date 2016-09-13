local parent, ns = ...
local oUF = ns.oUF

local VISIBLE = 1
local HIDDEN = 0

local UpdateTooltip = function(self)
	GameTooltip:SetUnitAura(self:GetParent().__owner.unit, self:GetID(), self.filter)
end

local OnEnter = function(self)
	if(not self:IsVisible()) then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	self:UpdateTooltip()
end

local OnLeave = function()
	GameTooltip:Hide()
end

local createAuraIcon = function(icons, index)
	local button = CreateFrame("Button", icons:GetDebugName().."Button"..index, icons)
	button:EnableMouse(true)
	button:RegisterForClicks'RightButtonUp'

	button:SetWidth(icons.size or 16)
	button:SetHeight(icons.size or 16)

	local cd = CreateFrame("Cooldown", "$parentCooldown", button, "CooldownFrameTemplate")
	cd:SetAllPoints(button)
	cd:SetDrawEdge(false)

	local icon = button:CreateTexture(nil, "BORDER")
	icon:SetAllPoints(button)

	local count = button:CreateFontString(nil, "OVERLAY")
	count:SetFontObject(NumberFontNormal)
	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 0)

	local overlay = button:CreateTexture(nil, "OVERLAY")
	overlay:SetTexture"Interface\\Buttons\\UI-Debuff-Overlays"
	overlay:SetAllPoints(button)
	overlay:SetTexCoord(.296875, .5703125, 0, .515625)
	button.overlay = overlay

	local stealable = button:CreateTexture(nil, 'OVERLAY')
	stealable:SetTexture[[Interface\TargetingFrame\UI-TargetingFrame-Stealable]]
	stealable:SetPoint('TOPLEFT', -3, 3)
	stealable:SetPoint('BOTTOMRIGHT', 3, -3)
	stealable:SetBlendMode'ADD'
	button.stealable = stealable

	button.UpdateTooltip = UpdateTooltip
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)

	table.insert(icons, button)

	button.icon = icon
	button.count = count
	button.cd = cd

	if(icons.PostCreateIcon) then icons:PostCreateIcon(button) end

	return button
end

local customFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster)
	local isPlayer

	if(caster == 'player' or caster == 'vehicle') then
		isPlayer = true
	end

	if((icons.onlyShowPlayer and isPlayer) or (not icons.onlyShowPlayer and name)) then
		icon.isPlayer = isPlayer
		icon.owner = caster
		return true
	end
end

local updateIcon = function(unit, icons, index, offset, filter, isDebuff, visible)
	local name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff = UnitAura(unit, index, filter)
	if(name) then
		local n = visible + offset + 1
		local icon = icons[n]
		if(not icon) then
			icons.createdIcons = icons.createdIcons + 1
			icon = (icons.CreateIcon or createAuraIcon) (icons, n)
		end

		local show = (icons.CustomFilter or customFilter) (icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff)
		if(show) then
			-- We might want to consider delaying the creation of an actual cooldown
			-- object to this point, but I think that will just make things needlessly
			-- complicated.
			local cd = icon.cd
			if(cd and not icons.disableCooldown) then
				if(duration and duration > 0) then
					cd:SetCooldown(timeLeft - duration, duration)
					cd:Show()
				else
					cd:Hide()
				end
			end

			if((isDebuff and icons.showDebuffType) or (not isDebuff and icons.showBuffType) or icons.showType) then
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none

				icon.overlay:SetVertexColor(color.r, color.g, color.b)
				icon.overlay:Show()
			else
				icon.overlay:Hide()
			end

			local stealable = not isDebuff and isStealable
			if(stealable and icons.showStealableBuffs and not UnitIsUnit('player', unit)) then
				icon.stealable:Show()
			else
				icon.stealable:Hide()
			end

			icon.icon:SetTexture(texture)
			icon.count:SetText((count > 1 and count))

			icon.filter = filter
			icon.debuff = isDebuff

			icon:SetID(index)
			icon:Show()

			if(icons.PostUpdateIcon) then
				icons:PostUpdateIcon(unit, icon, index, offset)
			end

			return VISIBLE
		else
			return HIDDEN
		end
	end
end

local SetPosition = function(icons, x)
	if(icons and x > 0) then
		local col = 0
		local row = 0
		local gap = icons.gap
		local sizex = (icons.size or 16) + (icons['spacing-x'] or icons.spacing or 0)
		local sizey = (icons.size or 16) + (icons['spacing-y'] or icons.spacing or 0)
		local anchor = icons.initialAnchor or "BOTTOMLEFT"
		local growthx = (icons["growth-x"] == "LEFT" and -1) or 1
		local growthy = (icons["growth-y"] == "DOWN" and -1) or 1
		local cols = math.floor(icons:GetWidth() / sizex + .5)
		local rows = math.floor(icons:GetHeight() / sizey + .5)

		for i = 1, #icons do
			local button = icons[i]
			if(button and button:IsShown()) then
				if(gap and button.debuff) then
					if(col > 0) then
						col = col + 1
					end

					gap = false
				end

				if(col >= cols) then
					col = 0
					row = row + 1
				end
				button:ClearAllPoints()
				button:SetPoint(anchor, icons, anchor, col * sizex * growthx, row * sizey * growthy)

				col = col + 1
			elseif(not button) then
				break
			end
		end
	end
end

local filterIcons = function(unit, icons, filter, limit, isDebuff, offset, dontHide)
	if(not offset) then offset = 0 end
	local index = 1
	local visible = 0
	local hidden = 0
	while(visible < limit) do
		local result = updateIcon(unit, icons, index, offset, filter, isDebuff, visible)
		if(not result) then
			break
		elseif(result == VISIBLE) then
			visible = visible + 1
		elseif(result == HIDDEN) then
			hidden = hidden + 1
		end

		index = index + 1
	end

	if(not dontHide) then
		for i = visible + offset + 1, #icons do
			icons[i]:Hide()
		end
	end

	return visible, hidden
end

local Update = function(self, event, unit)
	if(self.unit ~= unit) then return end

	local auras = self.Auras
	if(auras) then
		if(auras.PreUpdate) then auras:PreUpdate(unit) end

		local numBuffs = auras.numBuffs or 32
		local numDebuffs = auras.numDebuffs or 40
		local max = numBuffs + numDebuffs

		local pvb = auras.visibleBuffs
		local visibleBuffs, hiddenBuffs = filterIcons(unit, auras, auras.buffFilter or auras.filter or 'HELPFUL', numBuffs, nil, 0, true)
		auras.visibleBuffs = visibleBuffs

		local pvd = auras.visibleDebuffs
		local visibleDebuffs, hiddenDebuffs = filterIcons(unit, auras, auras.debuffFilter or auras.filter or 'HARMFUL', numDebuffs, true, visibleBuffs)
		auras.visibleDebuffs = visibleDebuffs

		auras.visibleAuras = auras.visibleBuffs + auras.visibleDebuffs

		if(auras.PreSetPosition) then
			auras:PreSetPosition(max)
		end

		local hiddenAuras = hiddenBuffs + hiddenDebuffs
		if(
			auras.PreSetPosition or
			hiddenAuras > 0 or
			(auras.gap and (visibleBuffs ~= pvb or visibleDebuffs ~= pvd)) or
			auras.createdIcons > auras.anchoredIcons
		)
		then
			(auras.SetPosition or SetPosition) (auras, max)
			auras.anchoredIcons = auras.createdIcons
		end

		if(auras.PostUpdate) then auras:PostUpdate(unit) end
	end

	local buffs = self.Buffs
	if(buffs) then
		if(buffs.PreUpdate) then buffs:PreUpdate(unit) end

		local numBuffs = buffs.num or 32
		local visibleBuffs, hiddenBuffs = filterIcons(unit, buffs, buffs.filter or 'HELPFUL', numBuffs)
		buffs.visibleBuffs = visibleBuffs

		if(buffs.PreSetPosition) then
			buffs:PreSetPosition(numBuffs)
		end

		if(buffs.PreSetPosition or hiddenBuffs > 0 or buffs.createdIcons > buffs.anchoredIcons) then
			(buffs.SetPosition or SetPosition) (buffs, numBuffs)
			buffs.anchoredIcons = buffs.createdIcons
		end

		if(buffs.PostUpdate) then buffs:PostUpdate(unit) end
	end

	local debuffs = self.Debuffs
	if(debuffs) then
		if(debuffs.PreUpdate) then debuffs:PreUpdate(unit) end

		local numDebuffs = debuffs.num or 40
		local visibleDebuffs, hiddenDebuffs = filterIcons(unit, debuffs, debuffs.filter or 'HARMFUL', numDebuffs, true)
		debuffs.visibleDebuffs = visibleDebuffs

		if(debuffs.PreSetPosition) then
			debuffs:PreSetPosition(numDebuffs)
		end

		if(debuffs.PreSetPosition or hiddenDebuffs > 0 or debuffs.createdIcons > debuffs.anchoredIcons) then
			(debuffs.SetPosition or SetPosition) (debuffs, numDebuffs)
			debuffs.anchoredIcons = debuffs.createdIcons
		end

		if(debuffs.PostUpdate) then debuffs:PostUpdate(unit) end
	end
end

local ForceUpdate = function(element)
	return Update(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local Enable = function(self)
	if(self.Buffs or self.Debuffs or self.Auras) then
		self:RegisterEvent("UNIT_AURA", Update)

		local buffs = self.Buffs
		if(buffs) then
			buffs.__owner = self
			buffs.ForceUpdate = ForceUpdate

			buffs.createdIcons = 0
			buffs.anchoredIcons = 0
		end

		local debuffs = self.Debuffs
		if(debuffs) then
			debuffs.__owner = self
			debuffs.ForceUpdate = ForceUpdate

			debuffs.createdIcons = 0
			debuffs.anchoredIcons = 0
		end

		local auras = self.Auras
		if(auras) then
			auras.__owner = self
			auras.ForceUpdate = ForceUpdate

			auras.createdIcons = 0
			auras.anchoredIcons = 0
		end

		return true
	end
end

local Disable = function(self)
	if(self.Buffs or self.Debuffs or self.Auras) then
		self:UnregisterEvent("UNIT_AURA", Update)
	end
end

oUF:AddElement('Aura', Update, Enable, Disable)
