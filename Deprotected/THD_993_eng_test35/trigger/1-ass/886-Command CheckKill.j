function Trig_Command_CheckKill_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local unit h = GetPlayerCharacter(p)
    local integer n = GetPlayerId(p)
    local integer i = 0
    if p == udg_PlayerA[0] or p == udg_PlayerB[0] then
        loop
            set h = udg_PlayerHeroes[i]
            if IsUnitAlly(h, p) then
                set n = GetPlayerId(GetOwningPlayer(h))
                call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " creep kills: " + I2S(udg_FlagFarm[n]) + " creep denies: " + I2S(udg_FlagTk[n]) + " total points obtained: " + I2S(udg_PlayerTotalGoldIncome[n]) + " total points lost: " + I2S(udg_PlayerNonItemGoldLoss[n]) + " points spent on items: " + I2S(udg_PlayerTotalGoldLoss[n] - udg_PlayerNonItemGoldLoss[n]))
            endif
            set i = i + 1
        exitwhen i >= 12
        endloop
        set h = null
        return
    endif
    call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " creep kills: " + I2S(udg_FlagFarm[n]) + " creep denies: " + I2S(udg_FlagTk[n]) + " total points obtained: " + I2S(udg_PlayerTotalGoldIncome[n]) + " total points lost: " + I2S(udg_PlayerNonItemGoldLoss[n]) + " points spent on items: " + I2S(udg_PlayerTotalGoldLoss[n] - udg_PlayerNonItemGoldLoss[n]))
    set h = null
endfunction

function InitTrig_Command_CheckKill takes nothing returns nothing
    set gg_trg_Command_CheckKill = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_CheckKill, function Trig_Command_CheckKill_Actions)
endfunction