function Trig_DaoYao_Conditions takes nothing returns boolean
    local unit caster = GetEventDamageSource()
    if GetUnitAbilityLevel(caster, 'A0GQ') > 0 != true or GetUnitAbilityLevel(caster, 'A1HQ') != 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    if GetRandomInt(0, 100) < 15 then
        if IsUnitType(caster, UNIT_TYPE_RANGED_ATTACKER) then
            call UnitStunTarget(caster, GetTriggerUnit(), 0.4, 0, 0)
        else
            call UnitStunTarget(caster, GetTriggerUnit(), 1, 0, 0)
        endif
    endif
    set caster = null
    return false
endfunction

function InitTrig_Ati05_DaoYao takes nothing returns nothing
    set gg_trg_Ati05_DaoYao = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Ati05_DaoYao)
    call TriggerAddCondition(gg_trg_Ati05_DaoYao, Condition(function Trig_DaoYao_Conditions))
endfunction