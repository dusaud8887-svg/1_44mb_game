glowTime = 0;
add = 0;
addDuration = 0;
uni_add = shader_get_uniform(shdrMob, "add");
highlighted = false;
player = instance_find(obj_Player, 0);
spriteColor = 16777215;
SPD = 0.75 + random(0.5);
moving = false;
alarm[0] = 30;
direction = irandom(359);
depth = -y - 10;
changeDirCD = 0;
image_alpha = 0;
idleSprite = -1;
moveSprite = -1;
spawnCheck = true;
charID = "";
lifetime = (60 + irandom(60)) * 60;
alarm[2] = irandom(5) * 60;
interactCD = 0;
resetInteraction = 0;
state = 0;
interactNumber = 0;
gestureBubble = -4;
isFishing = false;
fishCheckCD = 300;
farmCheckCD = 300;
farmInteract = -1;
isWatering = false;

function Interact()
{
    if (interactCD == 0 && !spawnCheck && player.canControl && image_alpha == 1)
    {
        if (instance_exists(gestureBubble))
        {
            with (gestureBubble)
            {
                instance_destroy();
            }
        }
        if (interactNumber == 0)
        {
            gestureBubble = instance_create_depth(x, y - 20, depth - 5, obj_vfx);
            gestureBubble.sprite_index = spr_Gestures;
            gestureBubble.image_speed = 0;
            gestureBubble.image_index = 0;
            gestureBubble.followCharacter = id;
            gestureBubble.offset_y = -20;
            gestureBubble.alarm[1] = 120;
            gestureBubble.duration = 150;
            interactCD = 5;
        }
        else if (interactNumber < 5)
        {
            gestureBubble = instance_create_depth(x, y - 20, depth - 5, obj_vfx);
            gestureBubble.sprite_index = spr_Gestures;
            gestureBubble.image_speed = 0;
            gestureBubble.image_index = 1;
            gestureBubble.followCharacter = id;
            gestureBubble.offset_y = -20;
            gestureBubble.alarm[1] = 120;
            gestureBubble.duration = 150;
            interactCD = 5;
        }
        else if (interactNumber < 15)
        {
            gestureBubble = instance_create_depth(x, y - 20, depth - 5, obj_vfx);
            gestureBubble.sprite_index = spr_Gestures;
            gestureBubble.image_speed = 0;
            gestureBubble.image_index = 2;
            gestureBubble.followCharacter = id;
            gestureBubble.offset_y = -20;
            gestureBubble.alarm[1] = 120;
            gestureBubble.duration = 150;
            interactCD = 5;
        }
        else if (interactNumber < 25)
        {
            gestureBubble = instance_create_depth(x, y - 20, depth - 5, obj_vfx);
            gestureBubble.sprite_index = spr_Gestures;
            gestureBubble.image_speed = 0;
            gestureBubble.image_index = 3;
            gestureBubble.followCharacter = id;
            gestureBubble.offset_y = -20;
            gestureBubble.alarm[1] = 120;
            gestureBubble.duration = 150;
            interactCD = 5;
        }
        else if (interactNumber >= 25)
        {
            gestureBubble = instance_create_depth(x, y - 20, depth - 5, obj_vfx);
            gestureBubble.sprite_index = spr_Gestures;
            gestureBubble.image_speed = 0;
            gestureBubble.image_index = 4;
            gestureBubble.followCharacter = id;
            gestureBubble.offset_y = -20;
            gestureBubble.alarm[1] = 120;
            gestureBubble.duration = 150;
            interactCD = 5;
            DoAchievement("heyhey");
        }
        resetInteraction = 900;
        soundPlay([238], "npc", 10, 0, 0);
        interactNumber++;
        moving = false;
        if (!isFishing)
        {
            direction = point_direction(x, y, player.x, player.y);
        }
    }
}
