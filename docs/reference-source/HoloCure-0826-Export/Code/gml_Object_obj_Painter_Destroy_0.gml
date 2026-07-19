with (obj_Enemy)
{
    EndStop();
}
with (obj_Player)
{
    stopAttacks = false;
    canControl = true;
    specMustWait = 1;
    invincible = true;
    invincibilityTimer = 180;
}
with (obj_InputManager)
{
    hideMouse = false;
}
with (obj_Attack)
{
    if (attackID == "IofiPaint")
    {
        duration = 300;
    }
}
