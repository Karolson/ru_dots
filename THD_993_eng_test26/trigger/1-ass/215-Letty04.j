function Trig_Letty04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08P'
endfunction

function Trig_Letty04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u1 = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 4)
    local integer ulevel = LoadInteger(udg_ht, task, 5)
    local group g
    local unit v
    local boolexpr iff
    if i > 0 then
        call SaveInteger(udg_ht, task, 3, i - 1)
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, GetUnitX(u1), GetUnitY(u1), 350, iff)
        if i / 4 * 4 == i then
            call UnitMagicDamageArea(caster, GetUnitX(u1), GetUnitY(u1), 350, 1, 6)
        endif
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if udg_NewDebuffSys then
                    call UnitSlowTargetAspd(caster, v, 25 + level * 10, 0.5, 2, 0)
                    call UnitSlowTargetMspd(caster, v, 30 + level * 15, 0.5, 2, 0)
                else
                    if level == 1 then
                        call UnitSlowTarget(caster, v, 0.5, 'A114', 'B01U')
                    elseif level == 2 then
                        call UnitSlowTarget(caster, v, 0.5, 'A115', 'B01U')
                    else
                        call UnitSlowTarget(caster, v, 0.5, 'A116', 'B01U')
                    endif
                endif
            endif
        endloop
        call DestroyGroup(g)
    else
        call KillUnit(u1)
        call KillUnit(u2)
        call UnRegisterAreaShow(caster, 'A08P')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u1 = null
    set u2 = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Letty04_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit u1 = CreateUnit(GetOwningPlayer(caster), 'n01P', GetUnitX(caster), GetUnitY(caster), 270)
    local unit u2 = CreateUnit(GetOwningPlayer(caster), 'n01Q', GetUnitX(caster), GetUnitY(caster), 270)
    local integer level = GetUnitAbilityLevel(caster, 'A08P')
    local integer ulevel = 0
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 70)
    call SetUnitAnimation(u1, "birth")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u1)
    call SaveUnitHandle(udg_ht, task, 2, u2)
    call SaveInteger(udg_ht, task, 3, 8 * level + 8)
    call SaveInteger(udg_ht, task, 4, level)
    call SaveInteger(udg_ht, task, 5, ulevel)
    call TimerStart(t, 0.25, true, function Trig_Letty04_Main)
    call VE_Spellcast(caster)
    call RegisterAreaShowXY(caster, 'A08P', GetUnitX(caster), GetUnitY(caster), 350, 5, 0, "Abilities\\Weapons\\ZigguratFrostMissile\\ZigguratFrostMissile.mdl", 0.02)
    set caster = null
    set u1 = null
    set u2 = null
    set t = null
endfunction

function InitTrig_Letty04 takes nothing returns nothing
endfunction