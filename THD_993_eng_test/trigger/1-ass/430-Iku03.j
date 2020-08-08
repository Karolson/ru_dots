function Trig_Iku03_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'n00E' then
        return false
    endif
    if GetCustomState(GetTriggerUnit(), 1) != 0 then
        return false
    endif
    if GetCustomState(GetTriggerUnit(), 5) != 0 then
        return false
    endif
    return IsMobileUnit(GetTriggerUnit())
endfunction

function Trig_Iku03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit uz = GetPlayerCharacter(GetOwningPlayer(caster))
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real px = LoadReal(udg_ht, task, 0) - ox
    local real py = LoadReal(udg_ht, task, 1) - oy
    local real d = SquareRoot((cx - ox) * (cx - ox) + (cy - oy) * (cy - oy))
    local real a = Atan2(py, px)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer j = 10
    if i < j and d > 60 and not IsUnitType(target, UNIT_TYPE_DEAD) then
        set px = ox + (15.0 + 2.0 * GetUnitAbilityLevel(uz, 'A00Y')) * Cos(a)
        set py = oy + (15.0 + 2.0 * GetUnitAbilityLevel(uz, 'A00Y')) * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_WALKABILITY) or IsUnitInRange(caster, target, 60.0) or IsUnitCCImmune(target) then
            call SaveInteger(udg_ht, task, 1, 20)
        else
            if GetUnitTypeId(target) == 'n006' == false then
                call SetUnitXY(target, px, py)
            endif
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamMissile\\SteamMissile.mdl", px, py))
            call SaveInteger(udg_ht, task, 1, i + 1)
        endif
    else
        call SetUnitPathing(target, true)
        call SetUnitFlag(target, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Iku03_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit hero = GetPlayerCharacter(GetOwningPlayer(caster))
    local integer level = GetUnitAbilityLevel(hero, 'A00Y')
    local real k = 20 + level * 20 + 0.85 * GetHeroInt(hero, true)
    if GetUnitAbilityLevel(hero, 'B01T') > 0 then
        set k = k + 12.5 * GetUnitAbilityLevel(hero, 'A04O')
    endif
    call DebugMsg("03 Skill Action Open")
    call UnitMagicDamageTarget(hero, target, k, 6)
    call SetUnitPathing(target, false)
    call SetUnitFlag(target, 3, true)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, 15 + level * 2)
    call SaveReal(udg_ht, task, 0, GetUnitX(caster))
    call SaveReal(udg_ht, task, 1, GetUnitY(caster))
    call TimerStart(t, 0.04, true, function Trig_Iku03_Main)
    set t = null
    set caster = null
    set target = null
    set hero = null
endfunction

function InitTrig_Iku03 takes nothing returns nothing
endfunction