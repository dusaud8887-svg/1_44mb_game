if (fishingArea && !fishingBegin && !fishFound && !fishingMode && !fishingResults && !instance_exists(obj_GetFish))
{
    sprite_index = spr_FishingIcon;
    draw_sprite_ext(spr_FishingIcon, image_index, obj_Player.x, obj_Player.y - 32, 1, 1, 0, c_white, 1);
}
if (fishingBegin || fishingMode || fishFound)
{
    draw_sprite_ext(spr_FishingRod, ds_map_find_value(global.PlayerSave, "fishRod"), obj_Player.x, obj_Player.y, obj_Player.image_xscale, obj_Player.image_yscale, 0, c_white, 1);
    var playerDir = point_direction(obj_Player.x, obj_Player.y, x, y);
    var imNum = sprite_get_number(spr_FishingBop);
    draw_sprite_ext(spr_FishingBop, (animPlayingSpeed / room_speed) * imNum, obj_Player.x + lengthdir_x(80, playerDir), obj_Player.y + lengthdir_y(80, playerDir), 1, 1, 0, c_white, 1);
}
