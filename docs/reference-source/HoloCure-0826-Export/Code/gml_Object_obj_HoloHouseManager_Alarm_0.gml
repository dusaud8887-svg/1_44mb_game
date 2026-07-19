if (room == rm_HoloHouse_Entrance)
{
    if (instance_exists(obj_HerdingBoard))
    {
        obj_HerdingBoard.storedTime = global.TrackedTime;
        obj_HerdingBoard.LoadWorkers();
    }
    if (instance_exists(obj_PlantManager))
    {
        obj_PlantManager.storedTime = global.TrackedTime;
        obj_PlantManager.LoadPlants();
    }
    global.TrackedTime = 0;
}
