event_inherited();
if (ds_map_find_value(async_load, "type") == "GoogleSignIn_Show")
{
    if (ds_map_find_value(async_load, "success"))
    {
        token = ds_map_find_value(async_load, "idToken");
        event_user(0);
    }
}
