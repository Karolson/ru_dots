function Trig_Orange02_Spell_Conditions takes nothing returns boolean
    return GetTriggerUnit() == udg_SK_Chen02
endfunction

function Trig_Orange02_Spell_Actions takes nothing returns nothing
    set udg_SK_Chen02_Stun = true
endfunction

function InitTrig_Orange02_Spell takes nothing returns nothing
endfunction