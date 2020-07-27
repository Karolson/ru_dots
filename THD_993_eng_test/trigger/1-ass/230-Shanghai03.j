function Trig_Shanghai03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HN'
endfunction

function Trig_Shanghai03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    if GetWidgetLife(caster) < 0.405 or GetUnitAbilityLevel(caster, 'B044') == 0 then
        call UnitRemoveAbility(caster, 'Aeth')
        call SetUnitFlyHeight(caster, 45.0, 50.0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Shanghai03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    if GetUnitAbilityLevel(caster, 'A0HG') > 0 then
        call DisableTrigger(gg_trg_Shanghai01)
        call IssueImmediateOrder(caster, "undefend")
        call UnitRemoveAbility(caster, 'A0HH')
        call EnableTrigger(gg_trg_Shanghai01)
    endif
    call UnitAddAbility(caster, 'Aeth')
    call SetUnitFlyHeight(caster, GetRandomReal(0, 130.0), 50.0)
    set t = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
    call TimerStart(t, 0.2, true, function Trig_Shanghai03_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Shanghai03 takes nothing returns nothing
endfunction