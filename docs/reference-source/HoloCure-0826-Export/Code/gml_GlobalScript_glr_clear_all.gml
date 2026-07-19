function glr_clear_all()
{
    glr_light_destroy_all();
    glr_lightsimple_destroy_all();
    glr_mesh_destroy_all();
    glr_receiver_destroy_all();
    glr_shadowsprite_destroy_all();
    glr_shadowarea_destroy_all();
    glr_shadowdepth_destroy_all();
    glr_occlusion_destroy_all();
    glr_directional_custom_destroy_all();
}
