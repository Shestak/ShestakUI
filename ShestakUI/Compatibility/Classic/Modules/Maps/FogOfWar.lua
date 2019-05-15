local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.minimap.fog_of_war ~= true then return end

----------------------------------------------------------------------------------------
--	Fog of war on World Map(Leatrix_Maps by Leatrix)
----------------------------------------------------------------------------------------
local zones = {
	----------------------------------------------------------------------
	-- Eastern Kingdoms
	----------------------------------------------------------------------

	--[[Alterac Mountains]] [1205] = {},
	--[[Arathi Highlands]] [1206] = {},
	--[[Badlands]] [1207] = {},
	--[[Blasted Lands]] [1209] = {},
	--[[Burning Steppes]] [1224] = {},
	--[[Deadwind Pass]] [1233] = {},
	--[[Dun Morogh]] [1216] = {},
	--[[Duskwood]] [1235] = {},
	--[[Eastern Plaguelands]] [1213] = {},
	--[[Elwynn Forest]] [1228] = {},
	--[[Hillsbrad Foothills]] [1214] = {},
	--[[Loch Modan]] [1214] = {},
	--[[Redridge Mountains]] [1237] = {},
	--[[Searing Gorge]] [1220] = {},
	--[[Silverpine Forest]] [1211] = {},
	--[[Stranglethorn Vale]] [1238] = {},
	--[[Swamp of Sorrows]] [1239] = {},
	--[[The Hinterlands]] [1215] = {},
	--[[Tirisfal Glades]] [1210] = {},
	--[[Western Plaguelands]] [1212] = {},
	--[[Westfall]] [1240] = {},
	--[[Wetlands]] [1243] = {},

	----------------------------------------------------------------------
	-- Kalimdor
	----------------------------------------------------------------------

	--[[Ashenvale]] [1248] = {},
	--[[Azshara]] [1259] = {},
	--[[Darkshore]] [1247] = {},
	--[[Desolace]] [1251] = {},
	--[[Durotar]] [1194] = {},
	--[[Dustwallow Marsh]] [1253] = {},
	--[[Felwood]] [1260] = {},
	--[[Feralas]] [1252] = {},
	--[[Moonglade]] [1263] = {},
	--[[Mulgore]] [1200] = {},
	--[[Silithus]] [1264] = {},
	--[[Stonetalon Mountains]] [1250] = {},
	--[[Tanaris]] [1254] = {},
	--[[Teldrassil]] [1244] = {},
	--[[The Barrens]] [1202] = {},
	--[[Thousand Needles]] [1249] = {},
	--[[Un'Goro Crater]] [1261] = {},
	--[[Winterspring]] [1266] = {},
}

-- Create table to store revealed overlays
T.overlayTextures = {}

-- Function to refresh overlays (Blizzard_SharedMapDataProviders\MapExplorationDataProvider)
local function RefMap(self, fullUpdate)
	T.overlayTextures = {}
	local mapID = WorldMapFrame.mapID; if not mapID then return end
	local artID = C_Map.GetMapArtID(mapID); if not artID or not zones[artID] then return end
	local LeaMapsZone = zones[artID]

	-- Store already explored tiles in a table so they can be ignored
	local TileExists = {}
	local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(mapID)
	if exploredMapTextures then
		for i, exploredTextureInfo in ipairs(exploredMapTextures) do
			local key = exploredTextureInfo.textureWidth .. ":" .. exploredTextureInfo.textureHeight .. ":" .. exploredTextureInfo.offsetX .. ":" .. exploredTextureInfo.offsetY
			TileExists[key] = true
		end
	end

	-- Get the sizes
	self.layerIndex = self:GetMap():GetCanvasContainer():GetCurrentLayerIndex()
	local layers = C_Map.GetMapArtLayers(mapID)
	local layerInfo = layers and layers[self.layerIndex]
	if not layerInfo then return end
	local TILE_SIZE_WIDTH = layerInfo.tileWidth
	local TILE_SIZE_HEIGHT = layerInfo.tileHeight

	-- Show textures if they are in database and have not been explored
	for key, files in pairs(LeaMapsZone) do
		if not TileExists[key] then
			local width, height, offsetX, offsetY = strsplit(":", key)
			local fileDataIDs = { strsplit(",", files) }
			local numTexturesWide = ceil(width/TILE_SIZE_WIDTH)
			local numTexturesTall = ceil(height/TILE_SIZE_HEIGHT)
			local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight
			for j = 1, numTexturesTall do
				if ( j < numTexturesTall ) then
					texturePixelHeight = TILE_SIZE_HEIGHT
					textureFileHeight = TILE_SIZE_HEIGHT
				else
					texturePixelHeight = mod(height, TILE_SIZE_HEIGHT)
					if ( texturePixelHeight == 0 ) then
						texturePixelHeight = TILE_SIZE_HEIGHT
					end
					textureFileHeight = 16
					while(textureFileHeight < texturePixelHeight) do
						textureFileHeight = textureFileHeight * 2
					end
				end
				for k = 1, numTexturesWide do
					local texture = self.overlayTexturePool:Acquire()
					if ( k < numTexturesWide ) then
						texturePixelWidth = TILE_SIZE_WIDTH
						textureFileWidth = TILE_SIZE_WIDTH
					else
						texturePixelWidth = mod(width, TILE_SIZE_WIDTH)
						if ( texturePixelWidth == 0 ) then
							texturePixelWidth = TILE_SIZE_WIDTH
						end
						textureFileWidth = 16
						while(textureFileWidth < texturePixelWidth) do
							textureFileWidth = textureFileWidth * 2
						end
					end
					texture:SetSize(texturePixelWidth, texturePixelHeight)
					texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight)
					texture:SetPoint("TOPLEFT", offsetX + (TILE_SIZE_WIDTH * (k-1)), -(offsetY + (TILE_SIZE_HEIGHT * (j - 1))))
					texture:SetTexture(tonumber(fileDataIDs[((j - 1) * numTexturesWide) + k]), nil, nil, "TRILINEAR")
					texture:SetDrawLayer("ARTWORK", -1)
					if SavedOptionsPerChar.FogOfWar == true then
						texture:Show()
					else
						texture:Hide()
					end
					tinsert(T.overlayTextures, texture)
					if fullUpdate then
						self.textureLoadGroup:AddTexture(texture)
					end
				end
			end
		end
	end
end

-- Show overlays on startup
for pin in WorldMapFrame:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
	hooksecurefunc(pin, "RefreshOverlays", function() RefMap(pin, fullUpdate) end)
end