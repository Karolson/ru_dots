function Trig_StrAgi02_Coin_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A13T' then
        return true
    elseif GetSpellAbilityId() == 'A13U' then
        return true
    elseif GetSpellAbilityId() == 'A13V' then
        return true
    elseif GetSpellAbilityId() == 'A13W' then
        return true
    elseif GetSpellAbilityId() == 'A13X' then
        return true
    endif
    return false
endfunction

function Trig_StrAgi02_Coin_Target takes nothing returns boolean
    if GetOwningPlayer(GetFilterUnit()) != GetOwningPlayer(GetTriggerUnit()) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    elseif GetUnitTypeId(GetFilterUnit()) == 'h00B' then
        return false
    elseif GetUnitTypeId(GetFilterUnit()) == 'h00I' then
        return false
    elseif GetUnitTypeId(GetFilterUnit()) == 'n00A' then
        return false
    elseif GetUnitTypeId(GetFilterUnit()) == 'o005' then
        return false
    elseif IsUnitIllusion(GetFilterUnit()) then
        return true
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return true
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'A0ZU') > 0 then
        return true
    endif
    return false
endfunction

function Trig_Coin_LocRet takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real tx = LoadReal(udg_ht, task, 2)
    local real ty = LoadReal(udg_ht, task, 3)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    if GetWidgetLife(caster) >= 0.405 then
        call SetUnitXY(caster, tx, ty)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", ox, oy))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", tx, ty))
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_StrAgi02_Coin_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real dx = GetSpellTargetX() - ox
    local real dy = GetSpellTargetY() - oy
    local real px
    local real py
    local timer t
    local integer task
    local real a = Atan2(dy, dx)
    local real d = SquareRoot(dx * dx + dy * dy)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        return
    endif
    if GetSpellAbilityId() == 'A13T' then
        set d = RMinBJ(800.0, d)
    elseif GetSpellAbilityId() == 'A13U' then
        set d = RMinBJ(675.0, d)
    elseif GetSpellAbilityId() == 'A13V' then
        set d = RMinBJ(650.0, d)
    elseif GetSpellAbilityId() == 'A13W' then
        set d = RMinBJ(925.0, d)
    elseif GetSpellAbilityId() == 'A13X' then
        set d = RMinBJ(1050.0, d)
    endif
    set px = ox + d * Cos(a)
    set py = oy + d * Sin(a)
    call Trig_BlinkPlaceRealer(px, py, d, a)
    set px = udg_SK_BlinkPlace_x
    set py = udg_SK_BlinkPlace_y
    if GetUnitTypeId(caster) != 'U00M' then
        call SetUnitXY(caster, px, py)
    endif
    if GetUnitAbilityLevel(caster, 'A1HU') != 0 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 1, caster)
        call SaveReal(udg_ht, task, 2, ox)
        call SaveReal(udg_ht, task, 3, oy)
        call TimerStart(t, 3.0, false, function Trig_Coin_LocRet)
        set t = null
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", ox, oy))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", px, py))
    set caster = null
endfunction

function InitTrig_StrAgi02_Coin takes nothing returns nothing
    set gg_trg_StrAgi02_Coin = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StrAgi02_Coin, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_StrAgi02_Coin, Condition(function Trig_StrAgi02_Coin_Conditions))
    call TriggerAddAction(gg_trg_StrAgi02_Coin, function Trig_StrAgi02_Coin_Actions)
endfunction