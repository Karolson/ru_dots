function BgmPlay takes unit u, integer i returns nothing
    local sound Bgm = null
    if GetTriggerPlayer() == GetLocalPlayer() then
        call StopMusic(false)
    endif
    set Bgm = CreateSound("THDots\\music\\"+udg_PlayerCharacterString[GetPlayerId(GetOwningPlayer(u))]+"0.0mp3",true,false,true,12700,12700,"DefaultEAXON")
    if Bgm != null and udg_HeroBgm[GetPlayerId(GetOwningPlayer(u))] == null then
        if i != 0 then
            call SetSoundVolume(Bgm, i)
        else
            call SetSoundVolume(Bgm, 70)
        endif
        call StartSoundForPlayerBJ(GetOwningPlayer(u), Bgm)
        set udg_HeroBgm[GetPlayerId(GetOwningPlayer(u))] = Bgm
    else
        call SetSoundVolume(udg_HeroBgm[GetPlayerId(GetOwningPlayer(u))], i)
    endif
    set Bgm = null
endfunction

function Trig_Command_BgmOn_Actions takes nothing returns nothing
    local integer i = S2I(SubString(GetEventPlayerChatString(), 7, 10))
    local unit u = GetPlayerCharacter(GetTriggerPlayer())
    call BgmPlay(u, i)
    set u = null
endfunction

function InitTrig_Command_BgmOn takes nothing returns nothing
    set gg_trg_Command_BgmOn = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_BgmOn, function Trig_Command_BgmOn_Actions)
endfunction