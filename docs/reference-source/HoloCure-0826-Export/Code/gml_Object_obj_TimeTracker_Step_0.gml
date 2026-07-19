if (!instance_exists(obj_PlantManager) && array_exists(ds_map_find_value(global.PlayerSave, "unlockedStages"), "HOLO HOUSE"))
{
    global.TrackedTime++;
}
