if (hordePosition < array_length(currentHorde))
{
    var chooseDir = floor(random(ds_list_size(hordeDirections)));
    switch (ds_list_find_value(hordeDirections, chooseDir))
    {
        case 0:
            var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + random(100), camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0])), depth, obj_EnemySpawn);
            spawner.enemyID = currentHorde[hordePosition];
            break;
        case 1:
            var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) - random(100), depth, obj_EnemySpawn);
            spawner.enemyID = currentHorde[hordePosition];
            break;
        case 2:
            var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) - random(100), camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0])), depth, obj_EnemySpawn);
            spawner.enemyID = currentHorde[hordePosition];
            break;
        case 3:
            var spawner = instance_create_depth(camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + random(100), depth, obj_EnemySpawn);
            spawner.enemyID = currentHorde[hordePosition];
            break;
    }
    hordePosition++;
    alarm[11] = 1;
}
else
{
    ds_list_destroy(hordeDirections);
    currentHorde = [];
}
