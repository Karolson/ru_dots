function WW_SetUnitScaleSimple takes unit u, real scale returns nothing
    call SetUnitScale(u, scale, scale, scale)
endfunction

function WW_IsPointInLineRange takes real x, real y, real paraA, real paraB, real paraC, real range returns boolean
    local real p = paraA * x + paraB * y + paraC
    local real q = paraA * paraA + paraB * paraB
    if p * p > q * range * range then
        return false
    endif
    return true
endfunction

function Trig_Lunar04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0TF'
endfunction

function Trig_Lunar04_Loop takes nothing returns nothing
    local timer ti = GetExpiredTimer()
    local integer key = GetHandleId(ti)
    local integer limit = LoadInteger(udg_Hashtable, key, 1024)
    local integer loopCount = LoadInteger(udg_Hashtable, key, 2048)
    local unit dummy
    local integer i = 4
    if loopCount <= 0 then
        call ReleaseTimer(ti)
        call FlushChildHashtable(udg_Hashtable, key)
    else
        loop
            set dummy = LoadUnitHandle(udg_Hashtable, key, i)
            call WW_SetUnitScaleSimple(dummy, loopCount / 4.0)
            call SetUnitFlyHeight(dummy, 52 + 8 * loopCount, 0)
            if loopCount == 12 then
                call SetUnitTimeScale(dummy, 0)
            endif
        exitwhen i >= limit
            set i = i + 1
        endloop
        call SaveInteger(udg_Hashtable, key, 2048, loopCount - 1)
    endif
    set ti = null
    set dummy = null
endfunction

function Trig_Lunar04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit dummy
    local unit uEnum
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real angle = Atan2(ty - oy, tx - ox)
    local real dx = 75 * Cos(angle)
    local real dy = 75 * Sin(angle)
    local real radiusLong = 750 + 150 * level
    local real cx = ox + radiusLong * Cos(angle)
    local real cy = oy + radiusLong * Sin(angle)
    local real paraA = ty - oy
    local real paraB = ox - tx
    local real paraC = tx * oy - ox * ty
    local integer limit = 20 + 4 * level
    local group gEnum = CreateGroup()
    local group gFunc = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer hitCount = 0
    local real dmgPerFunc
    local timer ti = CreateTimer()
    local integer key = GetHandleId(ti)
    local real x = ox - dx - dx
    local real y = oy - dy - dy
    local integer i = 4
    call VE_Spellcast(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 140 - 20 * level)
    loop
        set dummy = CreateUnit(GetOwningPlayer(caster), 'u00V', x, y, Rad2Deg(angle))
        call KillUnit(dummy)
        call SaveUnitHandle(udg_Hashtable, key, i, dummy)
    exitwhen i >= limit
        set i = i + 1
        set x = x + dx
        set y = y + dy
    endloop
    call GroupEnumUnitsInRange(gEnum, cx, cy, radiusLong, iff)
    loop
        set uEnum = FirstOfGroup(gEnum)
    exitwhen uEnum == null
        call GroupRemoveUnit(gEnum, uEnum)
        if IsUnitType(uEnum, UNIT_TYPE_DEAD) == false and IsUnitType(uEnum, UNIT_TYPE_STRUCTURE) == false and WW_IsPointInLineRange(GetUnitX(uEnum), GetUnitY(uEnum), paraA, paraB, paraC, 200.0) then
            call GroupAddUnit(gFunc, uEnum)
            set hitCount = hitCount + 1
        endif
    endloop
    call DestroyGroup(gEnum)
    set hitCount = IMinBJ(hitCount, 16)
    call UnitBuffTarget(caster, caster, 20.0, 'A19U', 0)
    call SetUnitAbilityLevel(caster, 'A19U', hitCount)
    set dmgPerFunc = ABCIAllAgi(caster, 100 + level * 100 + hitCount * (29 + level * 11), 0.0)
    loop
        set uEnum = FirstOfGroup(gFunc)
    exitwhen uEnum == null
        call GroupRemoveUnit(gFunc, uEnum)
        call UnitPhysicalDamageTarget(caster, uEnum, dmgPerFunc)
    endloop
    call DestroyGroup(gFunc)
    call SaveInteger(udg_Hashtable, key, 1024, limit)
    call SaveInteger(udg_Hashtable, key, 2048, 15)
    call TimerStart(ti, 0.0625, true, function Trig_Lunar04_Loop)
    set caster = null
    set dummy = null
    set uEnum = null
    set gEnum = null
    set gFunc = null
    set iff = null
    set ti = null
endfunction

function InitTrig_Lunar04 takes nothing returns nothing
endfunction