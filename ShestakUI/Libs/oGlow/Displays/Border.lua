local T, C, L = unpack(select(2, ...))
local argcheck = oGlow.argcheck

local colorTable = setmetatable(
	{},
	{__index = function(self, val)
		argcheck(val, 2, "number")
		local r, g, b = GetItemQualityColor(val)
		rawset(self, val, {r, g, b})

		return self[val]
	end}
)

local createBorder = function(self, point)
	local bc = self.oGlowBorder
	if not bc then
		if C.skins.blizzard_frames == true then
			if not self:IsObjectType("Frame") then
				bc = CreateFrame("Frame", nil, self:GetParent())
			else
				bc = CreateFrame("Frame", nil, self)
			end

			bc:SetBackdrop({
				edgeFile = C.media.blank,
				edgeSize = 1,
			})

			if self.backdrop then
				bc:SetPoint("TOPLEFT", 0, 0)
				bc:SetPoint("BOTTOMRIGHT", 0, 0)
			else
				bc:SetPoint("TOPLEFT", point or self, 0, 0)
				bc:SetPoint("BOTTOMRIGHT", point or self, 0, 0)
			end
		else
			if not self:IsObjectType("Frame") then
				bc = self:GetParent():CreateTexture(nil, "OVERLAY")
			else
				bc = self:CreateTexture(nil, "OVERLAY")
			end

			bc:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
			bc:SetBlendMode("ADD")
			bc:SetAlpha(0.8)

			bc:SetWidth(70)
			bc:SetHeight(70)

			bc:SetPoint("CENTER", point or self)
		end
		self.oGlowBorder = bc
	end

	return bc
end

local borderDisplay = function(frame, color)
	if color then
		local bc = createBorder(frame)
		local rgb = colorTable[color]

		if rgb then
			if C.skins.blizzard_frames == true then
				bc:SetBackdropBorderColor(rgb[1], rgb[2], rgb[3])
				if bc.backdrop then
					bc.backdrop:SetBackdropBorderColor(rgb[1], rgb[2], rgb[3])
				end
			else
				bc:SetVertexColor(rgb[1], rgb[2], rgb[3])
			end
			bc:Show()
		end

		return true
	elseif frame.oGlowBorder then
		frame.oGlowBorder:Hide()
	end
end

function oGlow:RegisterColor(name, r, g, b)
	argcheck(name, 2, "string", "number")
	argcheck(r, 3, "number")
	argcheck(g, 4, "number")
	argcheck(b, 5, "number")

	if(rawget(colorTable, name)) then
		return nil, string.format("Color [%s] is already registered.", name)
	else
		rawset(colorTable, name, {r, g, b})
	end

	return true
end

oGlow:RegisterDisplay("Border", borderDisplay)