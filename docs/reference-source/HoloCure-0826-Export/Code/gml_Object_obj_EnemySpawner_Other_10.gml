timeEvents[0] = 
{
    time: [0, 0, 30],
    
    script: function addEnemy(arg0)
    {
        array_push(arg0.enemiesList, obj_Deadbeat);
        arg0.spawnTimer = 60;
    }
};
timeEvents[1] = 
{
    time: [0, 0, 6],
    
    script: function changeSpawnTimer(arg0)
    {
        arg0.spawnTimer = 90;
    }
};

horde0 = function(arg0)
{
    hordes = array_create();
    for (var i = 0; i < 30; i++)
    {
        array_push(hordes, obj_Deadbeat);
    }
    ds_list_destroy(arg0.hordeDirections);
    arg0.hordeDirections = ds_list_create();
    ds_list_add(hordeDirections, 0, 2);
    arg0.createHorde(hordes, hordeDirections);
};

timeEvents[2] = 
{
    time: [0, 1, 1],
    script: horde0
};
timeEvents[3] = 
{
    time: [0, 1, 30],
    
    script: function addEnemy(arg0)
    {
        array_push(arg0.enemiesList, 88);
        arg0.spawnTimer = 40;
    }
};

hordeTako = function(arg0)
{
    hordes = array_create();
    for (var i = 0; i < 90; i++)
    {
        array_push(hordes, obj_Deadbeat);
    }
    ds_list_destroy(arg0.hordeDirections);
    arg0.hordeDirections = ds_list_create();
    ds_list_add(hordeDirections, 0, 1, 2, 3);
    arg0.createHorde(hordes, hordeDirections);
};

timeEvents[4] = 
{
    time: [0, 2, 0],
    script: hordeTako
};

horde1 = function(arg0)
{
    hordes = array_create();
    for (var i = 0; i < 50; i++)
    {
        array_push(hordes, 88);
    }
    ds_list_destroy(arg0.hordeDirections);
    arg0.hordeDirections = ds_list_create();
    ds_list_add(hordeDirections, 0);
    arg0.createHorde(hordes, hordeDirections);
};

timeEvents[5] = 
{
    time: [0, 2, 15],
    script: horde1
};
timeEvents[6] = 
{
    time: [0, 2, 1],
    
    script: function addEnemy(arg0)
    {
        array_push(arg0.enemiesList, obj_Shrimp_lvl2);
        arg0.spawnTimer = 30;
        for (var i = 0; i < array_length(arg0.enemiesList); i++)
        {
            if (arg0.enemiesList[i] == obj_Shrimp)
            {
                array_delete(arg0.enemiesList, i, 1);
            }
        }
    }
};

horde2 = function(arg0)
{
    hordes = array_create();
    for (var i = 0; i < 75; i++)
    {
        array_push(hordes, obj_KFP_straight);
    }
    ds_list_destroy(arg0.hordeDirections);
    arg0.hordeDirections = ds_list_create();
    ds_list_add(arg0.hordeDirections, 2);
    arg0.createHorde(hordes, arg0.hordeDirections);
};

timeEvents[7] = 
{
    time: [0, 3, 0],
    script: horde2
};

horde3 = function(arg0)
{
    hordes = array_create();
    for (var i = 0; i < 150; i++)
    {
        array_push(hordes, obj_Deadbeat_lvl2);
    }
    ds_list_destroy(arg0.hordeDirections);
    arg0.hordeDirections = ds_list_create();
    ds_list_add(arg0.hordeDirections, 0, 1, 2, 3);
    arg0.createHorde(hordes, arg0.hordeDirections);
};

timeEvents[8] = 
{
    time: [0, 3, 50],
    script: horde3
};
timeEvents[9] = 
{
    time: [0, 3, 55],
    script: horde3
};
timeEvents[10] = 
{
    time: [0, 4, 0],
    script: horde3
};
timeEvents[11] = 
{
    time: [0, 3, 55],
    
    script: function addEnemy(arg0)
    {
        array_push(arg0.enemiesList, obj_BubbaE);
        arg0.spawnTimer = 20;
    }
};

horde4 = function(arg0)
{
    hordes = array_create();
    for (var i = 0; i < 200; i++)
    {
        array_push(hordes, obj_Shrimp_lvl2Slow);
    }
    ds_list_destroy(arg0.hordeDirections);
    arg0.hordeDirections = ds_list_create();
    ds_list_add(arg0.hordeDirections, 0, 1, 2, 3);
    arg0.createHorde(hordes, arg0.hordeDirections);
};

timeEvents[12] = 
{
    time: [0, 3, 10],
    script: horde4
};
timeEvents[13] = 
{
    time: [0, 4, 0],
    
    script: function addEnemy(arg0)
    {
        array_push(arg0.enemiesList, obj_Deadbeat_lvl2);
        arg0.spawnTimer = 20;
        for (var i = 0; i < array_length(arg0.enemiesList); i++)
        {
            if (arg0.enemiesList[i] == obj_Deadbeat)
            {
                array_delete(arg0.enemiesList, i, 1);
            }
        }
    }
};
