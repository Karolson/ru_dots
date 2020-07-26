function Trig_Hatate04_Ex_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0I2'
endfunction

function Trig_Hatate04_Ex_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local effect e = LoadEffectHandle(udg_ht, task, 1)
    call DestroyEffect(e)
    if IsUnitAlly(gg_unit_n023_0006, GetOwningPlayer(caster)) then
        call SetUnitXYGround(caster, GetLocationX(udg_BirthPoint[0]) - 125, GetLocationY(udg_BirthPoint[0]) - 125)
    elseif IsUnitAlly(gg_unit_n03O_0079, GetOwningPlayer(caster)) then
        call SetUnitXYGround(caster, GetLocationX(udg_BirthPoint[1]) - 125, GetLocationY(udg_BirthPoint[1]) - 125)
    endif
    call PauseUnit(caster, false)
    call SetUnitInvulnerable(caster, false)
    call IssueImmediateOrder(caster, "stop")
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set e = null
endfunction

function Trig_Hatate04_Ex_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local effect e
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 180)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        set e = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set e = AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", caster, "origin")
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveEffectHandle(udg_ht, task, 1, e)
    call TimerStart(t, 3.0, false, function Trig_Hatate04_Ex_Clear)
    set caster = null
    set t = null
    set e = null
endfunction

function InitTrig_Hatate04_Ex takes nothing returns nothing
endfunction