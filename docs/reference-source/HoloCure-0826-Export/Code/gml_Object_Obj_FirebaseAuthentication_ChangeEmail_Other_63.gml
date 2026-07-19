if (request == ds_map_find_value(async_load, "id"))
{
    if (ds_map_find_value(async_load, "status"))
    {
        if (ds_map_find_value(async_load, "result") != "")
        {
            var str = ds_map_find_value(async_load, "result");
            FirebaseAuthentication_ChangeEmail(str);
        }
    }
}
