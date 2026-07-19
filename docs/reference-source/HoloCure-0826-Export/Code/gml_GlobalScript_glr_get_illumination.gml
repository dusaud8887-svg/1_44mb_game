function glr_get_illumination()
{
    var px = floor(argument0 * global.GLR_MAIN_QUALITY);
    var py = floor(argument1 * global.GLR_MAIN_QUALITY);
    var val = buffer_peek(global.GLR_ILLUM_BUFFER, (px + (py * global.GLR_MAIN_SURFACE_WIDTH)) * 4, buffer_u32);
    if (is_int64(val))
    {
        return colour_get_value(val & 16777215) / 255;
    }
    else if (argument_count >= 3)
    {
        return argument[2];
    }
    else
    {
        return 0;
    }
}
