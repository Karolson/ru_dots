function Trig_NewEngland04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HL'
endfunction

function Trig_NewEngland04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real dx
    local real dy
    local real tx
    local real ty
    local real v = LoadReal(udg_ht, task, 2)
    local real s = LoadReal(udg_ht, task, 3)
    local real a = LoadReal(udg_ht, task, 4)
    local real e
    local real damage
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolean k = true
    if i > 0 and GetWidgetLife(caster) > 0.405 then
        if IsUnitVisible(target, GetOwningPlayer(caster)) then
            if GetWidgetLife(target) > 0.405 then
                set tx = GetUnitX(target)
                set ty = GetUnitY(target)
                call SaveReal(udg_ht, task, 0, tx)
                call SaveReal(udg_ht, task, 1, ty)
            else
                set tx = LoadReal(udg_ht, task, 0)
                set ty = LoadReal(udg_ht, task, 1)
            endif
            set k = true
        else
            set k = false
        endif
        if k then
            set dy = ty - oy
            set dx = tx - ox
        endif
        if k and SquareRoot(dy * dy + dx * dx) <= 40.0 then
            set damage = 18.0 + level * 6.0 + GetHeroAgi(GetCharacterHandle('H01A'), true) * 1.0
            call UnitPhysicalDamageTarget(caster, target, damage)
            call SaveInteger(udg_ht, task, 1, 0)
            call DebugMsg("Hit the target")
        else
            if k then
                set e = YawError(a, bj_RADTODEG * Atan2(dy, dx))
                if RAbsBJ(e) <= 30.0 then
                    if e >= 0.0 then
                        set e = RMinBJ(e, 2.0)
                    else
                        set e = RMaxBJ(e, -2.0)
                    endif
                    set a = a + e
                    if a < 0.0 then
                        set a = a + 360.0
                    elseif a >= 360.0 then
                        set a = a - 360.0
                    endif
                endif
            endif
            set v = v + 0.025 * (s - v)
            call SaveReal(udg_ht, task, 2, v)
            call SaveReal(udg_ht, task, 4, a)
            call SetUnitFacing(caster, a)
            set v = v / 50.0
            set dx = ox + v * CosBJ(a)
            set dy = oy + v * SinBJ(a)
            if IsTerrainPathable(dx, dy, PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(caster, dx)
                call SetUnitY(caster, dy)
                call SaveInteger(udg_ht, task, 1, i - 1)
            else
                call SaveInteger(udg_ht, task, 1, 0)
            endif
        endif
    else
        if GetWidgetLife(caster) > 0.405 then
            call SetUnitFlag(caster, 5, true)
            call PauseUnit(caster, false)
        endif
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 2))
        set u = CreateUnit(GetOwningPlayer(caster), 'n001', ox, oy, 0.0)
        call SetUnitFlyHeight(u, 100.0, 200000.0)
        call UnitAddAbility(u, 'A0HT')
        call SetUnitAbilityLevel(u, 'A0HT', level)
        call UnitPhysicalDamageArea(u, ox, oy, 200, 18 + level * 6 + GetHeroAgi(GetCharacterHandle('H01A'), true) * 0.4)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", ox, oy))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call KillUnit(caster)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_NewEngland04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local effect e
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitState(caster, UNIT_STATE_LIFE, 0.3 * GetUnitState(caster, UNIT_STATE_LIFE))
    call SelectUnitRemoveForPlayer(caster, GetOwningPlayer(caster))
    call SetUnitFlag(caster, 5, true)
    call PauseUnit(caster, true)
    call UnitAddAbility(caster, 'A0HR')
    set e = AddSpecialEffectTarget("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", caster, "chest")
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveEffectHandle(udg_ht, task, 2, e)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 150)
    call SaveReal(udg_ht, task, 0, GetUnitX(target))
    call SaveReal(udg_ht, task, 1, GetUnitY(target))
    call SaveReal(udg_ht, task, 2, 300.0)
    call SaveReal(udg_ht, task, 3, 900.0)
    call SaveReal(udg_ht, task, 4, a)
    call TimerStart(t, 0.02, true, function Trig_NewEngland04_Main)
    set caster = null
    set target = null
    set t = null
    set e = null
endfunction

function InitTrig_NewEngland04 takes nothing returns nothing
endfunction