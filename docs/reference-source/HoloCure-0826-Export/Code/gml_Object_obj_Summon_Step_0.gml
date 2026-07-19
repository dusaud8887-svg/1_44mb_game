event_inherited();
isInView = x > (camera_get_view_x(view_camera[0]) - 15) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 15) && y > (camera_get_view_y(view_camera[0]) - 15) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 15);
if (!stopAttacks)
{
    var keys = variable_struct_get_names(behaviours);
    for (var i = 0; i < array_length(keys); i++)
    {
        var Script = variable_struct_get(behaviours, keys[i]).Script;
        var config = variable_struct_get(behaviours, keys[i]).config;
        Script(self, config);
    }
    var key = ds_map_find_first(attacks);
    while (!is_undefined(key))
    {
        var attackObj = ds_map_find_value(attacks, key);
        var isSequence = variable_struct_exists(attackObj, "sequenceConfig");
        var ExecuteAttack = obj_AttackController.ExecuteAttack;
        if (attackObj.timer == 0)
        {
            attackObj.attackCount = attackObj.config.attackCount;
            attackObj.timer = round(attackObj.config.attackTime / (1 + (obj_Player.haste / 100)));
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
            var mob = self;
            if (isSequence)
            {
                var overrideConfig = {};
                variable_struct_copy(attackObj.sequenceConfig, overrideConfig);
                overrideConfig.x = x;
                overrideConfig.y = y;
                overrideConfig.stayOn = id;
                overrideConfig.countID = attackObj.countID;
                overrideConfig.summonSource = id;
                var attack = ExecuteAttack(attackObj.attackID, 227, overrideConfig);
                attackObj.countID++;
                with (attackObj.sequenceConfig)
                {
                    startx = flipx ? -1(startx + stepx) : (startx + stepx);
                    starty = flipy ? -1(starty + stepy) : (starty + stepy);
                    image_angle += stepDirection;
                    direction += stepDirection;
                    startDirection = (stepDirection != 0) ? 0 : startDirection;
                }
                attack.stayOn = id;
            }
            else
            {
                var overrideConfig = {};
                variable_struct_copy(attackObj.config, overrideConfig);
                overrideConfig.x = x;
                overrideConfig.y = y;
                overrideConfig.stayOn = id;
                overrideConfig.summonSource = id;
                var attack = ExecuteAttack(attackObj.attackID, 227, overrideConfig);
                with (attackObj.config)
                {
                    attackObj.sequenceConfig = {};
                    keys = variable_struct_get_names(self);
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
                        var newDirection = mob.image_xscale * stepDirection;
                        image_angle = lockCreatorDir ? (mob.direction + newDirection) : (direction + newDirection);
                        direction = lockCreatorDir ? (mob.direction + newDirection) : (direction + newDirection);
                        startDirection = (stepDirection != 0) ? 0 : startDirection;
                        stepDirection *= mob.image_xscale;
                        faceCreatorDirection = false;
                        horizontalOnly = false;
                    }
                }
                attack.stayOn = id;
            }
            attackObj.attackDelay = attackObj.config.attackDelay;
            attackObj.attackCount--;
        }
        attackObj.attackDelay--;
        key = ds_map_find_next(attacks, key);
    }
}
