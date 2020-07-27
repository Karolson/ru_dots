function Trig_Merlin01_DeSurice_Conditions takes nothing returns boolean
    if GetIssuedOrderIdBJ() == OrderId("attack") then
        return false
    endif
    return GetUnitAbilityLevel(GetTriggerUnit(), 'A0Z1') >= 1
endfunction

function Trig_Merlin01_DeSurice_Actions takes nothing returns nothing
    local unit caster = udg_SK_Merlin
    local unit target = GetTriggerUnit()
    call IssueTargetOrderById(target, 851983, caster)
    set caster = null
    set target = null
endfunction

function InitTrig_Merlin01_DeSurice takes nothing returns nothing
endfunction