function Trig_Suwako04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FL'
endfunction

function Trig_Suwako04_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real h = (i - 20) * (i - 20)
    local unit w
    call SetUnitFlyHeight(target, 450 - h, 0)
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i > 40 then
        call SetUnitFlyHeight(target, GetUnitDefaultFlyHeight(target), 0)
        call SetUnitPathing(target, true)
        call SetUnitFlag(target, 4, false)
        call SetUnitFlag(target, 3, false)
        call UnitStunTarget(caster, target, 0.75 + level * 0.25, 0, 0)
        call CE_Input(caster, target, 150)
        call UnitMagicDamageTarget(caster, target, 30 + 30 * level + GetHeroInt(caster, true) * 2, 6)
        call Trig_Suwako03_ManaRe(caster, 30 + 30 * level + GetHeroInt(caster, true) * 0.6)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set w = null
endfunction

function Trig_Suwako04_Effect_Start takes unit caster, unit target, integer level returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", ox, oy))
    call SetUnitPathing(target, false)
    call EnableHeight(target)
    call SetUnitFlag(target, 4, true)
    call SetUnitFlag(target, 3, true)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 1)
    call TimerStart(t, 0.02, true, function Trig_Suwako04_Effect_Main)
    set t = null
endfunction

function Trig_Suwako04_Effect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i
    local unit h
    if GetWidgetLife(caster) > 0.405 then
        set i = 0
        loop
        exitwhen i >= 12
            set h = udg_PlayerHeroes[i]
            if h != null and GetWidgetLife(h) > 0.405 and IsUnitEnemy(h, GetOwningPlayer(caster)) and IsUnitVisible(h, GetOwningPlayer(caster)) then
                call Trig_Suwako04_Effect_Start(caster, h, level)
            endif
            set i = i + 1
        endloop
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set h = null
endfunction

function Trig_Suwako04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A0FL')
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A0FL', 100)
    else
        call AbilityCoolDownResetion(caster, 'A0FL', 100 * 0.75)
    endif
    call VE_Spellcast(caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 1.0, false, function Trig_Suwako04_Effect)
    set caster = null
    set t = null
endfunction

function InitTrig_Suwako04 takes nothing returns nothing
endfunction