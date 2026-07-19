function glr_occlusion_destroy(arg0)
{
    ds_list_delete(global.GLR_OCCLUSION_LIST, ds_list_find_index(global.GLR_OCCLUSION_LIST, arg0));
    ds_list_destroy(arg0);
}
