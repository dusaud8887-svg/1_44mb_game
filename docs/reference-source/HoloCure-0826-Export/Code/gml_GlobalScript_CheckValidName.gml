function CheckValidName(arg0)
{
    var newName = arg0;
    if (newName == "")
    {
        newName = "Player";
    }
    var char = "";
    var valid = true;
    for (var i = 0; i < string_length(newName); i++)
    {
        char = string_char_at(newName, i + 1);
        if (!CheckValidChar(char))
        {
            valid = false;
        }
    }
    if (!valid)
    {
        newName = "Player";
    }
    return newName;
}

function CheckValidChar(arg0)
{
    var valid = false;
    if (arg0 == " " || arg0 == "!" || arg0 == "?" || arg0 == "'" || arg0 == "_" || arg0 == "." || arg0 == "~" || arg0 == "-" || arg0 == "," || arg0 == string_lettersdigits(arg0))
    {
        valid = true;
    }
    return valid;
}
