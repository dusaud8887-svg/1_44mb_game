if (used)
{
    DoAchievement("timeToUpgrade");
    UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "CreditCard", "ITEM");
    if (remainingUses > 0)
    {
        remainingUses--;
    }
    used = false;
}
if (remainingUses < 1)
{
    Destroy();
}
isInView = x > (camera_get_view_x(view_camera[0]) - 15) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 15) && y > (camera_get_view_y(view_camera[0]) - 15) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 15);
