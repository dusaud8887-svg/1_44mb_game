if (ds_map_find_value(async_load, "status"))
{
    if (ds_map_find_value(async_load, "result") != "")
    {
        if (ds_map_find_value(async_load, "id") == request_email)
        {
            email = ds_map_find_value(async_load, "result");
            request_password = get_string_async("Password:", "MyPassword123");
        }
        if (ds_map_find_value(async_load, "id") == request_password)
        {
            var password = ds_map_find_value(async_load, "result");
            FirebaseAuthentication_SignIn_Email(email, password);
        }
    }
}
