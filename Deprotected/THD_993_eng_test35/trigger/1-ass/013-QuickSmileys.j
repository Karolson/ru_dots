function Trig_QuickSmileys_Conditions takes nothing returns boolean
    call ExecuteFunc("CardStatShow")
    return not udg_Smileys[GetPlayerId(GetTriggerPlayer())]
endfunction

function Trig_QuickSmileys_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    local integer j = udg_SmileysLast[i]
    local effect e
    local string s
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set udg_Smileys[i] = true
    if j == 1 then
        set s = "smileys_smile.mdx"
    elseif j == 2 then
        set s = "smileys_sweat.mdx"
    elseif j == 3 then
        set s = "smileys_sohard.mdx"
    elseif j == 4 then
        set s = "smileys_poor.mdx"
    elseif j == 5 then
        set s = "smileys_dot.mdx"
    elseif j == 6 then
        set s = "smileys_cry.mdx"
    elseif j == 7 then
        set s = "smileys_crazy.mdx"
    elseif j == 8 then
        set s = "smileys_anger.mdx"
    elseif j == 9 then
        set s = "smileys_9.mdx"
    elseif j == 10 then
        set s = "smileys_bug.mdx"
    elseif j > 10 then
        set s = ""
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 4.0, "|cff00ccffEnter -s + number (eg:-s1)|r\r\n|cffffcc00 1. laugh 2. sweat 3. hard 4. weak 5. point|r\r\n|cffffcc00 6. cry 7. chaos 8. anger 9. nineball 10.BUG|r\r\n|Press the ESC key to quickly show recently used emoticons|r")
    endif
    set e = AddSpecialEffectTarget(s, udg_PlayerHeroes[i], "overhead")
    call SaveEffectHandle(udg_ht, task, 0, e)
    call SaveInteger(udg_ht, task, 1, i)
    call TimerStart(t, 4.0, false, function ClearSmiley)
    set t = null
    set s = ""
    set e = null
endfunction

function InitTrig_QuickSmileys takes nothing returns nothing
    local integer i = 0
    set gg_trg_QuickSmileys = CreateTrigger()
    loop
    exitwhen i > 10
        call TriggerRegisterPlayerEvent(gg_trg_QuickSmileys, Player(i), EVENT_PLAYER_END_CINEMATIC)
        set i = i + 1
        if i == 5 then
            set i = i + 1
        endif
    endloop
    call TriggerAddCondition(gg_trg_QuickSmileys, Condition(function Trig_QuickSmileys_Conditions))
    call TriggerAddAction(gg_trg_QuickSmileys, function Trig_QuickSmileys_Actions)
endfunction