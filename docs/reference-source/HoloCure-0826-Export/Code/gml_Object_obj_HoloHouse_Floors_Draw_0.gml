if (!is_undefined(variable_struct_get(floorOptions, currentOption)))
{
    draw_sprite(variable_struct_get(floorOptions, currentOption), 0, x, y);
}
else
{
    draw_self();
}
