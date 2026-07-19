function glr_shadowdepth_destroy(arg0)
{
    ds_list_delete(global.GLR_DEP_DYN_LIST, ds_list_find_index(global.GLR_DEP_DYN_LIST, arg0));
    ds_list_destroy(arg0);
}
