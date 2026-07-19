function FirebaseREST_firestore_cursor(arg0, arg1)
{
    var map = ds_map_create();
    var list = ds_list_create();
    ds_list_add(list, FirebaseREST_firestore_value(arg0));
    ds_list_mark_as_map(list, 0);
    ds_map_add_list(map, "values", list);
    if (arg1)
    {
        ds_map_set(map, "before", "true");
    }
    else
    {
        ds_map_set(map, "before", "false");
    }
    return map;
}
