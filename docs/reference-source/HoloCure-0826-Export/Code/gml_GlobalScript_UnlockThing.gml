function UnlockThing(arg0, arg1, arg2)
{
    var found = false;
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] == arg1)
        {
            found = true;
        }
    }
    for (var i = 0; i < array_length(global.unlockedThings); i++)
    {
        if (global.unlockedThings[i].optionID == arg1)
        {
            found = true;
        }
    }
    if (!found)
    {
        global.unlockedNew = true;
        switch (arg2)
        {
            case "WEAPON":
                array_push(global.unlockedThings, ds_map_find_value(global.attacksLibrary, arg1).config);
                array_push(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), arg1);
                SavePlayerSave();
                break;
                break;
            case "ITEM":
                array_push(global.unlockedThings, ds_map_find_value(global.itemsLibrary, arg1));
                array_push(ds_map_find_value(global.PlayerSave, "unlockedItems"), arg1);
                SavePlayerSave();
                break;
            case "STAGE":
                var newStage = 
                {
                    optionID: arg1,
                    optionName: arg1,
                    optionIcon: 2413,
                    optionDescription: global.TextContainer.stageDescription.selectedLanguage,
                    optionType: "Stage"
                };
                array_push(global.unlockedThings, newStage);
                array_push(ds_map_find_value(global.PlayerSave, "unlockedStages"), arg1);
                SavePlayerSave();
                break;
        }
        if (variable_global_exists("attacksLibrary") && variable_global_exists("itemsLibrary"))
        {
            CheckArmouryMaxed();
        }
    }
}
