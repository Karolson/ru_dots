function Trig_Yuugi_Roar_Conditions takes nothing returns boolean
    if IsUnitType(udg_SK_Yuugi, UNIT_TYPE_DEAD) then
        return false
    endif
    if udg_SK_Yuugi_Roar_CD then
        return false
    endif
    return GetUnitState(udg_SK_Yuugi, UNIT_STATE_LIFE) > 0 and GetUnitState(udg_SK_Yuugi, UNIT_STATE_LIFE) / GetUnitState(udg_SK_Yuugi, UNIT_STATE_MAX_LIFE) <= 0.2
endfunction

function Trig_Yuugi_Roar_Target takes nothing returns boolean
    if GetFilterUnit() == udg_SK_Yuugi then
        return false
    endif
    return IsUnitAlly(GetFilterUnit(), GetOwningPlayer(udg_SK_Yuugi))
endfunction

function Trig_Yuugi_Roar_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    set udg_SK_Yuugi_Roar_CD = false
    call ReleaseTimer(t)
    set t = null
endfunction

function Trig_Yuugi_Roar_Actions takes nothing returns nothing
    local unit caster = udg_SK_Yuugi
    local unit v
    local unit w
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local group g = CreateGroup()
    local boolexpr iff = Filter(function Trig_Yuugi_Roar_Target)
    local timer t = CreateTimer()
    set udg_SK_Yuugi_Roar_CD = true
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl", ox, oy))
    set w = CreateUnit(GetOwningPlayer(caster), 'n001', ox, oy, 0)
    call UnitAddAbility(w, 'A0RM')
    call SetUnitAbilityLevel(w, 'A0RM', 1)
    call IssueTargetOrder(w, "innerfire", caster)
    call GroupEnumUnitsInRange(g, ox, oy, 1.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAliveBJ(v) and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            set w = CreateUnit(GetOwningPlayer(caster), 'n001', ox, oy, 0)
            call UnitAddAbility(w, 'A0RM')
            call SetUnitAbilityLevel(w, 'A0RM', 2)
            call IssueTargetOrder(w, "innerfire", v)
        endif
    endloop
    call DestroyGroup(g)
    call TimerStart(t, 90.0, false, function Trig_Yuugi_Roar_Clear)
    set caster = null
    set v = null
    set w = null
    set g = null
    set iff = null
    set t = null
endfunction

function InitTrig_Yuugi_Roar takes nothing returns nothing
endfunction