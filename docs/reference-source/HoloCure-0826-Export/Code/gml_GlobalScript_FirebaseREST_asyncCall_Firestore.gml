function FirebaseREST_asyncCall_Firestore()
{
    var map = ds_map_create();
    ds_map_set(map, "listener", id);
    ds_map_set(map, "type", event);
    ds_map_set(map, "path", path);
    ds_map_set(map, "status", ds_map_find_value(async_load, "http_status"));
    ds_map_set(map, "result", ds_map_find_value(async_load, "result"));
    if (!is_undefined(errorMessage))
    {
        ds_map_set(map, "errorMessage", errorMessage);
    }
    if (argument_count)
    {
        ds_map_set(map, "value", argument[0]);
    }
    event_perform_async(ev_async_social, map);
}
