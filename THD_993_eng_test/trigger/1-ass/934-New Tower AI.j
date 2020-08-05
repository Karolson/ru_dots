function Trig_New_Tower_AI_Aggro takes unit caster, unit target returns nothing
    local group g
    local unit v
    local integer i
    local unit prevTarget
    if not IsUnitType(caster, UNIT_TYPE_HERO) or not IsUnitType(target, UNIT_TYPE_HERO) or not IsUnitEnemy(target, GetOwningPlayer(caster)) then
        return
    endif
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 700.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        set i = 0
        loop
            if (v == udg_TowerA[i] or v == udg_TowerB[i]) and IsUnitEnemy(v, GetOwningPlayer(caster)) and IsUnitVisible(caster, GetOwningPlayer(v)) then
                set prevTarget = LoadUnitHandle(udg_Hashtable, StringHash("Tower_AI"), GetHandleId(v))
                if prevTarget == null or IsUnitDead(prevTarget) or IsUnitInvulnerable(prevTarget) or IsUnitHidden(prevTarget) or not IsUnitInRange(v, prevTarget, 700.0) then
                    if IssueTargetOrder(v, "attack", caster) then
                        call SaveUnitHandle(udg_Hashtable, StringHash("Tower_AI"), GetHandleId(v), caster)
                    endif
                endif
            endif
            set i = i + 1
        exitwhen i > 7
        endloop
    endloop
    call DestroyGroup(g)
    set g = null
    set v = null
    set prevTarget = null
endfunction

function Trig_New_Tower_AI_Actions takes nothing returns nothing
    call Trig_New_Tower_AI_Aggro(GetTriggerUnit(), GetOrderTargetUnit())
endfunction

function Trig_New_Tower_AI_Any_Damage_Actions takes nothing returns nothing
    call Trig_New_Tower_AI_Aggro(GetEventDamageSource(), GetTriggerUnit())
endfunction

function InitTrig_New_Tower_AI takes nothing returns nothing
    local trigger trg_New_Tower_AI_Any_Damage = CreateTrigger()
    call TriggerAddAction(trg_New_Tower_AI_Any_Damage, function Trig_New_Tower_AI_Any_Damage_Actions)
    call RegisterAnyUnitDamage(trg_New_Tower_AI_Any_Damage)
    set gg_trg_New_Tower_AI = CreateTrigger()
    call TriggerAddAction(gg_trg_New_Tower_AI, function Trig_New_Tower_AI_Actions)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_New_Tower_AI, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
endfunction