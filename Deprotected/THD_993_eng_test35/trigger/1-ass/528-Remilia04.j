function Remilia04_Open takes unit caster returns nothing
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1ER', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1EP', true)
    if GetUnitAbilityLevel(caster, 'A1EP') < 1 then
        call UnitAddAbility(caster, 'A1EP')
    endif
    call UnitAddAbility(caster, 'A1ES')
    set caster = null
endfunction

function Remilia04_Stop takes unit caster returns nothing
    call UnitRemoveAbility(caster, 'A1ES')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1EP', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1ER', true)
    set caster = null
endfunction

function Trig_Remilia04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A1EP' then
        call Remilia04_Stop(GetTriggerUnit())
        return false
    endif
    if GetSpellAbilityId() != 'A1ER' then
        return false
    endif
    return true
endfunction

function Remilia04_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    local unit caster = udg_SK_Remilia
    local player p = udg_SK_Remilia_Player
    local real damage = LoadReal(udg_sht, StringHash("Remilia04Damage"), GetHandleId(caster))
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = ox
    local real ty = oy + 700.0
    local real rx = ox + 700.0
    local real ry = oy
    local real bx = ox
    local real by = oy - 700.0
    local real lx = ox - 700.0
    local real ly = oy
    local real targetx = GetUnitX(u)
    local real targety = GetUnitY(u)
    local real at = 57.29578 * Atan2(targety - ty, targetx - tx)
    local real ar = 57.29578 * Atan2(targety - ry, targetx - rx)
    local real ab = 57.29578 * Atan2(targety - by, targetx - bx)
    local real al = 57.29578 * Atan2(targety - ly, targetx - lx)
    local boolean crosscheck
    if at < 0 then
        set at = at + 360.0
    endif
    if ar < 0 then
        set ar = ar + 360.0
    endif
    if ab < 0 then
        set ab = ab + 360.0
    endif
    if al < 0 then
        set al = al + 360.0
    endif
    if (at >= 262.5 and at <= 277.5 and IsUnitInRangeXY(u, tx, ty, 800.0)) or (ar >= 172.5 and ar <= 187.5 and IsUnitInRangeXY(u, rx, ry, 800.0)) or (ab >= 82.5 and ab <= 97.5 and IsUnitInRangeXY(u, bx, by, 800.0)) or (al >= 352.5 or al <= 7.5 and IsUnitInRangeXY(u, lx, ly, 800.0)) then
        set crosscheck = true
    else
        set crosscheck = false
    endif
    if IsUnitEnemy(u, p) and GetWidgetLife(u) > 0.405 and GetUnitAbilityLevel(u, 'A0IL') > 0 == false and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and crosscheck or IsUnitInRange(u, caster, 250.0) then
        call UnitMagicDamageTarget(caster, u, damage, 5)
        if GetUnitAbilityLevel(u, 'A1ER') == 0 then
            call UnitInjureTarget(caster, u, 3.0)
        endif
    endif
    set caster = null
    set p = null
    set u = null
    return false
endfunction

function Remilia04_Timer_out takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer level = GetUnitAbilityLevel(caster, 'A1ER')
    local group g = LoadGroupHandle(udg_sht, task, 1)
    local boolexpr filter = LoadBooleanExprHandle(udg_sht, task, 2)
    local integer castMana = level * 12 + 14
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 600, filter)
    if GetUnitState(caster, UNIT_STATE_MANA) < castMana or GetUnitAbilityLevel(caster, 'A1ES') == 0 then
        call Remilia04_Stop(caster)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call RemoveSavedReal(udg_sht, StringHash("Remilia04Damage"), GetHandleId(caster))
        call DestroyBoolExpr(filter)
        call FlushChildHashtable(udg_Hashtable, task)
    else
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - castMana)
    endif
    set t = null
    set caster = null
    set g = null
    set filter = null
endfunction

function Trig_Remilia04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A1ER')
    local real damage = 0.5 * (50 + level * 30 + GetHeroInt(caster, true) * (0.3 + level * 0.2))
    local group g = CreateGroup()
    local boolexpr filter = Filter(function Remilia04_Filter)
    call Remilia04_Open(caster)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveGroupHandle(udg_sht, task, 1, g)
    call SaveBooleanExprHandle(udg_sht, task, 2, filter)
    call SaveReal(udg_sht, StringHash("Remilia04Damage"), GetHandleId(caster), damage)
    call TimerStart(t, 0.5, true, function Remilia04_Timer_out)
    set caster = null
    set t = null
    set g = null
    set filter = null
endfunction

function InitTrig_Remilia04 takes nothing returns nothing
endfunction