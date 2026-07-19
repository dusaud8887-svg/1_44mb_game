currentScene = 0;
lifetime = 0;
screenAlpha = 1;
currentText = 0;
alarm[0] = 10;
audio_stop_all();

function EnterKey()
{
    room_goto_next();
}
