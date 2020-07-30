function Orange03Damage takes unit caster returns real
    return ABCIAllInt(caster, 5 + 15 * GetUnitAbilityLevel(caster, 'A0Z3'), 1.0)
endfunction

function Trig_Orange03_Effecting takes unit caster returns nothing
    local group g
    local unit v
    local boolexpr iff
    local integer level = GetUnitAbilityLevel(caster, 'A0Z3')
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    if level != 0 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y))
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, x, y, 250, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if udg_NewDebuffSys then
                    call UnitSlowTargetNew(caster, v, 10 + 5 * level, 2.0, 2, 0)
                else
                    if level == 1 then
                        call UnitSlowTarget(caster, v, 2.0, 'A10W', 'B03E')
                    elseif level == 2 then
                        call UnitSlowTarget(caster, v, 2.0, 'A10X', 'B03E')
                    elseif level == 3 then
                        call UnitSlowTarget(caster, v, 2.0, 'A10Y', 'B03E')
                    elseif level == 4 then
                        call UnitSlowTarget(caster, v, 2.0, 'A10Z', 'B03E')
                    endif
                endif
            endif
        endloop
        call DestroyGroup(g)
        if udg_GameMode / 100 != 3 and udg_NewMid == false then
            call UnitMagicDamageArea(caster, x, y, 250, Orange03Damage(caster), 6)
        else
            call UnitMagicDamageArea(caster, x, y, 250, Orange03Damage(caster) * 1.35, 6)
        endif
    endif
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Orange01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0LP'
endfunction

function Trig_Orange01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolean o
    if t == LoadTimerHandle(udg_ht, GetHandleId(caster), 0) then
        set o = GetUnitCurrentOrder(caster) == OrderId("whirlwind")
        if i > 0 and o then
            set px = ox + 12.5 * Cos(a)
            set py = oy + 12.5 * Sin(a)
            call SetUnitXYGround(caster, px, py)
            call SaveInteger(udg_ht, task, 1, i - 1)
        else
            call Trig_Orange03_Effecting(caster)
            call UnitBuffTarget(caster, caster, 4.0, 'A193', 0)
            if o then
                call IssueImmediateOrder(caster, "stop")
            endif
            call SetUnitFlag(caster, 5, false)
            call SetUnitPathing(caster, true)
            call SetUnitAnimationByIndex(caster, 0)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
            call FlushChildHashtable(udg_ht, GetHandleId(caster))
        endif
    else
        call Trig_Orange03_Effecting(caster)
        call UnitBuffTarget(caster, caster, 3.0, 'A193', 0)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Orange01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real d = SquareRoot(Pow(ty - oy, 2) + Pow(tx - ox, 2))
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 7 - level * 0.5)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set d = RMinBJ(400.0 + GetUnitAbilityLevel(caster, 'A0LP') * 50, d)
    set d = RMaxBJ(225.0, d)
    call SetUnitFacing(caster, bj_RADTODEG * a)
    if GetUnitAbilityLevel(caster, 'A0EP') == 0 then
        call UnitAddAbility(caster, 'A0EP')
    endif
    call IssueImmediateOrder(caster, "whirlwind")
    call SetUnitFlag(caster, 5, true)
    call SetUnitPathing(caster, false)
    call SetUnitAnimation(caster, "Spell")
    call SaveTimerHandle(udg_ht, GetHandleId(caster), 0, t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, R2I(d / 12.5))
    call SaveReal(udg_ht, task, 0, a)
    call TimerStart(t, 0.01, true, function Trig_Orange01_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_Orange01 takes nothing returns nothing
endfunction