function BgmOff takes player u returns nothing
    local sound Bgm = null
    if GetLocalPlayer() != GetTriggerPlayer() then
        return
    endif
    set Bgm = udg_HeroBgm[GetPlayerId(u)]
    if Bgm != null then
        call StopSound(Bgm, false, false)
    endif
    call ClearMapMusic()
    call SetMapMusicIndexedBJ(udg_DefaultBGM, 0)
    call PlayMusicBJ(udg_DefaultBGM)
    set Bgm = null
    set udg_HeroBgm[GetPlayerId(u)] = null
endfunction

function Trig_Command_BgmOff_Actions takes nothing returns nothing
    local player u = GetTriggerPlayer()
    call BgmOff(u)
    set u = null
endfunction

function InitTrig_Command_BgmOff takes nothing returns nothing
    set gg_trg_Command_BgmOff = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_BgmOff, function Trig_Command_BgmOff_Actions)
endfunction