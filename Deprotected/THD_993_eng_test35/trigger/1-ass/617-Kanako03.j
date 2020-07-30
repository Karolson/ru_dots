function Trig_Kanako03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0F6'
endfunction

function Trig_Kanako03_Target takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    elseif IsUnitAlly(GetFilterUnit(), bj_groupEnumOwningPlayer) then
        return false
    elseif GetCustomState(GetFilterUnit(), 1) != 0 or GetCustomState(GetFilterUnit(), 5) != 0 then
        return false
    endif
    return true
endfunction

function Trig_Kanako03_Shoot_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 then
        call SetUnitX(u, GetUnitX(target))
        call SetUnitY(u, GetUnitY(target))
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
            call UnitMagicDamageTarget(caster, target, 30 + GetHeroInt(caster, true) * 0.3, 5)
        else
            call UnitMagicDamageTarget(caster, target, 60 + GetHeroInt(caster, true) * 0.6, 5)
        endif
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Kanako03_Shoot takes unit caster, unit target, integer level returns nothing
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n03C', GetUnitX(target), GetUnitY(target), 0.0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 16)
    call TimerStart(t, 0.05, true, function Trig_Kanako03_Shoot_Main)
    set u = null
    set t = null
endfunction

function Kanako03_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local group g = LoadGroupHandle(udg_sht, task, 1)
    local boolexpr f = LoadBooleanExprHandle(udg_sht, task, 2)
    local integer n = LoadInteger(udg_sht, task, 0)
    local real ox = LoadReal(udg_sht, task, 1)
    local real oy = LoadReal(udg_sht, task, 2)
    local integer level = LoadInteger(udg_sht, task, 3)
    local real a
    local real d
    local unit v = null
    local unit u
    local player p = GetOwningPlayer(caster)
    if n > 0 then
        call DebugMsg(I2S(n))
        call GroupEnumUnitsInRange(g, ox, oy, 200.0, null)
        loop
            set u = FirstOfGroup(g)
        exitwhen u == null
        exitwhen v != null
            call GroupRemoveUnit(g, u)
            if GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(u, 'Aloc') == 0 and IsUnitEnemy(u, p) then
                set v = u
            endif
        endloop
        if v == null then
            set a = GetRandomReal(0.0, 6.28344)
            set d = GetRandomReal(0.0, 200.0)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", ox + d * Cos(a), oy + d * Sin(a)))
        else
            call Trig_Kanako03_Shoot(caster, v, level)
        endif
        set n = n - 1
        call SaveInteger(udg_sht, task, 0, n)
    else
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call DestroyBoolExpr(f)
        call FlushChildHashtable(udg_sht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set f = null
    set v = null
    set u = null
endfunction

function Trig_Kanako03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0F6')
    local unit v = null
    local unit u
    local integer n = level * 2
    local real s = 1.0 / level
    local group g = CreateGroup()
    local boolexpr f = Filter(function Trig_Kanako03_Target)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real ox = GetSpellTargetX()
    local real oy = GetSpellTargetY()
    local real a
    local real d
    local player p = GetOwningPlayer(caster)
    call AbilityCoolDownResetion(caster, 'A0F6', 8 + level)
    call GroupEnumUnitsInRange(g, ox, oy, 200.0, null)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
    exitwhen v != null
        call GroupRemoveUnit(g, u)
        if GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(u, 'Aloc') == 0 and IsUnitEnemy(u, p) then
            set v = u
        endif
    endloop
    if v == null then
        set a = GetRandomReal(0.0, 6.28344)
        set d = GetRandomReal(0.0, 200.0)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", ox + d * Cos(a), oy + d * Sin(a)))
    else
        call Trig_Kanako03_Shoot(caster, v, level)
    endif
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveInteger(udg_sht, task, 0, n - 1)
    call SaveReal(udg_sht, task, 1, ox)
    call SaveReal(udg_sht, task, 2, oy)
    call SaveGroupHandle(udg_sht, task, 1, g)
    call SaveBooleanExprHandle(udg_sht, task, 2, f)
    call SaveInteger(udg_sht, task, 3, level)
    call TimerStart(t, s, true, function Kanako03_Loop)
    set t = null
    set caster = null
    set g = null
    set f = null
    set v = null
    set u = null
endfunction

function InitTrig_Kanako03 takes nothing returns nothing
endfunction