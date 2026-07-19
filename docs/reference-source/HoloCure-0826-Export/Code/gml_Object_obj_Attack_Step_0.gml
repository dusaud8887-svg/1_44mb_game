if (stayOnCreator)
{
    if (instance_exists(stayOn))
    {
        x = stayOn.x;
        y = stayOn.y + starty;
    }
}
if (drawBehind)
{
    depth = -y + height + (drawUnderAll * 500) + extraDepth;
}
if (typeof(script) != "array" && script)
{
    script(id, creator);
}
else if (typeof(script) == "array")
{
    if (typeof(script) == "array")
    {
        for (var i = 0; i < (array_length(script) - 1); i++)
        {
            script[i](id, creator);
        }
    }
}
if (variable_struct_names_count(enemiesInvincMap) > 0)
{
    var keys = variable_struct_get_names(enemiesInvincMap);
    for (var i = 0; i < array_length(keys); i++)
    {
        var targetCD = variable_struct_get(enemiesInvincMap, keys[i]);
        targetCD--;
        variable_struct_set(enemiesInvincMap, keys[i], targetCD);
        if (targetCD == 0)
        {
            variable_struct_remove(enemiesInvincMap, keys[i]);
        }
    }
}
if (fadeOut)
{
    if (duration < fadeTime)
    {
        image_alpha -= (1 / fadeTime);
    }
}
if (eraseCD > 0)
{
    eraseCD--;
}
if (duration > 0)
{
    duration--;
}
if (duration == 0)
{
    instance_destroy();
}
