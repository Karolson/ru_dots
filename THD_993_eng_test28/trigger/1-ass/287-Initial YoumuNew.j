function s__YoumuNew_d_create takes unit caster, real damage, integer p returns integer
    local timer t = CreateTimer()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer d = s__YoumuNew_d__allocate()
    set udg_s__YoumuNew_d_caster[d] = caster
    set udg_s__YoumuNew_d_damage[d] = damage
    set udg_s__YoumuNew_d_cx[d] = GetUnitX(caster)
    set udg_s__YoumuNew_d_cy[d] = GetUnitY(caster)
    set udg_s__YoumuNew_d_a[d] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__YoumuNew_d_p[d] = p
    set udg_s__YoumuNew_d_i[d] = 0
    call SaveInteger(udg_ht, GetHandleId(t), 0, d)
    call SetUnitPathing(caster, false)
    call UnitAddAbility(caster, 'Arav')
    call UnitRemoveAbility(caster, 'Arav')
    call TimerStart(t, 0.02, true, function sc__YoumuNew_d_dSkill_Action)
    set t = null
    return d
endfunction

function s__YoumuNew_d_destroy takes integer this returns nothing
    set udg_s__YoumuNew_d_caster[this] = null
    call s__YoumuNew_d_deallocate(this)
endfunction

function s__YoumuNew_d_dSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit sp = null
    local integer d = LoadInteger(udg_ht, GetHandleId(t), 0)
    local real damage03 = (udg_YoumuNew__YoumuNew03_DAMAGE_BASE + udg_YoumuNew__YoumuNew03_DAMAGE_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_d_caster[d], udg_YoumuNew__YoumuNew03) - 1)) / 100
    set udg_s__YoumuNew_d_i[d] = udg_s__YoumuNew_d_i[d] + 1
    call SetUnitX(udg_s__YoumuNew_d_caster[d], GetUnitX(udg_s__YoumuNew_d_caster[d]) + Cos(udg_s__YoumuNew_d_a[d]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    call SetUnitY(udg_s__YoumuNew_d_caster[d], GetUnitY(udg_s__YoumuNew_d_caster[d]) + Sin(udg_s__YoumuNew_d_a[d]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    if udg_s__YoumuNew_d_i[d] < 13 then
        call SetUnitFlyHeight(udg_s__YoumuNew_d_caster[d], GetUnitFlyHeight(udg_s__YoumuNew_d_caster[d]) + udg_YoumuNew__YoumuNew01_FLYRATE * 0.02, 99999)
    else
        call SetUnitFlyHeight(udg_s__YoumuNew_d_caster[d], GetUnitFlyHeight(udg_s__YoumuNew_d_caster[d]) - udg_YoumuNew__YoumuNew01_FLYRATE * 0.02, 99999)
    endif
    if udg_s__YoumuNew_d_i[d] > 25 then
        set udg_s__YoumuNew_d_cx[d] = GetUnitX(udg_s__YoumuNew_d_caster[d])
        set udg_s__YoumuNew_d_cy[d] = GetUnitY(udg_s__YoumuNew_d_caster[d])
        call SetUnitPathing(udg_s__YoumuNew_d_caster[d], true)
        if udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] == 0 then
            call UnitPhysicalDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d])
            if GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_d_caster[d], udg_YoumuNew__YoumuNew03) - 1) then
                set sp = CreateUnit(GetOwningPlayer(udg_s__YoumuNew_d_caster[d]), 'n057', udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], GetUnitFacing(udg_s__YoumuNew_d_caster[d]))
                call SetUnitAnimation(sp, "spell five alternate")
                call UnitMagicDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03, 5)
            endif
            call FlushChildHashtable(udg_ht, GetHandleId(t))
            call ReleaseTimer(t)
            call s__YoumuNew_d_destroy(d)
        elseif udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] == 1 then
            call UnitMagicDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d], 5)
            if GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_d_caster[d], udg_YoumuNew__YoumuNew03) - 1) then
                set sp = CreateUnit(GetOwningPlayer(udg_s__YoumuNew_d_caster[d]), 'n057', udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], GetUnitFacing(udg_s__YoumuNew_d_caster[d]))
                call SetUnitAnimation(sp, "spell five alternate")
                call UnitPhysicalDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03)
            endif
            call FlushChildHashtable(udg_ht, GetHandleId(t))
            call ReleaseTimer(t)
            call s__YoumuNew_d_destroy(d)
        elseif udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] == 2 then
            call UnitPhysicalDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03)
            call UnitMagicDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03, 5)
            call s__YoumuNew_d_create(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_damage[d], udg_s__YoumuNew_d_p[d])
            if udg_SK_YoumuNewExLast[udg_s__YoumuNew_d_p[d]] == 0 then
                call CastSpell(udg_YoumuNew, "Roukanken")
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "alternate", false)
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "defend upgrade first", true)
            elseif udg_SK_YoumuNewExLast[udg_s__YoumuNew_d_p[d]] == 1 then
                call CastSpell(udg_s__YoumuNew_d_caster[d], "Hakurouken")
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "alternate", false)
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "upgrade first", true)
            endif
            set udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] = udg_SK_YoumuNewExLast[udg_s__YoumuNew_d_p[d]]
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl", udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d]))
    endif
    set t = null
    set sp = null
endfunction

function s__YoumuNew_w_create takes unit caster, real x, real y, real damage, integer p returns integer
    local timer t = CreateTimer()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer w = s__YoumuNew_w__allocate()
    set udg_s__YoumuNew_w_caster[w] = caster
    set udg_s__YoumuNew_w_damage[w] = damage
    set udg_s__YoumuNew_w_cx[w] = GetUnitX(caster)
    set udg_s__YoumuNew_w_cy[w] = GetUnitY(caster)
    set udg_s__YoumuNew_w_a[w] = Atan2(y - udg_s__YoumuNew_w_cy[w], x - udg_s__YoumuNew_w_cx[w])
    set udg_s__YoumuNew_w_p[w] = p
    set udg_s__YoumuNew_w_i[w] = 0
    set udg_s__YoumuNew_w_iff[w] = iff
    set udg_s__YoumuNew_w_n[w] = 1
    set udg_s__YoumuNew_w_g2[w] = CreateGroup()
    call SaveInteger(udg_ht, GetHandleId(t), 0, w)
    call UnitAddAbility(caster, 'Arav')
    call UnitRemoveAbility(caster, 'Arav')
    call TimerStart(t, 0.02, true, function sc__YoumuNew_w_wSkill_Action)
    call VE_Spellcast(caster)
    set t = null
    return w
endfunction

function s__YoumuNew_w_destroy takes integer this returns nothing
    set udg_s__YoumuNew_w_caster[this] = null
    set udg_s__YoumuNew_w_u[this] = null
    call s__YoumuNew_w_deallocate(this)
endfunction

function s__YoumuNew_w_wSkill_Spell_Move takes nothing returns nothing
    local integer w = udg_YoumuNew_int
    if udg_s__YoumuNew_w_n[w] < 3 then
        set udg_s__YoumuNew_w_n[w] = udg_s__YoumuNew_w_n[w] + 1
    else
        set udg_s__YoumuNew_w_n[w] = 1
    endif
    call SetUnitX(GetEnumUnit(), GetUnitX(udg_s__YoumuNew_w_u[w]) + 200 * Cos(udg_s__YoumuNew_w_a[w] + 0.2 * udg_s__YoumuNew_w_i[w] + 1.57 * udg_s__YoumuNew_w_n[w]))
    call SetUnitY(GetEnumUnit(), GetUnitY(udg_s__YoumuNew_w_u[w]) + 200 * Sin(udg_s__YoumuNew_w_a[w] + 0.2 * udg_s__YoumuNew_w_i[w] + 1.57 * udg_s__YoumuNew_w_n[w]))
    call SetUnitFacing(GetEnumUnit(), (udg_s__YoumuNew_w_a[w] + 0.2 * udg_s__YoumuNew_w_i[w] + 0.785 * udg_s__YoumuNew_w_n[w]) / 3.14 * 180 + 90)
    call DebugMsg("udg_YoumuNew struct2:" + I2S(w))
endfunction

function s__YoumuNew_w_wSkill_main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 1)
    local real damage03 = (udg_YoumuNew__YoumuNew03_DAMAGE_BASE + udg_YoumuNew__YoumuNew03_DAMAGE_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_w_caster[w], udg_YoumuNew__YoumuNew03) - 1)) / 100
    set udg_s__YoumuNew_w_n[w] = 1
    set udg_s__YoumuNew_w_i[w] = udg_s__YoumuNew_w_i[w] + 1
    call SetUnitX(udg_s__YoumuNew_w_caster[w], GetUnitX(udg_s__YoumuNew_w_u[w]) + 200 * Cos(udg_s__YoumuNew_w_a[w] + 0.2 * udg_s__YoumuNew_w_i[w]))
    call SetUnitY(udg_s__YoumuNew_w_caster[w], GetUnitY(udg_s__YoumuNew_w_u[w]) + 200 * Sin(udg_s__YoumuNew_w_a[w] + 0.2 * udg_s__YoumuNew_w_i[w]))
    call SetUnitFacing(udg_s__YoumuNew_w_caster[w], (udg_s__YoumuNew_w_a[w] + 0.2 * udg_s__YoumuNew_w_i[w]) / 3.14 * 180 + 90)
    set udg_YoumuNew_int = LoadInteger(udg_ht, GetHandleId(t), 1)
    call DebugMsg("udg_YoumuNew struct1:" + I2S(w))
    call ForGroup(udg_s__YoumuNew_w_g2[w], function s__YoumuNew_w_wSkill_Spell_Move)
    if udg_s__YoumuNew_w_i[w] < 30 then
        call SetUnitFlyHeight(udg_s__YoumuNew_w_u[w], GetUnitFlyHeight(udg_s__YoumuNew_w_u[w]) + udg_YoumuNew__YoumuNew01_FLYRATE * 0.02, 99999)
    else
        call SetUnitFlyHeight(udg_s__YoumuNew_w_u[w], GetUnitFlyHeight(udg_s__YoumuNew_w_u[w]) - udg_YoumuNew__YoumuNew01_FLYRATE * 0.02, 99999)
    endif
    if udg_s__YoumuNew_w_i[w] == 50 then
        call SetUnitAnimation(CreateUnit(GetOwningPlayer(udg_s__YoumuNew_w_caster[w]), 'e025', GetUnitX(udg_s__YoumuNew_w_u[w]), GetUnitY(udg_s__YoumuNew_w_u[w]), 0), "Birth")
    endif
    if udg_s__YoumuNew_w_i[w] / 10 * 10 == udg_s__YoumuNew_w_i[w] then
        if udg_SK_YoumuNewEx[udg_s__YoumuNew_w_p[w]] == 0 then
            call UnitPhysicalDamageTarget(udg_s__YoumuNew_w_caster[w], udg_s__YoumuNew_w_u[w], udg_s__YoumuNew_w_damage[w] * damage03 / 6)
        elseif udg_SK_YoumuNewEx[udg_s__YoumuNew_w_p[w]] == 1 then
            call UnitMagicDamageTarget(udg_s__YoumuNew_w_caster[w], udg_s__YoumuNew_w_u[w], udg_s__YoumuNew_w_damage[w] * damage03 / 6, 5)
        elseif udg_SK_YoumuNewEx[udg_s__YoumuNew_w_p[w]] == 2 then
            call UnitPhysicalDamageArea(udg_s__YoumuNew_w_caster[w], GetUnitX(udg_s__YoumuNew_w_u[w]), GetUnitY(udg_s__YoumuNew_w_u[w]), udg_YoumuNew__YoumuNew04_AOE, udg_s__YoumuNew_w_damage[w] * damage03 / 6)
            call UnitMagicDamageArea(udg_s__YoumuNew_w_caster[w], GetUnitX(udg_s__YoumuNew_w_u[w]), GetUnitY(udg_s__YoumuNew_w_u[w]), udg_YoumuNew__YoumuNew04_AOE, udg_s__YoumuNew_w_damage[w] * damage03 / 6, 5)
        endif
    endif
    if udg_s__YoumuNew_w_i[w] > 60 then
        call SetUnitX(udg_s__YoumuNew_w_caster[w], GetUnitX(udg_s__YoumuNew_w_u[w]))
        call SetUnitY(udg_s__YoumuNew_w_caster[w], GetUnitY(udg_s__YoumuNew_w_u[w]))
        if udg_SK_YoumuNewExLast[udg_s__YoumuNew_w_p[w]] == 0 then
            call CastSpell(udg_YoumuNew, "Roukanken")
            call AddUnitAnimationProperties(udg_s__YoumuNew_w_caster[w], "alternate", false)
            call AddUnitAnimationProperties(udg_s__YoumuNew_w_caster[w], "defend upgrade first", true)
        elseif udg_SK_YoumuNewExLast[udg_s__YoumuNew_w_p[w]] == 1 then
            call CastSpell(udg_s__YoumuNew_w_caster[w], "Hakurouken")
            call AddUnitAnimationProperties(udg_s__YoumuNew_w_caster[w], "alternate", false)
            call AddUnitAnimationProperties(udg_s__YoumuNew_w_caster[w], "upgrade first", true)
        endif
        set udg_SK_YoumuNewEx[udg_s__YoumuNew_w_p[w]] = udg_SK_YoumuNewExLast[udg_s__YoumuNew_w_p[w]]
        call PauseUnit(udg_s__YoumuNew_w_caster[w], false)
        call SetUnitInvulnerable(udg_s__YoumuNew_w_caster[w], false)
        call SetUnitVertexColor(udg_s__YoumuNew_w_caster[w], 255, 255, 255, 255)
        call AbilityCoolDownResetion(udg_s__YoumuNew_w_caster[w], udg_YoumuNew__YoumuNewEx2, 0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call DestroyGroup(udg_s__YoumuNew_w_g2[w])
        call s__YoumuNew_w_destroy(w)
    endif
endfunction

function s__YoumuNew_w_wSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local timer t1 = CreateTimer()
    local group g = CreateGroup()
    local unit sp = null
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__YoumuNew_w_i[w] = udg_s__YoumuNew_w_i[w] + 1
    call SetUnitX(udg_s__YoumuNew_w_caster[w], GetUnitX(udg_s__YoumuNew_w_caster[w]) + Cos(udg_s__YoumuNew_w_a[w]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    call SetUnitY(udg_s__YoumuNew_w_caster[w], GetUnitY(udg_s__YoumuNew_w_caster[w]) + Sin(udg_s__YoumuNew_w_a[w]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    if udg_s__YoumuNew_w_i[w] > 25 then
        call PauseUnit(udg_s__YoumuNew_w_caster[w], false)
        call SetUnitInvulnerable(udg_s__YoumuNew_w_caster[w], false)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call ReleaseTimer(t1)
        call DestroyGroup(g)
        call DestroyGroup(udg_s__YoumuNew_w_g2[w])
        call s__YoumuNew_w_destroy(w)
    else
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__YoumuNew_w_caster[w]), GetUnitY(udg_s__YoumuNew_w_caster[w]), 120, udg_s__YoumuNew_w_iff[w])
        set udg_s__YoumuNew_w_u[w] = FirstOfGroup(g)
        if udg_s__YoumuNew_w_u[w] != null and (not IsUnitType(udg_s__YoumuNew_w_u[w], UNIT_TYPE_STRUCTURE) and GetWidgetLife(udg_s__YoumuNew_w_u[w]) > 0.405) and IsUnitType(udg_s__YoumuNew_w_u[w], UNIT_TYPE_HERO) then
            call PauseUnit(udg_s__YoumuNew_w_caster[w], true)
            call SetUnitInvulnerable(udg_s__YoumuNew_w_caster[w], true)
            call SetUnitVertexColor(udg_s__YoumuNew_w_caster[w], 255, 255, 255, 100)
            call UnitStunTarget(udg_s__YoumuNew_w_caster[w], udg_s__YoumuNew_w_u[w], 1.5, 0, 0)
            call SaveInteger(udg_ht, GetHandleId(t1), 1, LoadInteger(udg_ht, GetHandleId(t), 0))
            call ReleaseTimer(t)
            set udg_s__YoumuNew_w_i[w] = 0
            set udg_s__YoumuNew_w_a[w] = Atan2(udg_s__YoumuNew_w_cy[w] - GetUnitY(udg_s__YoumuNew_w_u[w]), udg_s__YoumuNew_w_cx[w] - GetUnitX(udg_s__YoumuNew_w_u[w]))
            call UnitAddAbility(udg_s__YoumuNew_w_u[w], 'Arav')
            call UnitRemoveAbility(udg_s__YoumuNew_w_u[w], 'Arav')
            set udg_s__YoumuNew_w_n[w] = (1) - 1
            loop
                set udg_s__YoumuNew_w_n[w] = udg_s__YoumuNew_w_n[w] + 1
            exitwhen udg_s__YoumuNew_w_n[w] > (3)
                set sp = CreateUnit(GetOwningPlayer(udg_s__YoumuNew_w_caster[w]), 'n057', GetUnitX(udg_s__YoumuNew_w_u[w]) + 200 * Cos(udg_s__YoumuNew_w_a[w] + 1.57 * udg_s__YoumuNew_w_n[w]), GetUnitY(udg_s__YoumuNew_w_u[w]) + 200 * Sin(udg_s__YoumuNew_w_a[w] + 1.57 * udg_s__YoumuNew_w_n[w]), 0)
                call SetUnitVertexColor(sp, 255, 255, 255, 100)
                call GroupAddUnit(udg_s__YoumuNew_w_g2[w], sp)
                call PauseUnit(sp, true)
            endloop
            call TimerStart(t1, 0.02, true, function s__YoumuNew_w_wSkill_main)
        else
            call DestroyGroup((g))
            call ReleaseTimer(t1)
        endif
    endif
    set t = null
    set t1 = null
    set g = null
    set sp = null
endfunction

function YoumuNew__YoumuNewAttack_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A1D4') == 0 then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
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

function YoumuNew__YoumuNewAttack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer p = GetPlayerId(GetOwningPlayer(caster))
    local real damage03 = (udg_YoumuNew__YoumuNew03_DAMAGE_BASE + udg_YoumuNew__YoumuNew03_DAMAGE_INCREASE * (GetUnitAbilityLevel(caster, udg_YoumuNew__YoumuNew03) - 1)) / 100
    local unit sp = null
    if udg_SK_YoumuNewEx[p] == 1 then
        if IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, target, GetUnitAttack(caster), 5)
            call UnitPhysicalDamageTarget(caster, target, GetUnitAttack(caster) * 0)
        else
            call UnitMagicDamageTarget(caster, target, GetUnitAttack(caster) * 0.9, 5)
            call UnitPhysicalDamageTarget(caster, target, GetUnitAttack(caster) * 0)
        endif
    endif
    if udg_SK_YoumuNewEx[p] == 2 then
        if IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, target, GetUnitAttack(caster), 5)
        else
            call UnitMagicDamageTarget(caster, target, GetUnitAttack(caster) * 0.9, 5)
        endif
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) == false and GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(caster, udg_YoumuNew__YoumuNew03) - 1) then
        set sp = CreateUnit(GetOwningPlayer(caster), 'n057', GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
        call SetUnitAnimation(sp, "attack")
        if udg_SK_YoumuNewEx[p] == 0 then
            call UnitMagicDamageTarget(caster, target, GetUnitAttack(caster) * damage03, 5)
        elseif udg_SK_YoumuNewEx[p] == 1 then
            call UnitPhysicalDamageTarget(caster, target, GetUnitAttack(caster) * damage03)
        elseif udg_SK_YoumuNewEx[p] == 2 then
            call UnitMagicDamageTarget(caster, target, GetUnitAttack(caster) * damage03, 5)
            call UnitPhysicalDamageTarget(caster, target, GetUnitAttack(caster) * damage03)
        endif
    endif
    set caster = null
    set target = null
    set sp = null
endfunction

function YoumuNew_ReceiveSword takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer p = GetPlayerId(GetOwningPlayer(udg_YoumuNew))
    if udg_SK_YoumuNewEx[p] == 2 then
        if udg_SK_YoumuNewExLast[p] == 0 then
            call CastSpell(udg_YoumuNew, "Roukanken")
            call AddUnitAnimationProperties(udg_YoumuNew, "alternate", false)
            call AddUnitAnimationProperties(udg_YoumuNew, "defend upgrade first", true)
        elseif udg_SK_YoumuNewExLast[p] == 1 then
            call CastSpell(udg_YoumuNew, "Hakurouken")
            call AddUnitAnimationProperties(udg_YoumuNew, "alternate", false)
            call AddUnitAnimationProperties(udg_YoumuNew, "upgrade first", true)
        endif
        set udg_SK_YoumuNewEx[p] = udg_SK_YoumuNewExLast[p]
    endif
    call ReleaseTimer(t)
    set t = null
endfunction

function YoumuNew__Skill takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local unit u = null
    local unit sp
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(caster, id)
    local integer p = GetPlayerId(GetOwningPlayer(caster))
    local location loc = GetSpellTargetLoc()
    local real x = GetLocationX(loc)
    local real y = GetLocationY(loc)
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real ux
    local real uy
    local real damage
    local real damage03 = (udg_YoumuNew__YoumuNew03_DAMAGE_BASE + udg_YoumuNew__YoumuNew03_DAMAGE_INCREASE * (GetUnitAbilityLevel(caster, udg_YoumuNew__YoumuNew03) - 1)) / 100
    local timer t = null
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call DebugMsg("skill open")
    if id == udg_YoumuNew__YoumuNewEx then
        call AbilityCoolDownResetion(caster, id, udg_YoumuNew__YoumuNewEx_CD_BASE - (lvl - 1) * udg_YoumuNew__YoumuNewEx_CD_DECREASE)
        call AddUnitAnimationProperties(caster, "alternate", false)
        if udg_SK_YoumuNewEx[p] == 0 then
            set udg_SK_YoumuNewEx[p] = 1
            set udg_SK_YoumuNewExLast[p] = 1
            call AddUnitAnimationProperties(caster, "defend upgrade first", false)
            call AddUnitAnimationProperties(caster, "upgrade first", true)
            call CastSpell(caster, "Hakurouken")
        elseif udg_SK_YoumuNewEx[p] == 1 then
            set udg_SK_YoumuNewEx[p] = 0
            set udg_SK_YoumuNewExLast[p] = 0
            call AddUnitAnimationProperties(caster, "upgrade first", false)
            call AddUnitAnimationProperties(caster, "defend upgrade first", true)
            call CastSpell(caster, "Roukanken")
        endif
    elseif id == udg_YoumuNew__YoumuNewEx2 then
        call AbilityCoolDownResetion(caster, id, udg_YoumuNew__YoumuNewEx2_CD_BASE - (lvl - 1) * udg_YoumuNew__YoumuNewEx2_CD_DECREASE)
        call AddUnitAnimationProperties(caster, "defend upgrade first", false)
        call AddUnitAnimationProperties(caster, "upgrade first", false)
        call AddUnitAnimationProperties(caster, "alternate", true)
        set t = CreateTimer()
        call CastSpell(caster, "Dual Blades!")
        call TimerStart(t, 9, false, function YoumuNew_ReceiveSword)
        set udg_SK_YoumuNewEx[p] = 2
    elseif id == udg_YoumuNew__YoumuNew01 then
        call AbilityCoolDownResetion(caster, id, udg_YoumuNew__YoumuNew01_CD_BASE - (lvl - 1) * udg_YoumuNew__YoumuNew01_CD_DECREASE)
        set damage = (lvl - 1) * udg_YoumuNew__YoumuNew01_DAMAGE_INC + udg_YoumuNew__YoumuNew01_DAMAGE_BASE + GetUnitAttack(caster) * udg_YoumuNew__YoumuNew01_DAMAGE_SCALE
        call s__YoumuNew_d_create(caster, damage, p)
        call DebugMsg("01 skill open")
    elseif id == udg_YoumuNew__YoumuNew02 then
        call AbilityCoolDownResetion(caster, id, udg_YoumuNew__YoumuNew02_CD_BASE - (lvl - 1) * udg_YoumuNew__YoumuNew02_CD_DECREASE)
        set damage = (lvl - 1) * udg_YoumuNew__YoumuNew02_DAMAGE_INC + udg_YoumuNew__YoumuNew02_DAMAGE_BASE + GetUnitAttack(caster) * udg_YoumuNew__YoumuNew02_DAMAGE_SCALE
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), udg_YoumuNew__YoumuNew02_AOE, iff)
        loop
            set u = FirstOfGroup(g)
        exitwhen u == null
            if u != null then
                if not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetWidgetLife(u) > 0.405 then
                    set ux = GetUnitX(u)
                    set uy = GetUnitY(u)
                    if udg_SK_YoumuNewEx[p] == 2 then
                        call UnitStunArea(caster, udg_YoumuNew__YoumuNew02_STUNTIME_BASE + udg_YoumuNew__YoumuNew02_STUNTIME_INC * (lvl - 1), cx, cy, udg_YoumuNew__YoumuNew02_AOE, 0, 0)
                        call UnitPhysicalDamageArea(caster, cx, cy, udg_YoumuNew__YoumuNew02_AOE, damage * damage03)
                        call UnitMagicDamageArea(caster, cx, cy, udg_YoumuNew__YoumuNew02_AOE, damage * damage03, 5)
                        if udg_SK_YoumuNewExLast[p] == 0 then
                            call CastSpell(caster, "Roukanken")
                            call AddUnitAnimationProperties(caster, "alternate", false)
                            call AddUnitAnimationProperties(caster, "defend upgrade first", true)
                        elseif udg_SK_YoumuNewExLast[p] == 1 then
                            call CastSpell(caster, "Hakurouken")
                            call AddUnitAnimationProperties(caster, "alternate", false)
                            call AddUnitAnimationProperties(caster, "upgrade first", true)
                        endif
                        set udg_SK_YoumuNewEx[p] = udg_SK_YoumuNewExLast[p]
                        call AddTimedEffectToPoint(cx, cy, 1.0, " Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                        call GroupClear(g)
                    else
                        if (uy - cy) * Sin(GetUnitFacing(caster) / 180 * 3.14) + (ux - cx) * Cos(GetUnitFacing(caster) / 180 * 3.14) > 0 then
                            call UnitStunTarget(caster, u, udg_YoumuNew__YoumuNew02_STUNTIME_BASE + udg_YoumuNew__YoumuNew02_STUNTIME_INC * (lvl - 1), 0, 0)
                            if udg_SK_YoumuNewEx[p] == 0 then
                                call UnitPhysicalDamageTarget(caster, u, damage)
                                if GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(caster, udg_YoumuNew__YoumuNew03) - 1) then
                                    set sp = CreateUnit(GetOwningPlayer(caster), 'n057', cx, cy, GetUnitFacing(caster))
                                    call SetUnitAnimation(sp, "spell one alternate")
                                    call UnitMagicDamageTarget(caster, u, damage * damage03, 5)
                                endif
                            elseif udg_SK_YoumuNewEx[p] == 1 then
                                call UnitMagicDamageTarget(caster, u, damage, 5)
                                if GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(caster, udg_YoumuNew__YoumuNew03) - 1) then
                                    set sp = CreateUnit(GetOwningPlayer(caster), 'n057', cx, cy, GetUnitFacing(caster))
                                    call SetUnitAnimation(sp, "spell one alternate")
                                    call UnitPhysicalDamageTarget(caster, u, damage * damage03)
                                endif
                            endif
                        endif
                        call AddTimedEffectToPoint(ux, uy, 1.0, " Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
                        call GroupRemoveUnit(g, u)
                    endif
                endif
            endif
        endloop
        if udg_SK_YoumuNewEx[p] != 2 and false then
            call AddUnitAnimationProperties(caster, "defend upgrade first", false)
            call AddUnitAnimationProperties(caster, "upgrade first", false)
            call AddUnitAnimationProperties(caster, "alternate", true)
            set t = CreateTimer()
            call CastSpell(caster, "Dual Blades!")
            call TimerStart(t, 9, false, function YoumuNew_ReceiveSword)
            set udg_SK_YoumuNewEx[p] = 2
        endif
        call DebugMsg("02skill open")
    elseif id == udg_YoumuNew__YoumuNew04 then
        call AbilityCoolDownResetion(caster, id, udg_YoumuNew__YoumuNew04_CD_BASE - (lvl - 1) * udg_YoumuNew__YoumuNew04_CD_DECREASE)
        set damage = (lvl - 1) * udg_YoumuNew__YoumuNew04_DAMAGE_INC + udg_YoumuNew__YoumuNew04_DAMAGE_BASE + GetUnitAttack(caster) * udg_YoumuNew__YoumuNew04_DAMAGE_SCALE
        call s__YoumuNew_w_create(caster, x, y, damage, p)
        call DebugMsg("04 skill open")
    endif
    call RemoveLocation(loc)
    call DestroyGroup(g)
    set t = null
    set caster = null
    set loc = null
    set u = null
    set g = null
    set sp = null
    return false
endfunction

function YoumuNew_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function YoumuNew__Skill))
    call TriggerRegisterUnitEvent(t, udg_YoumuNew, EVENT_UNIT_SPELL_EFFECT)
    set t = CreateTrigger()
    call RegisterAnyUnitDamage(t)
    call TriggerAddCondition(t, Condition(function YoumuNew__YoumuNewAttack_Conditions))
    call TriggerAddAction(t, function YoumuNew__YoumuNewAttack_Actions)
    call SetHeroLifeIncreaseValue(udg_YoumuNew, 13)
    call SetHeroManaIncreaseValue(udg_YoumuNew, 8)
    call SetHeroManaBaseRegenValue(udg_YoumuNew, 0.7)
    set t = null
endfunction

function Trig_Initial_YoumuNew_Actions takes nothing returns nothing
    set udg_YoumuNew = GetCharacterHandle(udg_YoumuNew_CODE)
    call YoumuNew_Init()
endfunction

function InitTrig_Initial_YoumuNew takes nothing returns nothing
    set gg_trg_Initial_YoumuNew = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_YoumuNew, function Trig_Initial_YoumuNew_Actions)
endfunction