function Trig_ManaRenge02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A02N'
endfunction

function Trig_ManaRenge02_Iff takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 or IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    endif
    return true
endfunction

function Trig_ManaRenge02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = Filter(function Trig_ManaRenge02_Iff)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 900, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call SetUnitState(v, UNIT_STATE_MANA, GetUnitState(v, UNIT_STATE_MANA) + 160)
    endloop
    call DestroyGroup(g)
    set caster = null
endfunction

function InitTrig_ManaRegen02 takes nothing returns nothing
    set gg_trg_ManaRegen02 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ManaRegen02, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ManaRegen02, Condition(function Trig_ManaRenge02_Conditions))
    call TriggerAddAction(gg_trg_ManaRegen02, function Trig_ManaRenge02_Actions)
endfunction