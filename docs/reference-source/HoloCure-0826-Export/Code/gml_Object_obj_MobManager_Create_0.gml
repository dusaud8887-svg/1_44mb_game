mobAchievementCounters = {};

function SpawnMob(arg0, arg1 = 
{
    x: 0,
    y: 0
}, arg2 = 1, arg3 = {}, arg4 = 0, arg5 = 50, arg6 = false)
{
    var mobData = ds_map_find_value(Mobs, arg0);
    var config = {};
    if (IsSpawnBlocked(arg1) && !arg6)
    {
        show_debug_message("Error spawning " + arg0 + " at coordinate " + string(arg1.x) + ", " + string(arg1.y) + "\n due to mob being spawned out of bounds");
    }
    variable_struct_copy(mobData.config, config);
    variable_struct_copy(arg3, config);
    var mob = instance_create_layer(arg1.x, arg1.y, "Instances", obj_PreCreate);
    if (arg2 > 1)
    {
        if (array_length(mobData.config.levels) > 0)
        {
            variable_struct_copy(mobData.config.levels[arg2 - 2], config);
            config.level = arg2;
        }
    }
    variable_struct_copy(arg3, config);
    var keys = variable_struct_get_names(config.behaviours);
    for (var i = 0; i < array_length(keys); i++)
    {
        var behaviour = variable_struct_get(config.behaviours, keys[i]);
        if (typeof(behaviour) == "struct")
        {
            var originalBehaviour = {};
            variable_struct_copy(behaviour, originalBehaviour);
            var behaviourTemplate = variable_struct_get(obj_MobManager.behaviours, keys[i]);
            var newBehaviour = 
            {
                config: {}
            };
            variable_struct_copy(behaviourTemplate, newBehaviour);
            variable_struct_copy(originalBehaviour.config, newBehaviour.config);
            variable_struct_set(config.behaviours, keys[i], newBehaviour);
        }
        else
        {
            variable_struct_set(config.behaviours, keys[i], variable_struct_get(obj_MobManager.behaviours, keys[i]));
        }
    }
    keys = variable_struct_get_names(config);
    for (var i = 0; i < array_length(keys); i++)
    {
        if (keys[i] != "sprite_index")
        {
            variable_instance_set(mob, keys[i], variable_struct_get(config, keys[i]));
        }
    }
    with (mob)
    {
        name = arg0;
        theConfig = config;
        srad = arg5;
        
        spawnScript = function ActualSpawn(arg0, arg1, arg2 = false, arg3 = 50)
        {
            instance_change(obj_Enemy, true);
            if (is_array(arg1.sprite_index))
            {
                sprite_index = arg1.sprite_index[irandom(array_length(arg1.sprite_index) - 1)];
            }
            else
            {
                sprite_index = arg1.sprite_index;
            }
            if (arg0.isEnemy)
            {
                obj_StageManager.enemyAmount++;
            }
            var keys = variable_struct_get_names(arg1);
            for (var i = 0; i < array_length(keys); i++)
            {
                if (keys[i] != "sprite_index")
                {
                    variable_instance_set(self, keys[i], variable_struct_get(arg1, keys[i]));
                }
            }
            if (variable_instance_exists(arg0, "behaviours"))
            {
                if (variable_struct_exists(arg0.behaviours, "powerScaling"))
                {
                    ATK = power(baseStats.ATK + (2 * (max(0, global.time[1] - 23) + (37 * global.time[0]))), 1 + ((max(0, ((global.time[0] * 60) + global.time[1]) - 30) + (max(0, global.time[0] - 1) * 60)) / 25));
                    baseStats.ATK = ATK;
                    prebuffStats.ATK = ATK;
                    SPD = min(300, power(baseStats.SPD + (0.12 * (max(0, global.time[1] - 23) + (37 * global.time[0]))), 1 + ((max(0, ((global.time[0] * 60) + global.time[1]) - 30) + (max(0, global.time[0] - 1) * 60)) / 25)));
                    baseStats.SPD = SPD;
                    prebuffStats.SPD = SPD;
                    HP = power(baseStats.HP + (baseStats.HP * 0.05 * (max(0, global.time[1] - 23) + (37 * global.time[0]))), 1 + ((max(0, ((global.time[0] * 60) + global.time[1]) - 30) + (max(0, global.time[0] - 1) * 60)) / 50));
                    prebuffStats.HP = HP;
                    baseStats.HP = HP;
                    currentHP = HP;
                }
                if (variable_struct_exists(arg0.behaviours, "timeScaling"))
                {
                    if (bomber)
                    {
                        ATK = 2 + (global.time[1] * (1 + ((isBoss || miniboss) * 0.5)) * (1 - (bomber * 0.85)));
                    }
                    else
                    {
                        ATK = 2 + (global.time[1] * (1 + ((isBoss || miniboss) * 0.5)) * (1 - (shooter * 0.2)));
                    }
                    baseStats.ATK = ATK;
                    prebuffStats.ATK = ATK;
                    SPD = (0.7 + ((global.time[1] / 5) * 0.15)) * (1 + ((isBoss || miniboss) * 0.2)) * (1 - ((shooter || bomber) * 0.5));
                    baseStats.SPD = SPD;
                    prebuffStats.SPD = SPD;
                    if (isBoss || miniboss)
                    {
                        HP = round(1000 + power(1000, 1 + (global.time[1] / 25)));
                        expvalue = round(power(750, 1 + (global.time[1] / 60)));
                    }
                    else
                    {
                        HP = round(power(4, 3.6 + (global.time[1] / 8.5)) - 127);
                        expvalue = round(power(5, 1 + ((global.time[1] + (global.time[2] div 30)) / 25)));
                    }
                    prebuffStats.HP = HP;
                    baseStats.HP = HP;
                    currentHP = HP;
                    if (isBoss)
                    {
                        var size = array_length(global.allBossEnemySprites);
                        var rand = irandom(size - 1);
                        if (is_array(global.allBossEnemySprites[rand][0]))
                        {
                            sprite_index = global.allBossEnemySprites[rand][0][0];
                        }
                        else
                        {
                            sprite_index = global.allBossEnemySprites[rand][0];
                        }
                        mask_index = global.allBossEnemySprites[rand][1];
                    }
                    else if (shooter)
                    {
                        var size = array_length(global.allShooterEnemySprites);
                        var rand = irandom(size - 1);
                        if (is_array(global.allShooterEnemySprites[rand][0]))
                        {
                            sprite_index = global.allShooterEnemySprites[rand][0][0];
                        }
                        else
                        {
                            sprite_index = global.allShooterEnemySprites[rand][0];
                        }
                        mask_index = global.allShooterEnemySprites[rand][1];
                    }
                    else if (bomber)
                    {
                        var size = array_length(global.allBomberEnemySprites);
                        var rand = irandom(size - 1);
                        if (is_array(global.allBomberEnemySprites[rand][0]))
                        {
                            sprite_index = global.allBomberEnemySprites[rand][0][0];
                        }
                        else
                        {
                            sprite_index = global.allBomberEnemySprites[rand][0];
                        }
                        mask_index = global.allBomberEnemySprites[rand][1];
                    }
                    else
                    {
                        var size = array_length(global.allNormalEnemySprites);
                        var rand = irandom(size - 1);
                        if (is_array(global.allNormalEnemySprites[rand][0]))
                        {
                            sprite_index = global.allNormalEnemySprites[rand][0][0];
                        }
                        else
                        {
                            sprite_index = global.allNormalEnemySprites[rand][0];
                        }
                        mask_index = global.allNormalEnemySprites[rand][1];
                    }
                }
                if (variable_struct_exists(arg0.behaviours, "healEnemies"))
                {
                    arg0.customDrawScriptBelow.HealEnemies = function(arg0)
                    {
                        draw_set_color(c_green);
                        draw_circle(arg0.x, arg0.y - 16, arg0.behaviours.healEnemies.config.range, true);
                    };
                }
                if (variable_struct_exists(arg0.behaviours, "debuffATK"))
                {
                    arg0.customDrawScriptBelow.debuffATK = function(arg0)
                    {
                        draw_set_color(c_red);
                        draw_circle(arg0.x, arg0.y - 16, arg0.behaviours.debuffATK.config.range, true);
                    };
                }
                if (variable_struct_exists(arg0.behaviours, "debuffSPD"))
                {
                    arg0.customDrawScriptBelow.debuffSPD = function(arg0)
                    {
                        draw_set_color(c_blue);
                        draw_circle(arg0.x, arg0.y - 16, arg0.behaviours.debuffSPD.config.range, true);
                    };
                }
            }
            if (arg2)
            {
                obj_AttackController.ExecuteAttack("SelfDestruct", id, 
                {
                    damage: 0.1,
                    playSound: [73],
                    radius: image_xscale * arg3
                });
            }
            if (arg1.isBoss)
            {
                arg0.achievementTrackerTimer = 0;
                arg0.checkEffects = 1;
                
                var achievementDeathFunction = function(arg0, arg1)
                {
                    if (arg1.achievementTrackerTimer < 600)
                    {
                        if (string_count("Yagoo", arg1.name) == 0)
                        {
                            DoAchievement("obliterated");
                        }
                    }
                };
                
                var achievementStepFunction = 
                {
                    Script: function(arg0)
                    {
                        var achievementTrackerTimer;
                        arg0.achievementTrackerTimer++;
                        if (arg0.achievementTrackerTimer == 18000)
                        {
                            DoAchievement("pacifist");
                        }
                    },
                    
                    config: {}
                };
                variable_struct_set(arg0.onDeath, "achievementDeath", achievementDeathFunction);
                variable_struct_set(arg0.scripts, "achievementSurvive", achievementStepFunction);
            }
            if (arg1.achievementMap != false)
            {
                var achievementFunction = function(arg0, arg1, arg2)
                {
                    if (arg2)
                    {
                        exit;
                    }
                    var achievementCounter = obj_MobManager.mobAchievementCounters;
                    var achievementCounterKeys = variable_struct_get_names(arg1.achievementMap);
                    for (var i = 0; i < array_length(achievementCounterKeys); i++)
                    {
                        var counter = variable_struct_get(achievementCounter, achievementCounterKeys[i]);
                        if (counter == undefined)
                        {
                            continue;
                        }
                        counter--;
                        if (counter == 0)
                        {
                            DoAchievement(achievementCounterKeys[i]);
                            variable_struct_remove(achievementCounter, achievementCounterKeys[i]);
                            variable_struct_remove(ds_map_find_value(obj_MobManager.Mobs, name).config.achievementMap, achievementCounterKeys[i]);
                            if (variable_struct_names_count(ds_map_find_value(obj_MobManager.Mobs, name).config.achievementMap) < 0)
                            {
                                ds_map_find_value(obj_MobManager.Mobs, name).config.achievementMap = false;
                            }
                        }
                        else
                        {
                            variable_struct_set(achievementCounter, achievementCounterKeys[i], counter);
                        }
                    }
                    if (ds_map_find_value(obj_MobManager.Mobs, name).config.achievementMap == false)
                    {
                        var currentName = name;
                        with (obj_BaseMob)
                        {
                            if (name == currentName)
                            {
                                variable_struct_remove(onDeath, "achievementCounter");
                            }
                        }
                    }
                };
                
                variable_struct_set(arg0.onDeath, "achievementCounter", achievementFunction);
            }
        };
        
        if (arg4 == 0)
        {
            spawnScript(self, theConfig);
        }
        else
        {
            soundPlay([165], "selfdestruct", 60, 30, false);
            waitSpawn = arg4;
            initTime = waitSpawn;
        }
    }
    global.mobsSpawned++;
    return mob;
}

function IsSpawnBlocked(arg0)
{
    if (arg0.y < global.topBorder && global.topBorder != -1)
    {
        return true;
    }
    if (arg0.y > global.bottomBorder && global.bottomBorder != -1)
    {
        return true;
    }
    if (arg0.x < global.leftBorder && global.leftBorder != -1)
    {
        return true;
    }
    if (arg0.x > global.rightBorder && global.rightBorder != -1)
    {
        return true;
    }
    return false;
}

function CreateSummon(arg0, arg1 = 
{
    x: obj_Player.x,
    y: obj_Player.y
})
{
    var summonConfig = ds_map_find_value(Summons, arg0).config;
    var summonObj = instance_create_layer(arg1.x, arg1.y, "Instances", obj_PreCreate);
    variable_struct_copy(summonConfig, summonObj);
    with (summonObj)
    {
        instance_change(obj_Summon, true);
        sprite_index = summonConfig.sprite_index;
    }
    return summonObj;
}

event_user(0);
event_user(2);
event_user(1);
event_user(4);
event_user(5);
event_user(3);
event_user(15);
