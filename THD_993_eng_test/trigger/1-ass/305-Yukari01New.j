function YUKARI01 takes nothing returns integer
    return 'A03F'
endfunction

function YUKARI01_ALT takes nothing returns integer
    return 'A07W'
endfunction

function Yukari01_Gap_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_sht, task, 0)
    call ShowUnitXumn(target, true)
    call PauseUnit(target, false)
    call FlushChildHashtable(udg_sht, task)
    call ReleaseTimer(t)
    set t = null
    set target = null
endfunction

function Yukari01_Gap_Away takes unit caster, unit target returns nothing
    local timer t
    local integer task
    local unit u
    if GetWidgetLife(target) > 0.405 then
        set u = CreateUnit(GetOwningPlayer(caster), 'h011', GetUnitX(target), GetUnitY(target), 0)
        call UnitApplyTimedLife(u, 'BTLF', 0.4)
        call SetUnitTimeScale(u, 2.0)
        call PauseUnit(target, true)
        call ShowUnit(target, false)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_sht, task, 0, target)
        call TimerStart(t, 1.5, false, function Yukari01_Gap_End)
    endif
    set t = null
    set u = null
endfunction

function Yukari01_Loop2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 1)
    local integer ctask = GetHandleId(caster)
    local unit u
    local effect e
    local boolean b = LoadBoolean(udg_sht, StringHash("Yukari01"), ctask)
    local real timeleft = LoadReal(udg_sht, task, 0)
    local real x
    local real y
    if b or timeleft > 9.0 then
        set u = LoadUnitHandle(udg_sht, task, 0)
        set e = LoadEffectHandle(udg_sht, task, 2)
        set x = GetUnitX(u)
        set y = GetUnitY(u)
        call DestroyEffect(e)
        call DestroyEffect(AddSpecialEffect("nebula.mdx", x, y))
        if b then
            call SetUnitPosition(caster, x, y)
        endif
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A07W', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A03F', true)
        call ReleaseVisionDummy(u)
        call ReleaseTimer(t)
        call SaveBoolean(udg_sht, StringHash("Yukari01"), ctask, false)
        call FlushChildHashtable(udg_sht, task)
    elseif timeleft <= 9.0 then
        set timeleft = timeleft + 0.05
        call SaveReal(udg_sht, task, 0, timeleft)
    endif
    set t = null
    set caster = null
    set u = null
    set e = null
endfunction

function Yukari01_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer ctask = GetHandleId(caster)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    local effect e
    local group g = LoadGroupHandle(udg_sht, task, 3)
    local real d = 37.5
    local real tx = LoadReal(udg_sht, task, 1)
    local real ty = LoadReal(udg_sht, task, 2)
    local real cx = GetUnitX(u)
    local real cy = GetUnitY(u)
    local real a = Atan2(ty - cy, tx - cx)
    local real dx = d * Cos(a)
    local real dy = d * Sin(a)
    local unit v
    local timer t2
    local boolean b = false
    local boolean b1 = LoadBoolean(udg_sht, StringHash("Yukari01"), ctask)
    call GroupEnumUnitsInRange(g, cx, cy, 96.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetUnitAbilityLevel(v, 'Aloc') <= 0 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not IsUnitType(v, UNIT_TYPE_ANCIENT) and GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, GetOwningPlayer(caster)) and not IsUnitType(v, UNIT_TYPE_DEAD) and GetUnitAbilityLevel(v, 'Avul') == 0 then
            set b = true
        endif
    exitwhen b
    endloop
    if v != null then
        set t2 = LoadTimerHandle(udg_sht, StringHash("Yukari01"), ctask)
        call UnitMagicDamageTarget(caster, v, 50 * GetUnitAbilityLevel(caster, 'A03F') + 1.6 * GetHeroInt(caster, true), 1)
        if not IsUnitCCImmune(v) then
            call Yukari01_Gap_Away(caster, v)
        endif
        set e = LoadEffectHandle(udg_sht, task, 2)
        call DestroyEffect(e)
        call ReleaseVisionDummy(u)
        call AbilityCoolDownResetion(caster, 'A03F', TimerGetRemaining(t2) - (12.0 - GetUnitAbilityLevel(caster, 'A03F') * 1.0))
        call RemoveSavedHandle(udg_sht, StringHash("Yukari01"), ctask)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A07W', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A03F', true)
        call ReleaseTimer(t)
        call ReleaseTimer(t2)
        call DestroyGroup(g)
        call FlushChildHashtable(udg_sht, task)
    elseif IsUnitInRangeXY(u, tx, ty, 37.5) then
        set e = LoadEffectHandle(udg_sht, task, 2)
        set t2 = LoadTimerHandle(udg_sht, StringHash("Yukari01"), ctask)
        call AbilityCoolDownResetion(caster, 'A03F', TimerGetRemaining(t2))
        call RemoveSavedHandle(udg_sht, StringHash("Yukari01"), ctask)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call FlushChildHashtable(udg_sht, task)
        call PauseTimer(t2)
        set task = GetHandleId(t2)
        call SaveUnitHandle(udg_sht, task, 0, u)
        call SaveUnitHandle(udg_sht, task, 1, caster)
        call SaveEffectHandle(udg_sht, task, 2, e)
        call SaveReal(udg_sht, task, 0, 0.05)
        call SaveBoolean(udg_sht, StringHash("Yukari01"), ctask, false)
        call TimerStart(t2, 0.05, true, function Yukari01_Loop2)
    else
        set cx = cx + dx
        set cy = cy + dy
        if IsTerrainPathable(cx, cy, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, cx)
            call SetUnitY(u, cy)
        endif
        if b1 then
            set e = LoadEffectHandle(udg_sht, task, 2)
            set t2 = LoadTimerHandle(udg_sht, StringHash("Yukari01"), ctask)
            call DestroyEffect(e)
            call DestroyEffect(AddSpecialEffect("nebula.mdx", cx, cy))
            call SetUnitX(caster, cx)
            call SetUnitY(caster, cy)
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A07W', false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A03F', true)
            call ReleaseVisionDummy(u)
            call AbilityCoolDownResetion(caster, 'A03F', TimerGetRemaining(t2))
            call RemoveSavedHandle(udg_sht, StringHash("Yukari01"), ctask)
            call SaveBoolean(udg_sht, StringHash("Yukari01"), ctask, false)
            call RemoveSavedBoolean(udg_sht, StringHash("Yukari01"), ctask)
            call ReleaseTimer(t)
            call ReleaseTimer(t2)
            call DestroyGroup(g)
            call FlushChildHashtable(udg_sht, task)
        endif
    endif
    set t = null
    set t2 = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set e = null
endfunction

function Yukari01_Actions takes nothing returns boolean
    local unit caster
    local unit u
    local integer level
    local real x
    local real y
    local integer ctask
    local timer t
    local timer t2
    local integer task
    local group g
    local effect e
    local real a
    local real cx
    local real cy
    local real tx
    local real ty
    if GetSpellAbilityId() == 'A03F' then
        set caster = GetTriggerUnit()
        set ctask = GetHandleId(caster)
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set t = CreateTimer()
        set t2 = CreateTimer()
        set task = GetHandleId(t2)
        set g = CreateGroup()
        set a = GetUnitFacing(caster)
        set cx = GetUnitX(caster)
        set cy = GetUnitY(caster)
        set tx = cx + 1000.0 * Cos(Atan2(y - cy, x - cx))
        set ty = cy + 1000.0 * Sin(Atan2(y - cy, x - cx))
        set level = GetUnitAbilityLevel(caster, 'A03F')
        call TimerStart(t, 21.0 - 1.0 * level, false, null)
        call SaveTimerHandle(udg_sht, StringHash("Yukari01"), ctask, t)
        set u = NewVisionDummy(GetOwningPlayer(caster), cx, cy, a)
        set e = AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\shadowstrike\\ShadowStrikeMissile.mdl", u, "origin")
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call SaveUnitHandle(udg_sht, task, 1, u)
        call SaveEffectHandle(udg_sht, task, 2, e)
        call SaveGroupHandle(udg_sht, task, 3, g)
        call SaveReal(udg_sht, task, 1, tx)
        call SaveReal(udg_sht, task, 2, ty)
        call TimerStart(t2, 0.03125, true, function Yukari01_Loop)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A03F', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A07W', true)
        if GetUnitAbilityLevel(caster, 'A07W') == 0 then
            call UnitAddAbility(caster, 'A07W')
            call UnitMakeAbilityPermanent(caster, true, 'A07W')
        endif
    elseif GetSpellAbilityId() == 'A07W' then
        set caster = GetTriggerUnit()
        call SaveBoolean(udg_sht, StringHash("Yukari01"), GetHandleId(caster), true)
    endif
    set u = null
    set t = null
    set g = null
    set e = null
    set t2 = null
    set caster = null
    return false
endfunction

function InitTrig_Yukari01New takes nothing returns nothing
endfunction