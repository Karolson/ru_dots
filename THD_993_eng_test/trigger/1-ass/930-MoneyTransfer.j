function Trig_MoneyTransfer_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i
    local integer j
    local integer k
    set i = 0
    loop
        set udg_CounterGH_MoneyNow[i] = GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD)
        set udg_CounterGH_MoneyTrans[i] = udg_CounterGH_MoneyNow[i] - udg_CounterGH_MoneyRecord[i]
        set i = i + 1
    exitwhen i == 12
    endloop
    set i = 0
    loop
        if udg_CounterGH_MoneyTrans[i] > 10 or udg_CounterGH_MoneyTrans[i] < -10 then
            set j = 0
            loop
                set k = udg_CounterGH_MoneyTrans[j] * -1
                if udg_CounterGH_MoneyTrans[i] == k then
                    if udg_CounterGH_MoneyTrans[i] > udg_CounterGH_MoneyTrans[j] then
                        call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 30, "|c00ff0000Found to suspect a plug-in transaction, |r" + udg_PN[GetPlayerId(Player(i))] + "|c00ff0000 give|r" + I2S(udg_CounterGH_MoneyTrans[i]) + "|c00ff0000 point to|r" + udg_PN[GetPlayerId( Player(j))] + "|c00ff0000.|r")
                    elseif udg_CounterGH_MoneyTrans[j] > udg_CounterGH_MoneyTrans[i] then
                        call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 30, "|c00ff0000Found to suspect a plug-in transaction, |r" + udg_PN[GetPlayerId(Player(i))] + "|c00ff0000 give|r" + I2S(udg_CounterGH_MoneyTrans[i]) + "|c00ff0000 point to|r" + udg_PN[GetPlayerId( Player(j))] + "|c00ff0000.|r")
                    endif
                endif
                set j = j + 1
            exitwhen j == 12
            endloop
        endif
        set i = i + 1
    exitwhen i == 12
    endloop
    set i = 0
    loop
        set udg_CounterGH_MoneyRecord[i] = udg_CounterGH_MoneyNow[i]
        set i = i + 1
    exitwhen i == 12
    endloop
    set t = null
endfunction

function Trig_MoneyTransfer_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, 0.2, true, function Trig_MoneyTransfer_Main)
    set t = null
endfunction

function InitTrig_MoneyTransfer takes nothing returns nothing
    set gg_trg_MoneyTransfer = CreateTrigger()
    call TriggerAddAction(gg_trg_MoneyTransfer, function Trig_MoneyTransfer_Actions)
endfunction