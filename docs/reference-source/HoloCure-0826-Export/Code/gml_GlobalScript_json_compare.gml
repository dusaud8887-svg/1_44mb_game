function json_compare(arg0, arg1)
{
    var ok = false;
    if (!firstTime)
    {
        var map_json1 = json_decode(arg0);
        var map_json2 = json_decode(arg1);
        ok = ds_map_size(map_json1) != ds_map_size(map_json2);
        if (!ok)
        {
            var key = ds_map_find_first(map_json2);
            while (!is_undefined(key))
            {
                if (!ds_map_exists(map_json1, key))
                {
                    ok = true;
                    break;
                }
                if (ds_map_find_value(map_json1, key) != ds_map_find_value(map_json2, key))
                {
                    ok = true;
                    break;
                }
                key = ds_map_find_next(map_json2, key);
            }
        }
        ds_map_destroy(map_json2);
        ds_map_destroy(map_json1);
        map_json2 = -1;
        map_json1 = -1;
    }
    return !ok;
}
