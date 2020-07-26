function Trig_Initialization_ItemAbilities_Func002A takes nothing returns nothing
    local player w = GetEnumPlayer()
    call SetPlayerAbilityAvailable(w, 'A03Q', false)
    call SetPlayerAbilityAvailable(w, 'A0GM', false)
    call SetPlayerAbilityAvailable(w, 'A0GU', false)
    call SetPlayerAbilityAvailable(w, 'A0R4', false)
    call SetPlayerAbilityAvailable(w, 'A0U2', false)
    call SetPlayerAbilityAvailable(w, 'A0YQ', false)
    call SetPlayerAbilityAvailable(w, 'A0YV', false)
    call SetPlayerAbilityAvailable(w, 'A139', false)
    call SetPlayerAbilityAvailable(w, 'A192', false)
    call SetPlayerAbilityAvailable(w, 'A0RQ', false)
    set w = null
endfunction

function Trig_Initialization_ItemAbilities_Actions takes nothing returns nothing
    call ForForce(bj_FORCE_ALL_PLAYERS, function Trig_Initialization_ItemAbilities_Func002A)
    call TriggerSleepAction(2.0)
    call AddingLBuff(0, 'A137', 'B007')
    call AddingLBuff(0, 'A13C', 'B06O')
    call AddingLBuff(0, 'A148', 0)
    call AddingLBuff(0, 'A149', 0)
    call AddingLBuff(0, 'A14A', 0)
    call AddingLBuff(0, 'A14B', 0)
    call AddingLBuff(0, 'A14C', 0)
    call AddingLBuff(0, 'A15G', 'B06U')
    call AddingLBuff(0, 'A15H', 'B06V')
    call AddingLBuff(0, 'A173', 0)
    call AddingLBuff(0, 'A175', 0)
endfunction

function InitTrig_Initialization_ItemAbilities takes nothing returns nothing
    set gg_trg_Initialization_ItemAbilities = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization_ItemAbilities, function Trig_Initialization_ItemAbilities_Actions)
endfunction