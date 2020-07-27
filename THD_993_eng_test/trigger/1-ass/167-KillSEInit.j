function InitTrig_KillSEInit takes nothing returns nothing
    set udg_SE_MISS = CreateSound("se_miss.wav", false, false, false, 1, 1, "DefaultEAXON")
    set udg_SE_Kill = CreateSound("se_Kill.mp3", false, false, false, 1, 1, "DefaultEAXON")
    call SetSoundVolume(udg_SE_MISS, 45)
    call SetSoundVolume(udg_SE_Kill, 45)
endfunction