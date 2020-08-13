function Trig_Setting_Item_System_Table_2_Actions takes nothing returns nothing
    local integer i = udg_HC_Database_01[2000] + 1000
    call HC_Formula_Begin(i, 2, 'I061')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I062', 1, 'I01V', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I036')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I017', 1, 'I017', 1, 'I03X', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I08M')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01C', 1, 'I08N', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I04T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I050', 1, 'I00S', 1, 'I01C', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I04T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I050', 1, 'I00R', 1, 'I01C', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I04T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I050', 1, 'I00T', 1, 'I01C', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00Q')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02F', 1, 'I01V', 1, 'I019', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00M')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02A', 1, 'I01C', 1, 'I017', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I08P')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06R', 1, 'I036', 1, 'I08O', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I04Q')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04C', 1, 'I00Q', 1, 'I04R', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I03S')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I03R', 1, 'I061', 1, 'I01B', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I037')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01U', 1, 'I06R', 1, 'I01B', 1)
    call HC_Formula_SetMaterialB('I03Z', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I008')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I03Q', 1, 'I01B', 1, 'I00Q', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I009')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06S', 1, 'I03N', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I083')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06T', 1, 'I082', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I085')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06T', 1, 'I084', 1, 'I06S', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00O')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I027', 1, 'I085', 1, 'I06T', 1)
    call HC_Formula_SetMaterialB('I083', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I089')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I088', 1, 'I068', 1, 'I068', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00B')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01D', 1, 'I00H', 1, 'I021', 1)
    call HC_Formula_SetMaterialB('I083', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I007')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01D', 1, 'I01N', 1, 'I01M', 1)
    call HC_Formula_SetMaterialB('I03K', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I087')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I086', 1, 'I04B', 1, 'I009', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I08A')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I08B', 1, 'I085', 1, 'I01M', 1)
    call HC_Formula_SetMaterialB('I01M', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I034')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I014', 1, 'I014', 1, 'I085', 1)
    call HC_Formula_SetMaterialB('I03V', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I02Z')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01I', 1, 'I01G', 1, 'I01Y', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00H')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01S', 1, 'I012', 1, 'I03U', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I05W')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02Z', -1, 'I018', 1, 0, 0)
    call HC_Formula_SetMaterialB('I015', 1, 'I01F', 1, 'I05V', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00E')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02G', 1, 'I014', 1, 'I00H', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I08E')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I08F', 1, 'I01I', 1, 'I01I', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I00D')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I009', -1, 'I01N', 1, 'I03O', 1)
    call HC_Formula_SetMaterialB('I08E', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I08H')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01G', 1, 'I01G', 1, 'I08G', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I030')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01D', 1, 'I08H', 1, 'I03P', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 2, 'I08J')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04B', 1, 'I08H', 1, 'I08I', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 3, 'I095')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I036', 1, 'I04F', 1, 'I096', 1)
    call HC_Formula_SetMaterialB('I011', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call TriggerExecute(gg_trg_Setting_Item_System_Table_3)
endfunction

function InitTrig_Setting_Item_System_Table_2 takes nothing returns nothing
    set gg_trg_Setting_Item_System_Table_2 = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Item_System_Table_2, function Trig_Setting_Item_System_Table_2_Actions)
endfunction