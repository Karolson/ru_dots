function Trig_Cirno_Ball_Conditions takes nothing returns boolean
    return GetItemTypeId(GetManipulatedItem()) == 'I00N'
endfunction

function Trig_Cirno_Ball_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real d = GetRandomReal(300, 700)
    local real a = GetRandomReal(0, 6.28344)
    local effect e
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set e = null
        return
    endif
    set px = ox + d * Cos(a)
    set py = oy + d * Sin(a)
    call SetUnitPosition(caster, px, py)
    set e = AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", caster, "chest")
    call DestroyEffect(e)
    set caster = null
    set e = null
endfunction

function InitTrig_Cirno_Ball takes nothing returns nothing
    set gg_trg_Cirno_Ball = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cirno_Ball, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Cirno_Ball, Condition(function Trig_Cirno_Ball_Conditions))
    call TriggerAddAction(gg_trg_Cirno_Ball, function Trig_Cirno_Ball_Actions)
endfunction