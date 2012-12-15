local error = function(...) print("|cffff0000Error:|r "..string.format(...)) end

local pipesTable = {}
local filtersTable = {}
local displaysTable = {}

local numPipes = 0
local numFilters = 0

local activeFilters = {}

local event_metatable = {
	__call = function(funcs, self, ...)
		for _, func in pairs(funcs) do
			func(self, ...)
		end
	end,
}

local oGlow = CreateFrame("Frame", "oGlow")

function oGlow:ADDON_LOADED(event, addon)
	if addon == "ShestakUI" then
		for pipe in next, pipesTable do
			self:EnablePipe(pipe)

			for filter in next, filtersTable do
				self:RegisterFilterOnPipe(pipe, filter)
			end
		end

		self:UnregisterEvent(event, self.ADDON_LOADED)
	end
end

-- Event API
local RegisterEvent = oGlow.RegisterEvent
function oGlow:RegisterEvent(event, func)
	if type(func) == "string" and type(self[func]) == "function" then
		func = self[func]
	end

	local curev = self[event]
	if curev and func then
		if type(curev) == "function" then
			self[event] = setmetatable({curev, func}, event_metatable)
		else
			for _, infunc in next, curev do
				if infunc == func then return end
			end

			table.insert(curev, func)
		end
	elseif self:IsEventRegistered(event) then
		return
	else
		if func then
			self[event] = func
		elseif not self[event] then
			return error("Handler for event [%s] does not exist.", event)
		end

		RegisterEvent(self, event)
	end
end

local UnregisterEvent = oGlow.UnregisterEvent
function oGlow:UnregisterEvent(event, func)
	local curev = self[event]
	if type(curev) == "table" and func then
		for k, infunc in next, curev do
			if infunc == func then
				curev[k] = nil

				if #curev == 0 then
					table.remove(curev, k)
					UnregisterEvent(self, event)
				end

				break
			end
		end
	else
		self[event] = nil
		UnregisterEvent(self, event)
	end
end

oGlow:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)

-- Pipe API
function oGlow:RegisterPipe(pipe, enable, disable, update, name)
	if pipesTable[pipe] then
		return nil, string.format("Pipe [%s] is already registered.")
	else
		numPipes = numPipes + 1

		pipesTable[pipe] = {
			enable = enable;
			disable = disable;
			name = name;
			update = update;
		}
	end

	return true
end

do
	local function iter(_, n)
		local n, t = next(pipesTable, n)
		if t then
			return n, t.isActive, t.name
		end
	end

	function oGlow.IteratePipes()
		return iter, nil, nil
	end
end

function oGlow:EnablePipe(pipe)
	local ref = pipesTable[pipe]
	if ref and not ref.isActive then
		ref.enable(self)
		ref.isActive = true

		return true
	end
end

function oGlow:DisablePipe(pipe)
	local ref = pipesTable[pipe]
	if ref and ref.isActive then
		if ref.disable then ref.disable(self) end
		ref.isActive = nil

		return true
	end
end

function oGlow:IsPipeEnabled(pipe)
	return pipesTable[pipe].isActive
end

function oGlow:UpdatePipe(pipe)
	local ref = pipesTable[pipe]
	if ref and ref.isActive then
		ref.update(self)

		return true
	end
end

function oGlow:GetNumPipes()
	return numPipes
end

-- Filter API
function oGlow:RegisterFilter(name, type, filter)
	if filtersTable[name] then return nil, "Filter function is already registered." end
	filtersTable[name] = {type, filter, name}

	numFilters = numFilters + 1

	return true
end

do
	local function iter(_, n)
		local n, t = next(filtersTable, n)
		if t then
			return n, t[1], t[4]
		end
	end

	function oGlow.IterateFilters()
		return iter, nil, nil
	end
end

function oGlow:RegisterFilterOnPipe(pipe, filter)
	if not pipesTable[pipe] then return nil, "Pipe does not exist." end
	if not filtersTable[filter] then return nil, "Filter does not exist." end

	if not activeFilters[pipe] then
		local filterTable = filtersTable[filter]
		local display = filterTable[1]
		activeFilters[pipe] = {}
		activeFilters[pipe][display] = {}
		table.insert(activeFilters[pipe][display], filterTable)
	else
		local filterTable = filtersTable[filter]
		local ref = activeFilters[pipe][filterTable[1]]

		for _, func in next, ref do
			if func == filter then
				return nil, "Filter function is already registered."
			end
		end
		table.insert(ref, filterTable)
	end
	return true
end

-- Display API
function oGlow:RegisterDisplay(name, display)
	displaysTable[name] = display
end

-- General API
function oGlow:CallFilters(pipe, frame, ...)
	if not pipesTable[pipe] then return nil, "Pipe does not exist." end

	local ref = activeFilters[pipe]
	if ref then
		for display, filters in next, ref do
			if not displaysTable[display] then return nil, "Display does not exist." end

			for i = 1, #filters do
				local func = filters[i][2]

				if (displaysTable[display](frame, func(...))) then break end
			end
		end
	end
end

oGlow:RegisterEvent("ADDON_LOADED")