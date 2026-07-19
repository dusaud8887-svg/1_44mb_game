if (interactCD > 0)
{
    interactCD--;
}
if (fishCheckCD > 0)
{
    fishCheckCD--;
}
if (farmCheckCD > 0)
{
    farmCheckCD--;
}
if (resetInteraction > 0)
{
    resetInteraction--;
}
else
{
    interactNumber = 0;
}
if (!spawnCheck && instance_exists(player) && point_distance(x, y, player.x, player.y) < 30 && player.canControl)
{
    var obj = collision_circle(player.x, player.y, 25, obj_holoHouseNPC, true, false);
    if (obj == id)
    {
        highlighted = true;
    }
    else
    {
        highlighted = false;
    }
}
else
{
    highlighted = false;
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
if (spawnCheck)
{
    if (!place_meeting(x, y, obj_Obstacle))
    {
        spawnCheck = false;
        sprite_index = idleSprite;
    }
    else
    {
        x = 961 + irandom(600);
        y = 1266 + irandom(600);
    }
}
mask_index = spr_playerMask;
if (moving && !spawnCheck)
{
    if (!place_meeting(x + lengthdir_x(SPD, direction), y, obj_Obstacle))
    {
        x += lengthdir_x(SPD, direction);
    }
    if (!place_meeting(x, y + lengthdir_y(SPD, direction), obj_Obstacle))
    {
        y += lengthdir_y(SPD, direction);
    }
    sprite_index = moveSprite;
    image_speed = 0.75;
}
else if (!spawnCheck)
{
    sprite_index = idleSprite;
    image_speed = 1;
}
if (changeDirCD == 0 && moving && place_meeting(x + lengthdir_x(SPD * 3, direction), y + lengthdir_y(SPD * 3, direction), obj_Obstacle))
{
    var obj = instance_place(x + lengthdir_x(SPD * 3, direction), y + lengthdir_y(SPD * 3, direction), obj_Obstacle);
    var moveAway = point_direction(obj.x, obj.y, x, y);
    direction = moveAway;
    x += lengthdir_x(3, moveAway);
    y += lengthdir_y(3, moveAway);
    changeDirCD = 60;
}
if (place_meeting(x + lengthdir_x(5, direction), y + lengthdir_y(5, direction), obj_Pond) && !isFishing && image_alpha == 1)
{
    var obj = instance_find(obj_Pond, 0);
    var roll = irandom(99);
    if (roll < 30 && fishCheckCD == 0)
    {
        isFishing = true;
        var howLong = 30 + (irandom(30) * 60);
        alarm[3] = howLong;
        lifetime += howLong;
        var look = point_direction(x, y, obj.x, obj.y);
        direction = look;
        moving = false;
        fishCheckCD = 120;
    }
}
if (place_meeting(x + lengthdir_x(5, direction), y + lengthdir_y(5, direction), obj_FarmingSpot) && image_alpha == 1)
{
    farmInteract = instance_place(x + lengthdir_x(5, direction), y + lengthdir_y(5, direction), obj_FarmingSpot);
    var roll = irandom(99);
    if (farmInteract != -4 && !isWatering)
    {
        if (farmInteract.seedID != -1 && !farmInteract.grown)
        {
            if (roll < 50 && farmCheckCD == 0 && farmInteract.waterCD == 0)
            {
                show_debug_message("water check success");
                isWatering = true;
                var howLong = (1 + irandom(3)) * 20;
                alarm[4] = howLong;
                lifetime += howLong;
                var look = point_direction(x, y, farmInteract.x, farmInteract.y);
                direction = look;
                moving = false;
                farmCheckCD = howLong + 1;
            }
            else
            {
                farmInteract = -1;
                farmCheckCD = 120;
            }
        }
        else
        {
            farmInteract = -1;
        }
    }
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
if (lifetime > 0)
{
    lifetime--;
}
else
{
    interactCD = 9999;
    alarm[1] = 1;
}
if (highlighted)
{
    if (instance_exists(obj_InputManager))
    {
        if (obj_InputManager.actionOnePressed)
        {
            Interact();
        }
    }
}
