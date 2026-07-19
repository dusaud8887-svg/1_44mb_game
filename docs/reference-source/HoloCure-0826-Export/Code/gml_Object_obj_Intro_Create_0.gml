currentScene = -1;
lifetime = 0;
screenAlpha = 1;
textAlpha = 0;
currentText = 0;
alarm[0] = 31;
alarm[2] = 31;
audio_stop_all();
global.bgmPlay = 26;
if (!audio_is_playing(global.bgmPlay))
{
    audio_play_sound(global.bgmPlay, 0, 0);
}

function EnterKey()
{
    if (global.unlockedNew && array_length(global.unlockedThings) > 0)
    {
        global.returningRoom = 3;
        global.resetLevel = true;
        audio_stop_sound(bgm_gameover);
        room_goto(rm_UnlockRoom);
    }
    else
    {
        room_goto_next();
    }
}

if (global.debug)
{
    room_goto_next();
}
