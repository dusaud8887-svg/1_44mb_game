if (followCharacter > 0)
{
    if (homingPlayer)
    {
        direction = point_direction(x, y, followCharacter.x, followCharacter.y - 16);
    }
    else if (instance_exists(followCharacter))
    {
        x = followCharacter.x + offset_x;
        y = followCharacter.y + offset_y;
        if (followAngle > -1)
        {
            if (variable_instance_exists(followCharacter, "aimedDirection"))
            {
                direction = followCharacter.aimedDirection;
            }
            else
            {
                direction = followCharacter.direction;
            }
            image_angle = direction;
        }
    }
    else
    {
        instance_destroy();
    }
}
if (add)
{
    gpu_set_blendmode(bm_add);
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha);
gpu_set_blendmode(bm_normal);
