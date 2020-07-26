function Trig_Kaguya02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0D2'
endfunction

function Trig_Kaguya02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real a = GetUnitFacing(target) * 0.017454
    local real px
    local real py
    local integer level = GetUnitAbilityLevel(caster, 'A0D2')
    local unit u
    local real d
    call AbilityCoolDownResetion(caster, 'A0D2', 21 - 2 * level)
    call UnitMagicDamageTarget(caster, caster, GetWidgetLife(caster) * 0.15, 1)
    if GetUnitAbilityLevel(target, 'A0V4') == 1 or GetUnitAbilityLevel(target, 'A0A1') == 1 then
        set caster = null
        set target = null
        return
    endif
    if GetUnitTypeId(target) == 'U00M' then
        set caster = null
        set target = null
        return
    endif
    set d = 225 + level * 75
    set px = ox + d * Cos(a)
    set py = oy + d * Sin(a)
    call Trig_BlinkPlaceRealer(px, py, d, a)
    set px = udg_SK_BlinkPlace_x
    set py = udg_SK_BlinkPlace_y
    set u = CreateUnit(GetOwningPlayer(caster), 'e02I', ox, oy, GetRandomInt(1, 360))
    set u = CreateUnit(GetOwningPlayer(caster), 'e02I', ox, oy, GetRandomInt(1, 360))
    set u = CreateUnit(GetOwningPlayer(caster), 'e02I', px, py, GetRandomInt(1, 360))
    set u = CreateUnit(GetOwningPlayer(caster), 'e02I', px, py, GetRandomInt(1, 360))
    call SetUnitXY(target, px, py)
    if IsUnitEnemy(caster, GetOwningPlayer(target)) then
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 40 + level * 30, 2.0), 1)
        call UnitBuffTarget(caster, target, 0.1, 'A17W', 0)
    else
        call UnitHealingTarget(caster, target, ABCIAllInt(caster, 40 + level * 30, 2.0) * 0.45)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Kaguya02 takes nothing returns nothing
endfunction