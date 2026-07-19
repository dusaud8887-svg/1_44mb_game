inGame = true;
if (room == rm_Title)
{
    inGame = false;
}
container[0] = 320;
container[1] = 48;
inputMan = instance_find(obj_InputManager, 0);
currentOption = 0;
playerMan = -1;
showOptionRange = 0;
changingName = 0;
deleteConfirm = false;
deleteOption = 0;
deleteSelect = 0;
canType = false;
editingName = "";
renameOption = 0;
delete_timer = 0;
rectVis = true;
rectTime = 0;
display_set_gui_size(640, 360);
changedSettings = false;
languageOptions = ["English", "한국어", "Indonesia"];
resolutionOptions = ["640 x 360", "1280 x 720", "1920 x 1080", "2560 x 1440"];
selectedResolution = global.Resolution;
switch (global.CurrentLanguage)
{
    case "eng":
        selectedLanguageOption = 0;
        break;
    case "jp":
        selectedLanguageOption = 1;
        break;
    case "Id":
        selectedLanguageOption = 2;
        break;
}
keybindMenu = false;
controllerMenu = false;
prevMenu = [0, 0];
remapping = false;
canControl = false;
alarm[0] = 10;
setAll = 0;
controllerSet = false;
controllerButtonList = [32769, 32770, 32771, 32772, 32773, 32775, 32774, 32776, 32778, 32777];
currentPositions = [0, 0, 0, 0, 0, 0];
maxOptions = [10 - (inGame * 1), 13];
optionPage = 0;
holdDeleteTimer = 180;

function HoldConfirm()
{
    if (deleteConfirm && deleteOption == 0)
    {
        holdDeleteTimer--;
    }
}

function ReleaseConfirm()
{
    if (deleteConfirm && deleteOption == 0)
    {
        holdDeleteTimer = 180;
    }
}

function GetCurrentController()
{
    for (var i = 0; i < 6; i++)
    {
        for (var j = 0; j < array_length(controllerButtonList); j++)
        {
            if (global.controllerButtons[i] == controllerButtonList[j])
            {
                currentPositions[i] = j;
            }
        }
    }
}

function Destroy()
{
    if (room == rm_Title)
    {
        var title = instance_find(obj_TitleScreen, 0);
        title.canControl = true;
        display_set_gui_size(1280, 720);
    }
    else
    {
        playerMan.pauseCurrentMenu = 0;
        playerMan.alarm[1] = 2;
    }
    instance_destroy();
}

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirmed();
        canControl = false;
        alarm[0] = 5;
    }
}

function Confirmed()
{
    if (canControl)
    {
        if (!keybindMenu && !controllerMenu)
        {
            if (optionPage == 0)
            {
                switch (currentOption + showOptionRange)
                {
                    case UnknownEnum.Value_0:
                        currentOption = 0;
                        optionPage = 1;
                        showOptionRange = 0;
                        break;
                    case UnknownEnum.Value_6:
                        var text = instance_find(obj_TextController, 0);
                        switch (selectedLanguageOption)
                        {
                            case 0:
                                text.SetLanguage(text.languages.English);
                                break;
                            case 1:
                                text.SetLanguage(text.languages.Japanese);
                                break;
                            case 2:
                                text.SetLanguage(text.languages.Indonesia);
                                break;
                        }
                        break;
                    case UnknownEnum.Value_3:
                        keybindMenu = true;
                        prevMenu = [currentOption, showOptionRange];
                        currentOption = 0;
                        showOptionRange = 0;
                        break;
                    case UnknownEnum.Value_4:
                        controllerMenu = true;
                        prevMenu = [currentOption, showOptionRange];
                        currentOption = 0;
                        showOptionRange = 0;
                        GetCurrentController();
                        break;
                    case UnknownEnum.Value_5:
                        global.vibration = !global.vibration;
                        break;
                    case UnknownEnum.Value_7:
                        global.hhCustomNames = !global.hhCustomNames;
                        break;
                    case UnknownEnum.Value_8:
                        global.hhMessages = !global.hhMessages;
                        break;
                    case UnknownEnum.Value_9:
                        if (deleteConfirm)
                        {
                            if (deleteOption == 1)
                            {
                                ReturnMenu();
                            }
                        }
                        else
                        {
                            deleteConfirm = true;
                            deleteOption = 1;
                        }
                        break;
                }
            }
            else
            {
                switch (currentOption + showOptionRange)
                {
                    case UnknownEnum.Value_0:
                        switch (selectedResolution)
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
                        global.Resolution = selectedResolution;
                        break;
                    case UnknownEnum.Value_1:
                        global.fullscreen = !global.fullscreen;
                        window_set_fullscreen(global.fullscreen);
                        break;
                    case UnknownEnum.Value_3:
                        global.showDamageText = !global.showDamageText;
                        break;
                    case UnknownEnum.Value_4:
                        global.lightFX = !global.lightFX;
                        break;
                    case UnknownEnum.Value_5:
                        global.screenshake = !global.screenshake;
                        break;
                    case UnknownEnum.Value_10:
                        global.hideFullHP = !global.hideFullHP;
                        break;
                    case UnknownEnum.Value_7:
                        global.showHUDHP = !global.showHUDHP;
                        break;
                    case UnknownEnum.Value_9:
                        global.aboveHP = !global.aboveHP;
                        break;
                    case UnknownEnum.Value_8:
                        global.showHPVal = !global.showHPVal;
                        break;
                    case UnknownEnum.Value_11:
                        global.showSkillRadius = !global.showSkillRadius;
                        break;
                    case UnknownEnum.Value_12:
                        global.showStamps = !global.showStamps;
                        break;
                }
            }
            SaveSettings();
            if (!(changingName && renameOption == -1))
            {
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
        }
        else if (controllerMenu)
        {
            var validKeys = true;
            for (var i = 0; i < 6; i++)
            {
                for (var j = 0; j < 6; j++)
                {
                    if (i != j)
                    {
                        if (currentPositions[i] == currentPositions[j])
                        {
                            validKeys = false;
                        }
                    }
                }
            }
            if (validKeys)
            {
                for (var i = 0; i < 6; i++)
                {
                    global.controllerButtons[i] = controllerButtonList[currentPositions[i]];
                }
                SaveSettings();
                SetControllerControls();
                controllerSet = true;
            }
            else
            {
                GetCurrentController();
            }
            audio_play_sound(snd_menu_confirm, 30, 0);
        }
        else if (!remapping)
        {
            remapping = true;
            keyboard_string = "";
            if (currentOption == 6)
            {
                setAll = 6;
                currentOption = 0;
                for (var i = 0; i < 6; i++)
                {
                    global.theButtons[i] = 0;
                }
            }
        }
    }
}

function ReturnMenu()
{
    if (changingName && renameOption == -1)
    {
        exit;
    }
    if (canControl)
    {
        if (deleteConfirm)
        {
            deleteConfirm = false;
        }
        else if (changingName)
        {
            changingName = false;
            canType = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else if (optionPage == 1)
        {
            optionPage = 0;
            currentOption = 0;
            showOptionRange = 0;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else if (!keybindMenu && !controllerMenu)
        {
            audio_play_sound(snd_menu_back, 30, 0);
            Destroy();
        }
        else if (controllerMenu)
        {
            controllerSet = false;
            audio_play_sound(snd_menu_back, 30, 0);
            controllerMenu = false;
            currentOption = prevMenu[0];
            showOptionRange = prevMenu[1];
        }
        else if (!remapping)
        {
            audio_play_sound(snd_menu_back, 30, 0);
            keybindMenu = false;
            currentOption = prevMenu[0];
            showOptionRange = prevMenu[1];
        }
    }
}

function SelectLeft()
{
    if (!keybindMenu && !controllerMenu && !changingName && !deleteConfirm)
    {
        if (optionPage == 0)
        {
            switch (currentOption + showOptionRange)
            {
                case UnknownEnum.Value_2:
                    if (global.soundVolume > 0)
                    {
                        global.soundVolume -= 0.1;
                    }
                    audio_group_set_gain(2, global.soundVolume, 0);
                    audio_play_sound(snd_menu_select, 30, 0);
                    SaveSettings();
                    break;
                case UnknownEnum.Value_1:
                    if (global.musicVolume > 0)
                    {
                        global.musicVolume -= 0.1;
                    }
                    audio_group_set_gain(1, global.musicVolume, 0);
                    SaveSettings();
                    break;
                case UnknownEnum.Value_6:
                    if (selectedLanguageOption > 0)
                    {
                        selectedLanguageOption--;
                    }
                    else
                    {
                        selectedLanguageOption = 2;
                    }
                    SaveSettings();
                    break;
            }
        }
        else if (optionPage == 1)
        {
            switch (currentOption + showOptionRange)
            {
                case UnknownEnum.Value_0:
                    if (selectedResolution > 0)
                    {
                        selectedResolution--;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    break;
                case UnknownEnum.Value_2:
                    if (global.attackAlpha > 0.3)
                    {
                        global.attackAlpha -= 0.1;
                    }
                    SaveSettings();
                    break;
                case UnknownEnum.Value_6:
                    global.portDisplay = !global.portDisplay;
                    SaveSettings();
                    break;
            }
        }
    }
    else if (deleteConfirm)
    {
        deleteOption = !deleteOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (controllerMenu && currentOption < 6)
    {
        if (currentPositions[currentOption] > 0)
        {
            currentPositions[currentOption]--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else
        {
            currentPositions[currentOption] = 9;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectRight()
{
    if (!keybindMenu && !controllerMenu && !changingName && !deleteConfirm)
    {
        if (optionPage == 0)
        {
            switch (currentOption + showOptionRange)
            {
                case UnknownEnum.Value_2:
                    if (global.soundVolume < 1)
                    {
                        global.soundVolume += 0.1;
                    }
                    audio_group_set_gain(2, global.soundVolume, 0);
                    audio_play_sound(snd_menu_select, 30, 0);
                    SaveSettings();
                    break;
                case UnknownEnum.Value_1:
                    if (global.musicVolume < 1)
                    {
                        global.musicVolume += 0.1;
                    }
                    audio_group_set_gain(1, global.musicVolume, 0);
                    SaveSettings();
                    break;
                case UnknownEnum.Value_6:
                    if (selectedLanguageOption < 2)
                    {
                        selectedLanguageOption++;
                    }
                    else
                    {
                        selectedLanguageOption = 0;
                    }
                    SaveSettings();
                    break;
            }
        }
        else if (optionPage == 1)
        {
            switch (currentOption + showOptionRange)
            {
                case UnknownEnum.Value_0:
                    if (selectedResolution < 3)
                    {
                        selectedResolution++;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    break;
                case UnknownEnum.Value_2:
                    if (global.attackAlpha < 1)
                    {
                        global.attackAlpha += 0.1;
                    }
                    SaveSettings();
                    break;
                case UnknownEnum.Value_6:
                    global.portDisplay = !global.portDisplay;
                    SaveSettings();
                    break;
            }
        }
    }
    else if (deleteConfirm)
    {
        deleteOption = !deleteOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (controllerMenu && currentOption < 6)
    {
        if (currentPositions[currentOption] < (array_length(controllerButtonList) - 1))
        {
            currentPositions[currentOption]++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else
        {
            currentPositions[currentOption] = 0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectUp()
{
    if (canControl)
    {
        if (currentOption == 0 && showOptionRange > 0 && !changingName && !deleteConfirm)
        {
            showOptionRange--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (currentOption > 0 && !remapping && !changingName && !deleteConfirm)
        {
            currentOption--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        if (controllerSet)
        {
            controllerSet = false;
        }
    }
}

function SelectDown()
{
    if (canControl)
    {
        if (!keybindMenu && !controllerMenu && !changingName && !deleteConfirm)
        {
            if (currentOption < 7 && (currentOption + showOptionRange) < (maxOptions[optionPage] - 1))
            {
                if (currentOption == 6 && (currentOption + showOptionRange) < (maxOptions[optionPage] - 1))
                {
                    showOptionRange++;
                }
                else
                {
                    currentOption++;
                }
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (controllerMenu)
        {
            if (currentOption < 6 && !remapping)
            {
                currentOption++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (currentOption < 6 && !remapping && !changingName && !deleteConfirm)
        {
            currentOption++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SetResolution(arg0, arg1)
{
    global.screen_resolution_x = arg0;
    global.screen_resolution_y = arg1;
    global.Resolution = (arg0 div 640) - 1;
    window_set_size(global.screen_resolution_x, global.screen_resolution_y);
    surface_resize(application_surface, global.screen_resolution_x, global.screen_resolution_y);
}

GetCurrentController();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12
}
