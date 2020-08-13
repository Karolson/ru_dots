function Trig_Setting_Item_System_Table_1_Actions takes nothing returns nothing
    local integer i = udg_HC_Database_01[2000] + 1000
    call HC_Formula_Begin(i, 1, 'I00S')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I020', 1, 'I010', 1, 'I01P', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I023', 1, 'I01L', 1, 'I01P', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00R')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01Z', 1, 'I01R', 1, 'I01P', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I04L')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04M', 1, 'I013', 1, 'I01G', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I04F')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04E', 1, 'I01K', 1, 'I01F', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00J')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02B', 1, 'I017', 1, 'I00Y', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I032')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I024', 1, 'I01R', 1, 'I013', 1)
    call HC_Formula_SetMaterialB('I04L', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I02Y')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01X', 1, 'I01J', 1, 'I01L', 1)
    call HC_Formula_SetMaterialB('I01K', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I051')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I052', 1, 'I010', 1, 'I00Y', 1)
    call HC_Formula_SetMaterialB('I00Z', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I06V')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06U', 1, 'I01O', 1, 'I04L', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I06X')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06W', 1, 'I01D', 1, 'I036', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00V')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I004', 1, 'I00Z', 1, 'I00Y', 1)
    call HC_Formula_SetMaterialB('I01S', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I04D')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I001', 1, 'I019', 1, 'I01I', 1)
    call HC_Formula_SetMaterialB('I01I', 1, 'I04K', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I05T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I018', 1, 'I019', 1, 'I01J', 1)
    call HC_Formula_SetMaterialB('I05U', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I069')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01V', 1, 'I036', 1, 'I00Z', 1)
    call HC_Formula_SetMaterialB('I00J', 1, 'I06A', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00W')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I006', 1, 'I01O', 1, 'I01O', 1)
    call HC_Formula_SetMaterialB('I04B', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I041')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I042', 1, 'I02Y', 1, 'I04C', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00P')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01S', 1, 'I049', -1, 'I02D', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I06K')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06L', 1, 'I00I', 1, 'I01N', 1)
    call HC_Formula_SetMaterialB('I01F', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I06Y')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06Z', 1, 'I04T', 1, 'I01U', 1)
    call HC_Formula_SetMaterialB('I048', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I06N')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I06M', 1, 'I014', 1, 'I049', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I03I')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I003', 1, 'I001', 1, 'I001', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I060')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I05Z', 1, 'I048', 1, 'I048', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I064')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I065', 1, 'I049', 1, 'I049', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I071')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I070', 1, 'I01N', 1, 0, 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I073')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I072', 1, 'I01I', 1, 'I00Y', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I075')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I074', 1, 'I017', 1, 'I017', 1)
    call HC_Formula_SetMaterialB('I06T', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I077')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I076', 1, 'I014', 1, 'I019', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07L')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I07K', 1, 'I012', 1, 'I00Y', 1)
    call HC_Formula_SetMaterialB('I00Y', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I043')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02E', 1, 'I01D', 1, 'I00Z', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07D')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I071', 1, 'I07C', 1, 'I011', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07F')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I07E', 1, 'I049', 1, 'I01R', 1)
    call HC_Formula_SetMaterialB('I01R', 1, 'I01R', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07H')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I07G', 1, 'I00Z', 1, 'I04F', 1)
    call HC_Formula_SetMaterialB('I017', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I066')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I067', 1, 'I01C', 1, 'I01O', 1)
    call HC_Formula_SetMaterialB('I01K', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I04A')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I002', 1, 'I08J', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07R')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I07Q', 1, 'I00Z', 1, 'I01M', 1)
    call HC_Formula_SetMaterialB('I00Y', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I04O')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I04P', 1, 'I01B', 1, 'I04F', 1)
    call HC_Formula_SetMaterialB('I01O', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I02X')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I005', 1, 'I04L', 1, 'I01S', 1)
    call HC_Formula_SetMaterialB('I00Z', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00K')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I00J', 1, 'I01J', 1, 'I011', 1)
    call HC_Formula_SetMaterialB('I028', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I081')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I080', 1, 'I068', 1, 'I01N', 1)
    call HC_Formula_SetMaterialB('I071', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07J')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I01P', 1, 'I07I', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I04C')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I03W', 1, 'I01P', 1, 'I01P', 1)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I035')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02C', 1, 'I07J', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07S')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02C', 1, 'I035', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07T')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02C', 1, 'I07S', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07U')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02C', 1, 'I07T', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07V')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I02C', 1, 'I07U', 1, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I00C')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I011', 1, 'I014', 1, 'I07J', 1)
    call HC_Formula_SetMaterialB('I022', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07X')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I07W', 1, 'I014', 1, 'I083', 1)
    call HC_Formula_SetMaterialB('I01M', 1, 0, 0, 0, 0)
    call HC_Formula_End()
    set i = i + 1
    call HC_Formula_Begin(i, 1, 'I07Z')
    call HC_Formula_SetResourceAB(0, 0)
    call HC_Formula_SetMaterialA('I07Y', 1, 'I01V', 1, 'I01G', 1)
    call HC_Formula_End()
    set i = i + 1
    call TriggerExecute(gg_trg_Setting_Item_System_Table_2)
endfunction

function InitTrig_Setting_Item_System_Table_1 takes nothing returns nothing
    set gg_trg_Setting_Item_System_Table_1 = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Item_System_Table_1, function Trig_Setting_Item_System_Table_1_Actions)
endfunction