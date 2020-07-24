function Trig_zhenshan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0BM'
endfunction

function Trig_Cat02_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 3)
    local real y = LoadReal(udg_ht, task, 4)
    local real damage = LoadReal(udg_ht, task, 2)
    local integer count = LoadInteger(udg_ht, task, 5)
    local group g = CreateGroup()
    local unit v
    call GroupEnumUnitsInRange(g, x, y, 225.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(caster)) then
            if GetUnitTypeId(v) == udg_SU_ID_A[0] or GetUnitTypeId(v) == udg_SU_ID_B[0] then
                call UnitMagicDamageTarget(caster, v, (damage + GetHeroInt(caster, true) * 0.8) * 0.5, 6)
            else
                call UnitMagicDamageTarget(caster, v, damage + GetHeroInt(caster, true) * 0.8, 6)
            endif
        endif
    endloop
    call DestroyGroup(g)
    call SaveInteger(udg_ht, task, 5, count + 1)
    if count >= 5 then
        call UnRegisterAreaShow(caster, 'A0BM')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set g = null
    set v = null
    set t = null
    set caster = null
endfunction

function Trig_zhenshan_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local player PLY = GetOwningPlayer(caster)
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local unit u = CreateUnit(PLY, 'n00R', x, y, 0)
    local timer t2
    local integer task2
    local group g = CreateGroup()
    local unit v
    local real damage = 30 + 30 * GetUnitAbilityLevel(caster, 'A0BM')
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
    if false then
        call GroupEnumUnitsInRange(g, x, y, 225.0, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(caster)) then
                if GetUnitTypeId(v) == udg_SU_ID_A[0] or GetUnitTypeId(v) == udg_SU_ID_B[0] then
                    call UnitMagicDamageTarget(caster, v, (damage + GetHeroInt(caster, true) * 0.8) * 0.5, 6)
                else
                    call UnitMagicDamageTarget(caster, v, damage + GetHeroInt(caster, true) * 0.8, 6)
                endif
            endif
        endloop
        call DestroyGroup(g)
    endif
    set t2 = CreateTimer()
    set task2 = GetHandleId(t2)
    call SaveUnitHandle(udg_ht, task2, 1, caster)
    call SaveReal(udg_ht, task2, 2, damage)
    call SaveReal(udg_ht, task2, 3, x)
    call SaveReal(udg_ht, task2, 4, y)
    call SaveInteger(udg_ht, task2, 5, 0)
    call TimerStart(t2, 1, true, function Trig_Cat02_Damage)
    call RegisterAreaShowXY(caster, 'A0BM', x, y, 225, 4, 0, "GhostBall.MDL", 0.02)
    call UnitAddAbility(u, 'A0BN')
    call SetUnitAbilityLevel(u, 'A0BN', GetUnitAbilityLevel(caster, 'A0BM'))
    call TriggerSleepAction(1.0)
    call IssuePointOrder(u, "rainoffire", x, y)
    call TriggerSleepAction(6)
    call KillUnit(u)
    set caster = null
    set PLY = null
    set g = null
    set v = null
    set u = null
endfunction

function InitTrig_Cat02 takes nothing returns nothing
endfunction