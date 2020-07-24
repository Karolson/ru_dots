function Trig_Command_Cloth03_Actions takes nothing returns nothing
    local player ply
    local integer k
    set ply = GetTriggerPlayer()
    set k = GetPlayerId(ply)
    if udg_GameStart then
        set ply = null
        return
    endif
    set udg_HeroClothChangeTo[k] = 3
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ccffccYou have selected special skin.|r")
    set ply = null
endfunction

function InitTrig_Command_Cloth03 takes nothing returns nothing
    set gg_trg_Command_Cloth03 = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Cloth03, function Trig_Command_Cloth03_Actions)
endfunction