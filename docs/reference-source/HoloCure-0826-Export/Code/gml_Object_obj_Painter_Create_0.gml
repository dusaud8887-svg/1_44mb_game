paintTimer = 1200;
paintAmount = 100;
paintCD = 60;
initial = true;
currentHue = irandom(255);
currentColor = make_color_hsv(currentHue, 255, 255);
obj_PlayerManager.Dank(1200);
painting = false;
prevX = 0;
alarm[0] = 1;
x = obj_Player.x;
y = obj_Player.y;
prevX = x;
drawDir = 0;
image_speed = 0;
global.timePause = true;

function Paint()
{
    if (paintCD == 0)
    {
        soundPlay([18], "paintloop", 8, 0);
        currentHue += 3;
        painting = 5;
        if (currentHue >= 256)
        {
            currentHue = 0;
        }
        paintCD = 3;
        currentColor = make_color_hsv(currentHue, 255, 255);
        paintAmount -= 1;
        obj_AttackController.ExecuteAttack("IofiPaint", 227, 
        {
            x: x,
            y: y,
            spriteColor: currentColor,
            drawUnderAll: true,
            extraDepth: paintAmount * 3
        });
    }
    if (paintAmount < 1)
    {
        EndPaint();
    }
}

function EndPaint()
{
    obj_PlayerManager.EndDank();
    global.timePause = false;
    instance_destroy();
}
