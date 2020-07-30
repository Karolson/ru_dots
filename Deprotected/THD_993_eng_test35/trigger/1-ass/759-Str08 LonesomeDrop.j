function Trig_Str08_LonesomeDrop_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I03I'
endfunction

function Trig_Str08_LonesomeDrop_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer k = GetConvertedPlayerId(GetOwningPlayer(caster))
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I03I') == 0 then
        set udg_SK_Lonesome[k] = 0
        call DebugMsg("Lonesome Effect End")
    endif
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set caster = null
    set t = null
endfunction

function Trig_Str08_LonesomeDrop_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 0.0, false, function Trig_Str08_LonesomeDrop_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Str08_LonesomeDrop takes nothing returns nothing
    set gg_trg_Str08_LonesomeDrop = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str08_LonesomeDrop, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(gg_trg_Str08_LonesomeDrop, Condition(function Trig_Str08_LonesomeDrop_Conditions))
    call TriggerAddAction(gg_trg_Str08_LonesomeDrop, function Trig_Str08_LonesomeDrop_Actions)
endfunction