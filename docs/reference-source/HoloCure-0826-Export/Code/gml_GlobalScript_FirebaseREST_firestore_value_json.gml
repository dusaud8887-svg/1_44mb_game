function FirebaseREST_firestore_value_json(arg0)
{
    var map = ds_map_create();
    ds_map_add(map, "value", arg0);
    var json = json_encode(map);
    ds_map_destroy(map);
    return json;
}
