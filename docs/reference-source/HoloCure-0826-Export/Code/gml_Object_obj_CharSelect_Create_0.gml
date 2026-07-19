global.gameMode = -1;
global.charSelected = -1;
global.playingStage = -1;
modeOption = 0;
selectingAlpha = 0;
leftcontainer[0] = -280;
leftcontainer[1] = 30;
middlecontainer[0] = 0;
middlecontainer[1] = 0;
rightcontainer[0] = 920;
rightcontainer[1] = 30;
modecontainer[0] = 198;
modecontainer[1] = 120;
bottomcontainer[0] = 20;
bottomcontainer[1] = 220;
bottomcontainer0[0] = 320;
bottomcontainer0[1] = 370;
bottomcontainer2[0] = 320;
bottomcontainer2[1] = 120;
bottomcontainer3[0] = 960;
bottomcontainer3[1] = 120;
selectedCharacter = 0;
selectingGen = 0;
selectingChar = 0;
charAnim = 0;
characterInfo[0] = ds_map_find_value(global.characterData, "ame");
characterInfo[1] = ds_map_find_value(global.characterData, "gura");
characterInfo[2] = ds_map_find_value(global.characterData, "ina");
characterInfo[3] = ds_map_find_value(global.characterData, "kiara");
characterInfo[4] = ds_map_find_value(global.characterData, "calli");
availableOutfits = 0;
outfitSelect = 0;
choseOutfit = true;
randomSelect = 0;
randomDelay = 5;
foodOption = false;
randomAvailableCharacters = [];
global.outfitSelected = "default";
randomSelectSlot = -1;
selectedStage = 0;
canControl = false;
alarm[3] = 3;
StageDataSetStages();
availableStages = [];
availableTimeStages = [];
availableHouseStages = [];
DetermineFollowings();
extraPush = 0;
totalCharacter = array_length(global.characterList);
charListByGen = [];
charListByGen[0] = [];
charListByGen[1] = [];
charListByGen[2] = [];
charListByGen[3] = [];
for (var i = 0; i < array_length(global.stageIDNames); i++)
{
    if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedStages"), global.stageIDNames[i]))
    {
        stage = ds_map_find_value(global.stages, global.stageIDNames[i]);
        switch (stage.stageType)
        {
            case UnknownEnum.Value_0:
                array_push(availableStages, stage);
                break;
            case UnknownEnum.Value_1:
                array_push(availableTimeStages, stage);
                break;
            case UnknownEnum.Value_2:
                array_push(availableHouseStages, stage);
                break;
            default:
                show_error("STAGE_TYPE not handled: {0}", stage.stageType);
                break;
        }
    }
}
if (global.debug)
{
    for (var i = 0; i < array_length(global.stageIDNamesDebug); i++)
    {
        array_push(availableStages, ds_map_find_value(global.stages, global.stageIDNamesDebug[i]));
    }
}
showingStages = [global.stageIDNames[UnknownEnum.Value_1], global.stageIDNames[UnknownEnum.Value_2]];
for (var i = 0; i < array_length(showingStages); i++)
{
    var found = false;
    for (var j = 0; j < array_length(availableStages); j++)
    {
        if (availableStages[j].stageIDName == showingStages[i])
        {
            found = true;
        }
    }
    if (!found)
    {
        array_push(availableStages, ds_map_find_value(global.stages, array_get(showingStages, i)));
    }
}
readyToGo = false;
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
for (var i = 5; i < totalCharacter; i++)
{
    characterInfo[i] = ds_map_find_value(global.characterData, "empty");
}
for (var i = 5; i < (totalCharacter - 1); i++)
{
    for (var j = 0; j < array_length(ds_map_find_value(global.PlayerSave, "characters")); j++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), j), 0) == global.characterList[i] && array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), j), 1) > 0)
        {
            characterInfo[i] = ds_map_find_value(global.characterData, global.characterList[i]);
        }
    }
}
var charCount = 0;
for (var i = 0; i < 10; i++)
{
    array_push(charListByGen[0], characterInfo[charCount]);
    charCount++;
}
for (var i = 0; i < 10; i++)
{
    array_push(charListByGen[1], characterInfo[charCount]);
    charCount++;
}
for (var i = 0; i < 9; i++)
{
    array_push(charListByGen[2], characterInfo[charCount]);
    charCount++;
}
for (var i = 0; i < 9; i++)
{
    array_push(charListByGen[3], characterInfo[charCount]);
    charCount++;
}
groups[0] = "홀로미스";
groups[1] = "홀로카운슬";
groups[2] = "HOPE";
groups[3] = "JP 0";
groups[4] = "????";
for (var i = 0; i < array_length(characterInfo); i++)
{
    if (characterInfo[i] != ds_map_find_value(global.characterData, "empty") && characterInfo[i] != ds_map_find_value(global.characterData, "none") && characterInfo[i] != ds_map_find_value(global.characterData, "random"))
    {
        array_push(randomAvailableCharacters, i);
    }
}
alarm[2] = 120;

function Return()
{
    if (global.charSelected == -1)
    {
        room_goto(rm_Title);
        audio_play_sound(snd_menu_back, 30, 0);
    }
    else if (global.charSelected != -1 && !choseOutfit)
    {
        choseOutfit = true;
        availableOutfits = 1;
        global.charSelected = -1;
        audio_play_sound(snd_menu_back, 30, 0);
    }
    else if (global.gameMode == -1)
    {
        if (array_length(availableOutfits) > 1)
        {
            choseOutfit = false;
        }
        else
        {
            global.charSelected = -1;
        }
        audio_play_sound(snd_menu_back, 30, 0);
    }
    else if (global.playingStage == -1)
    {
        if (global.holoHouseMode)
        {
            choseOutfit = false;
            if (array_length(availableOutfits) == 1)
            {
                global.charSelected = -1;
                extraPush = 1;
            }
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else
        {
            audio_play_sound(snd_menu_back, 30, 0);
        }
        global.gameMode = -1;
    }
    else if (readyToGo)
    {
        readyToGo = false;
        global.playingStage = -1;
        audio_play_sound(snd_menu_back, 30, 0);
    }
}

function Left()
{
    if (global.charSelected == -1)
    {
        if (selectingChar > 0)
        {
            selectingChar--;
            CalculateChar();
            leftcontainer[0] = -280;
            rightcontainer[0] = 920;
            audio_play_sound(snd_charSelectWoosh, 0, 0);
        }
    }
    else if (global.charSelected != -1 && !choseOutfit)
    {
        if (outfitSelect == 0)
        {
            outfitSelect = array_length(availableOutfits) - 1;
        }
        else
        {
            outfitSelect--;
        }
        audio_play_sound(snd_charSelectWoosh, 0, 0);
    }
    else if (global.gameMode == -1 && choseOutfit)
    {
        if (modeOption > 0)
        {
            modeOption--;
            audio_play_sound(snd_menu_select, 0, 0);
        }
    }
    else if (global.gameMode != -1 && global.playingStage == -1 && choseOutfit)
    {
        var whichSet = -1;
        switch (global.gameMode)
        {
            case 0:
                whichSet = availableStages;
                break;
            case 1:
                whichSet = availableStages;
                break;
            case 2:
                whichSet = availableTimeStages;
                break;
            case 3:
                whichSet = availableHouseStages;
                break;
        }
        if (array_length(whichSet) > 1 && !foodOption)
        {
            if (selectedStage == 0)
            {
                selectedStage = array_length(whichSet) - 1;
                audio_play_sound(snd_charSelectWoosh, 0, 0);
            }
            else
            {
                selectedStage--;
                audio_play_sound(snd_charSelectWoosh, 0, 0);
            }
        }
    }
}

function Right()
{
    if (global.charSelected == -1)
    {
        if (selectingChar < (array_length(charListByGen[selectingGen]) - 1))
        {
            selectingChar++;
            CalculateChar();
            leftcontainer[0] = -280;
            rightcontainer[0] = 920;
            audio_play_sound(snd_charSelectWoosh, 0, 0);
        }
    }
    else if (global.charSelected != -1 && !choseOutfit)
    {
        if (outfitSelect == (array_length(availableOutfits) - 1))
        {
            outfitSelect = 0;
        }
        else
        {
            outfitSelect++;
        }
        audio_play_sound(snd_charSelectWoosh, 0, 0);
    }
    else if (global.gameMode == -1 && choseOutfit)
    {
        if (modeOption < (1 + ds_map_find_value(global.PlayerSave, "timeModeUnlocked")))
        {
            modeOption++;
            audio_play_sound(snd_menu_select, 0, 0);
        }
    }
    else if (global.gameMode != -1 && global.playingStage == -1 && choseOutfit)
    {
        var whichSet = -1;
        switch (global.gameMode)
        {
            case 0:
                whichSet = availableStages;
                break;
            case 1:
                whichSet = availableStages;
                break;
            case 2:
                whichSet = availableTimeStages;
                break;
            case 3:
                whichSet = availableHouseStages;
                break;
        }
        if (array_length(whichSet) > 1 && !foodOption)
        {
            if (selectedStage == (array_length(whichSet) - 1))
            {
                selectedStage = 0;
                audio_play_sound(snd_charSelectWoosh, 0, 0);
            }
            else
            {
                selectedStage++;
                audio_play_sound(snd_charSelectWoosh, 0, 0);
            }
        }
    }
}

function Up()
{
    if (global.charSelected == -1)
    {
        if (selectingGen > 0)
        {
            if (selectingChar == (array_length(charListByGen[selectingGen]) - 1))
            {
                selectingChar = array_length(charListByGen[selectingGen - 1]) - 1;
            }
            else if (selectingChar > (array_length(charListByGen[selectingGen - 1]) - 1))
            {
                selectingChar = array_length(charListByGen[selectingGen - 1]) - 1;
            }
            selectingGen--;
            CalculateChar();
            leftcontainer[0] = -280;
            rightcontainer[0] = 920;
            audio_play_sound(snd_charSelectWoosh, 0, 0);
        }
    }
    else if (global.playingStage == -1 && global.gameMode > -1 && global.gameMode < 3)
    {
        if (!readyToGo && array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 0) != "")
        {
            foodOption = !foodOption;
            audio_play_sound(snd_menu_select, 0, false);
        }
    }
}

function Down()
{
    if (global.charSelected == -1)
    {
        if (selectingGen < (array_length(charListByGen) - 1))
        {
            if (selectingChar == (array_length(charListByGen[selectingGen]) - 1))
            {
                selectingChar = array_length(charListByGen[selectingGen + 1]) - 1;
            }
            else if (selectingChar > (array_length(charListByGen[selectingGen + 1]) - 1))
            {
                selectingChar = array_length(charListByGen[selectingGen + 1]) - 1;
            }
            selectingGen++;
            CalculateChar();
            leftcontainer[0] = -280;
            rightcontainer[0] = 920;
            audio_play_sound(snd_charSelectWoosh, 0, 0);
        }
    }
    else if (global.playingStage == -1 && global.gameMode > -1 && global.gameMode < 2)
    {
        if (!readyToGo && array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 0) != "")
        {
            foodOption = !foodOption;
            audio_play_sound(snd_menu_select, 0, false);
        }
    }
}

function CalculateChar()
{
    var val = 0;
    var gens = 0;
    var chars = 0;
    while (gens < selectingGen)
    {
        val += array_length(charListByGen[gens]);
        gens++;
    }
    while (chars < selectingChar)
    {
        val++;
        chars++;
    }
    selectedCharacter = val;
}

function Select()
{
    if (canControl)
    {
        canControl = false;
        alarm[3] = 3;
        if (global.charSelected == -1)
        {
            if (selectedCharacter == randomSelectSlot)
            {
                selectedCharacter = randomSelect;
            }
            if (characterInfo[selectedCharacter] != ds_map_find_value(global.characterData, "empty"))
            {
                global.charSelected = characterInfo[selectedCharacter];
                audio_play_sound(snd_charSelected, 0, 0);
                availableOutfits = ["default"];
                outfitSelect = 0;
                extraPush = 0;
                if (variable_struct_exists(global.charSelected, "outfits"))
                {
                    var outfitsCheck = variable_struct_get_names(global.charSelected.outfits);
                    availableOutfits = ["default"];
                    for (var i = 0; i < array_length(outfitsCheck); i++)
                    {
                        if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), outfitsCheck[i]))
                        {
                            array_push(availableOutfits, variable_struct_get(global.charSelected.outfits, outfitsCheck[i]).outfitID);
                        }
                    }
                    if (array_length(availableOutfits) > 1)
                    {
                        choseOutfit = false;
                    }
                    else if (global.holoHouseMode)
                    {
                        choseOutfit = true;
                        global.gameMode = 3;
                    }
                }
                else if (global.holoHouseMode)
                {
                    choseOutfit = true;
                    global.gameMode = 3;
                }
            }
        }
        else if (!choseOutfit)
        {
            global.outfitSelected = availableOutfits[outfitSelect];
            choseOutfit = true;
            audio_play_sound(snd_charSelected, 0, 0);
            if (global.holoHouseMode)
            {
                global.gameMode = 3;
            }
        }
        else if (global.gameMode == -1 && choseOutfit)
        {
            global.gameMode = modeOption;
            audio_play_sound(snd_charSelected, 0, 0);
            selectedStage = 0;
            foodOption = false;
        }
        else if (global.playingStage == -1)
        {
            if (foodOption)
            {
                audio_play_sound(snd_menu_confirm, 0, 0);
                ds_map_set(global.PlayerSave, "cookingOn", !ds_map_find_value(global.PlayerSave, "cookingOn"));
            }
            else
            {
                var whichSet = -1;
                if (global.holoHouseMode)
                {
                    global.gameMode = 3;
                }
                switch (global.gameMode)
                {
                    case 0:
                        whichSet = availableStages;
                        break;
                    case 1:
                        whichSet = availableStages;
                        break;
                    case 2:
                        whichSet = availableTimeStages;
                        break;
                    case 3:
                        whichSet = availableHouseStages;
                        break;
                }
                if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedStages"), whichSet[selectedStage].stageIDName) || global.debug)
                {
                    global.playingStage = whichSet[selectedStage].room;
                    audio_play_sound(snd_charSelected, 0, 0);
                    readyToGo = true;
                }
            }
        }
        else
        {
            audio_play_sound(snd_charSelected, 0, 0);
            room_goto(global.playingStage);
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
