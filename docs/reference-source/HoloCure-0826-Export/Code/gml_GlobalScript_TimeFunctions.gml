function getTimeFromTicks(arg0)
{
    var seconds = floor(arg0 / 60);
    var minutes = floor(seconds / 60);
    var hours = floor(minutes / 60);
    seconds = seconds % 60;
    minutes = minutes % 60;
    return [hours, minutes, seconds];
}
