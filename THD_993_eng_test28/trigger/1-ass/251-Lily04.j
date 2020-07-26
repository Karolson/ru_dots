function Trig_Lily04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0X6' or GetSpellAbilityId() == 'A1A9'
endfunction

function Trig_Lily04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real tx = LoadReal(udg_ht, task, 1)
    local real ty = LoadReal(udg_ht, task, 2)
    local integer abstyle = LoadInteger(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local integer level = LoadInteger(udg_ht, task, 5)
    local group g
    local unit v
    local integer j
    local real r
    local real a
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_ht, task, 4, i)
        set j = 0
        loop
            set a = GetRandomInt(0, 360)
            set r = GetRandomInt(0, 600)
            if abstyle == 0 then
                call DestroyEffect(AddSpecialEffect("lily4-1.MDx", tx + r * CosBJ(a), ty + r * SinBJ(a)))
            else
                call DestroyEffect(AddSpecialEffect("lily4-2.MDx", tx + r * CosBJ(a), ty + r * SinBJ(a)))
            endif
            set j = j + 1
        exitwhen j == 40
        endloop
        set g = CreateGroup()
        if abstyle == 0 then
            call GroupEnumUnitsInRange(g, tx, ty, 600.0, Filter(function Trig_Lily03_Abstyle00_Target))
        else
            call GroupEnumUnitsInRange(g, tx, ty, 600.0, Filter(function Trig_Lily03_Abstyle01_Target))
        endif
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if abstyle == 0 then
                call UnitHealingTarget(caster, v, ABCIAllInt(caster, 36 + 18 * level, 0.5))
            else
                call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 36 + 18 * level, 0.9), 6)
            endif
        endloop
        call DestroyGroup(g)
    else
        call UnRegisterAreaShow(caster, 'A0X6')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set v = null
endfunction

function Trig_Lily04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local integer abstyle
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer cost = 100 + level * 100
    local timer t
    local integer task
    if GetUnitTypeId(caster) == 'E023' then
        if GetUnitState(caster, UNIT_STATE_MANA) < cost then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough MP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set t = null
            return
        else
            call RegisterAreaShowXY(caster, 'A0X6', tx, ty, 600, 40, 1, "lily4-1.MDx", 0.5)
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
            set t = null
            return
        else
            call RegisterAreaShowXY(caster, 'A0X6', tx, ty, 600, 40, 1, "lily4-2.MDx", 0.5)
            set abstyle = 1
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) - cost)
        endif
    endif
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 140 - level * 20)
    call VE_Spellcast(caster)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, tx)
    call SaveReal(udg_ht, task, 2, ty)
    call SaveInteger(udg_ht, task, 3, abstyle)
    call SaveInteger(udg_ht, task, 4, 7)
    call SaveInteger(udg_ht, task, 5, level)
    call TimerStart(t, 1.0, true, function Trig_Lily04_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_Lily04 takes nothing returns nothing
endfunction