function Trig_Mokou01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A04U'
endfunction

function Trig_Mokou01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local real d
    local integer level
    local integer i = LoadInteger(udg_ht, task, 1)
    local group g
    local unit v
    local boolexpr iff
    local integer k
    local integer penki = 0
    if i > 0 then
        set px = ox + 30.0 * Cos(a)
        set py = oy + 30.0 * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SetUnitX(caster, px)
            call SetUnitY(caster, py)
            call SaveInteger(udg_ht, task, 1, i - 1)
        else
            call SaveInteger(udg_ht, task, 1, 0)
        endif
    else
        call KillUnit(u)
        call SetUnitFlag(caster, 5, false)
        call SetUnitPathing(caster, true)
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call SetUnitInvulnerable(caster, false)
        set level = LoadInteger(udg_ht, task, 0)
        call UnitMagicDamageTarget(caster, caster, 75 + 75 * level, 1)
        set u = NewDummy(GetOwningPlayer(caster), ox, oy, 270.0)
        call UnitAddAbility(u, 'A04V')
        call SetUnitAbilityLevel(u, 'A04V', level)
        call IssueImmediateOrder(u, "thunderclap")
        call UnitRemoveAbility(u, 'A04V')
        call ReleaseDummy(u)
        set k = GetPlayerId(GetOwningPlayer(caster)) + 1
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, ox, oy, 225, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, 85 + 65 * level + 0.06 * GetUnitState(caster, UNIT_STATE_MAX_LIFE), 5)
                if penki == 0 then
                    set penki = penki + 1
                else
                    set penki = 0
                    call SaveInteger(udg_sht, GetHandleId(caster), 1, LoadInteger(udg_sht, GetHandleId(caster), 1) + 1)
                    set udg_SK_Mokou02_Count[k] = udg_SK_Mokou02_Count[k] + 1
                endif
                if udg_SK_Mokou02_Count[k] >= 4 then
                    set udg_SK_Mokou02_Count[k] = 4
                endif
            endif
        endloop
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set u = CreateUnit(GetOwningPlayer(caster), 'u009', ox, oy, a)
        call UnitApplyTimedLife(u, 'BTLF', 0.01)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", ox, oy))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl", ox, oy))
        set i = 0
        loop
            set a = bj_DEGTORAD * 36.0 * i
            set d = 20.0
            loop
                set d = d + 100.0
                set px = ox + d * Cos(a)
                set py = oy + d * Sin(a)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", px, py))
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl", px, py))
            exitwhen d > 200.0
            endloop
            set i = i + 1
        exitwhen i >= 10
        endloop
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_Mokou01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real dx = GetSpellTargetX() - ox
    local real dy = GetSpellTargetY() - oy
    local real a = Atan2(dy, dx)
    local real d = SquareRoot(dy * dy + dx * dx)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 14)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set u = null
        set t = null
        return
    endif
    call Trig_BlinkPlaceRealer(ox + d * Cos(a), oy + d * Sin(a), d, a)
    set d = udg_SK_BlinkPlace_d
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'u00A', ox, oy, bj_RADTODEG * a)
    call SetUnitFlag(caster, 5, true)
    call SetUnitPathing(caster, false)
    call SetUnitVertexColor(caster, 255, 255, 255, 0)
    call SetUnitInvulnerable(caster, true)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, R2I(d / 30.0 + 0.5))
    call SaveReal(udg_ht, task, 0, a)
    call SaveReal(udg_ht, task, 1, d)
    call TimerStart(t, 0.02, true, function Trig_Mokou01_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Mokou01 takes nothing returns nothing
endfunction