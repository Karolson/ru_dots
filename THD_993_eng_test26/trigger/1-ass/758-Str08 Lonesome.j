function Trig_Str08_Lonesome_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I03I' and udg_SK_Lonesome[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 0
endfunction

function Trig_Str08_Lonesome_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real oldhp = LoadReal(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2) + 1
    local integer k = LoadInteger(udg_ht, task, 3)
    local real maxhp
    local real nowhp = GetWidgetLife(caster)
    if i >= 50 then
        set i = i - 50
        set maxhp = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
        call UnitHealingTarget(caster, caster, 0.0175 * (maxhp - nowhp))
        set nowhp = GetWidgetLife(caster)
    endif
    call SaveReal(udg_ht, task, 1, GetWidgetLife(caster))
    call SaveInteger(udg_ht, task, 2, i)
    if YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I03I') == 0 then
        set udg_SK_Lonesome[k] = 0
        call DebugMsg("Lonesome Effect End")
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Str08_Lonesome_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer k = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
    local timer t
    local integer task
    set udg_SK_Lonesome[k] = 1
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, GetWidgetLife(caster))
    call SaveInteger(udg_ht, task, 2, 0)
    call SaveInteger(udg_ht, task, 3, k)
    call TimerStart(t, 0.02, true, function Trig_Str08_Lonesome_Main)
    call DebugMsg("Lonesome Effect Start")
    set caster = null
    set t = null
endfunction

function InitTrig_Str08_Lonesome takes nothing returns nothing
    set gg_trg_Str08_Lonesome = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str08_Lonesome, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Str08_Lonesome, Condition(function Trig_Str08_Lonesome_Conditions))
    call TriggerAddAction(gg_trg_Str08_Lonesome, function Trig_Str08_Lonesome_Actions)
endfunction