function FirebaseREST_firestore_fieldReference(arg0)
{
    var map_order_field = ds_map_create();
    ds_map_add(map_order_field, "fieldPath", arg0);
    return map_order_field;
}
