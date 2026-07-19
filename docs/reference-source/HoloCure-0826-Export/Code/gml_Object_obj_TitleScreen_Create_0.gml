version = global.version;
if (!variable_global_exists("lastTitleOption"))
{
    global.lastTitleOption = 0;
}
if (!audio_is_playing(global.bgmPlay) && !global.debug)
{
    audio_stop_sound(global.bgmPlay);
    audio_play_sound(global.bgmPlay, 0, 1);
}
if (!audio_is_playing(bgm_SSS))
{
    audio_stop_sound(global.bgmPlay);
    global.bgmPlay = 183;
    audio_play_sound(global.bgmPlay, 0, 1);
}
currentOption = global.lastTitleOption;
canControl = false;
alarm[0] = 5;
display_set_gui_size(1280, 720);
idletime = 0;
global.holoHouseMode = false;
lifetime = 0;
titleY = 0;
holoHouseUnlocked = array_exists(ds_map_find_value(global.PlayerSave, "unlockedStages"), "HOLO HOUSE");

function Confirmed()
{
    idletime = 0;
    if (canControl)
    {
        switch (currentOption)
        {
            case 0:
                room_goto(rm_CharSelect);
                global.lastTitleOption = currentOption;
                break;
            case 1:
                if (holoHouseUnlocked)
                {
                    room_goto(rm_CharSelect);
                    global.holoHouseMode = true;
                    global.lastTitleOption = currentOption;
                }
                break;
            case 2:
                room_goto(rm_Shop);
                global.lastTitleOption = currentOption;
                break;
            case 3:
                room_goto(rm_HiScores);
                global.lastTitleOption = currentOption;
                break;
            case 4:
                room_goto(rm_Achievements);
                global.lastTitleOption = currentOption;
                break;
            case 5:
                instance_create_depth(x, y, depth - 100, obj_Options);
                canControl = false;
                global.lastTitleOption = currentOption;
                break;
            case 6:
                instance_create_depth(x, y, depth - 100, obj_Credits);
                canControl = false;
                global.lastTitleOption = currentOption;
                break;
            case 7:
                game_end();
                break;
        }
        audio_play_sound(snd_menu_confirm, 30, 0);
    }
}

function ReturnMenu()
{
}

function SelectLeft()
{
    idletime = 0;
}

function SelectRight()
{
    idletime = 0;
}

function SelectUp()
{
    idletime = 0;
    if (canControl)
    {
        if (currentOption > 0)
        {
            currentOption--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (currentOption == 0)
        {
            currentOption = 7;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectDown()
{
    idletime = 0;
    if (canControl)
    {
        if (currentOption < 7)
        {
            currentOption++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (currentOption == 7)
        {
            currentOption = 0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

DetermineFollowings();
if (ds_map_find_value(global.PlayerSave, "holoCoins") >= 5000)
{
    DoAchievement("SCT");
    UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "SuperChattoTime", "ITEM");
}
if (ds_map_find_value(global.PlayerSave, "holoCoins") >= 1000000)
{
    DoAchievement("grind");
}
instance_create_depth(x, y, 0, obj_AttackController);
CheckArmouryMaxed();
