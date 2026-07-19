if (created == -1)
{
    created = instance_create_depth(-999999, -999999, depth, enemyID);
}
instance_deactivate_object(created);
if (created > 0)
{
    var maskWidth = (sprite_get_bbox_right(created.mask_index) - sprite_get_bbox_left(created.mask_index)) * created.image_xscale;
    var maskHeight = (sprite_get_bbox_bottom(created.mask_index) - sprite_get_bbox_top(created.mask_index)) * created.image_yscale;
    if (collision_rectangle(x - (maskWidth / 2) - 1, y - maskHeight - 1, x + (maskWidth / 2) + 1, y + 1, obj_Enemy, 0, 1) == -4)
    {
        instance_activate_object(created);
        created.x = x;
        created.y = y;
        instance_destroy();
    }
    else
    {
        alarm[0] = 1;
    }
}
