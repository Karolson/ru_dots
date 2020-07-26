function Yuugi01_Additional_Damage takes nothing returns boolean
    local unit u = GetEventDamageSource()
    local unit v = GetTriggerUnit()
    local integer bonusdmg
    if GetUnitAbilityLevel(u, 'A11C') == 0 or IsUnitAlly(v, GetOwningPlayer(u)) or GetEventDamage() == 0 or IsDamageNotUnitAttack(u) or IsUnitType(v, UNIT_TYPE_STRUCTURE) then
        set u = null
        set v = null
        return false
    endif
    set bonusdmg = 7 * GetUnitAbilityLevel(u, 'A11C') + LoadInteger(udg_sht, StringHash("Yuugi01"), GetHandleId(u))
    call UnitPhysicalDamageTarget(u, v, bonusdmg)
    call DebugMsg(GetUnitName(u) + " additional damage of " + I2S(bonusdmg) + " " + GetUnitName(v))
    set u = null
    set v = null
    return false
endfunction

function Trig_Yuugi01_Conditions takes nothing returns boolean
    local unit u
    local trigger t
    if GetLearnedSkill() == 'A11C' then
        set u = GetTriggerUnit()
        call SetUnitAnimation(u, "spell")
        call UnitAddMaxLife(u, 150)
        if GetLearnedSkillLevel() == 1 then
            call DebugMsg("Trigger Created For Yuugi01")
            set t = CreateTrigger()
            call TriggerAddCondition(t, Condition(function Yuugi01_Additional_Damage))
            call RegisterAnyUnitDamage(t)
            call SaveInteger(udg_sht, StringHash("Yuugi01"), GetHandleId(u), 0)
        endif
    endif
    set u = null
    set t = null
    return false
endfunction

function InitTrig_Yuugi01 takes nothing returns nothing
endfunction