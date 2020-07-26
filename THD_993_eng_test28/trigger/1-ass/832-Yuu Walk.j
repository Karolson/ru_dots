function Trig_Yuu_Walk_Conditions takes nothing returns boolean
    local unit caster
    local unit target
    local real x
    local real y
    if GetSpellAbilityId() != 'A1P9' then
        set caster = null
        set target = null
        return false
    endif
    set caster = GetTriggerUnit()
    set target = GetPlayerCharacter(GetOwningPlayer(caster))
    if GetUnitState(target, UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    set x = GetUnitX(target)
    set y = GetUnitY(target)
    call SetUnitX(caster, x)
    call SetUnitY(caster, y)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", x, y))
    call YuuGive_GiveItem(target, caster)
    set caster = null
    set target = null
    return false
endfunction

function InitTrig_Yuu_Walk takes nothing returns nothing
    set gg_trg_Yuu_Walk = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Yuu_Walk, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yuu_Walk, Condition(function Trig_Yuu_Walk_Conditions))
endfunction