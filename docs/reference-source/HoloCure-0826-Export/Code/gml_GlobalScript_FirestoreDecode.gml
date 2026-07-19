function FirestoreDecodeVariableStruct(arg0)
{
    if (variable_struct_exists(arg0, "integerValue"))
    {
        return int64(arg0.integerValue);
    }
    else if (variable_struct_exists(arg0, "stringValue"))
    {
        return arg0.stringValue;
    }
    else if (variable_struct_exists(arg0, "mapValue"))
    {
        return FirestoreDecodeMap(arg0);
    }
    else if (variable_struct_exists(arg0, "arrayValue"))
    {
        return FirestoreDecodeArray(arg0);
    }
    else if (variable_struct_exists(arg0, "bytesValue"))
    {
        return FirestoreDecodeBytes(arg0);
    }
    else
    {
        show_debug_message("ERROR - decode returning default value!!! this could very likely be a type unnacounted for and cause unexpected issues");
        return arg0;
    }
}

function FirestoreDecodeMap(arg0)
{
    if (!variable_struct_exists(arg0.mapValue, "fields"))
    {
        return undefined;
    }
    var map = ds_map_create();
    var fields = arg0.mapValue.fields;
    var fieldNames = variable_struct_get_names(fields);
    for (var i = 0; i < array_length(fieldNames); i++)
    {
        var struct = variable_struct_get(fields, fieldNames[i]);
        ds_map_add(map, fieldNames[i], FirestoreDecodeVariableStruct(struct));
    }
    return map;
}

function FirestoreDecodeArray(arg0)
{
    if (!variable_struct_exists(arg0.arrayValue, "values"))
    {
        return [];
    }
    var arrayValues = arg0.arrayValue.values;
    var arrayLength = array_length(arrayValues);
    var array = array_create(arrayLength);
    for (var i = 0; i < arrayLength; i++)
    {
        array[i] = FirestoreDecodeVariableStruct(arrayValues[i]);
    }
    return array;
}

function FirestoreDecodeBytes(arg0)
{
    var buffer = buffer_base64_decode(arg0.bytesValue);
    var bytes = array_create(buffer_get_size(buffer), 0);
    for (var i = 0; i < buffer_get_size(buffer); i++)
    {
        bytes[i] = buffer_read(buffer, buffer_u8);
    }
    buffer_delete(buffer);
    return bytes;
}
