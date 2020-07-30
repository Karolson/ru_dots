function Trig_Komachi04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0CM'
endfunction

function Trig_Komachi04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real oldhp = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local effect e = LoadEffectHandle(udg_ht, task, 4)
    local unit soul1
    local unit soul2
    local unit soul3
    local unit soul4
    local real newhp
    local real nowhp
    local real angle = 0
    if i == 50 then
        set angle = GetUnitFacing(target)
        call SetUnitX(caster, GetUnitX(target) + 100 * Cos((angle - 180) * 0.017454))
        call SetUnitY(caster, GetUnitY(target) + 100 * Sin((angle - 180) * 0.017454))
        set angle = 57.29578 * Atan2(GetUnitY(target) - GetUnitY(caster), GetUnitX(target) - GetUnitX(caster))
        call SetUnitFacing(caster, angle)
        call UnitFade(caster, false, false, 0.05)
        call SetUnitTimeScale(caster, 2.0)
        call SetUnitAnimation(caster, "Attack Slam")
    elseif i == 87 then
        call VE_Sword_Special(target, 2)
        call SaveUnitHandle(udg_ht, task, 10, Komachi_Soul(caster, target, 2))
        call SaveUnitHandle(udg_ht, task, 11, Komachi_Soul(caster, target, 2))
        call SaveUnitHandle(udg_ht, task, 12, Komachi_Soul(caster, target, 2))
        call SaveUnitHandle(udg_ht, task, 13, Komachi_Soul(caster, target, 2))
    elseif i == 150 then
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitAnimation(caster, "Spell")
    elseif i == 250 then
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call SetUnitInvulnerable(caster, false)
        call PauseUnit(caster, false)
        if LoadBoolean(udg_ht, task, 8) then
            call PauseUnit(target, false)
        endif
        call SetUnitInvulnerable(target, false)
        call SetUnitTimeScale(caster, 1.0)
        call CE_Input(caster, target, GetUnitState(target, UNIT_STATE_LIFE) * 0.5)
        call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) * 0.55)
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", GetUnitX(target), GetUnitY(target)))
        set soul1 = LoadUnitHandle(udg_ht, task, 10)
        set soul2 = LoadUnitHandle(udg_ht, task, 11)
        set soul3 = LoadUnitHandle(udg_ht, task, 12)
        set soul4 = LoadUnitHandle(udg_ht, task, 13)
        call Komachi03_SoulExplosion(caster, soul1)
        call Komachi03_SoulExplosion(caster, soul2)
        call Komachi03_SoulExplosion(caster, soul3)
        call Komachi03_SoulExplosion(caster, soul4)
        call Komachi_Soul(caster, target, 3)
        call Komachi_Soul(caster, target, 3)
        call Komachi_Soul(caster, target, 3)
        call Komachi_Soul(caster, target, 3)
        call Komachi_Soul(caster, target, 3)
        set soul1 = null
        set soul2 = null
        set soul3 = null
        set soul4 = null
    endif
    if i >= 275 then
        set nowhp = GetWidgetLife(target)
        if nowhp > oldhp then
            set newhp = nowhp - (nowhp - oldhp) * 0.5
            call CE_Input(caster, target, newhp)
            call SetUnitState(target, UNIT_STATE_LIFE, newhp)
        endif
        call SaveReal(udg_ht, task, 2, GetWidgetLife(target))
    endif
    set i = i + 1
    call SaveInteger(udg_ht, task, 3, i)
    if i >= 1150 then
        call DestroyEffect(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Komachi04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0CM')
    local effect e
    local timer t
    local integer task
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 125 - 25 * level)
    else
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), (150 - 25 * level) * 0.75)
    endif
    call VE_Spellcast(caster)
    call PauseUnit(target, true)
    call PauseUnit(target, true)
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SetUnitInvulnerable(target, true)
    call UnitFade(caster, false, true, 0.05)
    call UnitInjureTarget(caster, target, 1 + 2 * level)
    set e = AddSpecialEffectTarget("Komachi_Change.mdl", target, "origin")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveReal(udg_ht, task, 2, GetUnitState(target, UNIT_STATE_LIFE))
    call SaveInteger(udg_ht, task, 3, 0)
    call SaveEffectHandle(udg_ht, task, 4, e)
    call TimerStart(t, 0.01, true, function Trig_Komachi04_Main)
    set caster = null
    set target = null
    set e = null
    set t = null
endfunction

function InitTrig_Komachi04 takes nothing returns nothing
endfunction