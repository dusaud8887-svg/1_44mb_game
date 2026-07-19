function glr_shadowarea_update(arg0, arg1, arg2)
{
    var l = arg0;
    var w = arg1;
    var h = arg2;
    vertex_delete_buffer(ds_list_find_value(l, UnknownEnum.Value_1));
    var buf = vertex_create_buffer();
    vertex_begin(buf, global.GLR_MODEL_FORMAT);
    vertex_position(buf, 0, 0);
    vertex_position(buf, w, 0);
    vertex_position(buf, 0, h);
    vertex_position(buf, w, h);
    vertex_end(buf);
    vertex_freeze(buf);
    ds_list_set(l, UnknownEnum.Value_1, buf);
}

enum UnknownEnum
{
    Value_1 = 1
}
