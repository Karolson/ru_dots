function AKYUEX_ACTIVE takes nothing returns integer
    return 'A0QH'
endfunction

function AkyuEx_SwitchOn takes nothing returns nothing
    call ReleaseTimer(GetExpiredTimer())
    set udg_Akyu_Ex = true
endfunction

function AkyuEx_Revive_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0QH' then
        set udg_Akyu_Ex = false
        call TimerStart(CreateTimer(), 240.0, false, function AkyuEx_SwitchOn)
        call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(udg_SK_Akyu), StringHash("IsAkyuExRevival"), true)
        call ReviveHero(udg_SK_Akyu, GetSpellTargetX(), GetSpellTargetY(), true)
        call SetUnitState(udg_SK_Akyu, UNIT_STATE_LIFE, 0.6 * GetUnitState(udg_SK_Akyu, UNIT_STATE_MAX_LIFE))
        call SetUnitState(udg_SK_Akyu, UNIT_STATE_MANA, 0.6 * GetUnitState(udg_SK_Akyu, UNIT_STATE_MAX_MANA))
    endif
    return false
endfunction

function InitTrig_AkyuEx_Revive takes nothing returns nothing
endfunction