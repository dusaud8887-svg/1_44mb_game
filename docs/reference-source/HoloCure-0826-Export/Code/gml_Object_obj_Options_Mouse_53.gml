for (var i = 0; i < 7; i++)
{
    var screensize = 1;
    if (room == rm_PauseRoom)
    {
        screensize++;
    }
    if (MouseOverButton("long", container[0] + 12, container[1] + 43 + (i * 34), screensize) && !remapping && !changingName && !deleteConfirm)
    {
        Confirmed();
    }
}
