currentThing = 0;
itemContainer = [800, 150];
canControl = false;
alarm[0] = 10;
audio_stop_all();
audio_play_sound(snd_gacha_get, 50, 0);

function DrawOption(arg0, arg1, arg2)
{
    var isNew = true;
    var iconType = 1149;
    draw_set_font(Galmuri9);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    var optionName = arg2.optionName;
    draw_text_color(arg0 + 19, arg1 + 3, optionName, c_white, c_white, c_white, c_white, 1);
    draw_set_alpha(0.8);
    draw_set_halign(fa_right);
    draw_text_scribble(arg0 + 375, arg1 + 3, ">> " + arg2.optionType);
    draw_set_alpha(1);
    if (arg2.optionIcon > 0)
    {
        draw_sprite(arg2.optionIcon, 0, arg0 + 34, arg1 + 39);
    }
    switch (arg2.optionType)
    {
        case "Weapon":
            iconType = 1046;
            break;
        case "Item":
            iconType = 182;
            break;
        case "Skill":
            iconType = 1986;
            break;
        case "Collab":
            iconType = 2219;
            break;
        case "Stage":
            iconType = 41;
            break;
    }
    draw_sprite(iconType, 0, arg0 + 35, arg1 + 40);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_text_scribble_ext(arg0 + 73, arg1 + 21, arg2.optionDescription, 300);
    if (isNew)
    {
        draw_text_color(arg0 + 280, arg1 + 3, global.TextContainer.newText.selectedLanguage, c_yellow, c_yellow, c_yellow, c_yellow, 1);
    }
}

function Confirm()
{
    if (canControl)
    {
        if (currentThing < array_length(global.unlockedThings))
        {
            canControl = false;
            alarm[0] = 20;
            itemContainer[0] = 800;
            audio_play_sound(snd_menu_confirm, 30, 0);
            if (currentThing < (array_length(global.unlockedThings) - 1))
            {
                audio_play_sound(snd_gacha_get, 50, 0);
            }
            currentThing++;
        }
        if (currentThing >= array_length(global.unlockedThings))
        {
            global.unlockedNew = false;
            global.unlockedThings = [];
            if (global.returningRoom > 0)
            {
                room_goto(global.returningRoom);
            }
            else
            {
                room_goto(rm_Title);
            }
        }
    }
}

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirm();
    }
}

initItems();
