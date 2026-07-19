audio_group_load(2);
audio_group_load(1);
global.version = string_replace_all(string_format(0.6, 4, 1), " ", "") + "." + string(floor(date_second_span(25569, 45155.38859257825)));
ini_open(program_directory + "version.ini");
show_debug_message(program_directory);
ini_write_string("Version", "version", global.version);
ini_close();
global.debug = debug_mode;
global.fullscreen = false;
global.showDamageText = true;
global.lightFX = true;
global.screenshake = true;
global.unlockedNew = false;
global.unlockedThings = [];
global.lives = 1;
global.playingMode = 0;
global.CurrentLanguage = "eng";
global.hiscorenames = true;
global.username = "Player";
global.readyToStart = false;
global.screen_resolution_x = 1280;
global.screen_resolution_y = 720;
global.soundVolume = 0.6;
global.musicVolume = 0.4;
global.attackAlpha = 1;
global.dynamicLighting = true;
global.portDisplay = 1;
global.hideFullHP = 1;
global.showHUDHP = 1;
global.showHPVal = 1;
global.aboveHP = 1;
global.showSkillRadius = 1;
global.vibration = 1;
global.hhCustomNames = true;
global.showStamps = true;
global.hhMessages = true;
global.hiscoreName = true;
audio_group_set_gain(1, global.musicVolume, 0);
global.showDamageText = true;
if (!variable_global_exists("theButtons"))
{
    global.theButtons = [];
}
if (!variable_global_exists("controllerButtons"))
{
    global.controllerButtons = [];
}
global.seenCollabs = [];
global.tears = [];
global.unlockedStages = [];
display_set_gui_size(640, 360);
global.lastSubmitUID = -1;
global.readyToStart = false;
if (debug_mode)
{
    show_debug_overlay(1);
}
global.gamepadSpeedMultiplier = 1;
global.characterFollowings = [];
global.refreshAchievements = false;
nameOkay = false;
image_speed = 0.05;
delete_timer = 0;
inputText = "Player";
getTextManager = -1;
initStep = 0;
currentOption = 0;
langOption = 0;
canType = false;
hnShow = 0;
useName = 0;
initLangOptions = ["English", "한국어", "Indonesia"];
rectTime = 0;
rectVis = true;
cursor_sprite = 2428;
window_set_cursor(cr_none);
global.wrappingStage = true;
global.characterList = ["ame", "gura", "ina", "kiara", "calli", "bae", "kronii", "fauna", "mumei", "sana", "irys", "fubuki", "mio", "okayu", "korone", "sora", "azki", "roboco", "suisei", "miko", "haato", "mel", "matsuri", "aki", "subaru", "choco", "shion", "ayame", "aqua", "moona", "risu", "iofi", "ollie", "reine", "anya", "kobo", "kaela", "zeta", "random"];
global.Resolution = 1;
depth = -500;
instance_create_depth(x, y, depth, obj_TextController);
StageDataSetStages();
scribble_font_set_default("jpFont");

function SetResolution(arg0, arg1)
{
    global.screen_resolution_x = arg0;
    global.screen_resolution_y = arg1;
    show_debug_message("setting resolutions: " + string(global.screen_resolution_x));
    window_set_size(global.screen_resolution_x, global.screen_resolution_y);
    surface_resize(application_surface, global.screen_resolution_x, global.screen_resolution_y);
}

global.isResettingSave = false;
InitialPlayerSaveLoad();
LoadSettings();
audio_group_set_gain(1, global.musicVolume, 0);
audio_group_set_gain(2, global.soundVolume, 0);
CustomColors();
FoodRecipes();

function EnterKey()
{
    if (initStep == 1)
    {
        if (!nameOkay)
        {
            nameOkay = CheckName(inputText);
            if (!nameOkay)
            {
                inputText = "";
            }
        }
        if (inputText != "" && nameOkay)
        {
            initStep = 2;
            currentOption = 0;
            global.username = inputText;
            SaveSettings();
        }
    }
    else if (initStep == 0 || initStep == 2 || initStep == 3 || initStep == 4)
    {
        Confirmed();
    }
}

function Confirmed()
{
    show_debug_message("initstep: " + string(initStep));
    if (initStep == 0)
    {
        switch (currentOption)
        {
            case 0:
                global.CurrentLanguage = "eng";
                langOption = 0;
                break;
            case 1:
                global.CurrentLanguage = "jp";
                langOption = 1;
                break;
            case 2:
                global.CurrentLanguage = "Id";
                langOption = 2;
                break;
        }
        if (instance_exists(getTextManager))
        {
            getTextManager.SetLanguage(global.CurrentLanguage);
            initStep++;
            audio_play_sound(snd_menu_confirm, 30, 0);
            keyboard_string = "";
            alarm[0] = 10;
        }
    }
    else if (initStep == 2)
    {
        switch (currentOption)
        {
            case 0:
                global.hiscorenames = true;
                hnShow = 0;
                break;
            case 1:
                global.hiscorenames = false;
                hnShow = 1;
                break;
        }
        initStep++;
        currentOption = 0;
        audio_play_sound(snd_menu_confirm, 30, 0);
    }
    else if (initStep == 3)
    {
        switch (currentOption)
        {
            case 0:
                global.hiscoreName = true;
                useName = 0;
                break;
            case 1:
                global.hiscoreName = false;
                useName = 1;
                break;
        }
        initStep++;
        currentOption = 0;
        audio_play_sound(snd_menu_confirm, 30, 0);
    }
    else if (initStep == 4)
    {
        switch (currentOption)
        {
            case 0:
                global.readyToStart = true;
                SetAnonymousHiscoreName(global.hiscoreName);
                SaveSettings();
                break;
            case 1:
                initStep = 0;
                nameOkay = false;
                break;
        }
        currentOption = 0;
        audio_play_sound(snd_menu_confirm, 30, 0);
    }
}

function ReturnMenu()
{
}

function SelectLeft()
{
}

function SelectRight()
{
}

function SelectUp()
{
    if (initStep == 0 || initStep == 2 || initStep == 3 || initStep == 4)
    {
        if (currentOption > 0)
        {
            currentOption--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectDown()
{
    if (initStep == 0 || initStep == 2 || initStep == 3 || initStep == 4)
    {
        if (initStep == 0)
        {
            if (currentOption < 2)
            {
                currentOption++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (currentOption < 1)
        {
            currentOption++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function CheckName(arg0)
{
    var check = true;
    var badWords = ["faggot", "nigger", "niggers", "penis", "vagina", "pussy", "whore", "chinks"];
    for (var i = 0; i < array_length(badWords); i++)
    {
        if (string_pos(badWords[i], string_lower(arg0)) > 0)
        {
            show_debug_message("found");
            check = false;
            break;
        }
    }
    if (string_lower(arg0) == "fag")
    {
        check = false;
    }
    return check;
}
