function TensiSkillThree2 takes nothing returns boolean
    local integer level
    local unit u = GetTriggerUnit()
    local trigger trg = GetTriggeringTrigger()
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        set level = GetUnitAbilityLevel(u, 'A073')
        if GetUnitAbilityLevel(u, 'B000') != 0 then
            call UnitGainMana(u, 7 + level * 2)
        else
            call UnitGainMana(u, 2 + level * 2)
        endif
    endif
    call DisableTrigger(trg)
    call DestroyTrigger(trg)
    set u = null
    set trg = null
    return false
endfunction

function TensiSkillThree1 takes nothing returns boolean
    local trigger t = GetTriggeringTrigger()
    local integer task = GetHandleId(t)
    local unit hero = LoadUnitHandle(udg_Hashtable, task, 1)
    local unit u = GetTriggerUnit()
    if u == hero then
        set t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, 2, false)
        call TriggerRegisterUnitEvent(t, hero, EVENT_UNIT_DAMAGED)
        call TriggerAddCondition(t, Condition(function TensiSkillThree2))
    endif
    set hero = null
    set t = null
    set u = null
    return false
endfunction

function Trig_Tensi03_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A073'
endfunction

function Trig_Tensi03_Actions takes nothing returns nothing
    local trigger t
    local integer task
    local unit u = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'A073') == 1 then
        call UnitAddAbility(u, 'A03R')
        set t = CreateTrigger()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_Hashtable, task, 1, u)
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(t, Condition(function TensiSkillThree1))
    else
        call SetUnitAbilityLevel(u, 'A03R', GetUnitAbilityLevel(u, 'A073'))
    endif
    set t = null
    set u = null
endfunction

function InitTrig_Tensi03 takes nothing returns nothing
endfunction