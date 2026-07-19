function TypeText(arg0)
{
    if (keyboard_string == " ")
    {
        arg0 += " ";
    }
    if (keyboard_string == "_")
    {
        arg0 += "_";
    }
    if (keyboard_string == ".")
    {
        arg0 += ".";
    }
    if (keyboard_string == "!")
    {
        arg0 += "!";
    }
    if (keyboard_string == "?")
    {
        arg0 += "?";
    }
    if (keyboard_string == ",")
    {
        arg0 += ",";
    }
    if (keyboard_string == "~")
    {
        arg0 += "~";
    }
    if (keyboard_string == "-")
    {
        arg0 += "-";
    }
    if (keyboard_string == "'")
    {
        arg0 += "'";
    }
    arg0 += string_lettersdigits(keyboard_string);
    return arg0;
}
