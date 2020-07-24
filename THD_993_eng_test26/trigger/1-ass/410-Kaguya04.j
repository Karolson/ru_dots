function s__kaguya03_onPeriodic takes nothing returns nothing
    local integer k = udg_s__kaguya03_next[0]
    local unit u
    loop
    exitwhen k == 0
        call GroupEnumUnitsInRange(udg_s__kaguya03_enum, GetUnitX(udg_s__kaguya03_source[k]), GetUnitY(udg_s__kaguya03_source[k]), udg_Kaguya03ManaDamageRangeBase + (GetUnitAbilityLevel(udg_s__kaguya03_source[k], udg_Kaguya03) - 1) * udg_Kaguya03ManaDamageRangeInc, null)
        loop
            set u = FirstOfGroup(udg_s__kaguya03_enum)
        exitwhen u == null
            call GroupRemoveUnit(udg_s__kaguya03_enum, u)
            if IsUnitType(u, UNIT_TYPE_HERO) and IsUnitEnemy(u, udg_s__kaguya03_p[k]) and GetWidgetLife(u) > 0.405 then
                if GetUnitState(u, UNIT_STATE_MANA) > 2 then
                    call UnitManaingTarget(udg_s__kaguya03_source[k], u, -0.3 * GetHeroInt(u, true))
                else
                    call UnitMagicDamageTarget(udg_s__kaguya03_source[k], u, -0.3 * GetHeroInt(u, true), 2)
                endif
            endif
        endloop
        set k = udg_s__kaguya03_next[k]
    endloop
endfunction

function s__kaguya03_create takes unit source returns integer
    local integer k = s__kaguya03__allocate()
    set udg_s__kaguya03_source[k] = source
    set udg_s__kaguya03_p[k] = GetOwningPlayer(source)
    if udg_s__kaguya03_next[0] != 0 then
        set udg_s__kaguya03_prev[udg_s__kaguya03_next[0]] = k
    else
        call TimerStart(udg_s__kaguya03_tm, 1.0, true, function s__kaguya03_onPeriodic)
    endif
    set udg_s__kaguya03_next[k] = udg_s__kaguya03_next[0]
    set udg_s__kaguya03_next[0] = k
    set udg_s__kaguya03_prev[k] = 0
    return k
endfunction

function Kaguya03_onLearn takes nothing returns boolean
    if GetLearnedSkill() == udg_Kaguya03 and GetLearnedSkillLevel() == 1 then
        call s__kaguya03_create(GetTriggerUnit())
    endif
    return false
endfunction

function KAGUYA04_MARKER takes nothing returns integer
    return 'A0LN'
endfunction

function Trig_Kaguya04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0SQ'
endfunction

function Trig_Kaguya04_RemoveEffect_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    call RemoveUnit(u)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set u = null
endfunction

function Trig_Kaguya04_RemoveEffect takes unit u returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitTimeScale(u, 0.01)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call TimerStart(t, 3.0, false, function Trig_Kaguya04_RemoveEffect_Clear)
    set t = null
endfunction

function Trig_Kaguya04_Stuning_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v = LoadUnitHandle(udg_ht, task, 0)
    if v != null then
        call PauseUnit(v, false)
        call SetUnitInvulnerable(v, false)
        call SetUnitTimeScale(v, 1.0)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set v = null
endfunction

function Trig_Kaguya04_Stuning takes unit caster, unit v, integer level returns nothing
    call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 10 + level * 100, 2.2), 5)
    call UnitStunTarget(caster, v, 1.5 + level * 0.5, 0, 0)
    call UnitSlowTarget(caster, v, 1.5 + level * 0.5, 'A0LN', 0)
    call UnitSlowTarget(caster, v, 1.5 + level * 0.5, 'A0I9', 0)
    call ChangeUnitColor(v, 50, 50, 50, 1.5 + level * 0.5)
endfunction

function Trig_Kaguya04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit u
    local unit v
    local group g
    local integer i
    local integer j
    local integer k
    local integer R
    local integer G
    local integer B
    local boolexpr iff
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 160 - 20 * level)
    call VE_Spellcast(caster)
    call AttachSoundToUnit(gg_snd_CityBuildingDeath1, caster)
    call SetSoundVolume(gg_snd_CityBuildingDeath1, 127)
    call StartSound(gg_snd_CityBuildingDeath1)
    call UnitMagicDamageTarget(caster, caster, GetUnitState(caster, UNIT_STATE_LIFE) * 0.4, 1)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04U', ox, oy, GetRandomInt(1, 360))
    call SetUnitVertexColor(u, 255, 255, 255, 125)
    if level == 1 then
        call SetUnitScale(u, 6, 6, 6)
        set k = 18
    elseif level == 2 then
        call SetUnitScale(u, 7.2, 7.2, 7.2)
        set k = 27
    else
        call SetUnitScale(u, 8.6, 8.6, 8.6)
        set k = 36
    endif
    call Trig_Kaguya04_RemoveEffect(u)
    set i = 0
    loop
        set u = CreateUnit(GetOwningPlayer(caster), 'n04T', ox + (350 + level * 100) * CosBJ(i * (360 / k)), oy + (350 + level * 100) * SinBJ(i * (360 / k)), GetRandomInt(1, 360))
        set j = GetRandomInt(0, 6)
        set R = udg_SK_Kaguya01_RGB[j * 3 + 0]
        set G = udg_SK_Kaguya01_RGB[j * 3 + 1]
        set B = udg_SK_Kaguya01_RGB[j * 3 + 2]
        call SetUnitVertexColor(u, R, G, B, 95)
        call Trig_Kaguya04_RemoveEffect(u)
        set i = i + 1
    exitwhen i == k
    endloop
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, ox, oy, 350 + level * 100, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call Trig_Kaguya04_Stuning(caster, v, level)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Kaguya04 takes nothing returns nothing
endfunction