if (!ds_map_exists(async_load, "type"))
{
    exit;
}
if (!string_count("FirebaseFirestore", ds_map_find_value(async_load, "type")))
{
    exit;
}
var ins = instance_create_depth(0, 0, 0, Obj_Debug_FallText_Firestore);
ins.text = string(ds_map_find_value(async_load, "listener")) + " - " + ds_map_find_value(async_load, "type") + " - " + ds_map_find_value(async_load, "path") + " - " + string(ds_map_find_value(async_load, "status"));
if (ds_map_exists(async_load, "value"))
{
    ins.text += " -> " + string(ds_map_find_value(async_load, "value"));
}
if (ds_map_exists(async_load, "errorMessage"))
{
    ins.text += " -> " + string(ds_map_find_value(async_load, "errorMessage"));
}
if (ds_map_find_value(async_load, "status") == 200)
{
    ins.color = 16777215;
}
else
{
    ins.color = 255;
}
if (ds_map_find_value(async_load, "status") == 200)
{
    switch (ds_map_find_value(async_load, "type"))
    {
        case "FirebaseFirestore_Document_Set":
            var path = ds_map_find_value(async_load, "path");
            break;
        case "FirebaseFirestore_Document_Update":
            var path = ds_map_find_value(async_load, "path");
            break;
        case "FirebaseFirestore_Document_Read":
            var path = ds_map_find_value(async_load, "path");
            value = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseFirestore_Document_Listener":
            var path = ds_map_find_value(async_load, "path");
            value = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseFirestore_Document_Delete":
            var path = ds_map_find_value(async_load, "path");
            break;
        case "FirebaseFirestore_Collection_Add":
            var path = ds_map_find_value(async_load, "path");
            break;
        case "FirebaseFirestore_Collection_Read":
            var path = ds_map_find_value(async_load, "path");
            value = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseFirestore_Collection_Listener":
            var path = ds_map_find_value(async_load, "path");
            value = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseFirestore_Collection_Query":
            var path = ds_map_find_value(async_load, "path");
            value = ds_map_find_value(async_load, "value");
            break;
    }
}
