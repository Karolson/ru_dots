function Trig_SuwakoEx_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A032'
endfunction

function Trig_Suwako03_ManaRe takes unit caster, real damage returns nothing
    local integer level = GetUnitAbilityLevel(caster, 'A0FK')
    if level >= 1 then
        call UnitManaingTarget(caster, caster, (0.04 + 0.02 * level) * damage)
    endif
endfunction

function Trig_SuwakoEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local group m = LoadGroupHandle(udg_ht, task, 2)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local integer k = LoadInteger(udg_ht, task, 6)
    local real damage
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitXY(u, px, py)
            call SaveInteger(udg_ht, task, 3, i - 1)
        else
            call SaveInteger(udg_ht, task, 3, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 75.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false and k > 0 then
                call GroupAddUnit(m, v)
                set k = k - 1
                set damage = 22 + GetHeroInt(caster, true) * 2.22
                call UnitPhysicalDamageTarget(caster, v, damage)
                call UnitDamageTarget(caster, v, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_METAL_HEAVY_SLICE)
                call UnitHealingTarget(caster, caster, 0.22 * damage)
                call UnitManaingTarget(caster, caster, 0.022 * damage)
                call Trig_Suwako03_ManaRe(caster, damage)
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetUnitX(v), GetUnitY(v)))
            endif
        endloop
        call SaveInteger(udg_ht, task, 6, k)
        if k == 0 then
            call SaveInteger(udg_ht, task, 3, 0)
        endif
        call DestroyGroup(g)
    else
        call RemoveUnit(u)
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

function Trig_SuwakoEx_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = Atan2(GetSpellTargetY() - oy, GetSpellTargetX() - ox) * bj_RADTODEG
    local group m = CreateGroup()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A032', 2.22)
    else
        call AbilityCoolDownResetion(caster, 'A032', 1.11)
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'e01Y', ox, oy, a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveGroupHandle(udg_ht, task, 2, m)
    call SaveInteger(udg_ht, task, 3, 35)
    call SaveReal(udg_ht, task, 4, a * 0.017454)
    call SaveReal(udg_ht, task, 5, 20.0)
    call SaveInteger(udg_ht, task, 6, 3)
    call TimerStart(t, 0.02, true, function Trig_SuwakoEx_Main)
    set caster = null
    set u = null
    set m = null
    set t = null
endfunction

function InitTrig_SuwakoEx takes nothing returns nothing
endfunction