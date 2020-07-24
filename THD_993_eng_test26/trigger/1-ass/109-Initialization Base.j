function Trig_Initialization_Base_Actions takes nothing returns nothing
    set udg_BaseA[0] = gg_unit_h00D_0013
    set udg_BaseA[1] = gg_unit_h02M_0043
    set udg_BaseA[2] = gg_unit_h02L_0073
    set udg_BaseA[3] = gg_unit_h013_0052
    set udg_BaseA[4] = gg_unit_h013_0053
    set udg_BaseA[5] = gg_unit_h013_0054
    set udg_BaseA[6] = gg_unit_h00Y_0050
    set udg_BaseA[8] = gg_unit_h00Y_0089
    set udg_BaseA[9] = gg_unit_h017_0107
    set udg_BaseA[11] = gg_unit_h027_0046
    set udg_BaseA[12] = gg_unit_h027_0068
    set udg_BaseA[14] = gg_unit_h018_0000
    set udg_BaseB[0] = gg_unit_h00U_0019
    set udg_BaseB[1] = gg_unit_h00Z_0091
    set udg_BaseB[2] = gg_unit_h00Z_0092
    set udg_BaseB[3] = gg_unit_h00A_0056
    set udg_BaseB[4] = gg_unit_h00A_0057
    set udg_BaseB[5] = gg_unit_h00A_0058
    set udg_BaseB[6] = gg_unit_h00C_0008
    set udg_BaseB[8] = gg_unit_h00C_0042
    set udg_BaseB[9] = gg_unit_h019_0038
    set udg_BaseB[11] = gg_unit_h028_0069
    set udg_BaseB[12] = gg_unit_h028_0023
    set udg_BaseB[14] = gg_unit_h016_0024
    call SetUnitInvulnerable(udg_BaseA[0], true)
    call SetUnitInvulnerable(udg_BaseA[3], true)
    call SetUnitInvulnerable(udg_BaseA[4], true)
    call SetUnitInvulnerable(udg_BaseA[5], true)
    call SetUnitInvulnerable(udg_BaseB[0], true)
    call SetUnitInvulnerable(udg_BaseB[3], true)
    call SetUnitInvulnerable(udg_BaseB[4], true)
    call SetUnitInvulnerable(udg_BaseB[5], true)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Tower_Break_A, udg_PlayerA[0], EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Tower_Break_B, udg_PlayerB[0], EVENT_PLAYER_UNIT_DEATH)
    call TriggerExecute(gg_trg_TowerAbility)
    call TriggerExecute(gg_trg_SpawnAbility)
endfunction

function InitTrig_Initialization_Base takes nothing returns nothing
    set gg_trg_Initialization_Base = CreateTrigger()
    call DisableTrigger(gg_trg_Initialization_Base)
    call TriggerAddAction(gg_trg_Initialization_Base, function Trig_Initialization_Base_Actions)
endfunction