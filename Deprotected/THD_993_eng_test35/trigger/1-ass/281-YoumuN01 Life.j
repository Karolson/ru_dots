function Trig_YoumuN01_Life_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_DEAD) or GetUnitAbilityLevel(GetTriggerUnit(), 'A1GM') == 0 then
        return false
    endif
    return GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) > 0 and GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) / GetUnitState(GetTriggerUnit(), UNIT_STATE_MAX_LIFE) <= 0.2
endfunction

function Trig_YoumuN01_Return takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h = LoadUnitHandle(udg_ht, task, 1)
    call UnitAddAbility(h, 'A1GM')
    call FlushChildHashtable(udg_ht, task)
    set h = null
    set t = null
endfunction

function Trig_YoumuN01_Life_Actions takes nothing returns nothing
    local unit h = GetTriggerUnit()
    local unit u = NewDummy(GetOwningPlayer(h), GetUnitX(h), GetUnitY(h), 0)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call UnitAddAbility(u, 'A0DJ')
    call IssueImmediateOrderById(u, 852285)
    call UnitRemoveAbility(u, 'A0DJ')
    call ReleaseDummy(u)
    call UnitBuffTarget(h, h, 1.0, 0, 'Bspe')
    call ClearAllNegativeBuff(u, false)
    call SaveUnitHandle(udg_ht, task, 1, h)
    call TimerStart(t, 60.0, false, function Trig_YoumuN01_Return)
    call UnitRemoveAbility(h, 'A1GM')
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", h, "origin"))
    set h = null
    set u = null
    set t = null
endfunction

function InitTrig_YoumuN01_Life takes nothing returns nothing
endfunction