function Trig_PachiliDE_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0XJ'
endfunction

function Trig_PachiliDE_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real tx = LoadReal(udg_ht, task, 1)
    local real ty = LoadReal(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 3)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, tx, ty, 225.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call Public_PacQ_MagicDamage(caster, v, 44 + level * 44 + 1.7 * GetHeroInt(caster, true), 5)
            call UnitStunTarget(caster, v, 0.3 + level * 0.3, 0, 0)
        endif
    endloop
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_PachiliDE_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local integer level = GetUnitAbilityLevel(caster, 'A0XJ')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0XJ')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, tx)
    call SaveReal(udg_ht, task, 2, ty)
    call SaveInteger(udg_ht, task, 3, level)
    call TimerStart(t, 1.0, false, function Trig_PachiliDE_Clear)
    set caster = null
    set t = null
endfunction

function InitTrig_PachiliDE takes nothing returns nothing
endfunction