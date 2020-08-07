function Trig_Shoe02_GreenDrop_Conditions takes nothing returns boolean
    if GetItemTypeId(GetManipulatedItem()) == 'I03A' or GetItemTypeId(GetManipulatedItem()) == 'I091' then
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer() then
            return true
        endif
    endif
endfunction

function Trig_Shoe02_GreenDrop_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer k = GetConvertedPlayerId(GetOwningPlayer(caster))
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I03A') == 0 and YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I091') == 0 then
        set udg_SK_Li_Shoe02_Green[k] = 0
        call UnitRemoveAbility(caster, 'A17L')
        call DebugMsg("Green Llama Effect End")
    endif
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set caster = null
    set t = null
endfunction

function Trig_Shoe02_GreenDrop_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 0.0, false, function Trig_Shoe02_GreenDrop_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Shoe02_GreenDrop takes nothing returns nothing
    set gg_trg_Shoe02_GreenDrop = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shoe02_GreenDrop, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(gg_trg_Shoe02_GreenDrop, Condition(function Trig_Shoe02_GreenDrop_Conditions))
    call TriggerAddAction(gg_trg_Shoe02_GreenDrop, function Trig_Shoe02_GreenDrop_Actions)
endfunction