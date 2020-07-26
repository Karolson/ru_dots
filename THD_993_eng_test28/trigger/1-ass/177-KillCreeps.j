function Trig_KillCreeps_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetTriggerUnit(), 'Aloc') == 0
endfunction

function Hero_Nearby_Filter takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and IsUnitAlly(GetFilterUnit(), bj_groupEnumOwningPlayer) and GetWidgetLife(GetFilterUnit()) > 0.405
endfunction

function Trig_KillCreeps_Actions takes nothing returns nothing
    local unit killer = GetKillingUnit()
    local unit death = GetTriggerUnit()
    local integer k = GetPlayerId(GetOwningPlayer(killer))
    local unit hero = GetPlayerCharacter(GetOwningPlayer(killer))
    local boolean ishero = IsUnitType(death, UNIT_TYPE_HERO)
    local group g = CreateGroup()
    local filterfunc f = Filter(function Hero_Nearby_Filter)
    local integer lvl = GetUnitLevel(death)
    local integer xp
    local integer i
    if not IsUnitInRange(death, hero, 1000.0) then
        set bj_groupEnumOwningPlayer = Player(k)
        call GroupEnumUnitsInRange(g, GetUnitX(death), GetUnitY(death), 1000.0, f)
        set bj_wantDestroyGroup = false
        set i = CountUnitsInGroup(g)
        if ishero then
            if lvl == 1 then
                set xp = 100
            elseif lvl == 2 then
                set xp = 120
            elseif lvl == 3 then
                set xp = 160
            elseif lvl == 4 then
                set xp = 220
            else
                set xp = 100 * (lvl - 2)
            endif
        else
            set xp = R2I(2.6 * lvl * lvl + 8.6 * lvl + 21.8)
        endif
        if i > 0 then
            set xp = R2I(xp / (i + 1))
        endif
        call AddHeroXP(hero, xp, true)
    endif
    call DestroyGroup(g)
    call DestroyFilter(f)
    if IsUnitAlly(death, GetOwningPlayer(killer)) == false then
        set udg_FlagFarm[k] = udg_FlagFarm[k] + 1
    else
        set udg_FlagTk[k] = udg_FlagTk[k] + 1
    endif
    set g = null
    set f = null
    set hero = null
    set killer = null
    set death = null
endfunction

function InitTrig_KillCreeps takes nothing returns nothing
    set gg_trg_KillCreeps = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_KillCreeps, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_KillCreeps, Condition(function Trig_KillCreeps_Conditions))
    call TriggerAddAction(gg_trg_KillCreeps, function Trig_KillCreeps_Actions)
endfunction