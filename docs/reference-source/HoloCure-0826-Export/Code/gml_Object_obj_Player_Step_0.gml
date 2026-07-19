checkEffects = 1;
event_inherited();
if (specUnlock > 0 && specialid != "" && specialMeter != floor(specCD * (specMod - (specCDR / 100))))
{
    specialTimer++;
    if (specialTimer == 60)
    {
        specialMeter++;
        specialTimer = 0;
    }
    if (specialMeter >= floor(specCD * (specMod - (specCDR / 100))))
    {
        if (!canSpecial)
        {
            soundPlay([27], "special", 30, 20);
            if (global.vibration)
            {
                input_vibrate_constant(0.9, 0, 30);
            }
        }
        canSpecial = true;
        specialMeter = floor(specCD * (specMod - (specCDR / 100)));
    }
}
if (specUnlock > 0 && specialid != "" && specialMeter == floor(specCD * (specMod - (specCDR / 100))))
{
    if (!canSpecial)
    {
        canSpecial = true;
        specialMeter = floor(specCD * (specMod - (specCDR / 100)));
        soundPlay([27], "special", 30, 20);
        if (global.vibration)
        {
            input_vibrate_constant(0.9, 0, 30);
        }
    }
}
if (!isStrafing && canControl)
{
    if (direction != input_direction(direction, "aim_left", "aim_right", "aim_up", "aim_down"))
    {
        direction = input_direction(direction, "aim_left", "aim_right", "aim_up", "aim_down");
        if (instance_exists(obj_PlayerManager))
        {
            obj_PlayerManager.playerFlags.aimed = true;
        }
        if (mouseFollowMode)
        {
            mouseFollowMode = false;
        }
    }
}
if (specMustWait > 0)
{
    specMustWait--;
}
if (direction < 90 || direction > 270)
{
    image_xscale = 1;
}
if (direction > 90 && direction < 270)
{
    image_xscale = -1;
}
if (afterImageOn != false)
{
    alarm[1] = 1;
}
if (HP < 1)
{
    HP = 1;
}
if (currentHP < 0)
{
    currentHP = 0;
    obj_PlayerManager.hpSus = currentHP - 1;
}
global.currentHP = currentHP;
global.maxHP = HP;
for (var i = 0; i < array_length(levelUpAchievementTimers); i++)
{
    levelUpAchievementTimers[i]--;
    if (levelUpAchievementTimers[i] == 0)
    {
        array_delete(levelUpAchievementTimers, i, 1);
    }
}
if (array_length(levelUpAchievementTimers) == 5)
{
    DoAchievement("powerLevelling");
}
if (regen > 0 && (currentHP > 0 || canNotDie))
{
    if (currentHP < HP)
    {
        if (regenTimer > 0)
        {
            regenTimer--;
        }
        else
        {
            currentHP += regen;
            regenTimer = 300;
            if (currentHP > HP)
            {
                currentHP = HP;
            }
            obj_PlayerManager.hpSus = currentHP - 1;
        }
    }
}
if (instance_exists(obj_PlayerManager) && obj_PlayerManager.donttouchCount >= 0)
{
    obj_PlayerManager.donttouchCount++;
    if (obj_PlayerManager.donttouchCount >= 18000 && !obj_PlayerManager.dontTouchTriggered)
    {
        DoAchievement("donttouch");
        obj_PlayerManager.dontTouchTriggered = true;
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "LabCoat", "ITEM");
    }
}
if (!input_check("actionOne"))
{
    isStrafing = false;
}
if (mouseFollowMode)
{
    direction = point_direction(x, y, mouse_x, mouse_y + 16);
}
if (crit >= 100)
{
    DoAchievement("notTakingAnyChances");
}
if (variable_instance_exists(self, "drunkDirection"))
{
    direction += drunkDirection;
}
if (instance_exists(obj_PlayerManager))
{
    if (!stopAttacks && isAlive)
    {
        var key = ds_map_find_first(attacks);
        while (!is_undefined(key))
        {
            var attackObj = ds_map_find_value(attacks, key);
            var isSequence = variable_struct_exists(attackObj, "sequenceConfig");
            var ExecuteAttack = obj_AttackController.ExecuteAttack;
            var originalCount = attackObj.config.attackCount;
            if (attackObj.timer == 0)
            {
                attackObj.attackCount = attackObj.config.attackCount;
                attackObj.splitEnhancement = originalCount;
                if (attackObj.config.weaponType == "MultiShot")
                {
                    attackObj.attackCount = min(attackObj.config.maxAttackCount, attackObj.attackCount + bonusProjectiles);
                    switch (attackObj.config.projOrientation)
                    {
                        case "none":
                            break;
                        case "circle":
                            attackObj.config.stepDirection = 360 / attackObj.attackCount;
                            break;
                        case "frontSpread":
                            attackObj.config.startDirection = -((attackObj.config.stepDirection / 2) * (attackObj.attackCount - 1));
                            break;
                    }
                }
                attackObj.countID = 0;
                attackObj.splitEnhancement = originalCount;
                attackObj.timer = max(attackObj.config.minDelay, round(attackObj.resetTimer / (1 + (haste / 100))));
                if (isSequence)
                {
                    variable_struct_remove(attackObj, "sequenceConfig");
                }
            }
            if (attackObj.timer > 0)
            {
                attackObj.timer--;
            }
            while (attackObj.attackCount > 0 && attackObj.attackDelay <= 0)
            {
                isSequence = variable_struct_exists(attackObj, "sequenceConfig");
                var player = self;
                if (isSequence)
                {
                    ExecuteAttack(attackObj.attackID, id, attackObj.sequenceConfig);
                    attackObj.countID++;
                    attackObj.splitEnhancement = originalCount;
                    with (attackObj.sequenceConfig)
                    {
                        startx = flipx ? -1(startx + stepx) : (startx + stepx);
                        starty = flipy ? -1(starty + stepy) : (starty + stepy);
                        image_angle += stepDirection;
                        direction += stepDirection;
                        startDirection = (stepDirection != 0) ? 0 : startDirection;
                        countID = attackObj.countID;
                        splitEnhancement = originalCount;
                    }
                }
                else
                {
                    var attack = ExecuteAttack(attackObj.attackID, id, attackObj.config);
                    with (attackObj.config)
                    {
                        attackObj.countID++;
                        attackObj.splitEnhancement = originalCount;
                        attackObj.sequenceConfig = {};
                        var keys = variable_struct_get_names(self);
                        for (var i = 0; i < array_length(keys); i++)
                        {
                            var property = variable_struct_get(self, keys[i]);
                            variable_struct_set(attackObj.sequenceConfig, keys[i], property);
                        }
                        with (attackObj.sequenceConfig)
                        {
                            direction = attack.direction;
                            startx = flipx ? -1(startx + stepx) : (startx + stepx);
                            starty = flipy ? -1(starty + stepy) : (starty + stepy);
                            var newDirection = player.image_xscale * stepDirection;
                            image_angle = lockCreatorDir ? (player.direction + newDirection) : (direction + newDirection + reverse);
                            direction = lockCreatorDir ? (player.direction + newDirection) : (direction + newDirection + reverse);
                            startDirection = (stepDirection != 0) ? 0 : startDirection;
                            stepDirection *= player.image_xscale;
                            faceCreatorDirection = false;
                            horizontalOnly = false;
                            countID = attackObj.countID;
                            splitEnhancement = originalCount;
                        }
                    }
                }
                attackObj.attackDelay = attackObj.config.attackDelay;
                attackObj.attackCount--;
            }
            attackObj.attackDelay--;
            key = ds_map_find_next(attacks, key);
        }
    }
}
if (currentHP <= 0 && global.new_camera_scale != 1)
{
    global.new_camera_scale = 1;
}
if (room == rm_HoloHouse_Entrance)
{
    var interactibleList = ds_list_create();
    collision_circle_list(x, y, 30, obj_NPC, true, true, interactibleList, true);
    collision_circle_list(x, y, 30, obj_holoHouseNPC, true, true, interactibleList, true);
    if (ds_list_size(interactibleList) > 0)
    {
        interactNear = true;
    }
    else
    {
        interactNear = false;
    }
}
