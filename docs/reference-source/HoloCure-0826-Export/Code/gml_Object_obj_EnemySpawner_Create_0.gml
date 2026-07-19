enemiesList = array_create(0, 0);
currentHorde = [];
hordeDirections = ds_list_create();
hordePosition = 0;
array_push(enemiesList, obj_Shrimp);
event_user(0);
randomDirection = ds_list_create();
ds_list_add(randomDirection, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0);
alarm[0] = spawnTimer;
alarm[1] = 1;

function createHorde(arg0, arg1)
{
    if (spawn)
    {
        currentHorde = arg0;
        hordePosition = 0;
        hordeDirections = arg1;
        alarm[11] = 1;
    }
}
