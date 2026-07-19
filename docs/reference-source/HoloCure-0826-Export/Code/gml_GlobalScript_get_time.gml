function get_time()
{
    var hoursPart = "";
    var minutesPart = "";
    var secondsPart = "";
    if (global.time[UnknownEnum.Value_0] > 0)
    {
        hoursPart = string(global.time[UnknownEnum.Value_0]) + " : ";
    }
    if (global.time[UnknownEnum.Value_1] < 10)
    {
        minutesPart = string("0" + string(global.time[UnknownEnum.Value_1]));
    }
    else
    {
        minutesPart = string(global.time[UnknownEnum.Value_1]);
    }
    if (global.time[UnknownEnum.Value_2] < 10)
    {
        secondsPart = string("0" + string(global.time[UnknownEnum.Value_2]));
    }
    else
    {
        secondsPart = string(global.time[UnknownEnum.Value_2]);
    }
    return hoursPart + minutesPart + " : " + secondsPart;
}

function StringFormatTimeSeconds(arg0)
{
    if (arg0 == undefined)
    {
        return "--:--:--";
    }
    var hours = floor(arg0 / 3600);
    var minutes = floor((arg0 % 3600) / 60);
    var seconds = floor(arg0 % 60);
    var timeText = ((hours > 0) ? (string(hours) + ":") : "") + string_format(minutes, 2, 0) + ":" + string_format(seconds, 2, 0);
    timeText = string_replace_all(timeText, " ", "0");
    return timeText;
}

function string_time(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] < 0)
        {
            arg0[i] = 0;
        }
    }
    if (array_length(arg0) == 0)
    {
        return "--:--:--";
    }
    var hoursPart = "";
    var minutesPart = "";
    var secondsPart = "";
    if (arg0[0] > 0)
    {
        hoursPart = string(arg0[0]) + " : ";
    }
    if (arg0[1] < 10)
    {
        minutesPart = string("0" + string(arg0[1]));
    }
    else
    {
        minutesPart = string(arg0[1]);
    }
    if (arg0[2] < 10)
    {
        secondsPart = string("0" + string(arg0[2]));
    }
    else
    {
        secondsPart = string(arg0[2]);
    }
    return hoursPart + minutesPart + " : " + secondsPart;
}

function CompareTimes(arg0, arg1)
{
    if (!(is_array(arg0) && is_array(arg1)))
    {
        return false;
    }
    if (arg0[0] < arg1[0])
    {
        return arg0;
    }
    if (arg0[0] > arg1[0])
    {
        return arg1;
    }
    if (arg0[1] < arg1[1])
    {
        return arg0;
    }
    if (arg0[1] > arg1[1])
    {
        return arg1;
    }
    if (arg0[2] < arg1[2])
    {
        return arg0;
    }
    if (arg0[2] > arg1[2])
    {
        return arg1;
    }
    return arg0;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
