local T, C, L = unpack(select(2, ...))
if not C.raidcooldown.enable == true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.raid_spells = {
	[20484] = 600,	-- Rebirth
	[6203] = 1800,	-- Soulstone
	[6346] = 180,	-- Fear Ward
	[29166] = 180,	-- Innervate
	[32182] = 300,	-- Heroism
	[2825] = 300,	-- Bloodlust
}