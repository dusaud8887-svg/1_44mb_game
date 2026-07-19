canControl = false;
global.firstTime = false;
alarm[0] = 30;

function Confirm()
{
    if (canControl)
    {
        room_goto(global.playingStage);
    }
}
