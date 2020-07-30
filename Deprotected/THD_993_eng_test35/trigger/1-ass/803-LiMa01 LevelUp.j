function Trig_LiMa01_LevelUp_Conditions takes nothing returns boolean
    return YDWEUnitHasItemOfTypeBJNull(GetTriggerUnit(), 'I085')
endfunction

function Trig_LiMa01_LevelUp_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + 32 + GetHeroLevel(caster) * 12)
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 24 + GetHeroLevel(caster) * 9)
    set caster = null
endfunction

function InitTrig_LiMa01_LevelUp takes nothing returns nothing
    set gg_trg_LiMa01_LevelUp = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LiMa01_LevelUp, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(gg_trg_LiMa01_LevelUp, Condition(function Trig_LiMa01_LevelUp_Conditions))
    call TriggerAddAction(gg_trg_LiMa01_LevelUp, function Trig_LiMa01_LevelUp_Actions)
endfunction