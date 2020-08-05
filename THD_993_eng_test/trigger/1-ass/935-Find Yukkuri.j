function FilterYukkuri takes nothing returns boolean
    local integer id = GetUnitTypeId(GetFilterUnit())
    if id == 'u017' or id == 'h00B' or id == 'h02N' or id == 'h02O' or id == 'h00I' then
        return true
    endif
    return false
endfunction

function Trig_Find_Yukkuri_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A02R' then
        return true
    endif
    return false
endfunction

function Trig_Find_Yukkuri_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local unit v
    local group g = CreateGroup()
    local filterfunc f = Filter(function FilterYukkuri)
    call GroupEnumUnitsOfPlayer(g, p, f)
    set v = FirstOfGroup(g)
    if v == null then
        call DisplayTextToPlayer(p, 0, 0, "Oops, no yukkuri found!")
    else
        if GetLocalPlayer() == p then
            call SelectUnit(GetTriggerUnit(), false)
        endif
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetLocalPlayer() == p then
                call SelectUnit(v, true)
            endif
        endloop
    endif
    call DestroyGroup(g)
    call DestroyFilter(f)
    set p = null
    set v = null
    set g = null
    set f = null
endfunction

function InitTrig_Find_Yukkuri takes nothing returns nothing
    set gg_trg_Find_Yukkuri = CreateTrigger()
    call TriggerAddAction(gg_trg_Find_Yukkuri, function Trig_Find_Yukkuri_Actions)
    call TriggerAddCondition(gg_trg_Find_Yukkuri, Condition(function Trig_Find_Yukkuri_Conditions))
    call TriggerRegisterAnyUnitEventFix(gg_trg_Find_Yukkuri, EVENT_PLAYER_UNIT_SPELL_EFFECT)
endfunction