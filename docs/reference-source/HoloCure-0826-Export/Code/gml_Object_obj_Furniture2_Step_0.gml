event_inherited();
if (highlighted)
{
    glowTime++;
    add = 0.2 + (0.2 * sin(glowTime / 10));
}
else
{
    glowTime = 0;
    add = 0;
}
if (spriteHeight > 32)
{
    tallObject = true;
}
if (variable_struct_names_count(scripts) > 0)
{
    var keys = variable_struct_get_names(scripts);
    for (var i = 0; i < array_length(keys); i++)
    {
        var scriptObject = variable_struct_get(scripts, keys[i]);
        if (scriptObject != undefined)
        {
            var Script = scriptObject.Script;
            var config = scriptObject.config;
            Script(227, self, config);
        }
    }
}
