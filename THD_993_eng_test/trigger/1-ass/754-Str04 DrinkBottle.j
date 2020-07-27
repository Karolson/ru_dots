function Trig_Str04_DrinkBottle_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A13F'
endfunction

function Str04_DrinkBottle_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(target))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(target))] / 0.6
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set target = null
    set t = null
endfunction

function Trig_Str04_DrinkBottle_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    if udg_NewDebuffSys then
        call UnitSlowTargetMspd(caster, target, 40, 4.0, 3, 0)
    else
        call UnitSlowTarget(caster, target, 4.0, 'A13G', 'B06P')
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(target))] = udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(target))] * 0.6
    endif
    call SaveUnitHandle(udg_ht, task, 0, target)
    call TimerStart(t, 4, false, function Str04_DrinkBottle_Clear)
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_Str04_DrinkBottle takes nothing returns nothing
    set gg_trg_Str04_DrinkBottle = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str04_DrinkBottle, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Str04_DrinkBottle, Condition(function Trig_Str04_DrinkBottle_Conditions))
    call TriggerAddAction(gg_trg_Str04_DrinkBottle, function Trig_Str04_DrinkBottle_Actions)
endfunction