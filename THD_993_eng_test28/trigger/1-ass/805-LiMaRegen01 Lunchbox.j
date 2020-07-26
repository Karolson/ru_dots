function Trig_LiMaRegen01_Lunchbox_Conditions takes nothing returns boolean
    local integer abid = GetSpellAbilityId()
    local unit u
    local item itm
    local integer charge
    if abid == 'A02K' or abid == 'A0LC' then
        set u = GetTriggerUnit()
        if GetSpellAbilityId() == 'A02K' then
            set itm = YDWEGetItemOfTypeFromUnitBJNull(u, 'I02Z')
            set charge = GetItemCharges(itm)
            call UnitHealingTarget(u, u, 22.0 * charge)
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + 16.0 * charge)
            call SetItemCharges(itm, 0)
        elseif GetSpellAbilityId() == 'A0LC' and GetUnitAbilityLevel(u, 'A1A5') == 0 then
            set itm = YDWEGetItemOfTypeFromUnitBJNull(u, 'I05W')
            set charge = GetItemCharges(itm)
            if charge > 0 then
                if charge > 7 then
                    call ClearAllNegativeBuff(u, false)
                    call UnitRemoveAbility(u, 'A0A1')
                    call UnitRemoveAbility(u, 'A0V4')
                endif
                call UnitBuffTarget(u, u, 25, 'A1A5', 0)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl", u, "origin"))
                call UnitHealingTarget(u, u, 43.0 * charge)
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + 27.0 * charge)
                call SetItemCharges(itm, 0)
            endif
        endif
    endif
    set itm = null
    set u = null
    return false
endfunction

function LunchBoxToggle_Reset takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = LoadInteger(udg_ht, GetHandleId(t), 0)
    set udg_LunchBoxToggle[i] = false
    call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
endfunction

function LunchBoxActive takes nothing returns boolean
    local integer i = GetPlayerId(GetTriggerPlayer())
    local unit u = udg_PlayerHeroes[i]
    local item itm = YDWEGetItemOfTypeFromUnitBJNull(u, 'I05W')
    local integer charge
    local timer t
    if itm != null then
        set charge = GetItemCharges(itm)
        if charge >= 1 and GetUnitAbilityLevel(u, 'A1A5') == 0 then
            if udg_LunchBoxToggle[i] then
                if charge > 7 then
                    call ClearAllNegativeBuff(u, false)
                    call UnitRemoveAbility(u, 'A0A1')
                    call UnitRemoveAbility(u, 'A0V4')
                endif
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl", u, "origin"))
                call UnitHealingTarget(u, u, 43.0 * charge)
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + 27.0 * charge)
                call UnitBuffTarget(u, u, 25, 'A1A5', 0)
                call SetItemCharges(itm, 0)
                set udg_LunchBoxToggle[i] = false
            else
                set udg_LunchBoxToggle[i] = true
                set t = CreateTimer()
                call SaveInteger(udg_ht, GetHandleId(t), 0, i)
                call TimerStart(t, 1.0, false, function LunchBoxToggle_Reset)
            endif
        endif
    endif
    set u = null
    set itm = null
    return false
endfunction

function InitTrig_LiMaRegen01_Lunchbox takes nothing returns nothing
    local trigger t = CreateTrigger()
    local integer i = 0
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerEvent(t, Player(i), EVENT_PLAYER_END_CINEMATIC)
        set i = i + 1
    endloop
    call TriggerAddCondition(t, Condition(function LunchBoxActive))
    set gg_trg_LiMaRegen01_Lunchbox = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LiMaRegen01_Lunchbox, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_LiMaRegen01_Lunchbox, Condition(function Trig_LiMaRegen01_Lunchbox_Conditions))
endfunction