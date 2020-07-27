function Trig_Str03_Profess_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0C1'
endfunction

function Trig_Str03_Profess_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real tx = GetUnitX(caster)
    local real ty = GetUnitY(caster)
    call GroupEnumUnitsInRange(g, tx, ty, 300, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            if udg_NewDebuffSys then
                call UnitSlowTargetNew(caster, v, 45, 4.0, 3, 0)
            else
                call UnitSlowTarget(caster, v, 4.0, 'A13C', 'B06O')
            endif
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Str03_Profess takes nothing returns nothing
    set gg_trg_Str03_Profess = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str03_Profess, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Str03_Profess, Condition(function Trig_Str03_Profess_Conditions))
    call TriggerAddAction(gg_trg_Str03_Profess, function Trig_Str03_Profess_Actions)
endfunction