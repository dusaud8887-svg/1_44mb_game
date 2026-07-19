if (!is_undefined(variable_struct_get(wallOptions, currentOption)))
{
    draw_sprite(variable_struct_get(wallOptions, currentOption), 0, x, y);
}
else
{
    draw_self();
}
