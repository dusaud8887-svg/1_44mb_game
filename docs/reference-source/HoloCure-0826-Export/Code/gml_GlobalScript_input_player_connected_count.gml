function input_player_connected_count()
{
    static _global = __input_global();
    
    var _count = 0;
    var _p = 0;
    repeat (4)
    {
        if (_global.__players[_p].__connected)
        {
            _count++;
        }
        _p++;
    }
    return _count;
}
