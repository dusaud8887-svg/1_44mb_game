if (global.lightFX)
{
    var afterimage = instance_create_depth(x, y, depth + 5, obj_afterImage);
    afterimage.sprite_index = sprite_index;
    afterimage.image_speed = 0;
    afterimage.image_index = image_index;
    afterimage.image_xscale = image_xscale;
    afterimage.image_yscale = image_yscale;
    afterimage.afterimage_color = afterImageColor;
    afterimage.image_angle = image_angle;
    afterimage.grow = true;
    afterimage.growthRate = 0.05;
    afterimage.fadeRate = 0.02;
}
alarm[0] = 10;
