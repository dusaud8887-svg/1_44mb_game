function AddFandomEXP(arg0, arg1)
{
    var index = -1;
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "fandomEXP")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 0) == arg0)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1) < 100)
            {
                array_set(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1) + arg1);
            }
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1) > 100)
            {
                array_set(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), i), 1, 100);
            }
        }
    }
}
