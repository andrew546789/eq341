local mq = require('mq')
function main()
-- put memspellset here
    local tank = "Grunk"
    local dps ="PatBenatar"
    local count = 0
    local bufSpel ="Strengthen"
    local atacSpel = "Burst of Flame"
    local helSpel = "Minor Healing"
    local debSpel = "Disempower"
    mq.cmd("/target "..tank)
    print("starting mac")
--start following tank here

    --while loop to heal and do stuff
    while 1 do 
        local order= count % 2
        if( order== 0)then 
            mq.cmd("/target "..tank)
        else
            mq.cmd("/target "..dps)
        end

        pctHps = tonumber(mq.TLO.Target.PctHPs())
        pctMana = mq.TLO.Me.PctMana()

        if mq.TLO.Me.CombatState.Equal[ACTIVE] then
            if pctMana < 100 then
                rest(pctHps, pctMana)
            end
        end
        if pctMana > 10 then
            heal(helSpel)
            if (pctMana >= 50) and (pctHPs >= 90) then
                buff(bufSpel)
            end
            mq.delay(3000)
        else
            rest()
        end
        if(mq.TLO.Me.XTarget() >0 and (pctMana >=50)) then
            hurt(debSpel,atacSpel)
        end
        count= count+1



    end
end
function heal(helSpel)

    pctHPs = tonumber(mq.TLO.Target.PctHPs())
    if pctHPs >= 90 then
        print("health is good. it is"..pctHPs)
    else
        print("healing because health is"..pctHPs)
        mq.cmd("/cast ".. helSpel)
    end
end
function rest(pctHPs, pctMana)
    --turn follow off
    mq.cmd("/sit")
    while pctMana < 99 do --STUCK IN LOOP HERE
        if (pctHPs < 50) and (pctMana > 10) then
            heal()
        end
        mq.delay(3000)
    end
    mq.cmd("/stand")
    --continue following
end
function buff(bufSpel)
    if (mq.TLO.Target.Distance() < 30 ) then --mq.TLO.Me.Target.Buff[Strength].ID ) and
        print("buffing")
        mq.cmd("/cast ".. bufSpel)

    end
end

function hurt(debSpel, atacSpel)
    print()
    mq.cmd("/assist")
    mq.cmd("/cast ".. debSpel)
    mq.delay(3000)
    mq.cmd("/cast ".. atacSpel)
end
local terminate = false
mq.bind('/assend', function() terminate = true end)

if not terminate then
    main()
    mq.delay(1000) -- equivalent to '1s'
end

