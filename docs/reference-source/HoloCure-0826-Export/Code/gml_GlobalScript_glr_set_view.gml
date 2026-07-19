function glr_set_view(arg0)
{
    global.GLR_VIEW = arg0;
    var s_width, s_height;
    if (view_enabled)
    {
        var cam = view_camera[global.GLR_VIEW];
        s_width = camera_get_view_width(cam);
        s_height = camera_get_view_height(cam);
    }
    else
    {
        s_width = room_width;
        s_height = room_height;
    }
    if (surface_exists(global.GLR_MAIN_SURFACE))
    {
        surface_free(global.GLR_MAIN_SURFACE);
    }
    global.GLR_WIDTH = s_width;
    global.GLR_HEIGHT = s_height;
    global.GLR_MAIN_SURFACE_WIDTH = s_width * global.GLR_MAIN_QUALITY;
    global.GLR_MAIN_SURFACE_HEIGHT = s_height * global.GLR_MAIN_QUALITY;
    global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    buffer_delete(global.GLR_ILLUM_BUFFER);
    global.GLR_ILLUM_BUFFER = buffer_create(global.GLR_MAIN_SURFACE_WIDTH * global.GLR_MAIN_SURFACE_HEIGHT * 4, buffer_fixed, 4);
    global.GLR_DIRECTIONAL_WIDTH = s_width * global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_HEIGHT = s_height * global.GLR_DIRECTIONAL_QUALITY;
    if (surface_exists(global.GLR_DIRECTIONAL_SURFACE))
    {
        surface_resize(global.GLR_DIRECTIONAL_SURFACE, global.GLR_DIRECTIONAL_WIDTH, global.GLR_DIRECTIONAL_HEIGHT);
    }
    if (surface_exists(global.GLR_DEPTH_SURFACE))
    {
        surface_resize(global.GLR_DEPTH_SURFACE, global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    }
}
