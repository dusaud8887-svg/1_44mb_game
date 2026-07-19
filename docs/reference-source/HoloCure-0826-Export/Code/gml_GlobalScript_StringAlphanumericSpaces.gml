function StringAlphanumericSpaces(arg0)
{
    var newString = "";
    for (var i = 1; i <= string_length(arg0); i++)
    {
        var charCode = string_ord_at(arg0, i);
        if ((charCode >= 48 && charCode <= 57) || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))
        {
            newString += string_copy(arg0, i, 1);
        }
        else if (charCode == 32)
        {
            newString += string_copy(arg0, i, 1);
        }
    }
    return newString;
}
