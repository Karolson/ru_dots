function Trig_PachiliAD_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WE'
endfunction

function Trig_PachiliAD_Target takes nothing returns boolean
    if GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_FLYING) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'Aloc') != 0 then
        return false
    elseif GetCustomState(GetTriggerUnit(), 1) != 0 then
        return false
    endif
    return IsMobileUnit(GetTriggerUnit())
endfunction

function Trig_PachiliAD_Repel takes nothing returns nothing
    local integer task = GetHandleId(GetTriggeringTrigger())
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = GetEnteringUnit()
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local location p1 = LoadLocationHandle(udg_ht, task, 2)
    local location p2 = LoadLocationHandle(udg_ht, task, 3)
    local real int = LoadReal(udg_ht, task, 0)
    local real damage
    local real px = GetUnitX(GetTriggerUnit())
    local real py = GetUnitY(GetTriggerUnit())
    local real x1 = px - GetLocationX(p1)
    local real y1 = py - GetLocationY(p1)
    local real x2 = px - GetLocationX(p2)
    local real y2 = py - GetLocationY(p2)
    local real a
    set a = 1 / SquareRoot(x1 * x1 + y1 * y1)
    set x1 = x1 * a
    set y1 = y1 * a
    set a = 1 / SquareRoot(x2 * x2 + y2 * y2)
    set x2 = x2 * a
    set y2 = y2 * a
    set a = Atan2(y1 + y2, x1 + x2)
    set px = px + 100.0 * Cos(a)
    set py = py + 100.0 * Sin(a)
    set damage = 14 + 14 * GetUnitAbilityLevel(caster, 'A0WE') + 0.6 * GetHeroInt(caster, true)
    if IsUnitFree(target) and GetUnitTypeId(target) == 'n006' == false then
        call SetUnitX(target, px)
        call SetUnitY(target, py)
    endif
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", target, "chest"))
    call Public_PacQ_MagicDamage(caster, target, damage, 5)
    set caster = null
    set target = null
    set u = null
    set p1 = null
    set p2 = null
endfunction

function Trig_PachiliAD_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local trigger trg
    local boolexpr tgb
    local triggeraction tga
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer n = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer z = LoadInteger(udg_ht, task, 2)
    local integer s = LoadInteger(udg_ht, task, 3)
    if GetUnitState(u, UNIT_STATE_LIFE) > 0 and z > 0 then
        set u = LoadUnitHandle(udg_ht, task, 7 + i)
        call SetUnitAnimation(u, "stand")
        if i + s > n or i + s < 1 then
            set s = -1 * s
        endif
        call SaveInteger(udg_ht, task, 1, i + s)
        call SaveInteger(udg_ht, task, 2, z - 1)
        call SaveInteger(udg_ht, task, 3, s)
    else
        call ReleaseTimer(t)
        set trg = LoadTriggerHandle(udg_ht, task, 4)
        set tgb = LoadBooleanExprHandle(udg_ht, task, 5)
        set tga = LoadTriggerActionHandle(udg_ht, task, 6)
        call TriggerRemoveAction(trg, tga)
        call DestroyBoolExpr(tgb)
        call DestroyTrigger(trg)
        set i = 1
        loop
        exitwhen i > n
            call KillUnit(LoadUnitHandle(udg_ht, task, 7 + i))
            set i = i + 1
        endloop
        call RemoveLocation(LoadLocationHandle(udg_ht, task, 2))
        call RemoveLocation(LoadLocationHandle(udg_ht, task, 3))
        call FlushChildHashtable(udg_ht, task)
        call FlushChildHashtable(udg_ht, GetHandleId(trg))
    endif
    set t = null
    set caster = null
    set trg = null
    set tga = null
    set tgb = null
    set u = null
endfunction

function Trig_PachiliAD_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local trigger trg = CreateTrigger()
    local boolexpr tgb
    local triggeraction tga
    local integer stask = GetHandleId(trg)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit u
    local real s
    local real a
    local real d
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px = GetSpellTargetX()
    local real py = GetSpellTargetY()
    local real dx
    local real dy
    local real ux
    local real uy
    local location p1
    local location p2
    local integer z
    local integer n
    local integer i
    local integer level = GetUnitAbilityLevel(caster, 'A0WE')
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0WE')
    set a = Atan2(py - oy, px - ox) * bj_RADTODEG
    set d = 32.0 * (3 + level)
    set p1 = Location(px + d * CosBJ(a + 90), py + d * SinBJ(a + 90))
    set p2 = Location(px + d * CosBJ(a - 90), py + d * SinBJ(a - 90))
    set n = 7 + level * 2
    set dx = (GetLocationX(p2) - GetLocationX(p1)) / I2R(n)
    set dy = (GetLocationY(p2) - GetLocationY(p1)) / I2R(n)
    set i = 1
    loop
    exitwhen i > n
        set a = Pow(-1, I2R(i - 1)) * I2R(i / 2) * 5.0
        set ux = GetLocationX(p1) + (I2R(i) - 0.5) * dx
        set uy = GetLocationY(p1) + (I2R(i) - 0.5) * dy
        set u = CreateUnit(GetOwningPlayer(caster), 'n03B', ux, uy, 0)
        call TriggerRegisterUnitInRange(trg, u, 40.0, iff)
        call SaveUnitHandle(udg_ht, task, 7 + i, u)
        call SetUnitX(u, ux)
        call SetUnitY(u, uy)
        set i = i + 1
    endloop
    set tgb = Condition(function Trig_PachiliAD_Target)
    call TriggerAddCondition(trg, tgb)
    set tga = TriggerAddAction(trg, function Trig_PachiliAD_Repel)
    set u = LoadUnitHandle(udg_ht, task, 8)
    set s = 0.3 / I2R(n)
    set z = R2I(6.0 / s)
    call SaveInteger(udg_ht, task, 0, n)
    call SaveInteger(udg_ht, task, 1, 1)
    call SaveInteger(udg_ht, task, 2, z)
    call SaveInteger(udg_ht, task, 3, 1)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveLocationHandle(udg_ht, task, 2, p1)
    call SaveLocationHandle(udg_ht, task, 3, p2)
    call SaveTriggerHandle(udg_ht, task, 4, trg)
    call SaveBooleanExprHandle(udg_ht, task, 5, tgb)
    call SaveTriggerActionHandle(udg_ht, task, 6, tga)
    call TimerStart(t, s, true, function Trig_PachiliAD_Main)
    call SaveReal(udg_ht, stask, 0, GetUnitAbilityLevel(caster, 'A0WE'))
    call SaveUnitHandle(udg_ht, stask, 0, caster)
    call SaveUnitHandle(udg_ht, stask, 1, u)
    call SaveLocationHandle(udg_ht, stask, 2, p1)
    call SaveLocationHandle(udg_ht, stask, 3, p2)
    call SaveTriggerActionHandle(udg_ht, stask, 4, tga)
    call SaveBooleanExprHandle(udg_ht, stask, 5, tgb)
    set t = null
    set caster = null
    set trg = null
    set tgb = null
    set tga = null
    set iff = null
    set u = null
    set p1 = null
    set p2 = null
endfunction

function InitTrig_PachiliAD takes nothing returns nothing
endfunction