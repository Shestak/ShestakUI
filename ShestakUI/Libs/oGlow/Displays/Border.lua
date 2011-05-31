-- local variables.
local T, C, L = unpack(select(2, ...))
local argcheck = oGlow.argcheck

local colorTable = setmetatable(
	{},

	-- We mainly want to handle item quality coloring, so this acts as a fallback.
	-- The bonus of doing this is that we don't really have to make any updates to
	-- the add-on if any new item colors are added. It also caches unlike the old
	-- version.
	{__index = function(self, val)
		argcheck(val, 2, 'number')
		local r, g, b = GetItemQualityColor(val)
		rawset(self, val, {r, g, b})

		return self[val]
	end}
)

local createBorder = function(self, point)
	local bc = self.oGlowBorder
	if(not bc) then
		if IsAddOnLoaded("ShestakUI_Extra") and C.extra_skins.blizzard_frames == true then
			if(not self:IsObjectType'Frame') then
				bc = CreateFrame("Frame", nil, self:GetParent())
			else
				bc = CreateFrame("Frame", nil, self)
			end

			bc:SetBackdrop({
				edgeFile = C.media.blank,
				edgeSize = 1,
			})

			bc:SetPoint("TOPLEFT", point or self, 0, 0)
			bc:SetPoint("BOTTOMRIGHT", point or self, 0, 0)
		else
			if(not self:IsObjectType'Frame') then
				bc = self:GetParent():CreateTexture(nil, 'OVERLAY')
			else
				bc = self:CreateTexture(nil, "OVERLAY")
			end

			bc:SetTexture"Interface\\Buttons\\UI-ActionButton-Border"
			bc:SetBlendMode"ADD"
			bc:SetAlpha(.8)

			bc:SetWidth(70)
			bc:SetHeight(70)

			bc:SetPoint("CENTER", point or self)
		end
		self.oGlowBorder = bc
	end

	return bc
end

local borderDisplay = function(frame, color)
	if(color) then
		local bc = createBorder(frame)
		local rgb = colorTable[color]

		if(rgb) then
			if IsAddOnLoaded("ShestakUI_Extra") and C.extra_skins.blizzard_frames == true then
				bc:SetBackdropBorderColor(rgb[1], rgb[2], rgb[3])
			else
				bc:SetVertexColor(rgb[1], rgb[2], rgb[3])
			end
			bc:Show()
		end

		return true
	elseif(frame.oGlowBorder) then
		frame.oGlowBorder:Hide()
	end
end

function oGlow:RegisterColor(name, r, g, b)
	argcheck(name, 2, 'string', 'number')
	argcheck(r, 3, 'number')
	argcheck(g, 4, 'number')
	argcheck(b, 5, 'number')

	-- Silently fail.
	if(rawget(colorTable, name)) then
		return nil, string.format('Color [%s] is already registered.', name)
	else
		rawset(colorTable, name, {r, g, b})
	end

	return true
end

oGlow:RegisterDisplay('Border', borderDisplay)
