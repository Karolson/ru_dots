function Trig_Weather_Spell_Aura takes integer aID returns nothing
    local integer tID = 'n00X'
    local real x = GetRectCenterX(udg_Weather_Region)
    local real y = GetRectCenterY(udg_Weather_Region)
    local group g = udg_Weather_SpellGroup
    local unit u
    set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), tID, x, y, 270.0)
    call UnitAddAbility(u, aID)
    call GroupAddUnit(g, u)
    set u = CreateUnit(udg_PlayerA[0], tID, x, y, 270.0)
    call UnitAddAbility(u, aID)
    call GroupAddUnit(g, u)
    set u = CreateUnit(udg_PlayerB[0], tID, x, y, 270.0)
    call UnitAddAbility(u, aID)
    call GroupAddUnit(g, u)
    set u = null
    set g = null
endfunction

function Trig_Weather_Spell_Actions takes nothing returns nothing
    local group g = udg_Weather_SpellGroup
    local unit u
    local real x = GetRectCenterX(udg_Weather_Region)
    local real y = GetRectCenterY(udg_Weather_Region)
    if udg_Weather_Type == 0 then
        call Trig_Weather_Spell_Aura('A001')
    endif
    if udg_Weather_Type == 1 then
        call Trig_Weather_Spell_Aura('A005')
    endif
    if udg_Weather_Type == 2 then
        call TriggerExecute(gg_trg_Weather_Spell_02)
        call Trig_Weather_Spell_Aura('A0LJ')
    endif
    if udg_Weather_Type == 3 then
        call Trig_Weather_Spell_Aura('A007')
    endif
    if udg_Weather_Type == 4 then
        call Trig_Weather_Spell_Aura('A004')
    endif
    if udg_Weather_Type == 5 then
        call Trig_Weather_Spell_Aura('A002')
    endif
    if udg_Weather_Type == 6 then
        call Trig_Weather_Spell_Aura('A003')
    endif
    if udg_Weather_Type == 7 then
        call Trig_Weather_Spell_Aura('A0VQ')
    endif
    if udg_Weather_Type == 8 then
        call Trig_Weather_Spell_Aura('A0VR')
    endif
    if udg_Weather_Type == 9 then
        call Trig_Weather_Spell_Aura('A0VS')
    endif
    set g = null
    set u = null
endfunction

function InitTrig_Weather_Effect_Spell takes nothing returns nothing
    set gg_trg_Weather_Effect_Spell = CreateTrigger()
    call TriggerAddAction(gg_trg_Weather_Effect_Spell, function Trig_Weather_Spell_Actions)
endfunction