function FirebaseREST_Firestore_path_isCollection(arg0)
{
    var list = FirebaseFirestore_Path_ToList(arg0);
    var count = ds_list_size(list);
    ds_list_destroy(list);
    return count % 2;
}
