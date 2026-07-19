function glr_mesh_create(arg0, arg1, arg2)
{
    var l = ds_list_create();
    ds_list_set(l, UnknownEnum.Value_0, UnknownEnum.Value_2);
    ds_list_set(l, UnknownEnum.Value_1, true);
    ds_list_set(l, UnknownEnum.Value_3, arg2);
    ds_list_set(l, UnknownEnum.Value_6, ds_list_create());
    ds_list_set(l, UnknownEnum.Value_4, -1);
    ds_list_set(l, UnknownEnum.Value_5, -1);
    ds_list_set(l, UnknownEnum.Value_7, arg0);
    ds_list_set(l, UnknownEnum.Value_8, arg1);
    ds_list_set(l, UnknownEnum.Value_9, 0);
    ds_list_set(l, UnknownEnum.Value_10, 1);
    ds_list_set(l, UnknownEnum.Value_11, 1);
    ds_list_set(l, UnknownEnum.Value_12, 0);
    ds_list_set(l, UnknownEnum.Value_13, 0);
    ds_list_set(l, UnknownEnum.Value_17, 0);
    ds_list_set(l, UnknownEnum.Value_18, 1);
    ds_list_set(l, UnknownEnum.Value_19, 1);
    ds_list_set(l, UnknownEnum.Value_20, 0);
    ds_list_set(l, UnknownEnum.Value_23, 0);
    ds_list_set(l, UnknownEnum.Value_2, 0);
    ds_list_set(l, UnknownEnum.Value_21, -1);
    ds_list_set(l, UnknownEnum.Value_22, -1);
    ds_list_set(l, UnknownEnum.Value_14, 0);
    ds_list_set(l, UnknownEnum.Value_15, 0);
    ds_list_set(l, UnknownEnum.Value_16, 0);
    ds_list_insert(l, UnknownEnum.Value_23, matrix_build(arg0, arg1, 0, 0, 0, 0, 1, 1, 1));
    if (arg2)
    {
        ds_list_add(global.GLR_MESH_STC_LIST, l);
    }
    else
    {
        ds_list_add(global.GLR_MESH_DYN_LIST, l);
    }
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
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23
}
