function SetControllerControls()
{
    input_binding_set("actionOne", input_binding_gamepad_button(global.controllerButtons[0]), 0, 0, "gamepad");
    input_binding_set("actionTwo", input_binding_gamepad_button(global.controllerButtons[2]), 0, 0, "gamepad");
    input_binding_set("actionOne", input_binding_gamepad_button(global.controllerButtons[1]), 0, 1, "gamepad");
    input_binding_set("actionTwo", input_binding_gamepad_button(global.controllerButtons[3]), 0, 1, "gamepad");
    input_binding_set("enter", input_binding_gamepad_button(global.controllerButtons[4]), 0, 0, "gamepad");
    input_binding_set("esc", input_binding_gamepad_button(global.controllerButtons[5]), 0, 0, "gamepad");
}
