function Trig_Setting_Character_C_Actions takes nothing returns nothing
    local integer i = 200
    local hashtable db = udg_HeroDatabase
    set i = i + 1
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Mugetsu.blp"
    set udg_HeroButton[i] = 'B02T'
    set udg_HeroBrief[i] = ""
    call AI_HeroSkill(i, 'A0UC', 'A0UB', 'A0UG', 'A03Y', 'A0UH')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroType[200] = i - 200
    set db = null
endfunction

function InitTrig_Setting_Character_C takes nothing returns nothing
    set gg_trg_Setting_Character_C = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Character_C, function Trig_Setting_Character_C_Actions)
endfunction