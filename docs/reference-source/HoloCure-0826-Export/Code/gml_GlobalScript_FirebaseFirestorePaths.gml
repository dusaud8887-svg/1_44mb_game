function FirebaseFirestore_Path_Join()
{
    var path = argument[0];
    for (var a = 1; a < argument_count; a++)
    {
        path = FirebaseFirestore_Path_Join_Pair(path, argument[a]);
    }
    return path;
}

function FirebaseFirestore_Path_Join_Pair(arg0, arg1)
{
    if (!string_count("http", arg0))
    {
        arg0 = "/" + arg0;
    }
    arg0 += "/";
    arg1 = "/" + arg1;
    arg1 += "/";
    var path = arg0 + arg1;
    while (string_count("//", path))
    {
        path = string_replace(path, "//", "/");
    }
    path = string_replace(path, ":/", "://");
    return path;
}

function FirebaseFirestore_Path_GetName(arg0, arg1)
{
    var list = FirebaseFirestore_Path_ToList(arg0);
    var name = ds_list_find_value(list, ds_list_size(list) - 1 - arg1);
    ds_list_destroy(list);
    return name;
}

function FirebaseFirestore_Path_ToList(arg0)
{
    var list = ds_list_create();
    var str = "";
    for (var a = 1; a <= string_length(arg0); a++)
    {
        var char = string_char_at(arg0, a);
        if (char == "/")
        {
            if (str != "")
            {
                ds_list_add(list, str);
            }
            str = "";
        }
        else
        {
            str += char;
        }
    }
    if (str != "")
    {
        ds_list_add(list, str);
    }
    return list;
}

function FirebaseFirestore_Path_Compare(arg0, arg1)
{
    var list0 = FirebaseFirestore_Path_ToList(arg0);
    var list1 = FirebaseFirestore_Path_ToList(arg1);
    var ok = ds_list_size(list0) == ds_list_size(list1);
    if (ok)
    {
        for (var a = 0; a < ds_list_size(list0); a++)
        {
            if (ds_list_find_value(list0, a) != ds_list_find_value(list1, a))
            {
                ok = false;
                break;
            }
        }
    }
    ds_list_destroy(list0);
    ds_list_destroy(list1);
    return ok;
}

function FirebaseFirestore_Path_Back(arg0, arg1)
{
    var str = "";
    var list = FirebaseFirestore_Path_ToList(arg0);
    for (var a = 0; a < (ds_list_size(list) - arg1); a++)
    {
        str += (ds_list_find_value(list, a) + "/");
    }
    ds_list_destroy(list);
    return str;
}
