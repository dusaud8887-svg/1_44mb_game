function its_time(arg0, arg1, arg2)
{
    return global.time[UnknownEnum.Value_0] == arg0 && global.time[UnknownEnum.Value_1] == arg1 && global.time[UnknownEnum.Value_2] == arg2;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
