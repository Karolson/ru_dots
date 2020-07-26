function Trig_Hourai04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0H0'
endfunction

function Trig_Hourai04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call SetUnitFacing(caster, a)
    set tx = ox + 30.0 * CosBJ(a)
    set ty = oy + 30.0 * SinBJ(a)
    set u = CreateUnit(GetOwningPlayer(caster), 'n03I', tx, ty, a)
    call SetUnitTimeScale(u, 1.5)
    call UnitApplyTimedLife(u, 'BTLF', 0.1)
    set u = CreateUnit(GetOwningPlayer(caster), 'o000', ox, oy, a)
    call UnitAddAbility(u, 'A0H1')
    call SetUnitAbilityLevel(u, 'A0H1', level)
    call IssuePointOrder(u, "breathoffrost", tx, ty)
    set caster = null
    set u = null
endfunction

function InitTrig_Hourai04 takes nothing returns nothing
endfunction