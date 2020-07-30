function Public_PacQ_AbilityCoolDownRestore takes unit caster, integer level, integer abid returns nothing
    if GetUnitAbilityLevel(caster, 'A0WB') == 1 then
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (30 + 30 * level) * 0.25)
    endif
    if abid == 'A0WE' then
        call AbilityCoolDownResetion(caster, abid, 12)
    else
        call AbilityCoolDownResetion(caster, abid, 12 - level)
    endif
endfunction

function Public_PacQ_AbilityCoolDownRestore_ULT takes unit caster, integer level, integer abid returns nothing
    if GetUnitAbilityLevel(caster, 'A0WB') == 1 then
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (75 + 125 * level) * 0.25)
    endif
    call AbilityCoolDownResetion(caster, abid, 120)
endfunction

function Public_PacQ_MagicDamage takes unit caster, unit target, real damage, integer dtype returns nothing
    local real i = damage
    if GetUnitAbilityLevel(caster, 'A0WA') == 1 then
        set i = i + damage * 0.15
    endif
    if GetUnitAbilityLevel(target, 'A0YM') >= 1 then
        set i = i * (1 + GetUnitAbilityLevel(target, 'A0YM') * 0.05 * GetUnitAbilityLevel(caster, 'A0XH'))
    endif
    call UnitMagicDamageTarget(caster, target, i * 0.955, dtype)
endfunction

function Trig_PachiliAB_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0W9'
endfunction

function Trig_PachiliAB_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 6)
    local unit v
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local boolean k = false
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SetUnitX(u2, px - 70 * Cos(a))
            call SetUnitY(u2, py - 70 * Sin(a))
            call SaveInteger(udg_ht, task, 3, i - 1)
        else
            call SaveInteger(udg_ht, task, 3, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 100.0, iff)
        set v = FirstOfGroup(g)
        if v != null then
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                set k = true
                call UnitDamageTarget(caster, v, 0.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_METAL_HEAVY_SLICE)
                call Public_PacQ_MagicDamage(caster, v, 60 + level * 60 + 2.35 * GetHeroInt(caster, true), 1)
                if GetUnitState(v, UNIT_STATE_LIFE) < GetUnitState(v, UNIT_STATE_MAX_LIFE) * (level * 0.03 + 0.03) then
                    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl", GetUnitX(v), GetUnitY(v)))
                    if IsUnitType(v, UNIT_TYPE_DEAD) == false then
                        call SetUnitInvulnerable(v, false)
                        call UnitRemoveBuffs(v, true, true)
                        call InstantKill(caster, v)
                    endif
                endif
            endif
        endif
        call DestroyGroup(g)
        if k then
            call KillUnit(u)
            call KillUnit(u2)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call KillUnit(u)
        call KillUnit(u2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set u2 = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_PachiliAB_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit u2
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0W9')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0W9')
    set u = CreateUnit(GetOwningPlayer(caster), 'h01T', ox, oy, bj_RADTODEG * a)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'h01R', ox - 70 * Cos(a), oy - 70 * Sin(a), bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 54)
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, 25.0)
    call SaveUnitHandle(udg_ht, task, 6, u2)
    call TimerStart(t, 0.02, true, function Trig_PachiliAB_Main)
    set caster = null
    set u = null
    set u2 = null
    set t = null
endfunction

function InitTrig_PachiliAB takes nothing returns nothing
endfunction