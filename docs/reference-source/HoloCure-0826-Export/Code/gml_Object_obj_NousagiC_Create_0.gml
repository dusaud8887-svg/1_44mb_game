spriteColor = 16777215;
interactable = true;
interactIcon = 2094;
interacting = false;
canControl = true;
highlighted = false;
interactIconY = 45;
interactRange = 30;
image_index = irandom(1);

function Confirm()
{
    if (highlighted && !interacting && obj_Player.canControl)
    {
        interacting = true;
        if (obj_Player.x > x)
        {
            obj_Player.direction = 180;
        }
        else
        {
            obj_Player.direction = 0;
        }
        obj_Player.canControl = false;
        obj_HoloHouseManager.canControl = false;
        obj_DialogueController.BeginDialogue(global.TextContainer.nousagiCDialogue.selectedLanguage, id);
        audio_play_sound(snd_menu_confirm, 30, 0);
    }
}

function Return()
{
    if (interacting)
    {
        interacting = false;
        obj_Player.canControl = true;
        obj_HoloHouseManager.alarm[1] = 5;
    }
}

function SelectLeft()
{
}

function SelectRight()
{
}

function SelectUp()
{
}

function SelectDown()
{
}
