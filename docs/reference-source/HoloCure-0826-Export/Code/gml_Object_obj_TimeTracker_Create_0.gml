if (!is_undefined(ds_map_find_value(global.PlayerSave, "trackedTime")))
{
    global.TrackedTime = ds_map_find_value(global.PlayerSave, "trackedTime");
}
else
{
    global.TrackedTime = 0;
}
