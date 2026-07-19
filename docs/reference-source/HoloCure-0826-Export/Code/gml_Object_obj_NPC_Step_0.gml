depth = -y;
highlighted = false;
if (interactable && obj_Player.canControl)
{
    var colliding = collision_circle(x, y, interactRange, obj_Player, true, true);
    if (instance_exists(colliding))
    {
        highlighted = true;
    }
    else
    {
        highlighted = false;
    }
}
if (!interacting && interactable)
{
    if (instance_exists(obj_InputManager))
    {
        if (obj_InputManager.actionOnePressed)
        {
            Confirm();
        }
    }
}
else if (interacting)
{
    if (instance_exists(obj_InputManager))
    {
        if (obj_InputManager.actionOnePressed)
        {
            Confirm();
        }
        if (obj_InputManager.actionTwoPressed)
        {
            Return();
        }
        if (obj_InputManager.moveLeftPressed)
        {
            SelectLeft();
        }
        if (obj_InputManager.moveRightPressed)
        {
            SelectRight();
        }
        if (obj_InputManager.moveUpPressed)
        {
            SelectUp();
        }
        if (obj_InputManager.moveDownPressed)
        {
            SelectDown();
        }
    }
}
