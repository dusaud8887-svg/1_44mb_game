function FirebaseREST_Firestore_collection_decode(arg0, arg1)
{
    var map_return = ds_map_create();
    var map = json_decode(arg1);
    if (ds_map_exists(map, "documents"))
    {
        var list = ds_map_find_value(map, "documents");
        for (var a = 0; a < ds_list_size(list); a++)
        {
            var map_ = ds_list_find_value(list, a);
            var path = ds_map_find_value(map_, "name");
            var key = FirebaseFirestore_Path_GetName(path, 0);
            var value = FirebaseREST_Firestore_jsonDecode(json_encode(map_));
            ds_map_add(map_return, key, value);
        }
    }
    ds_map_destroy(map);
    var json = json_encode(map_return);
    ds_map_destroy(map_return);
    return json;
}
