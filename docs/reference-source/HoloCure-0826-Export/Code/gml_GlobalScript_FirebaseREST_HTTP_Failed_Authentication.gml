function FirebaseREST_HTTP_Failed_Authentication()
{
    event = string_replace(event, "_YYFirebaseCallback", "");
    var map_error = json_decode(ds_map_find_value(async_load, "result"));
    if (ds_exists(map_error, ds_type_map))
    {
        var map = map_error;
        if (ds_map_exists(map, "default"))
        {
            if (ds_map_find_value(map, "default") == "")
            {
                errorMessage = "";
            }
            else
            {
                var list = ds_map_find_value(map, "default");
                if (ds_exists(list, ds_type_list))
                {
                    if (ds_list_size(list))
                    {
                        map = ds_list_find_value(list, 0);
                    }
                }
                if (ds_map_exists(map, "error"))
                {
                    if (ds_map_exists(ds_map_find_value(map, "error"), "message"))
                    {
                        errorMessage = ds_map_find_value(ds_map_find_value(map, "error"), "message");
                    }
                }
            }
        }
        else if (ds_map_exists(map, "error"))
        {
            if (is_string(ds_map_find_value(map, "error")))
            {
                errorMessage = ds_map_find_value(map, "error");
            }
            else if (ds_exists(ds_map_find_value(map, "error"), ds_type_map))
            {
                if (ds_map_exists(ds_map_find_value(map, "error"), "message"))
                {
                    errorMessage = ds_map_find_value(ds_map_find_value(map, "error"), "message");
                }
            }
        }
        ds_map_destroy(map_error);
    }
    if (!is_undefined(errorMessage))
    {
        if (errorMessage == "USER_NOT_FOUND")
        {
            FirebaseAuthentication_SignOut();
        }
    }
    RESTFirebase_asyncCall_Authentication();
}
