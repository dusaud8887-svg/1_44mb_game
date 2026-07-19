function FirebaseREST_firestore_value(arg0)
{
    var map = ds_map_create();
    if (is_real(arg0))
    {
        ds_map_add(map, "doubleValue", arg0);
    }
    else
    {
        ds_map_add(map, "stringValue", arg0);
    }
    return map;
}
