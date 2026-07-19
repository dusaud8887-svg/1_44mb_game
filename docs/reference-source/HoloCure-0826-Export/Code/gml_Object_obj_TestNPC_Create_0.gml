spriteColor = 16777215;
interactable = true;
interactIcon = -1;
interacting = false;
canControl = true;
highlighted = false;
interactIconY = 65;
interactRange = 30;

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
        obj_DialogueController.BeginDialogue(global.TextContainer.testDialogue.selectedLanguage, id);
    }
}

function Return()
{
    if (interacting)
    {
        interacting = false;
        obj_Player.canControl = true;
        obj_HoloHouseManager.canControl = true;
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
