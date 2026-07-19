wallOptions = 
{
    woodenWall: 1240,
    flatWall: 451,
    stripedWall: 1814,
    skyWall: 1359,
    polkaWallA: 1409,
    polkaWallB: 257,
    polkaWallC: 20,
    oceanWall: 2204,
    modernWall: 2279,
    stoneWall: 1591,
    easternWall: 856,
    redWall: 1240,
    blueWall: 1240,
    greenWall: 1240,
    yellowWall: 1240,
    whiteWall: 1240,
    blackWall: 1240,
    purpleWall: 1240,
    brownWall: 1240,
    pinkWall: 1240
};
currentOption = "woodenWall";

function SetWall(arg0)
{
    currentOption = arg0;
}

function LoadWalls()
{
    if (is_struct(ds_map_find_value(global.PlayerSave, "holoHouseSet")))
    {
        if (variable_struct_exists(ds_map_find_value(global.PlayerSave, "holoHouseSet"), "wall"))
        {
            currentOption = ds_map_find_value(global.PlayerSave, "holoHouseSet").wall;
        }
        else
        {
            currentOption = "woodenWall";
        }
    }
}

LoadWalls();
