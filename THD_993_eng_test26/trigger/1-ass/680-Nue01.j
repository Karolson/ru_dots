function Trig_Nue01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0M1'
endfunction

function Trig_Nue01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real nmdamage = 0.0
    set udg_SK_nue_nightmare_insc = udg_SK_nue_nightmare_insc - 1
    if udg_SK_nue_nightmare_insc == 0 then
        call DestroyEffect(LoadEffectHandle(udg_ht, GetHandleId(caster), 1))
        set udg_SK_nue_nightmare_buff = 0
        set nmdamage = NueDamageCounting(caster) * 1.0
        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 6.0, "|cffffcc00Nightmare of Heiankyou|r bonus damage: |cff9999ff" + R2S(nmdamage) + "|r")
    endif
    call ReleaseTimer(t)
    set t = null
    set caster = null
endfunction

function Trig_Nue01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local real nmdamage = 0.0
    local real time = 12.0
    if udg_SK_nue_nightmare_buff == 0 then
        call SaveEffectHandle(udg_ht, GetHandleId(caster), 1, AddSpecialEffectTarget("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", caster, "hand left"))
    endif
    set udg_SK_nue_nightmare_buff = udg_SK_nue_nightmare_buff + 1
    set udg_SK_nue_nightmare_insc = udg_SK_nue_nightmare_insc + 1
    set nmdamage = NueDamageCounting(caster) * 1.0
    call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 6.0, "|cffffcc00Nightmare of Heiankyou|r bonus damage: |cff9999ff" + R2S(nmdamage) + "|r")
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, time, false, function Trig_Nue01_Clear)
    set t = null
    set caster = null
endfunction

function InitTrig_Nue01 takes nothing returns nothing
endfunction