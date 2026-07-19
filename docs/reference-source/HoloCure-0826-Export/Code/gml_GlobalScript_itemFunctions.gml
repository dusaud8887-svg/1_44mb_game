function item_exists(arg0)
{
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "inventory")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 0) == arg0)
        {
            return true;
        }
    }
    return false;
}

function item_get(arg0)
{
    if (item_exists(arg0))
    {
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "inventory")); i++)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 0) == arg0)
            {
                return array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 1);
            }
        }
        return 0;
    }
    else
    {
        return undefined;
    }
}

function item_get_total(arg0)
{
    if (item_exists(arg0))
    {
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "inventory")); i++)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 0) == arg0)
            {
                if (array_length(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i)) < 3)
                {
                    return 0;
                }
                else
                {
                    return array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 2);
                }
            }
        }
        return 0;
    }
    else
    {
        return undefined;
    }
}

function inventory_add(arg0, arg1 = 1)
{
    var found = false;
    var index = 0;
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "inventory")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 0) == arg0)
        {
            index = i;
            found = true;
            break;
        }
    }
    if (found)
    {
        array_set(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1) + arg1);
        if (array_length(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index)) < 3)
        {
            array_push(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), arg1);
        }
        else
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 2, array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 2) + arg1);
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 2) > 9999)
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 2, 9999);
        }
    }
    else
    {
        array_push(ds_map_find_value(global.PlayerSave, "inventory"), [arg0, arg1, arg1]);
    }
}

function inventory_remove(arg0, arg1 = 1)
{
    var found = false;
    var index = 0;
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "inventory")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), i), 0) == arg0)
        {
            index = i;
            found = true;
            break;
        }
    }
    if (found)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1) > 0)
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1) - arg1);
        }
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1) < 0)
        {
            array_set(array_get(ds_map_find_value(global.PlayerSave, "inventory"), index), 1, 0);
        }
    }
}

function CanCook(arg0)
{
    var allChecked = true;
    var ingredients = variable_struct_get_names(arg0.recipe);
    for (var i = 0; i < array_length(ingredients); i++)
    {
        if (item_exists(ingredients[i]))
        {
            var hasItem = item_get(ingredients[i]);
            var required = variable_struct_get(arg0.recipe, ingredients[i]);
            if (hasItem < required)
            {
                allChecked = false;
            }
        }
        else
        {
            allChecked = false;
        }
    }
    return allChecked;
}

function furniture_unlocked(arg0)
{
    return array_exists(ds_map_find_value(global.PlayerSave, "unlockedFurniture"), arg0);
}

function goldfishcheck(arg0)
{
    switch (arg0)
    {
        case "goldenfish1":
            return !is_undefined(item_get("goldenshrimp"));
            break;
        case "goldenfish2":
            return !is_undefined(item_get("goldenclownfish"));
            break;
        case "goldenfish3":
            return !is_undefined(item_get("goldentuna"));
            break;
        case "goldenfish4":
            return !is_undefined(item_get("goldenkoifish"));
            break;
        case "goldenfish5":
            return !is_undefined(item_get("goldenlobster"));
            break;
        case "goldenfish6":
            return !is_undefined(item_get("goldeneel"));
            break;
        case "goldenfish7":
            return !is_undefined(item_get("goldenpufferfish"));
            break;
        case "goldenfish8":
            return !is_undefined(item_get("goldenmantaray"));
            break;
        case "goldenfish9":
            return !is_undefined(item_get("goldenturtle"));
            break;
        case "goldenfish10":
            return !is_undefined(item_get("goldensquid"));
            break;
        case "goldenfish11":
            return !is_undefined(item_get("goldenshark"));
            break;
        case "goldenfish12":
            return !is_undefined(item_get("goldenaxolotl"));
            break;
    }
}
