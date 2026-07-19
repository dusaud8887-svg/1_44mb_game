if (global.camera_scale != global.new_camera_scale)
{
    global.camera_scale += ((global.new_camera_scale - global.camera_scale) / 5);
    camera_set_view_size(view_camera[0], 640 / global.camera_scale, 360 / global.camera_scale);
    with (obj_glareLighting)
    {
        global.GLR_ZOOM = global.camera_scale;
    }
}
