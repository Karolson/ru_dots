function Trig_Weather_Spell_02_Actions takes nothing returns nothing
    local integer i
    local unit h
    set i = 0
    loop
        set h = udg_PlayerHeroes[i]
        if h != null then
            call UnitAddAbility(h, 'A0LI')
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    set h = null
endfunction

function InitTrig_Weather_Spell_02 takes nothing returns nothing
    set gg_trg_Weather_Spell_02 = CreateTrigger()
    call TriggerAddAction(gg_trg_Weather_Spell_02, function Trig_Weather_Spell_02_Actions)
endfunction