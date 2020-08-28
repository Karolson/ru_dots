function Trig_About_MapActions takes nothing returns nothing
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "Attention!", "Be tolerant of newbies.\r\nDotS is a game for civilized people.", "WAR3MAPPREVIEW.tga")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "Russian Dots Production team", "===Current Members===\r\nKarolson：Working on game balance.\r\nFaiWei：Working on translation of the rest of the map.\r\nEternal memory to all the other people who worked on this map.", "WAR3MAPPREVIEW.tga")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "Russian DotS Community", "Site: thdots.ru \r\nChinese site on which the map used to live: jiecao.cc\r\n More modern chinese site: bbs.nyasama.com |r", "ReplaceableTextures\\CommandButtons\\BTN_Shizuha.blp")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "Here was the information about the Chinese dots room 1\r\nAnd here was the information about the Chinese dots room 2")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "Here was the information about the Chinese dots room 3")
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "Map description", "This is a Touhou themed PvP map, \r\n...(3000 words omitted here)\r\nPS. The strength of all the characters in this map does not represent their strength in the original work.", "ReplaceableTextures\\CommandButtons\\BTN_Houjuu Nue.blp")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "Versions before 1.0 are in production and testing")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "If you find a bug, please explain to the production team and do not discuss the bug in any public place.")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "If the quality of the model displayed in the game is not clear enough, it is recommended that you use the external package version map.\r\nIf you cannot see the model in the game, please check the Readme text description in the external package.")
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "Touhou Project Introduction", "Touhou project is a series of games created by the japanese indie team Team Shanghai Alice (they mostly work on danmaku games) and some related teams.\r\nDetails can be found on Google: \r\nTouhou Project", "ReplaceableTextures\\CommandButtons\\BTN_marisa.blp")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "Creator: ZUN")
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "Player commands", "-ms Check current movement speed\r\n-as Check current attack speed\r\n-gr Check current magic resistance value\r\n-dev Lasthit count and gold income\r\n-veon Turn on advanced effects\r\n-veoff Turn off advanced effects\r\n-onword Turn on damage display\r\n-offword Turn off damage display\r\n-df Suicide after 20 seconds, can be used when stuck\r\n-cam <number> Set camera zoom\r\n-auras Toggle team auras\r\n-urd Vote for surrender\r\n-disurd Cancel surrender vote\r\n-dr Vote for draw\r\n-disdr Cancel draw vote\r\n-wi Weather info\r\n-custombgm Play file that lies in game directory THDotS\\custom.mp3\r\n-regen Show MP and HP regen\r\n-areashow <number> Show circle around girl with <number> range\r\n-areaoff Hide circle around character\r\n-fol Camera will follow your girl\r\n-foloff Disable camera follow", "ReplaceableTextures\\CommandButtons\\BTNitemMagicGuideBook.blp")
    call CreateQuestItemBJ(GetLastCreatedQuestBJ(), "Write commands in the chat to achieve the described result.")
endfunction

function InitTrig_About_Map takes nothing returns nothing
    set gg_trg_About_Map = CreateTrigger()
    call TriggerAddAction(gg_trg_About_Map, function Trig_About_MapActions)
endfunction