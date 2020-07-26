function Trig_Momizi02_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A09V'
endfunction

function Trig_Momizi02_Learn_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call UnitAddAttackDamage(u, 8)
    else
        call UnitAddAttackDamage(u, 12)
    endif
    set u = null
endfunction

function InitTrig_Momizi02_Learn takes nothing returns nothing
endfunction