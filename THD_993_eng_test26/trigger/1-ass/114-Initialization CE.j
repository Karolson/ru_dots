function CE_Response_Decay takes nothing returns nothing
    local integer c = udg_CE_state[0]
    local integer i
    local real u
    local real d
    if c / 2 * 2 == c then
        set i = 256
        loop
        exitwhen i >= 512
            set u = udg_CE_Response[i + 256]
            set udg_CE_Response[i] = 0.9 * udg_CE_Response[i] + u
            set udg_CE_Response[i + 256] = 0.0
            set i = i + 1
        endloop
    else
        set i = 0
        loop
        exitwhen i >= 256
            set d = udg_CE_Response[i + 256]
            set udg_CE_Response[i] = 0.8 * udg_CE_Response[i] + 0.5 * d
            set i = i + 1
        endloop
    endif
    set udg_CE_state[0] = c + 1
endfunction

function Trig_Initialization_CE_Actions takes nothing returns nothing
    local integer i
    local timer t
    set i = 0
    loop
    exitwhen i >= 32
        set udg_CE_state[i] = 0
        set udg_CE_register[i] = 0
        set i = i + 1
    endloop
    set i = 0
    loop
    exitwhen i >= 1024
        set udg_CE_Response[i] = 0.0
        set i = i + 1
    endloop
    set t = CreateTimer()
    call TimerStart(t, 0.05, true, function CE_Response_Decay)
    set t = null
endfunction

function InitTrig_Initialization_CE takes nothing returns nothing
    set gg_trg_Initialization_CE = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization_CE, function Trig_Initialization_CE_Actions)
endfunction