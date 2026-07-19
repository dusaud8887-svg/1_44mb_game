function FirebaseREST_Firestore_collection_query_decode(arg0, arg1)
{
    var result_map = ds_map_create();
    var map = json_decode(arg1);
    var list = ds_map_find_value(map, "default");
    for (var a = 0; a < ds_list_size(list); a++)
    {
        var map_doc = ds_list_find_value(list, a);
        if (!ds_map_exists(map_doc, "document"))
        {
            continue;
        }
        var map_ = ds_map_find_value(map_doc, "document");
        var json_ = FirebaseREST_Firestore_jsonDecode(json_encode(map_));
        ds_map_add_map(result_map, FirebaseFirestore_Path_GetName(ds_map_find_value(map_, "name"), 0), json_decode(json_));
    }
    ds_map_destroy(map);
    var json_result = json_encode(result_map);
    ds_map_destroy(result_map);
    return json_result;
}
