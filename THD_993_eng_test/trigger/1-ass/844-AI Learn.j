function Trig_AI_Learn_Actions takes nothing returns nothing
    local unit h = GetTriggerUnit()
    call AI_LearnSkill(h)
    if AIDIFF(h) == 0 then
    elseif AIDIFF(h) == 1 then
        call SetHeroStr(h, GetHeroStr(h, false) + GetRandomInt(0, 2), true)
        call SetHeroAgi(h, GetHeroAgi(h, false) + GetRandomInt(0, 2), true)
        call SetHeroInt(h, GetHeroInt(h, false) + GetRandomInt(0, 2), true)
    elseif AIDIFF(h) == 2 then
        call SetHeroStr(h, GetHeroStr(h, false) + GetRandomInt(0, 6), true)
        call SetHeroAgi(h, GetHeroAgi(h, false) + GetRandomInt(0, 6), true)
        call SetHeroInt(h, GetHeroInt(h, false) + GetRandomInt(0, 6), true)
    endif
    set h = null
endfunction

function InitTrig_AI_Learn takes nothing returns nothing
endfunction