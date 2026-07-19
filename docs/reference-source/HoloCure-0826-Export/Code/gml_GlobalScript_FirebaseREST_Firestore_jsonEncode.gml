function FirebaseREST_Firestore_jsonEncode(arg0)
{
    var map = json_decode(arg0);
    var map_keys = ds_map_create();
    var key = ds_map_find_first(map);
    while (!is_undefined(key))
    {
        ds_map_add_map(map_keys, key, FirebaseREST_firestore_value(ds_map_find_value(map, key)));
        key = ds_map_find_next(map, key);
    }
    ds_map_destroy(map);
    map = -1;
    var map_field = ds_map_create();
    ds_map_add_map(map_field, "fields", map_keys);
    var json_send = json_encode(map_field);
    ds_map_destroy(map_field);
    return json_send;
}
