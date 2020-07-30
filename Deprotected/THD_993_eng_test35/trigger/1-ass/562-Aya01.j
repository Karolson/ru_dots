function Trig_Aya01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A05K'
endfunction

function Trig_Aya01_Target takes nothing returns boolean
    if GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Aya01_Damage takes nothing returns nothing
    local integer task = GetHandleId(GetTriggeringTrigger())
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local real damage = LoadReal(udg_Hashtable, task, 0)
    call UnitMagicDamageTarget(caster, GetEnteringUnit(), damage, 5)
    set caster = null
endfunction

function Trig_Aya01_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local unit u = LoadUnitHandle(udg_Hashtable, task, 1)
    local trigger trg = LoadTriggerHandle(udg_Hashtable, task, 4)
    local real a = LoadReal(udg_Hashtable, task, 0)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real v = LoadReal(udg_Hashtable, task, 3)
    local real px = ox + v * Cos(a)
    local real py = oy + v * Sin(a)
    local integer z = LoadInteger(udg_Hashtable, task, 2)
    local real damage = LoadReal(udg_Hashtable, task, 7)
    local real area = LoadReal(udg_Hashtable, task, 8)
    local group dg = LoadGroupHandle(udg_Hashtable, task, 6)
    local group g
    local integer flaglevel = R2I(RMinBJ(GetUnitAbilityLevel(caster, 'A1CK') * 1.4, 5)) + 1
    local unit tmp
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if z > 0 and GetCustomState(caster, 6) != 0 == false then
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(caster, px)
            call SetUnitY(caster, py)
            call SetUnitAnimation(caster, "Walk")
            call SetUnitFacing(caster, a * bj_RADTODEG)
            set px = ox - 550 * Cos(a)
            set py = oy - 550 * Sin(a)
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, ox, oy, area, iff)
            loop
                set tmp = FirstOfGroup(g)
            exitwhen tmp == null
                call GroupRemoveUnit(g, tmp)
                if GetWidgetLife(tmp) > 0.405 and IsUnitType(tmp, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(tmp, dg) == false then
                    call GroupAddUnit(dg, tmp)
                    call DebugMsg("Aya Damage")
                    if GetUnitAbilityLevel(tmp, 'B00Y') > 0 and GetUnitAbilityLevel(caster, 'A05K') != 0 and GetUnitAbilityLevel(caster, 'A1CK') != 0 then	
	                    call AbilityCoolDownResetion(caster, 'A05K', 0.05)
                    endif
                    call UnitMagicDamageTarget(caster, tmp, damage / SquareRoot(flaglevel), 5)
                endif
            endloop
            call DestroyGroup(g)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl", ox, oy))
            set z = z - 1
        else
            set z = 0
        endif
        call SaveInteger(udg_Hashtable, task, 2, z)
    else
        if GetUnitAbilityLevel(caster, 'A1CS') == 1 then
            call UnitRemoveAbility(caster, 'A1CS')
        else
            call SetUnitAbilityLevel(caster, 'A1CS', GetUnitAbilityLevel(caster, 'A1CS') - 1)
        endif
        call DestroyGroup(dg)
        call SetUnitFlag(caster, 5, false)
        call IssueImmediateOrder(caster, "stop")
        call SetUnitPathing(caster, true)
        call KillUnit(u)
        call ReleaseTimer(t)
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set dg = null
    set g = null
    set iff = null
    set tmp = null
    set t = null
    set caster = null
    set trg = null
    set u = null
endfunction

function Trig_Aya01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real d = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
    local real damage
    local boolexpr iff
    local integer lv = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit u
    local real v = 30
    local boolean wflag = false
    if GetUnitAbilityLevel(caster, 'A1CK') == 0 then
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
    else
        set v = v + GetUnitAbilityLevel(caster, 'A1CK') * 2 - 2
        call SetUnitAbilityLevel(caster, 'A1CK', GetUnitAbilityLevel(caster, 'A1CK') + 1)
        call UnitManaingTarget(caster, caster, RMinBJ((GetHeroInt(caster, true) - GetHeroInt(caster, false)) * 1.75, 80))
        set wflag = true
    endif
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        set iff = null
        set u = null
        return
    endif
    if GetUnitAbilityLevel(caster, 'A1CS') == 0 then
        call UnitAddAbility(caster, 'A1CS')
    else
        call SetUnitAbilityLevel(caster, 'A1CS', GetUnitAbilityLevel(caster, 'A1CS') + 1)
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    set damage = 30 + lv * 45 + RMaxBJ(1.0 * GetUnitAttack(caster) - 25, 2.2 * GetHeroInt(caster, true))
    if lv == 1 then
        set d = RMinBJ(d, 600.0)
        set d = RMaxBJ(d, 200.0)
        if wflag then
        endif
    elseif lv == 2 then
        set d = RMinBJ(d, 1100.0)
        set d = RMaxBJ(d, 200.0)
        if wflag then
        endif
    elseif lv == 3 then
        set d = RMinBJ(d, 1600.0)
        set d = RMaxBJ(d, 200.0)
        if wflag then
        endif
    else
        set d = RMinBJ(d, 2100.0)
        set d = RMaxBJ(d, 200.0)
        if wflag then
        endif
    endif
    call Trig_BlinkPlaceRealer(ox + Cos(a) * d, oy + Sin(a) * d, d, a)
    set d = udg_SK_BlinkPlace_d
    call SetUnitPathing(caster, false)
    if GetUnitAbilityLevel(caster, 'A1CK') == 0 then
    else
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'n010', ox - 500 * Cos(a), oy - 500 * Sin(a), a * bj_RADTODEG)
    call SetUnitTimeScale(u, 3.0)
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveUnitHandle(udg_Hashtable, task, 1, u)
    call SaveReal(udg_Hashtable, task, 0, a)
    call SaveInteger(udg_Hashtable, task, 2, R2I(d / v))
    call SaveReal(udg_Hashtable, task, 3, v)
    call SaveGroupHandle(udg_Hashtable, task, 6, CreateGroup())
    call SaveReal(udg_Hashtable, task, 7, damage)
    if wflag then
        call SaveReal(udg_Hashtable, task, 8, 180)
    else
        call SaveReal(udg_Hashtable, task, 8, 120)
    endif
    call SetUnitFlag(caster, 5, true)
    call TimerStart(t, 0.02, true, function Trig_Aya01_Loop)
    set caster = null
    set t = null
    set iff = null
    set u = null
endfunction

function InitTrig_Aya01 takes nothing returns nothing
endfunction