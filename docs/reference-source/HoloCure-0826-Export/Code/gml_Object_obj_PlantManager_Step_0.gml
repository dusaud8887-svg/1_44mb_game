if (array_length(plantList) == totalPlants && !initPlants)
{
    initPlants = true;
    for (var i = 0; i < array_length(plantList); i++)
    {
        var thePlant = instance_create_depth(plantList[i].x, plantList[i].y, depth, obj_FarmingSpot);
        thePlant.farmID = i;
        array_set(plantList, i, thePlant);
    }
    LoadPlants();
}
