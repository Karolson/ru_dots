function Trig_Alice_Conditions takes nothing returns boolean
    return true
endfunction

function Trig_Alice_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer task = GetHandleId(caster)
    local integer d = GetLearnedSkill()
    local integer level = GetUnitAbilityLevel(caster, d)
    if d == 'A0GV' then
        set d = LoadInteger(udg_sht, task, 1)
        call SaveInteger(udg_sht, task, 1, d + 1)
        call SetPlayerTechResearched(GetOwningPlayer(caster), 'R007', level)
        if level >= 4 then
            if GetUnitAbilityLevel(caster, 'A0HU') == 0 then
                call UnitAddAbility(caster, 'A0HU')
                call UnitMakeAbilityPermanent(caster, true, 'A0HU')
            endif
            set level = GetUnitAbilityLevel(caster, 'A0GY')
            if level > 0 then
                call SetUnitAbilityLevel(caster, 'A0HU', level + 1)
            endif
        endif
    endif
    if d == 'A0GW' then
        set d = LoadInteger(udg_sht, task, 2)
        call SaveInteger(udg_sht, task, 2, d + 1)
        call SetPlayerTechResearched(GetOwningPlayer(caster), 'R008', level)
    endif
    if d == 'A0GX' then
        set d = LoadInteger(udg_sht, task, 3)
        call SaveInteger(udg_sht, task, 3, d + 1)
        call SetPlayerTechResearched(GetOwningPlayer(caster), 'R009', level)
    endif
    if d == 'A0GY' then
        set d = LoadInteger(udg_sht, task, 1)
        call SaveInteger(udg_sht, task, 1, d + 2)
        set d = LoadInteger(udg_sht, task, 2)
        call SaveInteger(udg_sht, task, 2, d + 2)
        set d = LoadInteger(udg_sht, task, 3)
        call SaveInteger(udg_sht, task, 3, d + 2)
        call SetPlayerTechResearched(GetOwningPlayer(caster), 'R006', level)
        call SetPlayerTechResearched(GetOwningPlayer(caster), 'R00A', level)
        if GetUnitAbilityLevel(caster, 'A0HU') > 0 then
            call SetUnitAbilityLevel(caster, 'A0HU', level + 1)
        endif
    endif
    set caster = null
endfunction

function InitTrig_Alice takes nothing returns nothing
endfunction