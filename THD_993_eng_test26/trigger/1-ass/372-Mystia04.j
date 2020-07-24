function Trig_Mystia04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0DN'
endfunction

function Mysita04_SlightSet takes player p, boolean bool returns nothing
    local integer i = 1
    loop
    exitwhen i >= 16
        if IsPlayerAlly(ConvertedPlayer(i), p) and ConvertedPlayer(i) != p then
            call SetPlayerAlliance(ConvertedPlayer(i), p, ALLIANCE_SHARED_VISION, bool)
        endif
        set i = i + 1
    endloop
endfunction

function Trig_Mystia04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    call DisplayCineFilter(false)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call EnableTrigger(gg_trg_Mystia04)
    set t = null
endfunction

function Trig_Mystia04_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i
    local unit v
    call TimerStart(t, 0.5, false, function Trig_Mystia04_Clear)
    set i = 0
    loop
        set v = udg_PlayerHeroes[i]
        if LoadBoolean(udg_ht, task, i) then
            call UnitRemoveAbility(v, 'A10H')
            call UnitRemoveAbility(v, 'A0VW')
            call Mysita04_SlightSet(GetOwningPlayer(v), true)
            if GetPlayerId(GetLocalPlayer()) == i and false then
                call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\Black_mask.blp")
                call SetCineFilterBlendMode(BLEND_MODE_BLEND)
                call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
                call SetCineFilterStartUV(0, 0, 1, 1)
                call SetCineFilterEndUV(0, 0, 1, 1)
                call SetCineFilterStartColor(0, 0, 0, 255)
                call SetCineFilterEndColor(0, 0, 0, 0)
                call SetCineFilterDuration(0.5)
                call EnablePreSelect(true, true)
            endif
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    set t = null
    set v = null
endfunction

function Trig_Mystia04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit v
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer i
    local real time = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call AbilityCoolDownResetion(caster, 'A0DN', 190 - level * 20)
    call VE_Spellcast(caster)
    set u = NewDummy(GetOwningPlayer(caster), ox, oy, 270.0)
    call UnitAddAbility(u, 'A0JO')
    call GroupEnumUnitsInRange(g, ox, oy, 800.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false then
            if udg_NewDebuffSys then
                call UnitSlowTargetAspd(caster, v, 35, 2.5 + 0.5 * level, 2, 0)
                call UnitSlowTargetMspd(caster, v, 50, 2.5 + 0.5 * level, 2, 0)
            else
                call UnitSlowTarget(caster, v, 2.5 + 0.5 * level, 'A11D', 'B04Z')
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitMagicDamageArea(caster, ox, oy, 600, 25 + 75 * level + 1.8 * GetHeroInt(caster, true), 5)
    call SetUnitScale(u, 2.0, 2.0, 2.0)
    set i = 0
    loop
    exitwhen i >= 36
        set px = ox + 133.3 * CosBJ(10.0 * i)
        set py = oy + 133.3 * SinBJ(10.0 * i)
        call IssuePointOrder(u, "breathoffrost", px, py)
        set i = i + 1
    endloop
    call SetUnitScale(u, 1.0, 1.0, 1.0)
    call UnitRemoveAbility(u, 'A0JO')
    call ReleaseDummy(u)
    if true then
        call DisableTrigger(gg_trg_Mystia04)
        set i = 0
        loop
            set v = udg_PlayerHeroes[i]
            if v != null and GetWidgetLife(v) > 0.405 then
                if IsUnitEnemy(v, GetOwningPlayer(caster)) and IsUnitInRange(caster, v, 600.0) then
                    call SaveBoolean(udg_ht, task, i, true)
                    call UnitAddAbility(v, 'A0VW')
                    call UnitAddAbility(v, 'A10H')
                    call Mysita04_SlightSet(GetOwningPlayer(v), false)
                    if GetPlayerId(GetLocalPlayer()) == i and false then
                        call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\Black_mask.blp")
                        call SetCineFilterBlendMode(BLEND_MODE_BLEND)
                        call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
                        call SetCineFilterStartUV(0, 0, 1, 1)
                        call SetCineFilterEndUV(0, 0, 1, 1)
                        call SetCineFilterStartColor(0, 0, 0, 0)
                        call SetCineFilterEndColor(0, 0, 0, 255)
                        call SetCineFilterDuration(0.2)
                        call DisplayCineFilter(true)
                        call EnablePreSelect(false, false)
                    endif
                else
                    call SaveBoolean(udg_ht, task, i, false)
                endif
            endif
            set i = i + 1
        exitwhen i >= 12
        endloop
        call TimerStart(t, 2.5 + 0.5 * level, false, function Trig_Mystia04_Fade)
    endif
    set caster = null
    set t = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Mystia04 takes nothing returns nothing
endfunction