function DebuffDuration takes unit target, real time returns real
    if udg_SK_Parsee01 > 0 and udg_SK_Parsee != null and IsUnitEnemy(target, GetOwningPlayer(udg_SK_Parsee)) and IsUnitInRange(target, udg_SK_Parsee, 900.0) then
        set time = time * (1 + udg_SK_Parsee01)
    endif
    if GetUnitTypeId(target) == 'O00B' then
        set time = time * 0.65
    endif
    if GetUnitAbilityLevel(target, 'A0IA') > 0 then
        set time = time * 0.2
    endif
    if YDWEUnitHasItemOfTypeBJNull(target, 'I071') or YDWEUnitHasItemOfTypeBJNull(target, 'I07D') then
        set time = time * 0.65
    endif
    if GetUnitAbilityLevel(target, 'B08E') > 0 then
        set time = time * (1.2 + GetUnitAbilityLevel(target, 'B08E') * 0.1)
    endif
    if GetUnitAbilityLevel(target, 'B08F') > 0 then
        set time = time * 0.7
    endif
    if GetUnitAbilityLevel(target, 'B08H') != 0 then
        set time = time * 1.4
    endif
    return time
endfunction

function DebuffClear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer tgttask = GetHandleId(target)
    local integer debuffid = LoadInteger(udg_ht, task, 0)
    local boolean casttype = LoadBoolean(udg_ht, task, 1)
    local integer abid = LoadInteger(udg_ht, task, 1)
    local string onRemoveFunc = LoadStr(udg_ht, task, 2)
    local integer fxabil
    local integer fxnumber = LoadInteger(udg_ht, task, -1) + 4
    local real fxtimeleft
    local real timeleft = LoadReal(udg_StatusSys, debuffid, tgttask)
    local integer i = 5
    if timeleft > 0 then
        set timeleft = timeleft - 0.05
        call SaveReal(udg_StatusSys, debuffid, tgttask, timeleft)
        loop
        exitwhen i > fxnumber
            set fxabil = LoadInteger(udg_ht, task, i)
            set fxtimeleft = LoadReal(udg_ht, task, i)
            if fxtimeleft > 0 then
                set fxtimeleft = fxtimeleft - 0.05
                call SaveReal(udg_ht, task, i, fxtimeleft)
            elseif GetUnitAbilityLevel(target, fxabil) > 0 then
                call UnitRemoveAbility(target, fxabil)
                call DebugMsg("Debuff Effect " + I2S(fxabil - 'A000') + " Cleared From " + GetUnitName(target))
            endif
            set i = i + 1
        endloop
    else
        call UnitRemoveAbility(target, debuffid)
        if not casttype then
            call UnitRemoveAbility(target, abid)
        endif
        loop
        exitwhen i > fxnumber
            set fxabil = LoadInteger(udg_ht, task, i)
            if GetUnitAbilityLevel(target, fxabil) > 0 then
                call UnitRemoveAbility(target, fxabil)
                call DebugMsg("Debuff Effect " + I2S(fxabil - 'A000') + " Cleared From " + GetUnitName(target))
            endif
            set i = i + 1
        endloop
        if onRemoveFunc != "" then
            set udg_ADebuffSource = caster
            set udg_ADebuffTarget = target
            call ExecuteFunc(onRemoveFunc)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call RemoveSavedReal(udg_StatusSys, debuffid, tgttask)
        call RemoveSavedHandle(udg_StatusSys, debuffid, tgttask)
        call RemoveSavedInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask)
        call DebugMsg("Debuff cleared from " + GetUnitName(target))
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function UnitDebuffTargetImmidiate takes unit caster, unit target, real time, integer debufftype, boolean casttype, integer abid, integer ablvl, integer debuffid, integer orderid, integer fxabil, string onRemoveFunc returns nothing
    local real outcometime = DebuffDuration(target, time)
    local unit u
    local timer t
    local integer task
    local real timeleft
    local integer i
    local integer j
    local real fxtimeleft
    local integer tgttask = GetHandleId(target)
    local boolean addedeffect = false
    if GetUnitAbilityLevel(target, 'A17X') == 0 and GetUnitAbilityLevel(target, 'A0PF') == 0 and GetUnitAbilityLevel(target, 'A0AN') == 0 and GetUnitCurrentOrder(target) != OrderId("metamorphosis") then
        if HaveSavedReal(udg_StatusSys, debuffid, tgttask) then
            set timeleft = LoadReal(udg_StatusSys, debuffid, tgttask)
        else
            set timeleft = 0
        endif
        if debufftype == 0 then
            if timeleft == 0 then
                call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime)
                call DebugMsg("The duration of " + GetObjectName(debuffid) + " debuff on " + GetUnitName(target) + " is set to " + R2S(outcometime) + "s")
            else
                call DebugMsg(GetObjectName(debuffid) + " debuff is currently invalid on " + GetUnitName(target))
                set u = null
                set t = null
                return
            endif
        elseif debufftype == 1 then
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime)
            call DebugMsg(GetObjectName(debuffid) + " debuff duration on " + GetUnitName(target) + " changed to " + R2S(outcometime) + "s")
        elseif debufftype == 2 then
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime + timeleft)
            call DebugMsg(GetObjectName(debuffid) + " of " + GetUnitName(target) + " debuff duration stacks up to " + R2S(outcometime + timeleft) + "s")
            set j = GetUnitAbilityLevel(target, debuffid)
            if j > 0 then
                set j = LoadInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask)
                set ablvl = R2I(j + (100 - j) * (ablvl * 0.01))
            endif
            call SaveInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask, ablvl)
        elseif debufftype == 3 then
            set outcometime = RMaxBJ(outcometime, timeleft)
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime)
            call DebugMsg(I2S(debuffid - 'B000') + " of " + GetUnitName(target) + " debuff duration stacks up to " + R2S(outcometime + timeleft) + "s")
            set j = GetUnitAbilityLevel(target, debuffid)
            if j > 0 then
                set j = LoadInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask)
                set ablvl = R2I(j + (100 - j) * (ablvl * 0.01))
            endif
            call SaveInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask, ablvl)
        elseif debufftype == 4 then
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime + timeleft)
        else
            call BJDebugMsg("Debuff Type Error")
            set u = null
            set t = null
            return
        endif
        if casttype then
            set u = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0.0)
            call UnitAddAbility(u, abid)
            if ablvl > 1 then
                call SetUnitAbilityLevel(u, abid, ablvl)
            endif
            call DebugMsg(GetObjectName(debuffid) + " of " + GetUnitName(target) + " abitity level is " + I2S(ablvl))
            call IssueImmediateOrderById(u, orderid)
            call UnitRemoveAbility(u, abid)
            call ReleaseDummy(u)
            if abid == 'A0QV' then
                call CCSystem_textshow("Stun", target, outcometime)
            elseif abid == 'A0QW' then
                call CCSystem_textshow("Curse", target, outcometime)
            elseif abid == 'A04F' then
                call CCSystem_textshow("Disarm", target, outcometime)
            elseif abid == 'A04D' then
                call CCSystem_textshow("Silence", target, outcometime)
            elseif abid == 'A0QI' then
                call CCSystem_textshow("Seal", target, outcometime)
            elseif abid == 'A0CW' then
                call CCSystem_textshow("Bleed", target, outcometime)
            else
                call DebugMsg("Unknown buff")
            endif
        else
            set j = GetUnitAbilityLevel(target, abid)
            if debufftype == 0 then
                if j == 0 then
                    call UnitAddAbility(target, abid)
                    call SetUnitAbilityLevel(target, abid, ablvl)
                    call UnitMakeAbilityPermanent(target, true, abid)
                endif
            elseif debufftype == 1 then
                if j == 0 then
                    call UnitAddAbility(target, abid)
                    call UnitMakeAbilityPermanent(target, true, abid)
                endif
                call SetUnitAbilityLevel(target, abid, ablvl)
            elseif debufftype == 2 then
                if j == 0 then
                    call UnitAddAbility(target, abid)
                    call UnitMakeAbilityPermanent(target, true, abid)
                endif
                if j > 0 then
                    set ablvl = R2I(j + (100 - j) * (ablvl * 0.01))
                endif
                call SetUnitAbilityLevel(target, abid, ablvl)
            endif
        endif
        if fxabil != 0 then
            if GetUnitAbilityLevel(target, fxabil) == 0 then
                call UnitAddAbility(target, fxabil)
                call UnitMakeAbilityPermanent(target, true, fxabil)
                set addedeffect = true
            else
                set i = 5
                loop
                exitwhen LoadInteger(udg_ht, task, i) == fxabil
                    set i = i + 1
                endloop
                set fxtimeleft = LoadReal(udg_ht, task, i)
                if debufftype == 0 or debufftype == 1 then
                    set fxtimeleft = outcometime
                elseif debufftype == 2 then
                    set fxtimeleft = fxtimeleft + outcometime
                endif
                call SaveReal(udg_ht, task, i, fxtimeleft)
            endif
        endif
        if not HaveSavedHandle(udg_StatusSys, debuffid, tgttask) then
            set t = CreateTimer()
            set task = GetHandleId(t)
            call SaveUnitHandle(udg_ht, task, 0, caster)
            call SaveUnitHandle(udg_ht, task, 1, target)
            call SaveInteger(udg_ht, task, 0, debuffid)
            call SaveBoolean(udg_ht, task, 1, casttype)
            call SaveInteger(udg_ht, task, 1, abid)
            call SaveStr(udg_ht, task, 2, onRemoveFunc)
            call SaveInteger(udg_ht, task, 5, fxabil)
            call SaveReal(udg_ht, task, 5, outcometime)
            call SaveInteger(udg_ht, task, -1, 1)
            call TimerStart(t, 0.05, true, function DebuffClear)
            call SaveTimerHandle(udg_StatusSys, debuffid, tgttask, t)
            call SaveInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask, ablvl)
        else
            if addedeffect then
                set t = LoadTimerHandle(udg_StatusSys, debuffid, tgttask)
                set task = GetHandleId(t)
                set i = LoadInteger(udg_ht, task, -1)
                call SaveInteger(udg_ht, task, 5 + i, fxabil)
                call SaveReal(udg_ht, task, 5 + i, outcometime)
                call SaveInteger(udg_ht, task, -1, i + 1)
            endif
        endif
    endif
    set u = null
    set t = null
endfunction

function UnitDebuffTarget takes unit caster, unit target, real time, integer debufftype, boolean casttype, integer abid, integer ablvl, integer debuffid, string orderstr, integer fxabil, string onRemoveFunc returns nothing
    local real outcometime = DebuffDuration(target, time)
    local unit u
    local timer t
    local integer task
    local real timeleft
    local integer i
    local integer j
    local real fxtimeleft
    local integer tgttask = GetHandleId(target)
    local boolean addedeffect = false
    if GetUnitAbilityLevel(target, 'A17X') == 0 and GetUnitAbilityLevel(target, 'A0PF') == 0 and GetUnitAbilityLevel(target, 'A0AN') == 0 and GetUnitCurrentOrder(target) != OrderId("metamorphosis") then
        if HaveSavedReal(udg_StatusSys, debuffid, tgttask) then
            set timeleft = LoadReal(udg_StatusSys, debuffid, tgttask)
        else
            set timeleft = 0
        endif
        if debufftype == 0 then
            if timeleft == 0 then
                call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime)
                call DebugMsg("The duration of " + GetObjectName(debuffid) + " debuff on " + GetUnitName(target) + " is set to " + R2S(outcometime) + "s")
            else
                call DebugMsg(GetObjectName(debuffid) + " debuff is currently invalid on " + GetUnitName(target))
                set u = null
                set t = null
                return
            endif
        elseif debufftype == 1 then
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime)
            call DebugMsg(GetObjectName(debuffid) + " debuff duration on " + GetUnitName(target) + " changed to " + R2S(outcometime) + "s")
        elseif debufftype == 2 then
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime + timeleft)
            call DebugMsg(GetObjectName(debuffid) + " of " + GetUnitName(target) + " debuff duration stacks up to " + R2S(outcometime + timeleft) + "s")
            set j = GetUnitAbilityLevel(target, debuffid)
            if j > 0 then
                set j = LoadInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask)
                set ablvl = R2I(j + (100 - j) * (ablvl * 0.01))
            endif
            call SaveInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask, ablvl)
        elseif debufftype == 3 then
            set outcometime = RMaxBJ(outcometime, timeleft)
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime)
            call DebugMsg(I2S(debuffid - 'B000') + " of " + GetUnitName(target) + " debuff duration stacks up to " + R2S(outcometime + timeleft) + "s")
            set j = GetUnitAbilityLevel(target, debuffid)
            if j > 0 then
                set j = LoadInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask)
                set ablvl = R2I(j + (100 - j) * (ablvl * 0.01))
            endif
            call SaveInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask, ablvl)
        elseif debufftype == 4 then
            call SaveReal(udg_StatusSys, debuffid, tgttask, outcometime + timeleft)
        else
            call BJDebugMsg("Debuff Type Error")
            set u = null
            set t = null
            return
        endif
        if casttype then
            set u = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0.0)
            call UnitAddAbility(u, abid)
            if ablvl > 1 then
                call SetUnitAbilityLevel(u, abid, ablvl)
            endif
            call DebugMsg(GetObjectName(debuffid) + " of " + GetUnitName(target) + " abitity level is " + I2S(ablvl))
            call IssueTargetOrder(u, orderstr, target)
            call UnitRemoveAbility(u, abid)
            call ReleaseDummy(u)
            if abid == 'A0QV' then
                call CCSystem_textshow("Stun", target, outcometime)
            elseif abid == 'A0QW' then
                call CCSystem_textshow("Curse", target, outcometime)
            elseif abid == 'A04F' then
                call CCSystem_textshow("Disarm", target, outcometime)
            elseif abid == 'A04D' then
                call CCSystem_textshow("Silence", target, outcometime)
            elseif abid == 'A0QI' then
                call CCSystem_textshow("Seal", target, outcometime)
            elseif abid == 'A0CW' then
                call CCSystem_textshow("Bleed", target, outcometime)
            else
                call DebugMsg("Unknown buff")
            endif
        else
            set j = GetUnitAbilityLevel(target, abid)
            if debufftype == 0 then
                if j == 0 then
                    call UnitAddAbility(target, abid)
                    call SetUnitAbilityLevel(target, abid, ablvl)
                    call UnitMakeAbilityPermanent(target, true, abid)
                endif
            elseif debufftype == 1 then
                if j == 0 then
                    call UnitAddAbility(target, abid)
                    call UnitMakeAbilityPermanent(target, true, abid)
                endif
                call SetUnitAbilityLevel(target, abid, ablvl)
            elseif debufftype == 2 then
                if j == 0 then
                    call UnitAddAbility(target, abid)
                    call UnitMakeAbilityPermanent(target, true, abid)
                endif
                if j > 0 then
                    set ablvl = R2I(j + (100 - j) * (ablvl * 0.01))
                endif
                call SetUnitAbilityLevel(target, abid, ablvl)
            endif
        endif
        if fxabil != 0 then
            if GetUnitAbilityLevel(target, fxabil) == 0 then
                call UnitAddAbility(target, fxabil)
                call UnitMakeAbilityPermanent(target, true, fxabil)
                set addedeffect = true
            else
                set i = 5
                loop
                exitwhen LoadInteger(udg_ht, task, i) == fxabil
                    set i = i + 1
                endloop
                set fxtimeleft = LoadReal(udg_ht, task, i)
                if debufftype == 0 or debufftype == 1 then
                    set fxtimeleft = outcometime
                elseif debufftype == 2 then
                    set fxtimeleft = fxtimeleft + outcometime
                endif
                call SaveReal(udg_ht, task, i, fxtimeleft)
            endif
        endif
        if not HaveSavedHandle(udg_StatusSys, debuffid, tgttask) then
            set t = CreateTimer()
            set task = GetHandleId(t)
            call SaveUnitHandle(udg_ht, task, 0, caster)
            call SaveUnitHandle(udg_ht, task, 1, target)
            call SaveInteger(udg_ht, task, 0, debuffid)
            call SaveBoolean(udg_ht, task, 1, casttype)
            call SaveInteger(udg_ht, task, 1, abid)
            call SaveStr(udg_ht, task, 2, onRemoveFunc)
            call SaveInteger(udg_ht, task, 5, fxabil)
            call SaveReal(udg_ht, task, 5, outcometime)
            call SaveInteger(udg_ht, task, -1, 1)
            call TimerStart(t, 0.05, true, function DebuffClear)
            call SaveTimerHandle(udg_StatusSys, debuffid, tgttask, t)
            call SaveInteger(udg_StatusSys, StringHash(I2S(abid)), tgttask, ablvl)
        else
            if addedeffect then
                set t = LoadTimerHandle(udg_StatusSys, debuffid, tgttask)
                set task = GetHandleId(t)
                set i = LoadInteger(udg_ht, task, -1)
                call SaveInteger(udg_ht, task, 5 + i, fxabil)
                call SaveReal(udg_ht, task, 5 + i, outcometime)
                call SaveInteger(udg_ht, task, -1, i + 1)
            endif
        endif
    endif
    set u = null
    set t = null
endfunction

function UnitStunTargetNew takes unit caster, unit target, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A0QV', 1, 'B07U', "firebolt", fxabil, "")
endfunction

function UnitCurseTargetNew takes unit caster, unit target, integer chance, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A0QW', chance, 'B07X', "curse", fxabil, "")
endfunction

function UnitSlowTargetAspd takes unit caster, unit target, integer percent, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A03C', percent, 'B07Z', "slow", fxabil, "")
endfunction

function UnitSlowTargetMspd takes unit caster, unit target, integer percent, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A06H', percent, 'B07Y', "cripple", fxabil, "")
endfunction

function UnitSlowTargetNew takes unit caster, unit target, integer percent, real time, integer debufftype, integer fxabil returns nothing
    call UnitSlowTargetAspd(caster, target, percent, time, debufftype, fxabil)
    call UnitSlowTargetMspd(caster, target, percent, time, debufftype, fxabil)
endfunction

function UnitSealTarget takes unit caster, unit target, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A0QI', 1, 'B07T', "drunkenhaze", fxabil, "")
endfunction

function UnitSealTargetAttack takes unit caster, unit target, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A04F', 1, 'B083', "drunkenhaze", fxabil, "")
endfunction

function UnitSealTargetCast takes unit caster, unit target, real time, integer debufftype, integer fxabil returns nothing
    call UnitDebuffTarget(caster, target, time, debufftype, true, 'A04D', 1, 'B084', "drunkenhaze", fxabil, "")
endfunction

function UnitInjureTargetNew takes unit caster, unit target, real time returns nothing
    call UnitDebuffTarget(caster, target, time, 2, false, 'A0CW', 1, 'B07H', "", 0, "")
endfunction

function InitTrig_DebuffSys takes nothing returns nothing
endfunction