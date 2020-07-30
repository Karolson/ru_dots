function Trig_Shikieiki04_Conditions takes nothing returns boolean
    local unit u = GetSpellTargetUnit()
    local unit v = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(v, 'A00K')
    if GetSpellAbilityId() != 'A00K' then
        set u = null
        set v = null
        return false
    elseif IsUnitIllusion(u) then
        call UnitDebuffTarget(v, u, 1.5 + I2R(level) * 2.5, 1, true, 'A00W', level, 'Bprg', "purge", 0, "")
        call CCSystem_textshow("Slow", u, DebuffDuration(u, 1.5 + I2R(level) * 2.5))
        set u = null
        set v = null
        return false
    elseif not IsUnitType(u, UNIT_TYPE_HERO) then
        set u = null
        set v = null
        return false
    endif
    if IsUnitEnemy(u, GetOwningPlayer(v)) then
        set u = null
        set v = null
        return true
    endif
    set u = null
    set v = null
    return false
endfunction

function Trig_Shikieiki04_Damage takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real damage
    local integer level = LoadInteger(udg_ht, task, 0)
    local triggeraction tga
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        set damage = (3.5 - level * 0.5) * GetEventDamage()
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) - damage)
    elseif GetTriggerEventId() == EVENT_UNIT_DEATH then
        set tga = LoadTriggerActionHandle(udg_ht, task, 3)
        call FlushChildHashtable(udg_ht, task)
        call TriggerRemoveAction(trg, tga)
        call DestroyTrigger(trg)
    endif
    set u = null
    set trg = null
    set tga = null
endfunction

function Trig_Shikieiki04_Main_Action takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = GetSummonedUnit()
    local integer level = LoadInteger(udg_ht, task, 0)
    local triggeraction tga = LoadTriggerActionHandle(udg_ht, task, 3)
    call FlushChildHashtable(udg_ht, task)
    call TriggerRemoveAction(trg, tga)
    call DestroyTrigger(trg)
    call UnitAddAbility(u, 'A08V')
    set trg = CreateTrigger()
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DEATH)
    set tga = TriggerAddAction(trg, function Trig_Shikieiki04_Damage)
    set task = GetHandleId(trg)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveTriggerActionHandle(udg_ht, task, 3, tga)
    call DebugMsg("four seasons 04")
    set caster = null
    set target = null
    set u = null
    set trg = null
    set tga = null
endfunction

function Trig_Shikieiki04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A00K')
    local unit u = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0)
    local trigger trg = CreateTrigger()
    local triggeraction tga = TriggerAddAction(trg, function Trig_Shikieiki04_Main_Action)
    local integer task
    call UnitDebuffTarget(caster, target, 1.5 + I2R(level) * 2.5, 1, true, 'A00W', level, 'Bprg', "purge", 0, "")
    call CCSystem_textshow("Slow", target, DebuffDuration(target, 1.5 + I2R(level) * 2.5))
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A00K', 85 - 10 * level)
    else
        call AbilityCoolDownResetion(caster, 'A00K', (85 - 10 * level) * 0.8)
    endif
    call VE_Spellcast(caster)
    call Trig_Shikieiki01_Debuff_Add(caster, target, 330.0)
    call Trig_Shikieiki01_Debuff_Add(caster, target, 330.0)
    call CE_Input(caster, target, 200)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_SUMMON)
    set task = GetHandleId(trg)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveTriggerActionHandle(udg_ht, task, 3, tga)
    call UnitAddAbility(u, 'A0BG')
    call SetUnitAbilityLevel(u, 'A0BG', 1)
    call IssueTargetOrderById(u, 852274, target)
    call UnitRemoveAbility(u, 'A0BG')
    call ReleaseDummy(u)
    set caster = null
    set target = null
    set u = null
    set trg = null
    set tga = null
endfunction

function InitTrig_Shikieiki04 takes nothing returns nothing
endfunction