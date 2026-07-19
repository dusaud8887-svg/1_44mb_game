fishingBegin = false;
fishingArea = false;
canControl = true;
fishFound = false;
fishingTimer = 0;
fishingMode = false;
depth = -1000;
image_speed = 1;
animPlayingSpeed = 0;
canPress = 0;
fishGauge = 50;
fishDepleteRate = 10;
failAmount = 10;
successAmount = 10;
letterBox = -50;
fishingResults = false;
catchNumber = 0;
resultsContainer = [320, 110];
lightTime = 0;
bpm = 30;
queueTime = 90;
waitTime = 50;
barHold = true;
barFlashTime = 0;
buttonArray = [];
minFish = 1;
bonusFish = 0;
failTimer = 0;
fishArray = [];
fishPool = [];
currentCatchingFish = -1;
fishSize = 1;
currentDifficulty = 0;
comboChain = 0;
bonusYield = 0;
difficultyUp = 0;
foundGold = false;
fireworksCD = 0;
goldBonus = 0;
fishingFurniture = false;
selectedFurniture = -1;
audio_play_sound(snd_lake, 2, true);

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
}

function ChainReset()
{
    comboChain = 0;
    goldBonus = 0;
    bonusYield = 0;
    difficultyUp = 0;
}

function ChooseFish(arg0 = ds_map_find_value(global.PlayerSave, "fishRod"))
{
    fishPool = [];
    for (var i = 0; i < array_length(fishArray); i++)
    {
        for (var j = 0; j < fishArray[i].config.spawnRate[arg0]; j++)
        {
            array_push(fishPool, fishArray[i].inventoryID);
        }
    }
    var theFish = ds_map_find_value(global.InventoryLibrary, array_get(fishPool, irandom(array_length(fishPool) - 1)));
    return theFish;
}

function SetDifficulty(arg0)
{
    currentDifficulty = arg0;
    switch (arg0)
    {
        case 0:
            var proficiency = ds_map_find_value(global.PlayerSave, "fishRod") * 0.2;
            bpm = 45 - min(5, difficultyUp / 5);
            queueTime = max(35, 90 - difficultyUp);
            fishDepleteRate = 10;
            failAmount = max(5, 10 * (1 - proficiency));
            successAmount = 15 * (1 + proficiency);
            break;
        case 1:
            var proficiency = ds_map_find_value(global.PlayerSave, "fishRod") * 0.2;
            bpm = 30 - min(5, difficultyUp / 5);
            queueTime = max(35, 90 - difficultyUp);
            fishDepleteRate = 10;
            failAmount = max(5, 15 * (1 - proficiency));
            successAmount = 15 * (1 + proficiency);
            break;
        case 2:
            var proficiency = (ds_map_find_value(global.PlayerSave, "fishRod") - 1) * 0.2;
            bpm = 30 - min(5, difficultyUp / 5);
            queueTime = max(35, 80 - difficultyUp);
            fishDepleteRate = 7;
            failAmount = max(5, 20 * (1 - proficiency));
            successAmount = 10 * (1 + proficiency);
            break;
        case 3:
            var proficiency = (ds_map_find_value(global.PlayerSave, "fishRod") - 2) * 0.2;
            bpm = 25 - min(5, difficultyUp / 5);
            queueTime = max(35, 80 - difficultyUp);
            fishDepleteRate = 5;
            failAmount = max(5, 25 * (1 - proficiency));
            successAmount = 10 * (1 + proficiency);
            break;
        case 4:
            var proficiency = (ds_map_find_value(global.PlayerSave, "fishRod") - 3) * 0.2;
            bpm = 25 - min(5, difficultyUp / 5);
            queueTime = max(35, 75 - difficultyUp);
            fishDepleteRate = 3;
            failAmount = max(5, 25 * (1 - proficiency));
            successAmount = 10 * (1 + proficiency);
            break;
        case 5:
            var proficiency = (ds_map_find_value(global.PlayerSave, "fishRod") - 4) * 0.2;
            bpm = 25 - min(5, difficultyUp / 5);
            queueTime = max(35, 70 - difficultyUp);
            fishDepleteRate = 3;
            failAmount = max(5, 30 * (1 - proficiency));
            successAmount = 10 * (1 + proficiency);
            break;
    }
}

function DetermineGold(arg0)
{
    var goldRodBonus = ds_map_find_value(global.PlayerSave, "fishRod") == 5;
    var roll = irandom(max(20, floor(700 - (140 * goldRodBonus) - (goldBonus * 5))));
    if (roll == 0)
    {
        var goldenFish = "golden" + arg0;
        currentCatchingFish = ds_map_find_value(global.InventoryLibrary, goldenFish);
        successAmount = 10;
        failAmount = 10;
        foundGold = true;
        goldBonus = 0;
    }
}

function GetFishDifficulty(arg0)
{
    switch (arg0)
    {
        case "shrimp":
            fishSize = 1;
            var roll = irandom(99);
            if (roll > 40)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(0);
            }
            else
            {
                minFish = 2;
                bonusFish = 4;
                SetDifficulty(1);
            }
            break;
        case "clownfish":
            fishSize = 1;
            var roll = irandom(99);
            if (roll > 30)
            {
                minFish = 1;
                bonusFish = 2;
                SetDifficulty(0);
            }
            else
            {
                minFish = 2;
                bonusFish = 3;
                SetDifficulty(1);
            }
            return 0;
            break;
        case "tuna":
            fishSize = 1.2;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(1);
            }
            else
            {
                minFish = 2;
                bonusFish = 3;
                SetDifficulty(2);
            }
            return 0;
            break;
        case "koifish":
            fishSize = 1.2;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else
            {
                minFish = 2;
                bonusFish = 3;
                SetDifficulty(3);
            }
            return 0;
            break;
        case "lobster":
            fishSize = 1.4;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else
            {
                minFish = 2;
                bonusFish = 2;
                SetDifficulty(3);
            }
            return 0;
            break;
        case "eel":
            fishSize = 1.5;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(3);
            }
            return 0;
            break;
        case "pufferfish":
            fishSize = 1.75;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(2);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(3);
            }
            return 0;
            break;
        case "mantaray":
            fishSize = 2;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(3);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(4);
            }
            return 0;
            break;
        case "turtle":
            fishSize = 2;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(3);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(4);
            }
            return 0;
            break;
        case "squid":
            fishSize = 2.5;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(3);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(4);
            }
            return 0;
            break;
        case "shark":
            fishSize = 3;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 2;
                SetDifficulty(4);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(5);
            }
            return 0;
            break;
        case "axolotl":
            fishSize = 3;
            var roll = irandom(99);
            if (roll > 20)
            {
                minFish = 1;
                bonusFish = 1;
                SetDifficulty(5);
            }
            else
            {
                minFish = 2;
                bonusFish = 1;
                SetDifficulty(5);
            }
            return 0;
            break;
    }
}

function RhythmFailed()
{
    fishGauge -= failAmount;
    var grade = instance_create_depth(camera_get_view_x(view_camera[0]) + 392, camera_get_view_y(view_camera[0]) + 278, -1000, obj_RhythmGrade);
    grade.grade = 2;
    audio_play_sound(snd_buttonFail, 0, 0);
}

function RhythmSuccess(arg0 = false)
{
    if (arg0)
    {
        fishGauge += (successAmount * 1.5);
    }
    else
    {
        fishGauge += successAmount;
    }
    if (fishGauge > 100)
    {
        fishGauge = 100;
    }
    var grade = instance_create_depth(camera_get_view_x(view_camera[0]) + 392, camera_get_view_y(view_camera[0]) + 278, -1000, obj_RhythmGrade);
    grade.grade = arg0;
    var vfx = instance_create_depth(217 + ((1 - (buttonArray[0][1] / queueTime)) * 192), 252, -1000, obj_vfxGUI);
    vfx.sprite_index = spr_rhythmButtons;
    vfx.image_index = buttonArray[0][0];
    vfx.image_speed = 0;
    vfx.alarm[0] = 1;
    vfx.alarm[1] = 1;
    array_delete(buttonArray, 0, 1);
    audio_play_sound(snd_buttonSuccess, 0, 0);
}

function ButtonCheck(arg0)
{
    if (canPress == 0)
    {
        if (array_length(buttonArray) > 0)
        {
            if (buttonArray[0][0] == arg0)
            {
                if (buttonArray[0][1] > (0.05 * queueTime) && buttonArray[0][1] < (0.11 * queueTime))
                {
                    RhythmSuccess(true);
                }
                else if (buttonArray[0][1] > 0 && buttonArray[0][1] < (0.16 * queueTime))
                {
                    RhythmSuccess(false);
                }
            }
            else if (buttonArray[0][1] > 0 && buttonArray[0][1] < (0.16 * queueTime))
            {
                RhythmFailed();
                failTimer = 10;
                array_delete(buttonArray, 0, 1);
            }
        }
    }
    canPress = 10;
}

function Confirmed()
{
    if (fishingResults && fishResultsTimer >= waitTime)
    {
        if (!fishingFurniture)
        {
            fishingBegin = false;
            fishingResults = false;
            obj_Player.canControl = true;
            obj_HoloHouseManager.canControl = true;
            if (fishGauge >= 100)
            {
                var newFish = false;
                var fish = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
                fish.sprite_index = currentCatchingFish.sprites;
                audio_play_sound(snd_fishGet, 0, 0);
                if (is_undefined(item_get(currentCatchingFish.id)))
                {
                    newFish = true;
                }
                inventory_add(currentCatchingFish.id, catchNumber);
                if (foundGold)
                {
                    if (newFish)
                    {
                        obj_HoloHouseManager.PopMessage(global.TextContainer.newItems.selectedLanguage);
                    }
                    DoAchievement("shinyfish");
                }
                if (comboChain >= 50)
                {
                    DoAchievement("rhythmmaster");
                }
                else if (comboChain >= 10)
                {
                    DoAchievement("fishfearme");
                }
                var allFound = true;
                for (var i = 0; i < array_length(obj_HoloHouseManager.categorizedItems[0]); i++)
                {
                    if (string_pos("golden", obj_HoloHouseManager.categorizedItems[0][i].inventoryID) == 0)
                    {
                        if (is_undefined(item_get(obj_HoloHouseManager.categorizedItems[0][i].inventoryID)))
                        {
                            allFound = false;
                        }
                    }
                }
                if (allFound)
                {
                    DoAchievement("plentyoffish");
                }
                SavePlayerSave();
            }
            else
            {
                audio_play_sound(snd_menu_confirm, 0, 0);
            }
        }
        else
        {
            fishingBegin = false;
            fishingResults = false;
            obj_Player.canControl = true;
            obj_HoloHouseManager.canControl = true;
            if (fishGauge >= 100)
            {
                var fish = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
                fish.sprite_index = selectedFurniture.furnitureIcon;
                audio_play_sound(snd_fishGet, 0, 0);
                array_push(ds_map_find_value(global.PlayerSave, "unlockedFurniture"), selectedFurniture.furnitureID);
                SavePlayerSave();
            }
            else
            {
                audio_play_sound(snd_menu_confirm, 0, 0);
            }
        }
        with (obj_itemLightBeam)
        {
            instance_destroy();
        }
        fishGauge = 0;
    }
    else if (!fishingBegin)
    {
        if (fishingArea && obj_Player.canControl && !obj_HoloHouseManager.paused)
        {
            fishingBegin = true;
            fishingTimer = 0;
            fishGauge = 50;
            foundGold = false;
            buttonArray = [];
            canPress = 0;
            currentCatchingFish = -1;
            letterBox = -50;
            audio_play_sound(snd_fishstart, 10, 0);
            if (obj_Player.x > x)
            {
                obj_Player.direction = 180;
            }
            else
            {
                obj_Player.direction = 0;
            }
            obj_Player.canControl = false;
            obj_HoloHouseManager.canControl = false;
        }
    }
    if (fishingMode)
    {
        ButtonCheck(UnknownEnum.Value_4);
    }
}

function ReturnMenu()
{
    if (fishingBegin && !fishingMode)
    {
        fishingBegin = false;
        obj_Player.canControl = true;
        obj_HoloHouseManager.canControl = true;
    }
    if (fishingMode)
    {
        ButtonCheck(UnknownEnum.Value_4);
    }
}

function SelectLeft()
{
    if (fishingMode)
    {
        ButtonCheck(UnknownEnum.Value_2);
    }
}

function SelectRight()
{
    if (fishingMode)
    {
        ButtonCheck(UnknownEnum.Value_3);
    }
}

function SelectUp()
{
    if (fishingMode)
    {
        ButtonCheck(UnknownEnum.Value_0);
    }
}

function SelectDown()
{
    if (fishingMode)
    {
        ButtonCheck(UnknownEnum.Value_1);
    }
}

function InitFish()
{
    fishArray = [];
    var key = ds_map_find_first(global.InventoryLibrary);
    while (!is_undefined(key))
    {
        if (ds_map_find_value(global.InventoryLibrary, key).inventoryType == "fish")
        {
            array_push(fishArray, ds_map_find_value(global.InventoryLibrary, key));
        }
        key = ds_map_find_next(global.InventoryLibrary, key);
    }
}

InitFish();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
