function Trig_Suika04_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetTriggerUnit()) != 'H00Q' then
        return false
    endif
    return GetSpellAbilityId() == 'A05W'
endfunction

function Trig_Suika04_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local boolean o = GetWidgetLife(caster) >= 0.405
    local boolean k = GetUnitTypeId(caster) == 'H00Q'
    if not o or not k then
        if o then
            call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl", caster, "origin"))
            call PlaySoundOnUnitBJ(gg_snd_Suika04, 100, caster)
        endif
        call UnitRemoveAbility(caster, 'B045')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05V', true)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05W', true)
        call DebugMsg("MPP OFF")
        call UnitReduceAttackDamage(caster, 15 + 15 * GetUnitAbilityLevel(caster, 'A05W'))
        call SetUnitScale(caster, 1, 1, 1)
        call SetUnitPathing(caster, true)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Suika04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local real s
    call VE_Spellcast(caster)
    set s = (2.0 + level * 2.0) * 0.9
    call SetUnitScale(caster, s, s, s)
    call UnitAddAbility(caster, 'A0BB')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05V', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05W', false)
    call SetUnitAbilityLevel(caster, 'A0HZ', level)
    call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl", caster, "origin"))
    call PlaySoundOnUnitBJ(gg_snd_Suika04, 100, caster)
    call CastSpell(caster, "Missing Power!!!!!!")
    call SetUnitPathing(caster, false)
    set t = CreateTimer()
    call UnitInitAddAttack(caster)
    call UnitAddAttackDamage(caster, 15 + 15 * level)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
    call TimerStart(t, 0.1, true, function Trig_Suika04_End)
    call DebugMsg("MPP ON")
    set caster = null
    set t = null
endfunction

function InitTrig_Suika04 takes nothing returns nothing
endfunction