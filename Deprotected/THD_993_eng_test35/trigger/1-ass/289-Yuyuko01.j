function Trig_Yuyuko01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A05D'
endfunction

function Trig_Yuyuko01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n04K', ox, oy, 0.0)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 17 - 3 * level)
    call UnitAddAbility(u, 'A0UN')
    call SetUnitAbilityLevel(u, 'A0UN', GetUnitAbilityLevel(caster, 'A05D'))
    call IssuePointOrder(u, "carrionswarm", tx, ty)
    set u = null
    set caster = null
endfunction

function InitTrig_Yuyuko01 takes nothing returns nothing
endfunction