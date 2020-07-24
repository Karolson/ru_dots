function Trig_Command_Cloth00_Actions takes nothing returns nothing
    local player ply
    local integer k
    set ply = GetTriggerPlayer()
    set k = GetPlayerId(ply)
    if udg_GameStart then
        set ply = null
        return
    endif
    set udg_HeroClothChangeTo[k] = -1
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ccffccYou have selected classic skin.|r")
    set ply = null
endfunction

function InitTrig_Command_Cloth00 takes nothing returns nothing
    set gg_trg_Command_Cloth00 = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Cloth00, function Trig_Command_Cloth00_Actions)
endfunction