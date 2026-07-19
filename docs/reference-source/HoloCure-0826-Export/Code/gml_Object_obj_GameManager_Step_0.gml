if (getTextManager < 0)
{
    getTextManager = instance_find(obj_TextController, 0);
}
if (global.readyToStart)
{
    room_goto_next();
}
if (initStep == 1 && canType)
{
    var weightedStringLength = GetWeightedStringLength(inputText);
    if (keyboard_check(vk_anykey) && weightedStringLength < 18)
    {
        var keyboardStringWeight = GetWeightedStringLength(keyboard_string);
        var newWeight = weightedStringLength + keyboardStringWeight;
        var newString = inputText + string_lettersdigits(keyboard_string);
        var byteLength = string_byte_length(newString);
        if (newWeight <= 18 && byteLength <= 27)
        {
            inputText = TypeText(inputText);
        }
        keyboard_string = "";
    }
    if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && delete_timer == 2)
    {
        inputText = string_delete(inputText, string_length(inputText), 1);
        delete_timer = 0;
        keyboard_string = "";
    }
    if (keyboard_check_pressed(vk_backspace))
    {
        inputText = string_delete(inputText, string_length(inputText), 1);
        keyboard_string = "";
        delete_timer = -10;
    }
    if (delete_timer != 2)
    {
        delete_timer++;
    }
}
