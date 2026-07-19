followPlayerID = instance_find(obj_Player, 0);
shakeX = 0;
shakeY = 0;
shakeDuration = 0;
shakeTime = 0;
shakeAmount = 6;
charCenterY = 16;
currentXOffset = 0;
currentYOffset = 0;
global.cameraXOffset = 0;
global.cameraYOffset = 0;

function ExecuteShake(arg0 = 60, arg1 = 6)
{
    if (global.screenshake)
    {
        if (shakeTime == 0)
        {
            shakeDuration = arg0;
            shakeTime = shakeDuration;
            shakeAmount = arg1;
            alarm[0] = 1;
        }
        else
        {
            shakeTime = arg0;
        }
    }
}

depth = -9999;
showHPBarTime = 0;
showingHP = false;
showShieldBarTime = 0;
showingShield = false;
