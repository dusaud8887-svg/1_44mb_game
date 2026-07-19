function glr_receiver_destroy_all()
{
    var size = ds_list_size(global.GLR_RECEIVER_LIST);
    for (i = 0; i < size; i++)
    {
        var ss = ds_list_find_value(global.GLR_RECEIVER_LIST, i);
        ds_list_destroy(ss);
    }
    ds_list_clear(global.GLR_RECEIVER_LIST);
}
