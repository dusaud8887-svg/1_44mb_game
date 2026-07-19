function new_ds_map_secure_save()
{
    var map = ds_map_create();
    ds_map_copy(map, argument[0]);
    var path = argument[1];
    var t = base64_encode(json_encode(map));
    var f = file_text_open_write(path);
    if (f != -1)
    {
        file_text_write_string(f, t);
        file_text_close(f);
    }
    f = file_text_open_write("backup_" + path);
    if (f != -1)
    {
        file_text_write_string(f, t);
        file_text_close(f);
        ds_map_destroy(map);
        map = -1;
    }
    else
    {
    }
}

function new_ds_map_secure_load()
{
    var path = argument[0];
    var f = file_text_open_read(path);
    var t = base64_decode(file_text_read_string(f));
    file_text_close(f);
    var mapStruct = json_parse(t);
    var map = ds_map_create();
    var keys = variable_struct_get_names(mapStruct);
    for (var i = 0; i < array_length(keys); i++)
    {
        ds_map_add(map, keys[i], variable_struct_get(mapStruct, keys[i]));
    }
    return map;
}
