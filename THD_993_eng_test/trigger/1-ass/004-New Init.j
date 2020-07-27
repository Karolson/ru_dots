function InitTrig_New_Init takes nothing returns nothing
    call InitPlayerColorRGB()
    set udg_Hashtable_UnitStatus = InitHashtable()
    set udg_Hashtable_Data = InitHashtable()
endfunction