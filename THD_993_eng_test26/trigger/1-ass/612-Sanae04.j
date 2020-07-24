function Trig_Sanae04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1AJ'
endfunction

function Trig_Sanae04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local integer z = LoadInteger(udg_Hashtable, task, 2)
    local unit u = LoadUnitHandle(udg_Hashtable, task, 999)
    local real x0 = GetUnitX(caster)
    local real y0 = GetUnitY(caster)
    local real x1
    local real y1
    local real x2
    local real y2
    local real cz = GetPositionZ(x0, y0)
    local real d = LoadReal(udg_Hashtable, task, 0)
    local real f = LoadReal(udg_Hashtable, task, 1)
    local real a
    local real b
    local integer j
    local lightning e
    call SetUnitX(u, GetUnitX(caster))
    call SetUnitY(u, GetUnitY(caster))
    if i < z and GetUnitCurrentOrder(caster) == OrderId("darkritual") then
        if i < 81 then
            if i / 20 * 20 == i then
                set j = i / 20
                set a = f + 144 * j
                set b = f + 144 * (j + 1)
                set x1 = x0 + d * Cos(a * 0.017454)
                set y1 = y0 + d * Sin(a * 0.017454)
                set x2 = x0 + d * Cos(b * 0.017454)
                set y2 = y0 + d * Sin(b * 0.017454)
                set e = AddLightningEx("HWPB", false, x1, y1, cz + 10, x2, y2, cz + 10)
                call SaveLightningHandle(udg_Hashtable, task, j + 1, e)
            else
                set j = i / 20
            endif
        else
            set j = 5
        endif
        loop
        exitwhen j == 0
            set e = LoadLightningHandle(udg_Hashtable, task, j)
            set a = f + 144 * j
            set b = f + 144 * (j + 1)
            set x1 = x0 + d * Cos(a * 0.017454)
            set y1 = y0 + d * Sin(a * 0.017454)
            set x2 = x0 + d * Cos(b * 0.017454)
            set y2 = y0 + d * Sin(b * 0.017454)
            call MoveLightningEx(e, false, x1, y1, cz + 10, x2, y2, cz + 10)
            set j = j - 1
        endloop
        call SaveInteger(udg_Hashtable, task, 1, i + 1)
    else
        call UnitRemoveAbility(u, 'A06Y')
        call KillUnit(u)
        call ReleaseTimer(t)
        call SetUnitInvulnerable(caster, false)
        if GetUnitCurrentOrder(caster) == OrderId("voodoo") then
            call IssueImmediateOrder(caster, "stop")
        endif
        set j = 5
        loop
        exitwhen j == 0
            set e = LoadLightningHandle(udg_Hashtable, task, j)
            call DestroyLightning(e)
            set j = j - 1
        endloop
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set e = null
endfunction

function Trig_Sanae04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1AJ')
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n00X', GetUnitX(caster), GetUnitY(caster), 0)
    call AbilityCoolDownResetion(caster, 'A1AJ', 150)
    call UnitAddAbility(u, 'A06Y')
    call IssueImmediateOrder(u, "voodoo")
    call CastSpell(caster, "Divine Virtue 'Bumper Crop'!!!")
    call VE_Spellcast(caster)
    call SetUnitInvulnerable(caster, true)
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveInteger(udg_Hashtable, task, 1, 0)
    call SaveInteger(udg_Hashtable, task, 2, 350)
    call SaveReal(udg_Hashtable, task, 0, 250.0 + 150.0 * level)
    call SaveReal(udg_Hashtable, task, 1, GetUnitFacing(caster))
    call SaveUnitHandle(udg_Hashtable, task, 999, u)
    call TimerStart(t, 0.01, true, function Trig_Sanae04_Main)
    set t = null
    set u = null
    set caster = null
endfunction

function InitTrig_Sanae04 takes nothing returns nothing
endfunction