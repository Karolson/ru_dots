function Trig_Youmu01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A05X'
endfunction

function Trig_Youmu01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, GetHandleId(caster), 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local real d = LoadReal(udg_ht, task, 1)
    local real damage
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local unit v
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if i < 2 then
        call SaveReal(udg_ht, task, 0, GetUnitFacing(caster) * bj_DEGTORAD)
        set a = GetUnitFacing(caster) * bj_DEGTORAD
    endif
    if GetWidgetLife(caster) >= 0.405 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if SetUnitXYFly(caster, px, py) == false then
            set px = ox
            set py = oy
        endif
        if u != null then
            call SetUnitX(u, px - 30.0 * Cos(a))
            call SetUnitY(u, py - 30.0 * Sin(a))
        endif
    endif
    call SaveInteger(udg_ht, task, 1, i + 1)
    if GetWidgetLife(caster) >= 0.405 and i < 2 then
        set damage = ABCIAllAtk(caster, level * 15, 0.5)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 304.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) >= 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
                call UnitPhysicalDamageTarget(caster, v, damage)
                call VE_Sword(v)
                call UnitDamageTarget(caster, v, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_METAL_HEAVY_SLICE)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", v, "chest"))
            endif
        endloop
        call DestroyGroup(g)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl", px, py))
    else
        call SetUnitPathing(caster, true)
        call SetUnitFlag(caster, 5, false)
        call SetUnitFlag(caster, 1, false)
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        if u != null then
            call SetUnitVertexColor(u, 255, 255, 255, 160)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_Youmu01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u = LoadUnitHandle(udg_sht, GetHandleId(caster), 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real d = SquareRoot(Pow(ty - oy, 2) + Pow(tx - ox, 2))
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15 - 2 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set u = null
        set t = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set d = RMinBJ(400 + level * 100, d)
    call Trig_BlinkPlaceRealer(ox + d * Cos(a), oy + d * Sin(a), d, a)
    set d = udg_SK_BlinkPlace_d
    set d = RMaxBJ(100.0, d) / 3.0
    call SetUnitFlag(caster, 5, true)
    call SetUnitFlag(caster, 1, true)
    call SetUnitVertexColor(caster, 0, 0, 0, 0)
    call SetUnitPathing(caster, false)
    if u != null then
        call SetUnitVertexColor(u, 0, 0, 0, 0)
        call SetUnitX(u, ox - 30.0 * Cos(a))
        call SetUnitY(u, oy - 30.0 * Sin(a))
        call SetUnitFacing(u, bj_RADTODEG * a)
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveReal(udg_ht, task, 0, a)
    call SaveReal(udg_ht, task, 1, d)
    call TimerStart(t, 0.2, true, function Trig_Youmu01_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Youmu01 takes nothing returns nothing
endfunction