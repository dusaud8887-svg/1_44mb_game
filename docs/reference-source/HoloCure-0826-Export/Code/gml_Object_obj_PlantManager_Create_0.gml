plantList = [-1, -1, -1, -1, -1, -1, -1, -1];
totalPlants = 8;
initPlants = false;
storedTime = 0;
global.soilSelect = 0;
global.plantSelect = 0;
global.plantStartingPosition = 0;

function SavePlants()
{
    var plantData = [];
    for (var i = 0; i < array_length(plantList); i++)
    {
        var eachPlant;
        if (plantList[i].seedID != -1)
        {
            eachPlant = [plantList[i].seedID.id, plantList[i].soilID.id, plantList[i].cropID, plantList[i].growTime, plantList[i].lifetime, plantList[i].growthState, plantList[i].grown, plantList[i].waterCD];
        }
        else
        {
            eachPlant = [-1, -1, -1, 0, 0, 0, 0, 0];
        }
        array_push(plantData, eachPlant);
    }
    ds_map_set(global.PlayerSave, "farmPlants", plantData);
    SavePlayerSave();
}

function LoadPlants()
{
    if (array_length(ds_map_find_value(global.PlayerSave, "farmPlants")) == 8)
    {
        for (var i = 0; i < array_length(plantList); i++)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 0) != -1)
            {
                plantList[i].seedID = ds_map_find_value(global.InventoryLibrary, array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 0));
                plantList[i].soilID = ds_map_find_value(global.InventoryLibrary, array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 1));
                plantList[i].cropID = array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 2);
                plantList[i].growTime = array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 3);
                plantList[i].lifetime = array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 4) + storedTime;
                plantList[i].growthState = array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 5);
                plantList[i].waterCD = array_get(array_get(ds_map_find_value(global.PlayerSave, "farmPlants"), i), 7);
            }
        }
    }
    storedTime = 0;
}
