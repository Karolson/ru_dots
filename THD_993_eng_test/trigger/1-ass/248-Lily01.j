function LilyAb01 takes nothing returns integer
    return 'A0WK'
endfunction

function LilyAb011 takes nothing returns integer
    return 'A1A6'
endfunction

function Trig_Lily01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WK' or GetSpellAbilityId() == 'A1A6'
endfunction

function Trig_Lily01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit e = LoadUnitHandle(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer abstyle = LoadInteger(udg_ht, task, 4)
    local integer level = LoadInteger(udg_ht, task, 5)
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_ht, task, 3, i)
        call SetUnitXY(e, GetUnitX(target), GetUnitY(target))
        if i / 10 * 10 == i then
            if abstyle == 0 then
                call UnitHealingTarget(caster, target, ABCIAllInt(caster, 16 * level, 0.45))
            else
                call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 16 * level, 0.6), 2)
            endif
        endif
    else
        call KillUnit(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Lily01_Functioned takes unit caster, unit target, integer abstyle, integer level returns nothing
    local timer t
    local integer task
    local unit e
    if abstyle == 0 then
        set e = CreateUnit(GetOwningPlayer(caster), 'n04D', GetUnitX(target), GetUnitY(target), 0)
        call UnitHealingTarget(caster, target, ABCIAllInt(caster, 16 * level, 0.3))
    else
        set e = CreateUnit(GetOwningPlayer(caster), 'n04E', GetUnitX(target), GetUnitY(target), 0)
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 16 * level, 0.5), 2)
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, e)
    call SaveInteger(udg_ht, task, 3, 50)
    call SaveInteger(udg_ht, task, 4, abstyle)
    call SaveInteger(udg_ht, task, 5, level)
    call TimerStart(t, 0.1, true, function Trig_Lily01_Main)
    set t = null
    set e = null
endfunction

function Trig_Lily01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer abstyle
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer cost = 30 * level
    if GetUnitTypeId(caster) == 'E023' then
        if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Cannot target enemy units|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + cost)
            set caster = null
            set target = null
            return
        elseif GetUnitState(caster, UNIT_STATE_MANA) < cost then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough MP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set target = null
            return
        else
            set abstyle = 0
        endif
    elseif GetUnitTypeId(caster) == 'E024' then
        if IsUnitAlly(target, GetOwningPlayer(caster)) then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Cannot target friendly units|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set target = null
            return
        elseif GetUnitState(caster, UNIT_STATE_LIFE) < cost then
            call IssueImmediateOrder(caster, "stop")
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000Not enough HP to cast this spell|r")
            set abstyle = GetSpellAbilityId()
            call UnitRemoveAbility(caster, abstyle)
            call UnitAddAbility(caster, abstyle)
            call SetUnitAbilityLevel(caster, abstyle, level)
            set caster = null
            set target = null
            return
        else
            set abstyle = 1
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) - cost)
        endif
    else
        set caster = null
        set target = null
        return
    endif
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call Trig_Lily01_Functioned(caster, target, abstyle, level)
    set caster = null
    set target = null
endfunction

function InitTrig_Lily01 takes nothing returns nothing
endfunction