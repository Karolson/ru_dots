function Trig_Shikieiki01_Display_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0I1'
endfunction

function Trig_Shikieiki01_Display_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit h
    local group g = CreateGroupOfAllHeroes()
    loop
        set h = FirstOfGroup(g)
    exitwhen h == null
        call GroupRemoveUnit(g, h)
        if IsUnitEnemy(h, GetOwningPlayer(caster)) then
            call Trig_Shikieiki01_Debuff_Display(caster, h)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set h = null
    set g = null
endfunction

function InitTrig_Shikieiki01_Display takes nothing returns nothing
endfunction