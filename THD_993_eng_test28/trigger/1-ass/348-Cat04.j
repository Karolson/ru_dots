function Trig_Rin04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0BP'
endfunction

function Rin04_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local player p = GetOwningPlayer(caster)
    local group g
    local unit v
    local string estr
    if GetUnitAbilityLevel(caster, 'A0BP') > 0 then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 3600.0, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetOwningPlayer(v) == p then
                if IsUnitVisible(v, GetLocalPlayer()) then
                    set estr = "Environment\\LargeBuildingFire\\LargeBuildingFire0.mdl"
                else
                    set estr = ""
                endif
                call DestroyEffect(AddSpecialEffect(estr, GetUnitX(v), GetUnitY(v)))
            endif
        endloop
        call DestroyGroup(g)
    endif
    set v = null
    set t = null
    set caster = null
    set p = null
    set g = null
endfunction

function Rin04_onDeath takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local unit caster = GetPlayerCharacter(GetOwningPlayer(u))
    local player p = GetOwningPlayer(caster)
    local unit v
    local real damage
    local group g
    local real x
    local real y
    if GetUnitAbilityLevel(caster, 'A0BP') > 0 then
        set g = CreateGroup()
        set damage = 50 + 10 * GetUnitAbilityLevel(caster, 'A0BP') + 0.3 * GetHeroInt(caster, true)
        set x = GetUnitX(u)
        set y = GetUnitY(u)
        call GroupEnumUnitsInRange(g, x, y, 360.0, null)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", x, y))
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, p) then
                if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                    call UnitMagicDamageTarget(caster, v, damage, 5)
                else
                    call UnitMagicDamageTarget(caster, v, damage * 0.25, 5)
                endif
            endif
        endloop
        call DestroyGroup(g)
        set g = null
        set v = null
    endif
    set u = null
    set caster = null
    return false
endfunction

function Trig_Rin04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = null
    local player p = GetOwningPlayer(caster)
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A0BP')
    local real angle
    local real dis
    local integer cnt
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local group g = CreateGroup()
    call DebugMsg("Rin04" + R2S(x) + " " + R2S(y))
    call GroupEnumUnitsInRange(g, x, y, 380.0, null)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        if (GetOwningPlayer(u) == p and u != caster and GetUnitAbilityLevel(u, 'A0WJ') > 0 and GetWidgetLife(u) > 0.405) or GetWidgetLife(u) < 0.405 then
            set target = u
        endif
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set g = CreateGroup()
    call DebugMsg("Rin0401")
    if target == null then
        call DebugMsg("Rin04 Reset")
        call AbilityCoolDownResetion(caster, 'A0BP', 1)
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 100 + level * 50)
        set caster = null
        set target = null
        set u = null
        set g = null
        return
    else
        call AbilityCoolDownResetion(caster, 'A0BP', 120 - 0 * level)
    endif
    call InstantKill(caster, target)
    call DebugMsg("Rin04Main")
    call UnitStunArea(caster, 1.0, x, y, 380, 0, 0)
    call VE_Spellcast(caster)
    set cnt = 0
    loop
    exitwhen cnt == 1 + level * 1
        set angle = 1.0 * GetRandomInt(0, 360)
        set dis = 1.0 * GetRandomInt(0, 380)
        set u = CreateUnit(udg_PlayerA[0], udg_SU_ID_A[0], x + CosBJ(angle) * dis, y + SinBJ(angle) * dis, 0)
        call addlife(u, GetPlayerTechCount(udg_PlayerA[0], 'R003', true) * 22)
        call KillUnit(u)
        set cnt = cnt + 1
    endloop
    set cnt = 0
    loop
    exitwhen cnt == 1 + level * 1
        set angle = 1.0 * GetRandomInt(0, 360)
        set dis = 1.0 * GetRandomInt(0, 350)
        set u = CreateUnit(udg_PlayerB[0], udg_SU_ID_B[0], x + CosBJ(angle) * dis, y + SinBJ(angle) * dis, 0)
        call addlife(u, GetPlayerTechCount(udg_PlayerB[0], 'R003', true) * 22)
        call KillUnit(u)
        set cnt = cnt + 1
    endloop
    set u = CreateUnit(GetOwningPlayer(caster), 'o000', x, y, 0.0)
    call UnitAddAbility(u, 'A0BQ')
    call SetUnitAbilityLevel(u, 'A0BQ', level)
    call IssueImmediateOrder(u, "animatedead")
    call UnitApplyTimedLife(u, 'B001', 0.5)
    call GroupEnumUnitsInRange(g, x, y, 380.0, null)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        if GetOwningPlayer(u) == p and u != caster then
            call UnitAddAbility(u, 'A0OZ')
            call SetUnitMoveSpeed(u, 420)
        endif
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set caster = null
    set target = null
    set u = null
    set p = null
    set g = null
endfunction

function InitTrig_Cat04 takes nothing returns nothing
endfunction