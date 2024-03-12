local mq = require('mq')

local function main()
-- put memspellset here
	local tank = "jabopie"
	print("starting mac")
--start following tank here

	--while loop to heal and do stuff
	while 1 do 
		if --active combat state
			if mq.TLO.me.PctMana < 100--i think
				rest()
		if mq.TLO.me.PctMana > 10
			heal()
			if (mq.TLO.me.PctMana >= 50) and (mq.TLO.Target.PctHPs >=)
				buff()
			mq.delay(3000)
		else
			rest()
	return
			
local function heal()
	if mq.TLO.Target.PctHPs >= 90
		print("health is good. it is" + mq.TLO.Target.PctHPs)
	else
		print("healing because health is" + mq.TLO.Target.PctHPs)
		--cast healing
	return

local function rest()
	--turn follow off
	--sit
	while mq.TLO.me.PctMana < 99
		if (mq.TLO.Target.PctHPs < 50) and (mq.TLO.me.PctMana > 10)
			heal()
		mq.delay(3000)
	--stand
	--continue following
	return

local function buff()
	if (not --${Target.Buff[Strength].ID}-- ) and --${Target.Distance}-- < 30 )
		print("buffing")
		--cast buff
	return

local terminate = false
mq.bind('/assend', function() terminate = true end)

if not terminate
    main()
    mq.delay(1000) -- equivalent to '1s'
end