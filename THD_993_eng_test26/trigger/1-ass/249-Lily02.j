function Trig_Lily02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WL' or GetSpellAbilityId() == 'A1A7'
endfunction

function Trig_Lily02_BuffTarget takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'B06A') == 1
endfunction

function Trig_Lily02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer abtype = LoadInteger(udg_ht, task, 1)
    local group g
    local unit v
    call UnitRemoveAbility(caster, abtype)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 99999.0, Filter(function Trig_Lily02_BuffTarget))
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitRemoveAbility(v, 'B06A')
    endloop
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set v = null
    set g = null
endfunction

function Trig_Lily02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer abstyle
    local integer abtype
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer cost = 75
    local timer t
    local integer task
    if GetUnitTypeId(caster) == 'E023' then
        if GetUnitState(caster, UNIT_STATE_MANA) < cost and false then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough MP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set target = null
            set t = null
            return
        else
            set abstyle = 0
        endif
    elseif GetUnitTypeId(caster) == 'E024' then
        if GetUnitState(caster, UNIT_STATE_LIFE) < cost then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough HP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set target = null
            set t = null
            return
        else
            set abstyle = 1
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) - cost)
        endif
    endif
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 26 - 3 * level)
    if abstyle == 0 then
        call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_MAX_LIFE))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\HealingWave\\HealingWaveTarget.mdl", GetUnitX(target), GetUnitY(target)))
        if level == 1 then
            set abtype = 'A0WO'
        elseif level == 2 then
            set abtype = 'A0WX'
        elseif level == 3 then
            set abtype = 'A0WY'
        else
            set abtype = 'A0WZ'
        endif
    else
        call InstantKill(caster, target)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl", GetUnitX(target), GetUnitY(target)))
        if level == 1 then
            set abtype = 'A0WP'
        elseif level == 2 then
            set abtype = 'A0X0'
        elseif level == 3 then
            set abtype = 'A0X1'
        else
            set abtype = 'A0X2'
        endif
    endif
    call UnitAddAbility(caster, abtype)
    call UnitMakeAbilityPermanent(caster, true, abtype)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, abtype)
    call TimerStart(t, 8.0, false, function Trig_Lily02_Clear)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Lily02 takes nothing returns nothing
endfunction