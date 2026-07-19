if (remapping)
{
    if (keyboard_check_pressed(vk_anykey))
    {
        var inputText = -1;
        if (keyboard_check_pressed(vk_left))
        {
            inputText = 37;
        }
        else if (keyboard_check_pressed(vk_right))
        {
            inputText = 39;
        }
        else if (keyboard_check_pressed(vk_up))
        {
            inputText = 38;
        }
        else if (keyboard_check_pressed(vk_down))
        {
            inputText = 40;
        }
        else if (keyboard_check_pressed(vk_control))
        {
            inputText = 17;
        }
        else if (keyboard_check_pressed(vk_shift))
        {
            inputText = 16;
        }
        else if (keyboard_check_pressed(vk_alt))
        {
            inputText = 18;
        }
        else if (keyboard_check_pressed(vk_space))
        {
            inputText = 32;
        }
        else
        {
            inputText = ord(string_upper(string_char_at(string(keyboard_string), 0)));
        }
        var validKey = true;
        if (inputText > 0)
        {
            validKey = ValidKeysOnly(inputText);
            if (key_to_string(inputText) == "[" || key_to_string(inputText) == "]" || key_to_string(inputText) == "/" || key_to_string(inputText) == "\\" || key_to_string(inputText) == ";" || key_to_string(inputText) == "WIN KEY" || key_to_string(inputText) == "+" || key_to_string(inputText) == "=" || key_to_string(inputText) == "*")
            {
                validKey = false;
            }
            for (var i = 0; i < 6; i++)
            {
                if (i != currentOption && key_to_string(inputText) == key_to_string(global.theButtons[i]))
                {
                    validKey = false;
                }
            }
            if (validKey)
            {
                global.theButtons[currentOption] = inputText;
                remapping = false;
                canControl = false;
                alarm[0] = 10;
                if (setAll > 0)
                {
                    setAll--;
                    currentOption++;
                    if (setAll != 0)
                    {
                        remapping = true;
                    }
                }
                if (setAll == 0)
                {
                    SaveSettings();
                }
                SetKeyboardControls();
            }
            keyboard_string = "";
        }
    }
}
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
if (deleteConfirm && deleteOption == 0 && holdDeleteTimer == 0)
{
    ResetPlayerSave();
}
