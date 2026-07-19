function HadWeapon(arg0, arg1)
{
    if (!is_undefined(arg0))
    {
        var key = ds_map_find_first(arg0);
        while (!is_undefined(key))
        {
            var attackObj = ds_map_find_value(arg0, key);
            if (is_array(arg1))
            {
                for (var j = 0; j < array_length(arg1); j++)
                {
                    if (attackObj.config.attackID == arg1[j])
                    {
                        return true;
                    }
                }
            }
            else if (attackObj.config.attackID == arg1)
            {
                return true;
            }
            key = ds_map_find_next(arg0, key);
        }
    }
    return false;
}

function HadItem(arg0, arg1)
{
    var itemsList = variable_struct_get_names(arg0);
    for (var i = 0; i < array_length(itemsList); i++)
    {
        var attackObj = itemsList[i];
        if (attackObj == arg1)
        {
            return true;
        }
    }
    return false;
}
