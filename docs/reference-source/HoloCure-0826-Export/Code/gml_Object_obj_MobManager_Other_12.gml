behaviours = {};
behaviours.collideWithPlayer = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (!arg0.inView)
            {
                exit;
            }
            if (!instance_exists(followTarget))
            {
                exit;
            }
            if (!arg0.isEnemy)
            {
                exit;
            }
            if (!variable_instance_exists(followTarget, "isEnemy"))
            {
                exit;
            }
            if (arg0.isEnemy && followTarget.isEnemy)
            {
                exit;
            }
            if (instance_exists(followTarget))
            {
                if (abs(followTarget.y - y) < hitboxHeight)
                {
                    if (variable_instance_exists(followTarget, "canBeHit") && followTarget.canBeHit == 0)
                    {
                        if (arg0.hitCDTimer == 0 && canAttack)
                        {
                            if (place_meeting(arg0.x, arg0.y, followTarget))
                            {
                                var dmgObj = obj_AttackController.CalculateDamage(followTarget, arg0, 
                                {
                                    damage: 0.1
                                });
                                var damage = dmgObj[0];
                                arg0.hitCDTimer = arg0.hitCD;
                                if (!instance_exists(followTarget))
                                {
                                    return false;
                                }
                                if (followTarget.isAlive)
                                {
                                    followTarget.canBeHit = 3;
                                    followTarget.TakeDamage(followTarget.OnCollide(id, damage), arg0);
                                }
                            }
                        }
                        else if (place_meeting(arg0.x, arg0.y, followTarget))
                        {
                            followTarget.OnCollide(id, -1);
                        }
                    }
                }
            }
        }
    },
    
    config: {}
};
behaviours.multiBossChecker = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (!arg1.set)
            {
                global.multiBossDefeat = arg1.numBosses;
                arg1.set = true;
            }
            arg0.x = -5000;
            arg0.y = -5000;
            if (global.multiBossDefeat == 0)
            {
                Die();
            }
        }
    },
    
    config: 
    {
        numBosses: 3,
        set: false
    }
};
behaviours.followPlayer = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (!instance_exists(followTarget) || followTarget == -4)
            {
                if (arg0.turnTimer == 0)
                {
                    arg0.direction = irandom(359);
                    arg0.turnTimer = 90;
                    if (arg0.direction > 270 || arg0.direction < 90)
                    {
                        arg0.image_xscale = abs(arg0.image_xscale);
                    }
                    else
                    {
                        arg0.image_xscale = -abs(arg0.image_xscale);
                    }
                }
                return false;
            }
            else if (canMove && !dontMove)
            {
                obj_MobManager.MoveToPosition(followTarget, self);
            }
        }
    },
    
    config: {}
};
behaviours.followRandomEnemies = 
{
    Script: function(arg0, arg1)
    {
        var changeTimer;
        with (arg0)
        {
            if (arg1.changeTimer > 0)
            {
                arg1.changeTimer--;
            }
            else
            {
                var targets = ds_list_create();
                var enemiesList = collision_circle_list(arg0.x, arg0.y, 200, obj_Enemy, true, true, targets, false);
                if (enemiesList > 0)
                {
                    followTarget = ds_list_find_value(targets, irandom(enemiesList - 1));
                }
                else
                {
                    followTarget = 227;
                }
                arg1.changeTimer = 60 + irandom(120);
            }
            if (!instance_exists(followTarget))
            {
                arg1.changeTimer = 0;
            }
            if (canMove && instance_exists(followTarget))
            {
                obj_MobManager.MoveToPosition(followTarget, self);
            }
        }
    },
    
    config: 
    {
        changeTimer: 60
    }
};
behaviours.healEnemies = 
{
    Script: function(arg0, arg1)
    {
        var healTimer;
        with (arg0)
        {
            if (arg1.healTimer > 0)
            {
                arg1.healTimer--;
            }
            else
            {
                if (arg0.isEnemy)
                {
                    var targets = ds_list_create();
                    var enemiesList = collision_circle_list(arg0.x, arg0.y, arg1.range, obj_Enemy, true, true, targets, false);
                    if (enemiesList > 0)
                    {
                        for (var i = 0; i < enemiesList; i++)
                        {
                            if (variable_instance_exists(ds_list_find_value(targets, i), "name") && string_count("Yagoo", ds_list_find_value(targets, i).name) == 0)
                            {
                                var healVal = min(1000, ds_list_find_value(targets, i).HP * 0.1);
                                if (ds_list_find_value(targets, i).id != "GoldenYagoo" && ds_list_find_value(targets, i).id != "SilverYagoo")
                                {
                                    Heal(ds_list_find_value(targets, i), floor((healVal - (healVal * 0.1)) + random(healVal * 0.2)), 0, true, false, false);
                                }
                            }
                        }
                    }
                }
                else if (point_distance(arg0.x, arg0.y, obj_Player.x, obj_Player.y) < arg1.range)
                {
                    var healVal = obj_Player.HP * 0.1;
                    Heal(227, floor((healVal - (healVal * 0.1)) + random(healVal * 0.2)), 0, true, false, false);
                }
                var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 10, obj_vfx);
                vfx.sprite_index = spr_HealPulse;
                vfx.image_speed = 0;
                vfx.image_xscale = 2.5;
                vfx.image_yscale = 2.5;
                vfx.image_alpha = 0.8;
                vfx.alarm[0] = 1;
                vfx.alarm[1] = 1;
                vfx.growthSpeed = 0.05;
                arg1.healTimer = arg1.maxTimer;
            }
        }
    },
    
    config: 
    {
        healTimer: 120,
        maxTimer: 120,
        range: 200
    }
};
behaviours.healBoss = 
{
    Script: function(arg0, arg1)
    {
        var healTimer;
        with (arg0)
        {
            if (arg1.healTimer > 0)
            {
                arg1.healTimer--;
            }
            else
            {
                if (arg0.isEnemy)
                {
                    var targets = ds_list_create();
                    var enemiesList = collision_circle_list(arg0.x, arg0.y, arg1.range, obj_Enemy, true, true, targets, false);
                    if (enemiesList > 0)
                    {
                        for (var i = 0; i < enemiesList; i++)
                        {
                            if (variable_instance_exists(ds_list_find_value(targets, i), "name") && string_count("Yagoo", ds_list_find_value(targets, i).name) == 0)
                            {
                                var healVal = min(2000, ds_list_find_value(targets, i).HP * 0.1);
                                if (ds_list_find_value(targets, i).id != "GoldenYagoo" && ds_list_find_value(targets, i).id != "SilverYagoo")
                                {
                                    Heal(ds_list_find_value(targets, i), floor((healVal - (healVal * 0.1)) + random(healVal * 0.2)), 0, true, false, false);
                                }
                            }
                        }
                    }
                }
                else if (point_distance(arg0.x, arg0.y, obj_Player.x, obj_Player.y) < arg1.range)
                {
                    var healVal = obj_Player.HP * 0.1;
                    Heal(227, floor((healVal - (healVal * 0.1)) + random(healVal * 0.2)), 0, true, false, false);
                }
                var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 10, obj_vfx);
                vfx.sprite_index = spr_HealPulse;
                vfx.image_speed = 0;
                vfx.image_xscale = 3;
                vfx.image_yscale = 3;
                vfx.image_alpha = 0.8;
                vfx.alarm[0] = 1;
                vfx.alarm[1] = 1;
                vfx.growthSpeed = 0.06;
                arg1.healTimer = arg1.maxTimer;
            }
        }
    },
    
    config: 
    {
        healTimer: 300,
        maxTimer: 300,
        range: 300
    }
};
behaviours.debuffATK = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (arg0.isEnemy)
            {
                if (instance_exists(obj_Player))
                {
                    if (point_distance(arg0.x, arg0.y, obj_Player.x, obj_Player.y) < arg1.range)
                    {
                        obj_AttackController.ApplyBuff(227, "DebuffATK", ds_map_find_value(obj_AttackController.Buffs, "DebuffATK"), 
                        {
                            buffIcon: 857
                        });
                    }
                }
            }
        }
    },
    
    config: 
    {
        range: 150
    }
};
behaviours.debuffSPD = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (arg0.isEnemy)
            {
                if (instance_exists(obj_Player))
                {
                    if (point_distance(arg0.x, arg0.y, obj_Player.x, obj_Player.y) < arg1.range)
                    {
                        obj_AttackController.ApplyBuff(227, "DebuffSPD", ds_map_find_value(obj_AttackController.Buffs, "DebuffSPD"), 
                        {
                            buffIcon: 1544
                        });
                    }
                }
            }
        }
    },
    
    config: 
    {
        range: 150
    }
};
behaviours.DemonWhisper = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (arg1.currentTarget > 0 && instance_exists(arg1.currentTarget))
            {
                followTarget = arg1.currentTarget;
            }
            else
            {
                arg1.currentTarget = -1;
            }
            if (variable_struct_exists(arg0.buffs, "DemonWhisper"))
            {
                if (arg1.currentTarget == -1)
                {
                    var targets = ds_list_create();
                    if (instance_exists(obj_Enemy))
                    {
                        var numTargets = collision_circle_list(arg0.x, arg0.y, 300, obj_Enemy, true, true, targets, true);
                        if (numTargets > 0)
                        {
                            var randomIndex = floor(random(numTargets));
                            if (ds_list_find_value(targets, randomIndex).isEnemy)
                            {
                                arg1.currentTarget = ds_list_find_value(targets, randomIndex);
                            }
                        }
                    }
                }
            }
            else
            {
                followTarget = instance_find(obj_Player, 0);
            }
        }
    },
    
    config: 
    {
        currentTarget: -1
    }
};
behaviours.waveMovement = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (arg1.baseSPD == -1)
            {
                arg1.baseSPD = baseStats.SPD;
            }
            if (!knockbackImmune)
            {
                knockbackImmune = true;
            }
            if (arg1.lifetime == 0)
            {
                lifeTime = 360;
                origin_x = x;
                origin_y = y;
                if (arg0.direction < 90 || arg0.direction > 270)
                {
                    arg0.image_xscale = abs(arg0.image_xscale);
                }
                if (arg0.direction > 90 && arg0.direction < 270)
                {
                    arg0.image_xscale = -abs(arg0.image_xscale);
                }
            }
            origin_x += lengthdir_x(SPD, direction);
            origin_y += lengthdir_y(SPD, direction);
            x = origin_x + lengthdir_x(sin(arg1.lifetime / arg1.waveSpeed) * arg1.travelWidth, direction + 90);
            y = origin_y + lengthdir_y(sin(arg1.lifetime / arg1.waveSpeed) * arg1.travelWidth, direction + 90);
            arg1.lifetime += SPD / arg1.baseSPD;
        }
    },
    
    config: 
    {
        baseSPD: -1,
        lifetime: 0,
        travelWidth: 30,
        waveSpeed: 15
    }
};
behaviours.chargePlayer = 
{
    Script: function(arg0, arg1)
    {
        var warnTime, waitTime;
        with (arg0)
        {
            if (arg1.waitTime == 0)
            {
                tangible = false;
                if (!arg1.charged)
                {
                    if (instance_exists(obj_Player))
                    {
                        arg1.circleTime = arg1.warnTime;
                        soundPlay([165], "selfdestruct", 60, 30, false);
                        if (!variable_instance_exists(arg0, "chargingDir"))
                        {
                            chargingDir = point_direction(x, y, obj_Player.x, obj_Player.y);
                        }
                        if (arg1.chargePoint == -1)
                        {
                            arg1.chargePoint = instance_create_depth(x + lengthdir_x(1000, chargingDir), y + lengthdir_y(1000, chargingDir), depth, obj_empty);
                            arg1.chargePoint.creator = id;
                        }
                        
                        customDrawScriptBelow.chargePlayer = function(arg0)
                        {
                            var aimedDir = chargingDir;
                            draw_set_alpha(0.4 + (0.2 * sin(behaviours.chargePlayer.config.warnTime / 5)));
                            draw_set_color(make_color_rgb(255, 170, 170));
                            draw_rectangle_rotated(x, y - (5 * image_yscale), -1, (-15 * image_xscale) - 1, 1001, (15 * image_xscale) + 1, aimedDir, true);
                            draw_set_color(c_red);
                            draw_set_alpha(0.3 + (0.1 * sin(behaviours.chargePlayer.config.warnTime / 5)));
                            draw_rectangle_rotated(x, y - (5 * image_yscale), 0, -15 * image_xscale, 1000, 15 * image_xscale, aimedDir, false);
                            draw_set_alpha(1);
                        };
                    }
                }
            }
            if (arg1.warnTime > 0 && arg1.waitTime == 0)
            {
                arg1.warnTime--;
            }
            if (arg1.waitTime > 0)
            {
                arg1.waitTime--;
            }
            if (arg1.warnTime == 0 && canAttack && !arg1.charged)
            {
                arg1.charged = true;
                charging = true;
                tangible = false;
                direction = chargingDir;
                variable_struct_remove(customDrawScriptBelow, "chargePlayer");
                arg1.warnTime = -1;
                var vfx = instance_create_depth(x, y - 16, depth - 10, obj_vfx);
                vfx.sprite_index = spr_DashVFX;
                vfx.image_angle = direction;
                vfx.image_alpha = 0.85;
                vfx.image_xscale = abs(image_xscale);
                vfx.image_yscale = abs(image_xscale);
                vfx.followCharacter = id;
                vfx.offset_y = -16;
                vfx.add = true;
                vfx.duration = 60;
                soundPlay([5], "dashing", 20, 30, true);
            }
            if (arg1.charged && instance_exists(arg1.chargePoint) && point_distance(x, y, arg1.chargePoint.x, arg1.chargePoint.y) < 25)
            {
                if (instance_exists(arg1.chargePoint))
                {
                    arg1.chargePoint.Die();
                }
                Die(true, false);
            }
            else if (arg1.charged)
            {
                mask_index = spr_dashMask;
                knockbackImmune = true;
                if (instance_exists(arg1.chargePoint))
                {
                    obj_MobManager.MoveToPosition(arg1.chargePoint, self);
                }
                else
                {
                    Die(true, false);
                }
            }
        }
    },
    
    config: 
    {
        waitTime: 30,
        warnTime: 40,
        rectTime: 0,
        damage: 0.5,
        charged: false,
        chargePoint: -1
    }
};
behaviours.chargeStraight = 
{
    Script: function(arg0, arg1)
    {
        var warnTime, waitTime;
        with (arg0)
        {
            if (arg1.waitTime == 0)
            {
                tangible = false;
                if (!arg1.charged)
                {
                    soundPlay([165], "selfdestruct", 60, 30, false);
                    
                    customDrawScriptBelow.chargeStraight = function(arg0)
                    {
                        var aimedDir = direction;
                        draw_set_alpha(0.4 + (0.2 * sin(behaviours.chargeStraight.config.warnTime / 5)));
                        draw_set_color(make_color_rgb(255, 170, 170));
                        draw_rectangle_rotated(x, y - (5 * image_yscale), -1, (-15 * image_xscale) - 1, 1001, (15 * image_xscale) + 1, aimedDir, true);
                        draw_set_color(c_red);
                        draw_set_alpha(0.3 + (0.1 * sin(behaviours.chargeStraight.config.warnTime / 5)));
                        draw_rectangle_rotated(x, y - (5 * image_yscale), 0, -15 * image_xscale, 1000, 15 * image_xscale, aimedDir, false);
                        draw_set_alpha(1);
                    };
                }
            }
            if (arg1.warnTime > 0 && arg1.waitTime == 0)
            {
                arg1.warnTime--;
            }
            if (arg1.waitTime > 0)
            {
                arg1.waitTime--;
            }
            if (arg1.warnTime == 0 && canAttack && !arg1.charged)
            {
                arg1.charged = true;
                charging = true;
                tangible = false;
                arg1.chargePoint = 
                {
                    x: arg0.x + lengthdir_x(600, arg0.direction),
                    y: arg0.y + lengthdir_y(600, arg0.direction)
                };
                variable_struct_remove(customDrawScriptBelow, "chargeStraight");
                arg1.warnTime = -1;
                var vfx = instance_create_depth(x, y - 16, depth - 10, obj_vfx);
                vfx.sprite_index = spr_DashVFX;
                vfx.image_angle = direction;
                vfx.image_alpha = 0.85;
                vfx.image_xscale = abs(image_xscale);
                vfx.image_yscale = abs(image_xscale);
                vfx.followCharacter = id;
                vfx.offset_y = -16;
                vfx.add = true;
                vfx.duration = 60;
                soundPlay([5], "dashing", 20, 30, true);
            }
            if (arg1.charged && point_distance(x, y, arg1.chargePoint.x, arg1.chargePoint.y) < 25)
            {
                Die(true, false);
            }
            else if (arg1.charged)
            {
                mask_index = spr_dashMask;
                knockbackImmune = true;
                if (arg1.chargePoint != -1)
                {
                    obj_MobManager.MoveToPosition(arg1.chargePoint, self);
                }
                else
                {
                    Die(true, false);
                }
            }
        }
    },
    
    config: 
    {
        waitTime: 30,
        warnTime: 40,
        rectTime: 0,
        damage: 0.5,
        charged: false,
        chargePoint: -1
    }
};
behaviours.selfDestruct = 
{
    Script: function(arg0, arg1)
    {
        var warnTime;
        with (arg0)
        {
            if (!arg1.exploded)
            {
                if (instance_exists(obj_Player))
                {
                    if (point_distance(obj_Player.x, obj_Player.y, x, y) < arg1.radius || arg1.immediateTrigger)
                    {
                        arg1.exploded = true;
                        arg1.circleTime = arg1.warnTime;
                        soundPlay([165], "selfdestruct", 60, 30, false);
                        
                        customDrawScriptBelow.SelfDestruct = function(arg0)
                        {
                            draw_set_alpha(0.4 + (0.2 * sin(behaviours.selfDestruct.config.warnTime / 5)));
                            draw_set_color(make_color_rgb(255, 170, 170));
                            draw_circle(x, y, behaviours.selfDestruct.config.radius + 1, true);
                            draw_set_color(c_red);
                            draw_set_alpha(1);
                            draw_circle(x, y, behaviours.selfDestruct.config.radius * (1 - (behaviours.selfDestruct.config.warnTime / behaviours.selfDestruct.config.circleTime)), true);
                            draw_set_alpha(0.3 + (0.1 * sin(behaviours.selfDestruct.config.warnTime / 5)));
                            draw_circle(x, y, behaviours.selfDestruct.config.radius, false);
                            draw_set_alpha(1);
                        };
                    }
                }
            }
            if (arg1.warnTime == 0)
            {
                obj_AttackController.ExecuteAttack("SelfDestruct", id, 
                {
                    damage: arg1.damage,
                    radius: arg1.radius
                });
                var explod = instance_create_depth(x, y, depth - 1, obj_vfx);
                explod.sprite_index = spr_Explosion;
                explod.image_alpha = 0.8;
                explod.image_xscale = arg1.radius / 50;
                explod.image_yscale = arg1.radius / 50;
                Die(false, false);
            }
            if (arg1.exploded)
            {
                if (arg1.warnTime > 0)
                {
                    arg1.warnTime--;
                }
            }
        }
    },
    
    config: 
    {
        radius: 60,
        warnTime: 90,
        circleTime: 0,
        damage: 0.5,
        exploded: false,
        immediateTrigger: false
    }
};
behaviours.timedSelfDestruct = 
{
    Script: function(arg0, arg1)
    {
        var explodeTime, warnTime;
        with (arg0)
        {
            if (!arg1.init)
            {
                if (inView)
                {
                    arg1.init = true;
                }
            }
            if (arg1.init)
            {
                customDrawScriptAbove.timedSelfDestructTimer = function(arg0)
                {
                    draw_set_halign(fa_center);
                    draw_set_font(excluded_big);
                    draw_text_outline(x, y - 120, string(arg0.behaviours.timedSelfDestruct.config.explodeTime div 60), 1, 0, 6, 12, 100, make_color_rgb(255, 60, 60), 0.7 + (0.1 * sin(behaviours.timedSelfDestruct.config.explodeTime / 5)));
                };
                
                if (arg1.explodeTime > 0)
                {
                    arg1.explodeTime--;
                    if ((arg1.explodeTime % 60) == 0)
                    {
                        soundPlay([154], "countdown", 30, 100, false);
                        if (arg1.explodeTime <= 360)
                        {
                            obj_Cam.ExecuteShake(120, 3);
                        }
                    }
                }
                if (!arg1.exploded)
                {
                    if (instance_exists(obj_Player))
                    {
                        if (arg1.explodeTime == 900)
                        {
                            arg1.exploded = true;
                            arg1.circleTime = arg1.warnTime;
                            soundPlay([165], "timedSelfDestruct", 60, 30, false);
                            
                            customDrawScriptBelow.timedtimedSelfDestruct = function(arg0)
                            {
                                draw_set_alpha(0.4 + (0.2 * sin(behaviours.timedSelfDestruct.config.warnTime / 5)));
                                draw_set_color(make_color_rgb(255, 170, 170));
                                draw_circle(x, y, behaviours.timedSelfDestruct.config.radius + 1, true);
                                draw_set_color(c_red);
                                draw_set_alpha(1);
                                draw_circle(x, y, behaviours.timedSelfDestruct.config.radius * (1 - (behaviours.timedSelfDestruct.config.warnTime / behaviours.timedSelfDestruct.config.circleTime)), true);
                                draw_set_alpha(0.3 + (0.1 * sin(behaviours.timedSelfDestruct.config.warnTime / 5)));
                                draw_circle(x, y, behaviours.timedSelfDestruct.config.radius, false);
                                draw_set_alpha(1);
                            };
                        }
                    }
                }
                if (arg1.warnTime == 0)
                {
                    obj_AttackController.ExecuteAttack("SelfDestruct", id, 
                    {
                        damage: arg1.damage,
                        radius: arg1.radius
                    });
                    var explod = instance_create_depth(x, y, depth - 1, obj_vfx);
                    explod.sprite_index = spr_Explosion;
                    explod.image_alpha = 0.8;
                    explod.image_xscale = arg1.radius / 50;
                    explod.image_yscale = arg1.radius / 50;
                    obj_PlayerManager.ExecuteFlash();
                    Die(false, false);
                }
                if (arg1.exploded)
                {
                    if (arg1.warnTime > 0)
                    {
                        arg1.warnTime--;
                    }
                }
            }
        }
    },
    
    config: 
    {
        explodeTime: 1800,
        radius: 60,
        warnTime: 900,
        circleTime: 0,
        damage: 0.75,
        exploded: false,
        init: false
    }
};
behaviours.endlessTimedSelfDestruct = 
{
    Script: function(arg0, arg1)
    {
        var explodeTime, warnTime;
        with (arg0)
        {
            if (!arg1.init)
            {
                if (inView)
                {
                    arg1.init = true;
                }
            }
            if (arg1.init)
            {
                customDrawScriptAbove.endlessTimedSelfDestruct = function(arg0)
                {
                    draw_set_halign(fa_center);
                    draw_set_font(excluded_big);
                    draw_text_outline(x, y - 120, string(arg0.behaviours.endlessTimedSelfDestruct.config.explodeTime div 60), 1, 0, 6, 12, 100, make_color_rgb(255, 60, 60), 0.7 + (0.1 * sin(behaviours.endlessTimedSelfDestruct.config.explodeTime / 5)));
                };
                
                if (arg1.explodeTime > 0)
                {
                    arg1.explodeTime--;
                    if ((arg1.explodeTime % 60) == 0)
                    {
                        soundPlay([154], "countdown", 30, 100, false);
                        if (arg1.explodeTime <= 360)
                        {
                            obj_Cam.ExecuteShake(120, 3);
                        }
                    }
                }
                if (!arg1.exploded)
                {
                    if (instance_exists(obj_Player))
                    {
                        if (arg1.explodeTime == 900)
                        {
                            arg1.exploded = true;
                            arg1.circleTime = arg1.warnTime;
                            soundPlay([165], "timedSelfDestruct", 60, 30, false);
                            
                            customDrawScriptBelow.endlessTimedSelfDestruct = function(arg0)
                            {
                                draw_set_alpha(0.4 + (0.2 * sin(behaviours.endlessTimedSelfDestruct.config.warnTime / 5)));
                                draw_set_color(make_color_rgb(255, 170, 170));
                                draw_circle(x, y, behaviours.endlessTimedSelfDestruct.config.radius + 1, true);
                                draw_set_color(c_red);
                                draw_set_alpha(1);
                                draw_circle(x, y, behaviours.endlessTimedSelfDestruct.config.radius * (1 - (behaviours.endlessTimedSelfDestruct.config.warnTime / behaviours.endlessTimedSelfDestruct.config.circleTime)), true);
                                draw_set_alpha(0.3 + (0.1 * sin(behaviours.endlessTimedSelfDestruct.config.warnTime / 5)));
                                draw_circle(x, y, behaviours.endlessTimedSelfDestruct.config.radius, false);
                                draw_set_alpha(1);
                            };
                        }
                    }
                }
                if (arg1.warnTime == 0)
                {
                    obj_AttackController.ExecuteAttack("SelfDestruct", id, 
                    {
                        damage: arg1.damage,
                        radius: arg1.radius
                    });
                    var explod = instance_create_depth(x, y, depth - 1, obj_vfx);
                    explod.sprite_index = spr_Explosion;
                    explod.image_alpha = 0.8;
                    explod.image_xscale = arg1.radius / 50;
                    explod.image_yscale = arg1.radius / 50;
                    obj_PlayerManager.ExecuteFlash();
                    arg1.explodeTime = 1020;
                    arg1.exploded = false;
                    arg1.warnTime = 900;
                }
                if (arg1.exploded)
                {
                    if (arg1.warnTime > 0)
                    {
                        arg1.warnTime--;
                    }
                }
            }
        }
    },
    
    config: 
    {
        explodeTime: 905,
        radius: 60,
        warnTime: 900,
        circleTime: 0,
        damage: 0.75,
        exploded: false,
        init: false
    }
};
behaviours.moveRandom = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (!instance_exists(obj_Player))
            {
                return false;
            }
            if (canMove)
            {
                if (firstMove)
                {
                    if (arg0.id == "GoldenYagoo")
                    {
                        coinValue = floor(coinValue + (((global.time[UnknownEnum.Value_1] div 5) - 1) * coinValue * 0.5));
                        hitNumber = floor(hitNumber + (((global.time[UnknownEnum.Value_1] div 5) - 1) * hitNumber));
                    }
                    else if (arg0.id == "SilverYagoo")
                    {
                        coinValue = floor(coinValue + (((global.time[UnknownEnum.Value_1] div 3) - 1) * coinValue * 0.5));
                        hitNumber = floor(hitNumber + (((global.time[UnknownEnum.Value_1] div 3) - 1) * hitNumber));
                    }
                    newPointX = obj_Player.x;
                    newPointY = obj_Player.y;
                    firstMove = false;
                    changeDirectionTime = 60;
                }
                if (point_distance(arg0.x, arg0.y, newPointX, newPointY) < 20)
                {
                    changeDirectionTime = 180;
                    var ranDir = irandom(359);
                    newPointX = obj_Player.x + lengthdir_x(50 + irandom(270), ranDir);
                    newPointY = obj_Player.y + lengthdir_y(50 + irandom(270), ranDir);
                }
                else if (changeDirectionTime == 0)
                {
                    changeDirectionTime = 180;
                    var ranDir = irandom(359);
                    newPointX = obj_Player.x + lengthdir_x(50 + irandom(270), ranDir);
                    newPointY = obj_Player.y + lengthdir_y(50 + irandom(270), ranDir);
                }
                else
                {
                    changeDirectionTime--;
                }
                obj_MobManager.MoveToPosition(
                {
                    x: newPointX,
                    y: newPointY
                }, self);
            }
        }
    },
    
    config: {}
};
behaviours.moveStraight = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            tangible = false;
            direction = arg1.direction;
            speed = SPD;
            knockbackImmune = true;
        }
    },
    
    config: 
    {
        direction: 0
    }
};
behaviours.powerScaling = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
        }
    },
    
    config: {}
};
behaviours.timeScaling = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
        }
    },
    
    config: {}
};
behaviours.fireLaser = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (inView && canAttack && canSpecial)
            {
                attackTime--;
                if (attackTime <= 0)
                {
                    obj_AttackController.ExecuteAttack("Fubulaser", id);
                    attackTime = 90 + irandom(210);
                }
            }
        }
    },
    
    config: {}
};
behaviours.fireLaser2 = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (inView && canAttack && canSpecial)
            {
                attackTime--;
                if (attackTime <= 0)
                {
                    obj_AttackController.ExecuteAttack("Fubulaser2", id);
                    attackTime = 180 + irandom(180);
                }
            }
        }
    },
    
    config: {}
};
behaviours.fireBreath = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (inView && canAttack && canSpecial && arg0.followTarget != -4)
            {
                attackTime--;
                attackTime2--;
                if (attackTime <= 0)
                {
                    obj_AttackController.ExecuteAttack("MikoFireBreath", id);
                    attackTime = 540 + irandom(300);
                }
                if (attackTime2 <= 15 && (attackTime2 % 5) == 0)
                {
                    obj_AttackController.ExecuteAttack("MikodanyeLava", id);
                    if (attackTime2 == 0)
                    {
                        attackTime2 = 360 + irandom(240);
                    }
                }
            }
        }
    },
    
    config: {}
};
behaviours.throwBeaker = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (inView && canAttack && canSpecial && arg0.followTarget != -4)
            {
                attackTime2--;
                if (attackTime2 <= 20 && (attackTime2 % 5) == 0)
                {
                    obj_AttackController.ExecuteAttack("PoisonBeaker", id);
                    if (attackTime2 == 0)
                    {
                        attackTime2 = 180 + irandom(240);
                    }
                }
            }
        }
    },
    
    config: {}
};
behaviours.chainsaw = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (inView && canAttack && canSpecial && arg0.followTarget != -4)
            {
                attackTime2--;
                if (attackTime2 == 0)
                {
                    obj_AttackController.ExecuteAttack("EnemySlash", arg0, 
                    {
                        faceCreatorDirection: false,
                        sprite_index: spr_CalliSlash1,
                        direction: arg0.directionMoving,
                        image_angle: arg0.directionMoving,
                        image_xscale: 1.6,
                        image_yscale: 1.6,
                        starty: -40,
                        spriteColor: make_color_rgb(255, 88, 150),
                        afterImageColor: 255
                    });
                    if (attackTime2 == 0)
                    {
                        attackTime2 = 150 + irandom(100);
                    }
                }
            }
        }
    },
    
    config: {}
};
behaviours.risusaurusFire = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (inView && canAttack && canSpecial && arg0.followTarget != -4)
            {
                attackTime--;
                if (attackTime <= 0)
                {
                    obj_AttackController.ExecuteAttack("RisuFireBreath", id);
                    attackTime = 480 + irandom(300);
                }
            }
        }
    },
    
    config: {}
};
behaviours.groundPound = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            arg0.customDrawScriptBelow.groundPound = function(arg0)
            {
                if (arg0.giantShadow)
                {
                    draw_set_alpha(0.4);
                    draw_set_color(c_black);
                    draw_ellipse(arg0.shadowX - 120, arg0.shadowY - 66.66, arg0.shadowX + 120, arg0.shadowY + 66.66, false);
                }
            };
            
            if (inView && canAttack && canSpecial && arg0.followTarget != -4)
            {
                if (attackTime > 0)
                {
                    attackTime--;
                }
                if (attackTime == 0)
                {
                    canMove = false;
                    canAttack = false;
                    invincible = true;
                    sprite_index = spr_SmollAme_jump;
                    soundPlay([67], "amegroundpound", 10, 30);
                    image_index = 0;
                    jumpTime = 0;
                    attackTime = -1;
                }
            }
            var player = instance_find(obj_Player, 0);
            if (instance_exists(player))
            {
                if (sprite_index == spr_SmollAme_jump)
                {
                    if (floor(image_index) >= 9)
                    {
                        jumpTime++;
                        canAttack = false;
                        canMove = false;
                        giantShadow = true;
                        knockbackImmune = true;
                        mask_index = spr_emptyMask;
                        image_speed = 0;
                        if (player.x > x)
                        {
                            x += (0.5 + (8 * (1 - min(1, jumpTime / 60))));
                        }
                        else if (player.x < x)
                        {
                            x -= (0.5 + (8 * (1 - min(1, jumpTime / 60))));
                        }
                        if (player.y > shadowY)
                        {
                            y += (0.5 + (8 * (1 - min(1, jumpTime / 60))));
                        }
                        else if (player.y < shadowY)
                        {
                            y -= (0.5 + (8 * (1 - min(1, jumpTime / 60))));
                        }
                    }
                    if (jumpTime >= 230)
                    {
                        sprite_index = spr_SmollAme_groundpound;
                        image_speed = sprite_get_speed(769) / 24;
                        image_index = 0;
                        inAir = false;
                        canMove = false;
                        giantShadow = false;
                        jumpTime = -1;
                    }
                }
                else if (sprite_index == spr_SmollAme_groundpound)
                {
                    if (floor(image_index) == 2 && groundPoundMake)
                    {
                        obj_AttackController.ExecuteAttack("AmeGroundPound", id);
                        var fx = instance_create_depth(x, y, depth + 10, obj_vfx);
                        fx.sprite_index = spr_smokeeffect1;
                        fx.image_alpha = 0.8;
                        fx.image_xscale = 3;
                        fx.image_yscale = 3;
                        obj_Cam.ExecuteShake(70, 4);
                        groundPoundMake = false;
                        soundPlay([8], "amegroundpound", 10, 30);
                        invincible = false;
                    }
                    if (floor(image_index) >= 17)
                    {
                        sprite_index = spr_SmollAme_walk;
                        image_index = 0;
                        mask_index = spr_SmollAme_hitbox;
                        giantShadow = false;
                        inAir = false;
                        canAttack = true;
                        canMove = true;
                        attackTime = 180 + irandom(210);
                        knockbackImmune = false;
                        groundPoundMake = true;
                    }
                }
            }
        }
    },
    
    config: {}
};
behaviours.groundPound2 = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, warnTime, lifetime;
        with (arg0)
        {
            if (arg1.attackTime > 0 && !arg1.attack3ing)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attack3ing)
            {
                if (arg1.targetLoc == -1)
                {
                    arg1.targetLoc = instance_create_depth(obj_Player.x, obj_Player.y, depth, obj_marker);
                    arg1.targetLoc.initTime = 90;
                    arg1.targetLoc.srad = 130;
                    audio_play_sound(snd_enemyAttack, 50, false);
                }
                if (arg1.warnTime > 0)
                {
                    arg1.warnTime--;
                }
                if (arg1.warnTime == 0 && canSpecial && !arg1.jumped)
                {
                    canMove = false;
                    dontMove = true;
                    arg1.jumped = true;
                    canAttack = false;
                    invincible = true;
                    invincibilityTimer = 999;
                    sprite_index = spr_PumpkinAme_jump;
                    soundPlay([67], "amegroundpound", 10, 30);
                    image_index = 0;
                    image_speed = 0;
                    jumpTime = 0;
                    self.attackTime = -1;
                    arg1.lifetime = 0;
                    arg1.attackTime = -1;
                }
            }
            if (arg1.jumped)
            {
                if (arg1.lifetime >= 0 && arg1.lifetime <= 60)
                {
                    y -= 50;
                }
                if (arg1.lifetime == 60)
                {
                    x = arg1.targetLoc.x;
                    y = arg1.targetLoc.y - 300;
                }
                if (arg1.lifetime > 60 && arg0.y < arg1.targetLoc.y && !arg1.landed)
                {
                    y += 50;
                    image_index = 1;
                }
                if (arg1.lifetime > 60 && arg0.y >= arg1.targetLoc.y && !arg1.landed)
                {
                    arg0.y = arg1.targetLoc.y;
                    arg1.landed = true;
                    sprite_index = spr_PumpkinAme_groundpound;
                    image_speed = 1;
                    image_index = 0;
                    obj_AttackController.ExecuteAttack("EHGroundPound", id, 
                    {
                        ratio: 1
                    });
                    var fx = instance_create_depth(x, y, depth + 10, obj_vfx);
                    fx.sprite_index = spr_smokeeffect1;
                    fx.image_alpha = 0.8;
                    fx.image_xscale = 3;
                    fx.image_yscale = 3;
                    obj_Cam.ExecuteShake(70, 4);
                    groundPoundMake = false;
                    soundPlay([8], "amegroundpound", 10, 30);
                    var vfx = instance_create_depth(arg0.x, arg0.y, 450, obj_vfx);
                    vfx.sprite_index = spr_groundcrack;
                    vfx.duration = 120;
                    vfx.image_xscale = 3;
                    vfx.image_yscale = 3;
                    vfx.image_alpha = 0.8;
                    vfx.alarm[1] = 90;
                    var player = instance_find(obj_Player, 0);
                    var rockWarning = instance_create_depth(player.x, player.y, depth, obj_marker);
                    rockWarning.initTime = 65;
                    rockWarning.srad = 65;
                    rockWarning.stationary = true;
                    obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                    {
                        x: player.x,
                        setY: player.y,
                        y: player.y - 300,
                        waitTime: 65
                    });
                    for (var i = 0; i < 3; i++)
                    {
                        var randomX = -150 + irandom(300);
                        var randomY = -150 + irandom(300);
                        rockWarning = instance_create_depth(player.x + randomX, player.y + randomY, depth, obj_marker);
                        rockWarning.initTime = 65;
                        rockWarning.srad = 65;
                        rockWarning.stationary = true;
                        obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                        {
                            x: player.x + randomX,
                            setY: player.y + randomY,
                            y: (player.y + randomY) - 300,
                            waitTime: 65
                        });
                    }
                    for (var i = 0; i < 4; i++)
                    {
                        var randomX = -300 + irandom(600);
                        var randomY = -200 + irandom(400);
                        rockWarning = instance_create_depth(arg0.x + randomX, arg0.y + randomY, depth, obj_marker);
                        rockWarning.initTime = 65;
                        rockWarning.srad = 65;
                        rockWarning.stationary = true;
                        obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                        {
                            x: arg0.x + randomX,
                            setY: arg0.y + randomY,
                            y: (arg0.y + randomY) - 300,
                            waitTime: 65
                        });
                    }
                }
                if (arg1.lifetime == 150)
                {
                    sprite_index = spr_PumpkinAme;
                    image_index = 0;
                    dontMove = false;
                    canMove = true;
                    canAttack = true;
                    arg1.lifetime = 0;
                    arg1.warnTime = 90;
                    invincible = false;
                    arg1.landed = false;
                    invincibilityTimer = 1;
                    arg1.attackTime = 180 + irandom(240);
                    arg1.jumped = false;
                    with (arg1.targetLoc)
                    {
                        instance_destroy();
                    }
                    arg1.targetLoc = -1;
                }
                arg1.lifetime++;
            }
        }
    },
    
    config: 
    {
        attackTime: 240,
        lifetime: 0,
        warnTime: 80,
        jumped: false,
        targetLoc: -1,
        shootingTime: -1,
        shootingRound: 0,
        attackTime2: 90,
        landed: false,
        canAttack2: true,
        attack2Count: 6,
        spawnTimer: 120,
        aeTimer: 1,
        enrage: false,
        attack3ing: false,
        attack3Done: false,
        attack3CD: 180,
        attack3Count: 15,
        attack3Delay: 60,
        attack3Time: 400
    }
};
behaviours.aChanAttacks = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount, attackTime2, attackTime3, attack3Delay, attack3Count, attack3CD, attackTime4, attack4Delay, attackCount4;
        with (arg0)
        {
            if (arg1.attackTime > 0 && !arg1.attacking3 && !arg1.attacking4)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1 && !arg1.attacking3 && !arg1.attacking4)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("AChanBullet1", arg0);
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 120;
                    arg1.shotCount = 7;
                    arg1.attacking1 = false;
                }
            }
            if (arg1.attackTime2 > 0 && !arg1.attacking3 && !arg1.attacking4)
            {
                arg1.attackTime2--;
            }
            if (arg1.attackTime2 == 0 && !arg1.attacking3 && !arg1.attacking4)
            {
                for (var i = 0; i < 10; i++)
                {
                    obj_AttackController.ExecuteAttack("AChanBullet2", arg0, 
                    {
                        direction: i * 36
                    });
                }
                arg1.attackTime2 = 150 + irandom(150);
            }
            if (arg1.attackTime3 > 0 && !arg1.attacking4)
            {
                arg1.attackTime3--;
            }
            if (arg1.attackTime3 == 0 && !arg1.attacking3)
            {
                obj_PlayerManager.Dank(600);
                arg1.attacking3 = true;
            }
            if (arg1.attack3Delay > 0)
            {
                arg1.attack3Delay--;
            }
            if (arg1.attacking3)
            {
                arg0.behaviours.aChanMovement.config.stop = true;
                if (arg1.attack3Count > 0)
                {
                    if (arg1.attack3Delay == 0)
                    {
                        for (var i = 0; i < 10; i++)
                        {
                            if ((arg1.attack3Count % 2) == 0)
                            {
                                obj_AttackController.ExecuteAttack("AChanBullet3", arg0, 
                                {
                                    direction: i * 36
                                });
                            }
                            else
                            {
                                obj_AttackController.ExecuteAttack("AChanBullet4", arg0, 
                                {
                                    direction: i * 36
                                });
                            }
                        }
                        arg1.attack3Delay = 40;
                        arg1.attack3Count--;
                    }
                }
                else
                {
                    arg1.attack3Done = true;
                }
            }
            if (arg1.attack3Done)
            {
                if (arg1.attack3CD > 0)
                {
                    arg1.attack3CD--;
                }
                else
                {
                    arg1.attacking3 = false;
                    arg0.behaviours.aChanMovement.config.stop = false;
                    arg1.attack3CD = 180 + irandom(120);
                    arg1.attack3Done = false;
                    arg1.attack3Delay = 0;
                    arg1.attack3Count = 15;
                    arg1.attackTime3 = 600 + irandom(180);
                }
            }
            if (arg1.attackTime4 > 0 && !arg1.attacking3)
            {
                arg1.attackTime4--;
            }
            if (arg1.attackTime4 == 0 && !arg1.attacking4)
            {
                arg1.attacking4 = true;
                obj_PlayerManager.Dank(600);
                arg1.attack4Dir = point_direction(x, y, obj_Player.x, obj_Player.y);
            }
            if (arg1.attacking4 && arg1.attack4Delay > 0)
            {
                arg1.attack4Delay--;
            }
            if (arg1.attacking4)
            {
                arg0.behaviours.aChanMovement.config.stop = true;
                if (arg1.attackCount4 > 0)
                {
                    if (arg1.attack4Delay == 0)
                    {
                        obj_AttackController.ExecuteAttack("AChanBullet5", arg0, 
                        {
                            direction: arg1.attack4Dir,
                            starty: -32
                        });
                        arg1.attack4Dir -= 3;
                        arg1.attack4Delay = 4;
                        arg1.attackCount4--;
                    }
                }
                else
                {
                    arg1.attacking4 = false;
                    arg0.behaviours.aChanMovement.config.stop = false;
                    arg1.attack4Delay = 120;
                    arg1.attack4Dir = 270;
                    arg1.attackCount4 = 120;
                    arg1.attackTime4 = 600 + irandom(180);
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 120,
        attackTime2: 150,
        attacking1: false,
        shotCount: 7,
        attackTime3: 600,
        attacking3: false,
        attack3Count: 15,
        attack3Delay: 0,
        attack3Done: false,
        attack3CD: 180,
        attacking4: false,
        attackTime4: 900,
        attackCount4: 120,
        attack4Dir: 270,
        attack4Delay: 120
    }
};
behaviours.aChanMovement = 
{
    Script: function(arg0, arg1)
    {
        with (arg0)
        {
            if (origin_x == -1)
            {
                origin_x = x;
                origin_y = y;
            }
            if (!arg1.stop)
            {
                if (!instance_exists(obj_Player))
                {
                    return false;
                }
                if (origin_x != obj_Player.x)
                {
                    origin_x += ((obj_Player.x - origin_x) * 0.01);
                }
                if (origin_y != obj_Player.y)
                {
                    origin_y += ((obj_Player.y - origin_y) * 0.01);
                }
                direction = point_direction(x, y, obj_Player.x, obj_Player.y);
                if (arg0.direction < 90 || arg0.direction > 270)
                {
                    arg0.image_xscale = abs(arg0.image_xscale);
                }
                if (arg0.direction > 90 && arg0.direction < 270)
                {
                    arg0.image_xscale = -abs(arg0.image_xscale);
                }
                x = origin_x + (sin(arg1.lifetime / (arg1.waveSpeed * 2)) * arg1.travelWidth);
                y = origin_y + (sin(arg1.lifetime / arg1.waveSpeed) * arg1.travelHeight);
                arg1.lifetime += SPD;
            }
        }
    },
    
    config: 
    {
        lifetime: 0,
        travelWidth: 280,
        travelHeight: 120,
        waveSpeed: 50,
        stop: false
    }
};
behaviours.NodokaAttacks = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount, attackTime2, attackTime3, attack3Delay, attack3Count, attack3CD, attackTime4, attack4Delay, attackCount4, aeTimer;
        with (arg0)
        {
            if (arg1.attackTime > 0 && !arg1.attacking3 && !arg1.attacking4)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1 && !arg1.attacking3 && !arg1.attacking4)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("AChanBullet1", arg0, 
                    {
                        speed: 6
                    });
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 90 - (arg1.enrage * 10);
                    arg1.shotCount = 9 + (arg1.enrage * 3);
                    arg1.attacking1 = false;
                }
            }
            if (arg1.attackTime2 > 0 && !arg1.attacking3 && !arg1.attacking4)
            {
                arg1.attackTime2--;
            }
            if (arg1.attackTime2 == 0 && !arg1.attacking3 && !arg1.attacking4)
            {
                obj_AttackController.ExecuteAttack("Fubulaser2", id, 
                {
                    starty: -10,
                    beamHeight: 10,
                    turnRate: 0.3
                });
                arg1.attackTime2 = 150 + irandom(150);
            }
            if (arg1.attackTime3 > 0 && !arg1.attacking4)
            {
                arg1.attackTime3--;
            }
            if (arg1.attackTime3 == 0 && !arg1.attacking3)
            {
                obj_PlayerManager.Dank(600);
                audio_play_sound(snd_enemyAttack, 50, false);
                arg1.attacking3 = true;
            }
            if (arg1.attack3Delay > 0)
            {
                arg1.attack3Delay--;
            }
            if (arg1.attacking3)
            {
                arg0.behaviours.aChanMovement.config.stop = true;
                if (arg1.attack3Count > 0)
                {
                    if (arg1.attack3Delay == 15)
                    {
                        for (var i = 0; i < (10 + (arg1.enrage * 2)); i++)
                        {
                            obj_AttackController.ExecuteAttack("AChanBullet2", arg0, 
                            {
                                speed: 2,
                                direction: (i * (360 / (10 + (arg1.enrage * 2)))) + (arg1.attack3Count * 5)
                            });
                        }
                    }
                    if (arg1.attack3Delay == 0)
                    {
                        for (var i = 0; i < (10 + (arg1.enrage * 2)); i++)
                        {
                            obj_AttackController.ExecuteAttack("AChanBullet3", arg0, 
                            {
                                speed: 2.5,
                                direction: (i * (360 / (10 + (arg1.enrage * 2)))) + (arg1.attack3Count * 5)
                            });
                            obj_AttackController.ExecuteAttack("AChanBullet4", arg0, 
                            {
                                speed: 2.5,
                                direction: (i * (360 / (10 + (arg1.enrage * 2)))) + (arg1.attack3Count * 5)
                            });
                        }
                        arg1.attack3Delay = 30;
                        arg1.attack3Count--;
                    }
                }
                else
                {
                    arg1.attack3Done = true;
                }
            }
            if (arg1.attack3Done)
            {
                if (arg1.attack3CD > 0)
                {
                    arg1.attack3CD--;
                }
                else
                {
                    arg1.attacking3 = false;
                    arg0.behaviours.aChanMovement.config.stop = false;
                    arg1.attack3CD = 180 + irandom(120);
                    arg1.attack3Done = false;
                    arg1.attack3Delay = 0;
                    arg1.attack3Count = 15;
                    arg1.attackTime3 = 600 + irandom(180);
                }
            }
            if (arg1.attackTime4 > 0 && !arg1.attacking3)
            {
                arg1.attackTime4--;
            }
            if (arg1.attackTime4 == 0 && !arg1.attacking4)
            {
                arg1.attacking4 = true;
                obj_PlayerManager.Dank(900);
                audio_play_sound(snd_enemyAttack, 50, false);
                arg1.attack4Dir = point_direction(x, y, obj_Player.x, obj_Player.y);
            }
            if (arg1.attacking4 && arg1.attack4Delay > 0)
            {
                arg1.attack4Delay--;
            }
            if (arg1.attacking4)
            {
                arg0.behaviours.aChanMovement.config.stop = true;
                if (arg1.attackCount4 > 0)
                {
                    if (arg1.attack4Delay == 0)
                    {
                        obj_AttackController.ExecuteAttack("NodokaBullet1", arg0, 
                        {
                            direction: arg1.attack4Dir,
                            starty: -32
                        });
                        obj_AttackController.ExecuteAttack("NodokaBullet1", arg0, 
                        {
                            direction: arg1.attack4Dir,
                            waveDir: -1,
                            starty: -32
                        });
                        for (var i = 0; i < (5 + (arg1.enrage * 2)); i++)
                        {
                            obj_AttackController.ExecuteAttack("AChanBullet2", arg0, 
                            {
                                speed: 1.75,
                                direction: (i * (360 / (5 + (arg1.enrage * 2)))) + (arg1.attackCount4 * 10)
                            });
                        }
                        arg1.attack4Dir -= 30;
                        arg1.attack4Delay = 6 - arg1.enrage;
                        arg1.attackCount4--;
                    }
                }
                else
                {
                    arg1.attacking4 = false;
                    arg0.behaviours.aChanMovement.config.stop = false;
                    arg1.attack4Delay = 120;
                    arg1.attack4Dir = 270;
                    arg1.attackCount4 = 100;
                    arg1.attackTime4 = 600 + irandom(180);
                }
            }
            if (currentHP < (HP / 2))
            {
                if (!arg1.enrage)
                {
                    arg1.enrage = true;
                    audio_play_sound(snd_bossenrage, 50, false);
                }
            }
            if (arg1.aeTimer > 0 && arg1.enrage)
            {
                arg1.aeTimer--;
            }
            else if (arg1.enrage)
            {
                arg1.aeTimer = 3;
                var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                afterimage.sprite_index = arg0.sprite_index;
                afterimage.image_speed = 0;
                afterimage.image_index = arg0.image_index;
                afterimage.image_xscale = arg0.image_xscale;
                afterimage.image_yscale = arg0.image_yscale;
                afterimage.afterimage_color = 32768;
                afterimage.image_angle = arg0.image_angle;
                afterimage.image_alpha = 0.8;
                afterimage.grow = true;
                afterimage.growthRate = 0.25;
            }
        }
    },
    
    config: 
    {
        attackTime: 100,
        attackTime2: 150,
        attacking1: false,
        shotCount: 9,
        attackTime3: 600,
        attacking3: false,
        attack3Count: 15,
        attack3Delay: 0,
        attack3Done: false,
        attack3CD: 180,
        attacking4: false,
        attackTime4: 900,
        attackCount4: 100,
        attack4Dir: 270,
        attack4Delay: 120,
        aeTimer: 0,
        enrage: false
    }
};
behaviours.homingDash = 
{
    Script: function(arg0, arg1)
    {
        var timer, dashingWarnTimer, stoppingCD;
        with (arg0)
        {
            if (!canSpecial)
            {
                exit;
            }
            if (!variable_instance_exists(arg0, "idleSprite"))
            {
                arg0.idleSprite = arg0.sprite_index;
            }
            if (followTarget == -4)
            {
                if (!arg1.dashing)
                {
                    lockFacing = true;
                    sprite_index = idleSprite;
                    arg1.stopping = false;
                    arg1.dashing = false;
                    arg1.dashingWarnTimer = 60;
                    arg1.stoppingCD = 40;
                    arg0.dontMove = false;
                    canAttack = true;
                    arg1.timer = 60 + irandom(240);
                    if (arg1.chargePoint > -1)
                    {
                        with (arg1.chargePoint)
                        {
                            Die();
                        }
                    }
                    arg1.chargePoint = -1;
                    exit;
                }
            }
            if (!arg1.dashingBegin && !arg1.dashing)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    dontMove = true;
                    arg1.dashingBegin = true;
                    arg1.dashingWarnTimer = 60;
                    var warning = instance_create_depth(x, y, depth - 500, obj_cautionattack);
                    warning.followPlayerID = arg0;
                }
            }
            else
            {
                if (!arg1.dashing)
                {
                    if (arg1.dashingWarnTimer > 0)
                    {
                        arg1.dashingWarnTimer--;
                        if (arg1.dashingWarnTimer == arg1.dashDelay)
                        {
                            var predictPosition = [followTarget.x, followTarget.y];
                            var further = 
                            {
                                x: lengthdir_x(300, point_direction(x, y, predictPosition[0], predictPosition[1])),
                                y: lengthdir_y(300, point_direction(x, y, predictPosition[0], predictPosition[1] + (16 * image_yscale)))
                            };
                            var target = instance_create_depth(predictPosition[0] + further.x, predictPosition[1] + further.y, followTarget.depth, obj_empty);
                            arg1.chargePoint = target;
                            arg1.chargePoint.creator = id;
                        }
                    }
                    else
                    {
                        arg1.dashing = true;
                        arg1.dashingBegin = false;
                        arg1.currentSPD = arg1.dashSPD;
                        lockFacing = false;
                        soundPlay([5], "enemyJump", 20, 0);
                        if (arg1.dashSprite != -1)
                        {
                            sprite_index = arg1.dashSprite;
                        }
                        arg0.dontMove = true;
                    }
                }
                if (arg1.dashing && !arg1.stopping && instance_exists(arg1.chargePoint) && point_distance(x, y, arg1.chargePoint.x, arg1.chargePoint.y) < 150)
                {
                    arg1.stopping = true;
                    arg1.stoppingCD = 40;
                }
                else if (arg1.stopping && arg1.dashing)
                {
                    arg1.currentSPD *= 0.85;
                    if (arg1.stoppingCD > 0)
                    {
                        arg1.stoppingCD--;
                    }
                }
                if (arg1.dashing || arg1.stopping)
                {
                    if (instance_exists(arg1.chargePoint))
                    {
                        obj_MobManager.MoveToPosition(arg1.chargePoint, self, arg1.currentSPD);
                    }
                    if (arg1.stomp)
                    {
                        soundPlay([296], "dashingstomp", 25, 0, true);
                    }
                }
                if (arg1.stoppingCD == 0 && arg1.dashing)
                {
                    lockFacing = true;
                    sprite_index = idleSprite;
                    arg1.stopping = false;
                    arg1.dashing = false;
                    arg1.dashingWarnTimer = 60;
                    arg1.stoppingCD = 40;
                    arg0.dontMove = false;
                    canAttack = true;
                    arg1.timer = 90 + irandom(360);
                    with (arg1.chargePoint)
                    {
                        Die();
                    }
                    arg1.chargePoint = -1;
                }
            }
        }
    },
    
    config: 
    {
        timer: 180,
        dashingBegin: false,
        dashing: false,
        dashingWarnTimer: 60,
        stopping: false,
        stoppingCD: 40,
        currentSPD: 0,
        chargePoint: -1,
        dashSprite: -1,
        dashSPD: 20,
        stomp: false,
        dashDelay: 25
    }
};
behaviours.projectileAttack = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount;
        with (arg0)
        {
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1 && followTarget != -4)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("EnemyBullet", arg0);
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 120;
                    arg1.shotCount = 1;
                    arg1.attacking1 = false;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 120,
        attackTime2: 150,
        attacking1: false,
        shotCount: 1
    }
};
behaviours.projectileAttackBoss = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount;
        with (arg0)
        {
            if (!canAttack)
            {
                exit;
            }
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1 && followTarget != -4)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("EnemyBullet", arg0, 
                    {
                        x: arg0.x,
                        y: arg0.y - (15 * image_yscale),
                        depth: arg0.depth - 50
                    });
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 120;
                    arg1.shotCount = 3;
                    arg1.attacking1 = false;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 120,
        attackTime2: 150,
        attacking1: false,
        shotCount: 3
    }
};
behaviours.projectileAttackBoss2 = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount;
        with (arg0)
        {
            if (!canAttack)
            {
                exit;
            }
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1 && followTarget != -4)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    for (var i = 0; i < 10; i++)
                    {
                        obj_AttackController.ExecuteAttack("AChanBullet5", arg0, 
                        {
                            x: arg0.x,
                            y: arg0.y - (15 * image_yscale),
                            direction: (i * 36) + (arg1.shotCount * 10),
                            projSpeed: 5,
                            depth: arg0.depth - 50
                        });
                    }
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 200;
                    arg1.shotCount = arg1.maxCount;
                    arg1.attacking1 = false;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 200,
        attacking1: false,
        shotCount: 3,
        maxCount: 3
    }
};
behaviours.projectileAttackBoss3 = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount;
        with (arg0)
        {
            if (!canAttack)
            {
                exit;
            }
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1 && followTarget != -4)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("EnemyBullet", arg0, 
                    {
                        x: arg0.x,
                        y: arg0.y - (15 * image_yscale),
                        depth: arg0.depth - 50
                    });
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 120;
                    arg1.shotCount = 5;
                    arg1.attacking1 = false;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 120,
        attackTime2: 150,
        attacking1: false,
        shotCount: 5
    }
};
behaviours.projectileAttackSlow = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount;
        with (arg0)
        {
            if (!canAttack)
            {
                exit;
            }
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1 && followTarget != -4)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("EnemyBullet", arg0);
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 300 + irandom(100);
                    arg1.shotCount = 1;
                    arg1.attacking1 = false;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 80 + irandom(60),
        attackTime2: 300,
        attacking1: false,
        shotCount: 1
    }
};
behaviours.shieldRecover = 
{
    Script: function(arg0, arg1)
    {
        var timer;
        with (arg0)
        {
            if (arg1.timer == 0)
            {
                shieldHP = arg1.maxShield;
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        }
    },
    
    config: 
    {
        timer: 600,
        maxTimer: 600,
        maxShield: 100
    }
};
behaviours.projectileAttackRapid = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, shotCount;
        with (arg0)
        {
            if (!canAttack)
            {
                exit;
            }
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attacking1 && followTarget != -4)
            {
                arg1.attacking1 = true;
            }
            if (arg1.attacking1)
            {
                if (arg1.attackTime == 0 && arg1.shotCount > 0)
                {
                    obj_AttackController.ExecuteAttack("EnemyBullet", arg0);
                    arg1.attackTime = 8;
                    arg1.shotCount--;
                }
                if (arg1.shotCount == 0)
                {
                    arg1.attackTime = 90 + irandom(30);
                    arg1.shotCount = 1;
                    arg1.attacking1 = false;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 30,
        attackTime2: 60,
        attacking1: false,
        shotCount: 1
    }
};
behaviours.backflip = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, warnTime, lifetime, shootingTime, shootingRound, attackTime2, attack2Count, spawnTimer, aeTimer;
        with (arg0)
        {
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0)
            {
                if (arg1.targetLoc == -1)
                {
                    arg1.targetLoc = instance_create_depth(obj_Player.x, obj_Player.y, depth, obj_marker);
                    arg1.targetLoc.initTime = 90;
                    arg1.targetLoc.srad = 120;
                    audio_play_sound(snd_enemyAttack, 50, false);
                }
                if (arg1.warnTime > 0)
                {
                    arg1.warnTime--;
                }
                if (arg1.warnTime == 0 && canSpecial && !arg1.jumped)
                {
                    canMove = false;
                    arg1.jumped = true;
                    canAttack = false;
                    invincible = true;
                    invincibilityTimer = 999;
                    sprite_index = spr_Bae3D_backflip;
                    soundPlay([67], "amegroundpound", 10, 30);
                    image_index = 0;
                    jumpTime = 0;
                    self.attackTime = -1;
                    arg1.lifetime = 0;
                    arg1.attackTime = -1;
                }
            }
            if (arg1.jumped)
            {
                if (arg1.lifetime >= 15 && arg1.lifetime <= 57)
                {
                    direction = point_direction(arg0.x, arg0.y, arg1.targetLoc.x, arg1.targetLoc.y);
                    x += lengthdir_x(abs(arg1.targetLoc.x - arg0.x) * 0.1, direction);
                    y += lengthdir_y(abs(arg1.targetLoc.y - arg0.y) * 0.1, direction);
                }
                if (arg1.lifetime == 57)
                {
                    obj_AttackController.ExecuteAttack("BaeGroundPound", id, 
                    {
                        ratio: 1
                    });
                    var fx = instance_create_depth(x, y, depth + 10, obj_vfx);
                    fx.sprite_index = spr_smokeeffect1;
                    fx.image_alpha = 0.8;
                    fx.image_xscale = 3;
                    fx.image_yscale = 3;
                    obj_Cam.ExecuteShake(70, 4);
                    groundPoundMake = false;
                    soundPlay([8], "amegroundpound", 10, 30);
                    arg1.shootingTime = 1;
                    arg1.shootingRound = 6 + (arg1.enrage * 4);
                }
                if (arg1.lifetime == 92)
                {
                    sprite_index = spr_Bae3D_walk;
                    image_index = 0;
                    canMove = true;
                    canAttack = true;
                    arg1.lifetime = 0;
                    arg1.warnTime = 90;
                    invincible = false;
                    invincibilityTimer = 1;
                    arg1.attackTime = 180 + irandom(240);
                    arg1.jumped = false;
                    with (arg1.targetLoc)
                    {
                        instance_destroy();
                    }
                    arg1.targetLoc = -1;
                }
                arg1.lifetime++;
            }
            if (arg1.shootingTime > 0 && arg1.shootingRound > 0)
            {
                arg1.shootingTime--;
            }
            if (arg1.shootingTime == 0)
            {
                if (arg1.shootingRound > 0)
                {
                    var roundDir = arg1.shootingRound * 30;
                    for (var i = 0; i < 15; i++)
                    {
                        obj_AttackController.ExecuteAttack("Bae3DBullet", id, 
                        {
                            direction: roundDir + (24 * i)
                        });
                    }
                    arg1.shootingRound--;
                    arg1.shootingTime = 9;
                }
                if (arg1.shootingRound == 0)
                {
                    arg1.shootingRound = 0;
                    arg1.shootingTime = -1;
                }
            }
            if (arg1.attackTime2 > 0 && !arg1.jumped)
            {
                arg1.attackTime2--;
            }
            if (arg1.attackTime2 == 0 && !arg1.jumped)
            {
                if (arg1.attack2Count > 0)
                {
                    obj_AttackController.ExecuteAttack("AChanBullet1", arg0, 
                    {
                        x: arg0.x,
                        y: arg0.y - 100
                    });
                    arg1.attackTime2 = 8;
                    arg1.attack2Count--;
                }
                if (arg1.attack2Count == 0)
                {
                    arg1.attackTime2 = 90;
                    arg1.attack2Count = 5 + (arg1.enrage * 5);
                }
            }
            if (arg1.spawnTimer > 0 && !arg1.jumped && arg1.enrage)
            {
                arg1.spawnTimer--;
            }
            if (arg1.spawnTimer == 0 && !arg1.jumped)
            {
                var randomAmount = 1 + irandom(2);
                for (var i = 0; i < randomAmount; i++)
                {
                    var pos = 
                    {
                        x: (obj_Player.x - 50) + irandom(100),
                        y: (obj_Player.y - 50) + irandom(100)
                    };
                    obj_MobManager.SpawnMob("Rats", pos, 5, 
                    {
                        HP: 5000,
                        image_xscale: 1.5,
                        image_yscale: 1.5
                    }, 90, 50);
                }
                arg1.spawnTimer = 300 + irandom(180);
            }
            if (currentHP < (HP / 2))
            {
                if (!arg1.enrage)
                {
                    arg1.enrage = true;
                    audio_play_sound(snd_bossenrage, 50, false);
                }
            }
            if (arg1.aeTimer > 0 && arg1.enrage)
            {
                arg1.aeTimer--;
            }
            else if (arg1.enrage)
            {
                arg1.aeTimer = 3;
                var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                afterimage.sprite_index = arg0.sprite_index;
                afterimage.image_speed = 0;
                afterimage.image_index = arg0.image_index;
                afterimage.image_xscale = arg0.image_xscale;
                afterimage.image_yscale = arg0.image_yscale;
                afterimage.afterimage_color = 4235519;
                afterimage.image_angle = arg0.image_angle;
                afterimage.image_alpha = 0.8;
                afterimage.grow = true;
                afterimage.growthRate = 0.1;
            }
        }
    },
    
    config: 
    {
        attackTime: 240,
        lifetime: 0,
        warnTime: 90,
        jumped: false,
        targetLoc: -1,
        shootingTime: -1,
        shootingRound: 0,
        attackTime2: 90,
        attack2Count: 5,
        spawnTimer: 120,
        aeTimer: 1,
        enrage: false
    }
};
behaviours.groundPunch = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, warnTime, lifetime;
        with (arg0)
        {
            if (arg1.attackTime > 0)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && canSpecial)
            {
                if (arg1.targetLoc == -1)
                {
                    arg1.targetLoc = instance_create_depth(arg0.x, arg0.y, depth, obj_marker);
                    arg1.targetLoc.initTime = 130;
                    arg1.targetLoc.srad = 250;
                    arg1.targetLoc.stationary = true;
                    audio_play_sound(snd_enemyAttack, 50, false);
                    sprite_index = spr_Shubangelion_attack_start;
                    image_index = 0;
                    canMove = false;
                    dontMove = true;
                    canAttack = false;
                }
                if (arg1.warnTime > 0)
                {
                    arg1.warnTime--;
                }
                if (arg1.warnTime <= 119)
                {
                    sprite_index = spr_Shubangelion_attack_charge;
                }
                if (arg1.warnTime == 0 && !arg1.punched)
                {
                    arg1.punched = true;
                    self.attackTime = -1;
                    arg1.lifetime = 0;
                    arg1.attackTime = -1;
                    sprite_index = spr_Shubangelion_attack_punch;
                    image_index = 0;
                }
            }
            if (arg1.punched && arg1.lifetime == 15)
            {
                obj_AttackController.ExecuteAttack("ShubangelionSmash", arg0.id, 
                {
                    ratio: 1
                });
                var fx = instance_create_depth(x, y, depth + 10, obj_vfx);
                fx.sprite_index = spr_smokeeffect1;
                fx.image_alpha = 0.8;
                fx.image_xscale = 3;
                fx.image_yscale = 3;
                obj_Cam.ExecuteShake(90, 5);
                groundPoundMake = false;
                soundPlay([8], "amegroundpound", 10, 30);
                arg1.shootingTime = 1;
                arg1.shootingRound = 6 + (arg1.enrage * 4);
                var vfx = instance_create_depth(arg0.x, arg0.y, 450, obj_vfx);
                vfx.sprite_index = spr_groundcrack;
                vfx.duration = 120;
                vfx.image_xscale = 2;
                vfx.image_yscale = 2;
                vfx.image_alpha = 0.8;
                vfx.alarm[1] = 90;
                vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 1, obj_vfx);
                vfx.sprite_index = spr_bombExplode;
                vfx.image_xscale = 4;
                vfx.image_yscale = 4;
                vfx.image_alpha = 0.7;
            }
            if (arg1.punched && arg1.lifetime == 45)
            {
                var player = instance_find(obj_Player, 0);
                var rockWarning = instance_create_depth(player.x, player.y, depth, obj_marker);
                rockWarning.initTime = 65;
                rockWarning.srad = 65;
                rockWarning.stationary = true;
                obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                {
                    x: player.x,
                    setY: player.y,
                    y: player.y - 300,
                    waitTime: 65
                });
                for (var i = 0; i < 4; i++)
                {
                    var randomX = -150 + irandom(300);
                    var randomY = -150 + irandom(300);
                    rockWarning = instance_create_depth(player.x + randomX, player.y + randomY, depth, obj_marker);
                    rockWarning.initTime = 65;
                    rockWarning.srad = 65;
                    rockWarning.stationary = true;
                    obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                    {
                        x: player.x + randomX,
                        setY: player.y + randomY,
                        y: (player.y + randomY) - 300,
                        waitTime: 65
                    });
                }
                for (var i = 0; i < 4; i++)
                {
                    var randomX = -300 + irandom(600);
                    var randomY = -200 + irandom(400);
                    rockWarning = instance_create_depth(arg0.x + randomX, arg0.y + randomY, depth, obj_marker);
                    rockWarning.initTime = 65;
                    rockWarning.srad = 65;
                    rockWarning.stationary = true;
                    obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                    {
                        x: arg0.x + randomX,
                        setY: arg0.y + randomY,
                        y: (arg0.y + randomY) - 300,
                        waitTime: 65
                    });
                }
            }
            if (arg1.punched && arg1.lifetime >= 80)
            {
                sprite_index = spr_Shubangelion_walk;
                image_index = 0;
                dontMove = false;
                canMove = true;
                canAttack = true;
                arg1.lifetime = 0;
                arg1.punched = false;
                arg1.warnTime = 130;
                arg1.attackTime = 300 + irandom(150);
                with (arg1.targetLoc)
                {
                    instance_destroy();
                }
                arg1.targetLoc = -1;
            }
            if (arg1.punched)
            {
                arg1.lifetime++;
            }
        }
    },
    
    config: 
    {
        attackTime: 300,
        lifetime: 0,
        targetLoc: -1,
        warnTime: 130,
        begunAttack: false,
        punched: false,
        shootingTime: -1,
        shootingRound: 0,
        attackTime2: 90,
        attack2Count: 5,
        spawnTimer: 120,
        aeTimer: 1,
        enrage: false
    }
};
behaviours.eldrichhaachama = 
{
    Script: function(arg0, arg1)
    {
        var attackTime, warnTime, lifetime, shootingTime, shootingRound, attackTime2, attack3Time, attack3Count, attack3Delay, attack3CD, attack2Count;
        with (arg0)
        {
            if (arg1.attackTime > 0 && !arg1.attack3ing)
            {
                arg1.attackTime--;
            }
            if (arg1.attackTime == 0 && !arg1.attack3ing)
            {
                if (arg1.targetLoc == -1)
                {
                    arg1.targetLoc = instance_create_depth(obj_Player.x, obj_Player.y, depth, obj_marker);
                    arg1.targetLoc.initTime = 90;
                    arg1.targetLoc.srad = 130;
                    audio_play_sound(snd_enemyAttack, 50, false);
                }
                if (arg1.warnTime > 0)
                {
                    arg1.warnTime--;
                }
                if (arg1.warnTime == 0 && canSpecial && !arg1.jumped)
                {
                    canMove = false;
                    dontMove = true;
                    arg1.jumped = true;
                    canAttack = false;
                    arg1.canAttack2 = false;
                    invincible = true;
                    invincibilityTimer = 999;
                    sprite_index = spr_EldrichHaachama_jump;
                    soundPlay([67], "amegroundpound", 10, 30);
                    image_index = 0;
                    jumpTime = 0;
                    self.attackTime = -1;
                    arg1.lifetime = 0;
                    arg1.attackTime = -1;
                }
            }
            if (arg1.jumped)
            {
                if (arg1.lifetime >= 0 && arg1.lifetime <= 60)
                {
                    y -= 50;
                }
                if (arg1.lifetime == 60)
                {
                    x = arg1.targetLoc.x;
                    y = arg1.targetLoc.y - 300;
                }
                if (arg1.lifetime > 60 && arg0.y < arg1.targetLoc.y && !arg1.landed)
                {
                    y += 50;
                }
                if (arg1.lifetime > 60 && arg0.y >= arg1.targetLoc.y && !arg1.landed)
                {
                    arg0.y = arg1.targetLoc.y;
                    arg1.landed = true;
                    sprite_index = spr_EldrichHaachama_land;
                    image_index = 0;
                    obj_AttackController.ExecuteAttack("EHGroundPound", id, 
                    {
                        ratio: 1
                    });
                    var fx = instance_create_depth(x, y, depth + 10, obj_vfx);
                    fx.sprite_index = spr_smokeeffect1;
                    fx.image_alpha = 0.8;
                    fx.image_xscale = 3;
                    fx.image_yscale = 3;
                    obj_Cam.ExecuteShake(70, 4);
                    groundPoundMake = false;
                    soundPlay([8], "amegroundpound", 10, 30);
                    var vfx = instance_create_depth(arg0.x, arg0.y, 450, obj_vfx);
                    vfx.sprite_index = spr_groundcrack;
                    vfx.duration = 120;
                    vfx.image_xscale = 3;
                    vfx.image_yscale = 3;
                    vfx.image_alpha = 0.8;
                    vfx.alarm[1] = 90;
                    var player = instance_find(obj_Player, 0);
                    var rockWarning = instance_create_depth(player.x, player.y, depth, obj_marker);
                    rockWarning.initTime = 65;
                    rockWarning.srad = 65;
                    rockWarning.stationary = true;
                    obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                    {
                        x: player.x,
                        setY: player.y,
                        y: player.y - 300,
                        waitTime: 65
                    });
                    for (var i = 0; i < 3; i++)
                    {
                        var randomX = -150 + irandom(300);
                        var randomY = -150 + irandom(300);
                        rockWarning = instance_create_depth(player.x + randomX, player.y + randomY, depth, obj_marker);
                        rockWarning.initTime = 65;
                        rockWarning.srad = 65;
                        rockWarning.stationary = true;
                        obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                        {
                            x: player.x + randomX,
                            setY: player.y + randomY,
                            y: (player.y + randomY) - 300,
                            waitTime: 65
                        });
                    }
                    for (var i = 0; i < 4; i++)
                    {
                        var randomX = -300 + irandom(600);
                        var randomY = -200 + irandom(400);
                        rockWarning = instance_create_depth(arg0.x + randomX, arg0.y + randomY, depth, obj_marker);
                        rockWarning.initTime = 65;
                        rockWarning.srad = 65;
                        rockWarning.stationary = true;
                        obj_AttackController.ExecuteAttack("ShubangelionRocks", arg0.id, 
                        {
                            x: arg0.x + randomX,
                            setY: arg0.y + randomY,
                            y: (arg0.y + randomY) - 300,
                            waitTime: 65
                        });
                    }
                }
                if (arg1.lifetime == 150)
                {
                    sprite_index = spr_EldrichHaachama_walk;
                    image_index = 0;
                    dontMove = false;
                    canMove = true;
                    canAttack = true;
                    arg1.lifetime = 0;
                    arg1.canAttack2 = true;
                    arg1.warnTime = 90;
                    invincible = false;
                    arg1.landed = false;
                    invincibilityTimer = 1;
                    arg1.attackTime = 180 + irandom(240);
                    arg1.jumped = false;
                    with (arg1.targetLoc)
                    {
                        instance_destroy();
                    }
                    arg1.targetLoc = -1;
                }
                arg1.lifetime++;
            }
            if (arg1.shootingTime > 0 && arg1.shootingRound > 0)
            {
                arg1.shootingTime--;
            }
            if (arg1.shootingTime == 0)
            {
                if (arg1.shootingRound > 0)
                {
                    var roundDir = arg1.shootingRound * 30;
                    for (var i = 0; i < 15; i++)
                    {
                        obj_AttackController.ExecuteAttack("Bae3DBullet", id, 
                        {
                            direction: roundDir + (24 * i)
                        });
                    }
                    arg1.shootingRound--;
                    arg1.shootingTime = 9;
                }
                if (arg1.shootingRound == 0)
                {
                    arg1.shootingRound = 0;
                    arg1.shootingTime = -1;
                }
            }
            if (arg1.attackTime2 > 0 && !arg1.jumped)
            {
                arg1.attackTime2--;
            }
            if (arg1.attack3Time > 0 && !arg1.attack3ing && !arg1.jumped && arg1.attackTime > 0)
            {
                arg1.attack3Time--;
            }
            if (arg1.attack3Time == 0 && !arg1.attack3ing && !arg1.jumped && arg1.attackTime > 0)
            {
                arg1.attack3ing = true;
                sprite_index = spr_EldrichHaachama_scream;
                image_index = 0;
                dontMove = true;
                canMove = false;
                arg1.canAttack2 = false;
                obj_PlayerManager.Dank(600);
                soundPlay([29], "snd_eldrichscream", 10, 30);
            }
            if (arg1.attack3Count > 0 && arg1.attack3ing)
            {
                if (arg1.attack3Delay == 0)
                {
                    for (var i = 0; i < 16; i++)
                    {
                        obj_AttackController.ExecuteAttack("AChanBullet3", arg0, 
                        {
                            direction: (i * 22.5) + (arg1.attack3Count * 7),
                            x: arg0.x,
                            y: arg0.y - 30,
                            speed: 2.75,
                            damage: 0.065
                        });
                    }
                    arg1.attack3Delay = 30;
                    arg1.attack3Count--;
                }
                else
                {
                    arg1.attack3Delay--;
                }
            }
            else if (arg1.attack3ing)
            {
                arg1.attack3Done = true;
            }
            if (arg1.attack3Done)
            {
                if (arg1.attack3CD > 0)
                {
                    arg1.attack3CD--;
                }
                else
                {
                    sprite_index = spr_EldrichHaachama_walk;
                    image_index = 0;
                    dontMove = false;
                    canMove = true;
                    canAttack = true;
                    arg1.attack3ing = false;
                    arg1.canAttack2 = true;
                    arg1.attack3CD = 180 + irandom(120);
                    arg1.attack3Done = false;
                    arg1.attack3Delay = 60;
                    arg1.attack3Count = 15;
                    arg1.attack3Time = 500 + irandom(180);
                }
            }
            if (arg1.attackTime2 == 0 && !arg1.jumped && arg1.canAttack2)
            {
                if (arg1.attack2Count > 0)
                {
                    obj_AttackController.ExecuteAttack("AChanBullet1", arg0, 
                    {
                        x: arg0.x,
                        y: arg0.y - 45,
                        projSpeed: 9
                    });
                    arg1.attackTime2 = 7;
                    arg1.attack2Count--;
                }
                if (arg1.attack2Count == 0)
                {
                    arg1.attackTime2 = 90;
                    arg1.attack2Count = 6;
                }
            }
        }
    },
    
    config: 
    {
        attackTime: 240,
        lifetime: 0,
        warnTime: 80,
        jumped: false,
        targetLoc: -1,
        shootingTime: -1,
        shootingRound: 0,
        attackTime2: 90,
        landed: false,
        canAttack2: true,
        attack2Count: 6,
        spawnTimer: 120,
        aeTimer: 1,
        enrage: false,
        attack3ing: false,
        attack3Done: false,
        attack3CD: 180,
        attack3Count: 15,
        attack3Delay: 60,
        attack3Time: 400
    }
};
behaviours.horde = 
{
    Script: function(arg0, arg1)
    {
        var passes;
        with (arg0)
        {
            if (canMove)
            {
                if (variable_struct_names_count(waypoint) == 0)
                {
                    runTime = 0;
                    if (!instance_exists(obj_Player))
                    {
                        return false;
                    }
                    direction = point_direction(arg0.x, arg0.y, obj_Player.x, obj_Player.y);
                    waypoint = 
                    {
                        x: obj_Player.x + lengthdir_x(400, direction),
                        y: obj_Player.y + lengthdir_y(400, direction)
                    };
                    var group = variable_struct_get(obj_StageManager.controlGroups, arg0.name);
                    group = group[arg0.groupNumber];
                    var keys = variable_struct_get_names(group);
                    for (var i = 0; i < array_length(keys); i++)
                    {
                        var member = variable_struct_get(group, keys[i]);
                        if (instance_exists(member))
                        {
                            member.direction = direction;
                        }
                    }
                }
                else
                {
                    runTime++;
                    speed = SPD * 2;
                    if (direction < 90 || direction > 270)
                    {
                        image_xscale = abs(image_xscale);
                    }
                    if (direction > 90 && direction < 270)
                    {
                        image_xscale = -abs(image_xscale);
                    }
                    if (distance_to_point(waypoint.x, waypoint.y) < 200 && arg1.passes >= 0)
                    {
                        arg1.passes--;
                    }
                }
                if (arg1.passes < 0 && !arg0.inView && runTime > 120)
                {
                    Die(true);
                }
            }
        }
    },
    
    config: 
    {
        passes: 0
    }
};

hordeOnCreate = function(arg0)
{
    var name = arg0.name;
    if (!variable_struct_exists(obj_StageManager.controlGroups, name))
    {
        variable_struct_set(obj_StageManager.controlGroups, name, []);
    }
    var group = variable_struct_get(obj_StageManager.controlGroups, name);
    var groupNumber = 0;
    if (variable_instance_exists(arg0, "groupNumber"))
    {
        groupNumber = arg0.groupNumber;
    }
    else
    {
        arg0.groupNumber = 0;
    }
    if ((array_length(group) - 1) < groupNumber)
    {
        array_push(group, {});
    }
    var subGroup = group[groupNumber];
    variable_struct_set(subGroup, arg0, arg0);
    arg0.onDeath = 
    {
        checkIfHordeEmpty: function(arg0, arg1, arg2)
        {
            var group = variable_struct_get(obj_StageManager.controlGroups, arg1.name);
            group = group[arg1.groupNumber];
            variable_struct_remove(group, arg1.id);
            var keys = variable_struct_get_names(group);
            if (array_length(keys) == 0)
            {
                array_delete(group, arg1.groupNumber, 1);
            }
        }
    };
};

enum UnknownEnum
{
    Value_1 = 1
}
