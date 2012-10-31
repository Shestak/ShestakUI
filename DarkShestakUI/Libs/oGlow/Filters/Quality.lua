local quality = function(...)
	local quality = -1

	for i = 1, select("#", ...) do
		local itemLink = select(i, ...)

		if itemLink then
			local _, _, itemQuality = GetItemInfo(itemLink)

			if itemQuality then
				quality = math.max(quality, itemQuality)
			end
		end
	end

	if quality > 1 then
		return quality
	end
end

oGlow:RegisterFilter("Quality border", "Border", quality, [[Adds a border to the icons, indicating the quality the items have.]])