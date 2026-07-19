if (seedID != -1 && !grown)
{
    if (growTime > 0 && lifetime < (growTime - 1))
    {
        lifetime++;
    }
    if (lifetime > (growTime - 1))
    {
        lifetime = growTime - 1;
    }
    growthState = (lifetime + 1) div (growTime div 3);
    if (!grown && growthState == 3)
    {
        grown = true;
        var theCrop = ds_map_find_value(global.InventoryLibrary, cropID);
        var textMessage = 
        {
            eng: "[c_green]" + theCrop.inventoryName + "[/color] has fully grown!",
            jp: "[c_green]" + theCrop.inventoryName + "[/color]" + "이(가) 완전히 자랐습니다!",
            Id: "[c_green]" + theCrop.inventoryName + "[/color] telah tumbuh subur!"
        };
        var selectedLanguage = global.CurrentLanguage;
        obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
        part_emitter_region(global.psystem, emitter, x - 17, x + 17, y + 5, y - 30, 0, 0);
        part_system_depth(global.psystem, -9999);
        part_emitter_stream(global.psystem, emitter, global.partType3, 3);
    }
}
if (waterCD > 0)
{
    waterCD--;
}
if (highlighted)
{
    glowTime++;
    add = 0.2 + (0.2 * sin(glowTime / 10));
}
else
{
    glowTime = 0;
    add = 0;
}
if (instance_exists(player) && point_distance(x, y, player.x, player.y) < 30)
{
    if (interactable)
    {
        var farmingSpots = ds_list_create();
        collision_circle_list(player.x, player.y, 25, obj_FarmingSpot, true, false, farmingSpots, true);
        if (ds_list_find_value(farmingSpots, 0) == id)
        {
            highlighted = true;
        }
        else
        {
            highlighted = false;
        }
        ds_list_destroy(farmingSpots);
        farmingSpots = -1;
    }
}
else
{
    highlighted = false;
}
if (!interacting && interactable && highlighted)
{
    if (instance_exists(obj_InputManager))
    {
        if (obj_InputManager.actionOnePressed)
        {
            Confirm();
        }
    }
}
else if (interacting)
{
    if (instance_exists(obj_InputManager))
    {
        if (obj_InputManager.actionOnePressed)
        {
            Confirm();
        }
        if (obj_InputManager.actionTwoPressed)
        {
            Return();
        }
        if (obj_InputManager.moveLeftPressed)
        {
            SelectLeft();
        }
        if (obj_InputManager.moveRightPressed)
        {
            SelectRight();
        }
        if (obj_InputManager.moveUpPressed)
        {
            SelectUp();
        }
        if (obj_InputManager.moveDownPressed)
        {
            SelectDown();
        }
    }
}
cursorTime++;
if (cursorTime >= 10000)
{
    cursorTime = 0;
}
if (cropsResults && cropsResultsTimer < waitTime)
{
    if (cropsResultsTimer == (waitTime - 1))
    {
        audio_play_sound(snd_fishResults, 0, 0);
    }
    cropsResultsTimer++;
}
