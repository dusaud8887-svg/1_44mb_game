var keys = variable_struct_get_names(self);
for (var i = 0; i < array_length(keys); i++)
{
    var data = variable_struct_get(self, keys[i]);
    data = undefined;
}
