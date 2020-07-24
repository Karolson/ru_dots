function Trig_YoumuEx_Conditions takes nothing returns boolean
    local unit u
    if GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER then
        if OrderId2String(GetIssuedOrderId()) == "berserk" then
            set u = GetTriggerUnit()
            call ClearAllNegativeBuff(u, false)
            set u = null
        endif
    elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId() == 'A1IF' then
        set u = GetTriggerUnit()
        call AbilityCoolDownResetion(u, GetSpellAbilityId(), 90)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\Possession\\PossessionMissile.mdl", u, "head"))
        set u = null
    endif
    return false
endfunction

function InitTrig_YoumuEx takes nothing returns nothing
endfunction