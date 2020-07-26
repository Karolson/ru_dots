function Trig_Initialization_SpawnActions takes nothing returns nothing
    call TriggerExecute(gg_trg_Route_A)
    call TriggerExecute(gg_trg_Route_B)
    set udg_Game_BattleBeginTime = 90
    set udg_SpawnPlayer[0] = udg_PlayerA[0]
    set udg_SpawnPlayer[1] = udg_PlayerB[0]
    set udg_SpawnLocA[0] = GetRectCenter(gg_rct_SpawnA0)
    set udg_SpawnLocA[1] = GetRectCenter(gg_rct_SpawnA1)
    set udg_SpawnLocA[2] = GetRectCenter(gg_rct_SpawnA2)
    set udg_SpawnLocA[3] = GetRectCenter(gg_rct_BaseA)
    set udg_SpawnLocB[0] = GetRectCenter(gg_rct_SpawnB0)
    set udg_SpawnLocB[1] = GetRectCenter(gg_rct_SpawnB1)
    set udg_SpawnLocB[2] = GetRectCenter(gg_rct_SpawnB2)
    set udg_SpawnLocB[3] = GetRectCenter(gg_rct_BaseB)
endfunction

function InitTrig_Initialization_Spawn takes nothing returns nothing
    set gg_trg_Initialization_Spawn = CreateTrigger()
    call DisableTrigger(gg_trg_Initialization_Spawn)
    call TriggerAddAction(gg_trg_Initialization_Spawn, function Trig_Initialization_SpawnActions)
endfunction