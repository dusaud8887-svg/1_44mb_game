function SetKeyboardControls()
{
    input_binding_set("actionOne", input_binding_key(global.theButtons[0]), 0, 0, "keyboard_and_mouse");
    input_binding_set("actionTwo", input_binding_key(global.theButtons[1]), 0, 0, "keyboard_and_mouse");
    input_binding_set("left", input_binding_key(global.theButtons[2]), 0, 0, "keyboard_and_mouse");
    input_binding_set("right", input_binding_key(global.theButtons[3]), 0, 0, "keyboard_and_mouse");
    input_binding_set("up", input_binding_key(global.theButtons[4]), 0, 0, "keyboard_and_mouse");
    input_binding_set("down", input_binding_key(global.theButtons[5]), 0, 0, "keyboard_and_mouse");
}
