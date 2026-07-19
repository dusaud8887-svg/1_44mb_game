Achievement = function(arg0, arg1, arg2, arg3 = {}, arg4, arg5 = [2408, 500], arg6 = "general") constructor
{
    id = arg0;
    OnSet = arg2;
    name = arg1.achievementName;
    achievementIcon = variable_struct_exists(arg1, "achievementIcon") ? arg1.achievementIcon : 2173;
    achievementName = arg1.achievementName;
    achievementDescription = variable_struct_exists(arg1, "achievementDescription") ? arg1.achievementDescription : global.TextContainer.stockTooltip.selectedLanguage;
    achievementID = arg0;
    unlocked = false;
    reward = arg5;
    flags = arg3;
    achievementNumber = arg4;
    category = arg6;
    
    function Check(arg0 = {})
    {
        if (!unlocked)
        {
            if (OnSet != undefined)
            {
                self.OnSet(self, arg0);
                if (unlocked)
                {
                    obj_Achievements.PopAchievement(self);
                    if (is_array(reward))
                    {
                        ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + reward[1]);
                    }
                    SavePlayerSave();
                }
            }
        }
    }
    
    function CheckPrevious()
    {
    }
};

show_debug_message("setting achievements");
if (!variable_global_exists("achievementsMap"))
{
    ACHIEVEMENTS = ds_map_create();
}
else
{
    ds_map_destroy(global.achievementsMap);
    global.achievementsMap = -1;
    show_debug_message("destroyed previous ach");
    ACHIEVEMENTS = ds_map_create();
}
var orderNum = 0;

var OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

var Flags = {};
ds_map_set(ACHIEVEMENTS, "ameClear", new Achievement("ameClear", 
{
    achievementName: global.TextContainer.a_ameClearName.selectedLanguage,
    achievementIcon: 1760,
    achievementDescription: global.TextContainer.a_ameClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ameGachikoi", new Achievement("ameGachikoi", 
{
    achievementName: global.TextContainer.a_ameGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_ameGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "guraClear", new Achievement("guraClear", 
{
    achievementName: global.TextContainer.a_guraClearName.selectedLanguage,
    achievementIcon: 239,
    achievementDescription: global.TextContainer.a_guraClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "guraGachikoi", new Achievement("guraGachikoi", 
{
    achievementName: global.TextContainer.a_guraGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_guraGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ina10", new Achievement("ina10", 
{
    achievementName: global.TextContainer.a_ina10Name.selectedLanguage,
    achievementIcon: 1813,
    achievementDescription: global.TextContainer.a_ina10Description.selectedLanguage
}, OnSet, Flags, orderNum, 116, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "inaClear", new Achievement("inaClear", 
{
    achievementName: global.TextContainer.a_inaClearName.selectedLanguage,
    achievementIcon: 344,
    achievementDescription: global.TextContainer.a_inaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "inaGachikoi", new Achievement("inaGachikoi", 
{
    achievementName: global.TextContainer.a_inaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_inaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kiara10", new Achievement("kiara10", 
{
    achievementName: global.TextContainer.a_kiara10Name.selectedLanguage,
    achievementIcon: 2061,
    achievementDescription: global.TextContainer.a_kiara10Description.selectedLanguage
}, OnSet, Flags, orderNum, 268, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kiaraClear", new Achievement("kiaraClear", 
{
    achievementName: global.TextContainer.a_kiaraClearName.selectedLanguage,
    achievementIcon: 2061,
    achievementDescription: global.TextContainer.a_kiaraClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kiaraGachikoi", new Achievement("kiaraGachikoi", 
{
    achievementName: global.TextContainer.a_kiaraGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_kiaraGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "calli10", new Achievement("calli10", 
{
    achievementName: global.TextContainer.a_calli10Name.selectedLanguage,
    achievementIcon: 1485,
    achievementDescription: global.TextContainer.a_calli10Description.selectedLanguage
}, OnSet, Flags, orderNum, 596, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "calliClear", new Achievement("calliClear", 
{
    achievementName: global.TextContainer.a_calliClearName.selectedLanguage,
    achievementIcon: 296,
    achievementDescription: global.TextContainer.a_calliClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "calliGachikoi", new Achievement("calliGachikoi", 
{
    achievementName: global.TextContainer.a_calliGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_calliGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "bae10", new Achievement("bae10", 
{
    achievementName: global.TextContainer.a_bae10Name.selectedLanguage,
    achievementIcon: 187,
    achievementDescription: global.TextContainer.a_bae10Description.selectedLanguage
}, OnSet, Flags, orderNum, 501, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "baeClear", new Achievement("baeClear", 
{
    achievementName: global.TextContainer.a_baeClearName.selectedLanguage,
    achievementIcon: 2021,
    achievementDescription: global.TextContainer.a_baeClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "baeGachikoi", new Achievement("baeGachikoi", 
{
    achievementName: global.TextContainer.a_baeGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_baeGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kroniiClear", new Achievement("kroniiClear", 
{
    achievementName: global.TextContainer.a_kroniiClearName.selectedLanguage,
    achievementIcon: 59,
    achievementDescription: global.TextContainer.a_kroniiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kroniiGachikoi", new Achievement("kroniiGachikoi", 
{
    achievementName: global.TextContainer.a_kroniiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_kroniiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "faunaClear", new Achievement("faunaClear", 
{
    achievementName: global.TextContainer.a_faunaClearName.selectedLanguage,
    achievementIcon: 655,
    achievementDescription: global.TextContainer.a_faunaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "faunaGachikoi", new Achievement("faunaGachikoi", 
{
    achievementName: global.TextContainer.a_faunaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_faunaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "mumeiClear", new Achievement("mumeiClear", 
{
    achievementName: global.TextContainer.a_mumeiClearName.selectedLanguage,
    achievementIcon: 1023,
    achievementDescription: global.TextContainer.a_mumeiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "mumeiGachikoi", new Achievement("mumeiGachikoi", 
{
    achievementName: global.TextContainer.a_mumeiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_mumeiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "sana10", new Achievement("sana10", 
{
    achievementName: global.TextContainer.a_sana10Name.selectedLanguage,
    achievementIcon: 812,
    achievementDescription: global.TextContainer.a_sana10Description.selectedLanguage
}, OnSet, Flags, orderNum, 893, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "sanaClear", new Achievement("sanaClear", 
{
    achievementName: global.TextContainer.a_sanaClearName.selectedLanguage,
    achievementIcon: 478,
    achievementDescription: global.TextContainer.a_sanaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "sanaGachikoi", new Achievement("sanaGachikoi", 
{
    achievementName: global.TextContainer.a_sanaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_sanaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "irys10", new Achievement("irys10", 
{
    achievementName: global.TextContainer.a_irys10Name.selectedLanguage,
    achievementIcon: 1028,
    achievementDescription: global.TextContainer.a_irys10Description.selectedLanguage
}, OnSet, Flags, orderNum, 575, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "irysClear", new Achievement("irysClear", 
{
    achievementName: global.TextContainer.a_irysClearName.selectedLanguage,
    achievementIcon: 1127,
    achievementDescription: global.TextContainer.a_irysClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, 207, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "irysGachikoi", new Achievement("irysGachikoi", 
{
    achievementName: global.TextContainer.a_irysGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_irysGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fubukiClear", new Achievement("fubukiClear", 
{
    achievementName: global.TextContainer.a_fubukiClearName.selectedLanguage,
    achievementIcon: 2354,
    achievementDescription: global.TextContainer.a_fubukiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fubukiGachikoi", new Achievement("fubukiGachikoi", 
{
    achievementName: global.TextContainer.a_fubukiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_fubukiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "mioClear", new Achievement("mioClear", 
{
    achievementName: global.TextContainer.a_mioClearName.selectedLanguage,
    achievementIcon: 1068,
    achievementDescription: global.TextContainer.a_mioClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "mioGachikoi", new Achievement("mioGachikoi", 
{
    achievementName: global.TextContainer.a_mioGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_mioGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "okayuClear", new Achievement("okayuClear", 
{
    achievementName: global.TextContainer.a_okayuClearName.selectedLanguage,
    achievementIcon: 924,
    achievementDescription: global.TextContainer.a_okayuClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "okayuGachikoi", new Achievement("okayuGachikoi", 
{
    achievementName: global.TextContainer.a_okayuGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_okayuGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "korone10", new Achievement("korone10", 
{
    achievementName: global.TextContainer.a_korone10Name.selectedLanguage,
    achievementIcon: 1788,
    achievementDescription: global.TextContainer.a_korone10Description.selectedLanguage
}, OnSet, Flags, orderNum, 1922, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "koroneClear", new Achievement("koroneClear", 
{
    achievementName: global.TextContainer.a_koroneClearName.selectedLanguage,
    achievementIcon: 1578,
    achievementDescription: global.TextContainer.a_koroneClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "koroneGachikoi", new Achievement("koroneGachikoi", 
{
    achievementName: global.TextContainer.a_koroneGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_koroneGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "soraClear", new Achievement("soraClear", 
{
    achievementName: global.TextContainer.a_soraClearName.selectedLanguage,
    achievementIcon: 1575,
    achievementDescription: global.TextContainer.a_soraClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "soraGachikoi", new Achievement("soraGachikoi", 
{
    achievementName: global.TextContainer.a_soraGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_soraGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "azkiClear", new Achievement("azkiClear", 
{
    achievementName: global.TextContainer.a_azkiClearName.selectedLanguage,
    achievementIcon: 1304,
    achievementDescription: global.TextContainer.a_azkiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "azkiGachikoi", new Achievement("azkiGachikoi", 
{
    achievementName: global.TextContainer.a_azkiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_azkiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "robocoClear", new Achievement("robocoClear", 
{
    achievementName: global.TextContainer.a_robocoClearName.selectedLanguage,
    achievementIcon: 1630,
    achievementDescription: global.TextContainer.a_robocoClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "robocoGachikoi", new Achievement("robocoGachikoi", 
{
    achievementName: global.TextContainer.a_robocoGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_robocoGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "suiseiClear", new Achievement("suiseiClear", 
{
    achievementName: global.TextContainer.a_suiseiClearName.selectedLanguage,
    achievementIcon: 145,
    achievementDescription: global.TextContainer.a_suiseiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "suiseiGachikoi", new Achievement("suiseiGachikoi", 
{
    achievementName: global.TextContainer.a_suiseiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_suiseiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "mikoClear", new Achievement("mikoClear", 
{
    achievementName: global.TextContainer.a_mikoClearName.selectedLanguage,
    achievementIcon: 148,
    achievementDescription: global.TextContainer.a_mikoClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "mikoGachikoi", new Achievement("mikoGachikoi", 
{
    achievementName: global.TextContainer.a_mikoGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_mikoGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "haatoClear", new Achievement("haatoClear", 
{
    achievementName: global.TextContainer.a_haatoClearName.selectedLanguage,
    achievementIcon: 2210,
    achievementDescription: global.TextContainer.a_haatoClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "haatoGachikoi", new Achievement("haatoGachikoi", 
{
    achievementName: global.TextContainer.a_haatoGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_haatoGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "melClear", new Achievement("melClear", 
{
    achievementName: global.TextContainer.a_melClearName.selectedLanguage,
    achievementIcon: 643,
    achievementDescription: global.TextContainer.a_melClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "melGachikoi", new Achievement("melGachikoi", 
{
    achievementName: global.TextContainer.a_melGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_melGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "matsuriClear", new Achievement("matsuriClear", 
{
    achievementName: global.TextContainer.a_matsuriClearName.selectedLanguage,
    achievementIcon: 2311,
    achievementDescription: global.TextContainer.a_matsuriClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "matsuriGachikoi", new Achievement("matsuriGachikoi", 
{
    achievementName: global.TextContainer.a_matsuriGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_matsuriGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "akiClear", new Achievement("akiClear", 
{
    achievementName: global.TextContainer.a_akiClearName.selectedLanguage,
    achievementIcon: 262,
    achievementDescription: global.TextContainer.a_akiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "akiGachikoi", new Achievement("akiGachikoi", 
{
    achievementName: global.TextContainer.a_akiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_akiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "chocoClear", new Achievement("chocoClear", 
{
    achievementName: global.TextContainer.a_chocoClearName.selectedLanguage,
    achievementIcon: 2361,
    achievementDescription: global.TextContainer.a_chocoClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "chocoGachikoi", new Achievement("chocoGachikoi", 
{
    achievementName: global.TextContainer.a_chocoGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_chocoGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "subaruClear", new Achievement("subaruClear", 
{
    achievementName: global.TextContainer.a_subaruClearName.selectedLanguage,
    achievementIcon: 2146,
    achievementDescription: global.TextContainer.a_subaruClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "subaruGachikoi", new Achievement("subaruGachikoi", 
{
    achievementName: global.TextContainer.a_subaruGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_subaruGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "shion10", new Achievement("shion10", 
{
    achievementName: global.TextContainer.a_shion10Name.selectedLanguage,
    achievementIcon: 153,
    achievementDescription: global.TextContainer.a_shion10Description.selectedLanguage
}, OnSet, Flags, orderNum, 175, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "shionClear", new Achievement("shionClear", 
{
    achievementName: global.TextContainer.a_shionClearName.selectedLanguage,
    achievementIcon: 2371,
    achievementDescription: global.TextContainer.a_shionClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "shionGachikoi", new Achievement("shionGachikoi", 
{
    achievementName: global.TextContainer.a_shionGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_shionGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ayameClear", new Achievement("ayameClear", 
{
    achievementName: global.TextContainer.a_ayameClearName.selectedLanguage,
    achievementIcon: 2369,
    achievementDescription: global.TextContainer.a_ayameClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ayameGachikoi", new Achievement("ayameGachikoi", 
{
    achievementName: global.TextContainer.a_ayameGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_ayameGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "aquaClear", new Achievement("aquaClear", 
{
    achievementName: global.TextContainer.a_aquaClearName.selectedLanguage,
    achievementIcon: 2280,
    achievementDescription: global.TextContainer.a_aquaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "aquaGachikoi", new Achievement("aquaGachikoi", 
{
    achievementName: global.TextContainer.a_aquaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_aquaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "moonaClear", new Achievement("moonaClear", 
{
    achievementName: global.TextContainer.a_moonaClearName.selectedLanguage,
    achievementIcon: 909,
    achievementDescription: global.TextContainer.a_moonaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "moonaGachikoi", new Achievement("moonaGachikoi", 
{
    achievementName: global.TextContainer.a_moonaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_moonaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "iofiClear", new Achievement("iofiClear", 
{
    achievementName: global.TextContainer.a_iofiClearName.selectedLanguage,
    achievementIcon: 2345,
    achievementDescription: global.TextContainer.a_iofiClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "iofiGachikoi", new Achievement("iofiGachikoi", 
{
    achievementName: global.TextContainer.a_iofiGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_iofiGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "risuClear", new Achievement("risuClear", 
{
    achievementName: global.TextContainer.a_risuClearName.selectedLanguage,
    achievementIcon: 2221,
    achievementDescription: global.TextContainer.a_risuClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "risuGachikoi", new Achievement("risuGachikoi", 
{
    achievementName: global.TextContainer.a_risuGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_risuGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ollieClear", new Achievement("ollieClear", 
{
    achievementName: global.TextContainer.a_ollieClearName.selectedLanguage,
    achievementIcon: 122,
    achievementDescription: global.TextContainer.a_ollieClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ollie10", new Achievement("ollie10", 
{
    achievementName: global.TextContainer.a_ollie10Name.selectedLanguage,
    achievementIcon: 370,
    achievementDescription: global.TextContainer.a_ollie10Description.selectedLanguage
}, OnSet, Flags, orderNum, 870, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "ollieGachikoi", new Achievement("ollieGachikoi", 
{
    achievementName: global.TextContainer.a_ollieGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_ollieGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "reineClear", new Achievement("reineClear", 
{
    achievementName: global.TextContainer.a_reineClearName.selectedLanguage,
    achievementIcon: 1887,
    achievementDescription: global.TextContainer.a_reineClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "reineGachikoi", new Achievement("reineGachikoi", 
{
    achievementName: global.TextContainer.a_reineGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_reineGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "anyaClear", new Achievement("anyaClear", 
{
    achievementName: global.TextContainer.a_anyaClearName.selectedLanguage,
    achievementIcon: 2331,
    achievementDescription: global.TextContainer.a_anyaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "anyaGachikoi", new Achievement("anyaGachikoi", 
{
    achievementName: global.TextContainer.a_anyaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_anyaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "koboClear", new Achievement("koboClear", 
{
    achievementName: global.TextContainer.a_koboClearName.selectedLanguage,
    achievementIcon: 228,
    achievementDescription: global.TextContainer.a_koboClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "koboGachikoi", new Achievement("koboGachikoi", 
{
    achievementName: global.TextContainer.a_koboGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_koboGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kaelaClear", new Achievement("kaelaClear", 
{
    achievementName: global.TextContainer.a_kaelaClearName.selectedLanguage,
    achievementIcon: 2352,
    achievementDescription: global.TextContainer.a_kaelaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "kaelaGachikoi", new Achievement("kaelaGachikoi", 
{
    achievementName: global.TextContainer.a_kaelaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_kaelaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "zeta10", new Achievement("zeta10", 
{
    achievementName: global.TextContainer.a_zeta10Name.selectedLanguage,
    achievementIcon: 1759,
    achievementDescription: global.TextContainer.a_zeta10Description.selectedLanguage
}, OnSet, Flags, orderNum, 989, "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "zetaClear", new Achievement("zetaClear", 
{
    achievementName: global.TextContainer.a_zetaClearName.selectedLanguage,
    achievementIcon: 2268,
    achievementDescription: global.TextContainer.a_zetaClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "zetaGachikoi", new Achievement("zetaGachikoi", 
{
    achievementName: global.TextContainer.a_zetaGachikoiName.selectedLanguage,
    achievementIcon: 2172,
    achievementDescription: global.TextContainer.a_zetaGachikoiDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "character"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "firstclear", new Achievement("firstclear", 
{
    achievementName: global.TextContainer.generalClearName.selectedLanguage,
    achievementIcon: 1706,
    achievementDescription: global.TextContainer.generalClearDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "midboss", new Achievement("midboss", 
{
    achievementName: global.TextContainer.FuburaComingName.selectedLanguage,
    achievementIcon: 511,
    achievementDescription: global.TextContainer.FuburaComingDescription.selectedLanguage
}, OnSet, Flags, orderNum, 251, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "firstboss", new Achievement("firstboss", 
{
    achievementName: global.TextContainer.firstBossName.selectedLanguage,
    achievementIcon: 402,
    achievementDescription: global.TextContainer.firstBossDescription.selectedLanguage
}, OnSet, Flags, orderNum, 37, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "secondboss", new Achievement("secondboss", 
{
    achievementName: global.TextContainer.TearsHappinessName.selectedLanguage,
    achievementIcon: 1988,
    achievementDescription: global.TextContainer.TearsHappinessDescription.selectedLanguage
}, OnSet, Flags, orderNum, 2065, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "thirdboss", new Achievement("thirdboss", 
{
    achievementName: global.TextContainer.CursedName.selectedLanguage,
    achievementIcon: 2341,
    achievementDescription: global.TextContainer.CursedDescription.selectedLanguage
}, OnSet, Flags, orderNum, 2248, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fourthboss", new Achievement("fourthboss", 
{
    achievementName: global.TextContainer.a_area15Name.selectedLanguage,
    achievementIcon: 1305,
    achievementDescription: global.TextContainer.a_area15Description.selectedLanguage
}, OnSet, Flags, orderNum, 19, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "1hard", new Achievement("1hard", 
{
    achievementName: global.TextContainer.ThousandMileStareName.selectedLanguage,
    achievementIcon: 2340,
    achievementDescription: global.TextContainer.ThousandMileStareDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "2hard", new Achievement("2hard", 
{
    achievementName: global.TextContainer.ManagersName.selectedLanguage,
    achievementIcon: 1872,
    achievementDescription: global.TextContainer.ManagersDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "3hard", new Achievement("3hard", 
{
    achievementName: global.TextContainer.a_MythOrTreatName.selectedLanguage,
    achievementIcon: 1459,
    achievementDescription: global.TextContainer.a_MythOrTreatDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "speedrunner", new Achievement("speedrunner", 
{
    achievementName: global.TextContainer.SpeedRunnerName.selectedLanguage,
    achievementIcon: 211,
    achievementDescription: global.TextContainer.SpeedRunnerDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    show_debug_message("checking idol achievement");
    var completeChars = true;
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) == 0 && array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "random" && array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "none" && array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "empty")
        {
            show_debug_message(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0));
            completeChars = false;
            break;
        }
    }
    if (completeChars)
    {
        arg0.unlocked = true;
    }
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "idolgroup", new Achievement("idolgroup", 
{
    achievementName: global.TextContainer.IdolGroupName.selectedLanguage,
    achievementIcon: 634,
    achievementDescription: global.TextContainer.IdolGroupDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "idolPower", new Achievement("idolPower", 
{
    achievementName: global.TextContainer.idolPowerName.selectedLanguage,
    achievementIcon: 1104,
    achievementDescription: global.TextContainer.idolPowerDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1564, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "yagoostatue", new Achievement("yagoostatue", 
{
    achievementName: global.TextContainer.yagoostatueName.selectedLanguage,
    achievementIcon: 2269,
    achievementDescription: global.TextContainer.yagoostatueDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 100], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "timeToUpgrade", new Achievement("timeToUpgrade", 
{
    achievementName: global.TextContainer.TimeToUpgradeName.selectedLanguage,
    achievementIcon: 1603,
    achievementDescription: global.TextContainer.TimeToUpgradeDescription.selectedLanguage
}, OnSet, Flags, orderNum, 2370, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "boing", new Achievement("boing", 
{
    achievementName: global.TextContainer.boingName.selectedLanguage,
    achievementIcon: 2406,
    achievementDescription: global.TextContainer.boingDescription.selectedLanguage
}, OnSet, Flags, orderNum, 815, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "safeISwear", new Achievement("safeISwear", 
{
    achievementName: global.TextContainer.SafeISwearName.selectedLanguage,
    achievementIcon: 282,
    achievementDescription: global.TextContainer.SafeISwearDescription.selectedLanguage
}, OnSet, Flags, orderNum, 658, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "SCT", new Achievement("SCT", 
{
    achievementName: global.TextContainer.SCTName.selectedLanguage,
    achievementIcon: 784,
    achievementDescription: global.TextContainer.SCTDescription.selectedLanguage
}, OnSet, Flags, orderNum, 2127, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "grind", new Achievement("grind", 
{
    achievementName: global.TextContainer.GrindName.selectedLanguage,
    achievementIcon: 1756,
    achievementDescription: global.TextContainer.GrindDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "wamy", new Achievement("wamy", 
{
    achievementName: global.TextContainer.WamyName.selectedLanguage,
    achievementIcon: 1771,
    achievementDescription: global.TextContainer.WamyDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1263, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "lv50", new Achievement("lv50", 
{
    achievementName: global.TextContainer.lvlFiftyName.selectedLanguage,
    achievementIcon: 751,
    achievementDescription: global.TextContainer.lvlFiftyDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1357, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "lv100", new Achievement("lv100", 
{
    achievementName: global.TextContainer.lvlHundredName.selectedLanguage,
    achievementIcon: 33,
    achievementDescription: global.TextContainer.lvlHundredDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "delusional", new Achievement("delusional", 
{
    achievementName: global.TextContainer.DelusionalName.selectedLanguage,
    achievementIcon: 2113,
    achievementDescription: global.TextContainer.DelusionalDescription.selectedLanguage
}, OnSet, Flags, orderNum, 613, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "toohalu", new Achievement("toohalu", 
{
    achievementName: global.TextContainer.TooHaluName.selectedLanguage,
    achievementIcon: 279,
    achievementDescription: global.TextContainer.TooHaluDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1811, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "50hamburgers", new Achievement("50hamburgers", 
{
    achievementName: global.TextContainer.a_burgerName.selectedLanguage,
    achievementIcon: 1639,
    achievementDescription: global.TextContainer.a_burgerDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "1000damage", new Achievement("1000damage", 
{
    achievementName: global.TextContainer.thousandDamageName.selectedLanguage,
    achievementIcon: 1022,
    achievementDescription: global.TextContainer.thousandDamageDescription.selectedLanguage
}, OnSet, Flags, orderNum, 987, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "10000damage", new Achievement("10000damage", 
{
    achievementName: global.TextContainer.tenThousandDamageName.selectedLanguage,
    achievementIcon: 444,
    achievementDescription: global.TextContainer.tenThousandDamageDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "couchPotato", new Achievement("couchPotato", 
{
    achievementName: global.TextContainer.couchPotatoName.selectedLanguage,
    achievementIcon: 473,
    achievementDescription: global.TextContainer.couchPotatoDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fleshWound", new Achievement("fleshWound", 
{
    achievementName: global.TextContainer.FleshWoundName.selectedLanguage,
    achievementIcon: 1794,
    achievementDescription: global.TextContainer.FleshWoundDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1416, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "dontNeed", new Achievement("dontNeed", 
{
    achievementName: global.TextContainer.dontNeedName.selectedLanguage,
    achievementIcon: 1786,
    achievementDescription: global.TextContainer.dontNeedDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "buyingPower", new Achievement("buyingPower", 
{
    achievementName: global.TextContainer.BuyingPowerName.selectedLanguage,
    achievementIcon: 2224,
    achievementDescription: global.TextContainer.BuyingPowerDescription.selectedLanguage
}, OnSet, Flags, orderNum, 476, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "petDog", new Achievement("petDog", 
{
    achievementName: global.TextContainer.a_petDogName.selectedLanguage,
    achievementIcon: 470,
    achievementDescription: global.TextContainer.a_petDogDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 200], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fullCollab", new Achievement("fullCollab", 
{
    achievementName: global.TextContainer.a_fullCollabName.selectedLanguage,
    achievementIcon: 1619,
    achievementDescription: global.TextContainer.a_fullCollabDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "muscle", new Achievement("muscle", 
{
    achievementName: global.TextContainer.MuscleName.selectedLanguage,
    achievementIcon: 496,
    achievementDescription: global.TextContainer.MuscleDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1269, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "dontFail", new Achievement("dontFail", 
{
    achievementName: global.TextContainer.PleaseDontFailName.selectedLanguage,
    achievementIcon: 539,
    achievementDescription: global.TextContainer.PleaseDontFailDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1012, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "CEOnow", new Achievement("CEOnow", 
{
    achievementName: global.TextContainer.defeatYagooName.selectedLanguage,
    achievementIcon: 271,
    achievementDescription: global.TextContainer.defeatYagooDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "payDay", new Achievement("payDay", 
{
    achievementName: global.TextContainer.defeatGoldenYagooName.selectedLanguage,
    achievementIcon: 774,
    achievementDescription: global.TextContainer.defeatGoldenYagooDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1478, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "freeStickers", new Achievement("freeStickers", 
{
    achievementName: global.TextContainer.defeatSilverYagooName.selectedLanguage,
    achievementIcon: 1624,
    achievementDescription: global.TextContainer.defeatSilverYagooDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fired", new Achievement("fired", 
{
    achievementName: global.TextContainer.defeatedYagooName.selectedLanguage,
    achievementIcon: 2260,
    achievementDescription: global.TextContainer.defeatedYagooDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "luckyDay", new Achievement("luckyDay", 
{
    achievementName: global.TextContainer.a_luckyDayName.selectedLanguage,
    achievementIcon: 467,
    achievementDescription: global.TextContainer.a_luckyDayDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "painPeko", new Achievement("painPeko", 
{
    achievementName: global.TextContainer.a_painPekoName.selectedLanguage,
    achievementIcon: 793,
    achievementDescription: global.TextContainer.a_painPekoDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "hardcoreGamer", new Achievement("hardcoreGamer", 
{
    achievementName: global.TextContainer.a_hardcoreGamerName.selectedLanguage,
    achievementIcon: 2213,
    achievementDescription: global.TextContainer.a_hardcoreGamerDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "payToWin", new Achievement("payToWin", 
{
    achievementName: global.TextContainer.a_payToWinName.selectedLanguage,
    achievementIcon: 1465,
    achievementDescription: global.TextContainer.a_payToWinDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 5000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "soloBeater", new Achievement("soloBeater", 
{
    achievementName: global.TextContainer.a_soloBeaterName.selectedLanguage,
    achievementIcon: 719,
    achievementDescription: global.TextContainer.a_soloBeaterDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "trueRNG", new Achievement("trueRNG", 
{
    achievementName: global.TextContainer.a_trueRNGName.selectedLanguage,
    achievementIcon: 171,
    achievementDescription: global.TextContainer.a_trueRNGDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "justRNG", new Achievement("justRNG", 
{
    achievementName: global.TextContainer.a_justRNGName.selectedLanguage,
    achievementIcon: 92,
    achievementDescription: global.TextContainer.a_justRNGDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "hallucinated", new Achievement("hallucinated", 
{
    achievementName: global.TextContainer.a_hallucinatedName.selectedLanguage,
    achievementIcon: 1129,
    achievementDescription: global.TextContainer.a_hallucinatedDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "iDidIt", new Achievement("iDidIt", 
{
    achievementName: global.TextContainer.a_iDidItName.selectedLanguage,
    achievementIcon: 1746,
    achievementDescription: global.TextContainer.a_iDidItDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "obliterated", new Achievement("obliterated", 
{
    achievementName: global.TextContainer.a_obliteratedName.selectedLanguage,
    achievementIcon: 976,
    achievementDescription: global.TextContainer.a_obliteratedDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "pacifist", new Achievement("pacifist", 
{
    achievementName: global.TextContainer.a_pacifistName.selectedLanguage,
    achievementIcon: 1488,
    achievementDescription: global.TextContainer.a_pacifistDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "powerLevelling", new Achievement("powerLevelling", 
{
    achievementName: global.TextContainer.a_powerLevellingName.selectedLanguage,
    achievementIcon: 1625,
    achievementDescription: global.TextContainer.a_powerLevellingDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fullyLoaded", new Achievement("fullyLoaded", 
{
    achievementName: global.TextContainer.a_fullyLoadedName.selectedLanguage,
    achievementIcon: 1538,
    achievementDescription: global.TextContainer.a_fullyLoadedDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "thankYou", new Achievement("thankYou", 
{
    achievementName: global.TextContainer.a_thankYouName.selectedLanguage,
    achievementIcon: 1896,
    achievementDescription: global.TextContainer.a_thankYouDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "notTakingAnyChances", new Achievement("notTakingAnyChances", 
{
    achievementName: global.TextContainer.a_notTakingAnyChancesName.selectedLanguage,
    achievementIcon: 600,
    achievementDescription: global.TextContainer.a_notTakingAnyChancesDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 2000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "millionaire", new Achievement("millionaire", 
{
    achievementName: global.TextContainer.a_millionaireName.selectedLanguage,
    achievementIcon: 1302,
    achievementDescription: global.TextContainer.a_millionaireDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 5000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "lookImOnTV", new Achievement("lookImOnTV", 
{
    achievementName: global.TextContainer.a_lookImOnTVName.selectedLanguage,
    achievementIcon: 1762,
    achievementDescription: global.TextContainer.a_lookImOnTVDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "donttouch", new Achievement("donttouch", 
{
    achievementName: global.TextContainer.a_donttouchName.selectedLanguage,
    achievementIcon: 1500,
    achievementDescription: global.TextContainer.a_donttouchDescription.selectedLanguage
}, OnSet, Flags, orderNum, 1070, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "welcomehome", new Achievement("welcomehome", 
{
    achievementName: global.TextContainer.a_welcomehomeName.selectedLanguage,
    achievementIcon: 1775,
    achievementDescription: global.TextContainer.a_welcomehomeDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "heyhey", new Achievement("heyhey", 
{
    achievementName: global.TextContainer.a_heyheyName.selectedLanguage,
    achievementIcon: 191,
    achievementDescription: global.TextContainer.a_heyheyDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "harvest", new Achievement("harvest", 
{
    achievementName: global.TextContainer.a_harvestName.selectedLanguage,
    achievementIcon: 990,
    achievementDescription: global.TextContainer.a_harvestDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "shinyfish", new Achievement("shinyfish", 
{
    achievementName: global.TextContainer.a_shinyfishName.selectedLanguage,
    achievementIcon: 1764,
    achievementDescription: global.TextContainer.a_shinyfishDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "stealfish", new Achievement("stealfish", 
{
    achievementName: global.TextContainer.a_stealfishName.selectedLanguage,
    achievementIcon: 817,
    achievementDescription: global.TextContainer.a_stealfishDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "digin", new Achievement("digin", 
{
    achievementName: global.TextContainer.a_diginName.selectedLanguage,
    achievementIcon: 67,
    achievementDescription: global.TextContainer.a_diginDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "fishfearme", new Achievement("fishfearme", 
{
    achievementName: global.TextContainer.a_fishfearmeName.selectedLanguage,
    achievementIcon: 1148,
    achievementDescription: global.TextContainer.a_fishfearmeDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "rhythmmaster", new Achievement("rhythmmaster", 
{
    achievementName: global.TextContainer.a_rhythmmasterName.selectedLanguage,
    achievementIcon: 940,
    achievementDescription: global.TextContainer.a_rhythmmasterDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "plentyoffish", new Achievement("plentyoffish", 
{
    achievementName: global.TextContainer.a_plentyoffishName.selectedLanguage,
    achievementIcon: 1532,
    achievementDescription: global.TextContainer.a_plentyoffishDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "lovenature", new Achievement("lovenature", 
{
    achievementName: global.TextContainer.a_lovenatureName.selectedLanguage,
    achievementIcon: 1707,
    achievementDescription: global.TextContainer.a_lovenatureDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "employee", new Achievement("employee", 
{
    achievementName: global.TextContainer.a_employeeName.selectedLanguage,
    achievementIcon: 321,
    achievementDescription: global.TextContainer.a_employeeDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 5000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "welltrained", new Achievement("welltrained", 
{
    achievementName: global.TextContainer.a_welltrainedName.selectedLanguage,
    achievementIcon: 699,
    achievementDescription: global.TextContainer.a_welltrainedDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 10000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "howcouldyou", new Achievement("howcouldyou", 
{
    achievementName: global.TextContainer.a_howcouldyouName.selectedLanguage,
    achievementIcon: 1411,
    achievementDescription: global.TextContainer.a_howcouldyouDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "highwayrobbery", new Achievement("highwayrobbery", 
{
    achievementName: global.TextContainer.a_highwayrobberyName.selectedLanguage,
    achievementIcon: 1212,
    achievementDescription: global.TextContainer.a_highwayrobberyDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 100], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "huh", new Achievement("huh", 
{
    achievementName: global.TextContainer.a_huhName.selectedLanguage,
    achievementIcon: 968,
    achievementDescription: global.TextContainer.a_huhDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 500], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "barebones", new Achievement("barebones", 
{
    achievementName: global.TextContainer.a_barebonesName.selectedLanguage,
    achievementIcon: 1328,
    achievementDescription: global.TextContainer.a_barebonesDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "hammertime", new Achievement("hammertime", 
{
    achievementName: global.TextContainer.a_hammertimeName.selectedLanguage,
    achievementIcon: 2252,
    achievementDescription: global.TextContainer.a_hammertimeDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "skillissue", new Achievement("skillissue", 
{
    achievementName: global.TextContainer.a_skillissueName.selectedLanguage,
    achievementIcon: 2095,
    achievementDescription: global.TextContainer.a_skillissueDescription.selectedLanguage
}, OnSet, Flags, orderNum, 349, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "oraora", new Achievement("oraora", 
{
    achievementName: global.TextContainer.a_oraoraName.selectedLanguage,
    achievementIcon: 1002,
    achievementDescription: global.TextContainer.a_oraoraDescription.selectedLanguage
}, OnSet, Flags, orderNum, 2237, "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "artblock", new Achievement("artblock", 
{
    achievementName: global.TextContainer.a_artblockName.selectedLanguage,
    achievementIcon: 1094,
    achievementDescription: global.TextContainer.a_artblockDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "nothoughts", new Achievement("nothoughts", 
{
    achievementName: global.TextContainer.a_nothoughtsName.selectedLanguage,
    achievementIcon: 2137,
    achievementDescription: global.TextContainer.a_nothoughtsDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 5000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "bullethell", new Achievement("bullethell", 
{
    achievementName: global.TextContainer.a_bullethellName.selectedLanguage,
    achievementIcon: 1888,
    achievementDescription: global.TextContainer.a_bullethellDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 8000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "nomain", new Achievement("nomain", 
{
    achievementName: global.TextContainer.a_nomainName.selectedLanguage,
    achievementIcon: 1422,
    achievementDescription: global.TextContainer.a_nomainDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "rawstrength", new Achievement("rawstrength", 
{
    achievementName: global.TextContainer.a_rawstrengthName.selectedLanguage,
    achievementIcon: 373,
    achievementDescription: global.TextContainer.a_rawstrengthDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 5000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "tankclass", new Achievement("tankclass", 
{
    achievementName: global.TextContainer.a_tankclassName.selectedLanguage,
    achievementIcon: 1877,
    achievementDescription: global.TextContainer.a_tankclassDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 3000], "general"));
orderNum++;

OnSet = function(arg0, arg1)
{
    arg0.unlocked = true;
};

Flags = {};
ds_map_set(ACHIEVEMENTS, "allcomplete", new Achievement("allcomplete", 
{
    achievementName: global.TextContainer.allAchievementName.selectedLanguage,
    achievementIcon: 201,
    achievementDescription: global.TextContainer.allAchievementDescription.selectedLanguage
}, OnSet, Flags, orderNum, [2408, 1], "general"));
orderNum++;
show_debug_message("initiating achievements");
global.achievementsMap = ACHIEVEMENTS;
