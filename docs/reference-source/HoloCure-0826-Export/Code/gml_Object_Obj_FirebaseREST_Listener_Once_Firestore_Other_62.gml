if (ds_map_find_value(async_load, "status") != 1)
{
    if (ds_map_find_value(async_load, "id") == request)
    {
        if (ds_map_find_value(async_load, "http_status") == 200 && ds_map_find_value(async_load, "status") == 0)
        {
            FirebaseREST_HTTP_Success_Firestore();
            instance_destroy();
        }
        else
        {
            if (ds_map_find_value(async_load, "http_status") == 401 || ds_map_find_value(async_load, "http_status") == 403 || ds_map_find_value(async_load, "http_status") == 404)
            {
                FirebaseREST_HTTP_Failed_Firestore();
                instance_destroy();
                exit;
            }
            alarm[0] = errorResetAlarm;
            countError++;
            if (countError >= errorCountLimit)
            {
                FirebaseREST_HTTP_Failed_Firestore();
                instance_destroy();
            }
        }
    }
}
