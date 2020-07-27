function Trig_Setting_SpawnActions takes nothing returns nothing
    set udg_SU_ID_A[0] = 'h00E'
    set udg_SU_No_A[0] = 4
    set udg_SU_ID_A[1] = 'e00B'
    set udg_SU_No_A[1] = 1
    set udg_SU_ID_A[2] = 'e016'
    set udg_SU_No_A[2] = 0
    set udg_SUA_ID_A[0] = 'h00G'
    set udg_SUA_ID_A[1] = 'e00D'
    set udg_SUA_ID_A[2] = 'u005'
    set udg_SU_ID_B[0] = 'h00F'
    set udg_SU_No_B[0] = 4
    set udg_SU_ID_B[1] = 'e00C'
    set udg_SU_No_B[1] = 1
    set udg_SU_ID_B[2] = 'e016'
    set udg_SU_No_B[2] = 0
    set udg_SUA_ID_B[0] = 'h00H'
    set udg_SUA_ID_B[1] = 'e00E'
    set udg_SUA_ID_B[2] = 'u005'
endfunction

function InitTrig_Setting_Spawn takes nothing returns nothing
    set gg_trg_Setting_Spawn = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Spawn, function Trig_Setting_SpawnActions)
endfunction