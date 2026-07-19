if (afterImageOn != false)
{
    var afterimage = instance_create_depth(x, y, depth + 55, obj_afterImage);
    afterimage.sprite_index = sprite_index;
    afterimage.image_speed = 0;
    afterimage.image_index = image_index;
    afterimage.image_xscale = image_xscale;
    afterimage.image_yscale = image_yscale;
    afterimage.afterimage_color = afterImageOn;
    afterimage.image_angle = image_angle;
    alarm[1] = 5;
}
