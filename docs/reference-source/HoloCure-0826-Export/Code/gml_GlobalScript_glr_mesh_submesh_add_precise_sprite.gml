function glr_mesh_submesh_add_precise_sprite(arg0, arg1, arg2, arg3 = 180, arg4 = 200, arg5 = false)
{
    if (arg5)
    {
        glr_mesh_submesh_add_precise_sprite_greedy(arg0, arg1, arg2, arg3, arg4);
    }
    else
    {
        glr_mesh_submesh_add_precise_sprite_normal(arg0, arg1, arg2, arg3, arg4);
    }
}

function glr_mesh_submesh_add_precise_sprite_greedy(arg0, arg1, arg2, arg3 = 360, arg4 = 200)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var w = sprite_get_width(arg1);
    var h = sprite_get_height(arg1);
    var xo = sprite_get_xoffset(arg1);
    var yo = sprite_get_yoffset(arg1);
    var surf = surface_create(w, h);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(arg1, arg2, xo, yo);
    surface_reset_target();
    var buffImg = buffer_create((w * h) << 2, buffer_fast, 1);
    buffer_get_surface(buffImg, surf, 0);
    var pointsList = ds_list_create();
    var curangle = 0;
    var curlen = 0;
    arg3 = 360 / arg3;
    var Xadd = 0;
    var Yadd = 0;
    arg3 = min(arg3, 360);
    arg3 = max(arg3, 1);
    var pointcount = 0;
    for (curangle = 0; curangle < 360; curangle += arg3)
    {
        curlen = 0;
        var x2lastvalid = -1;
        var y2lastvalid = -1;
        var dcosAng = dcos(curangle);
        var dsinAng = -dsin(curangle);
        while (true)
        {
            curlen++;
            x2lastvalid = curlen * dcosAng;
            y2lastvalid = curlen * dsinAng;
            Xadd = floor(xo + x2lastvalid);
            Yadd = floor(yo + y2lastvalid);
            if ((Xadd >= w || Xadd <= 0) | (Yadd >= h || Yadd <= 0))
            {
                break;
            }
            var px = (Xadd + (Yadd * w)) << 2;
            px++;
            px++;
            px++;
            var alpha = buffer_peek(buffImg, px, buffer_u8);
            if (alpha < arg4)
            {
                break;
            }
        }
        pointcount++;
        ds_list_add(pointsList, x2lastvalid, y2lastvalid);
    }
    buffer_delete(buffImg);
    surface_free(surf);
    ds_list_add(ds_list_find_value(arg0, UnknownEnum.Value_6), pointsList);
}

function glr_mesh_submesh_add_precise_sprite_normal(arg0, arg1, arg2, arg3 = 360, arg4 = 200)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var w = sprite_get_width(arg1);
    var h = sprite_get_height(arg1);
    var xo = sprite_get_xoffset(arg1);
    var yo = sprite_get_yoffset(arg1);
    var surf = surface_create(w, h);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(arg1, arg2, xo, yo);
    surface_reset_target();
    var buffImg = buffer_create((w * h) << 2, buffer_fast, 1);
    buffer_get_surface(buffImg, surf, 0);
    var pointsList = ds_list_create();
    var curangle = 0;
    var curlen = 0;
    arg3 = 360 / arg3;
    var Xadd = 0;
    var Yadd = 0;
    var x2 = 0;
    var y2 = 0;
    arg3 = min(arg3, 360);
    arg3 = max(arg3, 1);
    var pointcount = 0;
    for (curangle = 0; curangle < 360; curangle += arg3)
    {
        curlen = 0;
        var x2lastvalid = -1;
        var y2lastvalid = -1;
        var dcosAng = dcos(curangle);
        var dsinAng = -dsin(curangle);
        while (true)
        {
            curlen++;
            x2 = curlen * dcosAng;
            y2 = curlen * dsinAng;
            Xadd = floor(xo + x2);
            Yadd = floor(yo + y2);
            if ((Xadd >= w || Xadd <= 0) | (Yadd >= h || Yadd <= 0))
            {
                if (x2lastvalid == -1)
                {
                    x2lastvalid = x2;
                }
                if (y2lastvalid == -1)
                {
                    y2lastvalid = y2;
                }
                break;
            }
            var px = (Xadd + (Yadd * w)) << 2;
            px++;
            px++;
            px++;
            var alpha = buffer_peek(buffImg, px, buffer_u8);
            if (alpha > arg4)
            {
                x2lastvalid = x2;
                y2lastvalid = y2;
            }
        }
        pointcount++;
        ds_list_add(pointsList, x2lastvalid, y2lastvalid);
    }
    buffer_delete(buffImg);
    surface_free(surf);
    ds_list_add(ds_list_find_value(arg0, UnknownEnum.Value_6), pointsList);
}

enum UnknownEnum
{
    Value_6 = 6
}
