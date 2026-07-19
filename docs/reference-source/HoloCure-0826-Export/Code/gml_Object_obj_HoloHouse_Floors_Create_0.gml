floorOptions = 
{
    woodenFloor: 1573,
    woodenFloor2: 2026,
    stoneFloor: 2310,
    redCarpetFloor: 1850,
    blueCarpetFloor: 40,
    pinkCarpetFloor: 1072,
    concreteFloor: 1360,
    marbleFloor: 151,
    tiledFloor: 462,
    tatamiFloor: 507
};
currentOption = "woodenFloor";

function SetFloor(arg0)
{
    currentOption = arg0;
}

function LoadFloors()
{
    if (is_struct(ds_map_find_value(global.PlayerSave, "holoHouseSet")))
    {
        if (variable_struct_exists(ds_map_find_value(global.PlayerSave, "holoHouseSet"), "floor"))
        {
            currentOption = ds_map_find_value(global.PlayerSave, "holoHouseSet").floor;
        }
        else
        {
            currentOption = "woodenFloor";
        }
    }
}

LoadFloors();
