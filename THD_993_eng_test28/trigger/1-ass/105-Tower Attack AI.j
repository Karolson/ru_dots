function Trig_Tower_Attack_AI_Conditions takes nothing returns boolean
    if IsUnitType(GetAttacker(), UNIT_TYPE_STRUCTURE) == false then
        return false
    endif
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Tower_Attack_AI_Target takes nothing returns boolean
    if IsUnitIllusion(GetFilterUnit()) then
        return false
    endif
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(udg_TowerAI_Tower)) == false then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Tower_Attack_AI_Target02 takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    return IsUnitAlly(GetFilterUnit(), GetOwningPlayer(udg_TowerAI_Tower)) == false
endfunction

function Trig_Tower_Attack_AI_Actions takes nothing returns nothing
    local unit tower = GetAttacker()
    local unit hero = GetTriggerUnit()
    local group g
    local unit v
    local boolean k = false
    set udg_TowerAI_Tower = tower
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(tower), GetUnitY(tower), 600.0, Filter(function Trig_Tower_Attack_AI_Target))
    set v = FirstOfGroup(g)
    if v != null then
        set k = true
    endif
    call DestroyGroup(g)
    if k == false then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(tower), GetUnitY(tower), 600.0, Filter(function Trig_Tower_Attack_AI_Target02))
        set v = FirstOfGroup(g)
        if v != null then
            set v = GroupPickRandomUnit(g)
            call IssueTargetOrder(tower, "attack", v)
        endif
        call DestroyGroup(g)
    endif
    set tower = null
    set hero = null
    set g = null
    set v = null
endfunction

function InitTrig_Tower_Attack_AI takes nothing returns nothing
endfunction