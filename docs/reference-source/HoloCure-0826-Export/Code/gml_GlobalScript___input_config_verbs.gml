return 
{
    keyboard_and_mouse: 
    {
        up: input_binding_key(87),
        down: input_binding_key(83),
        left: input_binding_key(65),
        right: input_binding_key(68),
        actionOne: input_binding_key(32),
        actionTow: input_binding_key(16),
        enter: input_binding_key(13),
        esc: input_binding_key(27)
    },
    gamepad: 
    {
        up: [input_binding_gamepad_axis(32786, true), input_binding_gamepad_button(32781)],
        down: [input_binding_gamepad_axis(32786, false), input_binding_gamepad_button(32782)],
        left: [input_binding_gamepad_axis(32785, true), input_binding_gamepad_button(32783)],
        right: [input_binding_gamepad_axis(32785, false), input_binding_gamepad_button(32784)],
        actionOne: [input_binding_gamepad_button(32769), input_binding_gamepad_button(32775)],
        actionTwo: [input_binding_gamepad_button(32770), input_binding_gamepad_button(32776)],
        aim_up: input_binding_gamepad_axis(32788, true),
        aim_down: input_binding_gamepad_axis(32788, false),
        aim_left: input_binding_gamepad_axis(32787, true),
        aim_right: input_binding_gamepad_axis(32787, false),
        enter: input_binding_gamepad_button(32778),
        esc: input_binding_gamepad_button(32777)
    }
};
