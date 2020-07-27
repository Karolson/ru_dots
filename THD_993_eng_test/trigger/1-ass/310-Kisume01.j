function Trig_Kisume01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0R8'
endfunction

function Trig_Kisume01_Burning takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit w = LoadUnitHandle(udg_ht, task, 0)
    local unit caster = LoadUnitHandle(udg_ht, task, 3)
    local unit v
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local real tx = GetUnitX(w)
    local real ty = GetUnitY(w)
    if i > 0 then
        set i = i - 1
        call UnitMagicDamageArea(caster, tx, ty, 200, ABCIAllInt(caster, 6 + 6 * level, 0.35) / 2, 6)
        call SaveInteger(udg_ht, task, 1, i)
    else
        call KillUnit(w)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set w = null
    set v = null
endfunction

function Trig_Kisume01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local unit w
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local boolean instun = LoadBoolean(udg_ht, task, 6)
    local boolean k = false
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local timer t2
    local integer task2
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SaveInteger(udg_ht, task, 3, i - 1)
        else
            call SaveInteger(udg_ht, task, 3, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 120.0, iff)
        set v = FirstOfGroup(g)
        if v != null then
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if instun then
                    call UnitStunTarget(caster, v, 1.7 + 1.3, 0, 0)
                else
                    call UnitStunTarget(caster, v, 1.3, 0, 0)
                endif
                call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 25 + 40 * level, 1.7), 1)
                set k = true
            endif
        endif
        call DestroyGroup(g)
        if k then
            set t2 = CreateTimer()
            set task2 = GetHandleId(t2)
            set w = CreateUnit(GetOwningPlayer(caster), 'n03F', ox, oy, 0)
            call SaveUnitHandle(udg_ht, task2, 0, w)
            call SaveInteger(udg_ht, task2, 1, 16)
            call SaveInteger(udg_ht, task2, 2, level)
            call SaveUnitHandle(udg_ht, task2, 3, caster)
            call TimerStart(t2, 0.5, true, function Trig_Kisume01_Burning)
            call KillUnit(u)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        set w = CreateUnit(GetOwningPlayer(caster), 'n03F', ox, oy, 0)
        call SaveUnitHandle(udg_ht, task2, 0, w)
        call SaveInteger(udg_ht, task2, 1, 16)
        call SaveInteger(udg_ht, task2, 2, level)
        call TimerStart(t2, 0.5, true, function Trig_Kisume01_Burning)
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set w = null
    set g = null
    set iff = null
    set t2 = null
endfunction

function Trig_Kisume01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0R8')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local boolean instun = false
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 10 - level)
    if udg_SK_KisumeEX_Count >= 4 then
        set udg_SK_KisumeEX_Count = 0
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Well Bucket 'Well Destructor' stacks: |r" + I2S(udg_SK_KisumeEX_Count) + " |r")
        set instun = true
    else
        set udg_SK_KisumeEX_Count = udg_SK_KisumeEX_Count + 1
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Well Bucket 'Well Destructor' stacks: |r" + I2S(udg_SK_KisumeEX_Count) + " |r")
        set instun = false
    endif
    if udg_SK_KisumeEX_Count == 4 then
        call UnitAddAbility(caster, 'A08L')
    endif
    if udg_SK_KisumeEX_Count == 0 then
        call UnitRemoveAbility(caster, 'A08L')
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'n03D', ox, oy, bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 45)
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, 20.0)
    call SaveBoolean(udg_ht, task, 6, instun)
    call TimerStart(t, 0.02, true, function Trig_Kisume01_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Kisume01 takes nothing returns nothing
endfunction