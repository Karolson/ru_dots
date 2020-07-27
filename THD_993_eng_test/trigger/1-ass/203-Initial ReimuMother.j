function s__ReimuMother_e_create takes unit caster returns integer
    local timer t = CreateTimer()
    local integer e = s__ReimuMother_e__allocate()
    set udg_s__ReimuMother_e_caster[e] = caster
    set udg_s__ReimuMother_e_cx[e] = GetUnitX(caster)
    set udg_s__ReimuMother_e_cy[e] = GetUnitY(caster)
    set udg_s__ReimuMother_e_a[e] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__ReimuMother_e_i[e] = 0
    call SaveInteger(udg_ht, GetHandleId(t), 0, e)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_e_eSkill_loop)
    set t = null
    return e
endfunction

function s__ReimuMother_e_destroy takes integer this returns nothing
    set udg_s__ReimuMother_e_caster[this] = null
    call s__ReimuMother_e_deallocate(this)
endfunction

function s__ReimuMother_e_eSkill_loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer e = LoadInteger(udg_ht, GetHandleId(t), 0)
    call SetUnitX(udg_s__ReimuMother_e_caster[e], GetUnitX(udg_s__ReimuMother_e_caster[e]) + Cos(udg_s__ReimuMother_e_a[e]) * udg_ReimuMother__ReimuMotherEx_SPEED * 0.02)
    call SetUnitY(udg_s__ReimuMother_e_caster[e], GetUnitY(udg_s__ReimuMother_e_caster[e]) + Sin(udg_s__ReimuMother_e_a[e]) * udg_ReimuMother__ReimuMotherEx_SPEED * 0.02)
    set udg_s__ReimuMother_e_i[e] = udg_s__ReimuMother_e_i[e] + 1
    if udg_s__ReimuMother_e_i[e] > 13 then
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_e_destroy(e)
    endif
    set t = null
endfunction

function s__ReimuMother_d_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer d = s__ReimuMother_d__allocate()
    set udg_s__ReimuMother_d_caster[d] = caster
    set udg_s__ReimuMother_d_damage[d] = damage
    set udg_s__ReimuMother_d_a[d] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__ReimuMother_d_cx[d] = GetUnitX(caster) + udg_ReimuMother__ReimuMotherAll_AOE * Cos(udg_s__ReimuMother_d_a[d])
    set udg_s__ReimuMother_d_cy[d] = GetUnitY(caster) + udg_ReimuMother__ReimuMotherAll_AOE * Sin(udg_s__ReimuMother_d_a[d])
    call SaveInteger(udg_ht, GetHandleId(t), 0, d)
    call TimerStart(t, 0.02, false, function sc__ReimuMother_d_dSkill_Action)
    set t = null
    return d
endfunction

function s__ReimuMother_d_destroy takes integer this returns nothing
    set udg_s__ReimuMother_d_caster[this] = null
    call s__ReimuMother_d_deallocate(this)
endfunction

function s__ReimuMother_d_dSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local group g = CreateGroup()
    local unit v
    local integer d = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_d_caster[d]))]
    call GroupEnumUnitsInRange(g, udg_s__ReimuMother_d_cx[d], udg_s__ReimuMother_d_cy[d], udg_ReimuMother__ReimuMotherAll_AOE, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
            call UnitPhysicalDamageTarget(udg_s__ReimuMother_d_caster[d], v, udg_s__ReimuMother_d_damage[d])
        endif
        call GroupRemoveUnit(g, v)
    endloop
    call UnitStunArea(udg_s__ReimuMother_d_caster[d], udg_ReimuMother__ReimuMotherAll_StunTime + (GetUnitAbilityLevel(udg_s__ReimuMother_d_caster[d], 'A1CC') - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC, udg_s__ReimuMother_d_cx[d], udg_s__ReimuMother_d_cy[d], udg_ReimuMother__ReimuMotherAll_AOE, 0, 0)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    call DestroyGroup(g)
    call s__ReimuMother_d_destroy(d)
    set t = null
endfunction

function s__ReimuMother_f_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer f = s__ReimuMother_f__allocate()
    set udg_s__ReimuMother_f_caster[f] = caster
    set udg_s__ReimuMother_f_damage[f] = damage
    set udg_s__ReimuMother_f_a[f] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__ReimuMother_f_cx[f] = GetUnitX(caster)
    set udg_s__ReimuMother_f_cy[f] = GetUnitY(caster)
    set udg_s__ReimuMother_f_i[f] = 0
    set udg_s__ReimuMother_f_g[f] = CreateGroup()
    call UnitPhysicalDamageArea(udg_s__ReimuMother_f_caster[f], udg_s__ReimuMother_f_cx[f], udg_s__ReimuMother_f_cy[f], udg_ReimuMother__ReimuMotherAll_AOE, udg_s__ReimuMother_f_damage[f])
    call UnitStunArea(udg_s__ReimuMother_f_caster[f], udg_ReimuMother__ReimuMotherAll_StunTime + (GetUnitAbilityLevel(udg_s__ReimuMother_f_caster[f], 'A1CC') - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC, udg_s__ReimuMother_f_cx[f], udg_s__ReimuMother_f_cy[f], udg_ReimuMother__ReimuMotherAll_AOE, 0, 0)
    call SaveInteger(udg_ht, GetHandleId(t), 0, f)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_f_fSkill_Action)
    set t = null
    return f
endfunction

function s__ReimuMother_f_destroy takes integer this returns nothing
    set udg_s__ReimuMother_f_caster[this] = null
    call s__ReimuMother_f_deallocate(this)
endfunction

function s__ReimuMother_f_fSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v
    local real vx
    local real vy
    local real a
    local integer f = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_f_caster[f]))]
    call GroupEnumUnitsInRange(udg_s__ReimuMother_f_g[f], udg_s__ReimuMother_f_cx[f], udg_s__ReimuMother_f_cy[f], udg_ReimuMother__ReimuMotherAll_AOE, iff)
    loop
        set v = FirstOfGroup(udg_s__ReimuMother_f_g[f])
    exitwhen v == null
        if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and IsUnitType(v, UNIT_TYPE_ANCIENT) == false and GetWidgetLife(v) > 0.405 then
            set vx = GetUnitX(v)
            set vy = GetUnitY(v)
            set a = Atan2(vy - udg_s__ReimuMother_f_cy[f], vx - udg_s__ReimuMother_f_cx[f])
            call SetUnitX(v, GetUnitX(v) + Cos(a) * udg_ReimuMother__ReimuMother02_SPEED * 0.02)
            call SetUnitY(v, GetUnitY(v) + Sin(a) * udg_ReimuMother__ReimuMother02_SPEED * 0.02)
        endif
        call GroupRemoveUnit(udg_s__ReimuMother_f_g[f], v)
    endloop
    set udg_s__ReimuMother_f_i[f] = udg_s__ReimuMother_f_i[f] + 1
    if udg_s__ReimuMother_f_i[f] > 25 then
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call DestroyGroup(udg_s__ReimuMother_f_g[f])
        call s__ReimuMother_f_destroy(f)
    endif
    set t = null
endfunction

function s__ReimuMother_r_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer r = s__ReimuMother_r__allocate()
    set udg_s__ReimuMother_r_caster[r] = caster
    set udg_s__ReimuMother_r_damage[r] = damage
    set udg_s__ReimuMother_r_cx[r] = GetUnitX(caster)
    set udg_s__ReimuMother_r_cy[r] = GetUnitY(caster)
    set udg_s__ReimuMother_r_a[r] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__ReimuMother_r_i[r] = 0
    call SaveInteger(udg_ht, GetHandleId(t), 0, r)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_r_rSkill_Action)
    set t = null
    return r
endfunction

function s__ReimuMother_r_destroy takes integer this returns nothing
    set udg_s__ReimuMother_r_caster[this] = null
    call s__ReimuMother_r_deallocate(this)
endfunction

function s__ReimuMother_r_rSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer r = LoadInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__ReimuMother_r_i[r] = udg_s__ReimuMother_r_i[r] + 1
    call SetUnitX(udg_s__ReimuMother_r_caster[r], GetUnitX(udg_s__ReimuMother_r_caster[r]) + Cos(udg_s__ReimuMother_r_a[r]) * udg_ReimuMother__ReimuMother03_SPEED * 0.02)
    call SetUnitY(udg_s__ReimuMother_r_caster[r], GetUnitY(udg_s__ReimuMother_r_caster[r]) + Sin(udg_s__ReimuMother_r_a[r]) * udg_ReimuMother__ReimuMother03_SPEED * 0.02)
    if udg_s__ReimuMother_r_i[r] > 25 then
        set udg_s__ReimuMother_r_cx[r] = GetUnitX(udg_s__ReimuMother_r_caster[r]) + udg_ReimuMother__ReimuMotherAll_AOE * Cos(udg_s__ReimuMother_r_a[r])
        set udg_s__ReimuMother_r_cy[r] = GetUnitY(udg_s__ReimuMother_r_caster[r]) + udg_ReimuMother__ReimuMotherAll_AOE * Sin(udg_s__ReimuMother_r_a[r])
        call UnitPhysicalDamageArea(udg_s__ReimuMother_r_caster[r], udg_s__ReimuMother_r_cx[r], udg_s__ReimuMother_r_cy[r], udg_ReimuMother__ReimuMotherAll_AOE, udg_s__ReimuMother_r_damage[r])
        call UnitStunArea(udg_s__ReimuMother_r_caster[r], udg_ReimuMother__ReimuMotherAll_StunTime + GetUnitAbilityLevel(udg_s__ReimuMother_r_caster[r], 'A1CC') * udg_ReimuMother__ReimuMotherAll_StunTime_INC, udg_s__ReimuMother_r_cx[r], udg_s__ReimuMother_r_cy[r], udg_ReimuMother__ReimuMotherAll_AOE, 0, 0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_r_destroy(r)
    endif
    set t = null
endfunction

function s__ReimuMother_w_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer w = s__ReimuMother_w__allocate()
    set udg_s__ReimuMother_w_caster[w] = caster
    set udg_s__ReimuMother_w_damage[w] = damage
    set udg_s__ReimuMother_w_a[w] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__ReimuMother_w_cx[w] = GetUnitX(caster) + udg_ReimuMother__ReimuMotherAll_AOE * Cos(udg_s__ReimuMother_w_a[w])
    set udg_s__ReimuMother_w_cy[w] = GetUnitY(caster) + udg_ReimuMother__ReimuMotherAll_AOE * Sin(udg_s__ReimuMother_w_a[w])
    set udg_s__ReimuMother_w_i[w] = 0
    set udg_s__ReimuMother_w_h[w] = GetUnitFlyHeight(caster)
    set udg_s__ReimuMother_w_g[w] = CreateGroup()
    call GroupEnumUnitsInRange(udg_s__ReimuMother_w_g[w], udg_s__ReimuMother_w_cx[w], udg_s__ReimuMother_w_cy[w], udg_ReimuMother__ReimuMotherAll_AOE, iff)
    call UnitPhysicalDamageArea(udg_s__ReimuMother_w_caster[w], udg_s__ReimuMother_w_cx[w], udg_s__ReimuMother_w_cy[w], udg_ReimuMother__ReimuMotherAll_AOE, udg_s__ReimuMother_w_damage[w])
    call UnitStunArea(udg_s__ReimuMother_w_caster[w], udg_ReimuMother__ReimuMotherAll_StunTime + (GetUnitAbilityLevel(udg_s__ReimuMother_w_caster[w], 'A1CC') - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC, udg_s__ReimuMother_w_cx[w], udg_s__ReimuMother_w_cy[w], udg_ReimuMother__ReimuMotherAll_AOE, 0, 0)
    call SaveInteger(udg_ht, GetHandleId(t), 0, w)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_w_wSkill_Action)
    set t = null
    return w
endfunction

function s__ReimuMother_w_destroy takes integer this returns nothing
    set udg_s__ReimuMother_w_caster[this] = null
    call DestroyGroup(udg_s__ReimuMother_w_g[this])
    call s__ReimuMother_w_deallocate(this)
endfunction

function s__ReimuMother_w_wSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v
    local real i
    local group g = CreateGroup()
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__ReimuMother_w_i[w] < 13 then
        set i = 1
    else
        set i = -1
    endif
    call GroupAddGroup(udg_s__ReimuMother_w_g[w], g)
    if udg_s__ReimuMother_w_i[w] <= 25 then
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                call UnitAddAbility(v, 'Arav')
                call UnitRemoveAbility(v, 'Arav')
                call SetUnitFlyHeight(v, GetUnitFlyHeight(v) + udg_ReimuMother__ReimuMother04_FLYRATE * 0.02 * i, 99999)
            endif
            call GroupRemoveUnit(g, v)
        endloop
        set udg_s__ReimuMother_w_i[w] = udg_s__ReimuMother_w_i[w] + 1
    else
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call SetUnitFlyHeight(v, udg_s__ReimuMother_w_h[w], 99999)
            call GroupRemoveUnit(g, v)
        endloop
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_w_destroy(w)
    endif
    call DestroyGroup(g)
    set t = null
endfunction

function s__ReimuMother_ULT01_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer u1 = s__ReimuMother_ULT01__allocate()
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SetUnitPathing(caster, false)
    set udg_s__ReimuMother_ULT01_caster[u1] = caster
    set udg_s__ReimuMother_ULT01_damage[u1] = damage
    set udg_s__ReimuMother_ULT01_a[u1] = GetUnitFacing(caster) / 180 * 3.14
    set udg_s__ReimuMother_ULT01_i[u1] = 0
    set udg_s__ReimuMother_ULT01_g[u1] = CreateGroup()
    call SaveInteger(udg_ht, GetHandleId(t), 0, u1)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_ULT01_ULT01_loop)
    set t = null
    return u1
endfunction

function s__ReimuMother_ULT01_destroy takes integer this returns nothing
    set udg_s__ReimuMother_ULT01_caster[this] = null
    call DestroyGroup(udg_s__ReimuMother_ULT01_g[this])
    call s__ReimuMother_ULT01_deallocate(this)
endfunction

function s__ReimuMother_ULT01_ULT01_loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v
    local group g = CreateGroup()
    local integer u1 = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_ULT01_caster[u1]))]
    set udg_s__ReimuMother_ULT01_i[u1] = udg_s__ReimuMother_ULT01_i[u1] + 1
    if udg_s__ReimuMother_ULT01_i[u1] <= 25 then
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), udg_ReimuMother__ReimuMother_ULT01_WIDTH, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                call GroupAddUnit(udg_s__ReimuMother_ULT01_g[u1], v)
            endif
        endloop
        call AddTimedEffectToPoint(GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), 0.02, "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
        call SetUnitX(udg_s__ReimuMother_ULT01_caster[u1], GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]) + Cos(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
        call SetUnitY(udg_s__ReimuMother_ULT01_caster[u1], GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]) + Sin(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
    elseif udg_s__ReimuMother_ULT01_i[u1] <= 50 then
        call SetUnitFacing(udg_s__ReimuMother_ULT01_caster[u1], udg_s__ReimuMother_ULT01_a[u1] * 180 / 3.14 + 180)
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), udg_ReimuMother__ReimuMother_ULT01_WIDTH, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                call GroupAddUnit(udg_s__ReimuMother_ULT01_g[u1], v)
            endif
        endloop
        call AddTimedEffectToPoint(GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), 0.02, "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
        call SetUnitX(udg_s__ReimuMother_ULT01_caster[u1], GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]) - Cos(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
        call SetUnitY(udg_s__ReimuMother_ULT01_caster[u1], GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]) - Sin(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
    else
        loop
            set v = FirstOfGroup(udg_s__ReimuMother_ULT01_g[u1])
        exitwhen v == null
            call UnitPhysicalDamageTarget(udg_s__ReimuMother_ULT01_caster[u1], v, udg_s__ReimuMother_ULT01_damage[u1])
            call GroupRemoveUnit(udg_s__ReimuMother_ULT01_g[u1], v)
        endloop
        call PauseUnit(udg_s__ReimuMother_ULT01_caster[u1], false)
        call SetUnitInvulnerable(udg_s__ReimuMother_ULT01_caster[u1], false)
        call SetUnitPathing(udg_s__ReimuMother_ULT01_caster[u1], true)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT01_destroy(u1)
    endif
    call DestroyGroup(g)
    set t = null
endfunction

function s__ReimuMother_ULT02_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer i = 5
    local integer m = s__ReimuMother_ULT02__allocate()
    set udg_s__ReimuMother_ULT02_caster[m] = caster
    set udg_s__ReimuMother_ULT02_damage[m] = damage
    set udg_s__ReimuMother_ULT02_a[m] = (GetUnitFacing(caster) - 30) / 180 * 3.14
    set udg_s__ReimuMother_ULT02_cx[m] = GetUnitX(udg_s__ReimuMother_ULT02_caster[m])
    set udg_s__ReimuMother_ULT02_cy[m] = GetUnitY(udg_s__ReimuMother_ULT02_caster[m])
    set udg_s__ReimuMother_ULT02_n[m] = 0
    set udg_s__ReimuMother_ULT02_g[m] = CreateGroup()
    loop
    exitwhen i == 0
        set udg_s__ReimuMother_ULT02_u[m] = CreateUnit(GetOwningPlayer(caster), udg_ReimuMother__ReiMotherULT02_SHOT, udg_s__ReimuMother_ULT02_cx[m] + Cos(udg_s__ReimuMother_ULT02_a[m]) * 80, udg_s__ReimuMother_ULT02_cy[m] + Sin(udg_s__ReimuMother_ULT02_a[m]) * 80, udg_s__ReimuMother_ULT02_a[m] * 180 / 3.14)
        call GroupAddUnit(udg_s__ReimuMother_ULT02_g[m], udg_s__ReimuMother_ULT02_u[m])
        set i = i - 1
        set udg_s__ReimuMother_ULT02_a[m] = udg_s__ReimuMother_ULT02_a[m] + 0.2617
    endloop
    call SaveInteger(udg_ht, GetHandleId(t), 0, m)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_ULT02_startloop)
    set t = null
    return m
endfunction

function s__ReimuMother_ULT02_destroy takes integer this returns nothing
    set udg_s__ReimuMother_ULT02_caster[this] = null
    set udg_s__ReimuMother_ULT02_u[this] = null
    call DestroyGroup(udg_s__ReimuMother_ULT02_g[this])
    call s__ReimuMother_ULT02_deallocate(this)
endfunction

function s__ReimuMother_ULT02_startloop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u
    local unit v
    local real a
    local group g2 = CreateGroup()
    local group g3 = CreateGroup()
    local integer m = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_ULT02_caster[m]))]
    if udg_s__ReimuMother_ULT02_n[m] <= 25 then
        loop
            set u = FirstOfGroup(udg_s__ReimuMother_ULT02_g[m])
            set a = GetUnitFacing(u) / 180 * 3.14
        exitwhen u == null
            call SetUnitX(u, GetUnitX(u) + Cos(a) * udg_ReimuMother__ReimuMother_ULT02_SPEED * 0.02)
            call SetUnitY(u, GetUnitY(u) + Sin(a) * udg_ReimuMother__ReimuMother_ULT02_SPEED * 0.02)
            call GroupEnumUnitsInRange(g2, GetUnitX(u), GetUnitY(u), 100, iff)
            loop
                set v = FirstOfGroup(g2)
            exitwhen v == null
                if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                    call UnitMagicDamageTarget(udg_s__ReimuMother_ULT02_caster[m], v, udg_s__ReimuMother_ULT02_damage[m], 5)
                    call KillUnit(u)
                endif
                call GroupRemoveUnit(g2, v)
            endloop
            if GetWidgetLife(u) > 0.405 then
                call GroupAddUnit(g3, u)
            endif
            call GroupRemoveUnit(udg_s__ReimuMother_ULT02_g[m], u)
        endloop
        loop
            set u = FirstOfGroup(g3)
        exitwhen u == null
            call GroupRemoveUnit(g3, u)
            call GroupAddUnit(udg_s__ReimuMother_ULT02_g[m], u)
        endloop
    else
        loop
            set u = FirstOfGroup(udg_s__ReimuMother_ULT02_g[m])
        exitwhen u == null
            call GroupRemoveUnit(udg_s__ReimuMother_ULT02_g[m], u)
            call KillUnit(u)
        endloop
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT02_destroy(m)
    endif
    set udg_s__ReimuMother_ULT02_n[m] = udg_s__ReimuMother_ULT02_n[m] + 1
    call DestroyGroup(g2)
    call DestroyGroup(g3)
    set u = null
    set t = null
endfunction

function s__ReimuMother_ULT03_create takes unit caster returns integer
    local timer t = CreateTimer()
    local unit v
    local group g = CreateGroup()
    local integer u3 = s__ReimuMother_ULT03__allocate()
    set udg_s__ReimuMother_ULT03_caster[u3] = caster
    set udg_s__ReimuMother_ULT03_i[u3] = 0
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), udg_ReimuMother__ReimuMotherULT03_AOE, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call DestroyLightning(AddLightningEx("HWPB", true, GetUnitX(caster), GetUnitY(caster), 100, GetUnitX(v), GetUnitY(v), 100))
        set udg_s__ReimuMother_ULT03_i[u3] = udg_s__ReimuMother_ULT03_i[u3] + 1
        call GroupRemoveUnit(g, v)
    endloop
    call AddTimedEffectToUnit(caster, udg_ReimuMother__ReimuMotherULT03_TIME, "Abilities\\Spells\\Orc\\Voodoo\\VoodooAura.mdl", "origin")
    call UnitAddBonusDmg(udg_s__ReimuMother_ULT03_caster[u3], R2I(udg_s__ReimuMother_ULT03_i[u3] * udg_ReimuMother__ReimuMother_ULT03_DAMAGESCALE))
    call SaveInteger(udg_ht, GetHandleId(t), 0, u3)
    call TimerStart(t, udg_ReimuMother__ReimuMotherULT03_TIME, false, function sc__ReimuMother_ULT03_Clear)
    set t = null
    call DestroyGroup(g)
    return u3
endfunction

function s__ReimuMother_ULT03_destroy takes integer this returns nothing
    set udg_s__ReimuMother_ULT03_caster[this] = null
    call s__ReimuMother_ULT03_deallocate(this)
endfunction

function s__ReimuMother_ULT03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer u3 = LoadInteger(udg_ht, GetHandleId(t), 0)
    call UnitAddBonusDmg(udg_s__ReimuMother_ULT03_caster[u3], -R2I(udg_s__ReimuMother_ULT03_i[u3] * udg_ReimuMother__ReimuMother_ULT03_DAMAGESCALE))
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    call s__ReimuMother_ULT03_destroy(u3)
    set t = null
endfunction

function s__ReimuMother_ULT04_Healing takes unit caster, real damage returns nothing
    local unit v
    local group g = CreateGroup()
    call CreateUnit(GetOwningPlayer(caster), 'e03U', GetUnitX(caster), GetUnitY(caster), 0)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), udg_ReimuMother__ReimuMotherULT03_AOE, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        if IsUnitAlly(v, GetOwningPlayer(caster)) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
            call UnitHealingTarget(caster, v, damage)
        endif
        call GroupRemoveUnit(g, v)
    endloop
    call DestroyGroup(g)
endfunction

function s__ReimuMother_ULT05_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer w = s__ReimuMother_ULT05__allocate()
    set udg_s__ReimuMother_ULT05_caster[w] = caster
    set udg_s__ReimuMother_ULT05_damage[w] = damage
    set udg_s__ReimuMother_ULT05_cx[w] = GetUnitX(caster)
    set udg_s__ReimuMother_ULT05_cy[w] = GetUnitY(caster)
    set udg_s__ReimuMother_ULT05_i[w] = 0
    set udg_s__ReimuMother_ULT05_h[w] = GetUnitFlyHeight(caster)
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SetUnitPathing(caster, false)
    call SaveInteger(udg_ht, GetHandleId(t), 0, w)
    call TimerStart(t, 0.02, true, function sc__ReimuMother_ULT05_ULT05_Action)
    set t = null
    return w
endfunction

function s__ReimuMother_ULT05_destroy takes integer this returns nothing
    set udg_s__ReimuMother_ULT05_caster[this] = null
    call s__ReimuMother_ULT05_deallocate(this)
endfunction

function s__ReimuMother_ULT05_ULT05_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local real i
    local group g
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__ReimuMother_ULT05_i[w] < 25 then
        set i = 1
    else
        set i = -1
    endif
    if udg_s__ReimuMother_ULT05_i[w] <= 50 then
        call UnitAddAbility(udg_s__ReimuMother_ULT05_caster[w], 'Arav')
        call UnitRemoveAbility(udg_s__ReimuMother_ULT05_caster[w], 'Arav')
        call SetUnitFlyHeight(udg_s__ReimuMother_ULT05_caster[w], GetUnitFlyHeight(udg_s__ReimuMother_ULT05_caster[w]) + udg_ReimuMother__ReimuMotherULT05_FLYRATE * 0.02 * i, 99999)
        set udg_s__ReimuMother_ULT05_i[w] = udg_s__ReimuMother_ULT05_i[w] + 1
    else
        call SetUnitFlyHeight(udg_s__ReimuMother_ULT05_caster[w], udg_s__ReimuMother_ULT05_h[w], 99999)
        call PauseUnit(udg_s__ReimuMother_ULT05_caster[w], false)
        call SetUnitInvulnerable(udg_s__ReimuMother_ULT05_caster[w], false)
        call SetUnitPathing(udg_s__ReimuMother_ULT05_caster[w], true)
        call CreateUnit(GetOwningPlayer(udg_s__ReimuMother_ULT05_caster[w]), 'e03T', GetUnitX(udg_s__ReimuMother_ULT05_caster[w]), GetUnitY(udg_s__ReimuMother_ULT05_caster[w]), 0)
        call UnitMagicDamageArea(udg_s__ReimuMother_ULT05_caster[w], udg_s__ReimuMother_ULT05_cx[w], udg_s__ReimuMother_ULT05_cy[w], udg_ReimuMother__ReimuMotherULT05_AOE, udg_s__ReimuMother_ULT05_damage[w], 5)
        call UnitStunArea(udg_s__ReimuMother_ULT05_caster[w], udg_ReimuMother__ReimuMotherAll_StunTime + (GetUnitAbilityLevel(udg_s__ReimuMother_ULT05_caster[w], 'A1CC') - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC * 2, udg_s__ReimuMother_ULT05_cx[w], udg_s__ReimuMother_ULT05_cy[w], udg_ReimuMother__ReimuMotherULT05_AOE, 0, 0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT05_destroy(w)
    endif
    call DestroyGroup(g)
    set t = null
endfunction

function s__ReimuMother_ULT06_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer d = s__ReimuMother_ULT06__allocate()
    set udg_s__ReimuMother_ULT06_caster[d] = caster
    set udg_s__ReimuMother_ULT06_damage[d] = damage
    set udg_s__ReimuMother_ULT06_cx[d] = GetUnitX(caster)
    set udg_s__ReimuMother_ULT06_cy[d] = GetUnitY(caster)
    set udg_s__ReimuMother_ULT06_i[d] = 0
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SetUnitVertexColor(caster, 255, 255, 255, 120)
    call SaveInteger(udg_ht, GetHandleId(t), 0, d)
    call TimerStart(t, 0.5, true, function sc__ReimuMother_ULT06_dSkill_Action)
    set t = null
    return d
endfunction

function s__ReimuMother_ULT06_destroy takes integer this returns nothing
    set udg_s__ReimuMother_ULT06_caster[this] = null
    call s__ReimuMother_ULT06_deallocate(this)
endfunction

function s__ReimuMother_ULT06_dSkill_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local group g = CreateGroup()
    local unit v
    local unit v1 = null
    local real a = GetRandomReal(-3.14, 3.14)
    local real dis = 600
    local integer d = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_ULT06_caster[d]))]
    call GroupEnumUnitsInRange(g, udg_s__ReimuMother_ULT06_cx[d], udg_s__ReimuMother_ULT06_cy[d], 500, iff)
    call DebugMsg("06 Group on")
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            set v1 = v
        endif
        call GroupRemoveUnit(g, v)
    endloop
    if udg_s__ReimuMother_ULT06_i[d] < udg_ReimuMother__ReimuMotherULT06_COUNT and v1 != null then
        set udg_s__ReimuMother_ULT06_i[d] = udg_s__ReimuMother_ULT06_i[d] + 1
        call SetUnitX(udg_s__ReimuMother_ULT06_caster[d], GetUnitX(v1) + Cos(a) * 300)
        call SetUnitY(udg_s__ReimuMother_ULT06_caster[d], GetUnitY(v1) + Sin(a) * 300)
        call SetUnitFacing(udg_s__ReimuMother_ULT06_caster[d], a * 180 / 3.14)
        call SetUnitAnimation(udg_s__ReimuMother_ULT06_caster[d], "attack")
        loop
        exitwhen dis < 60
            call AddTimedEffectToPoint(GetUnitX(udg_s__ReimuMother_ULT06_caster[d]) - dis * Cos(a), GetUnitY(udg_s__ReimuMother_ULT06_caster[d]) - dis * Sin(a), 1, "ball_red.mdx")
            set dis = dis - 60
        endloop
        call UnitPhysicalDamageTarget(udg_s__ReimuMother_ULT06_caster[d], v1, udg_s__ReimuMother_ULT06_damage[d])
    else
        call PauseUnit(udg_s__ReimuMother_ULT06_caster[d], false)
        call SetUnitInvulnerable(udg_s__ReimuMother_ULT06_caster[d], false)
        call SetUnitVertexColor(udg_s__ReimuMother_ULT06_caster[d], 255, 255, 255, 255)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT06_destroy(d)
    endif
    call DestroyGroup(g)
    set t = null
    set v = null
    set v1 = null
endfunction

function ReimuMother__skilltimeloop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    set udg_skilltime = udg_skilltime - 0.02
    if udg_skilltime <= 0 then
        if GetHeroLevel(udg_ReimuMother) >= 6 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT01, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT02, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT03, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT04, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT05, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT06, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, true)
        endif
        set udg_skillname = null
        call ReleaseTimer(t)
    endif
    set t = null
endfunction

function ReimuMother__Skill takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local integer id = GetSpellAbilityId()
    local integer dmglvl = GetUnitAbilityLevel(caster, 'A1CB')
    local integer cdlvl = GetUnitAbilityLevel(caster, 'A1CD') + 1
    local integer stunlvl = GetUnitAbilityLevel(caster, 'A1CC')
    local timer t = CreateTimer()
    local real damage
    local integer exlvl = GetUnitAbilityLevel(caster, 'A1G1') + 1
    call DebugMsg("skill open")
    call UnitBuffTarget(caster, caster, 3, 'A1G1', 0)
    call SetUnitAbilityLevel(caster, 'A1G1', exlvl)
    if id == udg_ReimuMother__ReimuMotherEx then
//        call AbilityCoolDownResetion(caster, id, udg_ReimuMother__ReimuMotherAll_CD_BASE - (cdlvl - 1) * udg_ReimuMother__ReimuMotherAll_CD_DECREASE)
        call s__ReimuMother_e_create(caster)
        call DebugMsg("Ex skill open")
    elseif id == udg_ReimuMother__ReimuMother01 then
        call AbilityCoolDownResetion(caster, id, udg_ReimuMother__ReimuMotherAll_CD_BASE - (cdlvl - 1) * udg_ReimuMother__ReimuMotherAll_CD_DECREASE)
        set damage = udg_ReimuMother__ReimuMotherAll_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReimuMother__ReimuMotherAll_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherAll_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_d_create(caster, damage)
        set udg_skillname = udg_skillname + "d"
        call DebugMsg(udg_skillname)
        call DebugMsg("01 skill open")
    elseif id == udg_ReimuMother__ReimuMother02 then
        call AbilityCoolDownResetion(caster, id, udg_ReimuMother__ReimuMotherAll_CD_BASE - (cdlvl - 1) * udg_ReimuMother__ReimuMotherAll_CD_DECREASE)
        set damage = udg_ReimuMother__ReimuMotherAll_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReimuMother__ReimuMotherAll_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherAll_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_f_create(caster, damage)
        set udg_skillname = udg_skillname + "f"
        call DebugMsg(udg_skillname)
        call DebugMsg("02 skill open")
    elseif id == udg_ReimuMother__ReimuMother03 then
        call AbilityCoolDownResetion(caster, id, udg_ReimuMother__ReimuMotherAll_CD_BASE - (cdlvl - 1) * udg_ReimuMother__ReimuMotherAll_CD_DECREASE)
        set damage = udg_ReimuMother__ReimuMotherAll_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReimuMother__ReimuMotherAll_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherAll_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_r_create(caster, damage)
        set udg_skillname = udg_skillname + "r"
        call DebugMsg(udg_skillname)
        call DebugMsg("03 skill open")
    elseif id == udg_ReimuMother__ReimuMother04 then
        call AbilityCoolDownResetion(caster, id, udg_ReimuMother__ReimuMotherAll_CD_BASE - (cdlvl - 1) * udg_ReimuMother__ReimuMotherAll_CD_DECREASE)
        set damage = udg_ReimuMother__ReimuMotherAll_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReimuMother__ReimuMotherAll_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherAll_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_w_create(caster, damage)
        set udg_skillname = udg_skillname + "w"
        call DebugMsg(udg_skillname)
        call DebugMsg("04 skill open")
    elseif id == udg_ReimuMother__ReimuMotherULT01 then
        set damage = udg_ReimuMother__ReimuMotherULT01_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReimuMother__ReimuMotherULT01_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherULT01_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_ULT01_create(caster, damage)
        call CastSpell(caster, "Fantasy Seal: 'Blink'!")
        call DebugMsg("ULT01")
    elseif id == udg_ReimuMother__ReimuMotherULT02 then
        set damage = udg_ReimuMother__ReimuMotherULT02_DAMAGE_BASE + GetHeroInt(caster, true) * udg_ReimuMother__ReimuMotherULT02_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherULT02_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_ULT02_create(caster, damage)
        call CastSpell(caster, "Magic Seal: 'Dream Seal Scatter'!")
        call DebugMsg("ULT02")
    elseif id == udg_ReimuMother__ReimuMotherULT03 then
        call s__ReimuMother_ULT03_create(caster)
        call CastSpell(caster, "Fantasy Seal: 'Concentration'!")
        call DebugMsg("ULT03")
    elseif id == udg_ReimuMother__ReimuMotherULT04 then
        set damage = udg_ReimuMother__ReimuMotherULT04_DAMAGE_BASE + GetHeroInt(caster, true) * udg_ReimuMother__ReimuMotherULT04_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherULT04_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_ULT04_Healing(caster, damage)
        call CastSpell(caster, "Fantasy Seal: 'Light in the Darkness'!")
        call DebugMsg("ULT04")
    elseif id == udg_ReimuMother__ReimuMotherULT05 then
        set damage = udg_ReimuMother__ReimuMotherULT05_DAMAGE_BASE + GetHeroInt(caster, true) * udg_ReimuMother__ReimuMotherULT05_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherULT05_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_ULT05_create(caster, damage)
        call CastSpell(caster, "Fantasy Seal!")
        call DebugMsg("ULT05")
    elseif id == udg_ReimuMother__ReimuMotherULT06 then
        set damage = udg_ReimuMother__ReimuMotherULT06_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReimuMother__ReimuMotherULT06_DAMAGE_SCALE + udg_ReimuMother__ReimuMotherULT06_DAMAGE_INC * (dmglvl - 1)
        call s__ReimuMother_ULT06_create(caster, damage)
        call CastSpell(caster, "Born of a Miracle!")
        call DebugMsg("ULT06")
    endif
    if GetHeroLevel(caster) >= 6 and id == udg_ReimuMother__ReimuMother01 or id == udg_ReimuMother__ReimuMother02 or id == udg_ReimuMother__ReimuMother03 or id == udg_ReimuMother__ReimuMother04 then
        if udg_skillname == "rdw" then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT01, true)
            if GetUnitAbilityLevel(udg_ReimuMother, udg_ReimuMother__ReimuMotherULT01) == 0 then
                call UnitAddAbility(caster, udg_ReimuMother__ReimuMotherULT01)
            endif
        elseif udg_skillname == "dwf" then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT02, true)
            if GetUnitAbilityLevel(udg_ReimuMother, udg_ReimuMother__ReimuMotherULT02) == 0 then
                call UnitAddAbility(caster, udg_ReimuMother__ReimuMotherULT02)
            endif
        elseif udg_skillname == "frw" then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT03, true)
            if GetUnitAbilityLevel(udg_ReimuMother, udg_ReimuMother__ReimuMotherULT03) == 0 then
                call UnitAddAbility(caster, udg_ReimuMother__ReimuMotherULT03)
            endif
        elseif udg_skillname == "drf" then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT04, true)
            if GetUnitAbilityLevel(udg_ReimuMother, udg_ReimuMother__ReimuMotherULT04) == 0 then
                call UnitAddAbility(caster, udg_ReimuMother__ReimuMotherULT04)
            endif
        elseif udg_skillname == "wdfr" then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT05, true)
            if GetUnitAbilityLevel(udg_ReimuMother, udg_ReimuMother__ReimuMotherULT05) == 0 then
                call UnitAddAbility(caster, udg_ReimuMother__ReimuMotherULT05)
            endif
        elseif udg_skillname == "dfrw" then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherEx2, false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_ReimuMother), udg_ReimuMother__ReimuMotherULT06, true)
            if GetUnitAbilityLevel(udg_ReimuMother, udg_ReimuMother__ReimuMotherULT06) == 0 then
                call UnitAddAbility(caster, udg_ReimuMother__ReimuMotherULT06)
            endif
        endif
    endif
    set udg_skilltime = udg_skilltime + (udg_ReimuMother__ReimuMotherAll_StunTime + (stunlvl - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC) * 3
    if udg_skilltime <= 0 then
        call ReleaseTimer(t)
    else
        call TimerStart(t, 0.02, true, function ReimuMother__skilltimeloop)
    endif
    set caster = null
    set t = null
    return false
endfunction

function ReimuMother_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function ReimuMother__Skill))
    call TriggerRegisterUnitEvent(t, udg_ReimuMother, EVENT_UNIT_SPELL_EFFECT)
    call SetHeroLifeIncreaseValue(udg_ReimuMother, 6)
    call SetHeroManaIncreaseValue(udg_ReimuMother, 6)
    call SetHeroManaBaseRegenValue(udg_ReimuMother, 0.4)
    call RecHeroBasicArmorValue(udg_ReimuMother, 0.0)
    call RecHeroIncreArmorValue(udg_ReimuMother, 0.0)
    call RecHeroAttackBaseValue(udg_ReimuMother, 26)
    call RecHeroAttackUppeValue(udg_ReimuMother, 36)
    call RecHeroStaterTypeValue(udg_ReimuMother, 3)
    set t = null
endfunction

function Trig_Initial_ReimuMother_Actions takes nothing returns nothing
    set udg_ReimuMother = GetCharacterHandle(udg_ReimuMother_CODE)
    call ReimuMother_Init()
    call UnitAddAbility(udg_ReimuMother, 'A1C0')
    call UnitAddAbility(udg_ReimuMother, 'A1C2')
    call UnitAddAbility(udg_ReimuMother, 'A1C3')
    call UnitAddAbility(udg_ReimuMother, 'A1C4')
//    call UnitAddAbility(udg_ReimuMother, 'A1G2')
    call DebugMsg("ReimuMoher skill open")
endfunction

function InitTrig_Initial_ReimuMother takes nothing returns nothing
    set gg_trg_Initial_ReimuMother = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_ReimuMother, function Trig_Initial_ReimuMother_Actions)
endfunction