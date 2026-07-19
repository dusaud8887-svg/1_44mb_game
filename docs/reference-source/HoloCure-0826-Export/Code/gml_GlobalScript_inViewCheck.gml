function inViewCheck(arg0, arg1)
{
    return arg0 > camera_get_view_x(view_camera[0] - 20) && arg0 < (camera_get_view_x(view_camera[0]) + 660) && arg1 > (camera_get_view_y(view_camera[0]) - 20) && arg1 < (camera_get_view_y(view_camera[0]) + 380);
}
