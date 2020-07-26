function Trig_Yamame04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0RJ' then
        return true
    endif
    if GetSpellAbilityId() == 'A0YX' then
        set udg_SK_Yamame04 = udg_SK_Yamame04 - 1
        if udg_SK_Yamame04 == 0 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(GetTriggerUnit()), 'A0YX', false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(GetTriggerUnit()), 'A0RJ', true)
        endif
        return true
    endif
    return false
endfunction

function Trig_Yamame04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    set udg_SK_Yamame04 = 0
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0YX', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0RJ', true)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Yamame04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local lightning e1 = LoadLightningHandle(udg_ht, task, 2)
    local lightning e2 = LoadLightningHandle(udg_ht, task, 3)
    local lightning e3 = LoadLightningHandle(udg_ht, task, 4)
    local integer i = LoadInteger(udg_ht, task, 5)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz = GetPositionZ(ox, oy)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real tz = GetPositionZ(tx, ty)
    local real px
    local real py
    local real a = Atan2(ty - oy, tx - ox)
    if i > 0 and not IsUnitType(target, UNIT_TYPE_DEAD) and target != null then
        set i = i - 1
        set px = ox + 30.0 * Cos(a)
        set py = oy + 30.0 * Sin(a)
        call SetUnitXY(caster, px, py)
        call SetUnitFacing(caster, bj_RADTODEG * a)
        call MoveLightningEx(e1, false, ox, oy, oz + 75.0, tx, ty, tz + 75.0)
        call MoveLightningEx(e2, false, ox, oy, oz + 55.0, tx, ty, tz + 55.0)
        call MoveLightningEx(e3, false, ox, oy, oz + 35.0, tx, ty, tz + 35.0)
        if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) < 120.0 then
            set i = 0
        endif
        call SaveInteger(udg_ht, task, 5, i)
    else
        call DestroyLightning(e1)
        call DestroyLightning(e2)
        call DestroyLightning(e3)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e1 = null
    set e2 = null
    set e3 = null
endfunction

function Trig_Yamame04_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0RJ')
    local lightning e1
    local lightning e2
    local lightning e3
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz = GetPositionZ(ox, oy)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real tz = GetPositionZ(tx, ty)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 60 - 10 * level)
    call VE_Spellcast(caster)
    if GetSpellAbilityId() == 'A0RJ' then
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0RJ', false)
        if GetUnitAbilityLevel(caster, 'A0YX') == 0 then
            call UnitAddAbility(caster, 'A0YX')
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0YX', true)
        else
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0YX', true)
        endif
        call SetUnitAbilityLevel(caster, 'A0YX', GetUnitAbilityLevel(caster, 'A0RJ'))
        set udg_SK_Yamame04 = 1 + GetUnitAbilityLevel(caster, 'A0RJ')
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call TimerStart(t, 15, false, function Trig_Yamame04_Clear)
    endif
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        set caster = null
        set target = null
        set e1 = null
        set e2 = null
        set e3 = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set e1 = AddLightningEx("DSTR", false, ox, oy, oz + 75.0, tx, ty, tz + 75.0)
    set e2 = AddLightningEx("DSTR", false, ox, oy, oz + 55.0, tx, ty, tz + 55.0)
    set e3 = AddLightningEx("DSTR", false, ox, oy, oz + 35.0, tx, ty, tz + 35.0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveLightningHandle(udg_ht, task, 2, e1)
    call SaveLightningHandle(udg_ht, task, 3, e2)
    call SaveLightningHandle(udg_ht, task, 4, e3)
    call SaveInteger(udg_ht, task, 5, 150)
    call TimerStart(t, 0.02, true, function Trig_Yamame04_Main)
    if IsUnitAlly(target, GetOwningPlayer(caster)) == false and IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\NightElf\\EntBirthTarget\\EntBirthTarget.mdl", GetUnitX(target), GetUnitY(target)))
        call UnitPhysicalDamageTarget(caster, target, 65 + R2I(GetUnitAttack(caster) * 0.4))
        call UnitMagicDamageTarget(caster, target, 65 + R2I(GetHeroInt(caster, true) * 0.4), 1)
    endif
    set t = null
    set caster = null
    set target = null
    set e1 = null
    set e2 = null
    set e3 = null
endfunction

function InitTrig_Yamame04 takes nothing returns nothing
endfunction