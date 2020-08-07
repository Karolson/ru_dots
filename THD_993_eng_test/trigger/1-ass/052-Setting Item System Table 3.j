function Trig_Setting_Item_System_Table_3_Actions takes nothing returns nothing
    local integer i = udg_HC_Database_01[2000] + 1000
    call HC_Formula_Begin(i, 3, 'I02V')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I012', 1, 'I01N', 1, 'I03L', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I00G')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I03Y', 1, 'I009', 1, 'I01Q', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I00I')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02K', 1, 'I01H', 1, 'I01F', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I04N')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01H', 1, 'I08M', 1, 'I04S', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I02W')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04B', 1, 'I018', 1, 'I03M', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I08D')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04B', 1, 'I01H', 1, 'I08C', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I04G')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04H', 1, 'I01H', 1, 'I068', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I08Q')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01F', 1, 'I018', 1, 'I04C', 1)
    call HC_Formula_SetMaterialB('I07J', 1, 'I08R', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I039')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02H', 1, 'I01W', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I03A')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02I', 1, 'I01W', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I03B')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02J', 1, 'I01W', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I031')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I038', 1, 'I01W', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I00N')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I03T', 1, 'I01W', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I08T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I08S', 1, 'I01W', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I00A')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01W', 1, 'I02M', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I01T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I00Z', 1, 'I00Z', 1, 'I04B', 1)
    call HC_Formula_SetMaterialB('I01A', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I026')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01B', 1, 'I014', 1, 'I02L', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I04V')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I009', 1, 'I06S', 1, 'I04U', 1)
    call HC_Formula_SetMaterialB('I085', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I06Q')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I019', 1, 'I013', 1, 'I01N', 1)
    call HC_Formula_SetMaterialB('I08U', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I08V')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I08W', 1, 'I036', 1, 'I061', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I04X')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01V', 1, 'I01F', 1, 'I04Y', 1)
    call HC_Formula_SetMaterialB('I04L', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I033')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04F', 1, 'I01C', 1, 'I01U', 1)
    call HC_Formula_SetMaterialB('I01V', 1, 'I03G', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I08X')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04C', 1, 'I085', 1, 'I015', 1)
    call HC_Formula_SetMaterialB('I05B', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I093')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I08T', 1, 'I08Y', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I090')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I031', 1, 'I08Y', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I092')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I039', 1, 'I08Y', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I091')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I03A', 1, 'I08Y', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call DebugMsg("Number of items with recipes: " + I2S(i - 1000))
endfunction

function InitTrig_Setting_Item_System_Table_3 takes nothing returns nothing
    set gg_trg_Setting_Item_System_Table_3 = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Item_System_Table_3, function Trig_Setting_Item_System_Table_3_Actions)
endfunction