function Trig_Nitori04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0LK'
endfunction

function Nitori_SK4_DegreeApproach takes real targetdeg, real currentdeg, real maxrotation returns real
    local real flag1 = Sin((targetdeg - currentdeg) * 0.017454)
    local real flag2 = Cos(maxrotation * 0.017454)
    local real flag3 = Cos((targetdeg - currentdeg) * 0.017454)
    if flag1 >= 0 then
        if flag2 > flag3 then
            return currentdeg + maxrotation
        else
            return targetdeg
        endif
    else
        if flag2 > flag3 then
            return currentdeg - maxrotation
        else
            return targetdeg
        endif
    endif
endfunction

function Nitori_SK4_Abs takes real x returns real
    if x >= 0 then
        return x
    else
        return -1.0 * x
    endif
endfunction

function Nitori_SK4_Degree takes real deg1, real deg2 returns boolean
    return true
endfunction

function Nitori_Skill4_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local integer count = LoadInteger(udg_Hashtable, tid, 1)
    local integer countmax = LoadInteger(udg_Hashtable, tid, 2)
    local integer attbk = LoadInteger(udg_Hashtable, tid, 3)
    local real maxro = LoadReal(udg_Hashtable, tid, 4)
    local unit target = LoadUnitHandle(udg_Hashtable, tid, 6)
    local unit caster = LoadUnitHandle(udg_Hashtable, tid, 7)
    local real speed = LoadReal(udg_Hashtable, tid, 8)
    local real range = LoadReal(udg_Hashtable, tid, 12)
    local real endrange = LoadReal(udg_Hashtable, tid, 13)
    local integer attp = LoadInteger(udg_Hashtable, tid, 14)
    local integer fdl = LoadInteger(udg_Hashtable, tid, 15)
    local unit Rocket
    local integer RocketState
    local unit RocketTarget
    local real RocketX
    local real RocketY
    local real RocketFac
    local real RocketTargetXFix
    local real RocketTargetYFix
    local boolean RocketLockOn
    local real x
    local real y
    local real deg
    local real fac
    local unit helper
    local integer index = 0
    local integer maxindex = LoadInteger(udg_Hashtable, tid, 9)
    local integer i = 1
    local integer RocketNum = LoadInteger(udg_Hashtable, tid, 10)
    local real FrameRate = LoadReal(udg_Hashtable, tid, 11)
    if count >= countmax or IsUnitType(target, UNIT_TYPE_DEAD) then
        if countmax != 0 then
            call SaveInteger(udg_Hashtable, tid, 2, 0)
            call SaveInteger(udg_Hashtable, tid, 1, -1)
            loop
            exitwhen i > RocketNum
                set index = index + 100
                call SaveUnitHandle(udg_Hashtable, tid, index + 2, caster)
                set i = i + 1
            endloop
        else
            if count + 1 <= -1 * RocketNum then
                call ReleaseTimer(t)
                call FlushChildHashtable(udg_Hashtable, tid)
            endif
        endif
    endif
    loop
    exitwhen i > RocketNum
        set index = index + 100
        set Rocket = LoadUnitHandle(udg_Hashtable, tid, index)
        set RocketState = LoadInteger(udg_Hashtable, tid, index + 1)
        set RocketTarget = LoadUnitHandle(udg_Hashtable, tid, index + 2)
        set RocketTargetXFix = LoadReal(udg_Hashtable, tid, index + 3)
        set RocketTargetYFix = LoadReal(udg_Hashtable, tid, index + 4)
        set RocketLockOn = LoadBoolean(udg_Hashtable, tid, index + 5)
        if Rocket == null and countmax != 0 then
            if RocketState >= 0 then
                set helper = CreateUnit(GetOwningPlayer(caster), 'u00T', GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster) + 180.0 + GetRandomReal(-90, 90))
                call SaveUnitHandle(udg_Hashtable, tid, index, helper)
                call SaveUnitHandle(udg_Hashtable, tid, index + 2, target)
                call SaveReal(udg_Hashtable, tid, index + 3, 0)
                call SaveReal(udg_Hashtable, tid, index + 4, 0)
                call SaveBoolean(udg_Hashtable, tid, index + 5, true)
            else
                call SaveInteger(udg_Hashtable, tid, index + 1, RocketState + 1)
            endif
        endif
        if Rocket != null then
            set RocketX = GetUnitX(Rocket)
            set RocketY = GetUnitY(Rocket)
            set RocketFac = GetUnitFacing(Rocket)
            set x = GetUnitX(RocketTarget) + RocketTargetXFix
            set y = GetUnitY(RocketTarget) + RocketTargetYFix
            set deg = Atan2(y - RocketY, x - RocketX) / 3.1415926 * 180.0
            if RocketTarget == target and RocketState <= 0 then
                if (x - RocketX) * (x - RocketX) + (y - RocketY) * (y - RocketY) <= range then
                    if Nitori_SK4_Degree(RocketFac, deg) then
                        set helper = CreateUnit(GetOwningPlayer(Rocket), 'o000', RocketX, RocketY, RocketFac)
                        call UnitAddAbility(helper, 'A0OE')
                        call IssuePointOrder(helper, "breathoffire", x, y)
                    endif
                    call SaveInteger(udg_Hashtable, tid, index + 1, attbk)
                    call SaveUnitHandle(udg_Hashtable, tid, index + 2, target)
                    call SaveReal(udg_Hashtable, tid, index + 3, GetRandomReal(-100, 100))
                    call SaveReal(udg_Hashtable, tid, index + 4, GetRandomReal(-100, 100))
                    call SaveBoolean(udg_Hashtable, tid, index + 5, false)
                endif
            endif
            if RocketTarget == caster and countmax == 0 then
                if (x - RocketX) * (x - RocketX) + (y - RocketY) * (y - RocketY) <= endrange or GetUnitState(caster, UNIT_STATE_LIFE) >= 0.405 then
                    call KillUnit(Rocket)
                    call SaveUnitHandle(udg_Hashtable, tid, index, null)
                    call SaveInteger(udg_Hashtable, tid, 1, count - 1)
                endif
            endif
            set fac = Nitori_SK4_DegreeApproach(deg, RocketFac, maxro)
            call SetUnitFacingTimed(Rocket, fac, FrameRate)
            if RocketState <= attp then
                set deg = fac / 180.0 * 3.1415926
                set RocketX = RocketX + speed * Cos(deg)
                set RocketY = RocketY + speed * Sin(deg)
                call SetUnitXY(Rocket, RocketX, RocketY)
            endif
            if RocketState > 0 then
                call SaveInteger(udg_Hashtable, tid, index + 1, RocketState - 1)
            else
                if RocketLockOn == false and countmax != 0 then
                    call SaveUnitHandle(udg_Hashtable, tid, index + 2, target)
                    call SaveReal(udg_Hashtable, tid, index + 3, 0)
                    call SaveReal(udg_Hashtable, tid, index + 4, 0)
                    call SaveBoolean(udg_Hashtable, tid, index + 5, true)
                endif
            endif
        endif
        set i = i + 1
    endloop
    if countmax != 0 then
        call SaveInteger(udg_Hashtable, tid, 1, count + 1)
    endif
    set t = null
    set caster = null
    set target = null
    set Rocket = null
    set RocketTarget = null
    set helper = null
endfunction

function Trig_Nitori_Skill4_Actions takes nothing returns nothing
    local unit target = GetSpellTargetUnit()
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer tid = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A0LK')
    local integer i = 1
    local integer index = 0
    local real FrameRate = 0.02
    local integer RocketNum = 2 + level
    local real speed = 900.0
    local real SkillLastTime = 8.0
    local real CreateBlank = 0.15
    local real AttackBlank = 1.5
    local real AttackPause = 0.5
    local real MaxRotation = 10.0
    local real AttackRange = 250.0
    local real SkillEndRange = 25.0
    local integer FireDamageLevel = 1
    if level == 1 then
        call AbilityCoolDownResetion(caster, 'A0LK', 60)
    elseif level == 2 then
        call AbilityCoolDownResetion(caster, 'A0LK', 40)
    else
        call AbilityCoolDownResetion(caster, 'A0LK', 20)
    endif
    if GetHeroLevel(caster) >= 6 and GetHeroLevel(caster) < 10 then
        set FireDamageLevel = 1
    elseif GetHeroLevel(caster) >= 10 and GetHeroLevel(caster) < 15 then
        set FireDamageLevel = 2
    elseif GetHeroLevel(caster) >= 15 and GetHeroLevel(caster) < 20 then
        set FireDamageLevel = 3
    elseif GetHeroLevel(caster) >= 20 and GetHeroLevel(caster) < 25 then
        set FireDamageLevel = 4
    elseif GetHeroLevel(caster) == 25 then
        set FireDamageLevel = 5
    endif
    call TimerStart(t, FrameRate, true, function Nitori_Skill4_Main)
    call SaveTimerHandle(udg_Hashtable, tid, 0, t)
    call SaveInteger(udg_Hashtable, tid, 1, 1)
    call SaveInteger(udg_Hashtable, tid, 2, R2I(SkillLastTime / FrameRate))
    call SaveInteger(udg_Hashtable, tid, 3, R2I(AttackBlank / FrameRate))
    call SaveReal(udg_Hashtable, tid, 4, MaxRotation)
    call SaveUnitHandle(udg_Hashtable, tid, 6, target)
    call SaveUnitHandle(udg_Hashtable, tid, 7, caster)
    call SaveReal(udg_Hashtable, tid, 8, speed * FrameRate)
    call SaveReal(udg_Hashtable, tid, 12, AttackRange * AttackRange)
    call SaveReal(udg_Hashtable, tid, 13, SkillEndRange * SkillEndRange)
    call SaveInteger(udg_Hashtable, tid, 14, R2I((AttackBlank - AttackPause) / FrameRate))
    call SaveInteger(udg_Hashtable, tid, 15, FireDamageLevel)
    loop
    exitwhen i > RocketNum
        set index = index + 100
        call SaveUnitHandle(udg_Hashtable, tid, index, null)
        call SaveInteger(udg_Hashtable, tid, index + 1, -1 * (i - 1) * R2I(CreateBlank / FrameRate))
        call SaveUnitHandle(udg_Hashtable, tid, index + 2, caster)
        call SaveReal(udg_Hashtable, tid, index + 3, 0)
        call SaveReal(udg_Hashtable, tid, index + 4, 0)
        call SaveBoolean(udg_Hashtable, tid, index + 5, false)
        set i = i + 1
    endloop
    call SaveInteger(udg_Hashtable, tid, 9, index)
    call SaveInteger(udg_Hashtable, tid, 10, RocketNum)
    call SaveReal(udg_Hashtable, tid, 11, FrameRate)
    set target = null
    set caster = null
    set t = null
endfunction

function InitTrig_Nitori04 takes nothing returns nothing
endfunction