function Firebase_Listener_Refresh_Authentication(arg0)
{
    with (arg0)
    {
        arg0.alarm[0] = -1;
        event_perform(ev_alarm, 0);
    }
}

function Firebase_Listener_SetErrorCountLimit_Authentication(arg0, arg1)
{
    arg0.errorCountLimit = arg1;
}

function Firebase_Listener_SetErrorResetSteps_Authentication(arg0, arg1)
{
    arg0.errorResetAlarm = arg1;
}

function Firebase_Listener_SetRefreshSteps_Authentication(arg0, arg1)
{
    arg0.refreshCall = arg1;
}
