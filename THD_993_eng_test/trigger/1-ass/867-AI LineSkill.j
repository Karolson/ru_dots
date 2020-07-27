function AI_LastHitMovement takes unit h returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local group g
    local unit v
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, ox, oy, 600, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(h)) and IsUnitType(v, UNIT_TYPE_DEAD) == false then
            if IsUnitType(v, UNIT_TYPE_HERO) then
                if AI_CountingIfRetreat(h, 0.7) == false and GetRandomInt(0, 100) <= 5 then
                    if GetRandomInt(0, 4) == 0 then
                        set udg_AI_KillTargetA = v
                    elseif GetRandomInt(0, 4) == 0 then
                        set udg_AI_KillTargetB = v
                    elseif GetRandomInt(0, 4) == 0 then
                        set udg_AI_KillTargetC = v
                    else
                        set udg_AI_KillTargetD = v
                    endif
                endif
            elseif IsUnitType(v, UNIT_TYPE_STRUCTURE) then
            elseif udg_GameTime <= 600 then
                if GetUnitState(v, UNIT_STATE_LIFE) <= GetUnitAttack(h) * 0.8 then
                    if GetUnitAbilityLevel(h, 'A19W') == 1 then
                        call IssueTargetOrder(h, "attack", v)
                    endif
                endif
            endif
        else
            if udg_GameTime <= 600 then
                if GetUnitState(v, UNIT_STATE_LIFE) <= GetUnitAttack(h) * 0.8 then
                    if GetUnitAbilityLevel(h, 'A19W') == 1 then
                        call IssueTargetOrder(h, "attack", v)
                    endif
                endif
            endif
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    set v = null
endfunction

function AI_RetreatForGank takes unit h returns nothing
    local real atr = 1.5
    if udg_GameTime >= 1800 then
        set atr = 1.1
    elseif udg_GameTime >= 600 then
        set atr = 1.3
    endif
    if AI_CountingIfRetreat(h, atr) then
        call AI_IssueRetreatOrder(h)
    endif
endfunction

function InitTrig_AI_LineSkill takes nothing returns nothing
endfunction