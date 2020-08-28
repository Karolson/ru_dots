function Trig_Renko01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A12Q'
endfunction

function Trig_Renko01_Target01 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Renko01_Target02 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    endif
    return true
endfunction

function Trig_Renko01_Target03 takes nothing returns boolean
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) == false then
        return false
    elseif GetFilterUnit() == GetTriggerUnit() then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    endif
    return true
endfunction

function Trig_RenkoEx_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer bufflevel = LoadInteger(udg_sht, StringHash("RenkoEx"), GetHandleId(caster))
    set bufflevel = bufflevel - 1
    call SaveInteger(udg_sht, StringHash("RenkoEx"), GetHandleId(caster), bufflevel)
    call UnitReduceAttackDamage(caster, 10)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function Trig_RenkoEx_TurnsOn takes unit caster returns nothing
    local timer t
    local integer task
    local integer bufflevel = LoadInteger(udg_sht, StringHash("RenkoEx"), GetHandleId(caster))
    if bufflevel < 8 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        set bufflevel = bufflevel + 1
        call SaveInteger(udg_sht, StringHash("RenkoEx"), GetHandleId(caster), bufflevel)
        call UnitAddAttackDamage(caster, 10)
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call TimerStart(t, 8.0, false, function Trig_RenkoEx_Clear)
    endif
    set t = null
endfunction

function Trig_Renko01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A12Q')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a
    local unit target
    local real tx
    local real ty
    local group g
    local filterfunc f
    local unit v
    local real damage = 15 + 25 * level + GetUnitAttack(caster) * 0.35
    call AbilityCoolDownResetion(caster, 'A12Q', 11 - 1.5 * level)
    call Trig_RenkoEx_TurnsOn(caster)
    set g = CreateGroup()
    set f = Filter(function Trig_Renko01_Target01)
    call GroupEnumUnitsInRange(g, ox, oy, 750.0, f)
    call DestroyFilter(f)
    set target = GetClosestUnitInGroup(ox, oy, g)
    if target == null then
        call DestroyGroup(g)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 750.0, Filter(function Trig_Renko01_Target02))
        set target = GetClosestUnitInGroup(ox, oy, g)
    endif
    call DestroyGroup(g)
    if target != null then
        set tx = GetUnitX(target)
        set ty = GetUnitY(target)
        call DestroyEffect(AddSpecialEffect("Usami Renko_D.MDX", tx, ty))
        if udg_SK_Renko_LastSpell == 1 then
            if GetUnitAbilityLevel(caster, 'A0V4') != 1 and GetUnitAbilityLevel(caster, 'A0A1') != 1 then
                set a = Atan2(ty - oy, tx - ox)
                call DestroyEffect(AddSpecialEffect("Units\\Creeps\\HeroTinkerFactory\\HeroTinkerFactoryMissle.mdl", ox, oy))
                call DestroyEffect(AddSpecialEffect("Units\\Creeps\\HeroTinkerFactory\\HeroTinkerFactoryMissle.mdl", tx + 100 * Cos(a), ty + 100 * Sin(a)))
                call SetUnitXY(caster, tx + 100 * Cos(a), ty + 100 * Sin(a))
                call UnitPhysicalDamageTarget(caster, target, damage)
            endif
        elseif udg_SK_Renko_LastSpell == 2 then
            call UnitPhysicalDamageTarget(caster, target, damage)
            call UnitPhysicalDamageTarget(caster, target, damage)
        elseif udg_SK_Renko_LastSpell == 3 then
            set g = CreateGroup()
            set f = Filter(function Trig_Renko01_Target02)
            call GroupEnumUnitsInRange(g, tx, ty, 300.0, f)
            call DestroyFilter(f)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                call UnitPhysicalDamageTarget(caster, v, damage)
            endloop
            call DestroyGroup(g)
        elseif udg_SK_Renko_LastSpell == 4 then
            call UnitPhysicalDamageTarget(caster, target, damage)
            call UnitPhysicalDamageTarget(caster, target, damage)
            call UnitPhysicalDamageTarget(caster, target, damage)
        endif
    endif
    set udg_SK_Renko_LastSpell = 1
    set caster = null
    set target = null
    set g = null
    set v = null
    set f = null
endfunction

function InitTrig_Renko01 takes nothing returns nothing
endfunction