function Trig_BoneClarinet_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0YU'
endfunction

function BoneClarinet_GroupClear takes nothing returns nothing
    local unit v = GetEnumUnit()
    call UnitRemoveAbility(v, 'A0YV')
    call UnitRemoveAbility(v, 'B06C')
    set v = null
endfunction

function BoneClarinet_EffectEnd takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    call ForGroup(g, function BoneClarinet_GroupClear)
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set g = null
endfunction

function BoneClarinet_GroupFilter takes nothing returns boolean
    local unit v = GetFilterUnit()
    if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(v, GetTriggerPlayer()) then
        if GetUnitAbilityLevel(v, 'A0YV') != 1 then
            call UnitAddAbility(v, 'A0YV')
            set v = null
            return true
        endif
    endif
    set v = null
    return false
endfunction

function Trig_BoneClarinet_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local group g = CreateGroup()
    local filterfunc f = Filter(function BoneClarinet_GroupFilter)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, ox, oy, 600.0, f)
    call DestroyFilter(f)
    call SaveGroupHandle(udg_sht, task, 0, g)
    call TimerStart(t, 4.0, false, function BoneClarinet_EffectEnd)
    set caster = null
    set g = null
    set f = null
    set t = null
endfunction

function InitTrig_Life03_BoneClarinet takes nothing returns nothing
    set gg_trg_Life03_BoneClarinet = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Life03_BoneClarinet, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Life03_BoneClarinet, Condition(function Trig_BoneClarinet_Conditions))
    call TriggerAddAction(gg_trg_Life03_BoneClarinet, function Trig_BoneClarinet_Actions)
endfunction