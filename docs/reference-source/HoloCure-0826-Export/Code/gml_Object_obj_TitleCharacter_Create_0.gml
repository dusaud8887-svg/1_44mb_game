lifetime = 0;
lifetime = irandom(24) * 0.05235987755982988;
unlocked = false;
for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
{
    if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == charName)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) > 0)
        {
            unlocked = true;
            break;
        }
    }
}
