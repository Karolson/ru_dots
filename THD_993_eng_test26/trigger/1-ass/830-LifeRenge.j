function Trig_LifeRenge_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A00R'
endfunction

function Trig_LifeRenge_Iff takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 or IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    endif
    return true
endfunction

function Trig_LifeRenge_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = Filter(function Trig_LifeRenge_Iff)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 600, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetUnitAbilityLevel(v, 'A1CR') == 0 then
            call UnitHealingTarget(caster, v, 225 + udg_GameTime * 3 / 60)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
endfunction

function InitTrig_LifeRenge takes nothing returns nothing
    set gg_trg_LifeRenge = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LifeRenge, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_LifeRenge, Condition(function Trig_LifeRenge_Conditions))
    call TriggerAddAction(gg_trg_LifeRenge, function Trig_LifeRenge_Actions)
endfunction