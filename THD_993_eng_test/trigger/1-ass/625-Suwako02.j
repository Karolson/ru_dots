function Trig_Suwako02_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A17R' and GetUnitTypeId(GetTriggerUnit()) == 'H01X' then
        return true
    endif
    if GetSpellAbilityId() == 'A0X7' and GetUnitTypeId(GetTriggerUnit()) == 'H02A' then
        return true
    endif
    return GetSpellAbilityId() == 'A17Q' and GetUnitTypeId(GetTriggerUnit()) == 'H012'
endfunction

function Trig_Suwako02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local real damage = LoadReal(udg_Hashtable, task, 2)
    local integer i = LoadInteger(udg_Hashtable, task, 3)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    if GetUnitAbilityLevel(caster, 'B073') > 0 then
        call SaveInteger(udg_Hashtable, task, 3, i + 1)
        if R2I(i / 20) * 20 == i then
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, ox, oy, 300.0, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                    call UnitMagicDamageTarget(caster, v, damage * 0.2, 6)
                    call Trig_Suwako03_ManaRe(caster, damage * 0.2)
                endif
            endloop
            call DestroyGroup(g)
        endif
    else
        call SetUnitFlyHeight(caster, GetUnitDefaultFlyHeight(caster), 0)
        call IssueImmediateOrder(caster, "stop")
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX(caster), GetUnitY(caster)))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A032', true)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FI', true)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FL', true)
        call UnitRemoveAbility(caster, 'A0LL')
    endif
    set t = null
    set caster = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Suwako02_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX(caster), GetUnitY(caster)))
    call EnableHeight(caster)
    call SetUnitFlyHeight(caster, -30, 0)
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call SaveReal(udg_Hashtable, task, 2, 40 + 40 * level + GetHeroInt(caster, true) * 0.5)
    call SaveInteger(udg_Hashtable, task, 3, 0)
    call TimerStart(t, 0.02, true, function Trig_Suwako02_Main)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A032', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FI', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FL', false)
    set t = null
    set caster = null
endfunction

function InitTrig_Suwako02 takes nothing returns nothing
endfunction