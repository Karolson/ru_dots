function Trig_PachiliBE_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0XG'
endfunction

function Trig_PachiliBE_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real ox = LoadReal(udg_ht, task, 1)
    local real oy = LoadReal(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 5)
    local real d = LoadReal(udg_ht, task, 6)
    local group m = LoadGroupHandle(udg_ht, task, 7)
    local integer j = LoadInteger(udg_ht, task, 8)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    if i > 0 then
        set px = ox + (60 - i) * d * Cos(a)
        set py = oy + (60 - i) * d * Sin(a)
        if i / 3 * 3 == i then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", px, py))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl", px, py))
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 125.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                set j = j + 1
                call DestroyEffect(AddSpecialEffect("UltimateWindFlash.mdx", GetUnitX(v), GetUnitY(v)))
                call Public_PacQ_MagicDamage(caster, v, (39 + level * 39 + 1.65 * GetHeroInt(caster, true)) * (0.85 + j * 0.15), 5)
            endif
        endloop
        call DestroyGroup(g)
        call SaveInteger(udg_ht, task, 4, i - 1)
        call SaveInteger(udg_ht, task, 8, j)
    else
        call DestroyGroup(m)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set m = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_PachiliBE_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0XG')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local group m
    local timer t
    local integer task
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0XG')
    set t = CreateTimer()
    set task = GetHandleId(t)
    set m = CreateGroup()
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, ox)
    call SaveReal(udg_ht, task, 2, oy)
    call SaveInteger(udg_ht, task, 3, level)
    call SaveInteger(udg_ht, task, 4, 54)
    call SaveReal(udg_ht, task, 5, a)
    call SaveReal(udg_ht, task, 6, 25)
    call SaveGroupHandle(udg_ht, task, 7, m)
    call SaveInteger(udg_ht, task, 8, 0)
    call TimerStart(t, 0.02, true, function Trig_PachiliBE_Main)
    set caster = null
    set m = null
    set t = null
endfunction

function InitTrig_PachiliBE takes nothing returns nothing
endfunction