if (canType && renameOption == -1)
{
    var weightedStringLength = GetWeightedStringLength(editingName);
    if (keyboard_check(vk_anykey) && weightedStringLength < 18)
    {
        var keyboardStringWeight = GetWeightedStringLength(keyboard_string);
        var newWeight = weightedStringLength + keyboardStringWeight;
        var newString = editingName + string(keyboard_string);
        var byteLength = string_byte_length(newString);
        if (newWeight <= 18)
        {
            editingName = TypeText(editingName);
        }
        keyboard_string = "";
    }
    if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && delete_timer == 2)
    {
        editingName = string_delete(editingName, string_length(editingName), 1);
        delete_timer = 0;
        keyboard_string = "";
    }
    if (keyboard_check_pressed(vk_backspace))
    {
        editingName = string_delete(editingName, string_length(editingName), 1);
        keyboard_string = "";
        delete_timer = -10;
    }
    if (delete_timer != 2)
    {
        delete_timer++;
    }
}
rectTime++;
if (rectTime >= 20)
{
    rectTime = 0;
    rectVis = -rectVis;
}
