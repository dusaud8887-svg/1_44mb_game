shadowStrength = 0.3;
clones = false;
event_inherited();
HP = 2 + random(2);
currentHP = HP;
SPD = 0;
ATK = -1;
haste = 0;
breakable = true;
brokenPieces = 920;
foodChance = 99;
settled = false;
image_alpha = 0;
noWarp = false;
emitter = part_emitter_create(global.psystem);
followPlayerID = instance_find(obj_Player, 0);

function Spawn()
{
    if (global.topBorder != -1)
    {
        if (y < global.topBorder)
        {
            y = global.topBorder;
        }
    }
    if (global.bottomBorder != -1)
    {
        if (y > global.bottomBorder)
        {
            y = global.bottomBorder;
        }
    }
    if (global.leftBorder != -1)
    {
        if (x < global.leftBorder)
        {
            x = global.leftBorder;
        }
    }
    if (global.rightBorder != -1)
    {
        if (x > global.rightBorder)
        {
            x = global.rightBorder;
        }
    }
    inView = x > (camera_get_view_x(view_camera[0]) - 100) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 100) && y > (camera_get_view_y(view_camera[0]) - 100) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 100 + abs(bbox_top - bbox_bottom));
    while (inView)
    {
        inView = x > (camera_get_view_x(view_camera[0]) - 100) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 100) && y > (camera_get_view_y(view_camera[0]) - 100) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 100 + abs(bbox_top - bbox_bottom));
        image_alpha = 0;
        if (global.topBorder != -1 && global.bottomBorder != -1)
        {
            if (x >= obj_Player.x)
            {
                x += 500;
            }
            else
            {
                x -= 500;
            }
        }
        else if (global.leftBorder != -1 && global.rightBorder != -1)
        {
            if (y >= obj_Player.y)
            {
                y += 250;
            }
            else
            {
                y -= 250;
            }
        }
    }
    settled = true;
    part_emitter_region(global.psystem, emitter, x - 20, x + 20, y, y - 40, 0, 0);
    part_emitter_stream(global.psystem, emitter, global.partType3, 2);
    part_system_depth(global.psystem, -9999);
}

function Die()
{
    if (!broken)
    {
        audio_play_sound(snd_break, 30, 0);
        broken = true;
        if (global.lightFX)
        {
            if (brokenPieces != -1)
            {
                for (var i = 0; i < 20; i++)
                {
                    var debris = instance_create_depth(x, y - irandom(spriteHeight), depth - 1, obj_vfx);
                    debris.sprite_index = brokenPieces;
                    debris.image_speed = 0;
                    debris.image_index = irandom(sprite_get_number(brokenPieces));
                    debris.duration = 90;
                    debris.gravity = 0.25;
                    debris.hspeed = -5 + irandom(10);
                    debris.vspeed = -2 - irandom(4);
                }
            }
        }
        var roll = irandom(99);
        if (roll < 20)
        {
            for (var i = 0; i < (1 + irandom(2)); i++)
            {
                var drop = instance_create_depth(x, y - 20, depth, obj_Hamburger);
                drop.direction = floor(random(360));
                drop.speed = 4 + random(3);
            }
        }
        else if (roll < 35 && ds_map_find_value(global.PlayerSave, "specUnlock"))
        {
            for (var i = 0; i < (2 + irandom(2)); i++)
            {
                var drop = instance_create_depth(x, y - 20, depth, obj_IdolPower);
                drop.direction = floor(random(360));
                drop.speed = 4 + random(3);
            }
        }
        else if (roll < 60)
        {
            for (var i = 0; i < (5 + irandom(20)); i++)
            {
                var drop = instance_create_depth(x, y - 20, depth, obj_HoloCoinDrop);
                drop.amountVal = 10 * global.moneyMultiplier;
                drop.direction = floor(random(360));
                drop.speed = 3 + random(3);
            }
        }
        else if (roll < 85)
        {
            for (var i = 0; i < (10 + irandom(10)); i++)
            {
                var drop = instance_create_depth(x, y - 20, depth, obj_PreCreate);
                drop.expVal = obj_PlayerManager.toNextLevel * 0.05;
                drop.direction = floor(random(360));
                drop.speed = 3 + random(3);
                with (drop)
                {
                    instance_change(obj_EXP, true);
                }
            }
        }
        else if (roll < 95 && ds_map_find_value(global.PlayerSave, "stamps"))
        {
            var droppedsticker = instance_create_depth(x, y - 20, depth, obj_Sticker);
            droppedsticker.RollSticker();
        }
        instance_destroy();
    }
}
