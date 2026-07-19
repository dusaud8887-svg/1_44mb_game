function glr_occlusion_destroy_instance(arg0)
{
    ds_list_delete(global.GLR_OCCLUSION_LIST_INST, ds_list_find_index(global.GLR_OCCLUSION_LIST_INST, arg0));
}
