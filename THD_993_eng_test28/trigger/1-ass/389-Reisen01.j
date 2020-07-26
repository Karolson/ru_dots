function Trig_Reisen01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1B2'
endfunction

function Trig_Reisen01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1B2')
    local boolean tf
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx
    local real ty
    local integer i
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n00G', GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    set udg_ObjectsDoll = caster
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 21 - 2 * level)
    if udg_SK_Reisen01_Target != null then
        set tx = GetUnitX(udg_SK_Reisen01_Target)
        set ty = GetUnitY(udg_SK_Reisen01_Target)
        if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) > 800.0 + GetUnitAbilityLevel(caster, 'A069') * 35.0 then
            set udg_SK_Reisen01_Target = null
        endif
    endif
    set i = 0
    call UnitAddAbility(u, 'A067')
    call SetUnitAbilityLevel(u, 'A067', level)
    set tf = IssueTargetOrderById(u, 852274, caster)
    set caster = null
    set u = null
endfunction

function InitTrig_Reisen01 takes nothing returns nothing
endfunction