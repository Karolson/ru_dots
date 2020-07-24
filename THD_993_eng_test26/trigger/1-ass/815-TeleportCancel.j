function Trig_TeleportCancel_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A07Y' then
        return true
    elseif GetSpellAbilityId() == 'A08I' then
        return true
    endif
    return false
endfunction

function Trig_TeleportCancel_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    if GetUnitTypeId(caster) == 'H024' then
        call IssueImmediateOrder(caster, "stop")
    elseif GetUnitTypeId(caster) == 'H025' then
        call IssueImmediateOrder(caster, "stop")
    elseif GetUnitTypeId(caster) == 'H00S' then
        call IssueImmediateOrder(caster, "stop")
    elseif GetUnitTypeId(caster) == 'E01T' then
        call IssueImmediateOrder(caster, "stop")
    elseif GetUnitTypeId(caster) == 'E02C' then
        call IssueImmediateOrder(caster, "stop")
    elseif GetUnitTypeId(caster) == 'E00J' then
        call IssueImmediateOrder(caster, "stop")
    elseif GetUnitTypeId(caster) == 'H00Q' then
        call IssueImmediateOrder(caster, "stop")
    endif
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 then
        call IssueImmediateOrder(caster, "stop")
    endif
    if GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        call IssueImmediateOrder(caster, "stop")
    endif
    if GetUnitAbilityLevel(caster, 'A0BC') == 1 then
        call IssueImmediateOrder(caster, "stop")
    endif
    call SetUnitFlag(caster, 5, false)
    set caster = null
endfunction

function InitTrig_TeleportCancel takes nothing returns nothing
    set gg_trg_TeleportCancel = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_TeleportCancel, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_TeleportCancel, Condition(function Trig_TeleportCancel_Conditions))
    call TriggerAddAction(gg_trg_TeleportCancel, function Trig_TeleportCancel_Actions)
endfunction