function Trig_Satori03_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        return GetUnitAbilityLevel(GetSummonedUnit(), 'B04N') > 0
    endif
    if GetSpellAbilityId() == 'A0VX' then
        call DebugMsg("Active Satori03")
        return true
    endif
    return false
endfunction

function Trig_Satori03_Loop takes nothing returns nothing
    local timer t2 = GetExpiredTimer()
    local integer task
    local integer task2 = GetHandleId(t2)
    local unit caster = LoadUnitHandle(udg_ht, task2, 0)
    local unit target = LoadUnitHandle(udg_ht, task2, 1)
    local integer i = LoadInteger(udg_ht, task2, 2)
    local integer level
    local unit u
    if i > 0 then
        set level = GetUnitAbilityLevel(caster, 'A0VX')
        set u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0.0)
        call UnitAddAbility(u, 'A0J0')
        call SetUnitAbilityLevel(u, 'A0J0', level)
        set task = GetHandleId(u)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call IssueTargetOrderById(u, 852274, target)
        call DebugMsg("Satori03")
        set i = i - 1
        call SaveInteger(udg_ht, task2, 2, i)
    else
        call ReleaseTimer(t2)
        call FlushChildHashtable(udg_ht, task2)
    endif
    set t2 = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Satori03_Actions takes nothing returns nothing
    local unit caster
    local unit target
    local unit u
    local real ox
    local real oy
    local real dx
    local real dy
    local real a
    local real d
    local integer task
    local integer level
    local timer t2
    local integer task2
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        if GetSpellAbilityId() == 'A0VX' then
            set caster = GetTriggerUnit()
            set target = GetSpellTargetUnit()
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 16 - 1.5 * GetUnitAbilityLevel(caster, 'A0VX'))
            if IsUnitEnemy(GetSpellTargetUnit(), GetTriggerPlayer()) then
                if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
                    call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
                    set caster = null
                    set target = null
                    set u = null
                    set t2 = null
                    return
                endif
            endif
            set level = GetUnitAbilityLevel(caster, 'A0VX')
            call UnitAddAbility(caster, 'A1CI')
            set u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0.0)
            call UnitAddAbility(u, 'A0J0')
            call SetUnitAbilityLevel(u, 'A0J0', level)
            set task = GetHandleId(u)
            call SaveUnitHandle(udg_ht, task, 0, caster)
            call SaveUnitHandle(udg_ht, task, 1, target)
            call IssueTargetOrderById(u, 852274, target)
            call DebugMsg("Satori03")
            set t2 = CreateTimer()
            set task2 = GetHandleId(t2)
            call SaveUnitHandle(udg_ht, task2, 0, caster)
            call SaveUnitHandle(udg_ht, task2, 1, target)
            call SaveInteger(udg_ht, task2, 2, 2)
            call TimerStart(t2, 0.33, true, function Trig_Satori03_Loop)
        endif
    else
        set u = GetSummoningUnit()
        set task = GetHandleId(u)
        set caster = LoadUnitHandle(udg_ht, task, 0)
        set target = LoadUnitHandle(udg_ht, task, 1)
        set level = GetUnitAbilityLevel(caster, 'A0VX')
        call FlushChildHashtable(udg_ht, task)
        call UnitRemoveAbility(u, 'A0J0')
        call ReleaseDummy(u)
        set u = GetSummonedUnit()
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        set dx = GetUnitX(target) - ox
        set dy = GetUnitY(target) - oy
        set a = Atan2(dy, dx)
        set d = 80.0
        call SetUnitFacingTimed(u, bj_RADTODEG * a, 0.05)
        call UnitAddAbility(u, 'Aloc')
        call SetUnitX(u, GetUnitX(target) - d * Cos(a))
        call SetUnitY(u, GetUnitY(target) - d * Sin(a))
        if GetUnitAbilityLevel(caster, 'A1CI') > 0 then
            call UnitRemoveAbility(caster, 'A1CI')
            call UnitPhysicalDamageTarget(caster, target, (20 + 10 * level + GetUnitAttack(target) * (0.3 + level * 0.1)) * 3)
        endif
        call SetUnitAnimation(u, "Attack")
    endif
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Satori03_Learn takes nothing returns boolean
    if GetLearnedSkill() == 'A0VX' then
        call DestroyTrigger(gg_trg_Satori03)
        set gg_trg_Satori03 = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(gg_trg_Satori03, GetOwningPlayer(GetTriggerUnit()), EVENT_PLAYER_UNIT_SUMMON, null)
        call TriggerRegisterUnitEvent(gg_trg_Satori03, GetTriggerUnit(), EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(gg_trg_Satori03, Condition(function Trig_Satori03_Conditions))
        call TriggerAddAction(gg_trg_Satori03, function Trig_Satori03_Actions)
    endif
    return false
endfunction

function InitTrig_Satori03 takes nothing returns nothing
endfunction