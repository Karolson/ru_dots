function AddingLBuff takes integer bookid, integer abilityid, integer buffid returns nothing
    set udg_LBuff_Max = udg_LBuff_Max + 1
    set udg_LBuff_bookid[udg_LBuff_Max] = bookid
    set udg_LBuff_abilityid[udg_LBuff_Max] = abilityid
    set udg_LBuff_buffid[udg_LBuff_Max] = buffid
    if bookid != 0 then
        call FirstAbilityInit(bookid)
    else
        call FirstAbilityInit(abilityid)
    endif
endfunction

function ClearAllNegativeBuff takes unit u, boolean ult returns nothing
    local integer i
    local integer m
    set i = 0
    set m = udg_LBuff_Max
    loop
        set i = i + 1
        if udg_LBuff_bookid[i] != 0 then
            if GetUnitAbilityLevel(u, udg_LBuff_bookid[i]) >= 1 then
                call UnitRemoveAbility(u, udg_LBuff_bookid[i])
                if udg_LBuff_buffid[i] != 0 then
                    call UnitRemoveAbility(u, udg_LBuff_buffid[i])
                endif
            endif
        else
            if GetUnitAbilityLevel(u, udg_LBuff_abilityid[i]) >= 1 then
                call UnitRemoveAbility(u, udg_LBuff_abilityid[i])
            endif
            if udg_LBuff_buffid[i] != 0 then
                call UnitRemoveAbility(u, udg_LBuff_buffid[i])
            endif
        endif
    exitwhen i == m
    endloop
    call UnitRemoveBuffs(u, false, true)
    if GetUnitAbilityLevel(u, 'B02A') >= 1 then
        call UnitRemoveAbility(u, 'B02A')
    endif
    if GetUnitAbilityLevel(u, 'A0Z1') >= 1 then
        call UnitRemoveAbility(u, 'A0Z1')
        call UnitRemoveAbility(u, 'B065')
    endif
    if GetUnitAbilityLevel(u, 'A0S2') >= 1 then
        call SetUnitAbilityLevel(u, 'A0S2', 5)
    endif
    if GetUnitAbilityLevel(u, 'A0SE') >= 1 then
        call SetUnitAbilityLevel(u, 'A0SE', 5)
    endif
    if GetUnitAbilityLevel(u, 'A0V6') >= 1 then
        call UnitRemoveAbility(u, 'A0V6')
    endif
    if GetUnitAbilityLevel(u, 'A0RV') >= 1 then
        call UnitRemoveAbility(u, 'A0RV')
    endif
    if GetUnitAbilityLevel(u, 'A0A1') >= 1 then
        call UnitRemoveAbility(u, 'A0A1')
    endif
    if GetUnitAbilityLevel(u, 'B00D') >= 1 then
        call UnitRemoveAbility(u, 'B00D')
    endif
    call UnitRemoveAbility(u, 'A0A1')
    call UnitRemoveAbility(u, 'A0V4')
    call UnitRemoveAbility(u, 'B01R')
    call UnitRemoveAbility(u, 'B04S')
    call UnitRemoveAbility(u, 'B07N')
    call UnitRemoveAbility(u, 'B09K')
    call UnitRemoveAbility(u, 'B09A')
    call UnitRemoveAbility(u, 'B06R')
    if udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(u))] == null then
        call BroadcastMessage("Blink prohibition has been successfully lifted")
        set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(u))] = CreateUnit(GetOwningPlayer(u), 'e036', -5344.0, -3968.0, 0)
    endif
endfunction

function Sanae03_DebuffClear_Stage2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call ClearAllNegativeBuff(u, false)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set u = null
endfunction

function Sanae03_DebuffClear takes unit u returns nothing
    local timer t = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, u)
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", u, "origin"))
    call TimerStart(t, 0.75, false, function Sanae03_DebuffClear_Stage2)
    set t = null
endfunction

function ResetUnitColor takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call SetUnitVertexColor(v, 255, 255, 255, 255)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    set v = null
    set t = null
endfunction

function ChangeUnitColor takes unit v, integer r, integer g, integer b, real duration returns nothing
    local timer t = CreateTimer()
    local real time = DebuffDuration(v, duration)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, v)
    call SetUnitVertexColor(v, r, g, b, 255)
    call TimerStart(t, time, false, function ResetUnitColor)
    set t = null
endfunction

function ClearRestrictedMovement takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    if udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] == null and GetUnitAbilityLevel(target, 'A0A1') == 0 and GetUnitAbilityLevel(target, 'A0V4') == 0 then
        set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] = CreateUnit(GetOwningPlayer(target), 'e036', -5344.0, -3968.0, 0)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function RestrictTarget takes unit source, unit target, real duration returns nothing
    local real time = duration + 0.01
    local timer t
    if IsUnitCCImmune(target) then
        return
    endif
    if GetUnitAbilityLevel(target, 'A0AC') > 0 and GetRandomInt(1, 100) <= 2 + 3 * GetUnitAbilityLevel(target, 'A0AC') then
        call Sanae03_DebuffClear(target)
        return
    endif
    if not IsUnitIllusion(target) and IsUnitType(target, UNIT_TYPE_HERO) and udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] != null then
        set t = CreateTimer()
        call RemoveUnit(udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))])
        set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] = null
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
        call TimerStart(t, time, false, function ClearRestrictedMovement)
        call CCSystem_textshow("Bind", target, time)
        call CE_Input(source, target, 50.0)
    endif
    set t = null
endfunction

function UnitCurseTarget takes unit caster, unit target, real time, integer abid, string orderstr returns nothing
    local real outcometime = DebuffDuration(target, time)
    local integer outcomelevel
    local unit w
    if IsUnitCCImmune(target) then
        return
    endif
    if GetUnitAbilityLevel(target, 'A0AC') > 0 and GetRandomInt(1, 100) <= 2 + 3 * GetUnitAbilityLevel(target, 'A0AC') then
        call Sanae03_DebuffClear(target)
        return
    endif
    if outcometime > 5.0 then
        set outcometime = 5.0
    endif
    set outcomelevel = R2I(outcometime * 20)
    call DebugMsg("Skill Level Set To " + I2S(outcomelevel) + " for debuff time of " + R2S(outcometime))
    if abid == 'A0X5' or abid == 'A0OK' or abid == 'A11G' then
        call CCSystem_textshow("", target, outcometime)
    elseif abid == 'A04E' or abid == 'A04K' or abid == 'A0OK' or abid == 'A0VV' or abid == 'A0T7' or abid == 'A0UH' or abid == 'A18A' then
        call CCSystem_textshow("Silence", target, outcometime)
    elseif abid == 'A06P' or abid == 'A0MC' or abid == 'A0PY' then
        call CCSystem_textshow("Disable", target, outcometime)
    elseif abid == 'A08G' then
        call CCSystem_textshow("Snare", target, outcometime)
    elseif abid == 'A000' or abid == 'A12E' or abid == 'A12F' or abid == 'A12G' or abid == 'A145' then
        call CCSystem_textshow("Blind", target, outcometime)
    else
        call CCSystem_textshow("", target, outcometime)
    endif
    if GetUnitAbilityLevel(target, 'A0AN') == 0 and GetUnitCurrentOrder(target) != OrderId("metamorphosis") then
        set w = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0.0)
        if GetUnitTypeId(target) == 'U006' and udg_YuyukoBool[GetPlayerId(GetOwningPlayer(target))] then
            set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(target))] = 0
            set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(target))] = udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(target))] + outcometime
        endif
        call UnitAddAbility(w, abid)
        call SetUnitAbilityLevel(w, abid, outcomelevel)
        call IssueTargetOrder(w, orderstr, target)
        call UnitRemoveAbility(w, abid)
        call ReleaseDummy(w)
        call CE_Input(caster, target, outcometime * 10.0)
    endif
    set w = null
endfunction

function UnitSlowTarget_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer abilityid = LoadInteger(udg_ht, task, 2)
    local integer buffid = LoadInteger(udg_ht, task, 3)
    local integer iscall = LoadInteger(udg_ht, task, 4)
    local string endfunc = LoadStr(udg_ht, task, 5)
    local integer pointer = LoadInteger(udg_ht, task, 6)
    local integer i
    local integer j
    local integer k
    set i = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10)
    set i = i - 1
    call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, i)
    if i == 0 then
        if GetUnitAbilityLevel(target, abilityid) > 0 then
            call UnitRemoveAbility(target, abilityid)
            if buffid != 0 then
                call UnitRemoveAbility(target, buffid)
                if iscall == 1 then
                    set udg_PS_Source = caster
                    set udg_PS_Target = target
                    set udg_PS_Pointer = pointer
                    call ExecuteFunc(endfunc)
                    set udg_PS_Source = null
                    set udg_PS_Target = null
                    set udg_PS_Pointer = 0
                endif
            endif
            call DebugMsg("Slow cleared")
        endif
    endif
    set i = 0
    set j = 0
    set k = 0
    loop
        set i = i + 1
    exitwhen HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), i) == false
        set j = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), i)
        set k = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), j * 10)
    exitwhen k >= 1
    endloop
    if k == 0 then
        call FlushChildHashtable(udg_Hashtable_Slow, GetHandleId(target))
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
    set endfunc = ""
endfunction

function UnitSlowTargetEx takes unit caster, unit target, real time, integer abilityid, integer buffid, string endfunc, integer pointer returns boolean
    local real outcometime = DebuffDuration(target, time)
    local timer t
    local integer task
    local integer i
    local integer j
    local integer k
    local boolean ret
    if IsUnitCCImmune(target) then
        return true
    endif
    if GetUnitAbilityLevel(target, 'A0AC') > 0 and GetRandomInt(1, 100) <= 2 + 3 * GetUnitAbilityLevel(target, 'A0AC') then
        call Sanae03_DebuffClear(target)
        return true
    endif
    if IsUnitSlowable(target) then
        if udg_Hashtable_Slow == null then
            set udg_Hashtable_Slow = InitHashtable()
        endif
        if HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), 0) then
            set i = 0
            set j = 0
            loop
                set i = i + 1
            exitwhen HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), i) == false
                if LoadInteger(udg_Hashtable_Slow, GetHandleId(target), i) == abilityid then
                    set j = i
                endif
            exitwhen j >= 1
            endloop
            if j == 0 then
                set i = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), 0) + 1
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), 0, i)
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), i, abilityid)
                set k = 1
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, k)
                set ret = false
            else
                set i = j
                set k = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10) + 1
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, k)
                set ret = true
            endif
        else
            set i = 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), 0, i)
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), i, abilityid)
            set j = 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, j)
        endif
        if GetUnitAbilityLevel(target, abilityid) == 0 then
            call UnitAddAbility(target, abilityid)
            call UnitMakeAbilityPermanent(target, true, abilityid)
        endif
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveInteger(udg_ht, task, 2, abilityid)
        call SaveInteger(udg_ht, task, 3, buffid)
        call SaveInteger(udg_ht, task, 4, 1)
        call SaveStr(udg_ht, task, 5, endfunc)
        call SaveInteger(udg_ht, task, 6, pointer)
        call TimerStart(t, outcometime, false, function UnitSlowTarget_Clear)
        call DebugMsg("Slow target for " + R2S(outcometime) + "s")
        call CE_Input(caster, target, outcometime * 10.0)
    endif
    set t = null
    return ret
endfunction

function UnitSlowTarget takes unit caster, unit target, real time, integer abilityid, integer buffid returns nothing
    local real outcometime = DebuffDuration(target, time)
    local timer t
    local integer task
    local integer i
    local integer j
    local integer k
    if IsUnitCCImmune(target) then
        return
    endif
    if GetUnitAbilityLevel(target, 'A0AC') > 0 and GetRandomInt(1, 100) <= 2 + 3 * GetUnitAbilityLevel(target, 'A0AC') then
        call Sanae03_DebuffClear(target)
        return
    endif
    if IsUnitSlowable(target) then
        if udg_Hashtable_Slow == null then
            set udg_Hashtable_Slow = InitHashtable()
        endif
        if HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), 0) then
            set i = 0
            set j = 0
            loop
                set i = i + 1
            exitwhen HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), i) == false
                if LoadInteger(udg_Hashtable_Slow, GetHandleId(target), i) == abilityid then
                    set j = i
                endif
            exitwhen j >= 1
            endloop
            if j == 0 then
                set i = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), 0) + 1
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), 0, i)
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), i, abilityid)
                set k = 1
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, k)
            else
                set i = j
                set k = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10) + 1
                call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, k)
            endif
        else
            set i = 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), 0, i)
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), i, abilityid)
            set j = 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, j)
        endif
        if GetUnitAbilityLevel(target, abilityid) == 0 then
            call UnitAddAbility(target, abilityid)
            call UnitMakeAbilityPermanent(target, true, abilityid)
        endif
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveInteger(udg_ht, task, 2, abilityid)
        call SaveInteger(udg_ht, task, 3, buffid)
        call TimerStart(t, outcometime, false, function UnitSlowTarget_Clear)
        call DebugMsg("Slow target for " + R2S(outcometime) + "s")
        if outcometime >= 1.5 and outcometime <= 5.0 then
            call CCSystem_textshow("Slow", target, outcometime)
        endif
        call CE_Input(caster, target, outcometime * 10.0)
    endif
    set t = null
endfunction

function UnitSlowTargetArea takes unit caster, real x, real y, real range, real time, integer abilityid, integer buffid returns nothing
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitSlowTarget(caster, v, time, abilityid, buffid)
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
endfunction

function UnitBuffTarget_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer abilityid = LoadInteger(udg_ht, task, 2)
    local integer buffid = LoadInteger(udg_ht, task, 3)
    local integer i
    local integer j
    local integer k
    set i = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10)
    set i = i - 1
    call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, i)
    if i == 0 then
        call UnitRemoveAbility(target, abilityid)
        if buffid != 0 then
            call UnitRemoveAbility(target, buffid)
        endif
        call DebugMsg("Buff Clear")
    endif
    set i = 0
    set j = 0
    set k = 0
    loop
        set i = i + 1
    exitwhen HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), i) == false
        set j = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), i)
        set k = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), j * 10)
    exitwhen k >= 1
    endloop
    if k == 0 then
        call FlushChildHashtable(udg_Hashtable_Slow, GetHandleId(target))
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
endfunction

function UnitBuffTarget takes unit caster, unit target, real time, integer abilityid, integer buffid returns nothing
    local real outcometime = time
    local timer t
    local integer task
    local integer i
    local integer j
    local integer k
    if udg_Hashtable_Slow == null then
        set udg_Hashtable_Slow = InitHashtable()
    endif
    if HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), 0) then
        set i = 0
        set j = 0
        loop
            set i = i + 1
        exitwhen HaveSavedInteger(udg_Hashtable_Slow, GetHandleId(target), i) == false
            if LoadInteger(udg_Hashtable_Slow, GetHandleId(target), i) == abilityid then
                set j = i
            endif
        exitwhen j >= 1
        endloop
        if j == 0 then
            set i = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), 0) + 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), 0, i)
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), i, abilityid)
            set k = 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, k)
        else
            set i = j
            set k = LoadInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10) + 1
            call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, k)
        endif
    else
        set i = 1
        call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), 0, i)
        call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), i, abilityid)
        set j = 1
        call SaveInteger(udg_Hashtable_Slow, GetHandleId(target), abilityid * 10, j)
    endif
    if GetUnitAbilityLevel(target, abilityid) == 0 then
        call UnitAddAbility(target, abilityid)
        call UnitMakeAbilityPermanent(target, true, abilityid)
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, abilityid)
    call SaveInteger(udg_ht, task, 3, buffid)
    call DebugMsg("Buff for " + R2S(outcometime) + "s")
    call TimerStart(t, outcometime, false, function UnitBuffTarget_Clear)
    set t = null
endfunction

function Ridicule_Desurice_Conditions takes nothing returns boolean
    local trigger trg
    local integer task
    local unit caster
    local unit target
    local timer t
    if GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER then
        set target = GetOrderedUnit()
        if GetIssuedOrderId() == OrderId("attack") or GetIssuedOrderId() == OrderId("stop") or GetIssuedOrderId() == 851973 then
            set t = null
            set trg = null
            set caster = null
            set target = null
            return false
        else
            set trg = GetTriggeringTrigger()
            set task = GetHandleId(trg)
            set caster = LoadUnitHandle(udg_ht, task, 0)
            call PauseUnit(target, true)
            call IssueImmediateOrder(target, "stop")
            call PauseUnit(target, false)
            call IssueTargetOrder(target, "attack", caster)
        endif
    elseif GetTriggerEventId() == EVENT_UNIT_SELECTED then
        set target = GetTriggerUnit()
        call SelectUnit(target, false)
    elseif GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
        set trg = GetTriggeringTrigger()
        set task = GetHandleId(trg)
        set target = LoadUnitHandle(udg_ht, task, 1)
        if GetUnitAbilityLevel(target, 'A107') != 0 then
            set t = null
            set trg = null
            set caster = null
            set target = null
            return false
        endif
        set t = GetExpiredTimer()
        call TriggerClearConditions(trg)
        if GetOwningPlayer(target) == GetLocalPlayer() then
            call ClearSelection()
            call SelectUnit(target, true)
        endif
        call FlushChildHashtable(udg_ht, task)
        call DisableTrigger(trg)
        call DestroyTrigger(trg)
        call ReleaseTimer(t)
    endif
    set t = null
    set trg = null
    set caster = null
    set target = null
    return false
endfunction

function UnitRidiculeTarget takes unit caster, unit target, real time returns nothing
    local trigger trg
    local integer task
    if IsUnitCCImmune(target) then
        return
    endif
    call SelectUnit(target, false)
    call IssueTargetOrderById(target, 851983, caster)
    set time = DebuffDuration(target, time)
    if GetUnitAbilityLevel(target, 'A107') == 0 then
        set trg = CreateTrigger()
        set task = GetHandleId(trg)
        call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_ISSUED_TARGET_ORDER)
        call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_ISSUED_POINT_ORDER)
        call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_ISSUED_ORDER)
        call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_SELECTED)
        call TriggerRegisterTimerEvent(trg, 0.1, true)
        call TriggerAddCondition(trg, Condition(function Ridicule_Desurice_Conditions))
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
    endif
    call UnitBuffTarget(caster, target, time, 'A17W', 0)
    call UnitBuffTarget(caster, target, time, 'A107', 0)
    call CE_Input(caster, target, time * 10.0)
    call CCSystem_textshow("Taunt", target, time)
    set trg = null
endfunction

function UnitInjureTarget takes unit caster, unit target, real time returns nothing
    if IsUnitCCImmune(target) then
        return
    endif
    call UnitSlowTarget(caster, target, time, 'A0CW', 'B07H')
endfunction

function UnitInjureArea takes unit caster, real x, real y, real range, real time returns nothing
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitInjureTarget(caster, v, time)
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_OverAllControlSystem takes nothing returns nothing
endfunction