function AKYU04 takes nothing returns integer
    return 'A0P6'
endfunction

function AKYU04_ALLY_DEBUFF_SKILL takes nothing returns integer
    return 'A0PA'
endfunction

function AKYU04_ALLY_DEBUFF takes nothing returns integer
    return 'B081'
endfunction

function AKYU04_ENEMY_DEBUFF_SKILL takes nothing returns integer
    return 'A0PY'
endfunction

function AKYU04_ENEMY_DEBUFF takes nothing returns integer
    return 'B07R'
endfunction

function AKYU04_ENEMY_DEBUFF_ORDER takes nothing returns string
    return "drunkenhaze"
endfunction

function Akyu04_Conditions takes nothing returns boolean
    local group g
    local unit v
    local player p
    local real damage
    local real sealduration
    if GetSpellAbilityId() == 'A0P6' then
        call VE_Spellcast(GetTriggerUnit())
        set g = CreateGroup()
        set p = GetOwningPlayer(udg_SK_Akyu)
        set damage = GetUnitAbilityLevel(udg_SK_Akyu, 'A0P6') * 100.0 + 100.0 + 1.5 * GetHeroInt(udg_SK_Akyu, true)
        set sealduration = 2.0 + 1.0 * GetUnitAbilityLevel(udg_SK_Akyu, 'A0P6')
        call AbilityCoolDownResetion(udg_SK_Akyu, 'A0P6', 120)
        call GroupEnumUnitsInRange(g, GetUnitX(udg_SK_Akyu), GetUnitY(udg_SK_Akyu), 800.0, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_HERO) and GetUnitAbilityLevel(v, 'Avul') == 0 then
                if IsUnitAlly(v, p) then
                    call UnitBuffTarget(udg_SK_Akyu, v, 6.0, 'A0Z8', 'B081')
                    call UnitBuffTarget(udg_SK_Akyu, v, 6.0, 'A0PA', 'B081')
                else
                    call UnitMagicDamageTarget(udg_SK_Akyu, v, damage, 1)
                    if udg_NewDebuffSys then
                        call UnitDebuffTarget(udg_SK_Akyu, v, sealduration * 1.0, 1, true, 'A0QI', 1, 'B07T', "drunkenhaze", 'A069', "")
                    else
                        call UnitCurseTarget(udg_SK_Akyu, v, sealduration, 'A0PY', "drunkenhaze")
                    endif
                endif
            endif
        endloop
        call DestroyGroup(g)
    endif
    set g = null
    set v = null
    return false
endfunction

function InitTrig_Akyu04 takes nothing returns nothing
endfunction