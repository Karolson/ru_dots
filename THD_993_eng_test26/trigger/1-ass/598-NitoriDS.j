function NitoriDS takes nothing returns boolean
    if GetWidgetLife(GetPlayerCharacter(GetTriggerPlayer())) >= 0.405 then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00INT bonus:|r " + I2S(udg_Nitori_RealInt))
    endif
    return false
endfunction

function InitTrig_NitoriDS takes nothing returns nothing
endfunction