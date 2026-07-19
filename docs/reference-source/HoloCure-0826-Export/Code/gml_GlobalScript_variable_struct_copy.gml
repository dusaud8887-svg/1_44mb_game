function variable_struct_copy(arg0, arg1)
{
    var keys = variable_struct_get_names(arg0);
    for (var i = 0; i < array_length(keys); i++)
    {
        var property = variable_struct_get(arg0, keys[i]);
        if (typeof(property) == "struct")
        {
            variable_struct_set(arg1, keys[i], {});
            var newProperty = variable_struct_get(arg1, keys[i]);
            variable_struct_copy(property, newProperty);
        }
        else if (typeof(property) == "array")
        {
            var newArray = [];
            for (var j = 0; j < array_length(property); j++)
            {
                if (typeof(property[j]) == "struct")
                {
                    var newThing = {};
                    variable_struct_copy(property[j], newThing);
                    array_push(newArray, newThing);
                }
                else
                {
                    array_push(newArray, property[j]);
                }
            }
            variable_struct_set(arg1, keys[i], newArray);
        }
        else
        {
            variable_struct_set(arg1, keys[i], variable_struct_get(arg0, keys[i]));
        }
    }
    return arg1;
}
