function Trig_Power_Lost_Conditions takes nothing returns boolean
    if IsUnitIllusion(GetTriggerUnit()) then
        return false
    endif
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Power_Lost_Actions takes nothing returns nothing
    local unit h = GetTriggerUnit()
    local player who = GetOwningPlayer(h)
    local real x = GetUnitX(h)
    local real y = GetUnitY(h)
    local integer i = GetPlayerId(who) + 1
    local integer d = IMinBJ(udg_PlayerPower[i], 10)
    local integer c = LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'PRIM')
    set udg_PlayerPower[i] = udg_PlayerPower[i] - d
    if c == 1 then
        call SetHeroStr(h, GetHeroStr(h, false) - d, true)
    elseif c == 2 then
        call SetHeroAgi(h, GetHeroAgi(h, false) - d, true)
    elseif c == 3 then
        call SetHeroInt(h, GetHeroInt(h, false) - d, true)
    endif
    set d = d / 2
    loop
    exitwhen d <= 0
        call CreateItem('I03H', x, y)
        set d = d - 1
    endloop
    set h = null
    set who = null
endfunction

function InitTrig_Power_Lost takes nothing returns nothing
    set gg_trg_Power_Lost = CreateTrigger()
    call TriggerAddCondition(gg_trg_Power_Lost, Condition(function Trig_Power_Lost_Conditions))
    call TriggerAddAction(gg_trg_Power_Lost, function Trig_Power_Lost_Actions)
endfunction