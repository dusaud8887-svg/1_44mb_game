function DoAchievement(arg0)
{
    show_debug_message("doing achievement " + arg0);
    if (variable_global_exists("achievementsMap"))
    {
        if (ds_map_find_value(global.achievementsMap, arg0) != undefined)
        {
            ds_map_find_value(global.achievementsMap, arg0).Check();
            if (!extension_stubfunc_real(arg0))
            {
                extension_stubfunc_real(arg0);
            }
        }
    }
    global.refreshAchievements = true;
}

function AchievementIsUnlocked(arg0)
{
    return ds_map_find_value(global.achievementsMap, arg0).unlocked;
}

function CheckStoreItemsMaxed()
{
    var isMaxed = true;
    var shopItems = obj_Shop.shopItems;
    for (var i = 0; i < array_length(shopItems); i++)
    {
        if (!is_undefined(ds_map_find_value(global.PlayerSave, shopItems[i].optionID)))
        {
            if (shopItems[i].optionID == "challenge")
            {
            }
            else if (ds_map_find_value(global.PlayerSave, shopItems[i].optionID) != array_length(shopItems[i].cost))
            {
                isMaxed = false;
            }
        }
    }
    return isMaxed;
}

function CheckArmouryMaxed()
{
    var isMaxed = false;
    var armoryList = [];
    collabNames = [];
    for (var i = 0; i < array_length(global.seenCollabs); i++)
    {
        if (!array_exists(collabNames, global.seenCollabs[i].optionID))
        {
            array_push(collabNames, global.seenCollabs[i].optionID);
        }
    }
    var key = ds_map_find_first(global.attacksLibrary);
    var size = ds_map_size(global.attacksLibrary);
    for (var i = 0; i < size; i++)
    {
        var thing = ds_map_find_value(global.attacksLibrary, key);
        if (thing.config.optionType == "Weapon")
        {
            array_push(armoryList, thing.config);
        }
        key = ds_map_find_next(global.attacksLibrary, key);
    }
    key = ds_map_find_first(global.itemsLibrary);
    size = ds_map_size(global.itemsLibrary);
    for (var i = 0; i < size; i++)
    {
        var thing = ds_map_find_value(global.itemsLibrary, key);
        if (thing.optionType == "Item")
        {
            array_push(armoryList, thing);
        }
        key = ds_map_find_next(global.itemsLibrary, key);
    }
    key = ds_map_find_first(global.attacksLibrary);
    size = ds_map_size(global.attacksLibrary);
    for (var i = 0; i < size; i++)
    {
        var thing = ds_map_find_value(global.attacksLibrary, key);
        if (thing.config.optionType == "Collab" || thing.config.optionType == "SuperCollab")
        {
            array_push(armoryList, thing.config);
        }
        key = ds_map_find_next(global.attacksLibrary, key);
    }
    var totalThings = array_length(armoryList);
    var totalPlayerThings = array_length(ds_map_find_value(global.PlayerSave, "unlockedWeapons")) + array_length(ds_map_find_value(global.PlayerSave, "unlockedItems")) + array_length(collabNames);
    show_debug_message("totalThings: " + string(totalThings));
    show_debug_message("total Player Things: " + string(totalPlayerThings));
    if (totalPlayerThings == totalThings)
    {
        DoAchievement("fullyLoaded");
    }
}
