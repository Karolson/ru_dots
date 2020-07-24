function Trig_Tower_Break_B_Patch_Actions takes nothing returns nothing
    set udg_GameSetting_Gold_A = udg_GameSetting_Gold_A + 2
    set gg_rct_SpawnB0  =  gg_rct_SpawnB2
    set udg_SpawnLocB[0] = GetRectCenter(gg_rct_SpawnB0)
endfunction

function InitTrig_Tower_Break_B_Patch takes nothing returns nothing
    set gg_trg_Tower_Break_B_Patch = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tower_Break_B_Patch, gg_unit_h00A_0058, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Tower_Break_B_Patch, function Trig_Tower_Break_B_Patch_Actions)
endfunction