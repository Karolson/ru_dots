function Trig_Sakuya04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A03P'
endfunction

function Trig_Sakuya04_Reset takes unit h, integer d returns nothing
    local integer level = GetUnitAbilityLevel(h, d)
    if level > 0 then
        call UnitRemoveAbility(h, d)
        call UnitAddAbility(h, d)
        call SetUnitAbilityLevel(h, d, level)
        call UnitMakeAbilityPermanent(h, true, d)
    endif
endfunction

function Trig_Sakuya04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local texttag e = LoadTextTagHandle(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer k = GetPlayerId(GetOwningPlayer(caster)) + 1
    if i > 0 and GetWidgetLife(caster) > 0.405 then
        set i = i - 1
        call SaveInteger(udg_ht, task, 1, i)
        call SetTextTagTextBJ(e, R2SW(0.1 * i, 3, 1), 14.0)
        if IsUnitInRange(u, caster, 250 + level * 150.0) then
            call EnableTrigger(gg_trg_Sakuya04_Reset)
        else
            set udg_SK_Sakuya04_Switch[k] = false
            call DisableTrigger(gg_trg_Sakuya04_Reset)
            call EnableTrigger(gg_trg_Sakuya04_Enter)
            call SaveInteger(udg_ht, task, 1, 0)
        endif
    else
        set udg_SK_Sakuya04_Mana01[k] = 0
        set udg_SK_Sakuya04_Mana02[k] = 0
        set udg_SK_Sakuya04_Mana03[k] = 0
        set udg_SK_Sakuya04_Mana04[k] = 0
        set udg_SK_Sakuya04_Switch[k] = false
        call UnitManaingTarget(caster, caster, 100 * level)
        call SaveInteger(udg_sht, GetHandleId(caster), S2I("Sakuya04"), 0)
        call DisableTrigger(gg_trg_Sakuya04_Reset)
        call DisableTrigger(gg_trg_Sakuya04_Enter)
        call DestroyTextTag(e)
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set e = null
endfunction

function Trig_Sakuya04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real s
    local integer level = GetUnitAbilityLevel(caster, 'A03P')
    local timer t
    local integer task
    local texttag e
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    call VE_Spellcast(caster)
    call AbilityCoolDownResetion(caster, 'A03P', 180 - level * 30)
    set udg_SK_Sakuya04_Mana01[k] = 0
    set udg_SK_Sakuya04_Mana02[k] = 0
    set udg_SK_Sakuya04_Mana03[k] = 0
    set udg_SK_Sakuya04_Mana04[k] = 0
    set udg_SK_Sakuya04_Time[k] = 99999
    set udg_SK_Sakuya04_Switch[k] = true
    set s = 2 + level * 1
    set e = CreateTextTag()
    call SetTextTagTextBJ(e, R2SW(s, 3, 1), 14.0)
    call SetTextTagPos(e, ox, oy, 200.0)
    call SetTextTagColor(e, 0, 255, 255, 255)
    set u = CreateUnit(GetOwningPlayer(caster), 'h00T', ox, oy, 270.0)
    call SetUnitScale(u, 1.54, 1.54, 1.54)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveTextTagHandle(udg_ht, task, 2, e)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 20 + 20 * level)
    call TimerStart(t, 0.1, true, function Trig_Sakuya04_Main)
    call Trig_Sakuya04_Reset(caster, 'A04H')
    call Trig_Sakuya04_Reset(caster, 'A099')
    call Trig_Sakuya04_Reset(caster, 'A09A')
    call Trig_Sakuya04_Reset(caster, 'A1IA')
    call EnableTrigger(gg_trg_Sakuya04_Reset)
    call TriggerRegisterUnitInRange(gg_trg_Sakuya04_Enter, u, 700, null)
    call SaveInteger(udg_sht, GetHandleId(caster), S2I("Sakuya04"), 1)
    set caster = null
    set u = null
    set t = null
    set e = null
endfunction

function InitTrig_Sakuya04 takes nothing returns nothing
endfunction