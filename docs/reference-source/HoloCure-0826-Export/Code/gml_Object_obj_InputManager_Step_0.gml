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
if (moveUpDown)
{
    holdingUpTimer++;
}
if (moveDownDown)
{
    holdingDownTimer++;
}
if (moveLeftDown)
{
    holdingLeftTimer++;
}
if (moveRightDown)
{
    holdingRightTimer++;
}
if (moveUpRelease)
{
    holdingUpTimer = 0;
}
if (moveDownRelease)
{
    holdingDownTimer = 0;
}
if (moveLeftRelease)
{
    holdingLeftTimer = 0;
}
if (moveRightRelease)
{
    holdingRightTimer = 0;
}
if (holdingUpTimer > holdingTime)
{
    if ((holdingUpTimer % rapidTrigger) == 0 && upCD == 0)
    {
        moveUpPressed = true;
        upCD = 4;
    }
    else
    {
        moveUpPressed = false;
    }
}
if (holdingDownTimer > holdingTime)
{
    if ((holdingDownTimer % rapidTrigger) == 0 && downCD == 0)
    {
        moveDownPressed = true;
        downCD = 4;
    }
    else
    {
        moveDownPressed = false;
    }
}
if (holdingLeftTimer > holdingTime)
{
    if ((holdingLeftTimer % rapidTrigger) == 0 && rightCD == 0)
    {
        moveLeftPressed = true;
        rightCD = 4;
    }
    else
    {
        moveLeftPressed = false;
    }
}
if (holdingRightTimer > holdingTime)
{
    if ((holdingRightTimer % rapidTrigger) == 0 && leftCD == 0)
    {
        moveRightPressed = true;
        leftCD = 4;
    }
    else
    {
        moveRightPressed = false;
    }
}
if (upCD > 0)
{
    upCD--;
}
if (downCD > 0)
{
    downCD--;
}
if (leftCD > 0)
{
    leftCD--;
}
if (rightCD > 0)
{
    rightCD--;
}
if (global.mx != device_mouse_raw_x(0))
{
    global.mx = device_mouse_raw_x(0);
    mouseMoveX = true;
}
else
{
    mouseMoveX = false;
}
if (global.my != device_mouse_raw_y(0))
{
    global.my = device_mouse_raw_y(0);
    mouseMoveY = true;
}
else
{
    mouseMoveY = false;
}
if (mouseMoveX || mouseMoveY)
{
    mouseMoving = true;
}
else
{
    mouseMoving = false;
}
if (!mouseMoving && global.mouseMovedTime < 180 && (!instance_exists(obj_Player) || (instance_exists(obj_Player) && !obj_Player.mouseFollowMode)))
{
    global.mouseMovedTime++;
}
if (global.mouseMovedTime == 180 || hideMouse)
{
    cursor_sprite = 717;
}
else if (instance_exists(obj_Player) && obj_Player.mouseFollowMode && obj_Player.canControl)
{
    cursor_sprite = 62;
}
else
{
    cursor_sprite = 2428;
}
if (mouseMoving)
{
    global.mouseMovedTime = 0;
}
if (room == rm_InitRoom)
{
    if (instance_exists(obj_GameManager))
    {
        var gameMan = instance_find(obj_GameManager, 0);
        if (actionOneReleased)
        {
            gameMan.Confirmed();
        }
        if (actionTwoPressed)
        {
            gameMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            gameMan.SelectUp();
        }
        if (moveDownPressed)
        {
            gameMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            gameMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            gameMan.SelectRight();
        }
        if (enterPressed)
        {
            gameMan.EnterKey();
        }
        if (escPressed)
        {
            gameMan.ReturnMenu();
        }
    }
}
if (room == rm_Tutorial)
{
    if (instance_exists(obj_Tutorial))
    {
        var gameMan = instance_find(obj_Tutorial, 0);
        if (actionOneReleased)
        {
            gameMan.Confirm();
        }
        if (enterReleased)
        {
            gameMan.Confirm();
        }
    }
}
if (room == rm_Pre_Intro)
{
    if (instance_exists(obj_Pre_Intro))
    {
        var gameMan = instance_find(obj_Pre_Intro, 0);
        if (enterPressed)
        {
            gameMan.EnterKey();
        }
    }
}
if (room == rm_Intro)
{
    if (instance_exists(obj_Intro))
    {
        var gameMan = instance_find(obj_Intro, 0);
        if (enterPressed)
        {
            gameMan.EnterKey();
        }
    }
}
if (room == rm_Title)
{
    if (instance_exists(obj_TitleScreen))
    {
        var gameMan = instance_find(obj_TitleScreen, 0);
        if (actionOnePressed || enterPressed)
        {
            gameMan.Confirmed();
        }
        if (actionTwoPressed || escPressed)
        {
            gameMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            gameMan.SelectUp();
        }
        if (moveDownPressed)
        {
            gameMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            gameMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            gameMan.SelectRight();
        }
    }
}
if (room == rm_CharSelect)
{
    if (instance_exists(obj_CharSelect))
    {
        if (moveLeftPressed)
        {
            instance_find(obj_CharSelect, 0).Left();
        }
        if (actionTwoPressed || escPressed)
        {
            instance_find(obj_CharSelect, 0).Return();
        }
        if (moveRightPressed)
        {
            instance_find(obj_CharSelect, 0).Right();
        }
        if (moveUpPressed)
        {
            instance_find(obj_CharSelect, 0).Up();
        }
        if (moveDownPressed)
        {
            instance_find(obj_CharSelect, 0).Down();
        }
        if (actionOnePressed || enterPressed)
        {
            instance_find(obj_CharSelect, 0).Select();
        }
    }
}
if (room == rm_HiScores)
{
    if (instance_exists(obj_HiScores))
    {
        var hiscoreMan = instance_find(obj_HiScores, 0);
        if (actionOnePressed || enterPressed)
        {
            hiscoreMan.Confirmed();
        }
        if (actionTwoPressed || escPressed)
        {
            hiscoreMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            hiscoreMan.SelectUp();
        }
        if (moveDownPressed)
        {
            hiscoreMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            hiscoreMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            hiscoreMan.SelectRight();
        }
    }
}
if (room == rm_Shop)
{
    if (instance_exists(obj_Shop))
    {
        var shopMan = instance_find(obj_Shop, 0);
        if (actionOnePressed || enterPressed)
        {
            shopMan.Confirmed();
        }
        if (actionTwoPressed || escPressed)
        {
            shopMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            shopMan.SelectUp();
        }
        if (moveDownPressed)
        {
            shopMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            shopMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            shopMan.SelectRight();
        }
    }
}
if (room == rm_Achievements)
{
    if (instance_exists(obj_Achievements))
    {
        var achMan = instance_find(obj_Achievements, 0);
        if (actionOnePressed || enterPressed)
        {
            achMan.Confirmed();
        }
        if (actionTwoPressed || escPressed)
        {
            achMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            achMan.SelectUp();
        }
        if (moveDownPressed)
        {
            achMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            achMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            achMan.SelectRight();
        }
    }
}
if (instance_exists(obj_Credits))
{
    var optionMan = instance_find(obj_Credits, 0);
    if (actionTwoPressed || escPressed)
    {
        optionMan.ReturnMenu();
    }
}
if (instance_exists(obj_Drum))
{
    if (input_check_pressed("actionTwo"))
    {
        obj_Drum.Pressed();
    }
    if (mouse_check_button_pressed(mb_right))
    {
        obj_Drum.Pressed();
    }
}
if (instance_exists(obj_HoloHouse_RoomTransition))
{
    if (input_check_pressed("actionOne"))
    {
        obj_HoloHouse_RoomTransition.Activate();
    }
}
if (instance_exists(obj_UnlockMenu))
{
    var unlockMan = instance_find(obj_UnlockMenu, 0);
    if (actionOnePressed || enterPressed)
    {
        unlockMan.Confirm();
    }
}
if (instance_exists(obj_DialogueController))
{
    if (actionOnePressed || enterPressed)
    {
        obj_DialogueController.Confirmed();
    }
    if (actionTwoPressed || escPressed)
    {
        obj_DialogueController.ReturnMenu();
    }
}
if (instance_exists(obj_Options))
{
    var optionMan = instance_find(obj_Options, 0);
    if (actionOnePressed || enterPressed)
    {
        obj_Options.Confirmed();
    }
    if (actionOneDown || enterDown)
    {
        obj_Options.HoldConfirm();
    }
    if (actionOneReleased || enterReleased)
    {
        obj_Options.ReleaseConfirm();
    }
    if (actionTwoPressed || escPressed)
    {
        obj_Options.ReturnMenu();
    }
    if (moveUpPressed)
    {
        obj_Options.SelectUp();
    }
    if (moveDownPressed)
    {
        obj_Options.SelectDown();
    }
    if (moveLeftPressed)
    {
        obj_Options.SelectLeft();
    }
    if (moveRightPressed)
    {
        obj_Options.SelectRight();
    }
}
else if (instance_exists(obj_PlayerManager))
{
    if (!instance_find(obj_PlayerManager, 0).leveled)
    {
        if (instance_exists(obj_Player))
        {
            if (moveLeftDown || moveRightDown || moveUpDown || moveDownDown)
            {
                directionHorizontal = moveRightDown - moveLeftDown;
                directionVertical = moveDownDown - moveUpDown;
                directionMoving = point_direction(0, 0, directionHorizontal, directionVertical);
                directionDifference = angle_difference(direction, directionMoving);
                direction -= (min(abs(directionDifference), 24) * sign(directionDifference));
                if (directionHorizontal != 0 || directionVertical != 0)
                {
                    obj_Player.Move();
                }
            }
            if (moveLeftRelease && moveRightRelease && moveUpRelease && moveDownRelease)
            {
                obj_Player.Stop();
            }
            if (actionOneDown)
            {
            }
            if (actionTwoPressed)
            {
                ExecuteSpecialAttack();
            }
            if (actionOnePressed)
            {
                obj_Player.isStrafing = 1;
                if (obj_Player.mouseFollowMode)
                {
                    obj_Player.mouseFollowMode = false;
                }
            }
            if (actionOneReleased)
            {
                obj_Player.isStrafing = 0;
            }
        }
    }
    if (instance_find(obj_PlayerManager, 0).paused)
    {
        var playerMan = instance_find(obj_PlayerManager, 0);
        if (actionOnePressed || enterPressed)
        {
            playerMan.Confirmed();
        }
        if (actionTwoPressed || escPressed)
        {
            playerMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            playerMan.SelectUp();
        }
        if (moveDownPressed)
        {
            playerMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            playerMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            playerMan.SelectRight();
        }
    }
    else
    {
        if (enterPressed)
        {
            instance_find(obj_PlayerManager, 0).EnterKey();
        }
        if (escPressed || extension_stubfunc_real())
        {
            instance_find(obj_PlayerManager, 0).EscKey();
        }
    }
}
else if (instance_exists(obj_HoloHouseManager))
{
    if (!instance_find(obj_HoloHouseManager, 0).paused)
    {
        if (instance_exists(obj_Player))
        {
            if (moveLeftDown || moveRightDown || moveUpDown || moveDownDown)
            {
                directionHorizontal = moveRightDown - moveLeftDown;
                directionVertical = moveDownDown - moveUpDown;
                directionMoving = point_direction(0, 0, directionHorizontal, directionVertical);
                directionDifference = angle_difference(direction, directionMoving);
                direction -= (min(abs(directionDifference), 24) * sign(directionDifference));
                if (directionHorizontal != 0 || directionVertical != 0)
                {
                    obj_Player.Move();
                }
            }
            if (moveLeftRelease && moveRightRelease && moveUpRelease && moveDownRelease)
            {
                obj_Player.Stop();
            }
            if (actionOnePressed)
            {
                obj_HoloHouseManager.fullroom = !obj_HoloHouseManager.fullroom;
            }
            if (actionTwoPressed)
            {
                obj_HoloHouseManager.ReturnMenu();
            }
            if (actionOnePressed)
            {
            }
            if (actionOneReleased)
            {
            }
        }
    }
    else if (instance_find(obj_HoloHouseManager, 0).paused)
    {
        var playerMan = instance_find(obj_HoloHouseManager, 0);
        if (actionOnePressed || enterPressed)
        {
            playerMan.Confirmed();
        }
        if (actionTwoPressed || escPressed)
        {
            playerMan.ReturnMenu();
        }
        if (moveUpPressed)
        {
            playerMan.SelectUp();
        }
        if (moveDownPressed)
        {
            playerMan.SelectDown();
        }
        if (moveLeftPressed)
        {
            playerMan.SelectLeft();
        }
        if (moveRightPressed)
        {
            playerMan.SelectRight();
        }
    }
    if (enterPressed)
    {
        instance_find(obj_HoloHouseManager, 0).EnterKey();
    }
    if (escPressed)
    {
        instance_find(obj_HoloHouseManager, 0).EscKey();
    }
}
if (instance_exists(obj_FishingMiniGame))
{
    if (actionOnePressed || enterPressed)
    {
        obj_FishingMiniGame.Confirmed();
    }
    if (actionTwoPressed || escPressed)
    {
        obj_FishingMiniGame.ReturnMenu();
    }
    if (moveUpPressed)
    {
        obj_FishingMiniGame.SelectUp();
    }
    if (moveDownPressed)
    {
        obj_FishingMiniGame.SelectDown();
    }
    if (moveLeftPressed)
    {
        obj_FishingMiniGame.SelectLeft();
    }
    if (moveRightPressed)
    {
        obj_FishingMiniGame.SelectRight();
    }
}
