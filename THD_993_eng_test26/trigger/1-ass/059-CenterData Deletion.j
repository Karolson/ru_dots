function Trig_CenterData_Deletion_Actions takes nothing returns nothing
    local group g = CreateGroup()
    local unit v
    call GroupEnumUnitsInRect(g, gg_rct_Center_Camera_Area, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call KillUnit(v)
    endloop
    call DestroyGroup(g)
    set g = null
    set v = null
endfunction

function InitTrig_CenterData_Deletion takes nothing returns nothing
    set gg_trg_CenterData_Deletion = CreateTrigger()
    call TriggerAddAction(gg_trg_CenterData_Deletion, function Trig_CenterData_Deletion_Actions)
endfunction