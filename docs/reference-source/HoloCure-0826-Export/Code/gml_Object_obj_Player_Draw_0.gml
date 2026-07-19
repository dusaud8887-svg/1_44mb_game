if (global.lightingExists)
{
    glr_mesh_set_transform(playerMesh, x, y, image_xscale, image_yscale, image_angle);
}
var keys = variable_struct_get_names(customDrawScriptBelow);
for (var i = 0; i < array_length(keys); i++)
{
    var Script = variable_struct_get(customDrawScriptBelow, keys[i]);
    Script(id);
}
if (instance_exists(obj_PlayerManager))
{
    if (mouseFollowMode)
    {
        draw_sprite_ext(spr_Arrow, 2, x, y - 16, 1, 1, direction, c_white, 1);
    }
    else
    {
        draw_sprite_ext(spr_Arrow, isStrafing, x, y - 16, 1, 1, direction, c_white, 1);
    }
}
if (instance_exists(obj_FishingMiniGame))
{
    if (obj_FishingMiniGame.fishingBegin || obj_FishingMiniGame.fishingMode || obj_FishingMiniGame.fishFound)
    {
        draw_sprite_ext(spr_FishingRod, ds_map_find_value(global.PlayerSave, "fishRod"), x, y, image_xscale, image_yscale, 0, c_white, 1);
    }
}
if (global.reflection)
{
    if (sprite_index >= furn_WoodenDivider1)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, -abs(0.5 * image_yscale), image_angle, make_color_rgb(50, 50, 130), 0.4);
    }
}
else
{
    draw_sprite_ext(spr_Shadow, 0, x, y, 1, 1, 0, c_white, 0.8);
}
if (instance_exists(obj_DayNightCycle) && obj_DayNightCycle.rain)
{
    draw_sprite_ext(spr_umbrella2, 0, x, y, image_xscale, 1, 0, c_white, image_alpha);
}
if (xprevious == x && yprevious == y)
{
    Stop();
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha);
if (instance_exists(obj_DayNightCycle) && obj_DayNightCycle.rain)
{
    draw_sprite_ext(spr_umbrella, 0, x, y, image_xscale, 1, 0, c_white, image_alpha);
}
keys = variable_struct_get_names(customDrawScriptAbove);
for (var i = 0; i < array_length(keys); i++)
{
    var Script = variable_struct_get(customDrawScriptAbove, keys[i]);
    Script(id);
}
