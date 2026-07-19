if (request_email == ds_map_find_value(async_load, "id"))
{
    if (ds_map_find_value(async_load, "status") && ds_map_find_value(async_load, "result") != "")
    {
        var str = ds_map_find_value(async_load, "result");
        FirebaseAuthentication_SendPasswordResetEmail(str);
    }
    else
    {
        text = "Forgot Pass?";
    }
}
