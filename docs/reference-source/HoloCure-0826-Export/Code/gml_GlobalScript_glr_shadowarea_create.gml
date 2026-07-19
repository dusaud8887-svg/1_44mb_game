function glr_shadowarea_create(arg0, arg1, arg2, arg3, arg4)
{
    var l = ds_list_create();
    ds_list_set(l, UnknownEnum.Value_0, true);
    ds_list_set(l, UnknownEnum.Value_2, arg0);
    ds_list_set(l, UnknownEnum.Value_3, arg1);
    ds_list_set(l, UnknownEnum.Value_4, 0);
    ds_list_set(l, UnknownEnum.Value_5, 0);
    ds_list_set(l, UnknownEnum.Value_6, arg4);
    ds_list_set(l, UnknownEnum.Value_7, matrix_build(arg0, arg1, 0, 0, 0, 0, 1, 1, 1));
    var buf = vertex_create_buffer();
    vertex_begin(buf, global.GLR_MODEL_FORMAT);
    vertex_position(buf, 0, 0);
    vertex_position(buf, arg2, 0);
    vertex_position(buf, 0, arg3);
    vertex_position(buf, arg2, arg3);
    vertex_end(buf);
    vertex_freeze(buf);
    ds_list_set(l, UnknownEnum.Value_1, buf);
    ds_list_add(global.GLR_SHADOWAREA_LIST, l);
    return l;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7
}
