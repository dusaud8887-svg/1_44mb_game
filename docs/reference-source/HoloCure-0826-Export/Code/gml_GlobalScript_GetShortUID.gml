function GetShortUID()
{
    if (!variable_global_exists("UID"))
    {
        return undefined;
    }
    return string_copy(global.UID, 0, 6);
}
