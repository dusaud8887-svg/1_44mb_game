show_debug_message("init achievements");
achievementArray = [];
achievementUpdate = true;
showingIndex = 0;
canControl = true;
achievementType = 0;
achievementSeparated = [];
achievementPopUps = [];
popUpContainer = [450, 360];
popUpTimer = 0;
popUpMoving = 0;
unlockedCount = 0;
achievementMode = 0;
currentOption = 0;
startingPosition = 0;
charOption = 0;
fireworksCD = 15;

function CheckPastAchievements()
{
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Halu"))
    {
        DoAchievement("delusional");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "ChickensFeather"))
    {
        DoAchievement("kiara10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "IdolCostume"))
    {
        DoAchievement("idolPower");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "InjectionAsacoco"))
    {
        DoAchievement("safeISwear");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "SuperChattoTime"))
    {
        DoAchievement("SCT");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "EnergyDrink"))
    {
        DoAchievement("calli10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Plushie"))
    {
        DoAchievement("bae10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "GorillasPaw"))
    {
        DoAchievement("firstboss");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "CreditCard"))
    {
        DoAchievement("timeToUpgrade");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "StudyGlasses"))
    {
        DoAchievement("lv50");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Bandaid"))
    {
        DoAchievement("fleshWound");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Membership"))
    {
        DoAchievement("buyingPower");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "GWSPill"))
    {
        DoAchievement("toohalu");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "PiggyBank"))
    {
        DoAchievement("payDay");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Limiter"))
    {
        DoAchievement("sana10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "HoloLaser"))
    {
        DoAchievement("midboss");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "IdolSong"))
    {
        DoAchievement("irys10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "CuttingBoard"))
    {
        DoAchievement("ina10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "XPotato"))
    {
        DoAchievement("korone10");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "WamyWater"))
    {
        DoAchievement("wamy");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "CEOTears"))
    {
        DoAchievement("secondboss");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3", "STAGE");
    }
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "ENCurse"))
    {
        DoAchievement("thirdboss");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 4", "STAGE");
    }
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "completedStages")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 1")
        {
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                DoAchievement("firstclear");
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "HOLO HOUSE", "STAGE");
            }
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 1 (HARD)")
        {
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                DoAchievement("1hard");
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2 (HARD)", "STAGE");
            }
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == "STAGE 2 (HARD)")
        {
            if (array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)) > 0)
            {
                DoAchievement("2hard");
                UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3 (HARD)", "STAGE");
            }
        }
    }
}

function ResetAchievements()
{
    ds_map_destroy(ACHIEVEMENTS);
    ACHIEVEMENTS = -1;
    event_user(0);
}

function UpdateAchievements()
{
    showingIndex = 0;
    unlockedCount = 0;
    achievementArray = array_create(ds_map_size(global.achievementsMap));
    achievementUpdate = false;
    var key = ds_map_find_first(global.achievementsMap);
    for (var i = 0; i < ds_map_size(global.achievementsMap); i++)
    {
        array_set(achievementArray, ds_map_find_value(global.achievementsMap, key).achievementNumber, ds_map_find_value(global.achievementsMap, key));
        key = ds_map_find_next(global.achievementsMap, key);
    }
    var generalArray = [];
    var characterArray = [];
    for (var i = 0; i < array_length(achievementArray); i++)
    {
        if (achievementArray[i].category == "general")
        {
            array_push(generalArray, achievementArray[i]);
        }
        else if (achievementArray[i].category == "character")
        {
            array_push(characterArray, achievementArray[i]);
        }
        if (achievementArray[i].unlocked)
        {
            unlockedCount++;
        }
    }
    achievementSeparated[0] = generalArray;
    achievementSeparated[1] = characterArray;
    if (unlockedCount == (array_length(achievementArray) - 1))
    {
        DoAchievement("allcomplete");
    }
}

function PopAchievement(arg0)
{
    array_push(achievementPopUps, arg0);
}

function SaveAchievements()
{
    var achievementData = {};
    var key = ds_map_find_first(global.achievementsMap);
    for (var i = 0; i < ds_map_size(global.achievementsMap); i++)
    {
        var theFlags = ds_map_find_value(global.achievementsMap, key).flags;
        var theUnlocked = ds_map_find_value(global.achievementsMap, key).unlocked;
        var dataStruct = 
        {
            flags: theFlags,
            unlocked: theUnlocked
        };
        variable_struct_set(achievementData, key, dataStruct);
        key = ds_map_find_next(global.achievementsMap, key);
    }
    ds_map_set(global.PlayerSave, "achievements", achievementData);
}

function LoadAchievements()
{
    if (ds_map_size(ACHIEVEMENTS) == 0)
    {
        event_user(0);
    }
    var keys = variable_struct_get_names(ds_map_find_value(global.PlayerSave, "achievements"));
    for (var i = 0; i < array_length(keys); i++)
    {
        var key = keys[i];
        if (ds_map_find_value(global.achievementsMap, key) != undefined)
        {
            ds_map_find_value(global.achievementsMap, key).flags = variable_struct_get(ds_map_find_value(global.PlayerSave, "achievements"), key).flags;
            ds_map_find_value(global.achievementsMap, key).unlocked = variable_struct_get(ds_map_find_value(global.PlayerSave, "achievements"), key).unlocked;
            if (ds_map_find_value(global.achievementsMap, key).unlocked)
            {
                if (!extension_stubfunc_real(key))
                {
                    extension_stubfunc_real(key);
                }
            }
        }
    }
}

if (!variable_global_exists("achievementsMap"))
{
    event_user(0);
    if (ds_map_find_value(global.PlayerSave, "achievements") == -1)
    {
        ds_map_set(global.PlayerSave, "achievements", global.achievementsMap);
        SavePlayerSave();
    }
}
obj_Achievements.LoadAchievements();

function Confirmed()
{
    if (achievementMode == 0)
    {
        switch (currentOption)
        {
            case 0:
                achievementMode = 1;
                break;
            case 1:
                if (ds_map_find_value(global.PlayerSave, "fandom") > 0)
                {
                    achievementMode = 2;
                }
                break;
            case 2:
                ReturnMenu();
                break;
        }
    }
    audio_play_sound(snd_menu_confirm, 30, 0);
}

function ReturnMenu()
{
    if (achievementMode == 0)
    {
        if (room == rm_Achievements)
        {
            audio_play_sound(snd_menu_back, 30, 0);
            room_goto(rm_Title);
        }
    }
    else
    {
        achievementMode = 0;
        audio_play_sound(snd_menu_back, 30, 0);
    }
}

function SelectUp()
{
    if (achievementMode == 0 && currentOption > 0)
    {
        currentOption--;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (achievementMode == 1)
    {
        if (showingIndex > 0)
        {
            showingIndex--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (charOption > 0)
    {
        charOption--;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (startingPosition > 0)
    {
        startingPosition--;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectDown()
{
    if (achievementMode == 0 && currentOption < 2)
    {
        currentOption++;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (achievementMode == 1)
    {
        if ((showingIndex + 5) < array_length(achievementSeparated[achievementType]))
        {
            showingIndex++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (charOption < 4)
    {
        charOption++;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if ((charOption + startingPosition + 1) < (array_length(global.characterList) - 1))
    {
        startingPosition++;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectLeft()
{
    if (achievementMode == 1)
    {
        if (achievementType == 0)
        {
            achievementType = 1;
            audio_play_sound(snd_menu_select, 30, 0);
            showingIndex = 0;
        }
        else if (achievementType == 1)
        {
            achievementType = 0;
            audio_play_sound(snd_menu_select, 30, 0);
            showingIndex = 0;
        }
    }
}

function SelectRight()
{
    if (achievementMode == 1)
    {
        if (achievementType == 0)
        {
            achievementType = 1;
            audio_play_sound(snd_menu_select, 30, 0);
            showingIndex = 0;
        }
        else if (achievementType == 1)
        {
            achievementType = 0;
            audio_play_sound(snd_menu_select, 30, 0);
            showingIndex = 0;
        }
    }
}

function DrawAchievement(arg0, arg1, arg2)
{
    draw_set_font(Galmuri9);
    draw_set_alpha(0.5 + (!arg2.unlocked * 0.5));
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    var achievementName = arg2.achievementName;
    if (!arg2.unlocked)
    {
        achievementName = "?????";
    }
    draw_text_color(arg0 + 45, arg1 + 4, achievementName, c_yellow, c_yellow, c_yellow, c_yellow, 0.5 + (!arg2.unlocked * 0.5));
    if (arg2.achievementIcon > 0)
    {
        if (arg2.unlocked || global.debug)
        {
            draw_sprite_ext(arg2.achievementIcon, 0, arg0 + 23, arg1 + 26, 1, 1, 0, c_white, 0.5 + (!arg2.unlocked * 0.5));
        }
        else
        {
            draw_sprite_ext(spr_UnknownIcon, 0, arg0 + 23, arg1 + 26, 1, 1, 0, c_white, 0.5 + (!arg2.unlocked * 0.5));
        }
    }
    draw_sprite_ext(hud_optionIconCase, 0, arg0 + 24, arg1 + 27, 1, 1, 0, c_white, 0.5 + (!arg2.unlocked * 0.5));
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    var desc = arg2.achievementDescription;
    draw_text_scribble_ext(arg0 + 55, arg1 + 22, desc, 250, 13, undefined, 0.5 + (!arg2.unlocked * 0.5));
    if (arg2.reward != -1)
    {
        if (is_array(arg2.reward))
        {
            draw_sprite_ext(arg2.reward[0], 0, arg0 + 322, arg1 + 23, 1, 1, 0, c_white, 0.5 + (!arg2.unlocked * 0.5));
            draw_set_font(buffFont_tiny);
            draw_set_halign(fa_center);
            draw_set_alpha(0.5 + (!arg2.unlocked * 0.5));
            draw_text(arg0 + 323, arg1 + 37, arg2.reward[1]);
            draw_set_alpha(1);
        }
        else
        {
            draw_sprite_ext(arg2.reward, 0, arg0 + 322, arg1 + 26, 1, 1, 0, c_white, 0.5 + (!arg2.unlocked * 0.5));
            draw_sprite_ext(spr_optionUnlockIcon, 0, arg0 + 323, arg1 + 27, 1, 1, 0, c_white, 0.5 + (!arg2.unlocked * 0.5));
        }
    }
    if (arg2.unlocked)
    {
        draw_sprite(spr_shopLevels_Maxed, 0, arg0 + 323, arg1 + 27);
    }
    draw_set_alpha(1);
}

function DrawPopUp(arg0, arg1, arg2)
{
    depth = -5000;
    draw_set_font(Galmuri9);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    var achievementName = arg2.achievementName;
    if (global.CurrentLanguage == "eng")
    {
        if (string_length(achievementName) > 10)
        {
            achievementName = string_copy(achievementName, 1, 10) + "...";
        }
    }
    else if (global.CurrentLanguage == "jp")
    {
        achievementName = string_copy(achievementName, 1, 5) + "...";
    }
    draw_text_color(arg0 + 83, arg1 + 4, achievementName, c_yellow, c_yellow, c_yellow, c_yellow, 15);
    if (arg2.achievementIcon > 0)
    {
        draw_sprite_ext(arg2.achievementIcon, 0, arg0 + 23, arg1 + 26, 1, 1, 0, c_white, 1);
    }
    draw_sprite_ext(hud_optionIconCase, 0, arg0 + 24, arg1 + 27, 1, 1, 0, c_white, 1);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    var desc = "Achievement\nGET!";
    draw_text_scribble_ext(arg0 + 83, arg1 + 21, desc, 300, 13, undefined, 1);
    draw_set_alpha(1);
}

CheckPastAchievements();
