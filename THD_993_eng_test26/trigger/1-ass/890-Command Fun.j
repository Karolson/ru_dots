function Trig_Command_Fun_Actions takes nothing returns nothing
    set udg_ACDShow = true
    call BroadcastMessage("Custom BGM turned on (THDots\\custom.mp3)")
    if GetLocalPlayer() != GetTriggerPlayer() then
        return
    endif
    call ClearMapMusic()
    call SetMapMusicIndexedBJ("THDots\\custom.mp3", 0)
    call PlayMusicBJ("THDots\\custom.mp3")
endfunction

function InitTrig_Command_Fun takes nothing returns nothing
    set gg_trg_Command_Fun = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Fun, function Trig_Command_Fun_Actions)
endfunction