function Trig_Setting_Character_A_Actions takes nothing returns nothing
    local integer i = 0
    local hashtable db = udg_HeroDatabase
    set i = i + 1
    set udg_HeroType[i] = 'H001'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_reimu.blp"
    set udg_HeroButton[i] = 'B01I'
    set udg_HeroBrief[i] = "|cffffcc00Hakurei Reimu|r\n|cff00aaff|r Mage, support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A048', 'A049', 'A04B', 'A04A', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Reimu
    set udg_HeroCloth02Init[i] = gg_trg_Initial_ReimuMother
    set i = i + 1
    set udg_HeroType[i] = 'H000'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_marisa.blp"
    set udg_HeroButton[i] = 'B01V'
    set udg_HeroBrief[i] = "|cffffcc00Kirisame Marisa|r\n|cffff00ff|r Mage, fighter, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A042', 'A041', 'A03Z', 'A03Y', 'A040')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 25)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Marisa
    set i = i + 1
    set udg_HeroType[i] = 'E00F'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_yukari.blp"
    set udg_HeroButton[i] = 'B01M'
    set udg_HeroBrief[i] = "|cffffcc00Yakumo Yukari|r\n|cffff00ff|r Mage, fighter, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A04J', 'A04L', 'A04N', 'A03Y', 'A04M')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 3)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Yukari
    set i = i + 1
    set udg_HeroType[i] = 'E00G'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Ran.blp"
    set udg_HeroButton[i] = 'B01N'
    set udg_HeroBrief[i] = "|cffffcc00Yakumo Ran|r\n|cff00ff00|r Support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0EG', 'A08M', 'A0EH', 'A03Y', 'A0EE')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Ran
    set i = i + 1
    set udg_HeroType[i] = 'E01I'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Chen.blp"
    set udg_HeroButton[i] = 'B02L'
    set udg_HeroBrief[i] = "|cffffcc00Chen|r\n|cffff0000|r Fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0LP', 'A0TM', 'A0TN', 'A0TO', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 3)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 41)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Orange
    set i = i + 1
    set udg_HeroType[i] = 'E009'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Cirno.blp"
    set udg_HeroButton[i] = 'B00J'
    set udg_HeroBrief[i] = "|cffffcc00Cirno|r\n|cffaaaa00|r Professional, melee (STR)\n|cffccccccDifficulty for newbies: ⑨○○○○|r"
    call AI_HeroSkill(i, 'A06E', 'A06G', 'A06H', 'A03Y', 'A0MV')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Cirno
    set i = i + 1
    set udg_HeroType[i] = 'E02Y'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Akyuu.blp"
    set udg_HeroButton[i] = 'B033'
    set udg_HeroBrief[i] = "|cffffcc00Hieda no Akyuu|r\n|cff00ff00|r Support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0R8', 'A0R9', 'A0RA', 'A0RB', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 41)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initialing_Akyu
    set i = i + 1
    set udg_HeroType[i] = 'E02E'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Tokiko.blp"
    set udg_HeroButton[i] = 'B02W'
    set udg_HeroBrief[i] = "|cffffcc00Tokiko|r\n|cffffaa00|r Fighter, tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0R8', 'A0R9', 'A0RA', 'A0RB', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initialing_Tokiko
    set i = i + 1
    set udg_HeroType[i] = 'E00X'
    set udg_HeroCloth01[i] = 'E03D'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Umbrella.blp"
    set udg_HeroButton[i] = 'B018'
    set udg_HeroBrief[i] = "|cffffcc00Tatara Kogasa|r\n|cff999999|r Assassin, carry, melee (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A0C7', 'A0LS', 'A0C3', 'A0C8', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Umbrella
    set i = i + 1
    set udg_HeroType[i] = 'E01A'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Keine.blp"
    set udg_HeroButton[i] = 'B02G'
    set udg_HeroBrief[i] = "|cffffcc00Kamishirasawa Keine|r\n|cffffccff|r Fighter, support, melee (INT)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A0M8', 'A0M9', 'A0MA', 'A0MB', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, 'E01B', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'E01B', 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, 'E01B', 'BSAB', 30)
    call SaveInteger(udg_HeroDatabase, 'E01B', 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, 'E01B', 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Keine
    set i = i + 1
    set udg_HeroType[i] = 'N00J'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_mokou.blp"
    set udg_HeroButton[i] = 'B017'
    set udg_HeroBrief[i] = "|cffffcc00Fujiwara no Mokou|r\n|cffff0000|r Fighter, melee (STR)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    set udg_HeroCloth01[i] = 'N04L'
    call AI_HeroSkill(i, 'A059', 'A04W', 'A052', 'A03Y', 'A04U')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Mokou
    set i = i + 1
    set udg_HeroType[i] = 'H00N'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_letty.blp"
    set udg_HeroButton[i] = 'B01P'
    set udg_HeroBrief[i] = "|cffffcc00Letty Whiterock|r\n|cffaaaaff|r Mage, tank, ranged (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A08W', 'A092', 'A08Q', 'A08P', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Letty
    set i = i + 1
    set udg_HeroType[i] = 'U006'
    set udg_HeroButton[i] = 'B00Z'
    set udg_HeroBrief[i] = "|cffffcc00Saigyouji Yuyuko|r\n|cff0000ff|r Mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_yuyuko.blp"
    call AI_HeroSkill(i, 'A05D', 'A05B', 'A05E', 'A03Y', 'A05C')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Yuyuko
    set i = i + 1
    set udg_HeroType[i] = 'O00B'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_youmu.blp"
    set udg_HeroButton[i] = 'B016'
    set udg_HeroBrief[i] = "|cffffcc00Konpaku Youmu|r\n|cffff0000|r Fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A05Y', 'A064', 'A065', 'A03Y', 'A05X')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Youmu
    set udg_HeroCloth03Init[i] = gg_trg_Initial_YoumuN
    set i = i + 1
    set udg_HeroType[i] = 'E01N'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Lunasa.BLP"
    set udg_HeroButton[i] = 'B02M'
    set udg_HeroBrief[i] = "|cffffcc00Lunasa Prismriver|r\n|cffccccff|r Mage, carry, ranged (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0LM', 'A0OI', 'A0OG', 'A0OH', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Lunasa
    set i = i + 1
    set udg_HeroType[i] = 'E01W'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNMerlin.blp"
    set udg_HeroButton[i] = 'B02R'
    set udg_HeroBrief[i] = "|cffffcc00Merlin Prismriver|r\n|cffaaaa00|r Tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0O3', 'A0RS', 'A0RX', 'A03Y', 'A0RZ')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Init_Merlin
    set i = i + 1
    set udg_HeroType[i] = 'E020'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNLyrica.blp"
    set udg_HeroButton[i] = 'B02S'
    set udg_HeroBrief[i] = "|cffffcc00Lyrica Prismriver|r\n|cffffccff|r Fighter, support, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0O3', 'A0RS', 'A0RX', 'A03Y', 'A0RZ')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Lyrica
    set i = i + 1
    set udg_HeroType[i] = 'H029'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNDaiyousei.blp"
    set udg_HeroButton[i] = 'B035'
    set udg_HeroBrief[i] = "|cffffcc00Daiyousei|r\n|cffffccff|r Fighter, support, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A06E', 'A06G', 'A06H', 'A03Y', 'A0MV')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Daiyousei
    set i = i + 1
    set udg_HeroType[i] = 'O00J'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Remilia.blp"
    set udg_HeroButton[i] = 'B01O'
    set udg_HeroBrief[i] = "|cffffcc00Remilia Scarlet|r\n|cffaaaaff|r Mage, tank, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0CI', 'A0CD', 'A0CH', 'A0CG', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Remilia
    set i = i + 1
    set udg_HeroType[i] = 'E000'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_sakuya.blp"
    set udg_HeroButton[i] = 'B00F'
    set udg_HeroBrief[i] = "|cffffcc00Izayoi Sakuya|r\n|cffccccff|r Mage, carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    set udg_HeroCloth01[i] = 'E02D'
    call AI_HeroSkill(i, 'A09C', 'A04H', 'A099', 'A03Y', 'A09A')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Sakuya
    set i = i + 1
    set udg_HeroType[i] = 'U007'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Flandre.blp"
    set udg_HeroButton[i] = 'B00U'
    set udg_HeroBrief[i] = "|cffffcc00Flandre Scarlet|r\n|cffccccff|r Carry, pusher, melee (AGI)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A06J', 'A06L', 'A06K', 'A03Y', 'A06M')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'U00Z', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'U00Z', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'U00Z', 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, 'U00Z', 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, 'U00Z', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Flandre
    set i = i + 1
    set udg_HeroType[i] = 'U00N'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNpatchouli.blp"
    set udg_HeroButton[i] = 'B014'
    set udg_HeroBrief[i] = "|cffffcc00Patchouli Knowledge|r\n|cff0000ff|r Mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0FV', 'A0FZ', 'A0FY', 'A03Y', 'A0FX')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initialing_Pachili
    set i = i + 1
    set udg_HeroType[i] = 'E013'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNmeirin.blp"
    set udg_HeroButton[i] = 'B011'
    set udg_HeroBrief[i] = "|cffffcc00Hong Meiling|r\n|cffaaaa00|r Tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    set udg_HeroCloth01[i] = 'E03J'
    call AI_HeroSkill(i, 0, 0, 0, 0, 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Init_Meirin
    set i = i + 1
    set udg_HeroType[i] = 'E01E'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Koakuma.blp"
    set udg_HeroButton[i] = 'B02K'
    set udg_HeroBrief[i] = "|cffffcc00Koakuma|r\n|cff0000ff|r Mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A0MT', 'A0NI', 'A0NJ', 'A0NH', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 42)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Koakuma
    set i = i + 1
    set udg_HeroType[i] = 'O009'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNutsuho.blp"
    set udg_HeroButton[i] = 'B01L'
    set udg_HeroBrief[i] = "|cffffcc00Reiuji Utsuho|r\n|cffaaaaff|r Mage, tank, ranged (STR)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A0QN', 'A07B', 'A079', 'A076', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Utsuho
    set i = i + 1
    set udg_HeroType[i] = 'E00W'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Rin.blp"
    set udg_HeroButton[i] = 'B01J'
    set udg_HeroBrief[i] = "|cffffcc00Kaenbyou Rin|r\n|cffffcc00|r Pusher, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0BO', 'A0BH', 'A0BM', 'A03Y', 'A0BP')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Cat
    set i = i + 1
    set udg_HeroType[i] = 'E015'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNsatori.blp"
    set udg_HeroButton[i] = 'B022'
    set udg_HeroBrief[i] = "|cffffcc00Komeiji Satori|r\n|cff0000ff|r Mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0IZ', 'A0IW', 'A0IY', 'A0IX', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Satori
    set i = i + 1
    set udg_HeroType[i] = 'E010'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNkoishi.blp"
    set udg_HeroButton[i] = 'B01C'
    set udg_HeroBrief[i] = "|cffffcc00Komeiji Koishi|r\n|cffcccccc|r Carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A0GT', 'A0DY', 'A0ZC', 'A0ZB', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 25)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'E011', 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, 'E011', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'E011', 'BSAB', 20)
    call SaveInteger(udg_HeroDatabase, 'E011', 'BSAU', 25)
    call SaveInteger(udg_HeroDatabase, 'E011', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Koishi
    set i = i + 1
    set udg_HeroType[i] = 'E01U'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Parsee.blp"
    set udg_HeroButton[i] = 'B02O'
    set udg_HeroBrief[i] = "|cffffcc00Mizuhashi Parsee|r\n|cff0000ff|r Mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -200)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call AI_HeroSkill(i, 'A0PM', 'A0PO', 'A0RO', 'A03Q', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Parsee
    set i = i + 1
    set udg_HeroType[i] = 'H00K'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Yuugi.blp"
    set udg_HeroButton[i] = 'B012'
    set udg_HeroBrief[i] = "|cffffcc00Hoshiguma Yuugi|r\n|cffaaaa00|r Tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A08D', 'A08B', 'A08A', 'A08C', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Yuugi
    set i = i + 1
    set udg_HeroType[i] = 'O008'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Spider.blp"
    set udg_HeroButton[i] = 'B01W'
    set udg_HeroBrief[i] = "|cffffcc00Kurodani Yamame|r\n|cffffff00|r Fighter, pusher, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A08F', 'A08I', 'A08J', 'A08E', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 49)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Spider
    set i = i + 1
    set udg_HeroType[i] = 'E01V'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Kisume.blp"
    set udg_HeroButton[i] = 'B02P'
    set udg_HeroBrief[i] = "|cffffcc00Kisume|r\n|cffffaa00|r Fighter, tank, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A0R8', 'A0R9', 'A0RA', 'A0RB', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initialing_Kisume
    set i = i + 1
    set udg_HeroType[i] = 'E02J'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Miko.blp"
    set udg_HeroButton[i] = 'B02Z'
    set udg_HeroBrief[i] = "|cffffcc00Toyosatomimi no Miko|r\n|cffff0000|r Mage, tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A183', 'A185', 'A186', 'A187', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initialing_Miko
    set i = i + 1
    set udg_HeroType[i] = 'H026'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Soga.blp"
    set udg_HeroButton[i] = 'B031'
    set udg_HeroBrief[i] = "|cffffcc00Soga no Tojiko|r\n|cff0000ff|r Mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 36)
    call AI_HeroSkill(i, 'A0IZ', 'A0IW', 'A0IY', 'A0IX', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initialing_Soga
    set i = i + 1
    set udg_HeroType[i] = 'H02I'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Futo.blp"
    set udg_HeroButton[i] = 'B02T'
    set udg_HeroBrief[i] = "|cffffcc00Mononobe no Futo|r\n|cffff0000|r Specific mage, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A0UC', 'A0UG', 'A0ND', 'A0UB', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 25)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 25)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initialing_Futo
    set i = i + 1
    set udg_HeroType[i] = 'H01Z'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Renko.blp"
    set udg_HeroButton[i] = 'B02Y'
    set udg_HeroBrief[i] = "|cffffcc00Usami Renko|r\n|cffff0000|r Fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A12Q', 'A12R', 'A12S', 'A14D', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initialing_Renko
    set i = i + 1
    set udg_HeroType[i] = 'U00J'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_komachi.blp"
    set udg_HeroButton[i] = 'B019'
    set udg_HeroBrief[i] = "|cffffcc00Onozuka Komachi|r\n|cffaaaa00|r Tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A0CJ', 'A0CL', 'A0CM', 'A03Y', 'A0CK')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 41)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Komachi
    set i = i + 1
    set udg_HeroType[i] = 'E00V'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNshikieiki.blp"
    set udg_HeroButton[i] = 'B013'
    set udg_HeroBrief[i] = "|cffffcc00Shiki Eiki, Yamaxanadu|r\n|cffccccff|r Carry, ranged (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0B7', 'A0B9', 'A03Y', 'A00K', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 32)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Shikieiki
    set i = i + 1
    set udg_HeroType[i] = 'O01B'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNSatsuki Rin.blp"
    set udg_HeroButton[i] = 'B03B'
    set udg_HeroBrief[i] = "|cffffcc00Satsuki Rin|r\n|cffffffcc|r Mage, assassin, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A069', 'A0GT', 'A066', 'A06D', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -200)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Satsuki
    set i = i + 1
    set udg_HeroType[i] = 'H02E'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_ReimuMother.blp"
    set udg_HeroButton[i] = 'B00E'
    set udg_HeroBrief[i] = "|cffffcc00Minako Kazue Hakurei|r\n|cff00aaff|r Hybrid, Specialist (INT)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A048', 'A049', 'A04B', 'A04A', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_ReimuMother
    set i = i + 1
    set udg_HeroType[i] = 'H02K'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNseiga.blp"
    set udg_HeroButton[i] = 'B00P'
    set udg_HeroBrief[i] = "|cffffcc00Kaku Seiga|r\n|cff00aaff|r Support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initialing_Seiga
    set i = i + 1
    set udg_HeroType[i] = 'O019'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Makoto.blp"
    set udg_HeroButton[i] = 'B026'
    set udg_HeroBrief[i] = "|cffffcc00Youmu (Komajou Densetsu Ver.)|r\n|cff00aaff|r Fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_YoumuNew
    set i = i + 1
    set udg_HeroType[i] = 'U013'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Sirius.blp"
    set udg_HeroButton[i] = 'B025'
    set udg_HeroBrief[i] = "|cffffcc00Komachi (Serious)|r\n|cff00aaff|r Tank. melee (STR)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 41)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_KomachiN
    set udg_HeroType[0] = i
    set db = null
endfunction

function InitTrig_Setting_Character_A takes nothing returns nothing
    set gg_trg_Setting_Character_A = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Character_A, function Trig_Setting_Character_A_Actions)
endfunction