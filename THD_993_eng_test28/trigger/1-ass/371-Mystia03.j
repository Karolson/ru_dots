function Trig_Mystia03_Conditions takes nothing returns boolean
    local boolean a = false
    local integer i
    local integer j
    local integer abid = GetSpellAbilityId()
    local unit u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == false then
        set u = null
        return false
    elseif abid == 'A07Y' then
        set u = null
        return false
    elseif abid == 'A08I' then
        set u = null
        return false
    elseif abid == 'A0QP' then
        set u = null
        return false
    elseif abid == 'A0OS' then
        set u = null
        return false
    elseif abid == 'A0OR' then
        set u = null
        return false
    elseif abid == 'A029' then
        set u = null
        return false
    elseif abid == 'A02A' then
        set u = null
        return false
    elseif abid == 'A015' then
        set u = null
        return false
    elseif abid == 'A02B' then
        set u = null
        return false
    elseif abid == 'A035' then
        set u = null
        return false
    elseif abid == 'A02C' then
        set u = null
        return false
    elseif abid == 'A02K' then
        set u = null
        return false
    elseif abid == 'A02L' then
        set u = null
        return false
    elseif abid == 'A02M' then
        set u = null
        return false
    elseif abid == 'A0LC' then
        set u = null
        return false
    elseif abid == 'A0I1' then
        set u = null
        return false
    elseif abid == 'A04O' then
        set u = null
        return false
    elseif abid == 'A07V' then
        set u = null
        return false
    elseif abid == 'A0FK' then
        set u = null
        return false
    elseif abid == 'A03T' then
        set u = null
        return false
    elseif abid == 'A0CI' then
        set u = null
        return false
    elseif abid == 'A18G' then
        set u = null
        return false
    elseif abid == 'A0PK' then
        set u = null
        return false
    elseif abid == 'A0Z2' then
        set u = null
        return false
    endif
    set i = 0
    set j = 0
    loop
        if IsUnitAlly(u, GetOwningPlayer(udg_SK_Mystia[i])) and IsUnitType(udg_SK_Mystia[i], UNIT_TYPE_DEAD) == false then
            if GetRandomInt(1, 100) <= 35 and IsUnitInRange(u, udg_SK_Mystia[i], 450.0) then
                set a = true
                set j = j + 1
                set udg_SK_Mystia_K_Record = i
                set udg_SK_Mystia_Double_Record = j
            endif
        endif
        set i = i + 1
    exitwhen i == 16
    endloop
    set u = null
    return a
endfunction

function Trig_Mystia03_Actions takes nothing returns nothing
    local unit caster = udg_SK_Mystia[udg_SK_Mystia_K_Record]
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0DH')
    local integer doubling = udg_SK_Mystia_Double_Record
    local effect e1
    local effect e2
    if caster == target then
        set e1 = AddSpecialEffectTarget("MusicTarget.mdx", caster, "head")
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl", caster, "chest"))
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (20 + 20 * level) * doubling)
        call TriggerSleepAction(1.0)
        call DestroyEffect(e1)
    else
        set e1 = AddSpecialEffectTarget("MusicTarget.mdx", caster, "head")
        set e2 = AddSpecialEffectTarget("MusicTarget.mdx", target, "head")
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl", caster, "chest"))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl", target, "chest"))
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (20 + 20 * level) * doubling)
        call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) + (20 + 20 * level) * doubling)
        call TriggerSleepAction(1.0)
        call DestroyEffect(e1)
        call DestroyEffect(e2)
    endif
    set target = null
    set caster = null
    set e1 = null
    set e2 = null
endfunction

function Trig_Mystia03_Learn takes nothing returns nothing
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    if GetLearnedSkill() == 'A0DH' then
        set udg_SK_Mystia[k] = GetTriggerUnit()
        call DestroyTrigger(GetTriggeringTrigger())
        set gg_trg_Mystia03 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Mystia03, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(gg_trg_Mystia03, Condition(function Trig_Mystia03_Conditions))
        call TriggerAddAction(gg_trg_Mystia03, function Trig_Mystia03_Actions)
    endif
endfunction

function InitTrig_Mystia03 takes nothing returns nothing
endfunction