function Trig_Card05_DouMan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FZ'
endfunction

function Trig_Card05_DouMan_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real s = Deg2Rad(GetUnitFacing(caster))
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    call SetCardAbility(caster, GetSpellAbilityId(), false)
    call SetUnitAnimation(caster, "attack")
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", x, y))
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') == false then
        set x = x + 325 * Cos(s)
        set y = y + 325 * Sin(s)
        call Trig_BlinkPlaceRealer(x, y, 325, s)
        set x = udg_SK_BlinkPlace_x
        set y = udg_SK_BlinkPlace_y
        call SetUnitX(caster, x)
        call SetUnitY(caster, y)
    else
        set x = x + 325 * Cos(s) * 1.3
        set y = y + 325 * Sin(s) * 1.3
        call Trig_BlinkPlaceRealer(x, y, 325 * 1.3, s)
        set x = udg_SK_BlinkPlace_x
        set y = udg_SK_BlinkPlace_y
        call SetUnitX(caster, x)
        call SetUnitY(caster, y)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", x, y))
    set caster = null
endfunction

function InitTrig_Card05_DouMan takes nothing returns nothing
    set gg_trg_Card05_DouMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Card05_DouMan, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Card05_DouMan, Condition(function Trig_Card05_DouMan_Conditions))
    call TriggerAddAction(gg_trg_Card05_DouMan, function Trig_Card05_DouMan_Actions)
endfunction