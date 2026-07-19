if (request == ds_map_find_value(async_load, "id"))
{
    if (ds_map_find_value(async_load, "status"))
    {
        if (ds_map_find_value(async_load, "result") != "")
        {
            value = ds_map_find_value(async_load, "result");
            if (string_digits(value) == string(value))
            {
                show_debug_message("is real (number)");
                value = real(value);
            }
        }
    }
}
