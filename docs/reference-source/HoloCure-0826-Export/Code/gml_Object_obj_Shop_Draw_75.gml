if (gachaCompleted)
{
    draw_set_font(Galmuri14);
    draw_set_halign(fa_center);
    draw_set_alpha(1);
    var pullAmount = array_length(gachaPulls);
    if (pullAmount == 1)
    {
        var pull = gachaPulls[0];
        var charLookup = ds_map_find_value(global.characterData, pull.characterGot);
        if (pull.characterGot != "")
        {
            if (charLookup.large_port > 0)
            {
                draw_sprite_ext(charLookup.large_port, 0, 100, 300, -2, 2, 0, c_white, 1);
                draw_sprite_ext(charLookup.large_port, 0, 540, 300, 2, 2, 0, c_white, 1);
            }
            if (pull.chosenOutfit == "")
            {
                draw_sprite_ext(charLookup.sprite1, image_index / 2, 320, 220, 3, 3, 0, c_white, 1);
            }
            else
            {
                var of = variable_struct_get(charLookup.outfits, pull.chosenOutfit);
                draw_sprite_ext(of.sprites[0].sprite1, image_index / 2, 320, 220, 3, 3, 0, c_white, 1);
            }
        }
        draw_set_font(Galmuri14);
        draw_set_color(c_yellow);
        var textSuffix = pull.isNew ? " UNLOCKED!!!" : " RANK UP!!!";
        draw_text_outline(320, 270, charLookup.charName + textSuffix, 1.5, 0, 32, 4, 500, 65535, 1);
        if (pull.chosenOutfit != "")
        {
            draw_text_outline(320, 310, "OUTFIT GET!!!", 1.5, 0, 32, 4, 500, 65535, 1);
        }
    }
    else
    {
        var i = pullAmount - 1;
        while (i >= 0)
        {
            var charPosY = (pullAmount <= 5) ? 220 : ((i < 5) ? 180 : 320);
            var topRow = (i < 5) ? true : false;
            var rowIndex = topRow ? i : (i - 5);
            var rowCharAmount = topRow ? min(pullAmount, 5) : (pullAmount - 5);
            var rowPosOffset = (rowCharAmount - 1) * 60;
            var charPosX = (320 + (rowIndex * 120)) - rowPosOffset;
            var pull = gachaPulls[i];
            var charLookup = ds_map_find_value(global.characterData, pull.characterGot);
            if (pull.characterGot != "")
            {
                if (pull.chosenOutfit == "")
                {
                    draw_sprite_ext(charLookup.sprite1, image_index / 2, charPosX, charPosY, 3, 3, 0, c_white, 1);
                }
                else
                {
                    var of = variable_struct_get(charLookup.outfits, pull.chosenOutfit);
                    draw_sprite_ext(of.sprites[0].sprite1, image_index / 2, charPosX, charPosY, 3, 3, 0, c_white, 1);
                }
            }
            draw_set_font(buffFont);
            draw_set_color(c_yellow);
            var testSuffix = pull.isNew ? " UNLOCKED!!!" : " RANK UP!!!";
            draw_text_outline(charPosX, charPosY + 10, testSuffix, 0.75, 0, 32, 4, 500, 65535, 1);
            if (pull.chosenOutfit != "")
            {
                draw_text_outline(charPosX, charPosY + 10 + 14, "OUTFIT GET!!!", 0.75, 0, 32, 4, 500, 65535, 1);
            }
            i--;
        }
        draw_set_font(Galmuri14);
    }
    draw_text_outline(320, 30, "CONGRATULATIONS!!!", 1.5, 0, 32, 4, 300, 16777215, 1);
    if (whiteFlash)
    {
        flashTime++;
        draw_set_color(c_white);
        draw_set_alpha(1 - (flashTime / 60));
        draw_rectangle(0, 0, 640, 360, false);
        if (flashTime > 60)
        {
            flashTime = 0;
            whiteFlash = false;
        }
    }
}
draw_set_alpha(1);
