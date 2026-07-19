function FirebaseREST_Firestore_collection_compare(arg0, arg1)
{
    var map_1 = json_decode(arg0);
    if (!ds_exists(map_1, ds_type_map))
    {
        return false;
    }
    var map_2 = json_decode(arg1);
    if (!ds_exists(map_2, ds_type_map))
    {
        ds_map_destroy(map_1);
        map_1 = -1;
        return false;
    }
    if (!ds_map_exists(map_1, "documents") && !ds_map_exists(map_2, "documents"))
    {
        ds_map_destroy(map_1);
        ds_map_destroy(map_2);
        map_2 = -1;
        map_1 = -1;
        return true;
    }
    if (!ds_map_exists(map_1, "documents") || !ds_map_exists(map_2, "documents"))
    {
        ds_map_destroy(map_1);
        ds_map_destroy(map_2);
        map_2 = -1;
        map_1 = -1;
        return false;
    }
    var list_1 = ds_map_find_value(map_1, "documents");
    var list_2 = ds_map_find_value(map_2, "documents");
    if (ds_list_size(list_1) != ds_list_size(list_2))
    {
        ds_map_destroy(map_1);
        ds_map_destroy(map_2);
        map_2 = -1;
        map_1 = -1;
        return false;
    }
    for (var a = 0; a < ds_list_size(list_1); a++)
    {
        map_1 = ds_list_find_value(list_1, a);
        map_2 = ds_list_find_value(list_2, a);
        var json_dec_1 = FirebaseREST_Firestore_jsonDecode(json_encode(map_1));
        var json_dec_2 = FirebaseREST_Firestore_jsonDecode(json_encode(map_2));
        if (!json_compare(json_dec_1, json_dec_2))
        {
            ds_map_destroy(map_1);
            ds_map_destroy(map_2);
            map_2 = -1;
            map_1 = -1;
            return false;
        }
    }
    ds_map_destroy(map_1);
    ds_map_destroy(map_2);
    return true;
}
