function glr_set_directional_quality(arg0)
{
    global.GLR_DIRECTIONAL_QUALITY = clamp(arg0, 0.05, 1);
    if (surface_exists(global.GLR_DIRECTIONAL_SURFACE))
    {
        global.GLR_DIRECTIONAL_WIDTH = global.GLR_WIDTH * global.GLR_DIRECTIONAL_QUALITY;
        global.GLR_DIRECTIONAL_HEIGHT = global.GLR_HEIGHT * global.GLR_DIRECTIONAL_QUALITY;
        surface_resize(global.GLR_DIRECTIONAL_SURFACE, global.GLR_DIRECTIONAL_WIDTH, global.GLR_DIRECTIONAL_HEIGHT);
    }
}
