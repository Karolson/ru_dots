function Trig_Command_Cloth02_Actions takes nothing returns nothing
    local player ply
    local integer k
    set ply = GetTriggerPlayer()
    set k = GetPlayerId(ply)
    if udg_GameStart then
        set ply = null
        return
    endif
    set udg_HeroClothChangeTo[k] = 2
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ccffccYou have selected skin #2.|r")
    set ply = null
endfunction

function InitTrig_Command_Cloth02 takes nothing returns nothing
    set gg_trg_Command_Cloth02 = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Cloth02, function Trig_Command_Cloth02_Actions)
endfunction