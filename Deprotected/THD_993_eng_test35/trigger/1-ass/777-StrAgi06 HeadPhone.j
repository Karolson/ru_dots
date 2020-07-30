function Trig_StrAgi06_HeadPhone_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A15R'
endfunction

function Trig_StrAgi06_HeadPhone_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 2)
    local group taunted = LoadGroupHandle(udg_ht, task, 1)
    local group newtaunt
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    set i = i - 1
    call SaveInteger(udg_ht, task, 2, i)
    if i > 0 and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        if R2I(i / 5) * 5 == i then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl", GetUnitX(caster), GetUnitY(caster)))
        endif
        set newtaunt = CreateGroup()
        call GroupEnumUnitsInRange(newtaunt, GetUnitX(caster), GetUnitY(caster), 300, iff)
        loop
            set v = FirstOfGroup(newtaunt)
        exitwhen v == null
            call GroupRemoveUnit(newtaunt, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and GetUnitAbilityLevel(v, 'B04B') == 0 and GetUnitAbilityLevel(v, 'BOvc') == 0 and IsUnitInGroup(v, taunted) == false then
                call GroupAddUnit(taunted, v)
                call UnitRidiculeTarget(caster, v, i / 10)
            endif
        endloop
        call DestroyGroup(newtaunt)
    else
        call DestroyGroup(taunted)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set newtaunt = null
    set taunted = null
    set v = null
endfunction

function Trig_StrAgi06_HeadPhone_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group newtaunt = CreateGroup()
    local group taunted = CreateGroup()
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(newtaunt, GetUnitX(caster), GetUnitY(caster), 300, iff)
    loop
        set v = FirstOfGroup(newtaunt)
    exitwhen v == null
        call GroupRemoveUnit(newtaunt, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and GetUnitAbilityLevel(v, 'B04B') == 0 and GetUnitAbilityLevel(v, 'BOvc') == 0 then
            call GroupAddUnit(taunted, v)
            call UnitRidiculeTarget(caster, v, 2.1)
        endif
    endloop
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveGroupHandle(udg_ht, task, 1, taunted)
    call SaveInteger(udg_ht, task, 2, 21)
    call TimerStart(t, 0.1, true, function Trig_StrAgi06_HeadPhone_Main)
    call DestroyGroup(newtaunt)
    set caster = null
    set newtaunt = null
    set taunted = null
    set t = null
endfunction

function InitTrig_StrAgi06_HeadPhone takes nothing returns nothing
    set gg_trg_StrAgi06_HeadPhone = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StrAgi06_HeadPhone, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_StrAgi06_HeadPhone, Condition(function Trig_StrAgi06_HeadPhone_Conditions))
    call TriggerAddAction(gg_trg_StrAgi06_HeadPhone, function Trig_StrAgi06_HeadPhone_Actions)
endfunction