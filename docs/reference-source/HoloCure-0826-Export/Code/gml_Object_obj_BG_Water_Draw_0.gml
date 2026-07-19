draw_sprite(BG_PondWater, 0, x, y);
if (instance_exists(obj_BaseMob))
{
    var mobList = ds_list_create();
    var _num = collision_rectangle_list(x + 35, y + 14, x + 256, y + 230, obj_BaseMob, 1, 1, mobList, 0);
    for (var i = 0; i < _num; i++)
    {
        draw_sprite_ext(ds_list_find_value(mobList, i).sprite_index, ds_list_find_value(mobList, i).image_index, ds_list_find_value(mobList, i).x, ds_list_find_value(mobList, i).y + 1, ds_list_find_value(mobList, i).image_xscale, -0.8, 0, c_white, 0.5);
    }
    ds_list_destroy(mobList);
}
draw_self();
