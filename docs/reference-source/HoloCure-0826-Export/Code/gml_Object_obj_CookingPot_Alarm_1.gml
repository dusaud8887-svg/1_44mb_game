if (currentIngredient <= (array_length(ingredientList) - 1))
{
    if (item_exists(ingredientList[currentIngredient]))
    {
        var getIngredient = ds_map_find_value(global.InventoryLibrary, array_get(ingredientList, currentIngredient));
        var item = instance_create_depth(obj_Player.x, obj_Player.y, obj_Player.depth - 20, obj_CookIngredient);
        audio_play_sound(snd_yubiget, 0, 0);
        item.sprite_index = getIngredient.inventoryIcon;
    }
    currentIngredient++;
    alarm[1] = 10;
}
else
{
    beginCooking = true;
}
