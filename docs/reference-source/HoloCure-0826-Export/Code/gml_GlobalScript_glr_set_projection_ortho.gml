function glr_set_projection_ortho(arg0, arg1, arg2, arg3, arg4)
{
    var mV = matrix_build_lookat(arg0 + (arg2 / 2), arg1 + (arg3 / 2), -16000, arg0 + (arg2 / 2), arg1 + (arg3 / 2), 0, dsin(-arg4), dcos(-arg4), 0);
    var mP = matrix_build_projection_ortho(arg2, arg3, 1, 32000);
    var cam = camera_get_active();
    camera_set_view_mat(cam, mV);
    camera_set_proj_mat(cam, mP);
    camera_apply(cam);
}
