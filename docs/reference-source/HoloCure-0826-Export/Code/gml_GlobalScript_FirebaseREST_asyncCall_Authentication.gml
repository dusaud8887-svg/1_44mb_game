function RESTFirebase_asyncCall_Authentication()
{
    var map = ds_map_create();
    ds_map_set(map, "listener", identifiquer);
    ds_map_set(map, "type", event);
    ds_map_set(map, "status", ds_map_find_value(async_load, "http_status"));
    if (!is_undefined(errorMessage))
    {
        ds_map_set(map, "errorMessage", errorMessage);
    }
    if (argument_count)
    {
        ds_map_set(map, "value", argument[0]);
    }
    event_perform_async(ev_async_social, map);
    exit;
}
