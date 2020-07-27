function Trig_ReisenN01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1GR'
endfunction

function Trig_ReisenN01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A1GR')
    local boolean tf
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer i
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 21 - 2 * level)
    call SaveInteger(udg_ht, GetHandleId(caster), 1, 3)
    call SaveReal(udg_ht, GetHandleId(caster), 2, GetSpellTargetX())
    call SaveReal(udg_ht, GetHandleId(caster), 3, GetSpellTargetY())
    set u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 270.0)
    call UnitAddAbility(u, 'A1GZ')
    call SetUnitAbilityLevel(u, 'A1GZ', level)
    call IssueTargetOrder(u, "invisibility", caster)
    set i = 0
    call UnitAddAbility(u, 'A1GY')
    call SetUnitAbilityLevel(u, 'A1GY', 1)
    set tf = IssueTargetOrderById(u, 852274, caster)
    call UnitRemoveAbility(u, 'A1GZ')
    call UnitRemoveAbility(u, 'A1GY')
    call ReleaseDummy(u)
    set caster = null
    set u = null
endfunction

function InitTrig_ReisenN01 takes nothing returns nothing
endfunction