function Trig_NormalData_Deletion_Actions takes nothing returns nothing
    local group g = CreateGroup()
    local unit v
    call GroupEnumUnitsInRect(g, udg_MapRegion, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call KillUnit(v)
    endloop
    call DestroyGroup(g)
    call TriggerExecute(gg_trg_CenterModeData_Initialization)
    set g = null
    set v = null
endfunction

function InitTrig_NormalData_Deletion takes nothing returns nothing
    set gg_trg_NormalData_Deletion = CreateTrigger()
    call TriggerAddAction(gg_trg_NormalData_Deletion, function Trig_NormalData_Deletion_Actions)
endfunction