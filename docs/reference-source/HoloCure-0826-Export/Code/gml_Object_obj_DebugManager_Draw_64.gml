if (global.debug)
{
    var keys = variable_struct_get_names(drawScripts);
    for (var i = 0; i < array_length(keys); i++)
    {
        var Script = variable_struct_get(drawScripts, keys[i]);
        Script(self);
    }
}
