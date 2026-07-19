event_inherited();
cursorTime++;
if (cursorTime >= 10000)
{
    cursorTime = 0;
}
if (interacting)
{
    if ((pauseMenu >= 0 && pauseMenu < 3) || pauseMenu > 4)
    {
        global.new_camera_scale = 2;
        global.cameraXOffset = 100 + (x - obj_Player.x);
        global.cameraYOffset = -45;
    }
    else
    {
        global.new_camera_scale = 1;
        global.cameraXOffset = 0;
        global.cameraYOffset = 0;
    }
}
hireCost = 500 + (array_length(workers) * 500);
if (instance_number(obj_Worker) != array_length(workers))
{
    for (var i = 0; i < array_length(workers); i++)
    {
        if (workers[i][1] == -1)
        {
            var w = instance_create_depth((obj_WorkerSpawnPoint.x - 60) + random(120), (obj_WorkerSpawnPoint.y - 60) + random(120), depth, obj_Worker);
            w.index = i;
            w.sprite_index = variable_struct_get(fandomIDs, workers[i][0].fanID).sprite;
            w.fanID = workers[i][0].fanID;
            w.recruitName = workers[i][0].recruitName;
            w.efficiency = workers[i][0].efficiency;
            w.currentStamina = workers[i][0].currentStamina;
            w.maxStamina = workers[i][0].maxStamina;
            w.currentLevel = workers[i][0].currentLevel;
            w.creator = self;
            with (w)
            {
                Init();
            }
            workers[i][1] = w;
        }
    }
}
if (levelUpConfirm && levelUpTimer < waitTime)
{
    levelUpTimer++;
}
if (manageLevelConfirm && manageLevelTimer < waitTime)
{
    if (!levelUpConfirm)
    {
        manageLevelTimer++;
    }
    if (manageLevelTimer == (waitTime - 1))
    {
        audio_play_sound(snd_managelevel, 0, false);
    }
}
if (pauseMenu == UnknownEnum.Value_6)
{
    if (!levelUpConfirm)
    {
        if (workers[inventorySelect + startingPosition][0].currentEXP >= workers[inventorySelect + startingPosition][0].nextEXP)
        {
            LevelWorker(inventorySelect + startingPosition);
        }
    }
}
if (canType && renameOption == -1)
{
    var weightedStringLength = GetWeightedStringLength(renameString);
    if (keyboard_check(vk_anykey) && weightedStringLength < 18)
    {
        var keyboardStringWeight = GetWeightedStringLength(keyboard_string);
        var newWeight = weightedStringLength + keyboardStringWeight;
        var newString = renameString + string(keyboard_string);
        var byteLength = string_byte_length(newString);
        if (newWeight <= 18)
        {
            renameString = TypeText(renameString);
        }
        keyboard_string = "";
    }
    if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && delete_timer == 2)
    {
        renameString = string_delete(renameString, string_length(renameString), 1);
        delete_timer = 0;
        keyboard_string = "";
    }
    if (keyboard_check_pressed(vk_backspace))
    {
        renameString = string_delete(renameString, string_length(renameString), 1);
        keyboard_string = "";
        delete_timer = -10;
    }
    if (delete_timer != 2)
    {
        delete_timer++;
    }
}
if (animationTime < 30)
{
    animationTime++;
}
else
{
    animationTime = 0;
}

enum UnknownEnum
{
    Value_6 = 6
}
