if (global.lightFX)
{
    var afterimage = instance_create_depth(x, y, depth + 5, obj_afterImage);
    afterimage.sprite_index = sprite_index;
    afterimage.image_speed = 0;
    afterimage.image_index = image_index;
    afterimage.image_xscale = image_xscale;
    afterimage.image_yscale = image_yscale;
    if (is_array(afterImageColor))
    {
        if (!variable_instance_exists(self, "afterImageSequence"))
        {
            afterImageSequence = irandom(5);
        }
        afterimage.afterimage_color = afterImageColor[afterImageSequence];
        afterimage.fadeRate = 0.025;
        if (afterImageSequence >= (array_length(afterImageColor) - 1))
        {
            afterImageSequence = 0;
        }
        else
        {
            afterImageSequence++;
        }
    }
    else
    {
        afterimage.afterimage_color = afterImageColor;
    }
    afterimage.image_alpha = image_alpha / 2;
    afterimage.image_angle = image_angle;
}
alarm[10] = 2;
