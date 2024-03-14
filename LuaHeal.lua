local mq = require('mq')

local function main()
-- put memspellset here
	local tank = "jabopie"
	--mq.TLO.target
	print("starting mac")
--start following tank here

	--while loop to heal and do stuff
	while 1 do 
		if mq.TLO.Me.CombatState.Equal[ACTIVE] then
			if mq.TLO.Me.PctMana() < 100 then
				rest()
			end
		end
		if mq.TLO.Me.PctMana() > 10 then
			heal()
			if (mq.TLO.Me.PctMana() >= 50) and (mq.TLO.Target.PctHPs() >= 90) then
				buff()
			end
			mq.delay(3000)
		else
			rest()
		end
	end
end

	
			
local function heal()
	if mq.TLO.Target.PctHPs() >= 90 then
		print("health is good. it is" + mq.TLO.Target.PctHPs())
	else
		print("healing because health is" + mq.TLO.Target.PctHPs())
		--cast healing
	end
	return 0
end

local function rest()
	--turn follow off
	--sit
	while mq.TLO.Me.PctMana() < 99 do
		if (mq.TLO.Target.PctHPs() < 50) and (mq.TLO.Me.PctMana() > 10) then
			heal()
		end
		mq.delay(3000)
	end
	--stand
	--continue following
	return 0
end

local function buff()
	if (not mq.TLO.Target.Distance() < 30 ) then --mq.TLO.Target.Buff[Strength].ID--
		print("buffing")
		--cast buff
	end
	return 0
end

local terminate = false
mq.bind('/assend', function() terminate = true end)

if not terminate then
    main()
    mq.delay(1000) -- equivalent to '1s'
end