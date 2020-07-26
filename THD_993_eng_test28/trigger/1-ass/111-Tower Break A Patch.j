function Trig_Tower_Break_A_Patch_Actions takes nothing returns nothing
    set udg_GameSetting_Gold_B = udg_GameSetting_Gold_B + 2
    set gg_rct_SpawnA0  =  gg_rct_SpawnA1
    set udg_SpawnLocA[0] = GetRectCenter(gg_rct_SpawnA0)
endfunction

function InitTrig_Tower_Break_A_Patch takes nothing returns nothing
    set gg_trg_Tower_Break_A_Patch = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tower_Break_A_Patch, gg_unit_h013_0054, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Tower_Break_A_Patch, function Trig_Tower_Break_A_Patch_Actions)
endfunction