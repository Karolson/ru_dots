function moveBloodPool takes nothing returns nothing
    local unit u  =  GetEnumUnit()
    local unit uv  =  LoadUnitHandle(udg_ht, GetHandleId(u), 0)
    if GetWidgetLife(uv) >= 0.405 then
        call SetUnitX(u, GetUnitX(uv))
        call SetUnitY(u, GetUnitY(uv))
        call SetUnitFacingTimed(u, GetUnitFacing(uv), 0)
    endif
    set u  =  null
    set uv  =  null
endfunction

function moveBloodPools takes nothing returns nothing
    local unit v
    local timer tt = GetExpiredTimer()
    local integer m = LoadInteger(udg_ht, GetHandleId(tt), 0)
    if GetWidgetLife(udg_s__Kulumi02_projectile_c[m]) >= 0.405 then
        set udg_s__Kulumi02_projectile_cx[m] = GetUnitX(udg_s__Kulumi02_projectile_c[m])
        set udg_s__Kulumi02_projectile_cy[m] = GetUnitY(udg_s__Kulumi02_projectile_c[m])
        set udg_s__Kulumi02_projectile_cfacing[m] = GetUnitFacing(udg_s__Kulumi02_projectile_c[m])
    endif
    set v = FirstOfGroup(udg_s__Kulumi02_projectile_g1[m])
    if (v == null) then
        call ReleaseTimer(tt)
        set v = null
        set tt = null
        return
    endif
    call ForGroup(udg_s__Kulumi02_projectile_g1[m], function moveBloodPool)
    set v = null
    set tt = null
endfunction

function s__Kulumi02_projectile_create takes unit u, unit c, unit e, boolexpr iff, group g1 returns integer
    local timer t = CreateTimer()
    local integer m = s__Kulumi02_projectile__allocate()
    local timer tt = CreateTimer()
    set udg_s__Kulumi02_projectile_u[m] = u
    set udg_s__Kulumi02_projectile_c[m] = c
    set udg_s__Kulumi02_projectile_iff[m] = iff
    set udg_s__Kulumi02_projectile_ux[m] = GetUnitX(u)
    set udg_s__Kulumi02_projectile_uy[m] = GetUnitY(u)
    set udg_s__Kulumi02_projectile_cx[m] = GetUnitX(c)
    set udg_s__Kulumi02_projectile_cy[m] = GetUnitY(c)
    set udg_s__Kulumi02_projectile_ufacing[m] = GetUnitFacing(u)
    set udg_s__Kulumi02_projectile_cfacing[m] = GetUnitFacing(c)
    set udg_s__Kulumi02_projectile_e[m] = e
    set udg_s__Kulumi02_projectile_g1[m] = g1
    set udg_s__Kulumi02_projectile_i[m] = 0
    call SaveInteger(udg_ht, GetHandleId(t), 0, m)
    call RegisterAreaShow(c, udg_Kulumi__Kulumi02, udg_Kulumi__Kulumi02_AOE, 7, 1, "Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", 0.5)
    call TimerStart(t, 0.5, true, function sc__Kulumi02_projectile_Kulumi02Sleep)
    set t = null
    call SaveInteger(udg_ht, GetHandleId(tt), 0, m)
    call TimerStart(tt, 0.01, true, function moveBloodPools)
    set tt = null
    return m
endfunction

function s__Kulumi02_projectile_destroy takes integer this returns nothing
    call UnRegisterAreaShow(udg_s__Kulumi02_projectile_c[this], udg_Kulumi__Kulumi02)
    set udg_s__Kulumi02_projectile_u[this] = null
    set udg_s__Kulumi02_projectile_c[this] = null
    set udg_s__Kulumi02_projectile_e[this] = null
    call ReleaseDummy(udg_s__Kulumi02_projectile_e[this])
    call DestroyGroup(udg_s__Kulumi02_projectile_g1[this])
    call s__Kulumi02_projectile_deallocate(this)
endfunction

function s__Kulumi02_projectile_Kulumi02Sleep takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v
    local group g
    local integer i
    local real dis
    local real a
    local integer m = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__Kulumi02_projectile_i[m] > 12 then
        call KillUnit(udg_s__Kulumi02_projectile_c[m])
    else
        set udg_s__Kulumi02_projectile_i[m] = udg_s__Kulumi02_projectile_i[m] + 1
    endif
    if GetUnitState(udg_s__Kulumi02_projectile_c[m], UNIT_STATE_MANA) == 1000 then
        call KillUnit(udg_s__Kulumi02_projectile_c[m])
    endif
    if GetWidgetLife(udg_s__Kulumi02_projectile_c[m]) >= 0.405 then
        set i = 0
        loop
        exitwhen i >= 15
            set dis = GetRandomReal(0, udg_Kulumi__Kulumi02_AOE)
            set a = GetRandomInt(0, 360)
            call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", udg_s__Kulumi02_projectile_cx[m] + dis * CosBJ(a), udg_s__Kulumi02_projectile_cy[m] + dis * SinBJ(a)))
            set i = i + 1
        endloop
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, udg_s__Kulumi02_projectile_cx[m], udg_s__Kulumi02_projectile_cy[m], udg_Kulumi__Kulumi02_AOE, udg_s__Kulumi02_projectile_iff[m])
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if udg_NewDebuffSys then
                call UnitDebuffTarget(udg_s__Kulumi02_projectile_c[m], v, 0.5 * 1.0, 2, true, 'A04D', 1, 'B084', "drunkenhaze", 'A05P', "")
            else
                call UnitCurseTarget(udg_s__Kulumi02_projectile_c[m], v, 0.5, 'A11G', "drunkenhaze")
            endif
        endloop
        call DestroyGroup(g)
    else
        call ShowUnit(udg_s__Kulumi02_projectile_u[m], true)
        call SetUnitX(udg_s__Kulumi02_projectile_u[m], udg_s__Kulumi02_projectile_cx[m])
        call SetUnitY(udg_s__Kulumi02_projectile_u[m], udg_s__Kulumi02_projectile_cy[m])
        call SetUnitFacingTimed(udg_s__Kulumi02_projectile_u[m], udg_s__Kulumi02_projectile_cfacing[m], 0)
        call SetUnitAnimation(udg_s__Kulumi02_projectile_u[m], "stand")
        call SetUnitInvulnerable(udg_s__Kulumi02_projectile_u[m], false)
        call PauseUnit(udg_s__Kulumi02_projectile_u[m], false)
        call SelectUnitForPlayerSingle(udg_s__Kulumi02_projectile_u[m], GetOwningPlayer(udg_Kulumi))
        call FlushChildHashtable(udg_ht, task)
        call UnitRemoveAbility(udg_s__Kulumi02_projectile_e[m], 'A17B')
        loop
            set v = FirstOfGroup(udg_s__Kulumi02_projectile_g1[m])
        exitwhen v == null
            call GroupRemoveUnit(udg_s__Kulumi02_projectile_g1[m], v)
            call RemoveUnit(v)
        endloop
        call DestroyGroup(udg_s__Kulumi02_projectile_g1[m])
        set udg_Kulumi_i = 0
        call s__Kulumi02_projectile_destroy(m)
        call ReleaseTimer(t)
    endif
    set t = null
    set v = null
    set g = null
endfunction

function Kulumi__KulumiTim takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call ReleaseTimer(t)
    set t = null
endfunction

function Kulumi__KulumiAttack_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), udg_Kulumi__KulumiEx) == 0 then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Kulumi__KulumiAttack_Actions takes nothing returns nothing
    local unit u = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local unit v
    local unit uv
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local group g = CreateGroup()
    local timer t = CreateTimer()
    local unit tmp
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(u))]
    local integer lvl = GetUnitAbilityLevel(u, udg_Kulumi__Kulumi03)
    local integer lvl4 = GetUnitAbilityLevel(u, udg_Kulumi__Kulumi04)
    local real dmg = udg_Kulumi__Kulumi03_DMG_BASE + udg_Kulumi__Kulumi03_DMG_INC * (lvl - 1) + GetHeroInt(u, true) * udg_Kulumi__Kulumi03_DMG_SCALE
    local real dmg2 = ((lvl4 - 1) * udg_Kulumi__Kulumi04_DMG_INC + udg_Kulumi__Kulumi04_DMG_BASE + RMaxBJ(udg_Kulumi__Kulumi04_DMG_SCALE * GetUnitAttack(u), udg_Kulumi__Kulumi04_DMG_SCALE_INC * GetHeroInt(u, true))) * (1 - GetUnitState(target, UNIT_STATE_LIFE) / GetUnitState(target, UNIT_STATE_MAX_LIFE))
    call UnitHealingTarget(u, u, udg_Kulumi__KulumiEx_HEALTH + GetHeroLevel(u) * 1.2)
    call AddTimedEffectToUnit(u, 1.0, udg_Kulumi__Kulumi01_EFFECT, "origin")
    if lvl4 > 0 and IsUnitType(target, UNIT_TYPE_HERO) then
        set tmp = CreateUnit(GetOwningPlayer(target), 'e03O', ox, oy, 0)
        call SetUnitScale(tmp, 1.3, 1.3, 1.3)
        call KillUnit(tmp)
        set tmp = null
        call UnitAbsDamageTarget(u, target, dmg2)
    endif
    if lvl > 0 then
        call UnitMagicDamageArea(u, ox, oy, udg_Kulumi__Kulumi03_AOE, dmg, 5)
        call GroupEnumUnitsInRange(g, ox, oy, udg_Kulumi__Kulumi03_AOE, iff)
        set uv = NewDummy(GetOwningPlayer(u), ox, oy, 270.0)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call UnitDebuffTarget(uv, v, 4.0, 1, true, 'A11K', lvl, 'B094', "slow", 0, "")
            call GroupRemoveUnit(g, v)
            call AddTimedEffectToUnit(v, 4.0, udg_Kulumi__Kulumi01_EFFECT, "origin")
        endloop
        call ReleaseDummy(uv)
        set uv = null
        call TimerStart(t, 4, true, function Kulumi__KulumiTim)
        call DestroyGroup(g)
    endif
    set u = null
    set v = null
    set uv = null
    set g = null
    set tmp = null
    set iff = null
    set t = null
    set target = null
endfunction

function Kulumi__Health takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    if (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) == false then
        call UnitHealingTarget(u, u, 3.0)
    endif
    set t = null
    set u = null
endfunction

function Kulumi__Kulumi02Slam takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 1)
    local unit uv
    local real ux = GetUnitX(u)
    local real uy = GetUnitY(u)
    local integer lvl = GetUnitAbilityLevel(u, udg_Kulumi__Kulumi02)
    local integer ei = 0
    local player p = GetOwningPlayer(u)
    local group g1 = CreateGroup()
    local unit c = CreateUnit(p, udg_Kulumi__KulumiCoffin, ux, uy, GetUnitFacing(u))
    local unit e = NewDummy(p, ux, uy, 270.0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(p)]
    local integer m
    call UnitAddMaxLife(c, R2I(udg_Kulumi__Kulumi02_HP_SCALE * GetHeroInt(u, true) + (lvl - 1) * 100))
    call SetUnitMoveSpeed(c, GetUnitDefaultMoveSpeed(u) * (0.3 + lvl * 0.1))
    loop
    exitwhen ei > 7
        set uv = CreateUnit(p, 'n053', ux, uy, 53 * ei)
        call SaveUnitHandle(udg_ht, GetHandleId(uv), 0, c)
        call GroupAddUnit(g1, uv)
        set ei = ei + 1
    endloop
    set m = s__Kulumi02_projectile_create(u, c, e, iff, g1)
    if p == GetLocalPlayer() then
        call ClearSelection()
        call SelectUnit(c, true)
    endif
    call ShowUnit(u, false)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set uv = null
    set c = null
    set e = null
    set iff = null
    set g1 = null
    set p = null
endfunction

function Kulumi__KulumiTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 1)
    local integer i = LoadInteger(udg_ht, GetHandleId(t), 2) + 1
    call SaveInteger(udg_ht, GetHandleId(t), 2, i)
    if i < 26 then
        call SetUnitVertexColor(u, 255, 255, 255, 255)
        call UnitFade(u, false, false, 0.1)
    else
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
    endif
    set u = null
    set t = null
endfunction

function Kulumi__Skill takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local unit v
    local unit c
    local player p = GetOwningPlayer(u)
    local unit tar
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(u, id)
    local real dis
    local real a
    local real dmg
    local real ux = GetUnitX(u)
    local real uy = GetUnitY(u)
    local group g = CreateGroup()
    local timer t = null
    if id == udg_Kulumi__Kulumi01 then
        call AbilityCoolDownResetion(u, id, udg_Kulumi__Kulumi01_CD_BASE - (lvl - 1) * udg_Kulumi__Kulumi01_CD_DECREASE)
        set t = CreateTimer()
        set dmg = udg_Kulumi__Kulumi01_DMG_BASE + udg_Kulumi__Kulumi01_DMG_INC * (lvl - 1) + udg_Kulumi__Kulumi01_DMG_SCALE * GetUnitAttack(u)
        set tar = GetSpellTargetUnit()
        call AbilityCoolDownResetion(u, udg_Kulumi__Kulumi01, 6.0)
        call SetUnitInvulnerable(u, true)
        call PauseUnit(u, true)
        call SaveUnitHandle(udg_ht, GetHandleId(t), 1, u)
        call TimerStart(t, 0.02, true, function Kulumi__KulumiTimer)
        set a = Atan2(GetUnitY(tar) - uy, GetUnitX(tar) - ux)
        set dis = DistanceBetweenPoints(GetUnitLoc(u), GetUnitLoc(tar))
        loop
        exitwhen dis < 30
            call AddTimedEffectToPoint(ux + dis * Cos(a), uy + dis * Sin(a), 1, "Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
            set dis = dis - 60
        endloop
        call UnitPhysicalDamageTarget(u, tar, dmg)
        call SetUnitX(u, GetUnitX(tar))
        call SetUnitY(u, GetUnitY(tar))
        call SetUnitInvulnerable(u, false)
        call PauseUnit(u, false)
        call SelectUnitForPlayerSingle(u, GetOwningPlayer(u))
        call IssueTargetOrder(u, "attack", tar)
        call AddTimedEffectToUnit(tar, 2.0, udg_Kulumi__Kulumi01_EFFECT, "origin")
    elseif id == udg_Kulumi__Kulumi02 then
        call AbilityCoolDownResetion(u, id, udg_Kulumi__Kulumi02_CD_BASE - (lvl - 1) * udg_Kulumi__Kulumi02_CD_DECREASE)
        set t = CreateTimer()
        call PauseUnit(u, true)
        call SetUnitInvulnerable(u, true)
        call SetUnitAnimation(u, "spell slam")
        call SaveUnitHandle(udg_ht, GetHandleId(t), 1, u)
        call TimerStart(t, 0.5, false, function Kulumi__Kulumi02Slam)
    endif
    set u = null
    set v = null
    set c = null
    set p = null
    set tar = null
    set g = null
    set t = null
    return false
endfunction

function Kulumi_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    local timer tim = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(tim), 1, udg_Kulumi)
    call TimerStart(tim, 1.0, true, function Kulumi__Health)
    if udg_Kulumi__Kulumi_InitedPassive == false then
        set udg_Kulumi__Kulumi_InitedPassive = true
        call RegisterAnyUnitDamage(t)
        call TriggerAddCondition(t, Condition(function Kulumi__KulumiAttack_Conditions))
        call TriggerAddAction(t, function Kulumi__KulumiAttack_Actions)
    endif
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function Kulumi__Skill))
    call TriggerRegisterUnitEvent(t, udg_Kulumi, EVENT_UNIT_SPELL_EFFECT)
    call SetHeroLifeIncreaseValue(udg_Kulumi, 25)
    call SetHeroManaIncreaseValue(udg_Kulumi, 2)
    set t = null
endfunction

function Trig_Initial_Kulumi_Actions takes nothing returns nothing
    set udg_Kulumi = GetCharacterHandle(udg_Kulumi_CODE)
    call FirstAbilityInit('A04D')
    call FirstAbilityInit('A11G')
    call FirstAbilityInit('A17B')
    call FirstAbilityInit('A11K')
    call Kulumi_Init()
endfunction

function InitTrig_Initial_Kulumi takes nothing returns nothing
    set gg_trg_Initial_Kulumi = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Kulumi, function Trig_Initial_Kulumi_Actions)
endfunction