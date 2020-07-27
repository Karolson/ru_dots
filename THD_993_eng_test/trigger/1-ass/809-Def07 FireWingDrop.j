function Trig_Def07_FireWingDrop_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I04G' and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer()
endfunction

function Trig_Def07_FireWingDrop_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer k = GetConvertedPlayerId(GetOwningPlayer(caster))
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I04G') == 0 then
        set udg_SK_FireWing[k] = 0
        call DebugMsg("Phoenix Wing Effect End")
    endif
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set caster = null
    set t = null
endfunction

function Trig_Def07_FireWingDrop_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 0.0, false, function Trig_Def07_FireWingDrop_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Def07_FireWingDrop takes nothing returns nothing
    set gg_trg_Def07_FireWingDrop = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Def07_FireWingDrop, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(gg_trg_Def07_FireWingDrop, Condition(function Trig_Def07_FireWingDrop_Conditions))
    call TriggerAddAction(gg_trg_Def07_FireWingDrop, function Trig_Def07_FireWingDrop_Actions)
endfunction