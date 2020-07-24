function Trig_Toramaru04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0SR'
endfunction

function Trig_Toramaru04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local group m = LoadGroupHandle(udg_ht, task, 1)
    local group g
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer j
    local integer k = LoadInteger(udg_ht, task, 9)
    local real a = LoadReal(udg_ht, task, 4)
    local real ox = LoadReal(udg_ht, task, 5)
    local real oy = LoadReal(udg_ht, task, 6)
    local real tx = LoadReal(udg_ht, task, 7)
    local real ty = LoadReal(udg_ht, task, 8)
    local real px = 0
    local real py = 0
    local unit array u
    local unit w
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real damage
    local real duration
    if i != 100 then
        if k == 0 then
            set k = -90
        else
            set k = 90
        endif
        call SetUnitVertexColor(caster, 255, 255, 255, 255 - R2I(i * 2.55))
        call SetUnitXY(caster, ox + i * 3 * Cos(a - k / bj_RADTODEG), oy + i * 3 * Sin(a - k / bj_RADTODEG))
        call SaveInteger(udg_ht, task, 3, i + 1)
    elseif IsUnitType(caster, UNIT_TYPE_DEAD) == false and i == 100 then
        call PauseUnit(caster, false)
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call SetUnitXY(caster, tx, ty)
        set u[0] = CreateUnit(GetOwningPlayer(caster), 'e01S', tx, ty, 90)
        set u[1] = CreateUnit(GetOwningPlayer(caster), 'e01S', tx, ty, 162)
        set u[2] = CreateUnit(GetOwningPlayer(caster), 'e01S', tx, ty, 234)
        set u[3] = CreateUnit(GetOwningPlayer(caster), 'e01S', tx, ty, 306)
        set u[4] = CreateUnit(GetOwningPlayer(caster), 'e01S', tx, ty, 18)
        set i = 0
        set damage = 40 + level * 80 + 1.8 * GetHeroInt(caster, true)
        set duration = 1.0 + level * 0.5
        call VE_Spellcast(caster)
        loop
        exitwhen i == 5
            set j = 2
            loop
            exitwhen j == 20
                set px = tx + j * 50 * Cos((i * 72 + 90) * 0.017454)
                set py = ty + j * 50 * Sin((i * 72 + 90) * 0.017454)
                set g = CreateGroup()
                call GroupEnumUnitsInRange(g, px, py, 175.0, iff)
                loop
                    set v = FirstOfGroup(g)
                exitwhen v == null
                    call GroupRemoveUnit(g, v)
                    if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                        call GroupAddUnit(m, v)
                        call UnitMagicDamageTarget(caster, v, damage, 5)
                        call UnitStunTarget(caster, v, duration, 0, 0)
                    endif
                endloop
                call DestroyGroup(g)
                set j = j + 1
            endloop
            set i = i + 1
        endloop
        if udg_SK_ToramaruDB_Count > 0 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
        endif
        call ReleaseTimer(t)
        call DestroyGroup(m)
        call FlushChildHashtable(udg_ht, task)
    elseif IsUnitType(caster, UNIT_TYPE_DEAD) then
        call PauseUnit(caster, false)
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call ReleaseTimer(t)
        call DestroyGroup(m)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set m = null
    set g = null
    set u[0] = null
    set u[1] = null
    set u[2] = null
    set u[3] = null
    set u[4] = null
    set w = null
    set v = null
    set iff = null
endfunction

function Trig_Toramaru04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0SR')
    local group m
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A0SR', 150)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set m = null
        set t = null
        return
    endif
    set m = CreateGroup()
    set t = CreateTimer()
    set task = GetHandleId(t)
    if udg_SK_ToramaruDB_Count > 0 then
        set udg_SK_ToramaruDB_Count = udg_SK_ToramaruDB_Count - 1
        call Trig_ToramaruDB_Change()
        call UnitHealingTarget(caster, caster, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02)
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.02)
    endif
    call PauseUnit(caster, true)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveGroupHandle(udg_ht, task, 1, m)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 0)
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, ox)
    call SaveReal(udg_ht, task, 6, oy)
    call SaveReal(udg_ht, task, 7, tx)
    call SaveReal(udg_ht, task, 8, ty)
    call SaveInteger(udg_ht, task, 9, GetRandomInt(0, 1))
    call TimerStart(t, 0.01, true, function Trig_Toramaru04_Main)
    set caster = null
    set m = null
    set t = null
endfunction

function InitTrig_Toramaru04 takes nothing returns nothing
endfunction