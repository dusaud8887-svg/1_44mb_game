function RESTFirebaseFirestore_Collection_Add(arg0, arg1)
{
    if (!FirebaseREST_Firestore_path_isCollection(arg0))
    {
        show_debug_message("error: path not correspond to collection");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Collection_Add", 256, FirebaseREST_Firestore_getURL(arg0), "POST", FirebaseREST_Firestore_headerToken(), FirebaseREST_Firestore_jsonEncode(arg1));
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Collection_Read(arg0)
{
    if (!FirebaseREST_Firestore_path_isCollection(arg0))
    {
        show_debug_message("error: path not correspond to collection");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Collection_Read", 256, FirebaseREST_Firestore_getURL(arg0), "GET", FirebaseREST_Firestore_headerToken(), "");
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Collection_Listener(arg0)
{
    if (!FirebaseREST_Firestore_path_isCollection(arg0))
    {
        show_debug_message("error: path not correspond to collection");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Collection_Listener", 241, FirebaseREST_Firestore_getURL(arg0), "GET", FirebaseREST_Firestore_headerToken(), "");
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Collection_Query(arg0)
{
    var path = arg0._path;
    var start = arg0._start;
    var end_ = arg0._end;
    var limit = arg0._limit;
    if (!FirebaseREST_Firestore_path_isCollection(path))
    {
        show_debug_message("error: path not correspond to collection");
        exit;
    }
    var original_ref = path;
    var collection = FirebaseFirestore_Path_GetName(path, 0);
    var list_from = ds_list_create();
    var map_collector = ds_map_create();
    ds_map_add(map_collector, "collectionId", collection);
    ds_map_add(map_collector, "allDescendants", "false");
    ds_list_add(list_from, map_collector);
    ds_list_mark_as_map(list_from, 0);
    path = FirebaseFirestore_Path_Back(path, 1);
    var map_where = ds_map_create();
    var map_compositeFilter = ds_map_create();
    ds_map_add(map_compositeFilter, "op", "AND");
    var list_filters = ds_list_create();
    if (!is_undefined(arg0._operations))
    {
        for (var a = 0; a < array_length(arg0._operations); a++)
        {
            var map_FieldFilter = ds_map_create();
            ds_map_add_map(map_FieldFilter, "field", FirebaseREST_firestore_fieldReference(arg0._operations[a].path));
            ds_map_add(map_FieldFilter, "op", arg0._operations[a].operation);
            ds_map_add_map(map_FieldFilter, "value", FirebaseREST_firestore_value(arg0._operations[a].value));
            var map_toList = ds_map_create();
            ds_map_add_map(map_toList, "fieldFilter", map_FieldFilter);
            ds_list_add(list_filters, map_toList);
        }
    }
    for (var a = 0; a < ds_list_size(list_filters); a++)
    {
        ds_list_mark_as_map(list_filters, a);
    }
    ds_map_add_list(map_compositeFilter, "filters", list_filters);
    ds_map_add_map(map_where, "compositeFilter", map_compositeFilter);
    var list_orderBy = ds_list_create();
    if (!is_undefined(arg0._orderBy_conditions))
    {
        for (var i = 0; i < array_length(arg0._orderBy_conditions); i++)
        {
            var map_orderList = ds_map_create();
            ds_map_add_map(map_orderList, "field", FirebaseREST_firestore_fieldReference(arg0._orderBy_conditions[i].field));
            ds_map_add(map_orderList, "direction", arg0._orderBy_conditions[i].direction);
            ds_list_add(list_orderBy, map_orderList);
            ds_list_mark_as_map(list_orderBy, i);
        }
    }
    var map_startAt;
    if (is_undefined(start))
    {
        map_startAt = ds_map_create();
    }
    else
    {
        map_startAt = FirebaseREST_firestore_cursor(start, 1);
    }
    var map_endAt;
    if (is_undefined(end_))
    {
        map_endAt = ds_map_create();
    }
    else
    {
        map_endAt = FirebaseREST_firestore_cursor(end_, 0);
    }
    var map_structuredQuery = ds_map_create();
    ds_map_add_list(map_structuredQuery, "from", list_from);
    if (ds_map_size(map_where))
    {
        ds_map_add_map(map_structuredQuery, "where", map_where);
    }
    else
    {
        ds_map_destroy(map_where);
    }
    if (ds_list_size(list_orderBy))
    {
        ds_map_add_list(map_structuredQuery, "orderBy", list_orderBy);
    }
    else
    {
        ds_list_destroy(list_orderBy);
    }
    if (ds_map_size(map_startAt))
    {
        ds_map_add_map(map_structuredQuery, "startAt", map_startAt);
    }
    else
    {
        ds_map_destroy(map_startAt);
    }
    if (ds_map_size(map_endAt))
    {
        ds_map_add_map(map_structuredQuery, "endAt", map_endAt);
    }
    else
    {
        ds_map_destroy(map_endAt);
    }
    if (!is_undefined(limit))
    {
        ds_map_add(map_structuredQuery, "limit", limit);
    }
    var map_requestBody = ds_map_create();
    ds_map_add_map(map_requestBody, "structuredQuery", map_structuredQuery);
    var json = json_encode(map_requestBody);
    ds_map_destroy(map_requestBody);
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Collection_Query", 256, FirebaseREST_Firestore_getURL(path), "POST", FirebaseREST_Firestore_headerToken(), json);
    listener.url += ":runQuery";
    listener.path = original_ref;
    return listener;
}

function RESTFirebaseFirestore_Document_Delete(arg0)
{
    if (!FirebaseREST_Firestore_path_isDocument(arg0))
    {
        show_debug_message("error: path not correspond to document");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Document_Delete", 256, FirebaseREST_Firestore_getURL(arg0), "DELETE", FirebaseREST_Firestore_headerToken(), "");
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Document_Read(arg0)
{
    if (!FirebaseREST_Firestore_path_isDocument(arg0))
    {
        show_debug_message("error: path not correspond to document");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Document_Read", 256, FirebaseREST_Firestore_getURL(arg0), "GET", FirebaseREST_Firestore_headerToken(), "");
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Document_Listener(arg0)
{
    if (!FirebaseREST_Firestore_path_isDocument(arg0))
    {
        show_debug_message("error: path not correspond to document");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("FirebaseFirestore_Document_Listener", 200, FirebaseREST_Firestore_getURL(arg0), "GET", FirebaseREST_Firestore_headerToken(), "");
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Document_Set(arg0, arg1)
{
    if (!FirebaseREST_Firestore_path_isDocument(arg0))
    {
        show_debug_message("error: path not correspond to document");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("RESTFirebaseFirestore_Document_Set", 256, FirebaseREST_Firestore_getURL(arg0), "PATCH", FirebaseREST_Firestore_headerToken(), FirebaseREST_Firestore_jsonEncode(arg1));
    listener.path = arg0;
    return listener;
}

function RESTFirebaseFirestore_Document_Update(arg0, arg1)
{
    if (!FirebaseREST_Firestore_path_isDocument(arg0))
    {
        show_debug_message("error: path not correspond to document");
        exit;
    }
    var listener = FirebaseREST_asyncFunction_Firestore("RESTFirebaseFirestore_Document_Update", 256, FirebaseREST_Firestore_getURL(arg0), "PATCH", FirebaseREST_Firestore_headerToken(), FirebaseREST_Firestore_jsonEncode(arg1));
    listener.url += FriebaseREST_Firestore_urlUpdateMask(arg1);
    show_debug_message(listener.url);
    listener.path = arg0;
    return listener;
}
