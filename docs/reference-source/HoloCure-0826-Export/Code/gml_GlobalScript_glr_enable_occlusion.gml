function glr_enable_occlusion(arg0)
{
    if (arg0 && !global.GLR_OCCLUSION_ENABLED && !surface_exists(global.GLR_DEPTH_SURFACE))
    {
        global.GLR_DEPTH_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    }
    global.GLR_OCCLUSION_ENABLED = arg0;
}
