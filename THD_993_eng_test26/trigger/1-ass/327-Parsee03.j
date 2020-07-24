function Trig_Parsee03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RO'
endfunction

function Trig_Parsee03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer i
    local integer j
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = GetUnitFacing(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
    set i = level + 1
    set j = level + 1
    loop
        set u = CreateUnit(GetOwningPlayer(caster), 'o014', ox + 100 * CosBJ(a + 360 / j * i + 360 / j / 2), oy + 100 * SinBJ(a + 360 / j * i + 360 / j / 2), a)
        if target != null then
            call IssueTargetOrder(u, "attack", target)
        endif
        set i = i - 1
    exitwhen i == 0
    endloop
    set caster = null
    set u = null
endfunction

function InitTrig_Parsee03 takes nothing returns nothing
endfunction