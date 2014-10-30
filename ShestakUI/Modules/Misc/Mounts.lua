----------------------------------------------------------------------------------------
--	Universal Mount macro(by Monolit)
--	/run Mountz("your_ground_mount","your_flying_mount","your_underwater_mount")
----------------------------------------------------------------------------------------
function Mountz(groundmount, flyingmount, underwatermount)
	local flyablex, swimablex, vjswim, InVj, nofly
	local num = C_MountJournal.GetNumMounts()
	if not num or IsMounted() then
		Dismount()
		return
	end
	if CanExitVehicle() then
		VehicleExit()
		return
	end
	if IsUsableSpell(59569) == nil then
		nofly = true
	end
	if not nofly and (IsFlyableArea() and GetCurrentMapContinent() ~= 7) then
		flyablex = true
	end
	for i = 1, 40 do
		local sid = select(11, UnitBuff("player", i))
		if sid == 73701 or sid == 76377 then
			InVj = true
		end
	end
	if InVj and IsSwimming() then
		vjswim = true
	end
	if IsSwimming() and (nofly or GetCurrentMapContinent() == 7) and not vjswim then
		swimablex = true
	end
	if IsControlKeyDown() then
		if not vjswim then
			flyablex = not flyablex
		else
			vjswim = not vjswim
		end
	end
	for i = 1, num, 1 do
		local info, id = C_MountJournal.GetMountInfo(i)
		if flyingmount and info == flyingmount and flyablex and not swimablex then
			C_MountJournal.Summon(i)
			return
		elseif groundmount and info == groundmount and not flyablex and not swimablex and not vjswim then
			C_MountJournal.Summon(i)
			return
		elseif underwatermount and info == underwatermount and swimablex then
			C_MountJournal.Summon(i)
			return
		elseif id == 75207 and vjswim then
			C_MountJournal.Summon(i)
			return
		end
	end
end