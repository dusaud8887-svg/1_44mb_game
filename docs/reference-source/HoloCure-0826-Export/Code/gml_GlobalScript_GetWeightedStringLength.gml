function GetWeightedStringLength(arg0)
{
    var alphaCount = 0;
    var nonAlphaCount = 0;
    var spaceCount = 0;
    var specialCount = 0;
    for (var i = 1; i <= string_length(arg0); i++)
    {
        var charCode = string_ord_at(arg0, i);
        if ((charCode >= 48 && charCode <= 57) || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122))
        {
            alphaCount++;
        }
        else if (charCode == 32)
        {
            spaceCount++;
        }
        else if ((charCode >= 33 && charCode <= 47) || (charCode >= 58 && charCode <= 64) || (charCode >= 91 && charCode <= 96) || (charCode >= 123 && charCode <= 126))
        {
            specialCount++;
        }
        else
        {
            nonAlphaCount++;
        }
    }
    return (alphaCount * 1) + (nonAlphaCount * 2) + (spaceCount * 1) + (specialCount * 1);
}

function TruncateUsernameToMaxLength(arg0)
{
    var weightedNameLength = GetWeightedStringLength(arg0);
    var byteLength = string_byte_length(arg0);
    while (weightedNameLength > 18 && byteLength > 27 && string_length(arg0) > 0)
    {
        arg0 = string_copy(arg0, 0, string_length(arg0) - 1);
        weightedNameLength = GetWeightedStringLength(arg0);
        byteLength = string_byte_length(arg0);
    }
    return arg0;
}
