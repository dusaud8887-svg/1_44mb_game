if (spawn)
{
    if (!ds_list_empty(randomDirection))
    {
        var chooseDir = floor(random(ds_list_size(randomDirection)));
        var enemy = floor(random(array_length(enemiesList)));
        switch (ds_list_find_value(randomDirection, chooseDir))
        {
            case 0:
                var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + random(100), camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0])), depth, obj_EnemySpawn);
                spawner.enemyID = enemiesList[enemy];
                break;
            case 1:
                var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) - random(100), depth, obj_EnemySpawn);
                spawner.enemyID = enemiesList[enemy];
                break;
            case 2:
                var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) - random(100), camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0])), depth, obj_EnemySpawn);
                spawner.enemyID = enemiesList[enemy];
                break;
            case 3:
                var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + random(100), depth, obj_EnemySpawn);
                spawner.enemyID = enemiesList[enemy];
                break;
        }
        ds_list_delete(randomDirection, chooseDir);
    }
}
if (ds_list_empty(randomDirection))
{
    ds_list_clear(randomDirection);
    ds_list_add(randomDirection, 0, 1, 2, 3);
    alarm[0] = 1;
}
alarm[0] = spawnTimer;
