function Trig_ReisenN04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1GT'
endfunction

function Trig_ReisenN04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A1GT')
    local boolean tf
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer i
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 40 - 10 * level)
    call SaveInteger(udg_ht, GetHandleId(caster), 1, 4)
    call SaveReal(udg_ht, GetHandleId(caster), 2, ox)
    call SaveReal(udg_ht, GetHandleId(caster), 3, oy)
    call SaveUnitHandle(udg_ht, GetHandleId(caster), 4, caster)
    call SaveUnitHandle(udg_ht, GetHandleId(caster), 5, GetSpellTargetUnit())
    set u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 270.0)
    set i = 0
    call UnitAddAbility(u, 'A1GY')
    call SetUnitAbilityLevel(u, 'A1GY', 2)
    set tf = IssueTargetOrderById(u, 852274, caster)
    call UnitRemoveAbility(u, 'A1GY')
    call ReleaseDummy(u)
    set caster = null
    set u = null
endfunction

function InitTrig_ReisenN04 takes nothing returns nothing
endfunction