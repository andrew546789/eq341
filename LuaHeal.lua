local mq = require('mq')

local function main()
-- put memspellset here
	local tank = "jabopie"
	--mq.TLO.target
	print("starting mac")
--start following tank here

	--while loop to heal and do stuff
	while 1 do 
		if mq.TLO.me.CombatState.Equal[ACTIVE] then
			if mq.TLO.me.PctMana < 100 then
				rest()
				end
			end
		if mq.TLO.me.PctMana > 10 then
			heal()
			if (mq.TLO.me.PctMana >= 50) and (mq.TLO.Target.PctHPs >=) then
				buff()
				end
			mq.delay(3000)
			end
		else
			rest()
			end
		end
	end
	
			
local function heal()
	if mq.TLO.Target.PctHPs >= 90 then
		print("health is good. it is" + mq.TLO.Target.PctHPs)
		end
	else
		print("healing because health is" + mq.TLO.Target.PctHPs)
		--cast healing
		end
	end

local function rest()
	--turn follow off
	--sit
	while mq.TLO.me.PctMana < 99
		if (mq.TLO.Target.PctHPs < 50) and (mq.TLO.me.PctMana > 10) then
			heal()
			end
		mq.delay(3000)
		end
	--stand
	--continue following
	end

local function buff()
	if (not mq.TLO.Target.Distance < 30 ) --${Target.Buff[Strength].ID}-- ) and
		print("buffing")
		--cast buff
		end
	end

local terminate = false
mq.bind('/assend', function() terminate = true end)

if not terminate
    main()
    mq.delay(1000) -- equivalent to '1s'
end