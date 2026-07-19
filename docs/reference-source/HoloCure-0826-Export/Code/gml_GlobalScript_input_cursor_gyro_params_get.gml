function input_cursor_gyro_params_get(arg0 = 0)
{
    static _global = __input_global();
    static _result = 
    {
        axis_x: UnknownEnum.Value_1,
        axis_y: UnknownEnum.Value_0,
        sensitivity_x: 2,
        sensitivity_y: -2,
        gamepad: undefined
    };
    
    if (arg0 < 0)
    {
        __input_error("Invalid player index provided (", arg0, ")");
        return undefined;
    }
    if (arg0 >= 4)
    {
        __input_error("Player index too large (", arg0, " must be less than ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    _result.axis_x = _global.__players[arg0].__gyro_axis_x;
    _result.axis_y = _global.__players[arg0].__gyro_axis_y;
    _result.sensitivity_x = _global.__players[arg0].__gyro_sensitivity_x;
    _result.sensitivity_y = _global.__players[arg0].__gyro_sensitivity_y;
    _result.gamepad = _global.__players[arg0].__gyro_gamepad;
    return _result;
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
