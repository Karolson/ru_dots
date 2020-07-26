function Trig_Hatate04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0E6'
endfunction

function Trig_Hatate04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    if IsUnitType(u, UNIT_TYPE_DEAD) == false then
        call SetUnitXY(u, GetUnitX(v), GetUnitY(v))
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set v = null
    set u = null
endfunction

function Trig_Hatate04_Main takes unit caster, unit v, integer level returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    if level == 1 then
        set u = CreateUnit(GetOwningPlayer(caster), 'n03Y', GetUnitX(v), GetUnitY(v), 0)
    elseif level == 2 then
        set u = CreateUnit(GetOwningPlayer(caster), 'n03Z', GetUnitX(v), GetUnitY(v), 0)
    else
        set u = CreateUnit(GetOwningPlayer(caster), 'n040', GetUnitX(v), GetUnitY(v), 0)
    endif
    call SaveUnitHandle(udg_ht, task, 0, v)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call TimerStart(t, 0.1, true, function Trig_Hatate04_Clear)
    set t = null
    set u = null
endfunction

function Trig_Hatate04_EffectClear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local effect e = LoadEffectHandle(udg_ht, task, 0)
    call DestroyEffect(e)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e = null
endfunction

function Trig_Hatate04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0E6')
    local integer i
    local unit v
    local effect e = AddSpecialEffectTarget("Abilities\\Spells\\Items\\PotionOfOmniscience\\CrystalBallCaster.mdl", caster, "head")
    call VE_Spellcast(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 220 - 50 * level)
    set i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and IsUnitEnemy(v, GetOwningPlayer(caster)) then
            call Trig_Hatate04_Main(caster, v, level)
        endif
        set i = i + 1
    endloop
    call SaveEffectHandle(udg_ht, task, 0, e)
    call TimerStart(t, 4 + level, false, function Trig_Hatate04_EffectClear)
    set t = null
    set caster = null
    set v = null
    set e = null
endfunction

function InitTrig_Hatate04 takes nothing returns nothing
endfunction