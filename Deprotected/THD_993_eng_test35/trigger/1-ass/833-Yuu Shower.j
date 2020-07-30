function Trig_Yuu_Shower_Conditions takes nothing returns boolean
    local unit caster
    if GetSpellAbilityId() != 'A0P9' then
        set caster = null
        return false
    endif
    set caster = GetTriggerUnit()
    if IsUnitAlly(caster, Player(5)) then
        call SetUnitPositionLoc(caster, udg_BirthPoint[0])
        call DestroyEffect(AddSpecialEffectLocBJ(udg_RevivePoint[0], "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"))
    else
        call SetUnitPositionLoc(caster, udg_BirthPoint[1])
        call DestroyEffect(AddSpecialEffectLocBJ(udg_RevivePoint[1], "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"))
    endif
    set caster = null
    return false
endfunction

function InitTrig_Yuu_Shower takes nothing returns nothing
    set gg_trg_Yuu_Shower = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Yuu_Shower, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yuu_Shower, Condition(function Trig_Yuu_Shower_Conditions))
endfunction