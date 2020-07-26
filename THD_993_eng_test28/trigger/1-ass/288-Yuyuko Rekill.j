function Trig_Yuyuko_Rekill_Invulnerability_Clear takes nothing returns nothing
endfunction

function Trig_Yuyuko_Rekill_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'B00B') > 0 then
        set u = null
        return false
    endif
    if GetUnitAbilityLevel(u, 'A0MM') == 0 then
        set u = null
        return false
    endif
    if udg_SK_uuzre_switch == 1 then
        set u = null
        return false
    endif
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        if GetEventDamage() > GetUnitState(u, UNIT_STATE_LIFE) - 5.0 then
            set udg_SK_uuzre_switch = 1
            call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
            call TSU_SetUnitInvulnerable(u, 0.02)
            call UnitAddAbility(u, 'A0MQ')
            call UnitAddAbility(u, 'A0MR')
            call UnitAddAbility(u, 'A0MS')
            set u = null
            return true
        endif
    endif
    if GetUnitAbilityLevel(u, 'B006') > 0 and GetWidgetLife(u) <= 5.0 then
        set udg_SK_uuzre_switch = 1
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
        call TSU_SetUnitInvulnerable(u, 0.02)
        call UnitAddAbility(u, 'A0MQ')
        call UnitAddAbility(u, 'A0MR')
        call UnitAddAbility(u, 'A0MS')
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Trig_Yuyuko_Rekill_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real ox = LoadReal(udg_ht, task, 2)
    local real oy = LoadReal(udg_ht, task, 3)
    local unit illusion = LoadUnitHandle(udg_ht, task, 4)
    local player ply = LoadPlayerHandle(udg_ht, task, 5)
    local unit u
    local integer j
    local real a
    local unit v
    local integer level = GetUnitAbilityLevel(caster, 'A0MM')
    set u = caster
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
    set u = CreateUnit(GetOwningPlayer(caster), 'n001', ox, oy, 0)
    set u = CreateUnit(GetOwningPlayer(caster), 'o000', ox, oy, 0.0)
    call SetUnitScale(u, 2.0, 2.0, 2.0)
    call UnitAddAbility(u, 'A05G' + GetRandomInt(0, 3))
    set j = 1
    loop
        set a = j * 12.0
        call IssuePointOrder(u, "carrionswarm", ox + 100 * CosBJ(a), oy + 100 * SinBJ(a))
        set j = j + 1
    exitwhen j > 30
    endloop
    call RemoveUnit(illusion)
    call SetUnitVertexColor(caster, 255, 255, 255, 255)
    call UnitRemoveAbility(caster, 'A0MQ')
    call UnitRemoveAbility(caster, 'A0MR')
    call SetUnitInvulnerable(caster, false)
    call UnitRemoveBuffs(caster, true, true)
    call SetUnitXY(caster, ox, oy)
    set v = CreateUnit(ply, 'n001', ox, oy, 0)
    call InstantKill(v, caster)
    if GetUnitState(caster, UNIT_STATE_LIFE) > 0 then
        call SetUnitLifePercentBJ(caster, 1.0)
        call KillUnit(caster)
    endif
    call UnitRemoveAbility(caster, 'A0MS')
    set udg_SK_uuzre_switch = 0
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set illusion = null
    set u = null
    set v = null
    set ply = null
endfunction

function Trig_Yuyuko_Rekill_Movement takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit illusion = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer v = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(illusion)
    local real oy = GetUnitY(illusion)
    local real kx = GetUnitX(caster)
    local real ky = GetUnitY(caster)
    local real d = SquareRoot((ox - kx) * (ox - kx) + (oy - ky) * (oy - ky))
    local real a = Atan2(ky - oy, kx - ox)
    if IsUnitType(caster, UNIT_TYPE_DEAD) or v >= 125 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        set v = v + 1
        call SetUnitVertexColor(caster, 255, 255, 255, 170 - v * 3 / 4)
        if d > 500 + 100 * level then
            call SetUnitXY(caster, ox + (100 + 100 * level - 10) * Cos(a), oy + (100 + 100 * level - 10) * Sin(a))
            call IssueImmediateOrder(caster, "stop")
        endif
        call SaveInteger(udg_ht, task, 3, v)
    endif
    set t = null
    set caster = null
    set illusion = null
endfunction

function Trig_Yuyuko_Rekill_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local timer t2 = CreateTimer()
    local integer task2 = GetHandleId(t2)
    local unit caster = GetTriggerUnit()
    local unit killer = GetEventDamageSource()
    local unit illusion
    local player ply = GetOwningPlayer(killer)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local unit u
    local integer j
    local real a
    local integer level = GetUnitAbilityLevel(caster, 'A0MM')
    set u = caster
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
    set u = CreateUnit(GetOwningPlayer(caster), 'o000', ox, oy, 0)
    call SetUnitScale(u, 2.0, 2.0, 2.0)
    call UnitAddAbility(u, 'A05G' + GetRandomInt(0, 3))
    set j = 1
    loop
        set a = j * 12.0
        call IssuePointOrder(u, "carrionswarm", ox + 100 * CosBJ(a), oy + 100 * SinBJ(a))
        set j = j + 1
    exitwhen j > 30
    endloop
    call CreateUnit(GetOwningPlayer(caster), 'n01J', GetUnitX(caster), GetUnitY(caster), 270.0)
    set illusion = CreateUnit(GetOwningPlayer(caster), 'n02N', ox, oy, 0)
    call UnitRemoveBuffs(caster, true, true)
    call SetUnitLifePercentBJ(caster, 100.0)
    call IssueImmediateOrder(caster, "stop")
    call SetUnitVertexColor(caster, 255, 255, 255, 170)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 2, ox)
    call SaveReal(udg_ht, task, 3, oy)
    call SaveUnitHandle(udg_ht, task, 4, illusion)
    call SavePlayerHandle(udg_ht, task, 5, ply)
    call TimerStart(t, 10.0, false, function Trig_Yuyuko_Rekill_Clear)
    call SaveUnitHandle(udg_ht, task2, 0, caster)
    call SaveUnitHandle(udg_ht, task2, 1, illusion)
    call SaveInteger(udg_ht, task2, 2, level)
    call SaveInteger(udg_ht, task2, 3, 0)
    call TimerStart(t2, 0.1, true, function Trig_Yuyuko_Rekill_Movement)
    if GetOwningPlayer(killer) == udg_SK_nue_rscd_player and udg_SK_nue_rscd_player != null then
        call NueResetCD(GetPlayerCharacter(GetOwningPlayer(killer)), caster)
    endif
    call AnnounceHeroBonus(killer, caster)
    set t = null
    set caster = null
    set killer = null
    set illusion = null
    set u = null
    set ply = null
endfunction

function InitTrig_Yuyuko_Rekill takes nothing returns nothing
endfunction