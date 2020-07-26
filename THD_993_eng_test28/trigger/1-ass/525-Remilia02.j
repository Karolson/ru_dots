function Trig_Remilia02_Conditions takes nothing returns boolean
    local boolean k
    local integer uid
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        return GetSpellAbilityId() == 'A0CG'
    else
        set k = false
        set uid = GetUnitTypeId(GetTriggerUnit())
        if uid == 'u00F' then
            set k = true
        elseif uid == 'u00G' then
            set k = true
        elseif uid == 'u00H' then
            set k = true
        elseif uid == 'u00I' then
            set k = true
        endif
        if k then
            set udg_SK_Remilia02_Diex[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = GetUnitX(GetTriggerUnit())
            set udg_SK_Remilia02_Diey[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = GetUnitY(GetTriggerUnit())
            call DestroyEffect(AddSpecialEffect("BatAppear.mdx", GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())))
            set udg_SK_Remilia02_Killer[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = GetOwningPlayer(GetKillingUnit())
            call RemoveUnit(GetTriggerUnit())
        endif
        return false
    endif
    return false
endfunction

function Trig_Remilia02_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit array u
    local unit birth
    local boolean array v
    local integer i
    local integer j
    local integer death
    local real life1
    local real life2
    local integer count = LoadInteger(udg_ht, task, 15)
    local integer time = LoadInteger(udg_ht, task, 16)
    local unit killer
    local boolean camswitch = LoadBoolean(udg_ht, task, 0)
    call SaveInteger(udg_ht, task, 15, count + 1)
    call SaveInteger(udg_ht, task, 16, time - 1)
    set i = 7
    loop
    exitwhen i == 0
        set u[i] = LoadUnitHandle(udg_ht, task, i)
        set v[i] = LoadBoolean(udg_ht, task, i + 7)
        set i = i - 1
    endloop
    if count == 2 then
        if GetUnitAbilityLevel(caster, 'B02O') > 0 then
            call IssueImmediateOrder(caster, "unimmolation")
            call UnitRemoveAbility(caster, 'B02O')
        endif
        call IssueImmediateOrder(caster, "stop")
        call PauseUnit(caster, true)
    endif
    if count >= 5 and count <= 11 then
        set j = count - 4
        call DestroyEffect(AddSpecialEffect("Bat-2.mdx", GetUnitX(u[i]), GetUnitY(u[i])))
    endif
    if count >= 10 and count <= 16 then
        set j = count - 9
        call ShowUnit(u[j], true)
        call SetUnitInvulnerable(u[j], false)
        if GetLocalPlayer() == GetOwningPlayer(caster) then
            call SelectUnit(u[j], true)
        endif
        call IssueImmediateOrder(u[j], "windwalk")
        call DestroyEffect(AddSpecialEffect("BatAppear.mdx", GetUnitX(u[j]), GetUnitY(u[j])))
    endif
    set death = 7
    set i = 7
    loop
    exitwhen i == 0
        if IsUnitType(u[i], UNIT_TYPE_DEAD) or u[i] == null then
            set death = death - 1
            call SaveBoolean(udg_ht, task, i + 7, false)
        endif
        set i = i - 1
    endloop
    if death == 0 then
        set birth = u[7]
        set i = 7
        loop
        exitwhen i == 0
            if v[i] then
                set birth = u[i]
            endif
            set i = i - 1
        endloop
        call SetUnitState(caster, UNIT_STATE_LIFE, 5)
        call SetUnitPosition(caster, udg_SK_Remilia02_Diex[GetConvertedPlayerId(GetOwningPlayer(caster))], udg_SK_Remilia02_Diey[GetConvertedPlayerId(GetOwningPlayer(caster))])
        call PauseUnit(caster, false)
        call SetUnitInvulnerable(caster, false)
        if udg_SK_Remilia02_Killer[GetConvertedPlayerId(GetOwningPlayer(caster))] != null then
            set killer = CreateUnit(udg_SK_Remilia02_Killer[GetConvertedPlayerId(GetOwningPlayer(caster))], 'n001', GetUnitX(caster), GetUnitY(caster), 270.0)
            call InstantKill(killer, caster)
        else
            call KillUnit(caster)
        endif
        call PauseUnit(caster, false)
        call SetUnitInvulnerable(caster, false)
        call ShowUnitXumn(caster, true)
        call SelectUnitForPlayerSingle(caster, GetOwningPlayer(caster))
        if camswitch then
            call CameraAdd(caster)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    elseif time == 0 or udg_SK_Remilia02_Return then
        set birth = u[7]
        set i = 7
        loop
        exitwhen i == 0
            set life1 = GetWidgetLife(birth)
            set life2 = GetWidgetLife(u[i])
            if udg_SK_Remilia02_Return then
                if GetUnitAbilityLevel(u[i], 'A0DG') >= 1 then
                    set birth = u[i]
                endif
            elseif life2 > life1 then
                set birth = u[i]
            endif
            set i = i - 1
        endloop
        set udg_SK_Remilia02_Return = false
        call SetUnitPosition(caster, GetUnitX(birth), GetUnitY(birth))
        call PauseUnit(caster, false)
        call SetUnitState(caster, UNIT_STATE_LIFE, GetWidgetLife(birth) / GetUnitState(birth, UNIT_STATE_MAX_LIFE) * GetUnitState(caster, UNIT_STATE_MAX_LIFE))
        call SetUnitInvulnerable(caster, false)
        call ShowUnitXumn(caster, true)
        call SelectUnitForPlayerSingle(caster, GetOwningPlayer(caster))
        if camswitch then
            call CameraAdd(caster)
        endif
        call DestroyEffect(AddSpecialEffect("BatAppear.mdx", GetUnitX(caster), GetUnitY(caster)))
        set i = 7
        loop
        exitwhen i == 0
            call KillUnit(u[i])
            set i = i - 1
        endloop
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u[7] = null
    set u[6] = null
    set u[5] = null
    set u[4] = null
    set u[3] = null
    set u[2] = null
    set u[1] = null
    set birth = null
    set killer = null
endfunction

function Trig_Remilia02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit array u
    local integer time
    local integer uid
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer i
    local boolean camswitch = IsUnitInGroup(caster, udg_CameraUnits)
    local integer bonuslife = R2I(0.35 * GetUnitState(caster, UNIT_STATE_MAX_LIFE))
    local integer bonusdmg = R2I(0.35 * GetHeroInt(caster, true))
    local real r = GetWidgetLife(caster) / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    call UnitRemoveAbility(caster, 'A1ES')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1EP', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1ER', true)
    if level == 1 then
        set uid = 'u00F'
    elseif level == 2 then
        set uid = 'u00G'
    elseif level == 3 then
        set uid = 'u00H'
    elseif level == 4 then
        set uid = 'u00I'
    endif
    set time = 9
    if camswitch then
        call CameraRemove(caster)
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveBoolean(udg_ht, task, 0, camswitch)
    set i = 7
    loop
    exitwhen i == 0
        set u[i] = CreateUnit(GetOwningPlayer(caster), uid, GetUnitX(caster) + 150 * Cos(bj_DEGTORAD * i * 52), GetUnitY(caster) + 150 * Sin(bj_DEGTORAD * i * 52), 0)
        call UnitAddMaxLife(u[i], bonuslife)
        call UnitAddAttackDamage(u[i], bonusdmg)
        call SetUnitState(u[i], UNIT_STATE_LIFE, r * GetUnitState(u[i], UNIT_STATE_MAX_LIFE))
        call SaveUnitHandle(udg_ht, task, i, u[i])
        call SaveBoolean(udg_ht, task, i + 7, true)
        call SetUnitInvulnerable(u[i], false)
        call ShowUnit(u[i], false)
        set i = i - 1
    endloop
    call ShowUnit(caster, false)
    call SetUnitInvulnerable(caster, true)
    call DestroyEffect(AddSpecialEffect("Bat-1.mdx", GetUnitX(caster) + 30, GetUnitY(caster) - 30))
    call DestroyEffect(AddSpecialEffect("Bat-1.mdx", GetUnitX(caster) - 30, GetUnitY(caster) + 30))
    call DestroyEffect(AddSpecialEffect("Bat-1.mdx", GetUnitX(caster), GetUnitY(caster)))
    call SaveInteger(udg_ht, task, 15, 0)
    call SaveInteger(udg_ht, task, 16, time * 10)
    call TimerStart(t, 0.1, true, function Trig_Remilia02_Loop)
    set t = null
    set caster = null
    set u[7] = null
    set u[6] = null
    set u[5] = null
    set u[4] = null
    set u[3] = null
    set u[2] = null
    set u[1] = null
endfunction

function InitTrig_Remilia02 takes nothing returns nothing
endfunction