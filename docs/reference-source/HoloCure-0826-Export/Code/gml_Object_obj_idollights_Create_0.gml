var roll = irandom(4);
var size = 0.5 + random(1.5);
image_xscale = size;
image_yscale = size;
guiMode = false;
rotDir = 0;
rotSpeed = 0;
alarm[0] = 120;
switch (roll)
{
    case 0:
        sprite_index = spr_gacha_yellowlight;
        break;
    case 1:
        sprite_index = spr_gacha_greenlight;
        break;
    case 2:
        sprite_index = spr_gacha_bluelight;
        break;
    case 3:
        sprite_index = spr_gacha_purplelight;
        break;
    case 4:
        sprite_index = spr_gacha_red_light;
        break;
}
