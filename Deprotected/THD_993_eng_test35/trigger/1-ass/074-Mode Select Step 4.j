function Trig_Mode_Select_Step_4_Actions takes nothing returns nothing
    local integer i
    set i = 0
    call DisplayTextToForce(GetPlayersAll(), "Turbo mode is:")
    if GetClickedButton() == udg_GameModeIsTurboButton then
        set udg_GameModeIsTurbo = true
        loop
        exitwhen i == 8
            call UnitAddAbility(udg_TowerA[i], 'A00F')
            call UnitAddAbility(udg_TowerB[i], 'A00F')
            set i = i + 1
        endloop
        call DisplayTextToForce(GetPlayersAll(), "[2] On")
    else
        call DisplayTextToForce(GetPlayersAll(), "[1] Off")
    endif
    call DestroyTrigger(GetTriggeringTrigger())
    call DialogDestroy(udg_ModeSelectDialog)
    call DestroyTrigger(gg_trg_Mode_Select_Time_Out)
    call TriggerExecute(gg_trg_Enter_Character_Select_Screen)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Mode_Select_Step_4 takes nothing returns nothing
    set gg_trg_Mode_Select_Step_4 = CreateTrigger()
    call TriggerAddAction(gg_trg_Mode_Select_Step_4, function Trig_Mode_Select_Step_4_Actions)
endfunction