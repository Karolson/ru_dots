function Trig_Iku04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0A4'
endfunction

function Trig_Iku04_DelayEffect2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 2)
    set px = ox + 700.0 * Cos(a)
    set py = oy + 700.0 * Sin(a)
    set u = CreateUnit(GetOwningPlayer(caster), 'n01Z', px, py, bj_RADTODEG * a)
    call SetUnitScale(u, 2.5, 2.5, 2.5)
    call SetUnitTimeScale(u, 3.0)
    call UnitApplyTimedLife(u, 'BTLF', 0.1)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set u = null
    set caster = null
    set t = null
endfunction

function Trig_Iku04_DelayEffect1 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 2)
    set px = ox + 630.0 * Cos(a)
    set py = oy + 630.0 * Sin(a)
    set u = CreateUnit(GetOwningPlayer(caster), 'n01Z', px, py, bj_RADTODEG * a)
    call SetUnitScale(u, 3.5, 3.5, 3.5)
    call SetUnitTimeScale(u, 3.0)
    call UnitApplyTimedLife(u, 'BTLF', 0.1)
    call TimerStart(t, 0.05, false, function Trig_Iku04_DelayEffect2)
    set u = null
    set caster = null
    set t = null
endfunction

function Trig_Iku04_Filter takes nothing returns boolean
    return GetWidgetLife(GetFilterUnit()) > 0.405 and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not (GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0) and IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer)
endfunction

function Trig_Iku04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit v
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real dx = GetSpellTargetX() - ox
    local real dy = GetSpellTargetY() - oy
    local real px
    local real py
    local real a = Atan2(dy, dx)
    local real d
    local real e
    local integer level = GetUnitAbilityLevel(caster, 'A0A4')
    local real damage = 200.0 + level * 50.0 + 2.5 * GetHeroInt(caster, true)
    local group g
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local player p = GetOwningPlayer(caster)
    call AbilityCoolDownResetion(caster, 'A0A4', 80)
    call VE_Spellcast(caster)
    set px = ox + 550.0 * Cos(a)
    set py = oy + 550.0 * Sin(a)
    set u = CreateUnit(GetOwningPlayer(caster), 'n01Z', px, py, bj_RADTODEG * a)
    call SetUnitScale(u, 5.0, 5.0, 5.0)
    call SetUnitTimeScale(u, 3.0)
    call UnitApplyTimedLife(u, 'BTLF', 0.1)
    call AttachSoundToUnit(gg_snd_LightningShieldTarget, u)
    call SetSoundVolume(gg_snd_LightningShieldTarget, 127)
    call StartSound(gg_snd_LightningShieldTarget)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveReal(udg_ht, task, 2, a)
    call TimerStart(t, 0.05, false, function Trig_Iku04_DelayEffect1)
    set px = ox + 750.0 * Cos(a)
    set py = oy + 750.0 * Sin(a)
    set u = NewDummy(p, px, py, 0)
    set a = bj_RADTODEG * a + 180.0
    if a >= 360.0 then
        set a = a - 360.0
    endif
    if GetUnitAbilityLevel(caster, 'B01T') > 0 then
        set damage = damage + 12.5 * GetUnitAbilityLevel(caster, 'A04O')
    endif
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, px, py, 800.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not (GetUnitAbilityLevel(v, 'A0IL') > 0) and IsUnitEnemy(v, p) then
            set dx = GetUnitX(v) - px
            set dy = GetUnitY(v) - py
            set d = SquareRoot(dx * dx + dy * dy)
            set e = RAbsBJ(YawError(a, bj_RADTODEG * Atan2(dy, dx)))
            if e <= 15.0 + 0.03 * (800.0 - d) then
                call UnitDebuffTarget(caster, v, 2.0 + I2R(level), 1, true, 'A0B6', level, 'B027', "purge", 0, "")
                call UnitMagicDamageTarget(caster, v, damage, 5)
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitRemoveAbility(u, 'A0B6')
    call ReleaseDummy(u)
    set caster = null
    set u = null
    set v = null
    set g = null
    set t = null
endfunction

function InitTrig_Iku04 takes nothing returns nothing
endfunction