switch (irandom(2))
{
    case 0:
        sprite_index = BG_fulltree;
        break;
    case 1:
        sprite_index = BG_fulltree2;
        break;
    case 2:
        sprite_index = BG_fulltree3;
        break;
}
if (room == rm_GrassPlains_Night)
{
    sprite_index = BG_fulltree_night;
    particle_color = make_color_rgb(193, 213, 227);
}
event_inherited();
alarm[0] = 10;
