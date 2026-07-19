if (ds_map_find_value(async_load, "status") != 1)
{
    if (ds_map_find_value(async_load, "id") == request)
    {
        if (ds_map_find_value(async_load, "http_status") == 200 && ds_map_find_value(async_load, "status") == 0)
        {
            var map = json_decode(ds_map_find_value(async_load, "result"));
            token = ds_map_find_value(map, "id_token");
            ds_map_destroy(map);
            event_user(0);
        }
        else
        {
        }
    }
}
