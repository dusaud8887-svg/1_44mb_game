function glr_enable_blur(arg0)
{
    global.GLR_BLUR_ENABLED = arg0;
    if (!arg0)
    {
        if (surface_exists(global.GLR_BLUR_SURFACE))
        {
            surface_free(global.GLR_BLUR_SURFACE);
        }
        global.GLR_BLUR_SURFACE = -1;
    }
}
