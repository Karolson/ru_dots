function Trig_StrAgi04_Star_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0UP'
endfunction

function Trig_StrAgi04_Star_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local integer cnt = LoadInteger(udg_ht, task, 2) + 1
    call SaveInteger(udg_ht, task, 2, cnt)
    call ClearAllNegativeBuff(caster, false)
    call UnitRemoveAbility(caster, 'A0A1')
    call UnitRemoveAbility(caster, 'A0V4')
    call SetUnitVertexColor(caster, 255, 255, R2I(150 - Sin(cnt * 3.6 * 0.017454) * 150), 255)
    call DebugMsg(I2S(GetUnitAbilityLevel(caster, 'A17X')))
    if cnt >= 500 then
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call SetUnitPathing(caster, true)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_StrAgi04_Star_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveInteger(udg_ht, task, 2, 0)
    call TimerStart(t, 0.01, true, function Trig_StrAgi04_Star_Main)
    call SetUnitPathing(caster, false)
    call UnitBuffTarget(caster, caster, 5, 'A17X', 'B097')
    set t = null
    set caster = null
endfunction

function InitTrig_StrAgi04_Star takes nothing returns nothing
    set gg_trg_StrAgi04_Star = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StrAgi04_Star, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_StrAgi04_Star, Condition(function Trig_StrAgi04_Star_Conditions))
    call TriggerAddAction(gg_trg_StrAgi04_Star, function Trig_StrAgi04_Star_Actions)
endfunction