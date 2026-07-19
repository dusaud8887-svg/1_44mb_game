function input_hotswap_params_get()
{
    static _global = __input_global();
    static _result = {};
    
    _result.callback = _global.__hotswap_callback;
    return _result;
}
