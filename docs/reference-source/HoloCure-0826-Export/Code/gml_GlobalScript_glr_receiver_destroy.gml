function glr_receiver_destroy(arg0)
{
    ds_list_delete(global.GLR_RECEIVER_LIST, ds_list_find_index(global.GLR_RECEIVER_LIST, arg0));
    ds_list_destroy(arg0);
}
