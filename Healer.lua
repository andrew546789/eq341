--Healer code by Seth Vossler, Andrew Vossler and Hayden Cahill
local mq = require('mq')
function main()
    mq.cmd("/memspellset lvl20")
    local tank = "Forknight"
    local dps ="Forknight"
    local count = 0
    local bufdefSpel="Protect"
    local bufatkSpel="Burst Of Strength"
    local atacSpel = "Spirit Strike"
    local helSpel = "Healing"
    local lhelSpel = "Light Healing"
    local debSpel = "Walking Sleep"
    mq.cmd("/target "..tank)
    print("starting mac")

    --while loop to heal and do stuff
    while 1 do 
        mq.cmd("/afollow off")
        local order= count % 2
        if( order== 0)then 
            mq.cmd("/target "..tank)
        else
            mq.cmd("/target "..dps)
        end
        mq.cmd("/follow")
        pctHps = tonumber(mq.TLO.Target.PctHPs())
        pctMana = tonumber(mq.TLO.Me.PctMana())
        print(mq.TLO.Me.XTarget())
        if (mq.TLO.Me.XTarget() <=0) and pctMana < 100 then
            rest(pctHps, pctMana)
        end
        if pctMana > 10 then
            heal(helSpel,lhelSpel)
            if (pctMana >= 50) and (pctHPs >= 90) then
                buff(bufdefSpel,bufatkSpel)
            end
            mq.delay(3000)
        else
            rest(pctHps, pctMana, helSpel)
        end
        if((mq.TLO.Me.XTarget() >0) and (pctMana >=50)) then
            hurt(debSpel,atacSpel)
        end
        count= count+1



    end
end

-- heal function (will be the main called function at 50 mana)
function heal(helSpel,lhelSpel)

    pctHPs = tonumber(mq.TLO.Target.PctHPs())
    if pctHPs >= 90 then
        print("health is good. it is"..pctHPs)
    else
        print("healing because health is"..pctHPs)
	if pctHPs <= 75 then
	mq.cmd("/cast ".. helSpel)
	else
        mq.cmd("/cast ".. lhelSpel)
	end
    end
end

--sits the healer down outside of combat (in combat is sit wait 5 sec, stand)
function rest(pctHPs, pctMana ,helSpel ,lhelSpel)
    mq.cmd("/afollow off")
    mq.cmd("/sit")
    while (pctMana < 99) and (mq.TLO.Me.XTarget() <=0) do
    print("resting")
        if (pctHPs < 50) and (pctMana > 10) then
            heal(helSpel,lhelSpel)
        end
        mq.delay(5000)
    pctMana = mq.TLO.Me.PctMana()
    pctHps = tonumber(mq.TLO.Target.PctHPs())
    end
print("standing up")
mq.cmd("/stand")
mq.cmd("/follow")
end

-- casts a long term and short term buf if the target lacks either
function buff(bufdefSpel,bufatkSpel)
    if (mq.TLO.Target.Distance() < 30 ) then
        if not (mq.TLO.Target.Buff[Protect].ID()) then
    	    print("buffing def")
            mq.cmd("/cast "..bufdefSpel)
            mq.delay(6500)
        end
        if not (mq.TLO.Target.Buff("Burst Of Strength").ID()) then
    	    print("buffing atk")
            mq.cmd("/cast "..bufatkSpel)
            mq.delay(1000)
        end
    end
end
--targets the allies target, debuffs the enemy and casts an attack spell for it
function hurt(debSpel, atacSpel)
    print()
    mq.cmd("/assist")
    mq.cmd("/cast ".. debSpel)
    mq.delay(3500)
    mq.cmd("/cast ".. atacSpel)
    mq.delay(3000)
end
local terminate = false
mq.bind('/assend', function() terminate = true end)

if not terminate then
    main()
    mq.delay(1000) -- equivalent to '1s'
end

