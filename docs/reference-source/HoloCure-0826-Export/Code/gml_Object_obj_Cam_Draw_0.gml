if (currentXOffset != global.cameraXOffset)
{
    currentXOffset += ((global.cameraXOffset - currentXOffset) * 0.1);
    if (abs(global.cameraXOffset - currentXOffset) < 0.2)
    {
        currentXOffset = global.cameraXOffset;
    }
}
if (currentYOffset != global.cameraYOffset)
{
    currentYOffset += ((global.cameraYOffset - currentYOffset) * 0.1);
    if (abs(global.cameraYOffset - currentYOffset) < 0.2)
    {
        currentYOffset = global.cameraYOffset;
    }
}
if (followPlayerID > 0)
{
    x = followPlayerID.x + shakeX + currentXOffset;
    y = (followPlayerID.y - charCenterY) + shakeY + currentYOffset;
}
else
{
    followPlayerID = instance_find(obj_Player, 0);
}
if (global.aboveHP)
{
    if (instance_exists(followPlayerID))
    {
        if (!showingHP && followPlayerID.currentHP != followPlayerID.HP)
        {
            showingHP = true;
        }
        if (showingHP && followPlayerID.currentHP == followPlayerID.HP)
        {
            showingHP = false;
            showHPBarTime = 120;
            showShieldBarTime = 120;
        }
        if (showHPBarTime > 0 && global.hideFullHP)
        {
            showHPBarTime--;
        }
        if (variable_struct_exists(followPlayerID.scripts, "BodyPillow"))
        {
            if (!showingShield && followPlayerID.shieldHP != followPlayerID.scripts.BodyPillow.config.shieldHP)
            {
                showingShield = true;
            }
            if (showingShield && followPlayerID.shieldHP != followPlayerID.scripts.BodyPillow.config.shieldHP)
            {
                showingShield = false;
                showShieldBarTime = 120;
            }
            if (showShieldBarTime > 0)
            {
                showShieldBarTime--;
            }
        }
        if (followPlayerID.image_alpha != 0)
        {
            draw_set_alpha(1);
            if (followPlayerID.currentHP < followPlayerID.HP || showHPBarTime > 0)
            {
                draw_healthbar(followPlayerID.x - 13, followPlayerID.y - 16 - 20, followPlayerID.x + 13, followPlayerID.y - 16 - 23, (followPlayerID.currentHP / followPlayerID.HP) * 100, c_red, c_lime, c_lime, 0, 1, 0);
                if (variable_struct_exists(followPlayerID.scripts, "Plushie"))
                {
                    var takenDamageBar = max(0, (followPlayerID.scripts.Plushie.config.damageDebt - followPlayerID.shieldHP) / followPlayerID.HP) * 26;
                    if (takenDamageBar > 0)
                    {
                        draw_healthbar((followPlayerID.x - 13) + max(0, (min(1, (followPlayerID.currentHP + followPlayerID.shieldHP) / followPlayerID.HP) * 26) - takenDamageBar), followPlayerID.y - 16 - 20, (followPlayerID.x - 13) + max(0, ((followPlayerID.currentHP / followPlayerID.HP) * 26) - takenDamageBar) + min((followPlayerID.currentHP / followPlayerID.HP) * 26, takenDamageBar), followPlayerID.y - 16 - 23, 100, c_white, make_color_rgb(255, 101, 244), make_color_rgb(255, 101, 244), 0, 0, 0);
                    }
                }
            }
            if (variable_struct_exists(followPlayerID.scripts, "BodyPillow"))
            {
                if ((followPlayerID.shieldHP > 0 && followPlayerID.shieldHP != followPlayerID.scripts.BodyPillow.config.shieldHP) || followPlayerID.currentHP != followPlayerID.HP || showShieldBarTime > 0)
                {
                    draw_healthbar(followPlayerID.x - 13, followPlayerID.y - 16 - 23, followPlayerID.x + 13, followPlayerID.y - 16 - 26, (followPlayerID.shieldHP / followPlayerID.scripts.BodyPillow.config.shieldHP) * 100, c_red, make_color_rgb(78, 173, 255), make_color_rgb(78, 173, 255), 0, 0, 1);
                }
            }
        }
    }
}
