function __input_class_trigger_effect_vibration(arg0, arg1, arg2) constructor
{
    static __mode_name = "vibration";
    static __mode = UnknownEnum.Value_3;
    
    static __apply_ps5 = function(arg0, arg1, arg2)
    {
        return ps5_gamepad_set_trigger_effect_vibration(arg0, arg1, __params.position, __params.amplitude * arg2, __params.frequency);
    };
    
    static __steam_get_state = function(arg0, arg1)
    {
        if (input_gamepad_value(arg0, arg1) >= (__params.position / 10))
        {
            return UnknownEnum.Value_7;
        }
        return UnknownEnum.Value_6;
    };
    
    __params = 
    {
        position: clamp(arg0 * 10, 0, 9),
        amplitude: clamp(arg1 * 8, 0, 8),
        frequency: clamp(arg2 * 255, 0, 255)
    };
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_6 = 6,
    Value_7
}
