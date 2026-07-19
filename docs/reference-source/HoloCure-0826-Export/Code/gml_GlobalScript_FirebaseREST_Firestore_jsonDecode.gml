function FirebaseREST_Firestore_jsonDecode(arg0)
{
    if (is_undefined(arg0) || arg0 == "")
    {
        return json_stringify(
        {
            yyundefined1: "yyundefined1"
        });
    }
    var map = ds_map_create();
    var map_data = json_decode(arg0);
    if (!ds_exists(map_data, ds_type_map))
    {
        ds_map_destroy(map);
        map = -1;
        return json_stringify(
        {
            yyundefined2: "yyundefined2"
        });
    }
    if (ds_map_exists(map_data, "error"))
    {
        var map_error = ds_map_find_value(map_data, "error");
        if (ds_map_find_value(map_error, "code") == 404)
        {
            ds_map_destroy(map_data);
            ds_map_destroy(map);
            map = -1;
            map_data = -1;
            return json_stringify(
            {
                yyundefined3: "yyundefined3"
            });
        }
    }
    if (!ds_map_exists(map_data, "fields"))
    {
        ds_map_destroy(map);
        ds_map_destroy(map_data);
        map = -1;
        map_data = -1;
        return json_stringify(
        {
            yyundefined4: "yyundefined4"
        });
    }
    var map_fields = ds_map_find_value(map_data, "fields");
    var key = ds_map_find_first(map_fields);
    while (!is_undefined(key))
    {
        var map_value = ds_map_find_value(map_fields, key);
        var value = ds_map_find_value(map_value, ds_map_find_first(map_value));
        ds_map_add(map, key, value);
        key = ds_map_find_next(map_fields, key);
    }
    ds_map_destroy(map_data);
    map_data = -1;
    var json = json_encode(map);
    ds_map_destroy(map);
    return json;
}
