spriteColor = 16777215;
interactable = false;
interactIcon = -1;
interacting = false;
canControl = true;
highlighted = false;
interactIconY = 45;
interactRange = 30;
image_index = irandom(1);

function Confirm()
{
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
