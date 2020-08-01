function s__ensnared_create takes unit target, real time returns integer
    local integer e = s__ensnared__allocate()
    set udg_s__ensnared_u[e] = target
    set udg_s__ensnared_duration[e] = time
    set udg_Daiyousei__ensnaretotal = udg_Daiyousei__ensnaretotal + 1
    set udg_Daiyousei__ensnaredunit[udg_Daiyousei__ensnaretotal] = e
    return e
endfunction

function s__statbonus_create takes unit target, integer atk, integer arm returns integer
    local integer s = s__statbonus__allocate()
    set udg_s__statbonus_u[s] = target
    set udg_s__statbonus_bonusatk[s] = atk
    set udg_s__statbonus_bonusarm[s] = arm
    set udg_s__statbonus_e[s] = AddSpecialEffectTarget(udg_Daiyousei__DAIYOUSEI03_EFFECT, target, "overhead")
    call UnitAddBonusDmg(udg_s__statbonus_u[s], atk)
    call UnitAddBonusArm(udg_s__statbonus_u[s], arm)
    return s
endfunction

function s__statbonus_destroy takes integer this returns nothing
    call UnitAddBonusDmg(udg_s__statbonus_u[this], -udg_s__statbonus_bonusatk[this])
    call UnitAddBonusArm(udg_s__statbonus_u[this], -udg_s__statbonus_bonusarm[this])
    call DestroyEffect(udg_s__statbonus_e[this])
    set udg_s__statbonus_e[this] = null
    set udg_s__statbonus_u[this] = null
    call s__statbonus_deallocate(this)
endfunction

function Daiyousei_Skill_04_OnHit takes nothing returns boolean
    local unit source = udg_PS_Source
    local unit target = udg_PS_Target
    set udg_PS_Source = null
    set udg_PS_Target = null
    call UnitPhysicalDamageTarget(source, target, udg_Daiyousei__DAIYOUSEI04_DAMAGE + (GetUnitAbilityLevel(source, udg_Daiyousei__DAIYOUSEI04) - 1) * udg_Daiyousei__DAIYOUSEI04_DAMAGE_INC + udg_Daiyousei__DAIYOUSEI04_DAMAGE_SCALE * GetUnitAttack(source))
    set source = null
    set target = null
    return false
endfunction

function Daiyousei__Ex_Condition takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local unit v = GetEventDamageSource()
    local real d = 0.0
    if GetUnitAbilityLevel(v, udg_Daiyousei__DAIYOUSEIEX) == 0 or not udg_DAIYOUSEIEX_ACTIVE or IsUnitAlly(u, GetOwningPlayer(v)) or GetEventDamage() == 0 or IsDamageNotUnitAttack(v) then
        set u = null
        set v = null
        return false
    endif
    set d = udg_Daiyousei__DAIYOUSEIEX_DMG_FACTOR * (GetUnitAttack(v) - GetUnitAttack(u))
    if d > 0 then
        call DisableTrigger(GetTriggeringTrigger())
        call UnitPhysicalDamageTarget(v, u, d)
        set udg_DAIYOUSEIEX_ACTIVE = false
        call DestroyEffect(udg_DAIYOUSEIEX_ACTIVE_EFFECT)
        call EnableTrigger(GetTriggeringTrigger())
    endif
    set u = null
    set v = null
    return false
endfunction

function Daiyousei__Ex_Marker takes nothing returns boolean
    local unit u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) and IsUnitAlly(u, GetOwningPlayer(udg_Daiyousei)) and not udg_DAIYOUSEIEX_ACTIVE then
        set udg_DAIYOUSEIEX_ACTIVE = true
        set udg_DAIYOUSEIEX_ACTIVE_EFFECT = AddSpecialEffectTarget(udg_Daiyousei__DAIYOUSEIEX_EFFECT, udg_Daiyousei, "hand left")
    endif
    set u = null
    return false
endfunction

function Daiyousei__Immobilize takes nothing returns nothing
    local integer i = 1
    local integer e
    loop
        set e = udg_Daiyousei__ensnaredunit[i]
        set udg_s__ensnared_duration[e] = udg_s__ensnared_duration[e] - 0.1
        if udg_s__ensnared_duration[e] <= 0 then
            set udg_Daiyousei__ensnaredunit[i] = udg_Daiyousei__ensnaredunit[udg_Daiyousei__ensnaretotal]
            set udg_Daiyousei__ensnaretotal = udg_Daiyousei__ensnaretotal - 1
            call UnitRemoveAbility(udg_s__ensnared_u[e], udg_Daiyousei__DAIYOUSEI02_ENSNARE_BUFF)
            call s__ensnared_deallocate(e)
        endif
    exitwhen i >= udg_Daiyousei__ensnaretotal
        set i = i + 1
    endloop
    if udg_Daiyousei__ensnaretotal == 0 then
        call PauseTimer(udg_Daiyousei__ensnaretimer)
    endif
endfunction

function Daiyousei__RemoveBonus takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer s = LoadInteger(udg_ht, GetHandleId(t), 0)
    call s__statbonus_destroy(s)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
endfunction

function Daiyousei__RemoveInvis takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call UnitRemoveAbility(u, udg_Daiyousei__DAIYOUSEI04_PERM_INVIS)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    set u = null
    set t = null
endfunction

function Daiyousei__GoddamnOwl takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local destructable dt = LoadDestructableHandle(udg_ht, GetHandleId(t), 0)
    local unit v = LoadUnitHandle(udg_ht, GetHandleId(t), 1)
    local unit w = CreateUnit(GetOwningPlayer(v), 'e038', GetDestructableX(dt), GetDestructableY(dt), 0.0)
    call UnitAddAbility(w, 'Aprg')
    call IssueTargetOrder(w, "purge", dt)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    set dt = null
    set t = null
endfunction

function Daiyousei__Skill takes nothing returns boolean
    local destructable dt = null
    local unit u = null
    local unit v = GetTriggerUnit()
    local unit w = null
    local player p = GetOwningPlayer(v)
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(v, id)
    local group g = null
    local real x
    local real y
    local real d
    local real a
    local integer e
    local integer s
    local timer t = null
    if id == udg_Daiyousei__DAIYOUSEI01 then
        call AbilityCoolDownResetion(v, udg_Daiyousei__DAIYOUSEI01, udg_Daiyousei__DAIYOUSEI01_CD_BASE - (lvl - 1) * udg_Daiyousei__DAIYOUSEI01_CD_DECREASE)
        set u = GetSpellTargetUnit()
        set dt = GetSpellTargetDestructable()
        if u != null then
            set x = GetUnitX(u)
            set y = GetUnitY(u)
        elseif dt != null then
            set x = GetDestructableX(dt)
            set y = GetDestructableY(dt)
        else
            return false
        endif
        set d = 400.0 + lvl * 100.0
        set a = Atan2(y - GetUnitY(v), x - GetUnitX(v))
        call Trig_BlinkPlaceRealer(x, y, d, a)
        set x = udg_SK_BlinkPlace_x
        set y = udg_SK_BlinkPlace_y
        call DestroyEffect(AddSpecialEffect(udg_Daiyousei__DAIYOUSEI01_EFFECT, GetUnitX(v), GetUnitY(v)))
        call SetUnitXY(v, x, y)
        call DestroyEffect(AddSpecialEffect(udg_Daiyousei__DAIYOUSEI01_EFFECT, GetUnitX(v), GetUnitY(v)))
        if IsUnitAlly(u, GetOwningPlayer(v)) == false then
            call UnitHealingTarget(v, v, udg_Daiyousei__DAIYOUSEI01_HEAL)
        else
            call UnitHealingTarget(v, u, udg_Daiyousei__DAIYOUSEI01_HEAL)
            call AbilityCoolDownResetion(v, udg_Daiyousei__DAIYOUSEI01, (udg_Daiyousei__DAIYOUSEI01_CD_BASE - (lvl - 1) * udg_Daiyousei__DAIYOUSEI01_CD_DECREASE) / 2)
        endif
        if u != null and IsUnitEnemy(u, p) then
            call UnitPhysicalDamageTarget(v, u, GetUnitAttack(v))
        else
            set t = CreateTimer()
            call SaveDestructableHandle(udg_ht, GetHandleId(t), 0, dt)
            call SaveUnitHandle(udg_ht, GetHandleId(t), 1, v)
            call TimerStart(t, 0.05, false, function Daiyousei__GoddamnOwl)
        endif
        set w = null
        set u = null
        set dt = null
    elseif id == udg_Daiyousei__DAIYOUSEI02 then
        call AbilityCoolDownResetion(v, udg_Daiyousei__DAIYOUSEI02, udg_Daiyousei__DAIYOUSEI02_CD_BASE - (lvl - 1) * udg_Daiyousei__DAIYOUSEI02_CD_DECREASE)
        set x = GetUnitX(v)
        set y = GetUnitY(v)
        set g = CreateGroup()
        set u = NewDummy(p, x, y, 0.0)
        call UnitAddAbility(u, udg_Daiyousei__DAIYOUSEI02_ENSNARE)
        call GroupEnumUnitsInRange(g, x, y, udg_Daiyousei__DAIYOUSEI02_AOE, null)
        loop
            set w = FirstOfGroup(g)
        exitwhen w == null
            call GroupRemoveUnit(g, w)
            if IsUnitEnemy(w, p) and GetUnitAbilityLevel(w, 'Avul') == 0 and not IsUnitType(w, UNIT_TYPE_STRUCTURE) then
                set d = DebuffDuration(w, udg_Daiyousei__DAIYOUSEI02_ENSNARE_DURATION)
                if not IsUnitCCImmune(w) then
                    call IssueTargetOrder(u, udg_Daiyousei__DAIYOUSEI02_ENSNARE_ORDER, w)
                endif
                call RestrictTarget(v, w, udg_Daiyousei__DAIYOUSEI02_ENSNARE_DURATION)
                set e = s__ensnared_create(w, d)
                if udg_Daiyousei__ensnaretotal == 1 then
                    call TimerStart(udg_Daiyousei__ensnaretimer, 0.1, true, function Daiyousei__Immobilize)
                endif
            endif
        endloop
        call UnitRemoveAbility(u, udg_Daiyousei__DAIYOUSEI02_ENSNARE)
        call ReleaseDummy(u)
        call DestroyGroup(g)
        call UnitPhysicalDamageArea(v, x, y, udg_Daiyousei__DAIYOUSEI02_AOE, udg_Daiyousei__DAIYOUSEI02_DAMAGE + (lvl - 1) * udg_Daiyousei__DAIYOUSEI02_DAMAGE_INC + udg_Daiyousei__DAIYOUSEI02_DAMAGE_SCALE * GetUnitAttack(v))
        set g = null
        set u = null
    elseif id == udg_Daiyousei__DAIYOUSEI03 then
        call AbilityCoolDownResetion(v, udg_Daiyousei__DAIYOUSEI03, udg_Daiyousei__DAIYOUSEI03_CD_BASE - (lvl - 1) * udg_Daiyousei__DAIYOUSEI03_CD_DECREASE)
        set u = GetSpellTargetUnit()
        if u == v then
            set s = s__statbonus_create(u, (udg_Daiyousei__DAIYOUSEI03_ATK_BONUS + (lvl - 1) * udg_Daiyousei__DAIYOUSEI03_ATK_BONUS_INC) * 2, udg_Daiyousei__DAIYOUSEI03_ARMOR_BONUS + (lvl - 1) * udg_Daiyousei__DAIYOUSEI03_ARMOR_BONUS_INC)
        else
            set s = s__statbonus_create(u, udg_Daiyousei__DAIYOUSEI03_ATK_BONUS + (lvl - 1) * udg_Daiyousei__DAIYOUSEI03_ATK_BONUS_INC, udg_Daiyousei__DAIYOUSEI03_ARMOR_BONUS + (lvl - 1) * udg_Daiyousei__DAIYOUSEI03_ARMOR_BONUS_INC)
        endif
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, s)
        call TimerStart(t, udg_Daiyousei__DAIYOUSEI03_BONUS_DURATION, false, function Daiyousei__RemoveBonus)
        set t = null
        set u = null
    elseif id == udg_Daiyousei__DAIYOUSEI04 then
        call AbilityCoolDownResetion(v, udg_Daiyousei__DAIYOUSEI04, udg_Daiyousei__DAIYOUSEI04_CD_BASE - (lvl - 1) * udg_Daiyousei__DAIYOUSEI04_CD_DECREASE)
        call DestroyEffect(AddSpecialEffect(udg_Daiyousei__DAIYOUSEI04_GROUND_EFFECT, GetUnitX(v), GetUnitY(v)))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(v), GetUnitY(v), udg_Daiyousei__DAIYOUSEI04_AOE, null)
        loop
            set w = FirstOfGroup(g)
        exitwhen w == null
            call GroupRemoveUnit(g, w)
            if IsUnitEnemy(w, p) and GetWidgetLife(w) > 0.405 and not IsUnitType(w, UNIT_TYPE_STRUCTURE) then
                call LaunchProjectileToUnit(udg_Daiyousei__DAIYOUSEI04_PROJECTILE, 1.0, v, udg_Daiyousei__DAIYOUSEI04_PROJECTILE_SPEED, w, "Daiyousei_Skill_04_OnHit")
            endif
        endloop
        call DestroyGroup(g)
        set g = null
        call UnitAddAbility(v, udg_Daiyousei__DAIYOUSEI04_PERM_INVIS)
        call UnitMakeAbilityPermanent(v, true, udg_Daiyousei__DAIYOUSEI04_PERM_INVIS)
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, v)
        call TimerStart(t, udg_Daiyousei__DAIYOUSEI04_PERM_INVIS_DURATION, false, function Daiyousei__RemoveInvis)
        set t = null
    endif
    set v = null
    return false
endfunction

function Daiyousei_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function Daiyousei__Ex_Marker))
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function Daiyousei__Ex_Condition))
    call RegisterAnyUnitDamage(t)
    set t = CreateTrigger()
    call TriggerRegisterUnitEvent(t, udg_Daiyousei, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function Daiyousei__Skill))
    set udg_Daiyousei__ensnaretimer = CreateTimer()
    call SetHeroLifeIncreaseValue(udg_Daiyousei, 25)
    call SetHeroManaIncreaseValue(udg_Daiyousei, 9)
    set t = null
endfunction

function Trig_Initial_Daiyousei_Actions takes nothing returns nothing
    set udg_Daiyousei = GetCharacterHandle(udg_DAIYOUSEI_CODE)
    call Daiyousei_Init()
endfunction

function InitTrig_Initial_Daiyousei takes nothing returns nothing
    set gg_trg_Initial_Daiyousei = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Daiyousei, function Trig_Initial_Daiyousei_Actions)
endfunction