function Trig_ParseeEx_Conditions_Stage3 takes nothing returns boolean
    if GetUnitTypeId(GetTriggerUnit()) != 'E01U' then
        return false
    elseif IsUnitIllusion(GetTriggerUnit()) != true then
        return false
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'A0W6') == 0 then
        return false
    endif
    return true
endfunction

function Trig_ParseeEx_Stage3_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer j
    set j = 0
    loop
        set j = j + 1
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", ox + 300.0 * CosBJ(j * 30), oy + 300.0 * SinBJ(j * 30)))
    exitwhen j == 12
    endloop
    call UnitAbsDamageArea(caster, ox, oy, 400, 100 + GetHeroLevel(udg_SK_Parsee) * 25)
    set caster = null
endfunction

function InitTrig_ParseeEx_Stage3 takes nothing returns nothing
endfunction