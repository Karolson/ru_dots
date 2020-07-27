function Trig_Remilia01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0CD'
endfunction

function Trig_Remilia01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local group m = LoadGroupHandle(udg_ht, task, 2)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local real d = LoadReal(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolean k = false
    local real damage
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if i / 4 * 4 == i then
            call DestroyEffect(AddSpecialEffect("BatAppear.mdx", px, py))
        endif
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SaveInteger(udg_ht, task, 1, i - 1)
        else
            call SaveInteger(udg_ht, task, 1, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 120.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    set damage = 45 + level * 75 + 2.7 * GetHeroInt(caster, true)
                    call UnitMagicDamageTarget(caster, v, damage, 1)
                    set k = true
                else
                    set damage = 20 + level * 30 + GetHeroInt(caster, true)
                    call UnitAbsDamageTarget(caster, v, damage)
                endif
            endif
        endloop
        call DestroyGroup(g)
        if k then
            call KillUnit(u)
            call SaveInteger(udg_ht, task, 1, 0)
        endif
    else
        if GetWidgetLife(u) > 0.405 then
            call RemoveUnit(u)
        endif
        call ReleaseTimer(t)
        call DestroyGroup(m)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set m = null
    set g = null
    set iff = null
endfunction

function Trig_Remilia01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0CD')
    local group m = CreateGroup()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 6)
    set u = CreateUnit(GetOwningPlayer(caster), 'n029', ox, oy, bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveGroupHandle(udg_ht, task, 2, m)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 104)
    call SaveReal(udg_ht, task, 0, a)
    call SaveReal(udg_ht, task, 1, 24.0)
    call TimerStart(t, 0.02, true, function Trig_Remilia01_Main)
    set caster = null
    set u = null
    set m = null
    set t = null
endfunction

function InitTrig_Remilia01 takes nothing returns nothing
endfunction