function StringCapitalizeFirstLetters(arg0)
{
    arg0 = string_lower(arg0);
    var splitStr = string_split(arg0, " ");
    var returnStr = "";
    for (var i = 0; i < array_length(splitStr); i++)
    {
        var startingIndex = 1;
        var firstChar = string_char_at(splitStr[i], 1);
        var out = "";
        if (firstChar == "(")
        {
            startingIndex = 2;
            out += firstChar;
        }
        out += string_upper(string_char_at(splitStr[i], startingIndex));
        out += string_copy(splitStr[i], startingIndex + 1, string_length(splitStr[i]) - 1);
        returnStr += out;
        if (i < (array_length(splitStr) - 1))
        {
            returnStr += " ";
        }
    }
    return returnStr;
}
