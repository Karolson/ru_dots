function Trig_KogasaEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real life = GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02
    local real mana = GetUnitState(caster, UNIT_STATE_MANA) + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.02
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        return
    endif
    if IsUnitVisible(caster, Player(PLAYER_NEUTRAL_AGGRESSIVE)) == false and GetUnitAbilityLevel(caster, 'B02K') > 0 then
        if IsUnitAlly(caster, udg_PlayerA[0]) and IsUnitVisible(caster, udg_PlayerB[0]) == false then
            call UnitHealingTarget(caster, caster, life)
            call SetUnitState(caster, UNIT_STATE_MANA, mana)
        elseif IsUnitAlly(caster, udg_PlayerB[0]) and IsUnitVisible(caster, udg_PlayerA[0]) == false then
            call UnitHealingTarget(caster, caster, life)
            call SetUnitState(caster, UNIT_STATE_MANA, mana)
        endif
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_KogasaEx takes nothing returns nothing
endfunction