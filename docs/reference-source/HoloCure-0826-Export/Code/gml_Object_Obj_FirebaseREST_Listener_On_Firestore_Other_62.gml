if (ds_map_find_value(async_load, "status") != 1)
{
    if (ds_map_find_value(async_load, "id") == request)
    {
        alarm[0] = refreshCall;
        if (ds_map_find_value(async_load, "http_status") == 200 && ds_map_find_value(async_load, "status") == 0)
        {
            countError = 0;
            if (firstTime || ds_map_find_value(async_load, "result") != cache)
            {
                firstTime = false;
                cache = ds_map_find_value(async_load, "result");
                FirebaseREST_HTTP_Success_Firestore();
            }
        }
        else
        {
            if (ds_map_find_value(async_load, "http_status") == 401 || ds_map_find_value(async_load, "http_status") == 403 || ds_map_find_value(async_load, "http_status") == 404)
            {
                FirebaseREST_HTTP_Failed_Firestore();
                instance_destroy();
                exit;
            }
            if (firstTime || ds_map_find_value(async_load, "result") != cache)
            {
                alarm[0] = errorResetAlarm;
                countError++;
                if (countError >= errorCountLimit)
                {
                    cache = ds_map_find_value(async_load, "result");
                    firstTime = false;
                    countError = 0;
                    FirebaseREST_HTTP_Failed_Firestore();
                }
            }
        }
    }
}
