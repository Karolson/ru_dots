function Trig_All06_MoonWeapon_CallBack takes nothing returns nothing
    local unit caster = udg_PS_Source
    local unit target = udg_PS_Target
    local integer level = GetUnitAbilityLevel(caster, 'A1GT')
    local real damage = ABCIAllAtk(caster, 0, 0.7)
    call UnitMagicDamageTarget(caster, target, damage, 8)
    call DestroyEffect(AddSpecialEffect("RedLaser.mdl", GetUnitX(target), GetUnitY(target)))
endfunction

function Trig_All06_MoonWeapon_Actions takes boolean wavetype returns nothing
    local unit caster = GetEventDamageSource()
    local group g = CreateGroup()
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit target = GetTriggerUnit()
    local integer cnt = 2
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 650.0, iff)
    call GroupRemoveUnit(g, target)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null or cnt == 0
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_HERO) == wavetype and GetWidgetLife(v) >= 0.405 then
            set cnt = cnt - 1
            call LaunchProjectileToUnitEx("RedLaserX.mdl", 1.4, caster, GetUnitX(caster), GetUnitY(caster), 1400, v, "Trig_All06_MoonWeapon_CallBack")
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set g = null
    set v = null
    set iff = null
    set target = null
endfunction

function Trig_All06_MoonWeapon_Conditions takes nothing returns boolean
    local boolean itemtypem = YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I095')
    local boolean targettype
    if itemtypem == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I094') == false then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    call DebugMsg("MoonWeapon01")
    set targettype = IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
    if itemtypem then
        if targettype == false then
            call Trig_All06_MoonWeapon_Actions(false)
        endif
    else
        if targettype then
            call Trig_All06_MoonWeapon_Actions(true)
        endif
    endif
    return false
endfunction

function InitTrig_All06_MoonWeapon takes nothing returns nothing
    set gg_trg_All06_MoonWeapon = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_All06_MoonWeapon)
    call TriggerAddCondition(gg_trg_All06_MoonWeapon, Condition(function Trig_All06_MoonWeapon_Conditions))
endfunction