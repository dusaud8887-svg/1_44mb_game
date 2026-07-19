gamma_rendering_mode = false;
if (os_type != os_android && os_type != os_ios)
{
    glr_init(1);
    glr_set_directional_quality(1);
    glr_enable_directional(true);
    room_goto_next();
}
else
{
    glr_init(1);
    room_goto_next();
}
