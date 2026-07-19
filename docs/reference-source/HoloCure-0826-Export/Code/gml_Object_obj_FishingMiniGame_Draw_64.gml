if (fishingMode)
{
    if (letterBox < 0)
    {
        letterBox = floor(letterBox / 2);
    }
    draw_healthbar(232, 96, 407, 112, fishGauge, c_white, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, false, false);
    if (barHold)
    {
        barFlashTime++;
        var barColor = 255;
        draw_set_alpha(abs(sin(barFlashTime / 2)));
        if (fishGauge >= 100)
        {
            barColor = 16777215;
        }
        draw_healthbar(232, 96, 407, 112, 100, barColor, barColor, barColor, 0, false, false);
        draw_set_alpha(1);
    }
    draw_sprite(spr_FishGauge, 0, 232, 96);
    draw_sprite(spr_FishIcon, 0, 232 + ((fishGauge / 100) * 176), 88);
    if (!barHold)
    {
        draw_sprite(spr_rhythmBar, 0, 217, 252);
        for (var i = 0; i < array_length(buttonArray); i++)
        {
            if (failTimer > 0)
            {
                draw_set_alpha(0.5);
            }
            draw_sprite(spr_rhythmButtons, buttonArray[i][0], 217 + ((1 - (buttonArray[i][1] / queueTime)) * 192), 252);
            draw_set_alpha(1);
        }
    }
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, 640, 50 + letterBox, false);
    draw_rectangle(0, 360 - (50 + letterBox), 640, 360, false);
    draw_set_alpha(1);
    var xOffSet = -20;
    var yOffSet = 75;
    if (comboChain > 0)
    {
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_font(Galmuri14);
        draw_text_outline(450 + xOffSet, 155 + yOffSet, "CHAIN:  " + string(comboChain), 1, 0, 16, 4, 200, 16777215, 1);
        draw_set_font(Galmuri9);
        draw_text_outline(455 + xOffSet, 185 + yOffSet, global.TextContainer.fishChain.selectedLanguage + string(bonusYield), 1, 0, 16, 4, 200, 16777215, 1);
        if (difficultyUp > 0)
        {
            draw_text_outline(455 + xOffSet, 200 + yOffSet, "Speed:  Lv " + string(difficultyUp / 5), 1, 0, 16, 4, 200, 255, 1);
        }
    }
}
if (fishingResults && fishResultsTimer >= waitTime)
{
    if (resultsContainer[1] < 110)
    {
        resultsContainer[1] += 40;
    }
    else
    {
        resultsContainer[1] = 110;
    }
    draw_sprite(hud_fishingResults, 0, resultsContainer[0], resultsContainer[1]);
    draw_set_font(Galmuri14);
    draw_set_halign(fa_center);
    var resultText = "";
    if (fishGauge >= 100)
    {
        resultText = global.TextContainer.fishingSuccess.selectedLanguage;
    }
    else
    {
        resultText = global.TextContainer.enhanceFailed.selectedLanguage;
    }
    draw_text_outline(resultsContainer[0], resultsContainer[1] + 10, resultText, 2, 0, 16, 4, 200, 16777215, 1);
    draw_sprite(hud_confirmButton, 0, resultsContainer[0], resultsContainer[1] + 155);
    draw_set_font(Galmuri9);
    draw_set_color(c_black);
    draw_text_scribble(resultsContainer[0], resultsContainer[1] + 150, "OK");
    if (MouseOverButton("short", resultsContainer[0], resultsContainer[1] + 155))
    {
        ClickButton();
    }
    if (fishGauge >= 100)
    {
        if (!fishingFurniture)
        {
            draw_sprite(currentCatchingFish.inventoryIcon, 0, resultsContainer[0], resultsContainer[1] + 70);
        }
        else
        {
            draw_sprite(selectedFurniture.furnitureIcon, 0, resultsContainer[0], resultsContainer[1] + 70);
        }
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        var resultsText;
        if (!fishingFurniture)
        {
            resultsText = currentCatchingFish.inventoryName + " x " + string(catchNumber);
        }
        else
        {
            resultsText = selectedFurniture.furnitureName;
        }
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 110, resultsText, 1, 0, 16, 4, 175, 16777215, 1);
        for (var i = 0; i < 5; i++)
        {
            gpu_set_blendmode(bm_add);
            draw_sprite_ext(hudfx_itemLightBeam, 0, resultsContainer[0], resultsContainer[1] + 70, 1 + foundGold, 1 + foundGold, lightTime + (i * 72), c_white, 1);
            gpu_set_blendmode(bm_normal);
        }
        if (foundGold)
        {
            var sparks = instance_create_depth(random(640), -10, depth - 20, obj_sparkle);
            sparks.speed = 0;
        }
        if (foundGold && fireworksCD == 0)
        {
            fireworksCD = 15;
            instance_create_depth(irandom(640), 360, depth - 20, obj_fireworks);
        }
        if (fireworksCD > 0)
        {
            fireworksCD--;
        }
        lightTime++;
    }
    else if (fishingResults)
    {
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 100, global.TextContainer.fishingFailed.selectedLanguage, 1, 0, 16, 4, 175, 16777215, 1);
    }
}
