if (ds_map_find_value(async_load, "status") != 1)
{
    if (ds_map_find_value(async_load, "id") == request)
    {
        alarm[0] = refreshCall;
        if (ds_map_find_value(async_load, "http_status") == 200 && ds_map_find_value(async_load, "status") == 0)
        {
            var json_result = FirebaseREST_Firestore_jsonDecode(ds_map_find_value(async_load, "result"));
            if (firstTime || !json_compare(cache, json_result))
            {
                firstTime = false;
                cache = json_result;
                cache_status_code = ds_map_find_value(async_load, "http_status");
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
            var json_result = FirebaseREST_Firestore_jsonDecode(ds_map_find_value(async_load, "result"));
            if (firstTime || !json_compare(cache, json_result) || cache_status_code != ds_map_find_value(async_load, "http_status"))
            {
                alarm[0] = errorResetAlarm;
                countError++;
                if (countError >= errorCountLimit)
                {
                    cache = json_result;
                    cache_status_code = ds_map_find_value(async_load, "http_status");
                    firstTime = false;
                    countError = 0;
                    FirebaseREST_HTTP_Failed_Firestore();
                }
            }
        }
    }
}
