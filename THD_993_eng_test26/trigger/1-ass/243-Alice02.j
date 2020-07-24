function Trig_Alice02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0GW'
endfunction

function Trig_Alice02_Control takes nothing returns nothing
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
    local real d
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolean k = GetUnitAbilityLevel(u, 'A0HR') == 0
    if GetWidgetLife(caster) > 0.405 and GetWidgetLife(u) > 0.405 and k then
        if i >= 0 then
            if i <= 12 then
                call SaveInteger(udg_ht, task, 1, i + 1)
            else
                call SaveInteger(udg_ht, task, 1, 0)
            endif
        endif
        if not IsUnitInRange(caster, u, 1000.0) then
            set px = GetUnitX(u)
            set py = GetUnitY(u)
            set a = Atan2(py - oy, px - ox)
            set d = GetRandomReal(600.0, 800.0)
            set px = ox + d * Cos(a)
            set py = oy + d * Sin(a)
            if i == 0 then
                call IssuePointOrder(u, "move", px, py)
                call SaveInteger(udg_ht, task, 1, 1)
            endif
        endif
        if not IsUnitInRange(caster, u, 1200.0) then
            call RemoveDoll(caster, u, true)
        else
            set a = GetUnitFacing(caster) - 15.0
            set ox = ox + 30.0 * CosBJ(a)
            set oy = oy + 30.0 * SinBJ(a)
            set oz = GetPositionZ(ox, oy) + 80.0
            set px = GetUnitX(u)
            set py = GetUnitY(u)
            set pz = GetPositionZ(px, py) + GetUnitFlyHeight(u)
            if GetUnitTypeId(u) == 'h01B' then
                set pz = pz + 60.0
            else
                set pz = pz + 20.0
            endif
            call MoveLightningEx(e, false, ox, oy, oz, px, py, pz)
            if IsUnitVisible(caster, GetLocalPlayer()) and IsUnitVisible(u, GetLocalPlayer()) then
                call SetLightningColor(e, 1.0, 1.0, 1.0, 0.5)
            else
                call SetLightningColor(e, 0.0, 0.0, 0.0, 0.0)
            endif
        endif
    else
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 25)
        if GetWidgetLife(u) > 0.405 and k then
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

function Trig_Alice02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer task = GetHandleId(caster)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local unit u
    local group g = LoadGroupHandle(udg_sht, task, 2)
    local integer max = LoadInteger(udg_sht, task, 2)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer n
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12 - GetUnitAbilityLevel(caster, 'A0GW') * 1 - GetUnitAbilityLevel(caster, 'A0GY') * 1)
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
    set u = CreateDoll(caster, ConvertDollType(2), tx, ty, a, function Trig_Alice02_Control)
    call SetDollProperty(caster, u)
    call GroupAddUnit(g, u)
    set n = n + 1
    if GetRandomReal(0, 100) <= 61.8 then
        call SetUnitColor(u, PLAYER_COLOR_ORANGE)
    else
        call SetUnitColor(u, PLAYER_COLOR_GREEN)
    endif
    call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, "New England: " + I2S(n) + "/" + I2S(max))
    set caster = null
    set u = null
    set g = null
endfunction

function InitTrig_Alice02 takes nothing returns nothing
endfunction