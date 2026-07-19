function glr_set_quality(arg0)
{
    global.GLR_MAIN_QUALITY = clamp(arg0, 0.05, 1);
    if (surface_exists(global.GLR_MAIN_SURFACE))
    {
        surface_free(global.GLR_MAIN_SURFACE);
    }
    global.GLR_MAIN_SURFACE_WIDTH = global.GLR_WIDTH * global.GLR_MAIN_QUALITY;
    global.GLR_MAIN_SURFACE_HEIGHT = global.GLR_HEIGHT * global.GLR_MAIN_QUALITY;
    global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    if (surface_exists(global.GLR_BLUR_SURFACE))
    {
        surface_free(global.GLR_BLUR_SURFACE);
        global.GLR_BLUR_SURFACE = -1;
    }
    buffer_delete(global.GLR_ILLUM_BUFFER);
    global.GLR_ILLUM_BUFFER = buffer_create(global.GLR_MAIN_SURFACE_WIDTH * global.GLR_MAIN_SURFACE_HEIGHT * 4, buffer_fixed, 4);
}
