function Trig_MokouEx_Conditions takes nothing returns boolean
    local integer task
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_DEATH then
        if GetUnitTypeId(GetTriggerUnit()) == 'h00O' and GetKillingUnit() != null then
            set task = GetHandleId(GetTriggerUnit())
            call SaveUnitHandle(udg_ht, task, 0, GetKillingUnit())
        endif
        return false
    endif
    return GetSpellAbilityId() == 'A052'
endfunction

function Trig_MokouEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 then
        if GetWidgetLife(u) >= 0.405 then
            call SaveInteger(udg_ht, task, 1, i - 1)
            if i == 65 then
                call SaveEffectHandle(udg_ht, task, 2, AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\SmallFlameSpawn\\SmallFlameSpawn.mdl", u, "origin"))
            endif
        else
            call SaveInteger(udg_ht, task, 1, -1)
            call ShowUnitXumn(caster, true)
            call PauseUnit(caster, false)
            call SetUnitInvulnerable(caster, false)
            set u = LoadUnitHandle(udg_ht, GetHandleId(u), 0)
            if u == null then
                call UnitRemoveBuffs(caster, true, true)
                call KillUnit(caster)
            else
                call UnitRemoveBuffs(caster, true, true)
                call InstantKill(u, caster)
            endif
            if i < 65 then
                call DestroyEffect(LoadEffectHandle(udg_ht, task, 2))
            endif
            call FlushChildHashtable(udg_ht, GetHandleId(u))
        endif
    else
        if i >= 0 then
            call ShowUnit(caster, true)
            call PauseUnit(caster, false)
            call SetUnitInvulnerable(caster, false)
            if IsUnitDead(caster) then
                call ReviveHero(caster, GetUnitX(u), GetUnitY(u), false)
            endif
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE))
            call SelectUnitForPlayerSingle(caster, GetOwningPlayer(caster))
            call KillUnit(u)
        endif
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 2))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set caster = null
    set u = null
endfunction

function Trig_MokouEx_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real period
    local timer t
    local integer task
    local real abilitycooldownlv01 = 40
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I00B') then
        call Item_HeroAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv01)
    endif
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", GetUnitX(caster), GetUnitY(caster)))
    call PauseUnit(caster, true)
    call ShowUnit(caster, false)
    call SetUnitInvulnerable(caster, true)
    call UnitRemoveAbility(caster, 'Bvul')
    call UnitRemoveAbility(caster, 'A053')
    call UnitRemoveAbility(caster, 'A054')
    call UnitRemoveAbility(caster, 'A055')
    call UnitRemoveAbility(caster, 'A056')
    call UnitRemoveAbility(caster, 'A057')
    call UnitRemoveAbility(caster, 'A058')
    call UnitRemoveAbility(caster, 'B00U')
    call UnitRemoveAbility(caster, 'B00V')
    call UnitRemoveAbility(caster, 'B00W')
    call UnitRemoveAbility(caster, 'B00X')
    set period = 6.0
    set u = CreateUnit(GetOwningPlayer(caster), 'h00O', GetUnitX(caster), GetUnitY(caster), 270.0)
    call SelectUnitForPlayerSingle(u, GetOwningPlayer(caster))
    call SetUnitAnimation(u, "stand alternate")
    call UnitApplyTimedLife(u, 'Bphx', period + 0.1)
    call BroadcastMessage("Immortal 'Primal Phoenix'")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 1, R2I(period / 0.02))
    call TimerStart(t, 0.02, true, function Trig_MokouEx_Main)
    set caster = null
    set t = null
    set u = null
endfunction

function InitTrig_MokouEx takes nothing returns nothing
endfunction