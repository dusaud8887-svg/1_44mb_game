function set_camera(arg0, arg1, arg2, arg3)
{
    view_enabled = true;
    view_visible[0] = true;
    view_wport[0] = arg2;
    view_hport[0] = arg3;
    view_camera[0] = camera_create_view(arg0, arg1, view_wport[0], view_hport[0], 0, -1, -1, -1, 0, 0);
}
