function Trig_Koakuma_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0MT' or GetSpellAbilityId() == 'A0NH'
endfunction

function Trig_Koakuma_Target takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    elseif LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 1) == GetFilterUnit() then
        return false
    elseif GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    return true
endfunction

function Trig_Koakuma_Target2 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    elseif LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 1) == GetFilterUnit() then
        return false
    elseif GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Koakuma_Target3 takes nothing returns boolean
    if LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 1) == GetFilterUnit() then
        return false
    endif
    return GetUnitTypeId(GetFilterUnit()) == 'E01E'
endfunction

function Trig_Koakuma02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    if GetUnitAbilityLevel(target, 'A0NO') > 0 then
        call UnitRemoveAbility(target, 'A0NO')
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function Trig_Koakuma02_StartTimer takes unit target returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call TimerStart(t, 4.0, false, function Trig_Koakuma02_Clear)
    set t = null
    set target = null
endfunction

function Trig_Koakuma_SlowTarget takes unit caster, unit target, integer level returns nothing
    local real duration = 3
    call UnitRemoveAbility(target, 'A15Y')
    call UnitRemoveAbility(target, 'A15Z')
    call UnitRemoveAbility(target, 'A160')
    call UnitRemoveAbility(target, 'A161')
    call UnitRemoveAbility(target, 'A162')
    call UnitRemoveAbility(target, 'A163')
    call UnitRemoveAbility(target, 'A164')
    call UnitRemoveAbility(target, 'A165')
    call UnitRemoveAbility(target, 'A166')
    call UnitRemoveAbility(target, 'A167')
    call UnitRemoveAbility(target, 'A168')
    call UnitRemoveAbility(target, 'A169')
    call UnitRemoveAbility(target, 'A16A')
    call UnitRemoveAbility(target, 'A16B')
    call UnitRemoveAbility(target, 'A16C')
    call UnitRemoveAbility(target, 'A16D')
    call UnitRemoveAbility(target, 'A16E')
    call UnitRemoveAbility(target, 'A16F')
    call UnitRemoveAbility(target, 'A16G')
    call UnitRemoveAbility(target, 'A16H')
    call UnitRemoveAbility(target, 'A16I')
    call UnitRemoveAbility(target, 'A16J')
    call UnitRemoveAbility(target, 'A16K')
    call UnitRemoveAbility(target, 'A16L')
    call UnitRemoveAbility(target, 'B078')
    if caster == target then
        set duration = 0.01
    endif
    if level == 1 then
        call UnitSlowTarget(caster, target, duration, 'A15Y', 'B078')
    elseif level == 2 then
        call UnitSlowTarget(caster, target, duration, 'A15Z', 'B078')
    elseif level == 3 then
        call UnitSlowTarget(caster, target, duration, 'A160', 'B078')
    elseif level == 4 then
        call UnitSlowTarget(caster, target, duration, 'A161', 'B078')
    elseif level == 5 then
        call UnitSlowTarget(caster, target, duration, 'A162', 'B078')
    elseif level == 6 then
        call UnitSlowTarget(caster, target, duration, 'A163', 'B078')
    elseif level == 7 then
        call UnitSlowTarget(caster, target, duration, 'A164', 'B078')
    elseif level == 8 then
        call UnitSlowTarget(caster, target, duration, 'A165', 'B078')
    elseif level == 9 then
        call UnitSlowTarget(caster, target, duration, 'A166', 'B078')
    elseif level == 10 then
        call UnitSlowTarget(caster, target, duration, 'A167', 'B078')
    elseif level == 11 then
        call UnitSlowTarget(caster, target, duration, 'A168', 'B078')
    elseif level == 12 then
        call UnitSlowTarget(caster, target, duration, 'A169', 'B078')
    elseif level == 13 then
        call UnitSlowTarget(caster, target, duration, 'A16A', 'B078')
    elseif level == 14 then
        call UnitSlowTarget(caster, target, duration, 'A16B', 'B078')
    elseif level == 15 then
        call UnitSlowTarget(caster, target, duration, 'A16C', 'B078')
    elseif level == 16 then
        call UnitSlowTarget(caster, target, duration, 'A16D', 'B078')
    elseif level == 17 then
        call UnitSlowTarget(caster, target, duration, 'A16E', 'B078')
    elseif level == 18 then
        call UnitSlowTarget(caster, target, duration, 'A16F', 'B078')
    elseif level == 19 then
        call UnitSlowTarget(caster, target, duration, 'A16G', 'B078')
    elseif level == 20 then
        call UnitSlowTarget(caster, target, duration, 'A16H', 'B078')
    elseif level == 21 then
        call UnitSlowTarget(caster, target, duration, 'A16I', 'B078')
    elseif level == 22 then
        call UnitSlowTarget(caster, target, duration, 'A16J', 'B078')
    elseif level == 23 then
        call UnitSlowTarget(caster, target, duration, 'A16K', 'B078')
    else
        call UnitSlowTarget(caster, target, duration, 'A16L', 'B078')
    endif
endfunction

function Trig_Koakuma_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local unit v
    local unit w
    local integer sktype = LoadInteger(udg_ht, task, 3)
    local integer sklevel = LoadInteger(udg_ht, task, 4)
    local integer jumpi = LoadInteger(udg_ht, task, 5)
    local integer kmlevel = LoadInteger(udg_ht, task, 6)
    local boolean kmswitch = LoadBoolean(udg_ht, task, 7)
    local integer jumptimes = LoadInteger(udg_ht, task, 8)
    local integer aonolevel = 0
    local real mspeed = LoadReal(udg_ht, task, 9)
    local real jumpdeplz
    local real kmswitchincre
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real px
    local real py
    local real a = Atan2(ty - oy, tx - ox)
    local group g
    local boolexpr iff
    local boolexpr iff2
    local boolexpr iff3
    local boolean k = false
    local integer i = 0
    if target == null then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        set target = null
        set u = null
        set v = null
        set w = null
        set g = null
        set iff = null
        set iff2 = null
        set iff3 = null
        return
    endif
    set px = ox + mspeed * Cos(a)
    set py = oy + mspeed * Sin(a)
    call SetUnitXY(u, px, py)
    call SetUnitFacing(u, bj_RADTODEG * a)
    if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < mspeed + 4.0 then
        set jumpdeplz = 1.0
        loop
        exitwhen i == jumptimes
            set jumpdeplz = jumpdeplz * (1 - 0.08)
            set i = i + 1
        endloop
        if kmswitch == false then
            set kmswitchincre = 1.0
        else
            set kmswitchincre = 1.0 + kmlevel * 0.1
        endif
        if sktype == 'A0MT' then
            if IsUnitAlly(caster, GetOwningPlayer(target)) == false then
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\FragmentationShards\\FragBoomSpawn.mdl", GetUnitX(target), GetUnitY(target)))
                call UnitMagicDamageTarget(caster, target, (30 + 35 * sklevel + 1.3 * GetHeroInt(caster, true)) * jumpdeplz * kmswitchincre, 1)
            endif
            if kmswitch then
                set iff = Filter(function Trig_Koakuma_Target)
                set g = CreateGroup()
                call GroupEnumUnitsInRange(g, tx, ty, 225.0 + 25 * kmlevel, iff)
                loop
                    set v = FirstOfGroup(g)
                exitwhen v == null
                    call GroupRemoveUnit(g, v)
                    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\FragmentationShards\\FragBoomSpawn.mdl", GetUnitX(v), GetUnitY(v)))
                    call UnitMagicDamageTarget(caster, v, (30 + 35 * sklevel + 1.3 * GetHeroInt(caster, true)) * (0.25 * (1 + kmlevel)) * jumpdeplz * kmswitchincre * 0.75, 5)
                endloop
                call DestroyGroup(g)
            endif
        endif
        if sktype == 'A0NH' then
            if IsUnitAlly(caster, GetOwningPlayer(target)) == false then
                call UnitMagicDamageTarget(caster, target, (17 + 13 * sklevel + 0.45 * GetHeroInt(caster, true)) * jumpdeplz * kmswitchincre, 1)
                if GetUnitAbilityLevel(target, 'A0NO') == 0 then
                    call UnitAddAbility(target, 'A0NO')
                    call SetUnitAbilityLevel(target, 'A0NO', R2I(sklevel * jumpdeplz))
                else
                    set aonolevel = GetUnitAbilityLevel(target, 'A0NO')
                    call UnitRemoveAbility(target, 'A15X' + GetUnitAbilityLevel(target, 'A0NO'))
                    call UnitRemoveAbility(target, 'B05A')
                    call UnitAddAbility(target, 'A0NO')
                    call SetUnitAbilityLevel(target, 'A0NO', aonolevel + R2I(sklevel * jumpdeplz))
                endif
                call Trig_Koakuma_SlowTarget(caster, target, GetUnitAbilityLevel(target, 'A0NO'))
                call Trig_Koakuma02_StartTimer(target)
            endif
            if kmswitch then
                set iff = Filter(function Trig_Koakuma_Target)
                set g = CreateGroup()
                call GroupEnumUnitsInRange(g, tx, ty, 225.0 + 25 * kmlevel, iff)
                loop
                    set v = FirstOfGroup(g)
                exitwhen v == null
                    call GroupRemoveUnit(g, v)
                    call UnitMagicDamageTarget(caster, v, (17 + 13 * sklevel + 0.45 * GetHeroInt(caster, true)) * (0.25 * (1 + kmlevel)) * jumpdeplz * kmswitchincre * 0.75, 5)
                    if GetUnitAbilityLevel(v, 'A0NO') == 0 then
                        call UnitAddAbility(v, 'A0NO')
                        call SetUnitAbilityLevel(v, 'A0NO', R2I(sklevel * (0.25 * (1 + kmlevel)) * jumpdeplz))
                    else
                        set aonolevel = GetUnitAbilityLevel(v, 'A0NO')
                        call UnitRemoveAbility(v, 'A15X' + GetUnitAbilityLevel(v, 'A0NO'))
                        call UnitRemoveAbility(v, 'B05A')
                        call UnitAddAbility(v, 'A0NO')
                        call SetUnitAbilityLevel(v, 'A0NO', aonolevel + R2I(sklevel * (0.25 * (1 + kmlevel)) * jumpdeplz))
                    endif
                    call Trig_Koakuma_SlowTarget(caster, target, GetUnitAbilityLevel(target, 'A0NO'))
                    call Trig_Koakuma02_StartTimer(v)
                endloop
                call DestroyGroup(g)
            endif
        endif
        if jumpi > 0 then
            set g = CreateGroup()
            set iff2 = Filter(function Trig_Koakuma_Target2)
            call GroupEnumUnitsInRange(g, tx, ty, 420.0, iff2)
            set v = FirstOfGroup(g)
            if v != null then
                set k = true
                set target = GroupPickRandomUnit(g)
            else
                set iff = Filter(function Trig_Koakuma_Target)
                call GroupEnumUnitsInRange(g, tx, ty, 420.0, iff)
                set v = FirstOfGroup(g)
                if v != null then
                    set target = GroupPickRandomUnit(g)
                    call DestroyGroup(g)
                    set k = true
                else
                    set iff3 = Filter(function Trig_Koakuma_Target3)
                    call GroupEnumUnitsInRange(g, tx, ty, 420.0, iff3)
                    set v = FirstOfGroup(g)
                    if v != null then
                        set target = GroupPickRandomUnit(g)
                        call DestroyGroup(g)
                        set k = true
                    else
                        call DestroyGroup(g)
                        set k = false
                    endif
                endif
            endif
            if k then
                set jumpi = jumpi - 1
            else
                set jumpi = 0
            endif
            call SaveUnitHandle(udg_ht, task, 1, target)
            call SaveInteger(udg_ht, task, 5, jumpi)
            call SaveInteger(udg_ht, task, 8, jumptimes + 1)
        endif
        if k == false then
            call KillUnit(u)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
    set v = null
    set w = null
    set g = null
    set iff = null
    set iff2 = null
    set iff3 = null
endfunction

function Trig_Koakuma_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local integer sktype = GetSpellAbilityId()
    local integer uttype
    local integer sklevel = GetUnitAbilityLevel(caster, sktype)
    local integer lslevel = GetUnitAbilityLevel(caster, 'A05A')
    local integer kmlevel = GetUnitAbilityLevel(caster, 'A0NI')
    local integer jumpi
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    local boolean kmswitch = GetUnitAbilityLevel(caster, 'B05B') > 0
    local boolean dcswitch = GetUnitAbilityLevel(caster, 'A05F') > 0
    local real mspeed = 800.0
    if GetSpellAbilityId() == 'A0MT' then
        call AbilityCoolDownResetion(caster, 'A0MT', 10 - sklevel * 1)
    elseif GetSpellAbilityId() == 'A0NH' then
        call AbilityCoolDownResetion(caster, 'A0NH', 10)
    endif
    if dcswitch and sktype != 'A0NI' then
        set mspeed = mspeed + GetUnitAbilityLevel(caster, 'A05A') * 100 + 150
        call UnitRemoveAbility(caster, 'A05F')
        call UnitRemoveAbility(caster, 'B05O')
        call Trig_Koakuma03_Timer_Set(caster)
    endif
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set t = null
            set caster = null
            set target = null
            set u = null
            return
        endif
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    if sktype == 'A0MT' then
        set uttype = 'e01F'
    else
        set uttype = 'e01G'
    endif
    set jumpi = 1 + lslevel
    set u = CreateUnit(GetOwningPlayer(caster), uttype, ox, oy, 57.29578 * a)
    if kmswitch then
        if sktype == 'A0MT' then
            call SetUnitScale(u, 2.4, 2.4, 2.4)
        else
            call SetUnitScale(u, 4.0, 4.0, 4.0)
        endif
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 3, sktype)
    call SaveInteger(udg_ht, task, 4, sklevel)
    call SaveInteger(udg_ht, task, 5, jumpi)
    call SaveInteger(udg_ht, task, 6, kmlevel)
    call SaveBoolean(udg_ht, task, 7, kmswitch)
    call SaveInteger(udg_ht, task, 8, 0)
    call SaveReal(udg_ht, task, 9, mspeed / 50)
    call TimerStart(t, 0.02, true, function Trig_Koakuma_Main)
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Koakuma takes nothing returns nothing
endfunction