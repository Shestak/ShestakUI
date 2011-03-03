local _VERSION = GetAddOnMetadata('ShestakUI', 'version')

local function argcheck(value, num, ...)
	assert(type(num) == 'number', "Bad argument #2 to 'argcheck' (number expected, got "..type(num)..")")

	for i=1,select("#", ...) do
		if type(value) == select(i, ...) then return end
	end

	local types = strjoin(", ", ...)
	local name = string.match(debugstack(2,2,0), ": in function [`<](.-)['>]")
	error(("Bad argument #%d to '%s' (%s expected, got %s"):format(num, name, types, type(value)), 3)
end

local print = function(...) print("|cff33ff99oGlow:|r ", ...) end
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

local oGlow = CreateFrame('Frame', 'oGlow')

function oGlow:ADDON_LOADED(event, addon)
	if(addon == 'ShestakUI') then
		for pipe in next, pipesTable do
			self:EnablePipe(pipe)

			for filter in next, filtersTable do
				self:RegisterFilterOnPipe(pipe, filter)
			end
		end

		self:UnregisterEvent(event, self.ADDON_LOADED)
	end
end

--[[ Event API ]]

local RegisterEvent = oGlow.RegisterEvent
function oGlow:RegisterEvent(event, func)
	argcheck(event, 2, 'string')

	if(type(func) == 'string' and type(self[func]) == 'function') then
		func = self[func]
	end

	local curev = self[event]
	if(curev and func) then
		if(type(curev) == 'function') then
			self[event] = setmetatable({curev, func}, event_metatable)
		else
			for _, infunc in next, curev do
				if(infunc == func) then return end
			end

			table.insert(curev, func)
		end
	elseif(self:IsEventRegistered(event)) then
		return
	else
		if(func) then
			self[event] = func
		elseif(not self[event]) then
			return error("Handler for event [%s] does not exist.", event)
		end

		RegisterEvent(self, event)
	end
end

local UnregisterEvent = oGlow.UnregisterEvent
function oGlow:UnregisterEvent(event, func)
	argcheck(event, 2, 'string')

	local curev = self[event]
	if(type(curev) == 'table' and func) then
		for k, infunc in next, curev do
			if(infunc == func) then
				curev[k] = nil

				if(#curev == 0) then
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

oGlow:SetScript('OnEvent', function(self, event, ...)
	return self[event](self, event, ...)
end)

--[[ Pipe API ]]

function oGlow:RegisterPipe(pipe, enable, disable, update, name, desc)
	argcheck(pipe, 2, 'string')
	argcheck(enable, 3, 'function')
	argcheck(disable, 4, 'function', 'nil')
	argcheck(update, 5, 'function')
	argcheck(name, 6, 'string', 'nil')
	argcheck(desc, 7, 'string', 'nil')

	-- Silently fail.
	if(pipesTable[pipe]) then
		return nil, string.format('Pipe [%s] is already registered.')
	else
		numPipes = numPipes + 1

		pipesTable[pipe] = {
			enable = enable;
			disable = disable;
			name = name;
			update = update;
			desc = desc;
		}
	end

	return true
end

do
	local function iter(_, n)
		local n, t = next(pipesTable, n)
		if(t) then
			return n, t.isActive, t.name, t.desc
		end
	end

	function oGlow.IteratePipes()
		return iter, nil, nil
	end
end

function oGlow:EnablePipe(pipe)
	argcheck(pipe, 2, 'string')

	local ref = pipesTable[pipe]
	if(ref and not ref.isActive) then
		ref.enable(self)
		ref.isActive = true

		return true
	end
end

function oGlow:DisablePipe(pipe)
	argcheck(pipe, 2, 'string')

	local ref = pipesTable[pipe]
	if(ref and ref.isActive) then
		if(ref.disable) then ref.disable(self) end
		ref.isActive = nil

		return true
	end
end

function oGlow:IsPipeEnabled(pipe)
	argcheck(pipe, 2, 'string')

	return pipesTable[pipe].isActive
end

function oGlow:UpdatePipe(pipe)
	argcheck(pipe, 2, 'string')

	local ref = pipesTable[pipe]
	if(ref and ref.isActive) then
		ref.update(self)

		return true
	end
end

function oGlow:GetNumPipes()
	return numPipes
end

--[[ Filter API ]]

function oGlow:RegisterFilter(name, type, filter, desc)
	argcheck(name, 2, 'string')
	argcheck(type, 3, 'string')
	argcheck(filter, 4, 'function')
	argcheck(desc, 5, 'string', 'nil')

	if(filtersTable[name]) then return nil, 'Filter function is already registered.' end
	filtersTable[name] = {type, filter, name, desc}

	numFilters = numFilters + 1

	return true
end

do
	local function iter(_, n)
		local n, t = next(filtersTable, n)
		if(t) then
			return n, t[1], t[4]
		end
	end

	function oGlow.IterateFilters()
		return iter, nil, nil
	end
end

-- TODO: Validate that the display we try to use actually exists.
function oGlow:RegisterFilterOnPipe(pipe, filter)
	argcheck(pipe, 2, 'string')
	argcheck(filter, 3, 'string')

	if(not pipesTable[pipe]) then return nil, 'Pipe does not exist.' end
	if(not filtersTable[filter]) then return nil, 'Filter does not exist.' end
	
	-- XXX: Clean up this logic.
	if(not activeFilters[pipe]) then
		local filterTable = filtersTable[filter]
		local display = filterTable[1]
		activeFilters[pipe] = {}
		activeFilters[pipe][display] = {}
		table.insert(activeFilters[pipe][display], filterTable)
	else
		local filterTable = filtersTable[filter]
		local ref = activeFilters[pipe][filterTable[1]]

		for _, func in next, ref do
			if(func == filter) then
				return nil, 'Filter function is already registered.'
			end
		end
		table.insert(ref, filterTable)
	end
	return true
end

oGlow.IterateFiltersOnPipe = function(pipe)
	local t = activeFilters[pipe]
	return coroutine.wrap(function()
		for _, sub in next, t do
			for k, v in next, sub do
				coroutine.yield(v[3], v[1], v[4])
			end
		end
	end)
end

function oGlow:UnregisterFilterOnPipe(pipe, filter)
	argcheck(pipe, 2, 'string')
	argcheck(filter, 3, 'string')

	if(not pipesTable[pipe]) then return nil, 'Pipe does not exist.' end
	if(not filtersTable[filter]) then return nil, 'Filter does not exist.' end

	--- XXX: Be more defensive here.
	local filterTable = filtersTable[filter]
	local ref = activeFilters[pipe][filterTable[1]]
	if(ref) then
		for k, func in next, ref do
			if(func == filterTable) then
				table.remove(ref, k)
				return true
			end
		end
	end
end

function oGlow:GetNumFilters()
	return numFilters
end

--[[ Display API ]]

function oGlow:RegisterDisplay(name, display)
	argcheck(name, 2, 'string')
	argcheck(display, 3, 'function')

	displaysTable[name] = display
end

--[[ General API ]]

function oGlow:CallFilters(pipe, frame, ...)
	argcheck(pipe, 2, 'string')

	if(not pipesTable[pipe]) then return nil, 'Pipe does not exist.' end

	local ref = activeFilters[pipe]
	if(ref) then
		for display, filters in next, ref do
			-- TODO: Move this check out of the loop.
			if(not displaysTable[display]) then return nil, 'Display does not exist.' end

			for i=1,#filters do
				local func = filters[i][2]

				-- drop out of the loop if we actually do something nifty on a frame.
				if(displaysTable[display](frame, func(...))) then break end
			end
		end
	end
end

oGlow:RegisterEvent('ADDON_LOADED')

oGlow.argcheck = argcheck

oGlow.version = _VERSION
