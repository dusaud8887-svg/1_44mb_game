alarm[1] = 60;
if (array_length(timeEvents) > 0)
{
    for (var i = 0; i < array_length(timeEvents); i++)
    {
        if (its_time(timeEvents[i].time[0], timeEvents[i].time[1], timeEvents[i].time[2]))
        {
            timeEvents[i].script(id);
        }
    }
}
