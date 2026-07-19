switch (lifetime)
{
    case 30:
        currentScene = 0;
        break;
    case 214:
        alarm[1] = 1;
        alarm[3] = 1;
        break;
    case 261:
        alarm[0] = 1;
        alarm[2] = 1;
        break;
    case 486:
        alarm[1] = 1;
        alarm[3] = 1;
        break;
    case 532:
        alarm[0] = 1;
        alarm[2] = 1;
        break;
    case 746:
        alarm[3] = 1;
        break;
    case 792:
        alarm[2] = 1;
        break;
    case 960:
        alarm[1] = 1;
        alarm[3] = 1;
        break;
    case 1006:
        alarm[0] = 1;
        alarm[2] = 1;
        break;
    case 1266:
        alarm[1] = 1;
        alarm[3] = 1;
        break;
    case 1312:
        alarm[0] = 1;
        alarm[2] = 1;
        break;
    case 1604:
        alarm[1] = 1;
        alarm[3] = 1;
        break;
    case 1650:
        alarm[0] = 1;
        alarm[2] = 1;
        break;
    case 1854:
        alarm[3] = 1;
        break;
    case 1900:
        alarm[2] = 1;
        break;
    case 2058:
        alarm[1] = 1;
        alarm[3] = 1;
        break;
    case 2140:
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
        break;
}
lifetime++;
