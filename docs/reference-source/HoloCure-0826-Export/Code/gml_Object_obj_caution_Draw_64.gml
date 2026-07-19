switch (dir)
{
    case 0:
        draw_sprite_ext(spr_cautions, 0, 590, 180, 1, 1, 0, c_white, image_alpha);
        break;
    case 90:
        draw_sprite_ext(spr_cautions, 1, 320, 50, 1, 1, 0, c_white, image_alpha);
        break;
    case 180:
        draw_sprite_ext(spr_cautions, 2, 50, 180, 1, 1, 0, c_white, image_alpha);
        break;
    case 270:
        draw_sprite_ext(spr_cautions, 3, 320, 310, 1, 1, 0, c_white, image_alpha);
        break;
}
