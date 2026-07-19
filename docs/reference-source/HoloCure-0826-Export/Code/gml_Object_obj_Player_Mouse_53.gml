if (window_has_focus() && canControl)
{
    if (instance_exists(obj_PlayerManager))
    {
        mouseFollowMode = !mouseFollowMode;
        obj_PlayerManager.playerFlags.aimed = true;
    }
}
