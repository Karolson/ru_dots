function Trig_Tree_Bridge_Conditions takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Tree_Bridge_Rebirth takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local group g = CreateGroup()
    local filterfunc filter = Filter(function Trig_Tree_Bridge_Conditions)
    call GroupEnumUnitsInRect(g, gg_rct_BLTreesWayGate, filter)
    call DestroyFilter(filter)
    if CountUnitsInGroup(g) != 0 then
        call DestroyGroup(g)
        set filter = null
        set t = null
        set g = null
        return
    else
        call DestructableRestoreLife(gg_dest_LTt5_0498, GetDestructableMaxLife(gg_dest_LTt5_0498), true)
        call DestructableRestoreLife(gg_dest_DTlv_1987, GetDestructableMaxLife(gg_dest_DTlv_1987), true)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        set filter = null
        set t = null
        set g = null
    endif
endfunction

function Trig_Tree_Bridge_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    call KillDestructable(gg_dest_LTt5_0498)
    call TriggerSleepAction(5.0)
    call TimerStart(t, 1.0, true, function Trig_Tree_Bridge_Rebirth)
    set t = null
endfunction

function InitTrig_Tree_Bridge takes nothing returns nothing
    set gg_trg_Tree_Bridge = CreateTrigger()
    call TriggerRegisterDeathEvent(gg_trg_Tree_Bridge, gg_dest_DTlv_1987)
    call TriggerAddAction(gg_trg_Tree_Bridge, function Trig_Tree_Bridge_Actions)
endfunction