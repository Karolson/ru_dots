function GetCharacterHandle takes integer ID returns unit
    local integer i = 0
    loop
    exitwhen i >= 12
        if GetUnitTypeId(udg_PlayerHeroes[i]) == ID and udg_PlayerHeroFlag[i] == false then
            set udg_PlayerHeroFlag[i] = true
            return udg_PlayerHeroes[i]
        endif
        set i = i + 1
    endloop
    return null
endfunction

function IsDraftMode takes nothing returns boolean
    return ModuloInteger(udg_GameMode, 100) / 10 == 3
endfunction

function IsAllRandom takes nothing returns boolean
    return ModuloInteger(udg_GameMode, 100) / 10 == 7
endfunction

function IsBanMode takes nothing returns boolean
    return ModuloInteger(udg_GameMode, 100) / 10 == 5
endfunction

function IsSoloMode takes nothing returns boolean
    return udg_GameMode / 100 == 2
endfunction

function IsMidMode takes nothing returns boolean
    return udg_GameMode / 100 == 3
endfunction

function IsDMMode takes nothing returns boolean
    return udg_GameMode / 100 == 4
endfunction

function InitTrig_GIB takes nothing returns nothing
endfunction