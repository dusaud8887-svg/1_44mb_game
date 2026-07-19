if (canCollide)
{
    global.goldenHammer = 1;
    global.goldenHammerPieces = 3;
    soundPlay([91], "goldhammerpickup", 10, 0);
    if (array_length(variable_struct_get_names(obj_PlayerManager.availableWeaponCollabs)) > 0 && !global.goldAnvilCanDrop && global.gameMode != 2 && !ds_map_find_value(global.PlayerSave, "noCollabs"))
    {
        global.goldAnvilCanDrop = true;
    }
    instance_destroy();
}
