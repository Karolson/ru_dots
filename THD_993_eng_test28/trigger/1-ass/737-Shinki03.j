function Trig_Shinki03_Conditions takes nothing returns boolean
    if not (GetLearnedSkill() == 'A1DV') then
        return false
    endif
    return true
endfunction

function Trig_Shinki03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer LearnedSkillLevel = GetLearnedSkillLevel()
    if LearnedSkillLevel > 4 then
        set LearnedSkillLevel = 4
    endif
    if LearnedSkillLevel == 1 then
        call AddUnitAnimationProperties(GetTriggerUnit(), "alternate", true)
    endif
    call SetUnitAbilityLevel(caster, 'A1F0', LearnedSkillLevel + 1)
    call SetUnitMoveSpeed(caster, GetUnitDefaultMoveSpeed(caster) + LearnedSkillLevel * 5 + 15)
    set caster = null
endfunction

function InitTrig_Shinki03 takes nothing returns nothing
    set gg_trg_Shinki03 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shinki03, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Shinki03, Condition(function Trig_Shinki03_Conditions))
    call TriggerAddAction(gg_trg_Shinki03, function Trig_Shinki03_Actions)
endfunction