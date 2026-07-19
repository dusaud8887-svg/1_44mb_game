fishingArea = instance_place(x, y, obj_Player);
if (point_distance(x, y, obj_Player.x, obj_Player.y) < 150)
{
    audio_sound_gain(snd_lake, 1, 1);
}
else if (point_distance(x, y, obj_Player.x, obj_Player.y) > 250)
{
    audio_sound_gain(snd_lake, 0, 1);
}
else
{
    audio_sound_gain(snd_lake, min(1, (250 - point_distance(x, y, obj_Player.x, obj_Player.y)) / 100), 1);
}
if (animPlayingSpeed < 60)
{
    animPlayingSpeed += 1;
}
else
{
    animPlayingSpeed = 0;
}
if (fishingArea)
{
    if (fishingBegin || fishingMode || fishFound)
    {
        global.new_camera_scale = 2;
    }
    else
    {
        global.new_camera_scale = 1;
    }
}
if (fishingBegin && !fishFound && !fishingMode)
{
    fishingTimer++;
    if ((fishingTimer % 60) == 0)
    {
        var roll = irandom(99);
        if (roll < 33)
        {
            fishingBegin = false;
            fishFound = true;
            fishingTimer = 0;
            fishingFurniture = false;
            alarm[0] = 80;
            barHold = false;
            selectedFurniture = -1;
            var allFurn = global.FurnitureLibrary;
            var notUnlockedFurn = [];
            var i = ds_map_find_first(allFurn);
            while (!is_undefined(i))
            {
                if (ds_map_find_value(allFurn, i).furnitureID != "hardcoreTrophy" && ds_map_find_value(allFurn, i).furnitureID != "completegrass" && string_pos("goldenfish", ds_map_find_value(allFurn, i).furnitureID) == 0)
                {
                    if (!furniture_unlocked(ds_map_find_value(allFurn, i).furnitureID))
                    {
                        array_push(notUnlockedFurn, ds_map_find_value(allFurn, i));
                    }
                }
                i = ds_map_find_next(allFurn, i);
            }
            if (array_length(notUnlockedFurn) > 0)
            {
                var furnRoll = irandom(300);
                if (furnRoll == 0)
                {
                    fishingFurniture = true;
                    SetDifficulty(3);
                    selectedFurniture = notUnlockedFurn[irandom(array_length(notUnlockedFurn) - 1)];
                }
            }
            if (!fishingFurniture)
            {
                currentCatchingFish = ChooseFish();
                GetFishDifficulty(currentCatchingFish.inventoryID);
                DetermineGold(currentCatchingFish.inventoryID);
            }
            var vfx = instance_create_depth(obj_Player.x, obj_Player.y - 35, obj_Player.depth - 1000, obj_vfx);
            if (foundGold)
            {
                vfx.sprite_index = spr_FishingFound4;
                audio_play_sound(snd_fishFound4, 10, 0);
            }
            else
            {
                switch (currentDifficulty)
                {
                    case 0:
                        vfx.sprite_index = spr_FishingFound;
                        audio_play_sound(snd_fishfound, 10, 0);
                        break;
                    case 1:
                        vfx.sprite_index = spr_FishingFound;
                        audio_play_sound(snd_fishfound, 10, 0);
                        break;
                    case 2:
                        vfx.sprite_index = spr_FishingFound2;
                        audio_play_sound(snd_fishFound2, 10, 0);
                        break;
                    case 3:
                        vfx.sprite_index = spr_FishingFound2;
                        audio_play_sound(snd_fishFound2, 10, 0);
                        break;
                    case 4:
                        vfx.sprite_index = spr_FishingFound3;
                        audio_play_sound(snd_fishFound3, 10, 0);
                        break;
                    case 5:
                        vfx.sprite_index = spr_FishingFound3;
                        audio_play_sound(snd_fishFound3, 10, 0);
                        break;
                }
            }
            if (!fishingFurniture)
            {
                catchNumber = minFish + irandom(bonusFish);
                catchNumber = floor(catchNumber * array_get(currentCatchingFish.config.catchMultiplier, ds_map_find_value(global.PlayerSave, "fishRod")));
                catchNumber += round((bonusYield / 2) + random(bonusYield / 2));
            }
            show_debug_message(catchNumber);
            if (foundGold || fishingFurniture)
            {
                catchNumber = 1;
            }
        }
    }
}
if (fishingMode && !barHold)
{
    if (array_length(buttonArray) > 0)
    {
        for (var i = 0; i < array_length(buttonArray); i++)
        {
            buttonArray[i][1]--;
        }
    }
    if (array_length(buttonArray) > 0)
    {
        if (buttonArray[0][1] < 1)
        {
            if (buttonArray[0][0] != UnknownEnum.Value_5)
            {
                RhythmFailed();
            }
            array_delete(buttonArray, 0, 1);
        }
    }
}
if (canPress > 0)
{
    canPress--;
}
if (failTimer > 0)
{
    failTimer--;
}
if (fishingMode && !barHold && (fishGauge >= 100 || fishGauge < 1))
{
    barHold = true;
    barFlashTime = 0;
    alarm[3] = 30;
    canPress = 999;
    audio_stop_sound(snd_fishreel);
    if (fishGauge >= 100)
    {
        audio_play_sound(snd_fishBarFill, 0, 0);
    }
    else
    {
        audio_play_sound(snd_fishBarEmpty, 0, 0);
    }
}
if (fishingResults && fishResultsTimer < waitTime)
{
    if (fishResultsTimer == (waitTime - 1))
    {
        if (fishGauge >= 100)
        {
            audio_play_sound(snd_fishResults, 0, 0);
            if (foundGold)
            {
                audio_play_sound(snd_foundGold, 0, 0);
                obj_HoloHouseManager.ExecuteFlash();
            }
        }
        else
        {
            audio_play_sound(snd_fishFailed, 0, 0);
        }
    }
    fishResultsTimer++;
}
if (!fishingBegin && mouse_x >= (x - 100) && mouse_x < (x + 100) && mouse_y >= (y - 100) && mouse_y < (y + 100) && mouse_check_button_pressed(mb_left))
{
    Confirmed();
}
if (fishingMode && mouse_check_button_pressed(mb_left))
{
    Confirmed();
}

enum UnknownEnum
{
    Value_5 = 5
}
