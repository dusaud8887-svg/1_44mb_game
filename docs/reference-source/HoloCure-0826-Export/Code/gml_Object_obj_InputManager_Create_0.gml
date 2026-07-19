if (!variable_global_exists("theButtons"))
{
    global.theButtons = [];
}
if (!variable_global_exists("controllerButtons"))
{
    global.controllerButtons = [];
}
global.mx = device_mouse_raw_x(0);
global.my = device_mouse_raw_y(0);
mouseMoving = false;
mouseMoveX = false;
mouseMoveY = false;
directionHorizontal = 0;
directionVertical = 0;
directionMoving = 0;
directionDifference = 0;
direction = 0;
movementEnabled = 1;
upKey = 87;
downKey = 83;
leftKey = 65;
rightKey = 68;
actionOneKey = 32;
actionTwoKey = 16;
holdingTime = 20;
rapidTrigger = 5;
holdingUpTimer = 0;
holdingDownTimer = 0;
holdingLeftTimer = 0;
holdingRightTimer = 0;
hideMouse = false;
upCD = 0;
downCD = 0;
leftCD = 0;
rightCD = 0;
moveUpDown = input_check("up");
moveLeftDown = input_check("left");
moveDownDown = input_check("down");
moveRightDown = input_check("right");
moveUpRelease = input_check_released("up");
moveLeftRelease = input_check_released("left");
moveRightRelease = input_check_released("right");
moveDownRelease = input_check_released("down");
moveUpPressed = input_check_pressed("up");
moveLeftPressed = input_check_pressed("left");
moveRightPressed = input_check_pressed("right");
moveDownPressed = input_check_pressed("down");
actionOneDown = input_check("actionOne");
actionOnePressed = input_check_pressed("actionOne");
actionOneReleased = input_check_released("actionOne");
actionTwoDown = input_check("actionTwo");
actionTwoPressed = input_check_pressed("actionTwo");
actionTwoReleased = input_check_released("actionTwo");
enterDown = input_check("enter");
enterPressed = input_check_pressed("enter");
enterReleased = input_check_released("enter");
escDown = input_check("esc");
escPressed = input_check_pressed("esc");
escReleased = input_check_released("esc");
gamepad_set_colour(0, 16711680);

function ResetAll()
{
    holdingUpTimer = 0;
    holdingDownTimer = 0;
    holdingLeftTimer = 0;
    holdingRightTimer = 0;
    upCD = 0;
    downCD = 0;
    leftCD = 0;
    rightCD = 0;
}

if (!variable_global_exists("mouseMovedTime"))
{
    global.mouseMovedTime = 0;
}
if (array_length(global.theButtons) < 1)
{
    global.theButtons = [actionOneKey, actionTwoKey, leftKey, rightKey, upKey, downKey];
}
if (array_length(global.controllerButtons) < 6)
{
    global.controllerButtons = [32769, 32775, 32770, 32776, 32778, 32777];
    SetControllerControls();
}

function MouseMoved()
{
    return mouseMoving;
}

function ExecuteSpecialAttack()
{
    if (instance_exists(obj_PlayerManager))
    {
        var playerMan = instance_find(obj_PlayerManager, 0);
        var player = playerMan.playerCharacter;
        var specialid = player.specialid;
        if ((player.canSpecial || global.debug) && player.isAlive && player.specMustWait == 0)
        {
            obj_PlayerManager.dontNeedFlag = false;
            player.canSpecial = false;
            if (player.extraSpecial > 0 && player.instantRefreshSpecial)
            {
                player.extraSpecial--;
                player.specialMeter -= 1;
            }
            else
            {
                player.extraSpecial = 1;
                player.specialMeter = 0;
            }
            audio_play_sound(snd_specialuse, 5, 0);
            DoAchievement("idolPower");
            player.OnSpecial(player);
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "IdolCostume", "ITEM");
            obj_PlayerManager.playerFlags.usedSpecial = true;
            if (specialid != "")
            {
                obj_AttackController.ExecuteAttack(specialid, player);
                playerMan.Dank();
                var specVFX = instance_create_depth(player.x, player.y - 16, player.depth - 10, obj_vfx);
                specVFX.sprite_index = spr_useSpecial;
                specVFX.image_xscale = 1.5;
                specVFX.image_yscale = 1.5;
                specVFX.image_alpha = 0.8;
            }
        }
    }
}
