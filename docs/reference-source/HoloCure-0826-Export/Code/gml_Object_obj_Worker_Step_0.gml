if (creator.workers[index][0].currentFeed == -1)
{
    creator.workers[index][0].currentFeed = obj_HoloHouseManager.GetRandomFeed(creator.workers[index][0].tier);
}
if (currentStamina > 0)
{
    isWorking = true;
}
else
{
    isWorking = false;
}
if (isWorking)
{
    if (workingTimer == 0)
    {
        creator.CollectCoin(creator.workers[index][0], self);
        workingTimer = 120;
    }
    else
    {
        workingTimer--;
    }
}
if (staminaTimer < 1 && currentStamina > 0)
{
    currentStamina--;
    creator.workers[index][0].currentStamina = currentStamina;
    staminaTimer = 1080 + irandom(240);
    if (currentStamina == 0)
    {
        var textMessage = 
        {
            eng: "[c_yellow]" + string(recruitName) + "[/color] has become [c_red]EXHAUSTED[/color].",
            jp: "[c_yellow]" + string(recruitName) + "[/color]가 [c_red]기력[/color]이 다했습니다!",
            Id: "[c_yellow]" + string(recruitName) + "[/color] mengalami [c_red]Kelelahan![/color]"
        };
        var selectedLanguage = global.CurrentLanguage;
        obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
    }
}
else if (staminaTimer > 0)
{
    staminaTimer--;
}
if (moving)
{
    if (!place_meeting(x + lengthdir_x(SPD, direction), y, obj_Obstacle))
    {
        x += lengthdir_x(SPD, direction);
    }
    if (!place_meeting(x, y + lengthdir_y(SPD, direction), obj_Obstacle))
    {
        y += lengthdir_y(SPD, direction);
    }
}
if (changeDirCD == 0 && moving && place_meeting(x + lengthdir_x(SPD, direction), y + lengthdir_y(SPD, direction), obj_Obstacle))
{
    direction -= 180;
    direction = (direction - 60) + irandom(120);
    var moveTowardsCenter = point_direction(x, y, obj_WorkerSpawnPoint.x, obj_WorkerSpawnPoint.y);
    x += lengthdir_x(1, moveTowardsCenter);
    y += lengthdir_y(1, moveTowardsCenter);
    changeDirCD = 60;
}
if (changeDirCD > 0)
{
    changeDirCD--;
}
if (direction <= 90 || direction >= 270)
{
    image_xscale = abs(image_xscale);
}
if (direction > 90 && direction < 270)
{
    image_xscale = -abs(image_xscale);
}
