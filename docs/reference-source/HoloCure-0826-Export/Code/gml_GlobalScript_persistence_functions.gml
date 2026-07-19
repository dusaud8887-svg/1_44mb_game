global.defaultSettings = 
{
    fullscreen: false,
    showDamageText: true,
    lightFX: true,
    screenShake: true,
    CurrentLanguage: "eng",
    hiscoresnames: true,
    username: "Player",
    soundVolume: 0.6,
    musicVolume: 0.4,
    theButtons: [],
    controllerButtons: [],
    Resolution: 1,
    readyToStart: false,
    attackAlpha: 1,
    portDisplay: 0,
    showHUDHP: 1,
    showHPVal: 1,
    hideFullHP: 1,
    aboveHP: 1,
    showSkillRadius: 1,
    vibration: 1,
    showStamps: 1,
    hhMessages: 1,
    hiscoreName: 1
};

function SaveSettings()
{
    if (global.isResettingSave)
    {
        exit;
    }
    var file = file_text_open_write(working_directory + "settings.json");
    var buttonStrings = [];
    for (var i = 0; i < array_length(global.theButtons); i++)
    {
        array_push(buttonStrings, key_to_string(global.theButtons[i]));
    }
    var controllerStrings = [];
    for (var i = 0; i < array_length(global.controllerButtons); i++)
    {
        array_push(controllerStrings, ControllerToStrings(global.controllerButtons[i]));
    }
    var settings = 
    {
        fullscreen: global.fullscreen,
        showDamageText: global.showDamageText,
        lightFX: global.lightFX,
        screenShake: global.screenshake,
        CurrentLanguage: global.CurrentLanguage,
        hiscorenames: global.hiscorenames,
        username: global.username,
        soundVolume: global.soundVolume,
        musicVolume: global.musicVolume,
        theButtons: buttonStrings,
        controllerButtons: controllerStrings,
        Resolution: global.Resolution,
        readyToStart: global.readyToStart,
        attackAlpha: global.attackAlpha,
        portDisplay: global.portDisplay,
        showHUDHP: global.showHUDHP,
        showHPVal: global.showHPVal,
        hideFullHP: global.hideFullHP,
        aboveHP: global.aboveHP,
        showSkillRadius: global.showSkillRadius,
        vibration: global.vibration,
        showStamps: global.showStamps,
        hhMessages: global.hhMessages,
        hiscoreName: global.hiscoreName
    };
    settings = json_stringify(settings);
    file_text_write_string(file, settings);
    file_text_close(file);
}

function ParseButtons(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] == "LEFT")
        {
            global.theButtons[i] = 37;
        }
        else if (arg0[i] == "RIGHT")
        {
            global.theButtons[i] = 39;
        }
        else if (arg0[i] == "UP")
        {
            global.theButtons[i] = 38;
        }
        else if (arg0[i] == "DOWN")
        {
            global.theButtons[i] = 40;
        }
        else if (arg0[i] == "CTRL")
        {
            global.theButtons[i] = 17;
        }
        else if (arg0[i] == "SHIFT")
        {
            global.theButtons[i] = 16;
        }
        else if (arg0[i] == "ALT")
        {
            global.theButtons[i] = 18;
        }
        else if (arg0[i] == "SPACE")
        {
            global.theButtons[i] = 32;
        }
        else if (arg0[i] == "")
        {
            switch (i)
            {
                case 0:
                    global.theButtons[i] = 32;
                    break;
                case 1:
                    global.theButtons[i] = 16;
                    break;
                case 2:
                    global.theButtons[i] = ord(string_upper("A"));
                    break;
                case 3:
                    global.theButtons[i] = ord(string_upper("D"));
                    break;
                case 4:
                    global.theButtons[i] = ord(string_upper("W"));
                    break;
                case 5:
                    global.theButtons[i] = ord(string_upper("S"));
                    break;
            }
        }
        else
        {
            global.theButtons[i] = ord(string_upper(arg0[i]));
        }
        SetKeyboardControls();
    }
}

function ParseController(arg0)
{
    if (!is_array(arg0) || array_length(arg0) < 6)
    {
        arg0 = [32769, 32775, 32770, 32776, 32778, 32777];
    }
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] == "gp_face1")
        {
            global.controllerButtons[i] = 32769;
        }
        else if (arg0[i] == "gp_face2")
        {
            global.controllerButtons[i] = 32770;
        }
        else if (arg0[i] == "gp_face3")
        {
            global.controllerButtons[i] = 32771;
        }
        else if (arg0[i] == "gp_face4")
        {
            global.controllerButtons[i] = 32772;
        }
        else if (arg0[i] == "gp_shoulderl")
        {
            global.controllerButtons[i] = 32773;
        }
        else if (arg0[i] == "gp_shoulderlb")
        {
            global.controllerButtons[i] = 32775;
        }
        else if (arg0[i] == "gp_shoulderr")
        {
            global.controllerButtons[i] = 32774;
        }
        else if (arg0[i] == "gp_shoulderrb")
        {
            global.controllerButtons[i] = 32776;
        }
        else if (arg0[i] == "gp_select")
        {
            global.controllerButtons[i] = 32777;
        }
        else if (arg0[i] == "gp_start")
        {
            global.controllerButtons[i] = 32778;
        }
        SetControllerControls();
    }
}

function LoadSettings()
{
    if (file_exists(working_directory + "settings.json"))
    {
        show_debug_message("LOADING SETTINGS");
        var settingsJson = file_text_open_read(working_directory + "settings.json");
        var settings = json_parse(file_text_readln(settingsJson));
        show_debug_message(settings);
        CheckSettings(settings);
        if (!variable_struct_exists(settings, "readyToStart"))
        {
            global.readyToStart = false;
        }
        else
        {
            global.readyToStart = settings.readyToStart;
        }
        global.fullscreen = settings.fullscreen;
        global.showDamageText = settings.showDamageText;
        global.lightFX = settings.lightFX;
        global.screenshake = settings.screenShake;
        global.CurrentLanguage = settings.CurrentLanguage;
        global.hiscorenames = settings.hiscorenames;
        global.username = settings.username;
        global.soundVolume = settings.soundVolume;
        global.musicVolume = settings.musicVolume;
        global.Resolution = settings.Resolution;
        global.attackAlpha = settings.attackAlpha;
        global.portDisplay = settings.portDisplay;
        global.aboveHP = settings.aboveHP;
        global.hideFullHP = settings.hideFullHP;
        global.showHUDHP = settings.showHUDHP;
        global.showHPVal = settings.showHPVal;
        global.showSkillRadius = settings.showSkillRadius;
        global.vibration = settings.vibration;
        global.showStamps = settings.showStamps;
        global.hhMessages = settings.hhMessages;
        global.hiscoreName = settings.hiscoreName;
        if (variable_struct_exists(settings, "controllerButtons"))
        {
            ParseController(settings.controllerButtons);
        }
        else
        {
            show_debug_message("no buttons found");
        }
        if (variable_struct_exists(settings, "theButtons"))
        {
            ParseButtons(settings.theButtons);
        }
        else
        {
            show_debug_message("no buttons found");
        }
        file_text_close(settingsJson);
        window_set_fullscreen(global.fullscreen);
        switch (global.Resolution)
        {
            case 0:
                SetResolution(640, 360);
                break;
            case 1:
                SetResolution(1280, 720);
                break;
            case 2:
                SetResolution(1920, 1080);
                break;
            case 3:
                SetResolution(2560, 1440);
                break;
        }
        global.username = CheckValidName(global.username);
        SaveSettings();
    }
    else
    {
        show_debug_message("SAVING DEFAULT SETTINGS");
        SaveSettings();
    }
}

function CheckSettings(arg0)
{
    var keys = variable_struct_get_names(global.defaultSettings);
    for (var i = 0; i < array_length(keys); i++)
    {
        if (!variable_struct_exists(arg0, keys[i]))
        {
            variable_struct_set(arg0, keys[i], variable_struct_get(global.defaultSettings, keys[i]));
        }
    }
}

function SetFirstCharacterData()
{
    ds_map_set(global.PlayerSave, "characters", []);
    instance_create_depth(x, y, depth, obj_TextController);
    instance_create_depth(x, y, depth, obj_CharacterData);
    var key = ds_map_find_first(global.characterData);
    var size = ds_map_size(global.characterData);
    for (var i = 0; i < size; i++)
    {
        array_push(ds_map_find_value(global.PlayerSave, "characters"), [key, 0]);
        key = ds_map_find_next(global.characterData, key);
    }
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == "calli")
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, 1);
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == "ame")
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, 1);
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == "gura")
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, 1);
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == "ina")
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, 1);
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == "kiara")
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, 1);
        }
    }
    SavePlayerSave();
}

function SetFirstWeapons()
{
    ds_map_set(global.PlayerSave, "unlockedWeapons", ["PsychoAxe", "Glowstick", "SpiderCooking", "Tailplug", "BLBook", "EliteLava", "HoloBomb"]);
    SavePlayerSave();
}

function SetFirstItems()
{
    ds_map_set(global.PlayerSave, "unlockedItems", ["BodyPillow", "FullMeal", "PikiPikiPiman", "SuccubusHorn", "Headphones", "UberSheep", "HolyMilk", "Sake", "FaceMask"]);
    SavePlayerSave();
}

function InitialPlayerSaveLoad()
{
    initItems();
    instance_create_depth(x, y, 0, obj_AttackController);
    if (file_exists("save.dat") || file_exists("save_n.dat") || file_exists("backup.dat"))
    {
        LoadPlayerSave();
    }
    else
    {
        global.PlayerSave = ds_map_create();
        CheckPlayerSave();
        SavePlayerSave();
    }
}

function UnpackCollabs()
{
    global.seenCollabs = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "seenCollabs")))
    {
        if (ds_map_find_value(global.PlayerSave, "seenCollabs") != pointer_null && !is_undefined(ds_map_find_value(global.PlayerSave, "seenCollabs")) && ds_exists(ds_map_find_value(global.PlayerSave, "seenCollabs"), ds_type_list))
        {
            show_debug_message("loading collab list");
            var GMDSListBullshit;
            if (ds_exists(ds_map_find_value(global.PlayerSave, "seenCollabs"), ds_type_list))
            {
                show_debug_message("ds list");
                GMDSListBullshit = array_create();
                for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "seenCollabs")); i++)
                {
                    show_debug_message(i);
                    var collabWeapon = ds_map_find_value(obj_AttackController.attackIndex, ds_list_find_value(ds_map_find_value(global.PlayerSave, "seenCollabs"), i)).config;
                    if (!array_exists(global.seenCollabs, collabWeapon))
                    {
                        array_push(global.seenCollabs, collabWeapon);
                        array_push(GMDSListBullshit, collabWeapon);
                    }
                }
                ds_list_destroy(ds_map_find_value(global.PlayerSave, "seenCollabs"));
            }
            ds_map_set(global.PlayerSave, "seenCollabs", array_create());
            for (var i = 0; i < array_length(GMDSListBullshit); i++)
            {
                if (!array_exists(ds_map_find_value(global.PlayerSave, "seenCollabs"), GMDSListBullshit[i].attackID))
                {
                    array_push(ds_map_find_value(global.PlayerSave, "seenCollabs"), GMDSListBullshit[i].attackID);
                }
            }
        }
        else
        {
            ds_map_set(global.PlayerSave, "seenCollabs", array_create());
        }
    }
    else
    {
        show_debug_message("is array");
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "seenCollabs")); i++)
        {
            var getWeapon = ds_map_find_value(obj_AttackController.attackIndex, array_get(ds_map_find_value(global.PlayerSave, "seenCollabs"), i));
            if (!is_undefined(getWeapon))
            {
                var collabWeapon = getWeapon.config;
                if (!array_exists(global.seenCollabs, collabWeapon))
                {
                    array_push(global.seenCollabs, collabWeapon);
                }
            }
        }
    }
}

function UnpackWeapons()
{
    var weaponUnlocks = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "unlockedWeapons")) && ds_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), ds_type_list))
    {
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "unlockedWeapons")); i++)
        {
            var weapon = ds_list_find_value(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), i);
            array_push(weaponUnlocks, weapon);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "unlockedWeapons"));
        ds_map_set(global.PlayerSave, "unlockedWeapons", weaponUnlocks);
    }
    var removeDupes = [];
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "unlockedWeapons")); i++)
    {
        if (!array_exists(removeDupes, array_get(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), i)))
        {
            array_push(removeDupes, array_get(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), i));
        }
    }
    ds_map_set(global.PlayerSave, "unlockedWeapons", removeDupes);
}

function UnpackItems()
{
    var itemUnlocks = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "unlockedItems")) && ds_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), ds_type_list))
    {
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "unlockedItems")); i++)
        {
            var item = ds_list_find_value(ds_map_find_value(global.PlayerSave, "unlockedItems"), i);
            array_push(itemUnlocks, item);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "unlockedItems"));
        ds_map_set(global.PlayerSave, "unlockedItems", itemUnlocks);
    }
    var removeDupes = [];
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "unlockedItems")); i++)
    {
        if (!array_exists(removeDupes, array_get(ds_map_find_value(global.PlayerSave, "unlockedItems"), i)))
        {
            array_push(removeDupes, array_get(ds_map_find_value(global.PlayerSave, "unlockedItems"), i));
        }
    }
    ds_map_set(global.PlayerSave, "unlockedItems", removeDupes);
}

function UnpackCharacterUnlocks()
{
    var characterUnlocks = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "characters")) && ds_exists(ds_map_find_value(global.PlayerSave, "characters"), ds_type_list))
    {
        var GMDSListBullshit = array_create();
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "characters")); i++)
        {
            var char = ds_list_find_value(ds_map_find_value(global.PlayerSave, "characters"), i);
            var charArray = [ds_list_find_value(char, 0), ds_list_find_value(char, 1)];
            array_push(characterUnlocks, charArray);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "characters"));
        ds_map_set(global.PlayerSave, "characters", characterUnlocks);
    }
    instance_create_depth(x, y, depth, obj_TextController);
    instance_create_depth(x, y, depth, obj_CharacterData);
    if (ds_map_size(global.characterData) != array_length(ds_map_find_value(global.PlayerSave, "characters")))
    {
        var key = ds_map_find_first(global.characterData);
        var size = ds_map_size(global.characterData);
        for (var i = 0; i < size; i++)
        {
            var found = false;
            for (var j = 0; j < array_length(ds_map_find_value(global.PlayerSave, "characters")); j++)
            {
                if (key == array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), j), 0))
                {
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                array_push(ds_map_find_value(global.PlayerSave, "characters"), [key, 0]);
            }
            key = ds_map_find_next(global.characterData, key);
        }
    }
    var newArray = [];
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        var exists = false;
        for (var j = 0; j < array_length(newArray); j++)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == newArray[j][0])
            {
                exists = true;
                newArray[j][1] += array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1);
            }
        }
        if (!exists)
        {
            array_push(newArray, array_get(ds_map_find_value(global.PlayerSave, "characters"), i));
        }
    }
    ds_map_set(global.PlayerSave, "characters", newArray);
    show_debug_message("FINAL CHAR ARRAY: " + string(newArray));
}

function UnpackTears()
{
    show_debug_message("loading tears");
    show_debug_message(ds_map_find_value(global.PlayerSave, "tears"));
    var tearsCheck = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "tears")) && ds_exists(ds_map_find_value(global.PlayerSave, "tears"), ds_type_list))
    {
        var GMDSListBullshit = array_create();
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "tears")); i++)
        {
            var gen = ds_list_find_value(ds_map_find_value(global.PlayerSave, "tears"), i);
            var genArray = [ds_list_find_value(gen, 0), ds_list_find_value(gen, 1)];
            array_push(tearsCheck, genArray);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "tears"));
    }
    else
    {
        tearsCheck = ds_map_find_value(global.PlayerSave, "tears");
    }
    var completeGroups = ["myth", "councilHope", "gamers", "gen0", "gen1", "gen2", "id1", "id2", "id3"];
    var genCheck = false;
    for (var g = 0; g < array_length(completeGroups); g++)
    {
        genCheck = false;
        for (var i = 0; i < array_length(tearsCheck); i++)
        {
            if (tearsCheck[i][0] == completeGroups[g])
            {
                genCheck = true;
                break;
            }
        }
        if (!genCheck)
        {
            array_push(tearsCheck, [completeGroups[g], 0]);
        }
    }
    ds_map_set(global.PlayerSave, "tears", tearsCheck);
    show_debug_message(ds_map_find_value(global.PlayerSave, "tears"));
}

function UnpackOutfits()
{
    var outfitUnlocks = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "unlockedOutfits")) && ds_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), ds_type_list))
    {
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "unlockedOutfits")); i++)
        {
            var outfit = ds_list_find_value(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), i);
            array_push(outfitUnlocks, outfit);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "unlockedOutfits"));
        ds_map_set(global.PlayerSave, "unlockedOutfits", outfitUnlocks);
    }
    show_debug_message(ds_map_find_value(global.PlayerSave, "unlockedOutfits"));
}

function UnpackStages()
{
    var stageUnlocks = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "unlockedStages")) && ds_exists(ds_map_find_value(global.PlayerSave, "unlockedStages"), ds_type_list))
    {
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "unlockedStages")); i++)
        {
            var stage = ds_list_find_value(ds_map_find_value(global.PlayerSave, "unlockedStages"), i);
            array_push(stageUnlocks, stage);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "unlockedStages"));
        ds_map_set(global.PlayerSave, "unlockedStages", stageUnlocks);
    }
    show_debug_message(ds_map_find_value(global.PlayerSave, "unlockedStages"));
}

function UnpackStageCompletion()
{
    var stageCheck = array_create();
    if (!is_array(ds_map_find_value(global.PlayerSave, "completedStages")) && ds_exists(ds_map_find_value(global.PlayerSave, "completedStages"), ds_type_list))
    {
        var GMDSListBullshit = array_create();
        for (var i = 0; i < ds_list_size(ds_map_find_value(global.PlayerSave, "completedStages")); i++)
        {
            var stage = ds_list_find_value(ds_map_find_value(global.PlayerSave, "completedStages"), i);
            var charArray = [];
            for (var j = 0; j < ds_list_size(ds_list_find_value(stage, 1)); j++)
            {
                array_push(charArray, ds_list_find_value(ds_list_find_value(stage, 1), j));
            }
            var stageArray = [ds_list_find_value(stage, 0), charArray];
            array_push(stageCheck, stageArray);
        }
        ds_list_destroy(ds_map_find_value(global.PlayerSave, "completedStages"));
        ds_map_set(global.PlayerSave, "completedStages", stageCheck);
    }
    if (array_length(global.stageIDNames) != array_length(ds_map_find_value(global.PlayerSave, "completedStages")))
    {
        for (var i = 0; i < array_length(global.stageIDNames); i++)
        {
            var found = false;
            for (var j = 0; j < array_length(ds_map_find_value(global.PlayerSave, "completedStages")); j++)
            {
                if (global.stageIDNames[i] == array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), j), 0))
                {
                    found = true;
                }
            }
            if (!found)
            {
                array_push(ds_map_find_value(global.PlayerSave, "completedStages"), [global.stageIDNames[i], []]);
                show_debug_message("MISSING STAGE, PUSHING");
            }
        }
    }
    show_debug_message(ds_map_find_value(global.PlayerSave, "completedStages"));
}

function LoadPlayerSave()
{
    try
    {
        var fileLoaded = false;
        if (file_exists("save_n.dat"))
        {
            global.PlayerSave = new_ds_map_secure_load("save_n.dat");
            fileLoaded = true;
        }
        else if (file_exists("save.dat"))
        {
            global.PlayerSave = ds_map_secure_load("save.dat");
            file_rename("save.dat", "backup.dat");
            fileLoaded = true;
        }
        else if (file_exists("backup.dat"))
        {
            global.PlayerSave = ds_map_secure_load("backup.dat");
            fileLoaded = true;
        }
        else if (file_exists("backup_save_n.dat"))
        {
            global.PlayerSave = ds_map_secure_load("backup_save_n.dat");
            fileLoaded = true;
        }
        show_debug_message(global.PlayerSave);
        if (is_undefined(ds_map_find_value(global.PlayerSave, "randomMoneyKey")))
        {
            ds_map_set(global.PlayerSave, "randomMoneyKey", 0);
        }
        if (is_undefined(ds_map_find_value(global.PlayerSave, "holoCoins")))
        {
            ds_map_set(global.PlayerSave, "holoCoins", 0);
        }
        ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + ds_map_find_value(global.PlayerSave, "randomMoneyKey"));
        ds_map_set(global.PlayerSave, "holoCoins", floor(ds_map_find_value(global.PlayerSave, "holoCoins")));
        CheckPlayerSave();
        UnpackCharacterUnlocks();
        UnpackTears();
        UnpackWeapons();
        UnpackItems();
        UnpackCollabs();
        UnpackOutfits();
        UnpackStages();
        UnpackStageCompletion();
        DetermineFollowings();
        RetroactiveUnlocks();
    }
    catch (e)
    {
        if (file_exists("backup_save_n.dat"))
        {
            global.PlayerSave = ds_map_secure_load("backup_save_n.dat");
            var fileLoaded = true;
        }
        CheckPlayerSave();
        UnpackCharacterUnlocks();
        UnpackTears();
        UnpackWeapons();
        UnpackItems();
        UnpackCollabs();
        UnpackOutfits();
        UnpackStages();
        UnpackStageCompletion();
        DetermineFollowings();
        RetroactiveUnlocks();
        show_debug_message("Error loading save file, trying backup: " + e.message);
    }
}

function StageClearCheck(arg0, arg1)
{
    var cleared = true;
    for (var i = 0; i < array_length(arg0); i++)
    {
        var stage = ds_map_find_value(global.stages, array_get(array_get(arg0, i), 0));
        if (stage.stageType == UnknownEnum.Value_0)
        {
            if (!array_exists(arg0[i][1], arg1))
            {
                cleared = false;
                break;
            }
        }
    }
    return cleared;
}

function FollowingConditions(arg0)
{
    var indexNum = -1;
    var status = 0;
    for (var i = 0; i < array_length(global.characterFollowings); i++)
    {
        if (global.characterFollowings[i][0] == arg0)
        {
            indexNum = i;
            break;
        }
    }
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "fandomEXP")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 0) == arg0)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1) >= 100)
            {
                status = 3;
            }
            else if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1) >= 66)
            {
                status = 2;
            }
            else if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1) >= 33)
            {
                status = 1;
            }
            else
            {
                status = 0;
            }
        }
    }
    if (status == 3)
    {
        DoAchievement(global.characterFollowings[indexNum][0] + "Gachikoi");
    }
    global.characterFollowings[indexNum][1] = status;
}

function CheckPreviousFandom(arg0)
{
    var index = -1;
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "fandomEXP")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 0) == arg0)
        {
            index = i;
        }
    }
    if (index > -1)
    {
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
        {
            if (arg0 == array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0))
            {
                array_set(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1) + (min(20, array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1)) * 2));
            }
        }
        show_debug_message(array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1));
        var normalStages = [];
        var hardStages = [];
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "completedStages")); i++)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) != "")
            {
                if (string_pos("(HARD)", array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0)) != 0)
                {
                    array_push(hardStages, array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i));
                }
                else if (string_pos("TIME", array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0)) == 0)
                {
                    array_push(normalStages, array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i));
                }
            }
        }
        for (var i = 0; i < array_length(normalStages); i++)
        {
            var stage = ds_map_find_value(global.stages, array_get(array_get(normalStages, i), 0));
            if (stage.stageType == UnknownEnum.Value_0)
            {
                if (array_exists(normalStages[i][1], arg0))
                {
                    array_set(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1) + 15);
                }
            }
        }
        show_debug_message(array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1));
        for (var i = 0; i < array_length(hardStages); i++)
        {
            var stage = ds_map_find_value(global.stages, array_get(array_get(hardStages, i), 0));
            if (stage.stageType == UnknownEnum.Value_0)
            {
                if (array_exists(hardStages[i][1], arg0))
                {
                    array_set(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1) + 20);
                }
            }
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1) > 100)
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), index), 1, 100);
        }
    }
}

function DetermineFollowings()
{
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "empty" && array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "random")
        {
            var found = false;
            for (var j = 0; j < array_length(ds_map_find_value(global.PlayerSave, "fandomEXP")); j++)
            {
                if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), j), 0) == array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0))
                {
                    found = true;
                }
            }
            if (!found)
            {
                array_push(ds_map_find_value(global.PlayerSave, "fandomEXP"), [array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0), 0]);
                CheckPreviousFandom(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0));
            }
        }
    }
    show_debug_message("Fandom EXP");
    show_debug_message(ds_map_find_value(global.PlayerSave, "fandomEXP"));
    global.characterFollowings = [];
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "empty" && array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) != "random")
        {
            array_push(global.characterFollowings, [array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0), 0]);
            FollowingConditions(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0));
        }
    }
    show_debug_message(global.characterFollowings);
    SavePlayerSave();
}

function SavePlayerSave()
{
    if (global.isResettingSave)
    {
        exit;
    }
    show_debug_message("Saving...");
    ds_map_set(global.PlayerSave, "GameVersionNumberMajor", 0.6);
    ds_map_set(global.PlayerSave, "GameVersionNumberMinor", floor(date_second_span(25569, 45155.38859257825)));
    if (is_undefined(ds_map_find_value(global.PlayerSave, "holoCoins")))
    {
        ds_map_set(global.PlayerSave, "holoCoins", 0);
    }
    var tempMoney = ds_map_find_value(global.PlayerSave, "holoCoins");
    var randomMoneyKey = 10 + irandom(1000);
    ds_map_set(global.PlayerSave, "randomMoneyKey", randomMoneyKey);
    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") - randomMoneyKey);
    if (instance_exists(obj_Achievements) && variable_global_exists("achievementsMap"))
    {
        obj_Achievements.SaveAchievements();
    }
    new_ds_map_secure_save(global.PlayerSave, "save_n.dat");
    ds_map_set(global.PlayerSave, "holoCoins", tempMoney);
    show_debug_message("Major: " + string(ds_map_find_value(global.PlayerSave, "GameVersionNumberMajor")));
    show_debug_message("Minor: " + string(ds_map_find_value(global.PlayerSave, "GameVersionNumberMinor")));
}

function RetroactiveUnlocks()
{
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "completedStages")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 1")
        {
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2", "STAGE");
            }
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 2")
        {
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3", "STAGE");
            }
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 3")
        {
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "TIME STAGE 1", "STAGE");
                ds_map_set(global.PlayerSave, "timeModeUnlocked", true);
            }
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 1 (HARD)")
        {
            show_debug_message("testing stage 1 hard");
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2 (HARD)", "STAGE");
            }
        }
    }
}

function CheckPlayerSave()
{
    if (ds_exists(global.PlayerSave, ds_type_map))
    {
        if (!ds_map_exists(global.PlayerSave, "characters"))
        {
            SetFirstCharacterData();
        }
        var key = ds_map_find_first(global.defaultPlayerSave);
        while (!is_undefined(key))
        {
            if (!ds_map_exists(global.PlayerSave, key))
            {
                ds_map_set(global.PlayerSave, key, ds_map_find_value(global.defaultPlayerSave, key));
            }
            key = ds_map_find_next(global.defaultPlayerSave, key);
        }
    }
}

global.defaultPlayerSave = ds_map_create();
ds_map_set(global.defaultPlayerSave, "HP", 0);
ds_map_set(global.defaultPlayerSave, "ATK", 0);
ds_map_set(global.defaultPlayerSave, "SPD", 0);
ds_map_set(global.defaultPlayerSave, "crit", 0);
ds_map_set(global.defaultPlayerSave, "pickupRange", 0);
ds_map_set(global.defaultPlayerSave, "haste", 0);
ds_map_set(global.defaultPlayerSave, "regen", 0);
ds_map_set(global.defaultPlayerSave, "specUnlock", 0);
ds_map_set(global.defaultPlayerSave, "specCDR", 0);
ds_map_set(global.defaultPlayerSave, "EXP", 0);
ds_map_set(global.defaultPlayerSave, "food", 0);
ds_map_set(global.defaultPlayerSave, "moneyGain", 0);
ds_map_set(global.defaultPlayerSave, "reroll", 0);
ds_map_set(global.defaultPlayerSave, "eliminate", 0);
ds_map_set(global.defaultPlayerSave, "holoCoins", 0);
ds_map_set(global.defaultPlayerSave, "randomMoneyKey", 0);
ds_map_set(global.defaultPlayerSave, "unlockedCharacters", 0);
ds_map_set(global.defaultPlayerSave, "seenCollabs", []);
ds_map_set(global.defaultPlayerSave, "challenge", 0);
ds_map_set(global.defaultPlayerSave, "enhanceUp", 0);
ds_map_set(global.defaultPlayerSave, "mobUp", 0);
ds_map_set(global.defaultPlayerSave, "DR", 0);
ds_map_set(global.defaultPlayerSave, "GROff", 0);
ds_map_set(global.defaultPlayerSave, "growth", 0);
ds_map_set(global.defaultPlayerSave, "skillDamage", 0);
ds_map_set(global.defaultPlayerSave, "enchantments", 0);
ds_map_set(global.defaultPlayerSave, "stamps", 0);
ds_map_set(global.defaultPlayerSave, "weaponLimit", 0);
ds_map_set(global.defaultPlayerSave, "itemLimit", 0);
ds_map_set(global.defaultPlayerSave, "noCollabs", 0);
ds_map_set(global.defaultPlayerSave, "noSupers", 0);
ds_map_set(global.defaultPlayerSave, "fandom", 0);
ds_map_set(global.defaultPlayerSave, "fandomEXP", []);
ds_map_set(global.defaultPlayerSave, "characters", []);
ds_map_set(global.defaultPlayerSave, "timeModeUnlocked", 0);
ds_map_set(global.defaultPlayerSave, "unlockedWeapons", ["PsychoAxe", "Glowstick", "SpiderCooking", "Tailplug", "BLBook", "EliteLava", "HoloBomb"]);
ds_map_set(global.defaultPlayerSave, "unlockedItems", ["BodyPillow", "FullMeal", "PikiPikiPiman", "SuccubusHorn", "Headphones", "UberSheep", "HolyMilk", "Sake", "FaceMask"]);
ds_map_set(global.defaultPlayerSave, "tears", [["myth", 0], ["councilHope", 0], ["gamers", 0], ["gen0", 0], ["gen1", 0], ["gen2", 0], ["id1", 0], ["id2", 0], ["id3", 0]]);
ds_map_set(global.defaultPlayerSave, "unlockedOutfits", ["default"]);
ds_map_set(global.defaultPlayerSave, "unlockedStages", ["STAGE 1"]);
ds_map_set(global.defaultPlayerSave, "completedStages", [["STAGE 1", []], ["STAGE 2", []], ["STAGE 1 (HARD)", []], ["STAGE 3", []]]);
ds_map_set(global.defaultPlayerSave, "characterClears", []);
ds_map_set(global.defaultPlayerSave, "achievements", -1);
ds_map_set(global.defaultPlayerSave, "holoHouseFloor", -1);
ds_map_set(global.defaultPlayerSave, "holoHouseWall", -1);
ds_map_set(global.defaultPlayerSave, "holoHouseSet", {});
ds_map_set(global.defaultPlayerSave, "fishRod", 0);
ds_map_set(global.defaultPlayerSave, "rodUnlock", [1, 0, 0, 0, 0, 0]);
ds_map_set(global.defaultPlayerSave, "fishSand", 0);
ds_map_set(global.defaultPlayerSave, "inventory", []);
ds_map_set(global.defaultPlayerSave, "unlockedFurniture", []);
ds_map_set(global.defaultPlayerSave, "farmPlants", []);
ds_map_set(global.defaultPlayerSave, "trackedTime", 0);
ds_map_set(global.defaultPlayerSave, "manageWorkers", []);
ds_map_set(global.defaultPlayerSave, "manageLevel", 1);
ds_map_set(global.defaultPlayerSave, "manageEXP", 0);
ds_map_set(global.defaultPlayerSave, "cookingOn", true);
ds_map_set(global.defaultPlayerSave, "currentFood", ["", 0]);
ds_map_set(global.defaultPlayerSave, "autoCook", "");
ds_map_set(global.defaultPlayerSave, "firstTime", true);
global.firstTime = true;

function ResetPlayerSave()
{
    global.isResettingSave = true;
    show_debug_message("RESETTING SAVE");
    if (file_exists("save.dat"))
    {
        file_delete("save.dat");
    }
    if (file_exists("save_n.dat"))
    {
        file_delete("save_n.dat");
    }
    if (file_exists("backup.dat"))
    {
        file_delete("backup.dat");
    }
    if (file_exists("backup_save_n.dat"))
    {
        file_delete("backup_save_n.dat");
    }
    if (file_exists(working_directory + "settings.json"))
    {
        show_debug_message("settings found");
        file_delete(working_directory + "settings.json");
    }
    if (file_exists("settings.json"))
    {
        show_debug_message("settings found2");
        file_delete("settings.json");
    }
    game_end();
}

function pseudo_game_restart()
{
    with (all)
    {
        event_perform(ev_other, ev_game_end);
        instance_destroy();
    }
    var language = global.CurrentLanguage;
    audio_stop_all();
    room_goto(rm_CharSelect);
    game_restart();
    global.CurrentLanguage = language;
}

enum UnknownEnum
{
    Value_0
}
