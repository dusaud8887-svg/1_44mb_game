fullDialogue = [];
currentPage = 0;
displayingDialogue = "";
showingDialogue = false;
displayDelay = 0;
currentNPC = -1;
timer = 0;
depth = -5000;

function BeginDialogue(arg0, arg1)
{
    showingDialogue = true;
    fullDialogue = arg0;
    currentPage = 0;
    displayingDialogue = "";
    displayDelay = 3;
    textIndex = 1;
    obj_Player.canControl = false;
    currentNPC = arg1;
    if (instance_exists(obj_HoloHouseManager))
    {
        obj_HoloHouseManager.canControl = false;
    }
    if (instance_exists(obj_PlayerManager))
    {
        obj_PlayerManager.canControl = false;
    }
    currentNPC.canControl = false;
}

function EndDialogue()
{
    show_debug_message("ended dialogue");
    showingDialogue = false;
    currentNPC.alarm[0] = 10;
    currentNPC = -1;
}

function Confirmed()
{
    if (showingDialogue)
    {
        if (displayingDialogue != fullDialogue[currentPage][1])
        {
            displayingDialogue = fullDialogue[currentPage][1];
        }
        else if (currentPage < (array_length(fullDialogue) - 1))
        {
            currentPage++;
            displayingDialogue = "";
            displayDelay = 2;
            textIndex = 1;
            audio_play_sound(snd_menu_confirm, 0, 0);
        }
        else
        {
            audio_play_sound(snd_menu_confirm, 0, 0);
            EndDialogue();
        }
    }
}

function ReturnMenu()
{
    if (showingDialogue)
    {
        audio_play_sound(snd_menu_back, 0, 0);
        EndDialogue();
    }
}

function DrawDialogue(arg0, arg1)
{
    var iconType = 1149;
    var optionAlpha = 1;
    draw_sprite(hud_dialogueBox, 0, arg0, arg1);
    arg0 -= 237;
    draw_set_font(Galmuri9);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    var nameColor = 65535;
    draw_set_color(nameColor);
    draw_text_scribble_ext(arg0 + 22, arg1 + 8, fullDialogue[currentPage][0], 500, 10, undefined, 1);
    draw_set_color(c_white);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_text_scribble_ext(arg0 + 22, arg1 + 23, displayingDialogue, 440, 13, undefined, optionAlpha);
    draw_sprite(hud_dialogueButton, timer div 30, arg0 + 460, arg1 + 65);
    draw_set_alpha(1);
}
