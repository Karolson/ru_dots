function Trig_Alice03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0GX'
endfunction

function Trig_Alice03_Control takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local lightning e = LoadLightningHandle(udg_ht, task, 2)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz
    local real px
    local real py
    local real pz
    local real a
    if GetWidgetLife(caster) > 0.405 and GetWidgetLife(u) > 0.405 then
        if not IsUnitInRange(caster, u, 1200.0) then
            call RemoveDoll(caster, u, true)
        else
            set a = GetUnitFacing(caster) + 75.0
            set ox = ox + 20.0 * CosBJ(a)
            set oy = oy + 20.0 * SinBJ(a)
            set oz = GetPositionZ(ox, oy) + 50.0
            set px = GetUnitX(u)
            set py = GetUnitY(u)
            set pz = GetPositionZ(px, py) + GetUnitFlyHeight(u) + 20.0
            call MoveLightningEx(e, false, ox, oy, oz, px, py, pz)
            if IsUnitVisible(caster, GetLocalPlayer()) and IsUnitVisible(u, GetLocalPlayer()) then
                call SetLightningColor(e, 1.0, 1.0, 1.0, 0.5)
            else
                call SetLightningColor(e, 0.0, 0.0, 0.0, 0.0)
            endif
        endif
    else
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 25)
        if GetWidgetLife(u) > 0.405 then
            call KillUnit(u)
        endif
        call DestroyLightning(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set e = null
endfunction

function Trig_Alice03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer task = GetHandleId(caster)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local unit u
    local group g = LoadGroupHandle(udg_sht, task, 3)
    local integer max = LoadInteger(udg_sht, task, 3)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer n
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12 - GetUnitAbilityLevel(caster, 'A0GX') * 1 - GetUnitAbilityLevel(caster, 'A0GY') * 1)
    set n = CountDollsInGroup(g)
    if n >= max then
        loop
            set u = FirstOfGroup(g)
            call GroupRemoveUnit(g, u)
            if GetWidgetLife(u) > 0.405 then
                call RemoveDoll(caster, u, true)
                set n = n - 1
            exitwhen true
            endif
        endloop
    endif
    set tx = R2I(tx / 64.0 + 0.5) * 64.0
    set ty = R2I(ty / 64.0 + 0.5) * 64.0
    set a = R2I((a + 22.5) / 45.0) * 45.0
    set u = CreateDoll(caster, ConvertDollType(3), tx, ty, a, function Trig_Alice03_Control)
    call UnitRemoveAbility(u, 'Amov')
    call SetDollProperty(caster, u)
    call GroupAddUnit(g, u)
    set n = n + 1
    if GetRandomReal(0, 100) <= 61.8 then
        call SetUnitColor(u, PLAYER_COLOR_PINK)
    else
        call SetUnitColor(u, PLAYER_COLOR_RED)
    endif
    call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, "Hourai: " + I2S(n) + "/" + I2S(max))
    set caster = null
    set u = null
    set g = null
endfunction

function InitTrig_Alice03 takes nothing returns nothing
endfunction