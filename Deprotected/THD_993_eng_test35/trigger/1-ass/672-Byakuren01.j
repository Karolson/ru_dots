function Trig_Byakuren01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0NZ'
endfunction

function Trig_Byakuren01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0NZ')
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local unit e1
    local unit e2
    local unit e3
    local unit v
    local unit w
    local group g
    local boolexpr iff
    local real damage02 = 0
    call AbilityCoolDownResetion(caster, 'A0NZ', 19.5 - 2.5 * level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set e1 = null
            set e2 = null
            set v = null
            set w = null
            set g = null
            set iff = null
            return
        endif
    endif
    set e1 = CreateUnit(GetOwningPlayer(caster), 'e01J', tx, ty, 0)
    set e2 = CreateUnit(GetOwningPlayer(caster), 'e01J', tx, ty, 180)
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call SetUnitPathing(e1, false)
    call SetUnitPathing(e2, false)
    call SetUnitXY(e1, tx, ty)
    call SetUnitXY(e2, tx, ty)
    if udg_SK_Byakuren02_Record > 0 then
        set damage02 = udg_SK_Byakuren02_Record
        set udg_SK_Byakuren02_Record = 0
    endif
    call UnitMagicDamageTarget(caster, target, 35 + 65 * level + 0.8 * GetHeroInt(caster, true) + damage02, 1)
    call UnitStunTarget(caster, target, 1.2 + level * 0.2, 0, 0)
    if damage02 > 0 then
        set e3 = CreateUnit(GetOwningPlayer(caster), 'e01M', tx, ty, 0)
        call SetUnitPathing(e3, false)
        call SetUnitXY(e3, tx, ty)
    endif
    call GroupEnumUnitsInRange(g, tx, ty, 350, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and target != v then
            call UnitStunTarget(caster, v, 1.2 + level * 0.2, 0, 0)
            call UnitMagicDamageTarget(caster, v, 25 + 40 * level + 0.5 * GetHeroInt(caster, true) + damage02, 5)
            if damage02 > 0 then
                set e3 = CreateUnit(GetOwningPlayer(caster), 'e01M', GetUnitX(v), GetUnitY(v), 0)
                call SetUnitPathing(e3, false)
                call SetUnitXY(e3, GetUnitX(v), GetUnitY(v))
            endif
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set target = null
    set e1 = null
    set e2 = null
    set e3 = null
    set v = null
    set w = null
    set g = null
    set iff = null
endfunction

function InitTrig_Byakuren01 takes nothing returns nothing
endfunction