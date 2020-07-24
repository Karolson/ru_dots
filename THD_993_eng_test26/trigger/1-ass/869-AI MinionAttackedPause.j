function Trig_AI_MinionAttackedPause_Conditions takes nothing returns boolean
    if IsPlayerInForce(GetOwningPlayer(GetAttacker()), udg_AI_Players) == false then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return true
endfunction

function Trig_AI_MinionAttackedPause_Actions takes nothing returns nothing
    local unit h = GetAttacker()
    local unit k = GetTriggerUnit()
    local real tx
    local real ty
    local group g
    local unit v
    local boolean a = true
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(k), GetUnitY(k), 600, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(k)) and IsUnitType(v, UNIT_TYPE_DEAD) == false then
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                set a = false
            endif
        endif
    endloop
    call DestroyGroup(g)
    if udg_GameTime <= 600 and a then
        if GetUnitState(k, UNIT_STATE_LIFE) <= GetUnitAttack(h) * 0.8 then
        else
            set tx = GetUnitX(h) + Cos(GetRandomInt(0, 360) / bj_RADTODEG) * GetRandomInt(0, 150)
            set ty = GetUnitY(h) + Sin(GetRandomInt(0, 360) / bj_RADTODEG) * GetRandomInt(0, 150)
            call IssuePointOrder(h, "walk", tx, ty)
        endif
    endif
    set h = null
    set v = null
    set g = null
    set k = null
endfunction

function InitTrig_AI_MinionAttackedPause takes nothing returns nothing
    set gg_trg_AI_Minoriko_Attacked = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_MinionAttackedPause, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_AI_MinionAttackedPause, Condition(function Trig_AI_MinionAttackedPause_Conditions))
    call TriggerAddAction(gg_trg_AI_MinionAttackedPause, function Trig_AI_MinionAttackedPause_Actions)
endfunction