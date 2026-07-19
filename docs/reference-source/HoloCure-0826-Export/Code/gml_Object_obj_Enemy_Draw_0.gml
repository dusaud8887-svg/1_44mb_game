event_inherited();
if (global.lightingExists)
{
    glr_mesh_set_transform(playerMesh, x, y, image_xscale, image_yscale, image_angle);
}
if (!isVisible)
{
    glr_mesh_set_shadow_strength(playerMesh, 0);
}
else
{
    glr_mesh_set_shadow_strength(playerMesh, 0.2);
}
if (variable_struct_exists(behaviours, "shieldRecover"))
{
    if (shieldHP > 0 && shieldHP != behaviours.shieldRecover.config.maxShield)
    {
        draw_healthbar(x - (13 * abs(image_xscale)), y - (30 * image_yscale) - 22, x + (13 * abs(image_xscale)), y - (30 * image_yscale) - 26, (shieldHP / behaviours.shieldRecover.config.maxShield) * 100, c_red, make_color_rgb(78, 173, 255), make_color_rgb(78, 173, 255), 0, 0, 1);
    }
}
