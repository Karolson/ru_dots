function RumiaSpeedUpAtNight takes nothing returns boolean
    local trigger trg = GetTriggeringTrigger()
    local unit hero = LoadUnitHandle(udg_Hashtable, GetHandleId(trg), 1)
    local integer level = GetUnitAbilityLevel(hero, 'A07G')
    if IsUnitType(hero, UNIT_TYPE_DEAD) then
        set trg = null
        set hero = null
        return false
    endif
    if GetUnitAbilityLevel(hero, 'A07I') == 0 then
        call UnitAddAbility(hero, 'A07I')
        call UnitMakeAbilityPermanent(hero, true, 'A07I')
        call UnitMakeAbilityPermanent(hero, true, 'A07H')
        call SetPlayerAbilityAvailable(GetOwningPlayer(hero), 'A07I', false)
    endif
    if (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) == false and GetUnitAbilityLevel(hero, 'A07H') != level * 2 then
        call SetUnitAbilityLevel(hero, 'A07H', level * 2)
    elseif (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) and GetUnitAbilityLevel(hero, 'A07H') != level then
        call SetUnitAbilityLevel(hero, 'A07H', level)
    endif
    set trg = null
    set hero = null
    return false
endfunction

function RumiaLearnSkillThreeConditions takes nothing returns boolean
    return GetLearnedSkill() == 'A07G'
endfunction

function RumiaLearnSkillThreeActions takes nothing returns nothing
    local trigger trg
    local unit u = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'A07G') != 1 or IsUnitIllusion(u) then
        set trg = null
        set u = null
        return
    endif
    call UnitAddAbility(u, 'A07I')
    call UnitMakeAbilityPermanent(u, true, 'A07I')
    call UnitMakeAbilityPermanent(u, true, 'A07H')
    call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A07I', false)
    set trg = CreateTrigger()
    call SaveUnitHandle(udg_Hashtable, GetHandleId(trg), 1, u)
    call TriggerRegisterTimerEvent(trg, 2, true)
    call TriggerRegisterGameStateEventTimeOfDay(trg, GREATER_THAN_OR_EQUAL, 6.0)
    call TriggerRegisterGameStateEventTimeOfDay(trg, LESS_THAN, 6.0)
    call TriggerRegisterGameStateEventTimeOfDay(trg, GREATER_THAN_OR_EQUAL, 18.0)
    call TriggerRegisterGameStateEventTimeOfDay(trg, LESS_THAN, 18.0)
    call TriggerAddCondition(trg, Condition(function RumiaSpeedUpAtNight))
    set trg = GetTriggeringTrigger()
    call DisableTrigger(trg)
    call DestroyTrigger(trg)
    set trg = null
    set u = null
endfunction

function InitTrig_Rumia03 takes nothing returns nothing
endfunction