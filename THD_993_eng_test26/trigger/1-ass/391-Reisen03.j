function Trig_Reisen03_Learn_Conditions takes nothing returns boolean
    local integer level = GetUnitAbilityLevel(GetTriggerUnit(), 'A18G')
    local unit caster
    local real mana
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL and GetLearnedSkill() == 'A18G' then
        call SetPlayerTechResearched(GetOwningPlayer(GetTriggerUnit()), 'R000', level + 1)
    endif
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId() == 'A18G' then
        set caster = GetTriggerUnit()
        if GetUnitTypeId(caster) == 'O015' == false then
            if GetUnitAbilityLevel(caster, 'A10G') == 0 then
                call UnitAddAbility(caster, 'A10G')
                call UnitMakeAbilityPermanent(caster, true, 'A10G')
            endif
        else
            if GetUnitAbilityLevel(caster, 'A10G') != 0 then
                call UnitRemoveAbility(caster, 'A10G')
            endif
        endif
        set caster = null
    endif
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED and GetUnitTypeId(GetEventDamageSource()) == 'O015' and GetEventDamage() != 0 and IsDamageNotUnitAttack(GetEventDamageSource()) == false and GetUnitState(GetEventDamageSource(), UNIT_STATE_MANA) > 0 then
        set caster = GetEventDamageSource()
        set level = GetUnitAbilityLevel(GetEventDamageSource(), 'A18G')
        set mana = GetUnitState(caster, UNIT_STATE_MANA)
        call DebugMsg("Reisen03")
        if mana < 5 * 2 then
            call IssueImmediateOrder(caster, "bearform")
        endif
        set mana = mana - 5
        call SetUnitState(caster, UNIT_STATE_MANA, mana)
        set caster = null
    endif
    set caster = null
    return false
endfunction

function Trig_Reisen03_Learn takes nothing returns nothing
endfunction

function InitTrig_Reisen03 takes nothing returns nothing
endfunction