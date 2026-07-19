ITEMS = ds_map_create();
SuccubusHorn = [function()
{
    playerCharacter.onKill.SuccubusHorn = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.SuccubusHorn.config.timer == 0)
        {
            var roll = irandom(9);
            if (roll >= 7)
            {
                arg0.scripts.SuccubusHorn.config.timer = arg0.scripts.SuccubusHorn.config.maxTimer;
                Heal(arg0, 2, 1, true, false, true);
            }
        }
    };
    
    playerCharacter.onTakeDamage.SuccubusHorn = function(arg0, arg1, arg2, arg3)
    {
        var roll = irandom(99);
        if (roll <= 3)
        {
            if (arg3.currentHP <= (arg3.HP * 0.15))
            {
                Heal(arg3, max(1, arg3.HP * 0.2), 0);
                arg0 = 0;
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.SuccubusHorn = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 12
        }
    };
}, function()
{
    playerCharacter.onKill.SuccubusHorn = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.SuccubusHorn.config.timer == 0)
        {
            var roll = irandom(9);
            if (roll >= 7)
            {
                arg0.scripts.SuccubusHorn.config.timer = arg0.scripts.SuccubusHorn.config.maxTimer;
                Heal(arg0, 4, 1, true, false, true);
            }
        }
    };
    
    playerCharacter.onTakeDamage.SuccubusHorn = function(arg0, arg1, arg2, arg3)
    {
        var roll = irandom(99);
        if (roll <= 3)
        {
            if (arg3.currentHP <= (arg3.HP * 0.15))
            {
                Heal(arg3, max(1, arg3.HP * 0.25), 0);
                arg0 = 0;
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.SuccubusHorn = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.SuccubusHorn.config.timer > 0)
            {
                arg0.scripts.SuccubusHorn.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 12
        }
    };
}, function()
{
    playerCharacter.onKill.SuccubusHorn = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.SuccubusHorn.config.timer == 0)
        {
            var roll = irandom(9);
            if (roll >= 7)
            {
                arg0.scripts.SuccubusHorn.config.timer = arg0.scripts.SuccubusHorn.config.maxTimer;
                Heal(arg0, 6, 1, true, false, true);
            }
        }
    };
    
    playerCharacter.onTakeDamage.SuccubusHorn = function(arg0, arg1, arg2, arg3)
    {
        var roll = irandom(99);
        if (roll <= 3)
        {
            if (arg3.currentHP <= (arg3.HP * 0.15))
            {
                Heal(arg3, max(1, arg3.HP * 0.3), 0);
                arg0 = 0;
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.SuccubusHorn = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.SuccubusHorn.config.timer > 0)
            {
                arg0.scripts.SuccubusHorn.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 12
        }
    };
}, function()
{
    playerCharacter.onKill.SuccubusHorn = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.SuccubusHorn.config.timer == 0)
        {
            var roll = irandom(9);
            if (roll >= 7)
            {
                arg0.scripts.SuccubusHorn.config.timer = arg0.scripts.SuccubusHorn.config.maxTimer;
                Heal(arg0, 6, 1, true, false, true);
                Heal(arg0, arg0.HP * 0.05, 1, true, false, true);
            }
        }
    };
    
    playerCharacter.onTakeDamage.SuccubusHorn = function(arg0, arg1, arg2, arg3)
    {
        var roll = irandom(99);
        if (roll <= 3)
        {
            if (arg3.currentHP <= (arg3.HP * 0.15))
            {
                Heal(arg3, max(1, arg3.HP * 0.3), 0);
                arg0 = 0;
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.SuccubusHorn = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.SuccubusHorn.config.timer > 0)
            {
                arg0.scripts.SuccubusHorn.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 12
        }
    };
}];

SuccubusHornRemove = function()
{
};

ds_map_set(ITEMS, "SuccubusHorn", new Item("SuccubusHorn", 
{
    optionIcon: 65,
    optionIcon_Super: 1751,
    optionName: global.TextContainer.SuccubusHornName.selectedLanguage,
    optionDescription: global.TextContainer.SuccubusHornDescription.selectedLanguage,
    itemType: "Healing",
    weight: 3
}, 3, SuccubusHorn, SuccubusHornRemove, true));

function _ApplyExtraLifeIfAvailable()
{
    if (global.lives > 1)
    {
        if (playerCharacter.canNotDie)
        {
            exit;
        }
        
        playerCharacter.Die = function(arg0 = false, arg1 = false, arg2 = undefined)
        {
            playerCharacter.OnDeath(playerCharacter, arg2);
            if (variable_struct_exists(playerCharacter.scripts, "Plushie"))
            {
                playerCharacter.scripts.Plushie.config.damageDebt = 0;
            }
            if (variable_struct_exists(playerCharacter.buffs, "UndeadPenalty"))
            {
                obj_AttackController.RemoveBuff(playerCharacter, "UndeadPenalty");
            }
            if (playerCharacter.stopDeath)
            {
                playerCharacter.stopDeath = false;
                exit;
            }
            paused = true;
            reviving = true;
            Pause();
            canControl = false;
            alarm[1] = 30;
            playerCharacter.currentHP = max(1, playerCharacter.HP / 2);
            playerCharacter.invincible = true;
            playerCharacter.invincibilityTimer = 300;
            hpSus = playerCharacter.currentHP - 1;
            with (obj_Enemy)
            {
                if (!miniboss && !isBoss)
                {
                    Die();
                }
            }
            global.lives--;
            timesRevived++;
            if (variable_struct_exists(playerCharacter.stepBuffs, "ChickensFeather"))
            {
                obj_AttackController.ApplyBuff(playerCharacter, "ChickensFeather", ds_map_find_value(obj_AttackController.Buffs, "ChickensFeather"), {});
            }
            if (global.lives == 1)
            {
                playerCharacter.Die = function(arg0 = false, arg1 = false, arg2 = undefined)
                {
                    with (playerCharacter)
                    {
                        if (isAlive)
                        {
                            OnDeath(227, arg2);
                            if (variable_struct_exists(scripts, "Plushie"))
                            {
                                scripts.Plushie.config.damageDebt = 0;
                            }
                            if (variable_struct_exists(buffs, "UndeadPenalty"))
                            {
                                obj_AttackController.RemoveBuff(playerCharacter, "UndeadPenalty");
                            }
                            if (stopDeath)
                            {
                                stopDeath = false;
                                exit;
                            }
                            part_emitter_destroy_all(global.psystem);
                            isAlive = false;
                            visible = false;
                            for (var i = 0; i < 12; i++)
                            {
                                var heart = instance_create_depth(x, y - 16, depth - 1, obj_deathHeart);
                                heart.direction = (i * 360) / 12;
                                heart.speed = 2;
                            }
                            alarm[0] = 180;
                            mask_index = spr_empty;
                        }
                    }
                };
            }
        };
    }
}

function ChickensFeatherStepBuffApply(arg0, arg1)
{
    arg0.ATK += (6 - global.lives) * 0.2;
    arg0.SPD += (6 - global.lives) * 0.1;
}

ChickensFeather = [function()
{
    if (!variable_instance_exists(227, "chickensFeatherApplied"))
    {
        obj_Player.chickensFeatherApplied = 1;
        global.lives++;
        livesGained++;
    }
}, function()
{
    if (obj_Player.chickensFeatherApplied == 1)
    {
        obj_Player.chickensFeatherApplied = 2;
        global.lives++;
        livesGained++;
    }
}, function()
{
    if (obj_Player.chickensFeatherApplied == 2)
    {
        obj_Player.chickensFeatherApplied = -1;
        global.lives++;
        livesGained++;
    }
}, function()
{
    if (!variable_instance_exists(227, "chickensFeatherApplied"))
    {
        obj_Player.chickensFeatherApplied = -1;
        global.lives += 5;
        livesGained += 5;
    }
    playerCharacter.stepBuffs.ChickensFeather = 
    {
        Apply: ChickensFeatherStepBuffApply,
        config: {}
    };
}];

ChickensFeatherRemove = function()
{
    playerCharacter.Die = function()
    {
        part_emitter_destroy_all(global.psystem);
    };
};

ds_map_set(ITEMS, "ChickensFeather", new Item("ChickensFeather", 
{
    optionIcon: 268,
    optionIcon_Super: 2270,
    optionName: global.TextContainer.ChickensFeatherName.selectedLanguage,
    optionDescription: global.TextContainer.ChickensFeatherDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 2
}, 3, ChickensFeather, ChickensFeatherRemove, true));
StudyGlasses = [function()
{
    playerCharacter.expMultiplier += 0.1;
    
    playerCharacter.onLevelUp.StudyGlasses = function(arg0, arg1)
    {
        obj_AttackController.ApplyBuff(arg0, "StudyGlasses", ds_map_find_value(obj_AttackController.Buffs, "StudyGlasses"), 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 999,
            buffIcon: 1357
        });
    };
}, function()
{
    playerCharacter.expMultiplier += 0.15;
}, function()
{
    playerCharacter.expMultiplier += 0.2;
}, function()
{
    playerCharacter.expMultiplier += 0.25;
}, function()
{
    playerCharacter.expMultiplier += 0.3;
}, function()
{
    playerCharacter.expMultiplier += 0.4;
    
    playerCharacter.onLevelUp.StudyGlasses = function(arg0, arg1)
    {
        obj_AttackController.ApplyBuff(arg0, "StudyGlasses", ds_map_find_value(obj_AttackController.Buffs, "StudyGlasses"), 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 999,
            buffIcon: 1151
        });
    };
    
    global.rainbowEXPDrop = 0.5;
}];

StudyGlassesRemove = function()
{
    playerCharacter.expMultiplier = 1;
};

ds_map_set(ITEMS, "StudyGlasses", new Item("StudyGlasses", 
{
    optionIcon: 1357,
    optionIcon_Super: 1151,
    optionName: global.TextContainer.StudyGlassesName.selectedLanguage,
    optionDescription: global.TextContainer.StudyGlassesDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 5,
    weight: 3
}, 5, StudyGlasses, StudyGlassesRemove, true));
BodyPillow = [function()
{
    playerCharacter.DR *= 0.95;
    if (!variable_struct_exists(playerCharacter.scripts, "BodyPillow"))
    {
        playerCharacter.scripts.BodyPillow = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer <= 0)
                {
                    arg0.shieldHP = arg1.shieldHP;
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: max(1, 900 * (1 / (1 + (playerCharacter.haste / 100)))),
                shieldHP: 15
            }
        };
    }
}, function()
{
    playerCharacter.DR *= 0.9;
    playerCharacter.scripts.BodyPillow.config.shieldHP = 20;
}, function()
{
    playerCharacter.DR *= 0.85;
    playerCharacter.scripts.BodyPillow.config.shieldHP = 25;
}, function()
{
    playerCharacter.DR *= 0.8;
    playerCharacter.scripts.BodyPillow.config.shieldHP = 30;
}, function()
{
    playerCharacter.DR *= 0.75;
    playerCharacter.scripts.BodyPillow.config.shieldHP = 35;
}, function()
{
    playerCharacter.DR *= 0.7;
    if (!variable_struct_exists(playerCharacter.scripts, "BodyPillow"))
    {
        playerCharacter.scripts.BodyPillow = 
        {
            Script: function(arg0, arg1)
            {
                var timer, healTimer;
                if (arg1.timer <= 0)
                {
                    arg0.shieldHP = arg1.shieldHP;
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
                if (arg0.shieldHP == arg1.shieldHP && arg1.healTimer > 0)
                {
                    arg1.healTimer--;
                }
                else if (arg0.shieldHP < arg1.shieldHP)
                {
                    arg1.healTimer = arg1.maxHealTimer;
                }
                if (arg1.healTimer == 0)
                {
                    Heal(arg0, arg1.heal, 1, true, false);
                    arg1.healTimer = arg1.maxHealTimer;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: max(1, 900 * (1 / (1 + (playerCharacter.haste / 100)))),
                shieldHP: 40,
                healTimer: 180,
                maxHealTimer: 180,
                heal: 10
            }
        };
    }
    else
    {
        playerCharacter.scripts.BodyPillow.config.shieldHP = 40;
    }
}];

BodyPillowRemove = function()
{
};

ds_map_set(ITEMS, "BodyPillow", new Item("BodyPillow", 
{
    optionIcon: 1891,
    optionIcon_Super: 853,
    optionName: global.TextContainer.BodyPillowName.selectedLanguage,
    optionDescription: global.TextContainer.BodyPillowDescription.selectedLanguage,
    itemType: "Utility",
    weight: 3
}, 5, BodyPillow, BodyPillowRemove, true));
HolyMilk = [function()
{
    playerCharacter.weaponSizeMultiplier += 0.1;
    playerCharacter.knockbackMultiplier += 0.1;
    playerCharacter.pickupRange += 30 * global.positiveEffects;
}, function()
{
    playerCharacter.weaponSizeMultiplier += 0.15;
    playerCharacter.knockbackMultiplier += 0.15;
    playerCharacter.pickupRange += 40 * global.positiveEffects;
}, function()
{
    playerCharacter.weaponSizeMultiplier += 0.2;
    playerCharacter.knockbackMultiplier += 0.2;
    playerCharacter.pickupRange += 50 * global.positiveEffects;
}, function()
{
    playerCharacter.weaponSizeMultiplier += 0.3;
    playerCharacter.knockbackMultiplier += 0.3;
    playerCharacter.pickupRange += 100 * global.positiveEffects;
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 20 * global.positiveEffects;
    }
    playerCharacter.UpdateHP();
}];

HolyMilkRemove = function()
{
};

ds_map_set(ITEMS, "HolyMilk", new Item("HolyMilk", 
{
    optionIcon: 189,
    optionIcon_Super: 449,
    optionName: global.TextContainer.HolyMilkName.selectedLanguage,
    optionDescription: global.TextContainer.HolyMilkDescription.selectedLanguage,
    itemType: "Stat",
    weight: 1
}, 3, HolyMilk, HolyMilkRemove, true));
PikiPikiPiman = [function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 15 * global.positiveEffects;
        playerCharacter.UpdateHP();
    }
    variable_struct_set(playerCharacter.onHitEffects, "MainBoost", 
    {
        divide: 6
    });
}, function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 20 * global.positiveEffects;
        playerCharacter.UpdateHP();
    }
    variable_struct_set(playerCharacter.onHitEffects, "MainBoost", 
    {
        divide: 5
    });
}, function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 25 * global.positiveEffects;
        playerCharacter.UpdateHP();
    }
    variable_struct_set(playerCharacter.onHitEffects, "MainBoost", 
    {
        divide: 4
    });
}];

PikiPikiPimanRemove = function()
{
};

ds_map_set(ITEMS, "PikiPikiPiman", new Item("PikiPikiPiman", 
{
    optionIcon: 1551,
    optionName: global.TextContainer.PikiPikiPimanName.selectedLanguage,
    optionDescription: global.TextContainer.PikiPikiPimanDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 4
}, 3, PikiPikiPiman, PikiPikiPimanRemove));
Sake = [function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 1,
        loseStackOnRemove: true
    };
    var buffConfig2 = 
    {
        weight: 5,
        buffIcon: 1882
    };
    
    playerCharacter.onHeal.Sake = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 5,
            buffIcon: 1882
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Sake2", ds_map_find_value(ac.Buffs, "Sake2"), buffConfig);
        }
        return arg0;
    };
    
    playerCharacter.scripts.Sake = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: arg1.maxStacks,
                weight: 1,
                loseStackOnRemove: true
            };
            if (arg1.timer >= arg1.maxTimer)
            {
                obj_AttackController.ApplyBuff(arg0, "Sake", ds_map_find_value(obj_AttackController.Buffs, "Sake"), buffConfig);
                arg1.timer = 0;
            }
            else
            {
                arg1.timer++;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60,
            maxStacks: 10
        }
    };
    
    playerCharacter.onTakeDamage.Sake = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        if (arg0 < 1)
        {
            return arg0;
        }
        if (variable_struct_exists(arg3.buffs, "Sake"))
        {
            var losing = floor(arg3.buffs.Sake.config.stacks / 2);
            for (var i = 0; i < losing; i++)
            {
                obj_AttackController.RemoveBuff(arg3, "Sake");
            }
        }
        arg3.scripts.Sake.config.timer = 0;
        return arg0;
    };
    
    UpdateBuffIfExists("Sake", buffConfig);
    UpdateBuffIfExists("Sake2", buffConfig2);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 15,
        weight: 1
    };
    var buffConfig2 = 
    {
        weight: 5,
        buffIcon: 1882
    };
    
    playerCharacter.onHeal.Sake = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 5,
            buffIcon: 1882
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Sake2", ds_map_find_value(ac.Buffs, "Sake2"), buffConfig);
        }
        return arg0;
    };
    
    playerCharacter.scripts.Sake.config.maxStacks = 15;
    UpdateBuffIfExists("Sake", buffConfig);
    UpdateBuffIfExists("Sake2", buffConfig2);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: 1,
        loseStackOnRemove: true
    };
    var buffConfig2 = 
    {
        weight: 5,
        buffIcon: 1882
    };
    
    playerCharacter.onHeal.Sake = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 5,
            buffIcon: 1882
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Sake2", ds_map_find_value(ac.Buffs, "Sake2"), buffConfig);
        }
        return arg0;
    };
    
    playerCharacter.scripts.Sake.config.maxStacks = 20;
    UpdateBuffIfExists("Sake", buffConfig);
    UpdateBuffIfExists("Sake2", buffConfig2);
}, function()
{
    playerCharacter.drunkDirection = 0;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 30,
        weight: 1,
        loseStackOnRemove: true
    };
    var buffConfig2 = 
    {
        weight: 5,
        buffIcon: 1882
    };
    
    playerCharacter.onHeal.Sake = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 5,
            buffIcon: 1882
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Sake2", ds_map_find_value(ac.Buffs, "Sake2"), buffConfig);
        }
        return arg0;
    };
    
    playerCharacter.scripts.Sake = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: arg1.maxStacks,
                weight: 1
            };
            if (arg1.timer >= arg1.maxTimer)
            {
                obj_AttackController.ApplyBuff(arg0, "Sake", ds_map_find_value(obj_AttackController.Buffs, "Sake"), buffConfig);
                arg1.timer = 0;
            }
            else
            {
                arg1.timer++;
            }
            obj_Player.drunkDirection = (-5 + irandom(10)) * global.negativeEffects;
            if (obj_Player.drunkDirection > 30)
            {
                obj_Player.drunkDirection = 25 * global.negativeEffects;
            }
            if (obj_Player.drunkDirection < -30)
            {
                obj_Player.drunkDirection = -25 * global.negativeEffects;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60,
            maxStacks: 30
        }
    };
    
    playerCharacter.onTakeDamage.Sake = function(arg0, arg1, arg2, arg3)
    {
        return arg0;
    };
    
    UpdateBuffIfExists("Sake", buffConfig);
    UpdateBuffIfExists("Sake2", buffConfig2);
}];

SakeRemove = function()
{
};

ds_map_set(ITEMS, "Sake", new Item("Sake", 
{
    optionIcon: 1873,
    optionIcon_Super: 1520,
    optionName: global.TextContainer.SakeName.selectedLanguage,
    optionDescription: global.TextContainer.SakeDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 4
}, 3, Sake, SakeRemove, true));
FullMeal = [function()
{
    playerCharacter.healMultiplier += 1;
}];

FullMealRemove = function()
{
    playerCharacter.healMultiplier -= 1;
};

ds_map_set(ITEMS, "FullMeal", new Item("FullMeal", 
{
    optionIcon: 2140,
    optionName: global.TextContainer.FullMealName.selectedLanguage,
    optionDescription: global.TextContainer.FullMealDescription.selectedLanguage,
    itemType: "Healing",
    maxLevel: 1,
    weight: 1
}, 1, FullMeal, FullMealRemove));
UberSheep = [function()
{
    playerCharacter.scripts.UberSheep = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer <= 0)
            {
                var foodDrop = instance_create_depth((arg0.x - 200) + random(400), arg0.y - 200, arg0.depth, obj_Hamburger);
                foodDrop.hspeed = -4 + random(8);
                foodDrop.gravity = 1;
                foodDrop.setY = (arg0.y - 100) + random(200);
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 600,
            maxTimer: max(1, 600 * (1 / (1 + (playerCharacter.haste / 100))))
        }
    };
    global.foodDropChanceBuff = 0.1;
}, function()
{
    playerCharacter.scripts.UberSheep = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer <= 0)
            {
                var foodDrop = instance_create_depth((arg0.x - 200) + random(400), arg0.y - 200, arg0.depth, obj_Hamburger);
                foodDrop.hspeed = -4 + random(8);
                foodDrop.gravity = 1;
                foodDrop.setY = (arg0.y - 100) + random(200);
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 540,
            maxTimer: max(1, 540 * (1 / (1 + (playerCharacter.haste / 100))))
        }
    };
    global.foodDropChanceBuff = 0.12;
}, function()
{
    playerCharacter.scripts.UberSheep = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer <= 0)
            {
                var foodDrop = instance_create_depth((arg0.x - 200) + random(400), arg0.y - 200, arg0.depth, obj_Hamburger);
                foodDrop.hspeed = -4 + random(8);
                foodDrop.gravity = 1;
                foodDrop.setY = (arg0.y - 100) + random(200);
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 480,
            maxTimer: max(1, 480 * (1 / (1 + (playerCharacter.haste / 100))))
        }
    };
    global.foodDropChanceBuff = 0.15;
}, function()
{
    playerCharacter.scripts.UberSheep = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer <= 0)
            {
                var foodDrop = instance_create_depth((arg0.x - 200) + random(400), arg0.y - 200, arg0.depth, obj_Hamburger);
                foodDrop.hspeed = -4 + random(8);
                foodDrop.gravity = 1;
                foodDrop.setY = (arg0.y - 100) + random(200);
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 420,
            maxTimer: max(1, 420 * (1 / (1 + (playerCharacter.haste / 100))))
        }
    };
    global.foodDropChanceBuff = 0.18;
}, function()
{
    playerCharacter.scripts.UberSheep = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer <= 0)
            {
                var foodDrop = instance_create_depth((arg0.x - 200) + random(400), arg0.y - 200, arg0.depth, obj_Hamburger);
                foodDrop.hspeed = -4 + random(8);
                foodDrop.gravity = 1;
                foodDrop.setY = (arg0.y - 100) + random(200);
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 360,
            maxTimer: max(1, 360 * (1 / (1 + (playerCharacter.haste / 100))))
        }
    };
    global.foodDropChanceBuff = 0.2;
}];

UberSheepRemove = function()
{
};

ds_map_set(ITEMS, "UberSheep", new Item("UberSheep", 
{
    optionIcon: 2217,
    optionName: global.TextContainer.UberSheepName.selectedLanguage,
    optionDescription: global.TextContainer.UberSheepDescription.selectedLanguage,
    itemType: "Healing",
    weight: 4
}, 5, UberSheep, UberSheepRemove));
InjectionScript = 
{
    Script: function(arg0, arg1)
    {
        var timer;
        if (arg0.currentHP > 1 && arg1.timer <= 0 && !global.timePause)
        {
            var minDam = max(2, floor(arg0.HP * 0.05));
            if ((arg0.currentHP - minDam) <= 0)
            {
                minDam = arg0.currentHP - 1;
            }
            minDam = minDam * global.negativeEffects;
            if (minDam > 0)
            {
                arg0.ApplyDamage(floor(minDam), undefined, false, false);
            }
            if (arg0.currentHP < 1)
            {
                arg0.currentHP = 1;
                hpSus = floor(arg0.currentHP) - 1;
            }
            arg1.timer = arg1.maxTimer;
        }
        else
        {
            arg1.timer--;
        }
    },
    
    config: 
    {
        timer: 0,
        maxTimer: 60
    }
};
InjectionAsacoco = [function()
{
    playerCharacter.ATK += 0.4 * global.positiveEffects;
    playerCharacter.scripts.InjectionAsacoco = InjectionScript;
}, function()
{
    playerCharacter.ATK += 0.6 * global.positiveEffects;
    playerCharacter.scripts.InjectionAsacoco = InjectionScript;
}, function()
{
    playerCharacter.ATK += 0.8 * global.positiveEffects;
    playerCharacter.scripts.InjectionAsacoco = InjectionScript;
}];

InjectionAsacocoRemove = function()
{
};

ds_map_set(ITEMS, "InjectionAsacoco", new Item("InjectionAsacoco", 
{
    optionIcon: 658,
    optionName: global.TextContainer.InjectionAsacocoName.selectedLanguage,
    optionDescription: global.TextContainer.InjectionAsacocoDescription.selectedLanguage,
    itemType: "Stat",
    weight: 2
}, 3, InjectionAsacoco, InjectionAsacocoRemove));
Headphones = [function()
{
    playerCharacter.onTakeDamage.Headphones = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        var dodgeChance = 15;
        var roll = irandom(99);
        if (roll < dodgeChance)
        {
            arg3.invincible = true;
            arg3.invincibilityTimer = 3;
            obj_AttackController.ExecuteAttack("HeadphoneKnockback", arg3);
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.Headphones = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        var dodgeChance = 20;
        var roll = irandom(99);
        if (roll < dodgeChance)
        {
            arg3.invincible = true;
            arg3.invincibilityTimer = 3;
            obj_AttackController.ExecuteAttack("HeadphoneKnockback", arg3);
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.Headphones = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        var dodgeChance = 25;
        var roll = irandom(99);
        if (roll < dodgeChance)
        {
            arg3.invincible = true;
            arg3.invincibilityTimer = 3;
            obj_AttackController.ExecuteAttack("HeadphoneKnockback", arg3);
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.Headphones = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        var dodgeChance = 30;
        var roll = irandom(99);
        if (roll < dodgeChance)
        {
            arg3.invincible = true;
            arg3.invincibilityTimer = 3;
            obj_AttackController.ExecuteAttack("HeadphoneKnockback", arg3);
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.Headphones = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        var dodgeChance = 35;
        var roll = irandom(99);
        if (roll < dodgeChance)
        {
            arg3.invincible = true;
            arg3.invincibilityTimer = 3;
            obj_AttackController.ExecuteAttack("HeadphoneKnockback", arg3);
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.Headphones = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        var dodgeChance = 40;
        var roll = irandom(99);
        if (roll < dodgeChance)
        {
            arg3.invincible = true;
            arg3.invincibilityTimer = 3;
            obj_AttackController.ExecuteAttack("HeadphoneKnockback", arg3);
            Heal(arg3, arg3.HP * 0.1, 0, 1, false, false);
        }
        return arg0;
    };
}];

HeadphonesRemove = function()
{
};

ds_map_set(ITEMS, "Headphones", new Item("Headphones", 
{
    optionIcon: 1588,
    optionIcon_Super: 1268,
    optionName: global.TextContainer.HeadphonesName.selectedLanguage,
    optionDescription: global.TextContainer.HeadphonesDescription.selectedLanguage,
    itemType: "Utility",
    weight: 4
}, 5, Headphones, HeadphonesRemove, true));
FaceMask = [function()
{
    playerCharacter.BonusDamageTaken += 30 * global.negativeEffects;
    playerCharacter.DB += 0.3;
    playerCharacter.haste += 10 * global.positiveEffects;
}];

FaceMaskRemove = function()
{
};

ds_map_set(ITEMS, "FaceMask", new Item("FaceMask", 
{
    optionIcon: 1047,
    optionName: global.TextContainer.FaceMaskName.selectedLanguage,
    optionDescription: global.TextContainer.FaceMaskDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 1
}, 1, FaceMask, FaceMaskRemove));
GorillasPaw = [function()
{
    playerCharacter.crit -= 20 * global.negativeEffects;
    playerCharacter.DB += 0.2;
}, function()
{
    playerCharacter.crit -= 20 * global.negativeEffects;
    playerCharacter.DB += 0.3;
}, function()
{
    playerCharacter.crit -= 20 * global.negativeEffects;
    playerCharacter.DB += 0.4;
}, function()
{
    playerCharacter.DB += 0.5;
}];

GorillasPawRemove = function()
{
};

ds_map_set(ITEMS, "GorillasPaw", new Item("GorillasPaw", 
{
    optionIcon: 37,
    optionIcon_Super: 1037,
    optionName: global.TextContainer.GorillasPawName.selectedLanguage,
    optionDescription: global.TextContainer.GorillasPawDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 3
}, 3, GorillasPaw, GorillasPawRemove, true));
EnergyDrink = [function()
{
    playerCharacter.haste += 10 * global.positiveEffects;
    playerCharacter.SPD += 0.3 * global.positiveEffects;
    playerCharacter.HP = max(1, playerCharacter.HP * (1 - (0.2 * global.negativeEffects)));
    playerCharacter.UpdateHP();
}, function()
{
    playerCharacter.haste += 15 * global.positiveEffects;
    playerCharacter.SPD += 0.4 * global.positiveEffects;
    playerCharacter.HP = max(1, playerCharacter.HP * (1 - (0.2 * global.negativeEffects)));
    playerCharacter.UpdateHP();
}, function()
{
    playerCharacter.haste += 20 * global.positiveEffects;
    playerCharacter.SPD += 0.5 * global.positiveEffects;
    playerCharacter.HP = max(1, playerCharacter.HP * (1 - (0.2 * global.negativeEffects)));
    playerCharacter.UpdateHP();
}, function()
{
    playerCharacter.haste += 30 * global.positiveEffects;
    playerCharacter.SPD += 0.6 * global.positiveEffects;
}];

EnergyDrinkRemove = function()
{
};

ds_map_set(ITEMS, "EnergyDrink", new Item("EnergyDrink", 
{
    optionIcon: 596,
    optionIcon_Super: 2471,
    optionName: global.TextContainer.EnergyDrinkName.selectedLanguage,
    optionDescription: global.TextContainer.EnergyDrinkDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 3
}, 3, EnergyDrink, EnergyDrinkRemove, true));
Plushie = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Plushie"))
    {
        playerCharacter.scripts.Plushie = 
        {
            Script: function(arg0, arg1)
            {
                if (arg0.scripts.Plushie.config.timer > 0)
                {
                    arg0.scripts.Plushie.config.timer--;
                }
                else if (arg1.damageDebt > 0)
                {
                    var hurt = floor(max(1, arg1.damageDebt * 0.1));
                    arg0.TakeDamage(hurt, arg0, false, "", false, false, true);
                    arg1.damageDebt -= hurt;
                    arg1.timer = arg1.maxTimer;
                }
                if (arg0.currentHP == 0)
                {
                    arg1.damageDebt = 0;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 20,
                damageDebt: 0,
                initialReduction: 0.3
            }
        };
        
        playerCharacter.onTakeDamageAfter.Plushie = function(arg0, arg1, arg2, arg3)
        {
            if (arg3.invincible)
            {
                return arg0;
            }
            if (arg0 < 1)
            {
                return arg0;
            }
            var initHit = floor(max(1, arg3.scripts.Plushie.config.initialReduction * arg0));
            var totalDamage = arg0;
            var hitDebt = totalDamage - initHit;
            arg3.scripts.Plushie.config.damageDebt += hitDebt;
            arg0 = initHit;
            return arg0;
        };
    }
}, function()
{
    playerCharacter.scripts.Plushie.config.initialReduction = 0.2;
}, function()
{
    playerCharacter.scripts.Plushie.config.initialReduction = 0.1;
}];

PlushieRemove = function()
{
};

ds_map_set(ITEMS, "Plushie", new Item("Plushie", 
{
    optionIcon: 501,
    optionName: global.TextContainer.PlushieName.selectedLanguage,
    optionDescription: global.TextContainer.PlushieDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 4
}, 3, Plushie, PlushieRemove));
SuperChattoTime = [function()
{
    global.coinAutoPick = true;
    global.moneyMultiplier += 0.2;
}, function()
{
    global.coinAutoPick = true;
    global.moneyMultiplier += 0.4;
}, function()
{
    global.coinAutoPick = true;
    global.moneyMultiplier += 0.6;
}, function()
{
    global.coinAutoPick = true;
    global.moneyMultiplier += 0.8;
}, function()
{
    global.coinAutoPick = true;
    global.moneyMultiplier += 1;
}, function()
{
    global.coinAutoPick = true;
    global.moneyMultiplier += 1.5;
    playerCharacter.onPickUp.SuperChattoTime = 
    {
        Script: function(arg0, arg1, arg2, arg3)
        {
            if (arg2 == "HoloCoin" && arg3)
            {
                var buffConfig = 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: 99999,
                    buffIcon: 1918
                };
                obj_AttackController.ApplyBuff(arg0, "SuperChattoTime", ds_map_find_value(obj_AttackController.Buffs, "SuperChattoTime"), buffConfig);
            }
        },
        
        config: {}
    };
}];

SuperChattoTimeRemove = function()
{
};

ds_map_set(ITEMS, "SuperChattoTime", new Item("SuperChattoTime", 
{
    optionIcon: 2127,
    optionIcon_Super: 1918,
    optionName: global.TextContainer.SuperChattoTimeName.selectedLanguage,
    optionDescription: global.TextContainer.SuperChattoTimeDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 5,
    weight: 2
}, 5, SuperChattoTime, SuperChattoTimeRemove, true));
IdolCostume = [function()
{
    playerCharacter.specMod -= 0.2;
}, function()
{
    playerCharacter.specMod -= 0.25;
}, function()
{
    playerCharacter.specMod -= 0.3;
}, function()
{
    playerCharacter.specMod -= 0.35;
}, function()
{
    playerCharacter.specMod -= 0.4;
}, function()
{
    playerCharacter.specMod -= 0.45;
    if (!playerCharacter.instantRefreshSpecial)
    {
        playerCharacter.extraSpecial = 1;
    }
    playerCharacter.instantRefreshSpecial = true;
}];

IdolCostumeRemove = function()
{
};

ds_map_set(ITEMS, "IdolCostume", new Item("IdolCostume", 
{
    optionIcon: 1564,
    optionIcon_Super: 1267,
    optionName: global.TextContainer.IdolCostumeName.selectedLanguage,
    optionDescription: global.TextContainer.IdolCostumeDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 5,
    weight: 2
}, 5, IdolCostume, IdolCostumeRemove, true));
CreditCard = [function()
{
    global.anvilDropChanceBuff = 0.18;
    global.enhanceCostMultiplier = 0.8;
    if (!variable_struct_exists(playerCharacter.scripts, "CreditCard"))
    {
        playerCharacter.scripts.CreditCard = 
        {
            Script: function(arg0, arg1)
            {
                var spawnCD;
                if (arg1.spawnCD > 0)
                {
                    arg1.spawnCD--;
                }
                if (arg1.spawnCD == 0)
                {
                    arg1.spawnCD = arg1.minTime + irandom(arg1.maxTime);
                    global.freeAnvil = true;
                }
            },
            
            config: 
            {
                spawnCD: 14400,
                minTime: 7200,
                maxTime: 7200,
                super: false
            }
        };
    }
}, function()
{
    playerCharacter.scripts.CreditCard.config.minTime = 6300;
    playerCharacter.scripts.CreditCard.config.maxTime = 6300;
    global.anvilDropChanceBuff = 0.28;
    global.enhanceCostMultiplier = 0.75;
}, function()
{
    playerCharacter.scripts.CreditCard.config.minTime = 5400;
    playerCharacter.scripts.CreditCard.config.maxTime = 5400;
    global.anvilDropChanceBuff = 0.38;
    global.enhanceCostMultiplier = 0.7;
}, function()
{
    playerCharacter.scripts.CreditCard.config.minTime = 4500;
    playerCharacter.scripts.CreditCard.config.maxTime = 4500;
    global.anvilDropChanceBuff = 0.45;
    global.enhanceCostMultiplier = 0.65;
}, function()
{
    playerCharacter.scripts.CreditCard.config.minTime = 3600;
    playerCharacter.scripts.CreditCard.config.maxTime = 3600;
    global.anvilDropChanceBuff = 0.5;
    global.enhanceCostMultiplier = 0.6;
}, function()
{
    global.anvilDropChanceBuff = 0.5;
    global.enhanceCostMultiplier = 0.5;
    playerCharacter.scripts.CreditCard = 
    {
        Script: function(arg0, arg1)
        {
            var spawnCD;
            if (arg1.spawnCD > 0)
            {
                arg1.spawnCD--;
            }
            if (arg1.spawnCD == 0)
            {
                if (global.time[UnknownEnum.Value_2] == 0 && global.time[UnknownEnum.Value_3] == 0)
                {
                    arg1.spawnCD = 120;
                    instance_create_depth((arg0.x - 10) + irandom(20), (arg0.y - 10) + irandom(20), arg0.depth, obj_holoAnvil);
                    soundPlay([257], "anvil", 10, 75);
                }
            }
        },
        
        config: 
        {
            spawnCD: 0,
            super: true,
            minTime: 10800,
            maxTime: 10000
        }
    };
}];

CreditCardRemove = function()
{
};

ds_map_set(ITEMS, "CreditCard", new Item("CreditCard", 
{
    optionIcon: 2370,
    optionIcon_Super: 1750,
    optionName: global.TextContainer.CreditCardName.selectedLanguage,
    optionDescription: global.TextContainer.CreditCardDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 5,
    weight: 3
}, 5, CreditCard, CreditCardRemove, true));
Bandaid = [function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 10 * global.positiveEffects;
        playerCharacter.UpdateHP();
    }
    if (!variable_struct_exists(playerCharacter.scripts, "Bandaid"))
    {
        playerCharacter.scripts.Bandaid = 
        {
            Script: function(arg0, arg1)
            {
                if (arg1.healDebt > 0 && arg0.scripts.Bandaid.config.timer > 0)
                {
                    arg0.scripts.Bandaid.config.timer--;
                }
                if (arg0.scripts.Bandaid.config.timer == 0 && (arg0.currentHP > 0 || arg0.canNotDie))
                {
                    var healVal = min(arg1.healDebt, arg1.healAmount * arg0.HP);
                    arg1.healDebt -= healVal;
                    Heal(arg0, healVal, 1, true, false);
                    arg0.scripts.Bandaid.config.timer = arg0.scripts.Bandaid.config.maxTimer;
                }
            },
            
            config: 
            {
                timer: 180,
                maxTimer: 180,
                healAmount: 0.1,
                healDebt: 0,
                damageAbsorb: 0.8
            }
        };
    }
    
    playerCharacter.onTakeDamage.Bandaid = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        if (arg0 > 0)
        {
            var debtAmount = max(1, arg0 * playerCharacter.scripts.Bandaid.config.damageAbsorb);
            playerCharacter.scripts.Bandaid.config.healDebt += debtAmount;
        }
        return arg0;
    };
}, function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 20 * global.positiveEffects;
        playerCharacter.UpdateHP();
    }
    playerCharacter.scripts.Bandaid.config.damageAbsorb = 0.9;
    playerCharacter.scripts.Bandaid.config.healAmount = 0.1;
}, function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 30 * global.positiveEffects;
        playerCharacter.UpdateHP();
    }
    playerCharacter.scripts.Bandaid.config.damageAbsorb = 1;
    playerCharacter.scripts.Bandaid.config.healAmount = 0.1;
}];

BandaidRemove = function()
{
};

ds_map_set(ITEMS, "Bandaid", new Item("Bandaid", 
{
    optionIcon: 1416,
    optionName: global.TextContainer.BandaidName.selectedLanguage,
    optionDescription: global.TextContainer.BandaidDescription.selectedLanguage,
    itemType: "Healing",
    maxLevel: 3,
    weight: 4
}, 3, Bandaid, BandaidRemove));

function MembershipStepBuffApply(arg0, arg1)
{
    if (global.currentRunMoneyGained > 0)
    {
        obj_AttackController.ApplyBuff(arg0, "Membership", ds_map_find_value(obj_AttackController.Buffs, "Membership"), {});
        arg0.ATK += arg0.scripts.Membership.config.weight1 * global.positiveEffects;
        arg0.DR *= 1 - arg0.scripts.Membership.config.weight2;
    }
    else
    {
        obj_AttackController.RemoveBuff(arg0, "Membership");
    }
}

Membership = [function()
{
    playerCharacter.scripts.Membership = 
    {
        Script: function(arg0, arg1)
        {
            if (global.currentRunMoneyGained > 0)
            {
                arg0.scripts.Membership.config.timer--;
            }
            if (arg0.scripts.Membership.config.timer == 0)
            {
                global.currentRunMoneyGained -= (3 * global.negativeEffects);
                arg0.scripts.Membership.config.timer = arg0.scripts.Membership.config.maxTimer;
            }
        },
        
        config: 
        {
            timer: 60,
            maxTimer: 60,
            weight1: 0.3,
            weight2: 0.1
        }
    };
    playerCharacter.stepBuffs.Membership = 
    {
        Apply: MembershipStepBuffApply,
        config: {}
    };
}, function()
{
    playerCharacter.scripts.Membership = 
    {
        Script: function(arg0, arg1)
        {
            if (global.currentRunMoneyGained > 0)
            {
                arg0.scripts.Membership.config.timer--;
            }
            if (arg0.scripts.Membership.config.timer == 0)
            {
                global.currentRunMoneyGained -= (3 * global.negativeEffects);
                arg0.scripts.Membership.config.timer = arg0.scripts.Membership.config.maxTimer;
            }
        },
        
        config: 
        {
            timer: 60,
            maxTimer: 60,
            weight1: 0.4,
            weight2: 0.18
        }
    };
    playerCharacter.stepBuffs.Membership = 
    {
        Apply: MembershipStepBuffApply,
        config: {}
    };
}, function()
{
    playerCharacter.scripts.Membership = 
    {
        Script: function(arg0, arg1)
        {
            if (global.currentRunMoneyGained > 0)
            {
                arg0.scripts.Membership.config.timer--;
            }
            if (arg0.scripts.Membership.config.timer == 0)
            {
                global.currentRunMoneyGained -= (3 * global.negativeEffects);
                arg0.scripts.Membership.config.timer = arg0.scripts.Membership.config.maxTimer;
            }
        },
        
        config: 
        {
            timer: 60,
            maxTimer: 60,
            weight1: 0.5,
            weight2: 0.25
        }
    };
    playerCharacter.stepBuffs.Membership = 
    {
        Apply: MembershipStepBuffApply,
        config: {}
    };
}];

MembershipRemove = function()
{
};

ds_map_set(ITEMS, "Membership", new Item("Membership", 
{
    optionIcon: 476,
    optionName: global.TextContainer.MembershipName.selectedLanguage,
    optionDescription: global.TextContainer.MembershipDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 3
}, 3, Membership, MembershipRemove));

function GWSPillStepBuffApply(arg0, arg1)
{
    if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0 && playerCharacter.specialMeter < floor(playerCharacter.specCD * (playerCharacter.specMod - ((global.gameMode < 2) * 0.03 * ds_map_find_value(global.PlayerSave, "specCDR")))))
    {
        obj_AttackController.ApplyBuff(arg0, "GWSPill", ds_map_find_value(obj_AttackController.Buffs, "GWSPill"), 
        {
            weight: arg0.stepBuffs.GWSPill.config.weight
        });
    }
    else
    {
        obj_AttackController.RemoveBuff(arg0, "GWSPill");
    }
    arg0.crit += arg0.stepBuffs.GWSPill.config.weight * (ds_map_find_value(global.PlayerSave, "specUnlock") > 0 && playerCharacter.specialMeter < floor(playerCharacter.specCD * (playerCharacter.specMod - ((global.gameMode < 2) * 0.03 * ds_map_find_value(global.PlayerSave, "specCDR")))));
}

GWSPill = [function()
{
    playerCharacter.stepBuffs.GWSPill = 
    {
        Apply: GWSPillStepBuffApply,
        config: 
        {
            weight: 15 * global.positiveEffects
        }
    };
}, function()
{
    playerCharacter.stepBuffs.GWSPill = 
    {
        Apply: GWSPillStepBuffApply,
        config: 
        {
            weight: 20 * global.positiveEffects
        }
    };
}, function()
{
    playerCharacter.stepBuffs.GWSPill = 
    {
        Apply: GWSPillStepBuffApply,
        config: 
        {
            weight: 25 * global.positiveEffects
        }
    };
}];

GWSPillRemove = function()
{
};

ds_map_set(ITEMS, "GWSPill", new Item("GWSPill", 
{
    optionIcon: 1811,
    optionName: global.TextContainer.GWSPillName.selectedLanguage,
    optionDescription: global.TextContainer.GWSPillDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 2
}, 3, GWSPill, GWSPillRemove));
Halu = [function()
{
    if (global.haluLevel == 0)
    {
        global.preHaluDefeated = global.enemyDefeated;
    }
    global.additionalSpawn = 2;
    global.haluBuff = 0.1;
    global.haluLevel = 5;
}, function()
{
    global.additionalSpawn = 4;
    global.haluBuff = 0.15;
    global.haluLevel = 4;
}, function()
{
    global.additionalSpawn = 6;
    global.haluBuff = 0.2;
    global.haluLevel = 3;
}, function()
{
    global.additionalSpawn = 8;
    global.haluBuff = 0.25;
    global.haluLevel = 2;
}, function()
{
    global.additionalSpawn = 10;
    global.haluBuff = 0.3;
    global.haluLevel = 1;
}];

HaluRemove = function()
{
};

ds_map_set(ITEMS, "Halu", new Item("Halu", 
{
    optionIcon: 613,
    optionName: global.TextContainer.HaluName.selectedLanguage,
    optionDescription: global.TextContainer.HaluDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 5,
    weight: 3
}, 5, Halu, HaluRemove));
Limiter = [function()
{
    playerCharacter.pickupRange += 100 * global.positiveEffects;
}, function()
{
    playerCharacter.pickupRange += 200 * global.positiveEffects;
}, function()
{
    playerCharacter.pickupRange += 300 * global.positiveEffects;
}, function()
{
    playerCharacter.pickupRange += 500 * global.positiveEffects;
    playerCharacter.expMultiplier += 0.15;
    global.moneyMultiplier += 0.15;
}];

LimiterRemove = function()
{
};

ds_map_set(ITEMS, "Limiter", new Item("Limiter", 
{
    optionIcon: 893,
    optionIcon_Super: 898,
    optionName: global.TextContainer.LimiterName.selectedLanguage,
    optionDescription: global.TextContainer.LimiterDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 4
}, 3, Limiter, LimiterRemove, true));
PiggyBank = [function()
{
    playerCharacter.SPD += 0.2 * global.positiveEffects;
    playerCharacter.pickupRange -= 30 * global.negativeEffects;
    playerCharacter.scripts.PiggyBank = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.isMoving)
            {
                arg1.traveled += arg0.SPD;
                if (arg1.traveled >= arg1.travelLimit)
                {
                    arg1.traveled -= arg1.travelLimit;
                    global.currentRunMoneyGained += ((1 + arg0.moneyGain) * global.stageCoinBonus);
                    arg0.OnPickUp(arg0, "HoloCoin", false);
                }
            }
        },
        
        config: 
        {
            traveled: 0,
            travelLimit: 100
        }
    };
}, function()
{
    playerCharacter.SPD += 0.3 * global.positiveEffects;
    playerCharacter.pickupRange -= 30 * global.negativeEffects;
    playerCharacter.scripts.PiggyBank.config.travelLimit = 75;
}, function()
{
    playerCharacter.SPD += 0.4 * global.positiveEffects;
    playerCharacter.pickupRange -= 30 * global.negativeEffects;
    playerCharacter.scripts.PiggyBank.config.travelLimit = 50;
}, function()
{
    playerCharacter.SPD += 0.5 * global.positiveEffects;
    if (!variable_struct_exists(playerCharacter.scripts, "PiggyBank"))
    {
        playerCharacter.scripts.PiggyBank = 
        {
            Script: function(arg0, arg1)
            {
                if (arg0.isMoving)
                {
                    arg1.traveled += arg0.SPD;
                    if (arg1.traveled >= arg1.travelLimit)
                    {
                        arg1.traveled -= arg1.travelLimit;
                        global.currentRunMoneyGained += ((1 + arg0.moneyGain) * global.stageCoinBonus);
                        arg0.OnPickUp(arg0, "HoloCoin", false);
                    }
                }
            },
            
            config: 
            {
                traveled: 0,
                travelLimit: 100
            }
        };
    }
    playerCharacter.scripts.PiggyBank.config.travelLimit = 25;
}];

PiggyBankRemove = function()
{
};

if (global.charSelected.id == "moona")
{
    ds_map_set(ITEMS, "PiggyBank", new Item("PiggyBank", 
    {
        optionIcon: 1478,
        optionIcon_Super: 419,
        optionName: global.TextContainer.PiggyBankName2.selectedLanguage,
        optionDescription: global.TextContainer.PiggyBankDescription.selectedLanguage,
        itemType: "Utility",
        maxLevel: 1,
        weight: 2
    }, 3, PiggyBank, PiggyBankRemove, true));
}
else
{
    ds_map_set(ITEMS, "PiggyBank", new Item("PiggyBank", 
    {
        optionIcon: 1478,
        optionIcon_Super: 419,
        optionName: global.TextContainer.PiggyBankName.selectedLanguage,
        optionDescription: global.TextContainer.PiggyBankDescription.selectedLanguage,
        itemType: "Utility",
        maxLevel: 1,
        weight: 2
    }, 3, PiggyBank, PiggyBankRemove, true));
}
HopeSoda = [function()
{
    playerCharacter.CritMod += 0.1;
    playerCharacter.specMod += 0.25 * global.negativeEffects;
}, function()
{
    playerCharacter.CritMod += 0.2;
    playerCharacter.specMod += 0.25 * global.negativeEffects;
}, function()
{
    playerCharacter.CritMod += 0.3;
    playerCharacter.specMod += 0.25 * global.negativeEffects;
}, function()
{
    playerCharacter.CritMod += 0.4;
    playerCharacter.specMod += 0.25 * global.negativeEffects;
}, function()
{
    playerCharacter.CritMod += 0.5;
    playerCharacter.specMod += 0.25 * global.negativeEffects;
}, function()
{
    playerCharacter.CritMod += 0.5;
    
    playerCharacter.beforeDamageCalculation.HopeSoda = function(arg0, arg1, arg2)
    {
        if (arg1.scripts.HopeSoda.config.attackHits == 9)
        {
            arg2.sureCritOnce = true;
        }
        return arg2;
    };
    
    if (!variable_struct_exists(playerCharacter.scripts, "HopeSoda"))
    {
        playerCharacter.scripts.HopeSoda = 
        {
            Script: function(arg0, arg1)
            {
            },
            
            config: 
            {
                attackHits: 0
            }
        };
    }
    variable_struct_set(playerCharacter.onHitEffects, "HopeSoda", {});
}];

HopeSodaRemove = function()
{
};

ds_map_set(ITEMS, "HopeSoda", new Item("HopeSoda", 
{
    optionIcon: 207,
    optionIcon_Super: 1977,
    optionName: global.TextContainer.HopeSodaName.selectedLanguage,
    optionDescription: global.TextContainer.HopeSodaDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 2
}, 5, HopeSoda, HopeSodaRemove, true));
BlacksmithsGear = [function()
{
    global.anvilUses = 1;
    global.enhancementBuff = 0;
}, function()
{
    global.anvilUses = 1;
    global.enhancementBuff = 0.05;
}, function()
{
    global.anvilUses = 1;
    global.enhancementBuff = 0.1;
}];

BlacksmithsGearRemove = function()
{
};

ds_map_set(ITEMS, "BlacksmithsGear", new Item("BlacksmithsGear", 
{
    optionIcon: 1012,
    optionName: global.TextContainer.BlacksmithsGearName.selectedLanguage,
    optionDescription: global.TextContainer.BlacksmithsGearDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 1
}, 3, BlacksmithsGear, BlacksmithsGearRemove));
Shacklesss = [function()
{
    global.negativeEffects = 0.67;
}, function()
{
    global.negativeEffects = 0.33;
}, function()
{
    global.negativeEffects = 0;
}];

ShacklesssRemove = function()
{
};

ds_map_set(ITEMS, "Shacklesss", new Item("Shacklesss", 
{
    optionIcon: 175,
    optionName: global.TextContainer.ShacklesssName.selectedLanguage,
    optionDescription: global.TextContainer.ShacklesssDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 1
}, 3, Shacklesss, ShacklesssRemove));
DevilHat = [function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DevilHat", 
    {
        damageMultiplier: 1.2
    });
    playerCharacter.scripts.DevilHat = 
    {
        Script: function(arg0, arg1)
        {
        },
        
        config: 
        {
            range: 130,
            circleTime: 0
        }
    };
    
    playerCharacter.customDrawScriptAbove.DevilHat = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.DevilHat.config.circleTime += 0.5;
            if (arg0.scripts.DevilHat.config.circleTime >= (arg0.scripts.DevilHat.config.range / 1.5))
            {
                arg0.scripts.DevilHat.config.circleTime = 0;
            }
            draw_set_color(make_color_rgb(210, 100, 255));
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.DevilHat.config.range, true);
        }
    };
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DevilHat", 
    {
        damageMultiplier: 1.4
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DevilHat", 
    {
        damageMultiplier: 1.6
    });
}];

DevilHatRemove = function()
{
};

ds_map_set(ITEMS, "DevilHat", new Item("DevilHat", 
{
    optionIcon: 987,
    optionName: global.TextContainer.DevilHatName.selectedLanguage,
    optionDescription: global.TextContainer.DevilHatDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 5,
    weight: 2
}, 3, DevilHat, DevilHatRemove));
Breastplate = [function()
{
    playerCharacter.DR *= 0.75;
    playerCharacter.SPD -= 0.1 * global.negativeEffects;
    
    playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
    {
        if (!arg1.isEnemy)
        {
            return arg0;
        }
        var roll = irandom(99);
        if (roll < 50)
        {
            audio_play_sound(snd_attackreflect, 10, 0);
            var totalDam = 2;
            var attacker = 0;
            if (instance_exists(arg1) && variable_instance_exists(arg1, "creator"))
            {
                attacker = arg1.creator;
            }
            else
            {
                attacker = arg1;
            }
            if (instance_exists(attacker))
            {
                var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
                {
                    damage: totalDam
                });
                attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1], "BreastPlate", true);
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.DR *= 0.75;
    playerCharacter.SPD -= 0.1 * global.negativeEffects;
    
    playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
    {
        if (!arg1.isEnemy)
        {
            return arg0;
        }
        var roll = irandom(99);
        if (roll < 60)
        {
            audio_play_sound(snd_attackreflect, 10, 0);
            var totalDam = 2.5;
            var attacker = 0;
            if (instance_exists(arg1) && variable_instance_exists(arg1, "creator"))
            {
                attacker = arg1.creator;
            }
            else
            {
                attacker = arg1;
            }
            if (instance_exists(attacker))
            {
                var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
                {
                    damage: totalDam
                });
                attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1], "BreastPlate", true);
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.DR *= 0.75;
    playerCharacter.SPD -= 0.1 * global.negativeEffects;
    
    playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
    {
        if (!arg1.isEnemy)
        {
            return arg0;
        }
        var roll = irandom(99);
        if (roll < 70)
        {
            audio_play_sound(snd_attackreflect, 10, 0);
            var totalDam = 3;
            var attacker = 0;
            if (instance_exists(arg1) && variable_instance_exists(arg1, "creator"))
            {
                attacker = arg1.creator;
            }
            else
            {
                attacker = arg1;
            }
            if (instance_exists(attacker))
            {
                var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
                {
                    damage: totalDam
                });
                attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1], "BreastPlate", true);
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.DR *= 0.7;
    
    playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
    {
        if (!arg1.isEnemy)
        {
            return arg0;
        }
        var roll = irandom(99);
        if (roll < 75)
        {
            audio_play_sound(snd_attackreflect, 10, 0);
            var totalDam = 3;
            var attacker = 0;
            if (instance_exists(arg1) && variable_instance_exists(arg1, "creator"))
            {
                attacker = arg1.creator;
            }
            else
            {
                attacker = arg1;
            }
            var targets = ds_list_create();
            if (instance_exists(obj_Enemy))
            {
                var found = collision_circle_list(arg3.x, arg3.y, 60, obj_Enemy, true, true, targets, true);
            }
            if (ds_list_size(targets) > 0)
            {
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    if (ds_list_find_value(targets, i).isEnemy && !variable_instance_exists(ds_list_find_value(targets, i), "attackID") && ds_list_find_value(targets, i) != attacker)
                    {
                        dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), arg3, 
                        {
                            damage: totalDam
                        });
                        ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg3, dmgObj[1], "BreastPlate", true);
                    }
                }
            }
            var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
            {
                damage: totalDam
            });
            attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1], "BreastPlate", true);
            ds_list_destroy(targets);
            targets = -1;
        }
        return arg0;
    };
}];

BreastplateRemove = function()
{
};

ds_map_set(ITEMS, "Breastplate", new Item("Breastplate", 
{
    optionIcon: 1269,
    optionIcon_Super: 2305,
    optionName: global.TextContainer.BreastplateName.selectedLanguage,
    optionDescription: global.TextContainer.BreastplateDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 2
}, 3, Breastplate, BreastplateRemove, true));
Beetle = [function()
{
    variable_struct_set(playerCharacter.onHitEffects, "Beetle", 
    {
        multiplier: 1.33
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "Beetle", 
    {
        multiplier: 1.66
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "Beetle", 
    {
        multiplier: 2
    });
}];

BeetleRemove = function()
{
};

ds_map_set(ITEMS, "Beetle", new Item("Beetle", 
{
    optionIcon: 349,
    optionName: global.TextContainer.BeetleName.selectedLanguage,
    optionDescription: global.TextContainer.BeetleDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 5,
    weight: 3
}, 3, Beetle, BeetleRemove));
NinjaHeadband = [function()
{
    playerCharacter.SPD += 0.2 * global.positiveEffects;
    variable_struct_set(playerCharacter.onHitEffects, "NinjaHeadband", 
    {
        multiplier: 1.05
    });
}, function()
{
    playerCharacter.SPD += 0.4 * global.positiveEffects;
    variable_struct_set(playerCharacter.onHitEffects, "NinjaHeadband", 
    {
        multiplier: 1.1
    });
}, function()
{
    playerCharacter.SPD += 0.6 * global.positiveEffects;
    variable_struct_set(playerCharacter.onHitEffects, "NinjaHeadband", 
    {
        multiplier: 1.15
    });
}];

NinjaHeadbandRemove = function()
{
};

ds_map_set(ITEMS, "NinjaHeadband", new Item("NinjaHeadband", 
{
    optionIcon: 870,
    optionName: global.TextContainer.NinjaHeadbandName.selectedLanguage,
    optionDescription: global.TextContainer.NinjaHeadbandDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 5,
    weight: 3
}, 3, NinjaHeadband, NinjaHeadbandRemove));
FocusShades = [function()
{
    playerCharacter.onAttackCreate.FocusShades = function(arg0, arg1)
    {
        if (variable_instance_exists(arg1, "config") && variable_instance_exists(arg1.config, "weaponType") && arg1.config.weaponType != "Melee")
        {
            arg1.config.bonusCrit += 10;
            variable_struct_set(arg1.config.onHitEffects, "FocusShades", 
            {
                resist: 600
            });
        }
        exit;
    };
}, function()
{
    playerCharacter.onAttackCreate.FocusShades = function(arg0, arg1)
    {
        if (variable_instance_exists(arg1, "config") && variable_instance_exists(arg1.config, "weaponType") && arg1.config.weaponType != "Melee")
        {
            arg1.config.bonusCrit += 20;
            variable_struct_set(arg1.config.onHitEffects, "FocusShades", 
            {
                resist: 600
            });
        }
        exit;
    };
}, function()
{
    playerCharacter.onAttackCreate.FocusShades = function(arg0, arg1)
    {
        if (variable_instance_exists(arg1, "config") && variable_instance_exists(arg1.config, "weaponType") && arg1.config.weaponType != "Melee")
        {
            arg1.config.bonusCrit += 30;
            variable_struct_set(arg1.config.onHitEffects, "FocusShades", 
            {
                resist: 600
            });
        }
        exit;
    };
}];

FocusShadesRemove = function()
{
};

ds_map_set(ITEMS, "FocusShades", new Item("FocusShades", 
{
    optionIcon: 989,
    optionName: global.TextContainer.FocusShadesName.selectedLanguage,
    optionDescription: global.TextContainer.FocusShadesDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 2
}, 3, FocusShades, FocusShadesRemove));
LabCoat = [function()
{
    playerCharacter.scripts.LabCoat = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
            if (arg1.timer == 0)
            {
                arg1.timer = arg1.maxTimer;
                if (arg0.currentHP == arg0.HP)
                {
                    if (arg1.expRate < arg1.maxRate)
                    {
                        arg1.expRate += 0.01;
                    }
                }
                global.experience += (obj_PlayerManager.toNextLevel * arg1.expRate);
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 120,
            expRate: 0.01,
            maxRate: 0.02
        }
    };
    
    playerCharacter.onTakeDamage.LabCoat = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        arg3.scripts.LabCoat.config.expRate = 0.01;
        return arg0;
    };
}, function()
{
    playerCharacter.scripts.LabCoat.config.maxRate = 0.03;
}, function()
{
    playerCharacter.scripts.LabCoat.config.maxRate = 0.04;
}];

LabCoatRemove = function()
{
};

ds_map_set(ITEMS, "LabCoat", new Item("LabCoat", 
{
    optionIcon: 1070,
    optionName: global.TextContainer.LabCoatName.selectedLanguage,
    optionDescription: global.TextContainer.LabCoatDescription.selectedLanguage,
    itemType: "Utility",
    maxLevel: 3,
    weight: 2
}, 3, LabCoat, LabCoatRemove));
Candy = [function()
{
    playerCharacter.haste += 40;
    playerCharacter.DB -= 0.25 * global.negativeEffects;
    variable_struct_set(playerCharacter.onHitEffects, "candyHit", 
    {
        chance: 10
    });
}, function()
{
    playerCharacter.haste += 50;
    playerCharacter.DB -= 0.25 * global.negativeEffects;
    variable_struct_set(playerCharacter.onHitEffects, "candyHit", 
    {
        chance: 10
    });
}, function()
{
    playerCharacter.haste += 60;
    playerCharacter.DB -= 0.25 * global.negativeEffects;
    variable_struct_set(playerCharacter.onHitEffects, "candyHit", 
    {
        chance: 10
    });
}];

CandyRemove = function()
{
};

ds_map_set(ITEMS, "Candy", new Item("Candy", 
{
    optionIcon: 2237,
    optionName: global.TextContainer.CandyName.selectedLanguage,
    optionDescription: global.TextContainer.CandyDescription.selectedLanguage,
    itemType: "Stat",
    maxLevel: 3,
    weight: 2
}, 3, Candy, CandyRemove));
itemOptions = {};
var key = ds_map_find_first(ITEMS);
while (!is_undefined(key))
{
    variable_struct_set(itemOptions, key, 0);
    key = ds_map_find_next(ITEMS, key);
}
global.itemsLibrary = ds_map_create();
ds_map_copy(global.itemsLibrary, ITEMS);
PERKS = ds_map_create();
var FPSMasteryOnApply = [function()
{
    playerCharacter.ATK += global.SkillData.FPSMastery.ATK[0];
}, function()
{
    playerCharacter.ATK += global.SkillData.FPSMastery.ATK[1];
}, function()
{
    playerCharacter.ATK += global.SkillData.FPSMastery.ATK[2];
    playerCharacter.haste += global.SkillData.FPSMastery.Haste;
}];
ds_map_set(PERKS, "FPSMastery", new Perk("FPSMastery", 
{
    optionName: global.TextContainer.FPSMasteryName.selectedLanguage,
    optionIcon: 691,
    optionDescription: global.TextContainer.FPSMasteryDescription.selectedLanguage[0]
}, FPSMasteryOnApply));
var DetectiveEyeOnApply = [function()
{
    playerCharacter.crit += global.SkillData.DetectiveEye.crit[0];
}, function()
{
    playerCharacter.crit += global.SkillData.DetectiveEye.crit[1];
}, function()
{
    playerCharacter.crit += global.SkillData.DetectiveEye.crit[2];
    variable_struct_set(playerCharacter.onHitEffects, "INSTADEATH", 
    {
        chance: global.SkillData.DetectiveEye.KO
    });
}];
ds_map_set(PERKS, "DetectiveEye", new Perk("DetectiveEye", 
{
    optionName: global.TextContainer.DetectiveEyeName.selectedLanguage,
    optionIcon: 1867,
    optionDescription: global.TextContainer.DetectiveEyeDescription.selectedLanguage[0]
}, DetectiveEyeOnApply));
var BubbaOnApply = [function()
{
    if (!instance_exists(obj_Summon))
    {
        obj_PlayerManager.playerSummon = obj_MobManager.CreateSummon("Bubba");
    }
}, function()
{
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.damage = global.SkillData.Bubba.ATK[1];
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.attackTime = 100;
    obj_PlayerManager.playerSummon.SetStats(
    {
        SPD: 2
    });
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.image_xscale = 1.25;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.image_yscale = 1.25;
}, function()
{
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.damage = global.SkillData.Bubba.ATK[2];
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.attackTime = 80;
    obj_PlayerManager.playerSummon.SetStats(
    {
        SPD: 3
    });
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.image_xscale = 1.5;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.image_yscale = 1.5;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "BubbaBark").config.knockback = 
    {
        duration: global.SkillData.Bubba.stun,
        speed: 0
    };
}];
ds_map_set(PERKS, "Bubba", new Perk("Bubba", 
{
    optionIcon: 2278,
    optionName: global.TextContainer.BubbaName.selectedLanguage,
    optionDescription: global.TextContainer.BubbaDescription.selectedLanguage[0]
}, BubbaOnApply));
var ShortHeightOnApply = [function()
{
    playerCharacter.onTakeDamage.ShortHeight = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        var dodgeChance = global.SkillData.ShortHeight.dodgeChance[0];
        var roll = irandom(99);
        if (arg3.scripts.ShortHeight.config.timer == 0)
        {
            if (roll < dodgeChance)
            {
                arg3.invincible = true;
                arg3.invincibilityTimer = 30;
                arg3.scripts.ShortHeight.config.timer = arg3.scripts.ShortHeight.config.maxTimer;
                audio_play_sound(snd_headphonesbounce, 10, 0);
                obj_AttackController.ApplyBuff(playerCharacter, "ShortHeight", ds_map_find_value(obj_AttackController.Buffs, "ShortHeight"), 
                {
                    weight: global.SkillData.ShortHeight.SPD[0]
                });
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.ShortHeight = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.ShortHeight.config.timer > 0)
            {
                arg0.scripts.ShortHeight.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 75
        }
    };
}, function()
{
    playerCharacter.onTakeDamage.ShortHeight = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        var dodgeChance = global.SkillData.ShortHeight.dodgeChance[1];
        var roll = irandom(99);
        if (arg3.scripts.ShortHeight.config.timer == 0)
        {
            if (roll < dodgeChance)
            {
                arg3.invincible = true;
                arg3.invincibilityTimer = 30;
                arg3.scripts.ShortHeight.config.timer = arg3.scripts.ShortHeight.config.maxTimer;
                audio_play_sound(snd_headphonesbounce, 10, 0);
                obj_AttackController.ApplyBuff(playerCharacter, "ShortHeight", ds_map_find_value(obj_AttackController.Buffs, "ShortHeight"), 
                {
                    weight: global.SkillData.ShortHeight.SPD[1]
                });
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.ShortHeight = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.ShortHeight.config.timer > 0)
            {
                arg0.scripts.ShortHeight.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 75
        }
    };
}, function()
{
    playerCharacter.onTakeDamage.ShortHeight = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        var dodgeChance = global.SkillData.ShortHeight.dodgeChance[2];
        var roll = irandom(99);
        if (arg3.scripts.ShortHeight.config.timer == 0)
        {
            if (roll < dodgeChance)
            {
                arg3.invincible = true;
                arg3.invincibilityTimer = 30;
                arg3.scripts.ShortHeight.config.timer = arg3.scripts.ShortHeight.config.maxTimer;
                audio_play_sound(snd_headphonesbounce, 10, 0);
                obj_AttackController.ApplyBuff(playerCharacter, "ShortHeight", ds_map_find_value(obj_AttackController.Buffs, "ShortHeight"), 
                {
                    weight: global.SkillData.ShortHeight.SPD[2]
                });
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.ShortHeight = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.ShortHeight.config.timer > 0)
            {
                arg0.scripts.ShortHeight.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 75
        }
    };
}];
ds_map_set(PERKS, "ShortHeight", new Perk("ShortHeight", 
{
    optionName: global.TextContainer.ShortHeightName.selectedLanguage,
    optionIcon: 374,
    optionDescription: global.TextContainer.ShortHeightDescription.selectedLanguage[0]
}, ShortHeightOnApply));
var PowerOfAtlantisOnApply = [function()
{
    if (!variable_struct_exists(weapons, "PowerOfAtlantis"))
    {
        weapons.PowerOfAtlantis = 
        {
            level: 0,
            id: "PowerOfAtlantis"
        };
        AddAttack("PowerOfAtlantis");
        InitializeAttack(ds_map_find_value(playerCharacter.attacks, "PowerOfAtlantis"));
        ds_map_find_value(playerCharacter.attacks, "PowerOfAtlantis").config.level = 1;
        weapons.PowerOfAtlantis.level = 1;
    }
}, function()
{
    if (weapons.PowerOfAtlantis.level == 1)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "PowerOfAtlantis").timer;
        AddAttack("PowerOfAtlantis");
        ds_map_find_value(playerCharacter.attacks, "PowerOfAtlantis").timer = oldTimer;
    }
}, function()
{
    if (weapons.PowerOfAtlantis.level == 2)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "PowerOfAtlantis").timer;
        AddAttack("PowerOfAtlantis");
        ds_map_find_value(playerCharacter.attacks, "PowerOfAtlantis").timer = oldTimer;
    }
}];
ds_map_set(PERKS, "PowerOfAtlantis", new Perk("PowerOfAtlantis", 
{
    optionName: global.TextContainer.PowerOfAtlantisName.selectedLanguage,
    optionIcon: 1973,
    optionDescription: global.TextContainer.PowerOfAtlantisDescription.selectedLanguage[0]
}, PowerOfAtlantisOnApply));
var SharkBiteOnApply = [function()
{
    variable_struct_set(playerCharacter.onHitEffects, "SharkBites", 
    {
        chance: global.SkillData.SharkBite.chance[0],
        vuln: global.SkillData.SharkBite.vuln[0],
        heal: 0.01
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "SharkBites", 
    {
        chance: global.SkillData.SharkBite.chance[1],
        vuln: global.SkillData.SharkBite.vuln[1],
        heal: 0.01
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "SharkBites", 
    {
        chance: global.SkillData.SharkBite.chance[2],
        vuln: global.SkillData.SharkBite.vuln[2],
        heal: 0.01
    });
}];
ds_map_set(PERKS, "SharkBite", new Perk("SharkBite", 
{
    optionIcon: 1674,
    optionName: global.TextContainer.SharkBiteName.selectedLanguage,
    optionDescription: global.TextContainer.SharkBiteDescription.selectedLanguage[0]
}, SharkBiteOnApply));
var DeathOnApply = [function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "CalliSlash1").config.onHitEffects.DeathExplod = 
    {
        chance: global.SkillData.Death.chance[0],
        deathChance: global.SkillData.Death.deathChance[0],
        damage: global.SkillData.Death.damage[0],
        size: 1
    };
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "CalliSlash1").config.onHitEffects.DeathExplod = 
    {
        chance: global.SkillData.Death.chance[1],
        deathChance: global.SkillData.Death.deathChance[1],
        damage: global.SkillData.Death.damage[0],
        size: 1.1
    };
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "CalliSlash1").config.onHitEffects.DeathExplod = 
    {
        chance: global.SkillData.Death.chance[2],
        deathChance: global.SkillData.Death.deathChance[2],
        damage: global.SkillData.Death.damage[0],
        size: 1.2
    };
}];
ds_map_set(PERKS, "Death", new Perk("Death", 
{
    optionName: global.TextContainer.DeathName.selectedLanguage,
    optionIcon: 1797,
    optionDescription: global.TextContainer.DeathDescription.selectedLanguage[0]
}, DeathOnApply));
var TheRapperOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "TheRapper"))
    {
        playerCharacter.scripts.TheRapper = 
        {
            Script: function(arg0, arg1)
            {
                var targets = ds_list_create();
                if (instance_exists(obj_Enemy))
                {
                    collision_circle_list(arg0.x, arg0.y, arg1.range, obj_Enemy, true, true, targets, false);
                }
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    obj_AttackController.ApplyBuff(ds_list_find_value(targets, i), "TheRapper", ds_map_find_value(obj_AttackController.Buffs, "TheRapper"), arg1);
                }
                ds_list_destroy(targets);
                targets = -1;
            },
            
            config: 
            {
                amount: global.SkillData.TheRapper.amount[0],
                range: global.SkillData.TheRapper.distance[0],
                crit: false,
                circleTime: 0
            }
        };
    }
    
    playerCharacter.customDrawScriptAbove.TheRapper = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.TheRapper.config.circleTime += 0.5;
            if (arg0.scripts.TheRapper.config.circleTime >= (arg0.scripts.TheRapper.config.range / 1.5))
            {
                arg0.scripts.TheRapper.config.circleTime = 0;
            }
            draw_set_color(c_red);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheRapper.config.range - arg0.scripts.TheRapper.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheRapper.config.range, true);
        }
    };
}, function()
{
    playerCharacter.scripts.TheRapper.config.amount = global.SkillData.TheRapper.amount[1];
    playerCharacter.scripts.TheRapper.config.range = global.SkillData.TheRapper.distance[1];
}, function()
{
    playerCharacter.scripts.TheRapper.config.amount = global.SkillData.TheRapper.amount[2];
    playerCharacter.scripts.TheRapper.config.range = global.SkillData.TheRapper.distance[2];
    playerCharacter.scripts.TheRapper.config.crit = true;
}];
ds_map_set(PERKS, "TheRapper", new Perk("TheRapper", 
{
    optionName: global.TextContainer.TheRapperName.selectedLanguage,
    optionIcon: 109,
    optionDescription: global.TextContainer.TheRapperDescription.selectedLanguage[0]
}, TheRapperOnApply));
var WorkaholicOnApply = [function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: global.SkillData.Workaholic.ATK[0],
        buffSpeed: false
    };
    
    playerCharacter.onKill.Workaholic = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            weight: global.SkillData.Workaholic.ATK[0],
            buffSpeed: false
        };
        ac.ApplyBuff(arg0, "Workaholic", ds_map_find_value(ac.Buffs, "Workaholic"), buffConfig);
        
        arg0.customDrawScriptAbove.Workaholic = function(arg0)
        {
            var FXimage_index;
            if (variable_struct_exists(arg0.buffs, "Workaholic"))
            {
                gpu_set_blendmode(bm_add);
                var fxStrength = (arg0.buffs.Workaholic.config.stacks * (0.7 / arg0.buffs.Workaholic.config.maxStacks)) + 0.3;
                arg0.FXimage_index++;
                draw_sprite_ext(spr_Calli_workaholicFX, arg0.FXimage_index / 4, arg0.x, arg0.y, 1.5, 1.5, 0, c_white, fxStrength);
                gpu_set_blendmode(bm_normal);
            }
        };
    };
    
    UpdateBuffIfExists("Workaholic", buffConfig);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: global.SkillData.Workaholic.ATK[1],
        buffSpeed: false
    };
    
    playerCharacter.onKill.Workaholic = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            weight: global.SkillData.Workaholic.ATK[1],
            buffSpeed: false
        };
        ac.ApplyBuff(arg0, "Workaholic", ds_map_find_value(ac.Buffs, "Workaholic"), buffConfig);
        
        arg0.customDrawScriptAbove.Workaholic = function(arg0)
        {
            var FXimage_index;
            if (variable_struct_exists(arg0.buffs, "Workaholic"))
            {
                gpu_set_blendmode(bm_add);
                var fxStrength = (arg0.buffs.Workaholic.config.stacks * (0.7 / arg0.buffs.Workaholic.config.maxStacks)) + 0.3;
                arg0.FXimage_index++;
                draw_sprite_ext(spr_Calli_workaholicFX, arg0.FXimage_index / 4, arg0.x, arg0.y, 1.5, 1.5, 0, c_white, fxStrength);
                gpu_set_blendmode(bm_normal);
            }
        };
    };
    
    UpdateBuffIfExists("Workaholic", buffConfig);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: global.SkillData.Workaholic.ATK[2],
        buffSpeed: true
    };
    
    playerCharacter.onKill.Workaholic = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            weight: global.SkillData.Workaholic.ATK[2],
            buffSpeed: true
        };
        ac.ApplyBuff(arg0, "Workaholic", ds_map_find_value(ac.Buffs, "Workaholic"), buffConfig);
        
        arg0.customDrawScriptAbove.Workaholic = function(arg0)
        {
            var FXimage_index;
            if (variable_struct_exists(arg0.buffs, "Workaholic"))
            {
                gpu_set_blendmode(bm_add);
                var fxStrength = (arg0.buffs.Workaholic.config.stacks * (0.7 / arg0.buffs.Workaholic.config.maxStacks)) + 0.3;
                arg0.FXimage_index++;
                draw_sprite_ext(spr_Calli_workaholicFX, arg0.FXimage_index / 4, arg0.x, arg0.y, 1.5, 1.5, 0, c_white, fxStrength);
                gpu_set_blendmode(bm_normal);
            }
        };
    };
    
    UpdateBuffIfExists("Workaholic", buffConfig);
}];
ds_map_set(PERKS, "Workaholic", new Perk("Workaholic", 
{
    optionIcon: 1734,
    optionName: global.TextContainer.WorkaholicName.selectedLanguage,
    optionDescription: global.TextContainer.WorkaholicDescription.selectedLanguage[0]
}, WorkaholicOnApply));
var TheVoidOnApply = [function()
{
    playerCharacter.scripts.TheVoid = 
    {
        Script: function(arg0)
        {
            var debuffTargets = ds_list_create();
            var radius = global.SkillData.TheVoid.distance[0];
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg0.x, arg0.y, radius, obj_Enemy, true, true, debuffTargets, false);
            }
            for (var i = 0; i < ds_list_size(debuffTargets); i++)
            {
                var target = ds_list_find_value(debuffTargets, i);
                obj_AttackController.ApplyBuff(target, "TheVoid", ds_map_find_value(obj_AttackController.Buffs, "TheVoid"), 
                {
                    amount: global.SkillData.TheVoid.SPD[0],
                    damage: global.SkillData.TheVoid.damage[0],
                    reapply: true,
                    maxTimer: 60,
                    timer: 0
                });
            }
            ds_list_destroy(debuffTargets);
            debuffTargets = -1;
        },
        
        config: 
        {
            circleTime: 0,
            radius: global.SkillData.TheVoid.distance[0]
        }
    };
    
    playerCharacter.customDrawScriptAbove.TheVoid = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.TheVoid.config.circleTime += 0.5;
            if (arg0.scripts.TheVoid.config.circleTime >= (arg0.scripts.TheVoid.config.radius / 1.5))
            {
                arg0.scripts.TheVoid.config.circleTime = 0;
            }
            draw_set_color(c_purple);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheVoid.config.radius - arg0.scripts.TheVoid.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheVoid.config.radius, true);
        }
    };
}, function()
{
    playerCharacter.scripts.TheVoid = 
    {
        Script: function(arg0)
        {
            var debuffTargets = ds_list_create();
            var radius = global.SkillData.TheVoid.distance[1];
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg0.x, arg0.y, radius, obj_Enemy, true, true, debuffTargets, false);
            }
            for (var i = 0; i < ds_list_size(debuffTargets); i++)
            {
                var target = ds_list_find_value(debuffTargets, i);
                obj_AttackController.ApplyBuff(target, "TheVoid", ds_map_find_value(obj_AttackController.Buffs, "TheVoid"), 
                {
                    amount: global.SkillData.TheVoid.SPD[1],
                    damage: global.SkillData.TheVoid.damage[1],
                    reapply: true,
                    maxTimer: 60,
                    timer: 0
                });
            }
            ds_list_destroy(debuffTargets);
            debuffTargets = -1;
        },
        
        config: 
        {
            circleTime: 0,
            radius: global.SkillData.TheVoid.distance[1]
        }
    };
    
    playerCharacter.customDrawScriptAbove.TheVoid = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.TheVoid.config.circleTime += 0.5;
            if (arg0.scripts.TheVoid.config.circleTime >= (arg0.scripts.TheVoid.config.radius / 1.5))
            {
                arg0.scripts.TheVoid.config.circleTime = 0;
            }
            draw_set_color(c_purple);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheVoid.config.radius - arg0.scripts.TheVoid.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheVoid.config.radius, true);
        }
    };
}, function()
{
    playerCharacter.scripts.TheVoid = 
    {
        Script: function(arg0)
        {
            var debuffTargets = ds_list_create();
            var radius = global.SkillData.TheVoid.distance[2];
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg0.x, arg0.y, radius, obj_Enemy, true, true, debuffTargets, false);
            }
            for (var i = 0; i < ds_list_size(debuffTargets); i++)
            {
                var target = ds_list_find_value(debuffTargets, i);
                obj_AttackController.ApplyBuff(target, "TheVoid", ds_map_find_value(obj_AttackController.Buffs, "TheVoid"), 
                {
                    amount: global.SkillData.TheVoid.SPD[2],
                    damage: global.SkillData.TheVoid.damage[2],
                    reapply: true,
                    maxTimer: 60,
                    timer: 0
                });
            }
            ds_list_destroy(debuffTargets);
            debuffTargets = -1;
        },
        
        config: 
        {
            circleTime: 0,
            radius: global.SkillData.TheVoid.distance[2]
        }
    };
    
    playerCharacter.customDrawScriptAbove.TheVoid = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.TheVoid.config.circleTime += 0.5;
            if (arg0.scripts.TheVoid.config.circleTime >= (arg0.scripts.TheVoid.config.radius / 1.5))
            {
                arg0.scripts.TheVoid.config.circleTime = 0;
            }
            draw_set_color(c_purple);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheVoid.config.radius - arg0.scripts.TheVoid.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.TheVoid.config.radius, true);
        }
    };
}];
ds_map_set(PERKS, "TheVoid", new Perk("TheVoid", 
{
    optionName: global.TextContainer.TheVoidName.selectedLanguage,
    optionIcon: 1413,
    optionDescription: global.TextContainer.TheVoidDescription.selectedLanguage[0]
}, TheVoidOnApply));

function CultStepBuffApply(arg0, arg1)
{
    var enemies = ds_list_create();
    var amountOfEnemies = 0;
    if (instance_exists(obj_Enemy))
    {
        amountOfEnemies = collision_circle_list(arg0.x, arg0.y, 150, obj_Enemy, true, true, enemies, false);
    }
    if (amountOfEnemies > arg1.maxAmount)
    {
        amountOfEnemies = arg1.maxAmount;
    }
    arg0.ATK += arg1.amount * amountOfEnemies;
    ds_list_destroy(enemies);
    enemies = -1;
}

var CultOnApply = [function()
{
    playerCharacter.onHitEffects.ForbiddenWah = 
    {
        multiplier: global.SkillData.Cult.multiplier[0]
    };
}, function()
{
    playerCharacter.onHitEffects.ForbiddenWah = 
    {
        multiplier: global.SkillData.Cult.multiplier[1]
    };
}, function()
{
    playerCharacter.onHitEffects.ForbiddenWah = 
    {
        multiplier: global.SkillData.Cult.multiplier[2]
    };
}];
ds_map_set(PERKS, "Cult", new Perk("Cult", 
{
    optionName: global.TextContainer.CultName.selectedLanguage,
    optionIcon: 77,
    optionDescription: global.TextContainer.CultDescription.selectedLanguage[0]
}, CultOnApply));
var TheAncientOneOnApply = [function()
{
    if (!variable_struct_exists(weapons, "TheAncientOne"))
    {
        if (!instance_exists(obj_Summon))
        {
            obj_PlayerManager.playerSummon = obj_MobManager.CreateSummon("AncientOne");
        }
        weapons.TheAncientOne = 
        {
            level: 0,
            id: "TheAncientOne"
        };
        AddAttack("TheAncientOne");
        InitializeAttack(ds_map_find_value(playerCharacter.attacks, "TheAncientOne"));
        ds_map_find_value(playerCharacter.attacks, "TheAncientOne").config.level = 1;
        weapons.TheAncientOne.level = 1;
    }
}, function()
{
    if (weapons.TheAncientOne.level == 1)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "TheAncientOne").timer;
        AddAttack("TheAncientOne");
        ds_map_find_value(playerCharacter.attacks, "TheAncientOne").timer = oldTimer;
    }
}, function()
{
    if (weapons.TheAncientOne.level == 2)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "TheAncientOne").timer;
        AddAttack("TheAncientOne");
        ds_map_find_value(playerCharacter.attacks, "TheAncientOne").timer = oldTimer;
    }
}];
ds_map_set(PERKS, "TheAncientOne", new Perk("TheAncientOne", 
{
    optionName: global.TextContainer.TheAncientOneName.selectedLanguage,
    optionDescription: global.TextContainer.TheAncientOneDescription.selectedLanguage[0],
    optionIcon: 1347
}, TheAncientOneOnApply));
var TrailblazerOnApply = [function()
{
    playerCharacter.SPD += global.SkillData.Trailblazer.SPD[0];
    playerCharacter.scripts.Trailblazer = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.isMoving && arg1.timer <= 0)
            {
                obj_AttackController.ExecuteAttack("Trailblazer", arg0);
                arg1.timer = arg1.maxTimer;
            }
            else
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
}, function()
{
    playerCharacter.SPD += global.SkillData.Trailblazer.SPD[1];
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.damage = global.SkillData.Trailblazer.damage[1];
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.image_xscale = 1.25;
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.image_yscale = 1.25;
}, function()
{
    playerCharacter.SPD += global.SkillData.Trailblazer.SPD[2];
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.damage = global.SkillData.Trailblazer.damage[2];
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.image_xscale = 1.5;
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.image_yscale = 1.5;
    ds_map_find_value(obj_AttackController.attackIndex, "Trailblazer").config.onHitEffects.Trailblazer = 0;
}];
ds_map_set(PERKS, "Trailblazer", new Perk("Trailblazer", 
{
    optionName: global.TextContainer.TrailblazerName.selectedLanguage,
    optionDescription: global.TextContainer.TrailblazerDescription.selectedLanguage[0],
    optionIcon: 332
}, TrailblazerOnApply));
var DancerOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Dancer"))
    {
        playerCharacter.scripts.Dancer = 
        {
            Script: function(arg0, arg1)
            {
                var timer, healTimer;
                if (arg1.timer < 1 && arg0.isMoving)
                {
                    var buffConfig = {};
                    var keys = variable_struct_get_names(arg1.buffConfig);
                    variable_struct_copy(arg1.buffConfig, buffConfig);
                    obj_AttackController.ApplyBuff(arg0, "Dancer", ds_map_find_value(obj_AttackController.Buffs, "Dancer"), buffConfig);
                    arg1.timer = arg1.maxTimer;
                    
                    arg0.customDrawScriptAbove.Dancer = function(arg0)
                    {
                        var FXimage_index;
                        gpu_set_blendmode(bm_add);
                        arg0.FXimage_index++;
                        var fxStrength = (arg0.buffs.Dancer.config.stacks * (0.7 / arg0.buffs.Dancer.config.maxStacks)) + 0.3;
                        draw_sprite_ext(spr_Kiara_dancerFX, arg0.FXimage_index / 4, arg0.x, arg0.y, arg0.image_xscale, arg0.image_yscale, 0, c_white, fxStrength);
                        draw_set_alpha(1);
                        gpu_set_blendmode(bm_normal);
                    };
                }
                else if (arg0.isMoving)
                {
                    arg1.timer--;
                }
                if (arg1.healTimer < 1 && arg0.isMoving)
                {
                    arg1.healTimer = arg1.healMaxTimer;
                    Heal(arg0, arg0.HP * 0.05, 1, true, false);
                }
                else if (arg0.isMoving)
                {
                    arg1.healTimer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 60,
                healTimer: 300,
                healMaxTimer: 300,
                buffConfig: 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: 20,
                    weight: global.SkillData.Dancer.ATK[0],
                    buffCrit: false,
                    loseStackOnRemove: true
                }
            }
        };
    }
}, function()
{
    playerCharacter.scripts.Dancer.config.buffConfig.weight = global.SkillData.Dancer.ATK[1];
    UpdateBuffIfExists("Dancer", playerCharacter.scripts.Dancer.config.buffConfig);
}, function()
{
    playerCharacter.scripts.Dancer.config.buffConfig.weight = global.SkillData.Dancer.ATK[2];
    playerCharacter.scripts.Dancer.config.buffConfig.buffCrit = true;
    UpdateBuffIfExists("Dancer", playerCharacter.scripts.Dancer.config.buffConfig);
}];
ds_map_set(PERKS, "Dancer", new Perk("Dancer", 
{
    optionName: global.TextContainer.DancerName.selectedLanguage,
    optionDescription: global.TextContainer.DancerDescription.selectedLanguage[0],
    optionIcon: 1806
}, DancerOnApply));

function _PhoenixShieldInvincibility(arg0)
{
    arg0.invincible = true;
    arg0.invincibilityTimer = arg0.scripts.PhoenixShield.config.duration;
}

var PhoenixShieldOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.onTakeDamage, "PhoenixShield"))
    {
        playerCharacter.onTakeDamage.PhoenixShield = function(arg0, arg1, arg2, arg3)
        {
            if (playerCharacter.scripts.PhoenixShield.config.amount > 0 && playerCharacter.invincibilityTimer == 0 && playerCharacter.shieldHP == 0)
            {
                playerCharacter.delayedCallbacks.PhoenixShield = 
                {
                    config: {},
                    timer: 1,
                    maxTimer: 1,
                    amount: 1,
                    Func: _PhoenixShieldInvincibility
                };
                playerCharacter.scripts.PhoenixShield.config.amount--;
                arg0 *= 0.5;
                arg0 = round(arg0);
                if (variable_instance_exists(playerCharacter.buffs, "PhoenixShield"))
                {
                    playerCharacter.buffs.PhoenixShield.config.stacks--;
                    if (playerCharacter.buffs.PhoenixShield.config.stacks < 1)
                    {
                        obj_AttackController.RemoveBuff(playerCharacter, "PhoenixShield");
                    }
                }
                if (playerCharacter.scripts.PhoenixShield.config.amount == 0)
                {
                    variable_struct_remove(playerCharacter.customDrawScriptAbove, "PhoenixShield");
                }
            }
            return arg0;
        };
    }
    if (!variable_struct_exists(playerCharacter.scripts, "PhoenixShield"))
    {
        playerCharacter.scripts.PhoenixShield = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer < 1 && arg0.invincible == false && arg1.amount != arg1.maxAmount)
                {
                    arg1.amount = arg1.maxAmount;
                    arg1.timer = arg1.maxTimer;
                    var buffConfig = 
                    {
                        reapply: true,
                        buffIcon: 975,
                        stacks: arg1.amount,
                        maxStacks: arg1.maxAmount
                    };
                    obj_AttackController.ApplyBuff(arg0, "PhoenixShield", ds_map_find_value(obj_AttackController.Buffs, "PhoenixShield"), buffConfig);
                    
                    arg0.customDrawScriptAbove.PhoenixShield = function(arg0)
                    {
                        gpu_set_blendmode(bm_add);
                        draw_set_alpha((config.amount * 0.1) + 0.1);
                        draw_set_colour(make_color_rgb(224, 105, 49));
                        draw_circle(arg0.x, arg0.y - 16, 14 + (2 * config.amount), false);
                        draw_set_alpha(1);
                        gpu_set_blendmode(bm_normal);
                    };
                }
                else if (arg1.timer > 0 && arg0.invincible == false)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                amount: 0,
                duration: 15,
                maxAmount: 1,
                timer: 600,
                maxTimer: max(1, 600 * (1 / (1 + (playerCharacter.haste / 100))))
            }
        };
    }
}, function()
{
    playerCharacter.scripts.PhoenixShield.config.maxAmount = 2;
}, function()
{
    playerCharacter.scripts.PhoenixShield.config.maxAmount = 3;
}];
ds_map_set(PERKS, "PhoenixShield", new Perk("PhoenixShield", 
{
    optionName: global.TextContainer.PhoenixShieldName.selectedLanguage,
    optionDescription: global.TextContainer.PhoenixShieldDescription.selectedLanguage[0],
    optionIcon: 975
}, PhoenixShieldOnApply));
var HalfAngelOnApply = [function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 1
    };
    
    playerCharacter.onCriticalHit.HalfAngel = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: global.SkillData.HalfAngel.heal[0]
        };
        var roll = irandom(99);
        if (arg0.scripts.HalfAngel.config.timer == 0)
        {
            if (roll < global.SkillData.HalfAngel.chance[0])
            {
                Heal(arg0, floor(buffConfig.weight), 1);
                arg0.scripts.HalfAngel.config.timer = arg0.scripts.HalfAngel.config.maxTimer;
            }
        }
        return arg3;
    };
    
    playerCharacter.scripts.HalfAngel = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.HalfAngel.config.timer > 0)
            {
                arg0.scripts.HalfAngel.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.HalfAngel.heal[1]
    };
    
    playerCharacter.onCriticalHit.HalfAngel = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 2
        };
        var roll = irandom(99);
        if (arg0.scripts.HalfAngel.config.timer == 0)
        {
            if (roll < global.SkillData.HalfAngel.chance[1])
            {
                Heal(arg0, floor(buffConfig.weight), 1);
                arg0.scripts.HalfAngel.config.timer = arg0.scripts.HalfAngel.config.maxTimer;
            }
        }
        return arg3;
    };
    
    playerCharacter.scripts.HalfAngel = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.HalfAngel.config.timer > 0)
            {
                arg0.scripts.HalfAngel.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.HalfAngel.heal[2]
    };
    
    playerCharacter.onCriticalHit.HalfAngel = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 3
        };
        var roll = irandom(99);
        if (arg0.scripts.HalfAngel.config.timer == 0)
        {
            if (roll < global.SkillData.HalfAngel.chance[2])
            {
                Heal(arg0, floor(buffConfig.weight), 1);
                arg0.scripts.HalfAngel.config.timer = arg0.scripts.HalfAngel.config.maxTimer;
            }
        }
        return arg3;
    };
    
    playerCharacter.scripts.HalfAngel = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.HalfAngel.config.timer > 0)
            {
                arg0.scripts.HalfAngel.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
}];
ds_map_set(PERKS, "HalfAngel", new Perk("HalfAngel", 
{
    optionName: global.TextContainer.HalfAngelName.selectedLanguage,
    optionIcon: 1798,
    optionDescription: global.TextContainer.HalfAngelDescription.selectedLanguage[0]
}, HalfAngelOnApply));
var HalfDemonOnApply = [function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.HalfDemon.ATK[0]
    };
    
    playerCharacter.onHeal.HalfDemon = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: global.SkillData.HalfDemon.ATK[0]
        };
        ac.ApplyBuff(arg1, "HalfDemon", ds_map_find_value(ac.Buffs, "HalfDemon"), buffConfig);
        return arg0;
    };
    
    UpdateBuffIfExists("HalfDemon", buffConfig);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.HalfDemon.ATK[1]
    };
    
    playerCharacter.onHeal.HalfDemon = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: global.SkillData.HalfDemon.ATK[1]
        };
        ac.ApplyBuff(arg1, "HalfDemon", ds_map_find_value(ac.Buffs, "HalfDemon"), buffConfig);
        return arg0;
    };
    
    UpdateBuffIfExists("HalfDemon", buffConfig);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.HalfDemon.ATK[2]
    };
    
    playerCharacter.onHeal.HalfDemon = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: global.SkillData.HalfDemon.ATK[2]
        };
        ac.ApplyBuff(arg1, "HalfDemon", ds_map_find_value(ac.Buffs, "HalfDemon"), buffConfig);
        return arg0;
    };
    
    UpdateBuffIfExists("HalfDemon", buffConfig);
}];
ds_map_set(PERKS, "HalfDemon", new Perk("HalfDemon", 
{
    optionName: global.TextContainer.HalfDemonName.selectedLanguage,
    optionIcon: 90,
    optionDescription: global.TextContainer.HalfDemonDescription.selectedLanguage[0]
}, HalfDemonOnApply));
var HopeOnApply = [function()
{
    playerCharacter.crit += global.SkillData.Hope.crit[0];
    playerCharacter.scripts.Hope = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 30
        }
    };
    
    playerCharacter.onTakeDamage.Hope = function(arg0, arg1, arg2, arg3)
    {
        if (variable_struct_exists(arg3.scripts, "Hope") && arg3.scripts.Hope.config.timer == 0)
        {
            if (arg3.invincible)
            {
                return arg0;
            }
            if (arg3.shieldHP > 0)
            {
                return arg0;
            }
            var healChance = global.SkillData.Hope.chance[0];
            var roll = irandom(99);
            if (roll < healChance)
            {
                var val = floor(arg3.HP * global.SkillData.Hope.heal[0]);
                Heal(arg3, val, 1);
                obj_AttackController.ExecuteAttack("HopeExplode", arg3);
                arg3.scripts.Hope.config.timer = arg3.scripts.Hope.config.maxTimer;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.crit += global.SkillData.Hope.crit[1];
    
    playerCharacter.onTakeDamage.Hope = function(arg0, arg1, arg2, arg3)
    {
        if (variable_struct_exists(arg3.scripts, "Hope") && arg3.scripts.Hope.config.timer == 0)
        {
            if (arg3.invincible)
            {
                return arg0;
            }
            if (arg3.shieldHP > 0)
            {
                return arg0;
            }
            var healChance = global.SkillData.Hope.chance[1];
            var roll = irandom(99);
            if (roll < healChance)
            {
                var val = floor(arg3.HP * global.SkillData.Hope.heal[1]);
                Heal(arg3, val, 1);
                obj_AttackController.ExecuteAttack("HopeExplode", arg3);
                arg3.scripts.Hope.config.timer = arg3.scripts.Hope.config.maxTimer;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.crit += global.SkillData.Hope.crit[2];
    
    playerCharacter.onTakeDamage.Hope = function(arg0, arg1, arg2, arg3)
    {
        if (variable_struct_exists(arg3.scripts, "Hope") && arg3.scripts.Hope.config.timer == 0)
        {
            if (arg3.invincible)
            {
                return arg0;
            }
            if (arg3.shieldHP > 0)
            {
                return arg0;
            }
            var healChance = global.SkillData.Hope.chance[2];
            var roll = irandom(99);
            if (roll < healChance)
            {
                var val = floor(arg3.HP * global.SkillData.Hope.heal[2]);
                Heal(arg3, val, 1);
                obj_AttackController.ExecuteAttack("HopeExplode", arg3);
                arg3.scripts.Hope.config.timer = arg3.scripts.Hope.config.maxTimer;
            }
        }
        return arg0;
    };
}];
ds_map_set(PERKS, "Hope", new Perk("Hope", 
{
    optionName: global.TextContainer.HopeName.selectedLanguage,
    optionIcon: 547,
    optionDescription: global.TextContainer.HopeDescription.selectedLanguage[0]
}, HopeOnApply));
var CRaticalHitOnApply = [function()
{
    playerCharacter.onCriticalHit.CRaticalHit = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var secondRoll = irandom(100);
        if (secondRoll <= arg0.crit)
        {
            if (!variable_instance_exists(arg1, "CRatBuffed"))
            {
                if (!variable_instance_exists(arg1, "CritMod"))
                {
                    arg1.CritMod = 0;
                }
                arg1.CritMod += 0.5;
                arg1.CRatBuffed = true;
            }
        }
        return arg3;
    };
}, function()
{
    playerCharacter.onCriticalHit.CRaticalHit = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var secondRoll = irandom(100);
        if (secondRoll <= arg0.crit)
        {
            if (!variable_instance_exists(arg1, "CRatBuffed"))
            {
                if (!variable_instance_exists(arg1, "CritMod"))
                {
                    arg1.CritMod = 0;
                }
                arg1.CritMod += 1.5;
                arg1.CRatBuffed = true;
            }
        }
        return arg3;
    };
}, function()
{
    playerCharacter.onCriticalHit.CRaticalHit = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var secondRoll = irandom(100);
        if (secondRoll <= arg0.crit)
        {
            if (!variable_instance_exists(arg1, "CRatBuffed"))
            {
                if (!variable_instance_exists(arg1, "CritMod"))
                {
                    arg1.CritMod = 0;
                }
                arg1.CritMod += 2.5;
                arg1.CRatBuffed = true;
            }
        }
        return arg3;
    };
}];
ds_map_set(PERKS, "CRaticalHit", new Perk("CRaticalHit", 
{
    optionIcon: 1737,
    optionName: global.TextContainer.CRaticalHitName.selectedLanguage,
    optionDescription: global.TextContainer.CRaticalHitDescription.selectedLanguage[0]
}, CRaticalHitOnApply));
var DownUnderOnApply = [function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DownUnder", 
    {
        chance: 10,
        vuln: 0,
        resist: 420
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DownUnder", 
    {
        chance: 15,
        vuln: 0,
        resist: 420
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DownUnder", 
    {
        chance: 20,
        vuln: 0,
        resist: 420
    });
}];
ds_map_set(PERKS, "DownUnder", new Perk("DownUnder", 
{
    optionIcon: 569,
    optionName: global.TextContainer.DownUnderName.selectedLanguage,
    optionDescription: global.TextContainer.DownUnderDescription.selectedLanguage[0]
}, DownUnderOnApply));
var RatNGOnApply = [function()
{
    playerCharacter.ATK -= 0.15;
    playerCharacter.crit += 30;
}, function()
{
    playerCharacter.ATK -= 0.07;
    playerCharacter.crit += 30;
}, function()
{
    playerCharacter.crit += 30;
}];
ds_map_set(PERKS, "RatNG", new Perk("RatNG", 
{
    optionIcon: 649,
    optionName: global.TextContainer.RatNGName.selectedLanguage,
    optionDescription: global.TextContainer.RatNGDescription.selectedLanguage[0]
}, RatNGOnApply));

function CivilizationStepBuffApply(arg0, arg1)
{
    var enemies = ds_list_create();
    var amountOfEnemies = 0;
    var amountInView = 0;
    if (instance_exists(obj_Enemy))
    {
        amountOfEnemies = collision_circle_list(arg0.x, arg0.y, 320, obj_Enemy, true, true, enemies, false);
        for (var i = 0; i < amountOfEnemies; i++)
        {
            if (ds_list_find_value(enemies, i).inView)
            {
                amountInView++;
            }
        }
    }
    ds_list_destroy(enemies);
    enemies -= -1;
    if (amountInView > arg1.maxAmount)
    {
        amountInView = arg1.maxAmount;
    }
    arg0.ATK += arg1.amount * amountInView;
    arg0.ATK += global.SkillData.Civilization.ATK2 * floor(global.enemyDefeated / global.SkillData.Civilization.History);
}

var CivilizationOnApply = [function()
{
    playerCharacter.stepBuffs.Civilization = 
    {
        Apply: CivilizationStepBuffApply,
        config: 
        {
            amount: global.SkillData.Civilization.ATK[0],
            maxAmount: 100
        }
    };
}, function()
{
    playerCharacter.stepBuffs.Civilization = 
    {
        Apply: CivilizationStepBuffApply,
        config: 
        {
            amount: global.SkillData.Civilization.ATK[1],
            maxAmount: 80
        }
    };
}, function()
{
    playerCharacter.stepBuffs.Civilization = 
    {
        Apply: CivilizationStepBuffApply,
        config: 
        {
            amount: global.SkillData.Civilization.ATK[2],
            maxAmount: 75
        }
    };
}];
ds_map_set(PERKS, "Civilization", new Perk("Civilization", 
{
    optionName: global.TextContainer.CivilizationName.selectedLanguage,
    optionIcon: 2087,
    optionDescription: global.TextContainer.CivilizationDescription.selectedLanguage[0]
}, CivilizationOnApply));
var FriendOnApply = [function()
{
    if (!instance_exists(obj_Summon))
    {
        obj_PlayerManager.playerSummon = obj_MobManager.CreateSummon("Friend");
        obj_PlayerManager.playerSummon.attackEfficiency = global.SkillData.Friend.damage[0];
    }
}, function()
{
    obj_PlayerManager.playerSummon.attackEfficiency = global.SkillData.Friend.damage[1];
}, function()
{
    obj_PlayerManager.playerSummon.attackEfficiency = global.SkillData.Friend.damage[2];
}];
ds_map_set(PERKS, "Friend", new Perk("Friend", 
{
    optionName: global.TextContainer.FriendName.selectedLanguage,
    optionIcon: 1545,
    optionDescription: global.TextContainer.FriendDescription.selectedLanguage[0]
}, FriendOnApply));
var HistoryOnApply = [function()
{
    playerCharacter.onKill.History = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            buffIcon: 767
        };
        if (!variable_struct_exists(arg0.buffs, "Bloodthirst2"))
        {
            ac.ApplyBuff(arg0, "Bloodthirst", ds_map_find_value(ac.Buffs, "Bloodthirst"), buffConfig);
            var bloodColor = make_color_rgb(255, 255 - (5 * arg0.buffs.Bloodthirst.config.stacks), 255 - (5 * arg0.buffs.Bloodthirst.config.stacks));
            arg0.spriteColor = bloodColor;
            if (variable_struct_exists(arg0.buffs, "Bloodthirst"))
            {
                if (arg0.buffs.Bloodthirst.config.stacks > 19)
                {
                    ac.RemoveBuff(arg0, "Bloodthirst");
                    Heal(arg0, arg0.HP * global.SkillData.History.heal, 0);
                    var buffConfig2 = 
                    {
                        weight: global.SkillData.History.ATK[0],
                        buffIcon: 221
                    };
                    ac.ApplyBuff(arg0, "Bloodthirst2", ds_map_find_value(ac.Buffs, "Bloodthirst2"), buffConfig2);
                }
            }
        }
    };
}, function()
{
    playerCharacter.onKill.History = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            buffIcon: 767
        };
        if (!variable_struct_exists(arg0.buffs, "Bloodthirst2"))
        {
            ac.ApplyBuff(arg0, "Bloodthirst", ds_map_find_value(ac.Buffs, "Bloodthirst"), buffConfig);
            var bloodColor = make_color_rgb(255, 255 - (5 * arg0.buffs.Bloodthirst.config.stacks), 255 - (5 * arg0.buffs.Bloodthirst.config.stacks));
            arg0.spriteColor = bloodColor;
            if (variable_struct_exists(arg0.buffs, "Bloodthirst"))
            {
                if (arg0.buffs.Bloodthirst.config.stacks > 19)
                {
                    ac.RemoveBuff(arg0, "Bloodthirst");
                    Heal(arg0, arg0.HP * global.SkillData.History.heal, 0);
                    var buffConfig2 = 
                    {
                        weight: global.SkillData.History.ATK[1],
                        buffIcon: 221
                    };
                    ac.ApplyBuff(arg0, "Bloodthirst2", ds_map_find_value(ac.Buffs, "Bloodthirst2"), buffConfig2);
                }
            }
        }
    };
}, function()
{
    playerCharacter.onKill.History = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            buffIcon: 767
        };
        if (!variable_struct_exists(arg0.buffs, "Bloodthirst2"))
        {
            ac.ApplyBuff(arg0, "Bloodthirst", ds_map_find_value(ac.Buffs, "Bloodthirst"), buffConfig);
            var bloodColor = make_color_rgb(255, 255 - (5 * arg0.buffs.Bloodthirst.config.stacks), 255 - (5 * arg0.buffs.Bloodthirst.config.stacks));
            arg0.spriteColor = bloodColor;
            if (variable_struct_exists(arg0.buffs, "Bloodthirst"))
            {
                if (arg0.buffs.Bloodthirst.config.stacks > 19)
                {
                    ac.RemoveBuff(arg0, "Bloodthirst");
                    Heal(arg0, arg0.HP * global.SkillData.History.heal, 0);
                    var buffConfig2 = 
                    {
                        weight: global.SkillData.History.ATK[2],
                        buffIcon: 221
                    };
                    ac.ApplyBuff(arg0, "Bloodthirst2", ds_map_find_value(ac.Buffs, "Bloodthirst2"), buffConfig2);
                }
            }
        }
    };
}];
ds_map_set(PERKS, "History", new Perk("History", 
{
    optionName: global.TextContainer.HistoryName.selectedLanguage,
    optionIcon: 767,
    optionDescription: global.TextContainer.HistoryDescription.selectedLanguage[0]
}, HistoryOnApply));
var PerfectionOnApply = [function()
{
    var buffConfig = 
    {
        weight: global.SkillData.Perfection.weight[0],
        weight2: global.SkillData.Perfection.weight2[0]
    };
    playerCharacter.scripts.Perfection = 
    {
        Script: function(arg0, arg1)
        {
            var buffConfig = 
            {
                weight: global.SkillData.Perfection.weight[0],
                weight2: global.SkillData.Perfection.weight2[0]
            };
            if (arg0.currentHP == arg0.HP)
            {
                obj_AttackController.ApplyBuff(arg0, "Perfection", ds_map_find_value(obj_AttackController.Buffs, "Perfection"), buffConfig);
                
                arg0.customDrawScriptAbove.Perfection = function(arg0)
                {
                    var FXimage_index;
                    gpu_set_blendmode(bm_add);
                    arg0.FXimage_index++;
                    draw_sprite_ext(spr_KroniiPerfectionFX, arg0.FXimage_index / 2, arg0.x, arg0.y, 1, 1, 0, c_white, 0.8);
                    gpu_set_blendmode(bm_normal);
                };
            }
            else
            {
                obj_AttackController.RemoveBuff(arg0, "Perfection");
                variable_struct_remove(arg0.customDrawScriptAbove, "Perfection");
            }
        },
        
        config: {}
    };
    UpdateBuffIfExists("Perfection", buffConfig);
}, function()
{
    var buffConfig = 
    {
        weight: global.SkillData.Perfection.weight[1],
        weight2: global.SkillData.Perfection.weight2[1]
    };
    playerCharacter.scripts.Perfection = 
    {
        Script: function(arg0, arg1)
        {
            var buffConfig = 
            {
                weight: global.SkillData.Perfection.weight[1],
                weight2: global.SkillData.Perfection.weight2[1]
            };
            if (arg0.currentHP == arg0.HP)
            {
                obj_AttackController.ApplyBuff(arg0, "Perfection", ds_map_find_value(obj_AttackController.Buffs, "Perfection"), buffConfig);
                
                arg0.customDrawScriptAbove.Perfection = function(arg0)
                {
                    var FXimage_index;
                    gpu_set_blendmode(bm_add);
                    arg0.FXimage_index++;
                    draw_sprite_ext(spr_KroniiPerfectionFX, arg0.FXimage_index / 2, arg0.x, arg0.y, 1, 1, 0, c_white, 0.8);
                    gpu_set_blendmode(bm_normal);
                };
            }
            else
            {
                obj_AttackController.RemoveBuff(arg0, "Perfection");
                variable_struct_remove(arg0.customDrawScriptAbove, "Perfection");
            }
        },
        
        config: {}
    };
    UpdateBuffIfExists("Perfection", buffConfig);
}, function()
{
    var buffConfig = 
    {
        weight: global.SkillData.Perfection.weight[2],
        weight2: global.SkillData.Perfection.weight2[2]
    };
    playerCharacter.scripts.Perfection = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            var buffConfig = 
            {
                weight: global.SkillData.Perfection.weight[2],
                weight2: global.SkillData.Perfection.weight2[2]
            };
            if (arg0.currentHP == arg0.HP)
            {
                obj_AttackController.ApplyBuff(arg0, "Perfection", ds_map_find_value(obj_AttackController.Buffs, "Perfection"), buffConfig);
                
                arg0.customDrawScriptAbove.Perfection = function(arg0)
                {
                    var FXimage_index;
                    gpu_set_blendmode(bm_add);
                    arg0.FXimage_index++;
                    draw_sprite_ext(spr_KroniiPerfectionFX, arg0.FXimage_index / 2, arg0.x, arg0.y, 1, 1, 0, c_white, 0.8);
                    gpu_set_blendmode(bm_normal);
                };
            }
            else
            {
                obj_AttackController.RemoveBuff(arg0, "Perfection");
                variable_struct_remove(arg0.customDrawScriptAbove, "Perfection");
                if (arg1.timer <= 0)
                {
                    Heal(arg0, round(arg0.HP * 0.05), 1);
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
            timer: 0,
            maxTimer: 180
        }
    };
    UpdateBuffIfExists("Perfection", buffConfig);
}];
ds_map_set(PERKS, "Perfection", new Perk("Perfection", 
{
    optionName: global.TextContainer.PerfectionName.selectedLanguage,
    optionIcon: 1218,
    optionDescription: global.TextContainer.PerfectionDescription.selectedLanguage[0]
}, PerfectionOnApply));
var KroniicopterOnApply = [function()
{
    playerCharacter.haste += global.SkillData.Kroniicopter.haste[0];
    playerCharacter.SPD += global.SkillData.Kroniicopter.SPD[0];
    
    playerCharacter.onCriticalHit.Kroniicopter = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight: global.SkillData.Kroniicopter.haste[0]
        };
        if (variable_instance_exists(arg1, "attackID"))
        {
            if (arg1.attackID == "KroniiSmallHand" || arg1.attackID == "KroniiBigHand")
            {
                ac.ApplyBuff(arg0, "Kroniicopter", ds_map_find_value(ac.Buffs, "Kroniicopter"), buffConfig);
            }
        }
        return arg3;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight: global.SkillData.Kroniicopter.haste[0]
    };
    UpdateBuffIfExists("Kroniicopter", buffConfig);
}, function()
{
    playerCharacter.haste += global.SkillData.Kroniicopter.haste[1];
    playerCharacter.SPD += global.SkillData.Kroniicopter.SPD[1];
    
    playerCharacter.onCriticalHit.Kroniicopter = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight: global.SkillData.Kroniicopter.haste[1]
        };
        if (variable_instance_exists(arg1, "attackID"))
        {
            if (arg1.attackID == "KroniiSmallHand" || arg1.attackID == "KroniiBigHand")
            {
                ac.ApplyBuff(arg0, "Kroniicopter", ds_map_find_value(ac.Buffs, "Kroniicopter"), buffConfig);
            }
        }
        return arg3;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight: global.SkillData.Kroniicopter.haste[1]
    };
    UpdateBuffIfExists("Kroniicopter", buffConfig);
}, function()
{
    playerCharacter.haste += global.SkillData.Kroniicopter.haste[2];
    playerCharacter.SPD += global.SkillData.Kroniicopter.SPD[2];
    
    playerCharacter.onCriticalHit.Kroniicopter = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight: global.SkillData.Kroniicopter.haste[2]
        };
        if (variable_instance_exists(arg1, "attackID"))
        {
            if (arg1.attackID == "KroniiSmallHand" || arg1.attackID == "KroniiBigHand")
            {
                ac.ApplyBuff(arg0, "Kroniicopter", ds_map_find_value(ac.Buffs, "Kroniicopter"), buffConfig);
            }
        }
        return arg3;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight: global.SkillData.Kroniicopter.haste[2]
    };
    UpdateBuffIfExists("Kroniicopter", buffConfig);
}];
ds_map_set(PERKS, "Kroniicopter", new Perk("Kroniicopter", 
{
    optionName: global.TextContainer.KroniicopterName.selectedLanguage,
    optionIcon: 1430,
    optionDescription: global.TextContainer.KroniicopterDescription.selectedLanguage[0]
}, KroniicopterOnApply));
var TimeBubbleOnApply = [function()
{
    if (!variable_struct_exists(weapons, "TimeBubble"))
    {
        weapons.TimeBubble = 
        {
            level: 0,
            id: "TimeBubble"
        };
        AddAttack("TimeBubble");
        InitializeAttack(ds_map_find_value(playerCharacter.attacks, "TimeBubble"));
        ds_map_find_value(playerCharacter.attacks, "TimeBubble").config.level = 1;
        weapons.TimeBubble.level = 1;
    }
}, function()
{
    if (weapons.TimeBubble.level == 1)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "TimeBubble").timer;
        AddAttack("TimeBubble");
        ds_map_find_value(playerCharacter.attacks, "TimeBubble").timer = oldTimer;
    }
}, function()
{
    if (weapons.TimeBubble.level == 2)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "TimeBubble").timer;
        AddAttack("TimeBubble");
        ds_map_find_value(playerCharacter.attacks, "TimeBubble").timer = oldTimer;
    }
}];
ds_map_set(PERKS, "TimeBubble", new Perk("TimeBubble", 
{
    optionName: global.TextContainer.TimeBubbleName.selectedLanguage,
    optionIcon: 833,
    optionDescription: global.TextContainer.TimeBubbleDescription.selectedLanguage[0]
}, TimeBubbleOnApply));

function _WhispererInvincibility(arg0)
{
    arg0.invincible = true;
    arg0.invincibilityTimer = arg0.scripts.Whisperer.config.duration;
}

var WhispererOnApply = [function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 3
    };
    UpdateBuffIfExists("Whisperer", buffConfig);
    if (!variable_struct_exists(playerCharacter.onTakeDamage, "Whisperer"))
    {
        playerCharacter.onTakeDamage.Whisperer = function(arg0, arg1, arg2, arg3)
        {
            if (playerCharacter.invincible)
            {
                return arg0;
            }
            if (playerCharacter.scripts.Whisperer.config.amount > 0 && playerCharacter.invincibilityTimer == 0)
            {
                playerCharacter.delayedCallbacks.Whisperer = 
                {
                    config: {},
                    timer: 1,
                    maxTimer: 1,
                    amount: 1,
                    Func: _WhispererInvincibility
                };
                playerCharacter.scripts.Whisperer.config.amount--;
                playerCharacter.buffs.Whisperer.config.stacks--;
                arg0 = 0;
                arg0 = round(arg0);
                if (playerCharacter.scripts.Whisperer.config.amount == 0)
                {
                    variable_struct_remove(playerCharacter.customDrawScriptAbove, "Whisperer");
                    obj_AttackController.RemoveBuff(arg3, "Whisperer");
                }
            }
            playerCharacter.scripts.Whisperer.config.timer = playerCharacter.scripts.Whisperer.config.maxTimer;
            return arg0;
        };
    }
    if (!variable_struct_exists(playerCharacter.scripts, "Whisperer"))
    {
        playerCharacter.scripts.Whisperer = 
        {
            Script: function(arg0, arg1)
            {
                var amount, timer, healTimer;
                var buffConfig = 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: arg1.maxAmount
                };
                if (arg1.timer < 1 && arg1.amount != arg1.maxAmount)
                {
                    arg1.amount++;
                    arg1.timer = arg1.maxTimer;
                    obj_AttackController.ApplyBuff(arg0, "Whisperer", ds_map_find_value(obj_AttackController.Buffs, "Whisperer"), buffConfig);
                    
                    arg0.customDrawScriptAbove.Whisperer = function(arg0)
                    {
                        draw_set_alpha((config.amount * 0.05) + 0.2);
                        draw_set_colour(make_color_rgb(255, 219, 95));
                        draw_circle(arg0.x, arg0.y - 16, 15 + (2 * config.amount), false);
                        draw_set_alpha(1);
                    };
                }
                else if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                if (arg1.amount > 0)
                {
                    if (arg0.currentHP > 0 && arg1.healTimer <= 0)
                    {
                        var minHeal = max(1, round(arg0.HP * arg1.healVal * arg1.amount));
                        Heal(arg0, minHeal, 1);
                        arg1.healTimer = arg1.maxHealTimer;
                    }
                    else
                    {
                        arg1.healTimer--;
                    }
                }
            },
            
            config: 
            {
                amount: 0,
                duration: 15,
                maxAmount: 3,
                timer: 600,
                maxTimer: max(1, 600 * (1 / (1 + (playerCharacter.haste / 100)))),
                healTimer: 120,
                maxHealTimer: 120,
                healVal: 0.02
            }
        };
    }
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 4
    };
    UpdateBuffIfExists("Whisperer", buffConfig);
    playerCharacter.scripts.Whisperer.config.maxAmount = 4;
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 5
    };
    UpdateBuffIfExists("Whisperer", buffConfig);
    playerCharacter.scripts.Whisperer.config.maxAmount = 5;
}];
ds_map_set(PERKS, "Whisperer", new Perk("Whisperer", 
{
    optionName: global.TextContainer.WhispererName.selectedLanguage,
    optionIcon: 2112,
    optionDescription: global.TextContainer.WhispererDescription.selectedLanguage[0]
}, WhispererOnApply));
var SaplingOnApply = [function()
{
    var buffConfig = 
    {
        healVal: 0.03,
        weight: 0.3,
        weight2: 0.3
    };
    
    playerCharacter.onKill.Sapling = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            healVal: 0.03,
            weight: 0.3,
            weight2: 0.3
        };
        var rollChance = irandom(100);
        if (rollChance <= 5)
        {
            var sapling = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_sapling);
            sapling.buffConfig = buffConfig;
        }
        exit;
    };
    
    UpdateBuffIfExists("Sapling", buffConfig);
}, function()
{
    var buffConfig = 
    {
        healVal: 0.03,
        weight: 0.5,
        weight2: 0.5
    };
    
    playerCharacter.onKill.Sapling = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            healVal: 0.03,
            weight: 0.5,
            weight2: 0.5
        };
        var rollChance = irandom(100);
        if (rollChance <= 7)
        {
            var sapling = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_sapling);
            sapling.buffConfig = buffConfig;
        }
        exit;
    };
    
    UpdateBuffIfExists("Sapling", buffConfig);
}, function()
{
    var buffConfig = 
    {
        healVal: 0.03,
        weight: 0.7,
        weight2: 0.7
    };
    
    playerCharacter.onKill.Sapling = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            healVal: 0.03,
            weight: 0.7,
            weight2: 0.7
        };
        var rollChance = irandom(100);
        if (rollChance <= 10)
        {
            var sapling = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_sapling);
            sapling.buffConfig = buffConfig;
        }
        exit;
    };
    
    UpdateBuffIfExists("Sapling", buffConfig);
}];
ds_map_set(PERKS, "Sapling", new Perk("Sapling", 
{
    optionName: global.TextContainer.SaplingName.selectedLanguage,
    optionIcon: 134,
    optionDescription: global.TextContainer.SaplingDescription.selectedLanguage[0]
}, SaplingOnApply));
var GuardianTreeOnApply = [function()
{
    playerCharacter.onHeal.GuardianTree = function(arg0, arg1, arg2)
    {
        var ac = 114;
        ac.ExecuteAttack("GuardianTree", arg1);
        return arg0;
    };
}, function()
{
    playerCharacter.onHeal.GuardianTree = function(arg0, arg1, arg2)
    {
        var ac = 114;
        ac.ExecuteAttack("GuardianTree", arg1, 
        {
            damage: 2
        });
        return arg0;
    };
}, function()
{
    playerCharacter.onHeal.GuardianTree = function(arg0, arg1, arg2)
    {
        var ac = 114;
        ac.ExecuteAttack("GuardianTree", arg1, 
        {
            damage: 2.5
        });
        return arg0;
    };
}];
ds_map_set(PERKS, "GuardianTree", new Perk("GuardianTree", 
{
    optionName: global.TextContainer.GuardianTreeName.selectedLanguage,
    optionIcon: 14,
    optionDescription: global.TextContainer.GuardianTreeDescription.selectedLanguage[0]
}, GuardianTreeOnApply));
var RulerOfSpaceOnApply = [function()
{
    playerCharacter.weaponSizeMultiplier += 0.1;
    obj_AttackController.ApplyBuff(playerCharacter, "RulerOfSpace", ds_map_find_value(obj_AttackController.Buffs, "RulerOfSpace"));
    UpdateBuffIfExists("RulerOfSpace", {});
}, function()
{
    playerCharacter.weaponSizeMultiplier += 0.2;
    obj_AttackController.ApplyBuff(playerCharacter, "RulerOfSpace", ds_map_find_value(obj_AttackController.Buffs, "RulerOfSpace"));
    UpdateBuffIfExists("RulerOfSpace", {});
}, function()
{
    playerCharacter.weaponSizeMultiplier += 0.3;
    obj_AttackController.ApplyBuff(playerCharacter, "RulerOfSpace", ds_map_find_value(obj_AttackController.Buffs, "RulerOfSpace"));
    UpdateBuffIfExists("RulerOfSpace", {});
}];
ds_map_set(PERKS, "RulerOfSpace", new Perk("RulerOfSpace", 
{
    optionName: global.TextContainer.RulerOfSpaceName.selectedLanguage,
    optionIcon: 2461,
    optionDescription: global.TextContainer.RulerOfSpaceDescription.selectedLanguage[0]
}, RulerOfSpaceOnApply));
var GravityOnApply = [function()
{
    if (!variable_struct_exists(weapons, "SanaGravity"))
    {
        weapons.SanaGravity = 
        {
            level: 0,
            id: "SanaGravity"
        };
        AddAttack("SanaGravity");
        InitializeAttack(ds_map_find_value(playerCharacter.attacks, "SanaGravity"));
        ds_map_find_value(playerCharacter.attacks, "SanaGravity").config.level = 1;
        weapons.SanaGravity.level = 1;
    }
}, function()
{
    if (weapons.SanaGravity.level == 1)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "SanaGravity").timer;
        AddAttack("SanaGravity");
        ds_map_find_value(playerCharacter.attacks, "SanaGravity").timer = oldTimer;
    }
}, function()
{
    if (weapons.SanaGravity.level == 2)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "SanaGravity").timer;
        AddAttack("SanaGravity");
        ds_map_find_value(playerCharacter.attacks, "SanaGravity").timer = oldTimer;
    }
}];
ds_map_set(PERKS, "Gravity", new Perk("Gravity", 
{
    optionName: global.TextContainer.GravityName.selectedLanguage,
    optionIcon: 1034,
    optionDescription: global.TextContainer.GravityDescription.selectedLanguage[0]
}, GravityOnApply));
var AstrologyOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Astrology"))
    {
        playerCharacter.scripts.Astrology = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                var buffConfig = 
                {
                    weight1: arg1.weight1,
                    weight2: arg1.weight2,
                    stat: arg1.stat
                };
                if (arg1.timer <= 0)
                {
                    var randomStat = irandom(5);
                    var statEffect = instance_create_depth(arg0.x, arg0.y - 8, arg0.depth - 1, obj_statEffect);
                    statEffect.sprite_index = spr_StatUpEffect;
                    statEffect.image_index = randomStat;
                    soundPlay([89], "statUp", 10, 10);
                    if (randomStat == 5)
                    {
                        Heal(arg0, arg0.HP * buffConfig.weight2, 0, true);
                    }
                    else
                    {
                        arg1.stat = randomStat;
                        buffConfig.stat = arg1.stat;
                        obj_AttackController.ApplyBuff(arg0, "Astrology", ds_map_find_value(obj_AttackController.Buffs, "Astrology"), buffConfig);
                    }
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 900,
                weight1: 0.3,
                weight2: 0.3,
                stat: 0
            }
        };
    }
    var buffConfig = 
    {
        weight1: 0.3,
        weight2: 0.3,
        stat: playerCharacter.scripts.Astrology.config.stat
    };
    UpdateBuffIfExists("Astrology", buffConfig);
}, function()
{
    playerCharacter.scripts.Astrology.config.weight1 = 0.4;
    playerCharacter.scripts.Astrology.config.weight2 = 0.4;
    var buffConfig = 
    {
        weight1: 0.4,
        weight2: 0.4,
        stat: playerCharacter.scripts.Astrology.config.stat
    };
    UpdateBuffIfExists("Astrology", buffConfig);
}, function()
{
    playerCharacter.scripts.Astrology.config.weight1 = 0.5;
    playerCharacter.scripts.Astrology.config.weight2 = 0.5;
    var buffConfig = 
    {
        weight1: 0.5,
        weight2: 0.5,
        stat: playerCharacter.scripts.Astrology.config.stat
    };
    UpdateBuffIfExists("Astrology", buffConfig);
}];
ds_map_set(PERKS, "Astrology", new Perk("Astrology", 
{
    optionName: global.TextContainer.AstrologyName.selectedLanguage,
    optionIcon: 552,
    optionDescription: global.TextContainer.AstrologyDescription.selectedLanguage[0]
}, AstrologyOnApply));
var KonKonOnApply = [function()
{
    playerCharacter.onTakeDamage.KonKon = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible && arg3.scripts.KonKon.config.timer == 0)
        {
            var roll2 = irandom(99);
            if (roll2 < 60)
            {
                arg3.scripts.KonKon.config.timer = arg3.scripts.KonKon.config.maxTimer;
                obj_AttackController.ExecuteAttack("KonKonShout", arg3, 
                {
                    damage: 1,
                    image_xscale: 1.5,
                    image_yscale: 1.5
                });
            }
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        var dodgeChance = 10;
        var roll = irandom(99);
        if (arg3.scripts.KonKon.config.timer == 0)
        {
            if (roll < dodgeChance)
            {
                arg0 = 0;
                arg3.scripts.KonKon.config.timer = arg3.scripts.KonKon.config.maxTimer;
                audio_play_sound(snd_headphonesbounce, 10, 0);
                var roll2 = irandom(99);
                if (roll2 < 60)
                {
                    obj_AttackController.ExecuteAttack("KonKonShout", arg3, 
                    {
                        damage: 1,
                        image_xscale: 1.5,
                        image_yscale: 1.5
                    });
                }
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.KonKon = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.KonKon.config.timer > 0)
            {
                arg0.scripts.KonKon.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 6
        }
    };
}, function()
{
    playerCharacter.onTakeDamage.KonKon = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            var roll2 = irandom(99);
            if (roll2 < 70 && arg3.scripts.KonKon.config.timer == 0)
            {
                arg3.scripts.KonKon.config.timer = arg3.scripts.KonKon.config.maxTimer;
                obj_AttackController.ExecuteAttack("KonKonShout", arg3, 
                {
                    damage: 1.25,
                    image_xscale: 2,
                    image_yscale: 2
                });
            }
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        var dodgeChance = 10;
        var roll = irandom(99);
        if (arg3.scripts.KonKon.config.timer == 0)
        {
            if (roll < dodgeChance)
            {
                arg0 = 0;
                arg3.scripts.KonKon.config.timer = arg3.scripts.KonKon.config.maxTimer;
                audio_play_sound(snd_headphonesbounce, 10, 0);
                var roll2 = irandom(99);
                if (roll2 < 70)
                {
                    obj_AttackController.ExecuteAttack("KonKonShout", arg3, 
                    {
                        damage: 1.25,
                        image_xscale: 2,
                        image_yscale: 2
                    });
                }
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.KonKon = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.KonKon.config.timer > 0)
            {
                arg0.scripts.KonKon.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 6
        }
    };
}, function()
{
    playerCharacter.onTakeDamage.KonKon = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            var roll2 = irandom(99);
            if (roll2 < 80 && arg3.scripts.KonKon.config.timer == 0)
            {
                arg3.scripts.KonKon.config.timer = arg3.scripts.KonKon.config.maxTimer;
                obj_AttackController.ExecuteAttack("KonKonShout", arg3, 
                {
                    damage: 1.5,
                    image_xscale: 2.5,
                    image_yscale: 2.5
                });
            }
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        var dodgeChance = 10;
        var roll = irandom(99);
        if (arg3.scripts.KonKon.config.timer == 0)
        {
            if (roll < dodgeChance)
            {
                arg0 = 0;
                arg3.scripts.KonKon.config.timer = arg3.scripts.KonKon.config.maxTimer;
                audio_play_sound(snd_headphonesbounce, 10, 0);
                var roll2 = irandom(99);
                if (roll2 < 80)
                {
                    obj_AttackController.ExecuteAttack("KonKonShout", arg3, 
                    {
                        damage: 1.5,
                        image_xscale: 2.5,
                        image_yscale: 2.5
                    });
                }
            }
        }
        return arg0;
    };
    
    playerCharacter.scripts.KonKon = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.KonKon.config.timer > 0)
            {
                arg0.scripts.KonKon.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 6
        }
    };
}];
ds_map_set(PERKS, "KonKon", new Perk("KonKon", 
{
    optionName: global.TextContainer.KonKonName.selectedLanguage,
    optionIcon: 1205,
    optionDescription: global.TextContainer.KonKonDescription.selectedLanguage[0]
}, KonKonOnApply));
var FriendzoneOnApply = [function()
{
    playerCharacter.onTakeDamage.Friendzone = function(arg0, arg1, arg2, arg3)
    {
        if (variable_struct_exists(arg3.buffs, "Friendzone"))
        {
            arg3.scripts.Friendzone.config.timer = arg3.scripts.Friendzone.config.maxTimer;
            arg3.invincible = true;
            if (arg3.invincibilityTimer < 180)
            {
                arg3.invincibilityTimer = 180;
            }
            obj_AttackController.RemoveBuff(arg3, "Friendzone");
            var buffConfig = 
            {
                SPDBuff: 1,
                buffIcon: 711
            };
            soundPlay([145], "friendzone", 5, 30);
            obj_AttackController.ApplyBuff(arg3, "Friendzone2", ds_map_find_value(obj_AttackController.Buffs, "Friendzone2"), buffConfig);
        }
        return arg0;
    };
    
    var timer = 0;
    if (variable_struct_exists(playerCharacter.scripts, "Friendzone"))
    {
        timer = playerCharacter.scripts.Friendzone.config.timer;
    }
    playerCharacter.scripts.Friendzone = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.Friendzone.config.timer < 1)
            {
                var buffConfig = 
                {
                    timer: 180,
                    SPDBuff: 0.2
                };
                obj_AttackController.ApplyBuff(arg0, "Friendzone", ds_map_find_value(obj_AttackController.Buffs, "Friendzone"), buffConfig);
            }
            else if (arg0.scripts.Friendzone.config.timer > 0)
            {
                arg0.scripts.Friendzone.config.timer--;
            }
        },
        
        config: 
        {
            timer: timer,
            maxTimer: 720
        }
    };
}, function()
{
    playerCharacter.onTakeDamage.Friendzone = function(arg0, arg1, arg2, arg3)
    {
        if (variable_struct_exists(arg3.buffs, "Friendzone"))
        {
            arg3.scripts.Friendzone.config.timer = arg3.scripts.Friendzone.config.maxTimer;
            arg3.invincible = true;
            if (arg3.invincibilityTimer < 180)
            {
                arg3.invincibilityTimer = 180;
            }
            obj_AttackController.RemoveBuff(arg3, "Friendzone");
            var buffConfig = 
            {
                SPDBuff: 1,
                buffIcon: 711
            };
            soundPlay([145], "friendzone", 5, 30);
            obj_AttackController.ApplyBuff(arg3, "Friendzone2", ds_map_find_value(obj_AttackController.Buffs, "Friendzone2"), buffConfig);
        }
        return arg0;
    };
    
    var timer = 0;
    if (variable_struct_exists(playerCharacter.scripts, "Friendzone"))
    {
        timer = playerCharacter.scripts.Friendzone.config.timer;
    }
    playerCharacter.scripts.Friendzone = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.Friendzone.config.timer < 1)
            {
                var buffConfig = 
                {
                    timer: 180,
                    SPDBuff: 0.25
                };
                obj_AttackController.ApplyBuff(arg0, "Friendzone", ds_map_find_value(obj_AttackController.Buffs, "Friendzone"), buffConfig);
            }
            else if (arg0.scripts.Friendzone.config.timer > 0)
            {
                arg0.scripts.Friendzone.config.timer--;
            }
        },
        
        config: 
        {
            timer: timer,
            maxTimer: 720
        }
    };
    ds_map_find_value(obj_AttackController.Buffs, "Friendzone2").timer = 180;
    var buffConfig = 
    {
        timer: 180,
        SPDBuff: 0.25
    };
    UpdateBuffIfExists("Friendzone", buffConfig);
}, function()
{
    playerCharacter.onTakeDamage.Friendzone = function(arg0, arg1, arg2, arg3)
    {
        if (variable_struct_exists(arg3.buffs, "Friendzone"))
        {
            arg3.scripts.Friendzone.config.timer = arg3.scripts.Friendzone.config.maxTimer;
            arg3.invincible = true;
            if (arg3.invincibilityTimer < 180)
            {
                arg3.invincibilityTimer = 180;
            }
            obj_AttackController.RemoveBuff(arg3, "Friendzone");
            var buffConfig = 
            {
                SPDBuff: 1,
                buffIcon: 711
            };
            soundPlay([145], "friendzone", 5, 30);
            obj_AttackController.ApplyBuff(arg3, "Friendzone2", ds_map_find_value(obj_AttackController.Buffs, "Friendzone2"), buffConfig);
        }
        return arg0;
    };
    
    var timer = 0;
    if (variable_struct_exists(playerCharacter.scripts, "Friendzone"))
    {
        timer = playerCharacter.scripts.Friendzone.config.timer;
    }
    playerCharacter.scripts.Friendzone = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.Friendzone.config.timer < 1)
            {
                var buffConfig = 
                {
                    timer: 180,
                    SPDBuff: 0.3
                };
                obj_AttackController.ApplyBuff(arg0, "Friendzone", ds_map_find_value(obj_AttackController.Buffs, "Friendzone"), buffConfig);
            }
            else if (arg0.scripts.Friendzone.config.timer > 0)
            {
                arg0.scripts.Friendzone.config.timer--;
            }
        },
        
        config: 
        {
            timer: timer,
            maxTimer: 720
        }
    };
    ds_map_find_value(obj_AttackController.Buffs, "Friendzone2").timer = 180;
    var buffConfig = 
    {
        timer: 180,
        SPDBuff: 0.3
    };
    UpdateBuffIfExists("Friendzone", buffConfig);
}];
ds_map_set(PERKS, "Friendzone", new Perk("Friendzone", 
{
    optionName: global.TextContainer.FriendzoneName.selectedLanguage,
    optionIcon: 711,
    optionDescription: global.TextContainer.FriendzoneDescription.selectedLanguage[0]
}, FriendzoneOnApply));

function FoxKingStepBuffApply(arg0, arg1)
{
    if (arg0.isMoving)
    {
        var bonusSpeed = min(arg1.maxAmount, (((arg0.SPD * 100) - (arg0.baseStats.SPD * 100)) div 10) / 10);
        arg0.ATK += bonusSpeed;
    }
}

var FoxKingOnApply = [function()
{
    playerCharacter.SPD += 0.1;
    playerCharacter.stepBuffs.FoxKing = 
    {
        Apply: FoxKingStepBuffApply,
        config: 
        {
            maxAmount: 1
        }
    };
}, function()
{
    playerCharacter.SPD += 0.15;
    playerCharacter.stepBuffs.FoxKing = 
    {
        Apply: FoxKingStepBuffApply,
        config: 
        {
            maxAmount: 1.25
        }
    };
}, function()
{
    playerCharacter.SPD += 0.2;
    playerCharacter.stepBuffs.FoxKing = 
    {
        Apply: FoxKingStepBuffApply,
        config: 
        {
            maxAmount: 1.5
        }
    };
}];
ds_map_set(PERKS, "FoxKing", new Perk("FoxKing", 
{
    optionIcon: 1602,
    optionName: global.TextContainer.FoxKingName.selectedLanguage,
    optionDescription: global.TextContainer.FoxKingDescription.selectedLanguage[0]
}, FoxKingOnApply));
var YummyOnApply = [function()
{
    playerCharacter.food += 0.33;
    
    playerCharacter.onHeal.Yummy = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight1: 0.4,
            weight2: 0.15,
            weight3: 5
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Yummy", ds_map_find_value(ac.Buffs, "Yummy"), buffConfig);
        }
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight1: 0.4,
        weight2: 0.15,
        weight3: 5
    };
    UpdateBuffIfExists("Yummy", buffConfig);
}, function()
{
    playerCharacter.food += 0.43;
    
    playerCharacter.onHeal.Yummy = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight1: 0.6,
            weight2: 0.25,
            weight3: 10
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Yummy", ds_map_find_value(ac.Buffs, "Yummy"), buffConfig);
        }
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight1: 0.6,
        weight2: 0.25,
        weight3: 10
    };
    UpdateBuffIfExists("Yummy", buffConfig);
}, function()
{
    playerCharacter.food += 0.5;
    
    playerCharacter.onHeal.Yummy = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight1: 0.8,
            weight2: 0.35,
            weight3: 15
        };
        if (arg2)
        {
            ac.ApplyBuff(arg1, "Yummy", ds_map_find_value(ac.Buffs, "Yummy"), buffConfig);
        }
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight1: 0.8,
        weight2: 0.35,
        weight3: 15
    };
    UpdateBuffIfExists("Yummy", buffConfig);
}];
ds_map_set(PERKS, "Yummy", new Perk("Yummy", 
{
    optionName: global.TextContainer.YummyName.selectedLanguage,
    optionIcon: 517,
    optionDescription: global.TextContainer.YummyDescription.selectedLanguage[0]
}, YummyOnApply));
var FeastOnApply = [function()
{
    playerCharacter.onKill.Feast = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 6)
        {
            var food = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_OkayuFood);
            var foodRoll = irandom(19);
            if (foodRoll < 10)
            {
                food.healAmount = 1;
                food.sprite_index = spr_Okayu_cookie;
            }
            else if (foodRoll >= 10 && foodRoll < 16)
            {
                food.healAmount = 3;
                food.sprite_index = spr_Okayu_partfait;
            }
            else if (foodRoll >= 16 && foodRoll < 19)
            {
                food.healAmount = 5;
                food.sprite_index = spr_Okayu_pizza;
            }
            else
            {
                food.healAmount = 20;
                food.sprite_index = spr_Okayu_chicken;
            }
        }
        exit;
    };
}, function()
{
    playerCharacter.onKill.Feast = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 8)
        {
            var food = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_OkayuFood);
            var foodRoll = irandom(19);
            if (foodRoll < 10)
            {
                food.healAmount = 1;
                food.sprite_index = spr_Okayu_cookie;
            }
            else if (foodRoll >= 10 && foodRoll < 16)
            {
                food.healAmount = 3;
                food.sprite_index = spr_Okayu_partfait;
            }
            else if (foodRoll >= 16 && foodRoll < 19)
            {
                food.healAmount = 5;
                food.sprite_index = spr_Okayu_pizza;
            }
            else
            {
                food.healAmount = 20;
                food.sprite_index = spr_Okayu_chicken;
            }
        }
        exit;
    };
}, function()
{
    playerCharacter.onKill.Feast = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 10)
        {
            var food = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_OkayuFood);
            var foodRoll = irandom(19);
            if (foodRoll < 10)
            {
                food.healAmount = 1;
                food.sprite_index = spr_Okayu_cookie;
            }
            else if (foodRoll >= 10 && foodRoll < 16)
            {
                food.healAmount = 3;
                food.sprite_index = spr_Okayu_partfait;
            }
            else if (foodRoll >= 16 && foodRoll < 19)
            {
                food.healAmount = 5;
                food.sprite_index = spr_Okayu_pizza;
            }
            else
            {
                food.healAmount = 20;
                food.sprite_index = spr_Okayu_chicken;
            }
        }
        exit;
    };
}];
ds_map_set(PERKS, "Feast", new Perk("Feast", 
{
    optionName: global.TextContainer.FeastName.selectedLanguage,
    optionIcon: 896,
    optionDescription: global.TextContainer.FeastDescription.selectedLanguage[0]
}, FeastOnApply));
var SensitiveVoiceOnApply = [function()
{
    playerCharacter.crit += 5;
    
    playerCharacter.onCriticalHit.SensitiveVoice = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var roll = irandom(99);
        if (roll < 10 && !arg2.isBoss && !arg2.miniboss)
        {
            if (arg0.scripts.SensitiveVoice.config.timer == 0 && point_distance(arg0.x, arg0.y, arg2.x, arg2.y) <= 120)
            {
                ac.ApplyBuff(arg2, "SensitiveVoice", ds_map_find_value(ac.Buffs, "SensitiveVoice"), 
                {
                    resist: 600
                });
                arg0.scripts.SensitiveVoice.config.timer = arg0.scripts.SensitiveVoice.config.maxTimer;
            }
        }
        return arg3;
    };
    
    if (!variable_struct_exists(playerCharacter.scripts, "SensitiveVoice"))
    {
        playerCharacter.scripts.SensitiveVoice = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                range: 100,
                circleTime: 0,
                timer: 0,
                maxTimer: 6
            }
        };
    }
    
    playerCharacter.customDrawScriptAbove.SensitiveVoice = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.SensitiveVoice.config.circleTime += 0.5;
            if (arg0.scripts.SensitiveVoice.config.circleTime >= (arg0.scripts.SensitiveVoice.config.range / 1.5))
            {
                arg0.scripts.SensitiveVoice.config.circleTime = 0;
            }
            draw_set_color(c_purple);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.SensitiveVoice.config.range - arg0.scripts.SensitiveVoice.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.SensitiveVoice.config.range, true);
        }
    };
    
    playerCharacter.onCollide.SensitiveVoice = 
    {
        Script: function(arg0, arg1, arg2, arg3)
        {
            if (variable_struct_exists(arg3.buffs, "SensitiveVoice"))
            {
                if (!arg3.isBoss && !arg3.miniboss && arg3.isEnemy)
                {
                    arg3.Die(false, true, arg0);
                    Heal(arg0, floor(max(1, arg0.HP * 0.03)), 0, true, true);
                    arg1 = -1;
                    if (global.showDamageText)
                    {
                        var hit = instance_create_depth(arg3.x, arg3.y - 40, arg3.depth - 1, obj_damageText);
                        hit.critted = false;
                        hit.damageValue = "MOGU!";
                        hit.hspeed = 0;
                        hit.vspeed = -3;
                        hit.isEnemy = arg3.isEnemy;
                    }
                }
                else
                {
                }
            }
            return arg1;
        },
        
        config: {}
    };
}, function()
{
    playerCharacter.crit += 10;
    
    playerCharacter.onCriticalHit.SensitiveVoice = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var roll = irandom(99);
        if (roll < 15 && !arg2.isBoss && !arg2.miniboss)
        {
            if (arg0.scripts.SensitiveVoice.config.timer == 0 && point_distance(arg0.x, arg0.y, arg2.x, arg2.y) <= 120)
            {
                ac.ApplyBuff(arg2, "SensitiveVoice", ds_map_find_value(ac.Buffs, "SensitiveVoice"), 
                {
                    resist: 600
                });
                arg0.scripts.SensitiveVoice.config.timer = arg0.scripts.SensitiveVoice.config.maxTimer;
            }
        }
        return arg3;
    };
    
    playerCharacter.onCollide.SensitiveVoice = 
    {
        Script: function(arg0, arg1, arg2, arg3)
        {
            if (variable_struct_exists(arg3.buffs, "SensitiveVoice"))
            {
                if (!arg3.isBoss && !arg3.miniboss && arg3.isEnemy)
                {
                    arg3.Die(false, true, arg0);
                    Heal(arg0, floor(max(1, arg0.HP * 0.04)), 0, true, true);
                    arg1 = -1;
                    if (global.showDamageText)
                    {
                        var hit = instance_create_depth(arg3.x, arg3.y - 40, arg3.depth - 1, obj_damageText);
                        hit.critted = false;
                        hit.damageValue = "MOGU!";
                        hit.hspeed = 0;
                        hit.vspeed = -3;
                        hit.isEnemy = arg3.isEnemy;
                    }
                }
                else
                {
                }
            }
            return arg1;
        },
        
        config: {}
    };
}, function()
{
    playerCharacter.crit += 15;
    
    playerCharacter.onCriticalHit.SensitiveVoice = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var roll = irandom(99);
        if (roll < 20 && !arg2.isBoss && !arg2.miniboss)
        {
            if (arg0.scripts.SensitiveVoice.config.timer == 0 && point_distance(arg0.x, arg0.y, arg2.x, arg2.y) <= 120)
            {
                ac.ApplyBuff(arg2, "SensitiveVoice", ds_map_find_value(ac.Buffs, "SensitiveVoice"), 
                {
                    resist: 600
                });
                arg0.scripts.SensitiveVoice.config.timer = arg0.scripts.SensitiveVoice.config.maxTimer;
            }
        }
        return arg3;
    };
    
    playerCharacter.onCollide.SensitiveVoice = 
    {
        Script: function(arg0, arg1, arg2, arg3)
        {
            if (variable_struct_exists(arg3.buffs, "SensitiveVoice"))
            {
                if (!arg3.isBoss && !arg3.miniboss && arg3.isEnemy)
                {
                    arg3.Die(false, true, arg0);
                    Heal(arg0, floor(max(1, arg0.HP * 0.05)), 0, true, true);
                    arg1 = -1;
                    if (global.showDamageText)
                    {
                        var hit = instance_create_depth(arg3.x, arg3.y - 40, arg3.depth - 1, obj_damageText);
                        hit.critted = false;
                        hit.damageValue = "MOGU!";
                        hit.hspeed = 0;
                        hit.vspeed = -3;
                        hit.isEnemy = arg3.isEnemy;
                    }
                }
                else
                {
                }
            }
            return arg1;
        },
        
        config: {}
    };
}];
ds_map_set(PERKS, "SensitiveVoice", new Perk("SensitiveVoice", 
{
    optionIcon: 1627,
    optionName: global.TextContainer.SensitiveVoiceName.selectedLanguage,
    optionDescription: global.TextContainer.SensitiveVoiceDescription.selectedLanguage[0]
}, SensitiveVoiceOnApply));
var InugamiEnduranceOnApply = [function()
{
    playerCharacter.DR *= 0.9;
    if (variable_struct_exists(playerCharacter.onTakeDamage, "InugamiVengeance"))
    {
        exit;
    }
    obj_AttackController.ApplyBuff(playerCharacter, "InugamiEndurance", ds_map_find_value(obj_AttackController.Buffs, "InugamiEndurance"));
    var statEffect = instance_create_depth(playerCharacter.x, playerCharacter.y - 8, playerCharacter.depth - 1, obj_statEffect);
    statEffect.sprite_index = spr_KoronePerk1;
    statEffect.add = false;
    soundPlay([89], "statUp", 10, 10);
    
    playerCharacter.onTakeDamage.InugamiVengeance = function(arg0, arg1, arg2, arg3)
    {
        if (!variable_struct_exists(playerCharacter.scripts, "InugamiVengeanceCountdown"))
        {
            obj_AttackController.ApplyBuff(playerCharacter, "InugamiVengeance", ds_map_find_value(obj_AttackController.Buffs, "InugamiVengeance"), ds_map_find_value(obj_AttackController.Buffs, "InugamiVengeance").currentConfig);
            obj_AttackController.RemoveBuff(playerCharacter, "InugamiEndurance");
            soundPlay([17], "koroneretaliation", 30, 10);
            playerCharacter.scripts.InugamiVengeanceCountdown = 
            {
                Script: function(arg0, arg1)
                {
                    var timer;
                    if (arg1.timer == 0)
                    {
                        variable_struct_remove(obj_Player.scripts, "InugamiVengeanceCountdown");
                        obj_AttackController.ApplyBuff(227, "InugamiEndurance", ds_map_find_value(obj_AttackController.Buffs, "InugamiEndurance"));
                        var statEffect = instance_create_depth(arg0.x, arg0.y - 8, arg0.depth - 1, obj_statEffect);
                        statEffect.sprite_index = spr_KoronePerk1;
                        statEffect.add = false;
                        soundPlay([89], "statUp", 10, 10);
                        exit;
                    }
                    else
                    {
                        arg1.timer--;
                    }
                },
                
                config: 
                {
                    timer: 1200
                }
            };
        }
        return arg0;
    };
}, function()
{
    playerCharacter.DR *= 0.8;
    ds_map_find_value(obj_AttackController.Buffs, "InugamiVengeance").currentConfig = ds_map_find_value(obj_AttackController.Buffs, "InugamiVengeance").levelConfig[0];
}, function()
{
    playerCharacter.DR *= 0.7;
    ds_map_find_value(obj_AttackController.Buffs, "InugamiVengeance").currentConfig = ds_map_find_value(obj_AttackController.Buffs, "InugamiVengeance").levelConfig[1];
}];
ds_map_set(PERKS, "InugamiEndurance", new Perk("InugamiEndurance", 
{
    optionIcon: 1460,
    optionName: global.TextContainer.InugamiEnduranceName.selectedLanguage,
    optionDescription: global.TextContainer.InugamiEnduranceDescription.selectedLanguage[0]
}, InugamiEnduranceOnApply));
var YubiYubiOnApply = [function()
{
    if (!variable_struct_exists(weapons, "YubiYubi"))
    {
        weapons.YubiYubi = 
        {
            level: 0,
            id: "YubiYubi"
        };
        AddAttack("YubiYubi");
        InitializeAttack(ds_map_find_value(playerCharacter.attacks, "YubiYubi"));
        ds_map_find_value(playerCharacter.attacks, "YubiYubi").config.level = 1;
        weapons.YubiYubi.level = 1;
    }
}, function()
{
    if (weapons.YubiYubi.level == 1)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "YubiYubi").timer;
        AddAttack("YubiYubi");
        ds_map_find_value(playerCharacter.attacks, "YubiYubi").timer = oldTimer;
    }
    var playerBuff = ds_map_find_value(obj_AttackController.Buffs, "Yubi");
    var mobDebuff = ds_map_find_value(obj_AttackController.Buffs, "YubiYubi");
    playerBuff.currentConfig = playerBuff.levelConfig[0];
    UpdateBuffIfExists("Yubi", playerBuff.currentConfig);
}, function()
{
    if (weapons.YubiYubi.level == 2)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "YubiYubi").timer;
        AddAttack("YubiYubi");
        ds_map_find_value(playerCharacter.attacks, "YubiYubi").timer = oldTimer;
    }
    var playerBuff = ds_map_find_value(obj_AttackController.Buffs, "Yubi");
    var mobDebuff = ds_map_find_value(obj_AttackController.Buffs, "YubiYubi");
    playerBuff.currentConfig = playerBuff.levelConfig[1];
    UpdateBuffIfExists("Yubi", playerBuff.currentConfig);
}];
ds_map_set(PERKS, "YubiYubi", new Perk("YubiYubi", 
{
    optionIcon: 287,
    optionName: global.TextContainer.YubiYubiName.selectedLanguage,
    optionDescription: global.TextContainer.YubiYubiDescription.selectedLanguage[0]
}, YubiYubiOnApply));
var ChocoCoronetOnApply = [function()
{
    playerCharacter.healMultiplier += 0.1;
    
    playerCharacter.onKill.ChocoCoronet = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            weight: 10
        };
        var rollChance = irandom(99);
        if (rollChance < 6)
        {
            var food = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_Coronet);
            food.buffConfig = buffConfig;
        }
        exit;
    };
    
    var buffConfig = 
    {
        weight: 10
    };
    UpdateBuffIfExists("ChocoCoronet", buffConfig);
}, function()
{
    playerCharacter.healMultiplier += 0.2;
    
    playerCharacter.onKill.ChocoCoronet = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            weight: 15
        };
        var rollChance = irandom(99);
        if (rollChance < 6)
        {
            var food = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_Coronet);
            food.buffConfig = buffConfig;
        }
        exit;
    };
    
    var buffConfig = 
    {
        weight: 15
    };
    UpdateBuffIfExists("ChocoCoronet", buffConfig);
}, function()
{
    playerCharacter.healMultiplier += 0.3;
    
    playerCharacter.onKill.ChocoCoronet = function(arg0, arg1)
    {
        var buffConfig = 
        {
            weight: 20
        };
        var rollChance = irandom(99);
        if (rollChance < 6)
        {
            var food = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_Coronet);
            food.buffConfig = buffConfig;
        }
        exit;
    };
    
    var buffConfig = 
    {
        weight: 20
    };
    UpdateBuffIfExists("ChocoCoronet", buffConfig);
}];
ds_map_set(PERKS, "ChocoCoronet", new Perk("ChocoCoronet", 
{
    optionIcon: 1228,
    optionName: global.TextContainer.ChocoCoronetName.selectedLanguage,
    optionDescription: global.TextContainer.ChocoCoronetDescription.selectedLanguage[0]
}, ChocoCoronetOnApply));
var OmenOnApply = [function()
{
    playerCharacter.scripts.Omen = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
    ds_map_find_value(obj_AttackController.attackIndex, "TarotCards").config.onHitEffects.CreateOmen = 
    {
        chance: 10,
        damage: 2
    };
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "TarotCards").config.onHitEffects.CreateOmen = 
    {
        chance: 15,
        damage: 2.5
    };
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "TarotCards").config.onHitEffects.CreateOmen = 
    {
        chance: 20,
        damage: 3
    };
}];
ds_map_set(PERKS, "Omen", new Perk("Omen", 
{
    optionName: global.TextContainer.OmenName.selectedLanguage,
    optionIcon: 1774,
    optionDescription: global.TextContainer.OmenDescription.selectedLanguage[0]
}, OmenOnApply));
var MamaOnApply = [function()
{
    playerCharacter.scripts.Mama = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
            else
            {
                var enemies = ds_list_create();
                var amountOfEnemies = 0;
                if (instance_exists(obj_Enemy))
                {
                    amountOfEnemies = collision_circle_list(arg0.x, arg0.y, 100, obj_Enemy, true, true, enemies, false);
                }
                if (amountOfEnemies > arg1.maxAmount)
                {
                    amountOfEnemies = arg1.maxAmount;
                }
                Heal(arg0, (amountOfEnemies / 100) * arg0.HP, 1, true, false);
                arg1.timer = arg1.maxTimer;
                ds_list_destroy(enemies);
                enemies = -1;
            }
        },
        
        config: 
        {
            maxAmount: 10,
            timer: 240,
            maxTimer: 240,
            circleTime: 0,
            radius: 100
        }
    };
    
    playerCharacter.customDrawScriptAbove.Mama = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.Mama.config.circleTime += 0.5;
            if (arg0.scripts.Mama.config.circleTime >= (arg0.scripts.Mama.config.radius / 1.5))
            {
                arg0.scripts.Mama.config.circleTime = 0;
            }
            draw_set_color(c_blue);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.Mama.config.radius - arg0.scripts.Mama.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.Mama.config.radius, true);
        }
    };
}, function()
{
    playerCharacter.scripts.Mama.config.maxAmount = 20;
    playerCharacter.scripts.Mama.config.radius = 125;
}, function()
{
    playerCharacter.scripts.Mama.config.maxAmount = 30;
    playerCharacter.scripts.Mama.config.radius = 150;
}];
ds_map_set(PERKS, "Mama", new Perk("Mama", 
{
    optionName: global.TextContainer.MamaName.selectedLanguage,
    optionIcon: 510,
    optionDescription: global.TextContainer.MamaDescription.selectedLanguage[0]
}, MamaOnApply));
var CuteLaughOnApply = [function()
{
    variable_struct_set(playerCharacter.onHitEffects, "ProximityDamage", 
    {
        maxDamage: 0.5
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "ProximityDamage", 
    {
        maxDamage: 1
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "ProximityDamage", 
    {
        maxDamage: 1.5
    });
}];
ds_map_set(PERKS, "CuteLaugh", new Perk("CuteLaugh", 
{
    optionName: global.TextContainer.CuteLaughName.selectedLanguage,
    optionIcon: 705,
    optionDescription: global.TextContainer.CuteLaughDescription.selectedLanguage[0]
}, CuteLaughOnApply));
var IdolHealingOnApply = [function()
{
    playerCharacter.IdolHealingEmitter = part_emitter_create(global.psystem);
    playerCharacter.scripts.IdolHealing = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            radius: 100,
            damage: 1.25,
            circleTime: 0,
            timer: 0
        }
    };
    
    playerCharacter.onHeal.IdolHealing = function(arg0, arg1, arg2)
    {
        if (arg1.scripts.IdolHealing.config.timer == 0)
        {
            var targets = ds_list_create();
            if (global.lightFX)
            {
                part_emitter_region(global.psystem, arg1.IdolHealingEmitter, arg1.x - arg1.scripts.IdolHealing.config.radius, arg1.x + arg1.scripts.IdolHealing.config.radius, arg1.y - arg1.scripts.IdolHealing.config.radius, arg1.y + arg1.scripts.IdolHealing.config.radius, 1, 0);
                part_emitter_burst(global.psystem, arg1.IdolHealingEmitter, global.partType11, 30);
            }
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg1.x, arg1.y, arg1.scripts.IdolHealing.config.radius, obj_Enemy, true, true, targets, false);
            }
            for (var i = 0; i < ds_list_size(targets); i++)
            {
                var totalDam = arg1.scripts.IdolHealing.config.damage + (arg0 / 50);
                var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), arg1, 
                {
                    damage: totalDam
                });
                arg1.scripts.IdolHealing.config.timer = 8;
                if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
                {
                    ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg1, dmgObj[1], "IdolHealing", undefined, undefined, undefined, true);
                }
            }
            ds_list_destroy(targets);
            targets = -1;
        }
        return arg0;
    };
    
    playerCharacter.customDrawScriptAbove.IdolHealing = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.IdolHealing.config.circleTime += 0.5;
            if (arg0.scripts.IdolHealing.config.circleTime >= (arg0.scripts.IdolHealing.config.radius / 1.5))
            {
                arg0.scripts.IdolHealing.config.circleTime = 0;
            }
            draw_set_color(c_blue);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.IdolHealing.config.radius - arg0.scripts.IdolHealing.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.IdolHealing.config.radius, true);
        }
    };
}, function()
{
    playerCharacter.scripts.IdolHealing = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            radius: 125,
            damage: 1.5,
            circleTime: 0,
            timer: 0
        }
    };
}, function()
{
    playerCharacter.scripts.IdolHealing = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            radius: 150,
            damage: 1.75,
            circleTime: 0,
            timer: 0
        }
    };
}];
ds_map_set(PERKS, "IdolHealing", new Perk("IdolHealing", 
{
    optionName: global.TextContainer.IdolHealingName.selectedLanguage,
    optionIcon: 2343,
    optionDescription: global.TextContainer.IdolHealingDescription.selectedLanguage[0]
}, IdolHealingOnApply));
var EnemyThenOnApply = [function()
{
    playerCharacter.scripts.EnemyThen = 
    {
        Script: function(arg0, arg1)
        {
            var healTimer;
            if (arg1.healTimer > 0)
            {
                arg1.healTimer--;
            }
            if (arg1.targetNum < 0)
            {
                arg1.targetNum = 0;
            }
        },
        
        config: 
        {
            targetNum: 0,
            heal: 2,
            healTimer: 10,
            healChance: 20
        }
    };
    variable_struct_set(playerCharacter.onHitEffects, "EnemyThen", 
    {
        chance: 10,
        vuln: 25
    });
}, function()
{
    playerCharacter.scripts.EnemyThen.config.heal = 3;
    playerCharacter.scripts.EnemyThen.config.healChance = 25;
    variable_struct_set(playerCharacter.onHitEffects, "EnemyThen", 
    {
        chance: 15,
        vuln: 33
    });
}, function()
{
    playerCharacter.scripts.EnemyThen.config.heal = 4;
    playerCharacter.scripts.EnemyThen.config.healChance = 30;
    variable_struct_set(playerCharacter.onHitEffects, "EnemyThen", 
    {
        chance: 20,
        vuln: 50
    });
}];
ds_map_set(PERKS, "EnemyThen", new Perk("EnemyThen", 
{
    optionName: global.TextContainer.EnemyThenName.selectedLanguage,
    optionIcon: 1839,
    optionDescription: global.TextContainer.EnemyThenDescription.selectedLanguage[0]
}, EnemyThenOnApply));
var AnkimoOnApply = [function()
{
    if (!instance_exists(obj_Summon))
    {
        obj_PlayerManager.playerSummon = obj_MobManager.CreateSummon("Ankimo");
    }
}, function()
{
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "AnkimoTaunt").config.damage = 0.75;
    obj_PlayerManager.playerSummon.SetStats(
    {
        SPD: 1.75
    });
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "AnkimoTaunt").config.onHitEffects = 
    {
        AnkimoTaunt: 
        {
            chance: 25
        }
    };
}, function()
{
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "AnkimoTaunt").config.damage = 1;
    obj_PlayerManager.playerSummon.SetStats(
    {
        SPD: 2
    });
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "AnkimoTaunt").config.onHitEffects = 
    {
        AnkimoTaunt: 
        {
            chance: 30
        }
    };
}];
ds_map_set(PERKS, "Ankimo", new Perk("Ankimo", 
{
    optionName: global.TextContainer.AnkimoName.selectedLanguage,
    optionIcon: 2392,
    optionDescription: global.TextContainer.AnkimoDescription.selectedLanguage[0]
}, AnkimoOnApply));
var PerformanceOnApply = [function()
{
    playerCharacter.scripts.Performance = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10,
                weight1: 0.02,
                weight2: 2,
                loseStackOnRemove: true
            };
            if (arg0.isMoving)
            {
                if (arg1.timer >= arg1.maxTimer)
                {
                    obj_AttackController.ApplyBuff(arg0, "Performance", ds_map_find_value(obj_AttackController.Buffs, "Performance"), buffConfig);
                    arg1.timer = 0;
                }
                else if (!variable_struct_exists(arg0.buffs, "Performance") || (variable_struct_exists(arg0.buffs, "Performance") && arg0.buffs.Performance.config.stacks < arg0.buffs.Performance.config.maxStacks))
                {
                    arg1.timer++;
                }
                if (variable_struct_exists(arg0.buffs, "Performance"))
                {
                    arg1.dodgeChance = arg0.buffs.Performance.config.stacks * arg0.buffs.Performance.config.weight2;
                }
            }
            else
            {
                arg1.timer = 0;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60,
            dodgeChance: 0,
            maxDodgeChance: 20
        }
    };
    
    playerCharacter.onTakeDamage.Performance = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        if (arg0 < 1)
        {
            return arg0;
        }
        if (arg3.scripts.Performance.config.dodgeChance > 0)
        {
            var roll = irandom(99);
            if (roll < arg3.scripts.Performance.config.dodgeChance)
            {
                arg0 = 0;
            }
            if (arg0 > 0)
            {
                obj_AttackController.RemoveBuff(arg3, "Performance");
                obj_AttackController.RemoveBuff(arg3, "Performance");
                arg3.scripts.Performance.config.dodgeChance -= 4;
                if (arg3.scripts.Performance.config.dodgeChance < 0)
                {
                    arg3.scripts.Performance.config.dodgeChance = 0;
                }
            }
        }
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight1: 0.02,
        weight2: 2,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("Performance", buffConfig);
}, function()
{
    playerCharacter.scripts.Performance.Script = function(arg0, arg1)
    {
        var timer;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight1: 0.04,
            weight2: 3,
            loseStackOnRemove: true
        };
        if (arg0.isMoving)
        {
            if (arg1.timer >= arg1.maxTimer)
            {
                obj_AttackController.ApplyBuff(arg0, "Performance", ds_map_find_value(obj_AttackController.Buffs, "Performance"), buffConfig);
                arg1.timer = 0;
            }
            else if (!variable_struct_exists(arg0.buffs, "Performance") || (variable_struct_exists(arg0.buffs, "Performance") && arg0.buffs.Performance.config.stacks < arg0.buffs.Performance.config.maxStacks))
            {
                arg1.timer++;
            }
            if (variable_struct_exists(arg0.buffs, "Performance"))
            {
                arg1.dodgeChance = arg0.buffs.Performance.config.stacks * arg0.buffs.Performance.config.weight2;
            }
        }
        else
        {
            arg1.timer = 0;
        }
    };
    
    playerCharacter.scripts.Performance.config.maxDodgeChance = 40;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight1: 0.04,
        weight2: 3,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("Performance", buffConfig);
}, function()
{
    playerCharacter.scripts.Performance.Script = function(arg0, arg1)
    {
        var timer;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight1: 0.06,
            weight2: 4,
            loseStackOnRemove: true
        };
        if (arg0.isMoving)
        {
            if (arg1.timer >= arg1.maxTimer)
            {
                obj_AttackController.ApplyBuff(arg0, "Performance", ds_map_find_value(obj_AttackController.Buffs, "Performance"), buffConfig);
                arg1.timer = 0;
            }
            else if (!variable_struct_exists(arg0.buffs, "Performance") || (variable_struct_exists(arg0.buffs, "Performance") && arg0.buffs.Performance.config.stacks < arg0.buffs.Performance.config.maxStacks))
            {
                arg1.timer++;
            }
            if (variable_struct_exists(arg0.buffs, "Performance"))
            {
                arg1.dodgeChance = arg0.buffs.Performance.config.stacks * arg0.buffs.Performance.config.weight2;
            }
        }
        else
        {
            arg1.timer = 0;
        }
    };
    
    playerCharacter.scripts.Performance.config.maxDodgeChance = 60;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight1: 0.06,
        weight2: 4,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("Performance", buffConfig);
}];
ds_map_set(PERKS, "Performance", new Perk("Performance", 
{
    optionName: global.TextContainer.PerformanceName.selectedLanguage,
    optionIcon: 1309,
    optionDescription: global.TextContainer.PerformanceDescription.selectedLanguage[0]
}, PerformanceOnApply));
var VirtualDivaOnApply = [function()
{
    playerCharacter.scripts.VirtualDiva = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10,
                weight: 1
            };
            if (arg1.timer >= arg1.maxTimer)
            {
                obj_AttackController.ApplyBuff(arg0, "VirtualDiva", ds_map_find_value(obj_AttackController.Buffs, "VirtualDiva"), buffConfig);
                arg1.timer = 0;
            }
            else
            {
                arg1.timer++;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60
        }
    };
    
    playerCharacter.onTakeDamage.VirtualDiva = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        if (arg0 < 1)
        {
            return arg0;
        }
        obj_AttackController.RemoveBuff(arg3, "VirtualDiva");
        arg3.scripts.VirtualDiva.config.timer = 0;
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 1
    };
    UpdateBuffIfExists("VirtualDiva", buffConfig);
}, function()
{
    playerCharacter.scripts.VirtualDiva.Script = function(arg0, arg1)
    {
        var timer;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 2
        };
        if (arg1.timer >= arg1.maxTimer)
        {
            obj_AttackController.ApplyBuff(arg0, "VirtualDiva", ds_map_find_value(obj_AttackController.Buffs, "VirtualDiva"), buffConfig);
            arg1.timer = 0;
        }
        else
        {
            arg1.timer++;
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 2
    };
    UpdateBuffIfExists("VirtualDiva", buffConfig);
}, function()
{
    playerCharacter.scripts.VirtualDiva.Script = function(arg0, arg1)
    {
        var timer;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 3
        };
        if (arg1.timer >= arg1.maxTimer)
        {
            obj_AttackController.ApplyBuff(arg0, "VirtualDiva", ds_map_find_value(obj_AttackController.Buffs, "VirtualDiva"), buffConfig);
            arg1.timer = 0;
        }
        else
        {
            arg1.timer++;
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 3
    };
    UpdateBuffIfExists("VirtualDiva", buffConfig);
}];
ds_map_set(PERKS, "VirtualDiva", new Perk("VirtualDiva", 
{
    optionName: global.TextContainer.VirtualDivaName.selectedLanguage,
    optionIcon: 137,
    optionDescription: global.TextContainer.VirtualDivaDescription.selectedLanguage[0]
}, VirtualDivaOnApply));
var EncoreOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Encore"))
    {
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            noRefresh: true,
            maxStacks: 999
        };
        obj_AttackController.ApplyBuff(playerCharacter, "Encore", ds_map_find_value(obj_AttackController.Buffs, "Encore"), buffConfig);
        playerCharacter.scripts.Encore = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer < arg1.maxTimer)
                {
                    arg1.timer++;
                }
                if (arg1.timer >= arg1.maxTimer)
                {
                    arg1.timer = 0;
                    if (variable_struct_exists(arg0.buffs, "Encore"))
                    {
                        obj_AttackController.RemoveBuff(arg0, "Encore");
                    }
                    obj_AttackController.ExecuteAttack("EncoreBurst", arg0, 
                    {
                        damage: arg1.encoreDamage,
                        damageStacks: arg1.damageStacks,
                        image_xscale: 1,
                        image_yscale: 1
                    });
                    var buffConfig = 
                    {
                        reapply: true,
                        stacks: 1,
                        noRefresh: true,
                        maxStacks: 999
                    };
                    obj_AttackController.ApplyBuff(arg0, "Encore", ds_map_find_value(obj_AttackController.Buffs, "Encore"), buffConfig);
                    arg1.damageStacks = 0;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 420,
                damageStacks: 0,
                encoreDamage: 1
            }
        };
    }
    
    playerCharacter.onKill.Encore = function(arg0, arg1, arg2)
    {
        playerCharacter.scripts.Encore.config.damageStacks += 10;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            noRefresh: true,
            maxStacks: 999
        };
        obj_AttackController.ApplyBuff(arg0, "Encore", ds_map_find_value(obj_AttackController.Buffs, "Encore"), buffConfig);
    };
}, function()
{
    playerCharacter.scripts.Encore.config.encoreDamage = 2;
}, function()
{
    playerCharacter.scripts.Encore.config.encoreDamage = 3;
}];
ds_map_set(PERKS, "Encore", new Perk("Encore", 
{
    optionName: global.TextContainer.EncoreName.selectedLanguage,
    optionIcon: 1920,
    optionDescription: global.TextContainer.EncoreDescription.selectedLanguage[0]
}, EncoreOnApply));
var StellarOnApply = [function()
{
    playerCharacter.scripts.Stellar = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            radius: 75,
            circleTime: 0,
            timer: 0,
            maxTimer: 20
        }
    };
    
    playerCharacter.customDrawScriptAbove.Stellar = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.Stellar.config.circleTime += 0.5;
            if (arg0.scripts.Stellar.config.circleTime >= (arg0.scripts.Stellar.config.radius / 1.5))
            {
                arg0.scripts.Stellar.config.circleTime = 0;
            }
            draw_set_color(c_blue);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.Stellar.config.radius - arg0.scripts.Stellar.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.Stellar.config.radius, true);
        }
    };
    
    playerCharacter.afterCriticalHit.Stellar = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 5,
            weight: 0.04
        };
        var roll = irandom(99);
        if (roll < 25)
        {
            ac.ApplyBuff(arg0, "Stellar", ds_map_find_value(ac.Buffs, "Stellar"), buffConfig);
            if (arg0.scripts.Stellar.config.timer == 0)
            {
                arg0.scripts.Stellar.config.timer = arg0.scripts.Stellar.config.maxTimer;
                var targets = ds_list_create();
                if (instance_exists(obj_Enemy))
                {
                    collision_circle_list(arg0.x, arg0.y, arg0.scripts.Stellar.config.radius, obj_Enemy, true, true, targets, false);
                }
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
                    {
                        if (arg2 != ds_list_find_value(targets, i))
                        {
                            ds_list_find_value(targets, i).TakeDamage(arg3, arg0, true, "Stellar", undefined, undefined, undefined, true);
                        }
                    }
                }
                ds_list_destroy(targets);
                targets = -1;
                var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 10, obj_vfx);
                vfx.sprite_index = spr_SuiseiStellar;
                vfx.image_speed = 0;
                vfx.image_xscale = 0.75;
                vfx.image_yscale = 0.75;
                vfx.image_alpha = 0.8;
                vfx.alarm[0] = 1;
                vfx.alarm[1] = 1;
                vfx.alarm[2] = 1;
                vfx.followCharacter = arg0;
                soundPlay([81], "stellar", 10, 5, false);
            }
        }
        return arg3;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 5,
        weight: 0.04
    };
    UpdateBuffIfExists("Stellar", buffConfig);
}, function()
{
    playerCharacter.afterCriticalHit.Stellar = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 5,
            weight: 0.06
        };
        var roll = irandom(99);
        if (roll < 25)
        {
            ac.ApplyBuff(arg0, "Stellar", ds_map_find_value(ac.Buffs, "Stellar"), buffConfig);
            if (arg0.scripts.Stellar.config.timer == 0)
            {
                arg0.scripts.Stellar.config.timer = arg0.scripts.Stellar.config.maxTimer;
                var targets = ds_list_create();
                if (instance_exists(obj_Enemy))
                {
                    collision_circle_list(arg0.x, arg0.y, arg0.scripts.Stellar.config.radius, obj_Enemy, true, true, targets, false);
                }
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
                    {
                        if (arg2 != ds_list_find_value(targets, i))
                        {
                            ds_list_find_value(targets, i).TakeDamage(arg3, arg0, true, "Stellar", undefined, undefined, undefined, true);
                        }
                    }
                }
                ds_list_destroy(targets);
                targets = -1;
                var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 10, obj_vfx);
                vfx.sprite_index = spr_SuiseiStellar;
                vfx.image_speed = 0;
                vfx.image_xscale = 0.75;
                vfx.image_yscale = 0.75;
                vfx.image_alpha = 0.8;
                vfx.alarm[0] = 1;
                vfx.alarm[1] = 1;
                vfx.alarm[2] = 1;
                vfx.followCharacter = arg0;
                soundPlay([81], "stellar", 10, 5, false);
            }
        }
        return arg3;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 5,
        weight: 0.06
    };
    UpdateBuffIfExists("Stellar", buffConfig);
}, function()
{
    playerCharacter.afterCriticalHit.Stellar = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 5,
            weight: 0.08
        };
        var roll = irandom(99);
        if (roll < 25)
        {
            ac.ApplyBuff(arg0, "Stellar", ds_map_find_value(ac.Buffs, "Stellar"), buffConfig);
            if (arg0.scripts.Stellar.config.timer == 0)
            {
                arg0.scripts.Stellar.config.timer = arg0.scripts.Stellar.config.maxTimer;
                var targets = ds_list_create();
                if (instance_exists(obj_Enemy))
                {
                    collision_circle_list(arg0.x, arg0.y, arg0.scripts.Stellar.config.radius, obj_Enemy, true, true, targets, false);
                }
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
                    {
                        if (arg2 != ds_list_find_value(targets, i))
                        {
                            ds_list_find_value(targets, i).TakeDamage(arg3, arg0, true, "Stellar", undefined, undefined, undefined, true);
                        }
                    }
                }
                ds_list_destroy(targets);
                targets = -1;
                var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 10, obj_vfx);
                vfx.sprite_index = spr_SuiseiStellar;
                vfx.image_speed = 0;
                vfx.image_xscale = 0.75;
                vfx.image_yscale = 0.75;
                vfx.image_alpha = 0.8;
                vfx.alarm[0] = 1;
                vfx.alarm[1] = 1;
                vfx.alarm[2] = 1;
                vfx.followCharacter = arg0;
                soundPlay([81], "stellar", 10, 5, false);
            }
        }
        return arg3;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 5,
        weight: 0.08
    };
    UpdateBuffIfExists("Stellar", buffConfig);
}];
ds_map_set(PERKS, "Stellar", new Perk("Stellar", 
{
    optionName: global.TextContainer.StellarName.selectedLanguage,
    optionIcon: 2034,
    optionDescription: global.TextContainer.StellarDescription.selectedLanguage[0]
}, StellarOnApply));
var SuicopathOnApply = [function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "AxeSwing").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "PsychoAxe").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "BLAxe").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "BLLoverBooks").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "MiComet").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "StarHalberd").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    
    playerCharacter.onKill.Suicopath = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 2
        };
        obj_AttackController.ApplyBuff(arg0, "Suicopath", ds_map_find_value(obj_AttackController.Buffs, "Suicopath"), buffConfig);
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 2
    };
    UpdateBuffIfExists("Suicopath", buffConfig);
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "AxeSwing").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "PsychoAxe").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "BLLover").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "MiComet").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    
    playerCharacter.onKill.Suicopath = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 3
        };
        obj_AttackController.ApplyBuff(arg0, "Suicopath", ds_map_find_value(obj_AttackController.Buffs, "Suicopath"), buffConfig);
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 3
    };
    UpdateBuffIfExists("Suicopath", buffConfig);
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "AxeSwing").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "PsychoAxe").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "BLLover").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    ds_map_find_value(obj_AttackController.attackIndex, "MiComet").config.onHitEffects.LifeSteal = 
    {
        chance: 10,
        heal: 3
    };
    
    playerCharacter.onKill.Suicopath = function(arg0, arg1, arg2)
    {
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 4
        };
        obj_AttackController.ApplyBuff(arg0, "Suicopath", ds_map_find_value(obj_AttackController.Buffs, "Suicopath"), buffConfig);
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: 4
    };
    UpdateBuffIfExists("Suicopath", buffConfig);
}];
ds_map_set(PERKS, "Suicopath", new Perk("Suicopath", 
{
    optionName: global.TextContainer.SuicopathName.selectedLanguage,
    optionIcon: 636,
    optionDescription: global.TextContainer.SuicopathDescription.selectedLanguage[0]
}, SuicopathOnApply));
var MasterOfBlocksOnApply = [function()
{
    playerCharacter.onCriticalHit.MasterOfBlocks = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 0.1
        };
        var roll = irandom(99);
        if (roll < 15 && arg0.scripts.MasterOfBlocks.config.timer == 0)
        {
            arg0.scripts.MasterOfBlocks.config.timer = arg0.scripts.MasterOfBlocks.config.maxTimer;
            ac.ExecuteAttack("SuiseiBlocks", arg0, 
            {
                damage: 1.5,
                blockCount: 1,
                x: arg2.x,
                y: arg2.y - 350,
                image_xscale: 1,
                image_yscale: 1
            });
        }
        return arg3;
    };
    
    playerCharacter.scripts.MasterOfBlocks = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.MasterOfBlocks.config.timer > 0)
            {
                arg0.scripts.MasterOfBlocks.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 6
        }
    };
}, function()
{
    playerCharacter.onCriticalHit.MasterOfBlocks = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 0.1
        };
        var roll = irandom(99);
        if (roll < 20 && arg0.scripts.MasterOfBlocks.config.timer == 0)
        {
            arg0.scripts.MasterOfBlocks.config.timer = arg0.scripts.MasterOfBlocks.config.maxTimer;
            ac.ExecuteAttack("SuiseiBlocks", arg0, 
            {
                damage: 2,
                blockCount: 2,
                x: arg2.x,
                y: arg2.y - 350,
                image_xscale: 1,
                image_yscale: 1
            });
        }
        return arg3;
    };
    
    playerCharacter.scripts.MasterOfBlocks = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.MasterOfBlocks.config.timer > 0)
            {
                arg0.scripts.MasterOfBlocks.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 6
        }
    };
}, function()
{
    playerCharacter.onCriticalHit.MasterOfBlocks = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 10,
            weight: 0.1
        };
        var roll = irandom(99);
        if (roll < 25 && arg0.scripts.MasterOfBlocks.config.timer == 0)
        {
            arg0.scripts.MasterOfBlocks.config.timer = arg0.scripts.MasterOfBlocks.config.maxTimer;
            ac.ExecuteAttack("SuiseiBlocks", arg0, 
            {
                damage: 2.5,
                blockCount: 3,
                x: arg2.x,
                y: arg2.y - 350,
                image_xscale: 1,
                image_yscale: 1
            });
        }
        return arg3;
    };
    
    playerCharacter.scripts.MasterOfBlocks = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.MasterOfBlocks.config.timer > 0)
            {
                arg0.scripts.MasterOfBlocks.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 6
        }
    };
}];
ds_map_set(PERKS, "MasterOfBlocks", new Perk("MasterOfBlocks", 
{
    optionName: global.TextContainer.MasterOfBlocksName.selectedLanguage,
    optionIcon: 1472,
    optionDescription: global.TextContainer.MasterOfBlocksDescription.selectedLanguage[0]
}, MasterOfBlocksOnApply));
var ComputationOnApply = [function()
{
    playerCharacter.onKill.Computation = function(arg0, arg1, arg2)
    {
        var roll = random(10);
        if (roll < 1)
        {
            with (arg1)
            {
                if (expvalue > 0)
                {
                    var dropexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
                    dropexp.expVal = expvalue * 0.5;
                    dropexp.direction = floor(random(360));
                    dropexp.speed = 1 + random(2);
                    with (dropexp)
                    {
                        instance_change(obj_Battery, true);
                    }
                }
            }
        }
    };
}, function()
{
    playerCharacter.onKill.Computation = function(arg0, arg1, arg2)
    {
        var roll = random(10);
        if (roll < 1.5)
        {
            with (arg1)
            {
                if (expvalue > 0)
                {
                    var dropexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
                    dropexp.expVal = expvalue * 0.75;
                    dropexp.direction = floor(random(360));
                    dropexp.speed = 1 + random(2);
                    with (dropexp)
                    {
                        instance_change(obj_Battery, true);
                    }
                }
            }
        }
    };
}, function()
{
    playerCharacter.onKill.Computation = function(arg0, arg1, arg2)
    {
        var roll = random(10);
        if (roll < 2)
        {
            with (arg1)
            {
                if (expvalue > 0)
                {
                    var dropexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
                    dropexp.expVal = expvalue;
                    dropexp.direction = floor(random(360));
                    dropexp.speed = 1 + random(2);
                    with (dropexp)
                    {
                        instance_change(obj_Battery, true);
                    }
                }
            }
        }
    };
}];
ds_map_set(PERKS, "Computation", new Perk("Computation", 
{
    optionName: global.TextContainer.ComputationName.selectedLanguage,
    optionIcon: 7,
    optionDescription: global.TextContainer.ComputationDescription.selectedLanguage[0]
}, ComputationOnApply));
var HiLevelOnApply = [function()
{
    playerCharacter.ATK += floor(global.PLAYERLEVEL * 0.01 * 100) / 100;
    playerCharacter.crit += floor((global.PLAYERLEVEL div 10) * 3);
}, function()
{
    playerCharacter.ATK += floor(global.PLAYERLEVEL * 0.011 * 100) / 100;
    playerCharacter.crit += floor((global.PLAYERLEVEL div 10) * 4);
}, function()
{
    playerCharacter.ATK += floor(global.PLAYERLEVEL * 0.012 * 100) / 100;
    playerCharacter.crit += floor((global.PLAYERLEVEL div 10) * 5);
}];
ds_map_set(PERKS, "HiLevel", new Perk("HiLevel", 
{
    optionName: global.TextContainer.HiLevelName.selectedLanguage,
    optionIcon: 1289,
    optionDescription: global.TextContainer.HiLevelDescription.selectedLanguage[0]
}, HiLevelOnApply));
var RoboDischargeOnApply = [function()
{
    playerCharacter.onLevelUp.RoboDischarge = function(arg0, arg1)
    {
        obj_AttackController.ExecuteAttack("RoboDischarge", arg0, 
        {
            baseDamage: 1,
            image_xscale: 0.8,
            image_yscale: 0.8
        });
    };
}, function()
{
    playerCharacter.onLevelUp.RoboDischarge = function(arg0, arg1)
    {
        obj_AttackController.ExecuteAttack("RoboDischarge", arg0, 
        {
            baseDamage: 1.25,
            image_xscale: 1,
            image_yscale: 1
        });
    };
}, function()
{
    playerCharacter.onLevelUp.RoboDischarge = function(arg0, arg1)
    {
        obj_AttackController.ExecuteAttack("RoboDischarge", arg0, 
        {
            baseDamage: 1.5,
            image_xscale: 1.2,
            image_yscale: 1.2
        });
    };
}];
ds_map_set(PERKS, "RoboDischarge", new Perk("RoboDischarge", 
{
    optionName: global.TextContainer.RoboDischargeName.selectedLanguage,
    optionIcon: 1308,
    optionDescription: global.TextContainer.RoboDischargeDescription.selectedLanguage[0]
}, RoboDischargeOnApply));
var BabyLanguageOnApply = [function()
{
    playerCharacter.scripts.BabyLanguage = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 15
        }
    };
    variable_struct_set(playerCharacter.onHitEffects, "NyehHit", 
    {
        damage: 0.5,
        chance: 10
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "NyehHit", 
    {
        damage: 0.75,
        chance: 15
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "NyehHit", 
    {
        damage: 1,
        chance: 20
    });
}];
ds_map_set(PERKS, "BabyLanguage", new Perk("BabyLanguage", 
{
    optionName: global.TextContainer.BabyLanguageName.selectedLanguage,
    optionIcon: 2333,
    optionDescription: global.TextContainer.BabyLanguageDescription.selectedLanguage[0]
}, BabyLanguageOnApply));
var ErogeHeroOnApply = [function()
{
    playerCharacter.onKill.ErogeHero = function(arg0, arg1, arg2)
    {
        obj_AttackController.ApplyBuff(playerCharacter, "ErogeHero", ds_map_find_value(obj_AttackController.Buffs, "ErogeHero"));
    };
    
    playerCharacter.scripts.ErogeHero = 
    {
        Script: function(arg0, arg1)
        {
            if (variable_struct_exists(arg0.buffs, "ErogeHero") && arg0.scripts.ErogeHero.config.timer > 0)
            {
                arg0.scripts.ErogeHero.config.timer--;
            }
            else
            {
                arg0.scripts.ErogeHero.config.timer = arg0.scripts.ErogeHero.config.maxTimer;
            }
            if (arg0.scripts.ErogeHero.config.timer == 0)
            {
                Heal(arg0, arg0.scripts.ErogeHero.config.healAmount, 1, true, false);
                arg0.scripts.ErogeHero.config.timer = arg0.scripts.ErogeHero.config.maxTimer;
            }
        },
        
        config: 
        {
            timer: 120,
            maxTimer: 120,
            healAmount: 2
        }
    };
}, function()
{
    playerCharacter.scripts.ErogeHero = 
    {
        Script: function(arg0, arg1)
        {
            if (variable_struct_exists(arg0.buffs, "ErogeHero") && arg0.scripts.ErogeHero.config.timer > 0)
            {
                arg0.scripts.ErogeHero.config.timer--;
            }
            else
            {
                arg0.scripts.ErogeHero.config.timer = arg0.scripts.ErogeHero.config.maxTimer;
            }
            if (arg0.scripts.ErogeHero.config.timer == 0)
            {
                Heal(arg0, arg0.scripts.ErogeHero.config.healAmount, 1, true, false);
                arg0.scripts.ErogeHero.config.timer = arg0.scripts.ErogeHero.config.maxTimer;
            }
        },
        
        config: 
        {
            timer: 120,
            maxTimer: 120,
            healAmount: 3
        }
    };
}, function()
{
    playerCharacter.scripts.ErogeHero = 
    {
        Script: function(arg0, arg1)
        {
            if (variable_struct_exists(arg0.buffs, "ErogeHero") && arg0.scripts.ErogeHero.config.timer > 0)
            {
                arg0.scripts.ErogeHero.config.timer--;
            }
            else
            {
                arg0.scripts.ErogeHero.config.timer = arg0.scripts.ErogeHero.config.maxTimer;
            }
            if (arg0.scripts.ErogeHero.config.timer == 0)
            {
                Heal(arg0, arg0.scripts.ErogeHero.config.healAmount, 1, true, false);
                arg0.scripts.ErogeHero.config.timer = arg0.scripts.ErogeHero.config.maxTimer;
            }
        },
        
        config: 
        {
            timer: 120,
            maxTimer: 120,
            healAmount: 4
        }
    };
}];
ds_map_set(PERKS, "ErogeHero", new Perk("ErogeHero", 
{
    optionName: global.TextContainer.ErogeHeroName.selectedLanguage,
    optionIcon: 1479,
    optionDescription: global.TextContainer.ErogeHeroDescription.selectedLanguage[0]
}, ErogeHeroOnApply));
var EliteOnApply = [function()
{
    playerCharacter.onHeal.Elite = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight1: 0.2,
            weight2: 0.2
        };
        ac.ApplyBuff(arg1, "Elite", ds_map_find_value(ac.Buffs, "Elite"), buffConfig);
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight1: 0.2,
        weight2: 0.2
    };
    UpdateBuffIfExists("Elite", buffConfig);
}, function()
{
    playerCharacter.onHeal.Elite = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight1: 0.35,
            weight2: 0.35
        };
        ac.ApplyBuff(arg1, "Elite", ds_map_find_value(ac.Buffs, "Elite"), buffConfig);
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight1: 0.35,
        weight2: 0.35
    };
    UpdateBuffIfExists("Elite", buffConfig);
}, function()
{
    playerCharacter.onHeal.Elite = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            weight1: 0.5,
            weight2: 0.5
        };
        ac.ApplyBuff(arg1, "Elite", ds_map_find_value(ac.Buffs, "Elite"), buffConfig);
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        weight1: 0.5,
        weight2: 0.5
    };
    UpdateBuffIfExists("Elite", buffConfig);
}];
ds_map_set(PERKS, "Elite", new Perk("Elite", 
{
    optionName: global.TextContainer.EliteName.selectedLanguage,
    optionIcon: 2023,
    optionDescription: global.TextContainer.EliteDescription.selectedLanguage[0]
}, EliteOnApply));

function StrongestIdolStepBuffApply(arg0, arg1)
{
    if (variable_instance_exists(arg0, "haatoMode"))
    {
        switch (arg0.haatoMode)
        {
            case 0:
                arg0.DR *= arg1.amount1;
                break;
            case 1:
                arg0.ATK += arg1.amount2;
                break;
            case 2:
                arg0.DR *= arg1.amount1;
                arg0.ATK += arg1.amount2;
                break;
        }
    }
}

var StrongestIdolOnApply = [function()
{
    playerCharacter.stepBuffs.StrongestIdol = 
    {
        Apply: StrongestIdolStepBuffApply,
        config: 
        {
            amount1: 0.8,
            amount2: 0.3
        }
    };
}, function()
{
    playerCharacter.stepBuffs.StrongestIdol = 
    {
        Apply: StrongestIdolStepBuffApply,
        config: 
        {
            amount1: 0.75,
            amount2: 0.4
        }
    };
}, function()
{
    playerCharacter.stepBuffs.StrongestIdol = 
    {
        Apply: StrongestIdolStepBuffApply,
        config: 
        {
            amount1: 0.7,
            amount2: 0.5
        }
    };
}];
ds_map_set(PERKS, "StrongestIdol", new Perk("StrongestIdol", 
{
    optionName: global.TextContainer.StrongestIdolName.selectedLanguage,
    optionIcon: 1456,
    optionDescription: global.TextContainer.StrongestIdolDescription.selectedLanguage[0]
}, StrongestIdolOnApply));

PAI = function(arg0, arg1)
{
    if (variable_instance_exists(playerCharacter, "haatoMode"))
    {
        if (playerCharacter.haatoMode == 0)
        {
            playerCharacter.scripts.PurityAndInsanity = 
            {
                Script: function(arg0, arg1)
                {
                    var timer, spiderTimer;
                    if (arg1.timer <= 0)
                    {
                        Heal(arg0, arg1.heal, 1, true, false);
                        arg1.timer = arg1.maxTimer;
                    }
                    else
                    {
                        arg1.timer--;
                    }
                    if (arg1.spiderTimer > 0)
                    {
                        arg1.spiderTimer--;
                    }
                },
                
                config: arg1
            };
            if (variable_struct_exists(ds_map_find_value(playerCharacter.attacks, "RedHeart").config.onHitEffects, "SpiderBurst"))
            {
                variable_struct_remove(ds_map_find_value(playerCharacter.attacks, "RedHeart").config.onHitEffects, "SpiderBurst");
            }
        }
        if (playerCharacter.haatoMode == 1)
        {
            playerCharacter.scripts.PurityAndInsanity = 
            {
                Script: function(arg0, arg1)
                {
                    var spiderTimer;
                    ds_map_find_value(arg0.attacks, "RedHeart").config.onHitEffects.SpiderBurst = 
                    {
                        chance: 20,
                        radius: arg1.radius,
                        damage: arg1.damage
                    };
                    if (arg1.spiderTimer > 0)
                    {
                        arg1.spiderTimer--;
                    }
                },
                
                config: arg1
            };
        }
        if (playerCharacter.haatoMode == 2)
        {
            playerCharacter.scripts.PurityAndInsanity = 
            {
                Script: function(arg0, arg1)
                {
                    var timer, spiderTimer;
                    if (arg1.timer == 0)
                    {
                        Heal(arg0, arg1.heal, 1, true, false);
                        arg1.timer = arg1.maxTimer;
                    }
                    else
                    {
                        arg1.timer--;
                    }
                    if (arg1.spiderTimer > 0)
                    {
                        arg1.spiderTimer--;
                    }
                    ds_map_find_value(arg0.attacks, "RedHeart").config.onHitEffects.SpiderBurst = 
                    {
                        chance: 20,
                        radius: arg1.radius,
                        damage: arg1.damage
                    };
                },
                
                config: arg1
            };
        }
    }
};

var PurityAndInsanityOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.onSpecial, "PurityAndInsanity"))
    {
        var PAIconfig = 
        {
            timer: 0,
            maxTimer: 150,
            heal: 3,
            damage: 0.3,
            circleTime: 0,
            radius: 125,
            spiderTimer: 0,
            spiderMaxTimer: 15
        };
        playerCharacter.onSpecial.PurityAndInsanity = 
        {
            Script: PAI,
            config: PAIconfig
        };
        PAI(playerCharacter, PAIconfig);
    }
}, function()
{
    playerCharacter.onSpecial.PurityAndInsanity.config.damage = 0.4;
    playerCharacter.onSpecial.PurityAndInsanity.config.heal = 5;
}, function()
{
    playerCharacter.onSpecial.PurityAndInsanity.config.damage = 0.5;
    playerCharacter.onSpecial.PurityAndInsanity.config.heal = 7;
}];
ds_map_set(PERKS, "PurityAndInsanity", new Perk("PurityAndInsanity", 
{
    optionName: global.TextContainer.PurityAndInsanityName.selectedLanguage,
    optionIcon: 2050,
    optionDescription: global.TextContainer.PurityAndInsanityDescription.selectedLanguage[0]
}, PurityAndInsanityOnApply));
var CoexistenceOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Coexistence"))
    {
        playerCharacter.onSpecial.Coexistence = 
        {
            Script: function(arg0)
            {
            },
            
            config: {}
        };
        playerCharacter.scripts.Coexistence = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                var buffConfig = 
                {
                    reapply: true,
                    stacks: 1,
                    noRefresh: true,
                    maxStacks: arg1.maxStacks
                };
                if (arg1.timer <= 0)
                {
                    if (variable_struct_exists(arg0.buffs, "Coexistence") && arg0.buffs.Coexistence.config.stacks == (arg1.maxStacks - 1))
                    {
                        soundPlay([85], "coexist", 5, 30);
                    }
                    obj_AttackController.ApplyBuff(arg0, "Coexistence", ds_map_find_value(obj_AttackController.Buffs, "Coexistence"), buffConfig);
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 60,
                buffDuration: 600,
                maxStacks: 60
            }
        };
    }
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        noRefresh: true,
        maxStacks: 55
    };
    UpdateBuffIfExists("Coexistence", buffConfig);
    playerCharacter.scripts.Coexistence.config.buffDuration = 720;
    playerCharacter.scripts.Coexistence.config.maxStacks = 55;
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        noRefresh: true,
        maxStacks: 50
    };
    UpdateBuffIfExists("Coexistence", buffConfig);
    playerCharacter.scripts.Coexistence.config.buffDuration = 840;
    playerCharacter.scripts.Coexistence.config.maxStacks = 50;
}];
ds_map_set(PERKS, "Coexistence", new Perk("Coexistence", 
{
    optionName: global.TextContainer.CoexistenceName.selectedLanguage,
    optionIcon: 1944,
    optionDescription: global.TextContainer.CoexistenceDescription.selectedLanguage[0]
}, CoexistenceOnApply));
var VampireOnApply = [function()
{
    playerCharacter.scripts.Vampire = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.Vampire.config.timer > 0)
            {
                arg0.scripts.Vampire.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 12
        }
    };
    
    playerCharacter.onHeal.Vampire = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        if (arg3)
        {
            if (variable_struct_exists(arg1.scripts, "Vampire") && arg1.scripts.Vampire.config.timer == 0)
            {
                obj_AttackController.ExecuteAttack("MelBat", arg1, 
                {
                    onHitEffects: {}
                });
                arg1.scripts.Vampire.config.timer = arg1.scripts.Vampire.config.maxTimer;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onHeal.Vampire = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        if (arg3)
        {
            if (variable_struct_exists(arg1.scripts, "Vampire") && arg1.scripts.Vampire.config.timer == 0)
            {
                obj_AttackController.ExecuteAttack("MelBat", arg1, 
                {
                    onHitEffects: {}
                });
                obj_AttackController.ExecuteAttack("MelBat", arg1, 
                {
                    onHitEffects: {}
                });
                arg1.scripts.Vampire.config.timer = arg1.scripts.Vampire.config.maxTimer;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onHeal.Vampire = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        if (arg3)
        {
            if (variable_struct_exists(arg1.scripts, "Vampire") && arg1.scripts.Vampire.config.timer == 0)
            {
                obj_AttackController.ExecuteAttack("MelBat", arg1, 
                {
                    onHitEffects: {}
                });
                obj_AttackController.ExecuteAttack("MelBat", arg1, 
                {
                    onHitEffects: {}
                });
                obj_AttackController.ExecuteAttack("MelBat", arg1, 
                {
                    onHitEffects: {}
                });
                arg1.scripts.Vampire.config.timer = arg1.scripts.Vampire.config.maxTimer;
            }
        }
        return arg0;
    };
}];
ds_map_set(PERKS, "Vampire", new Perk("Vampire", 
{
    optionName: global.TextContainer.VampireName.selectedLanguage,
    optionIcon: 1436,
    optionDescription: global.TextContainer.VampireDescription.selectedLanguage[0]
}, VampireOnApply));
var AcerolaJuiceOnApply = [function()
{
    playerCharacter.onHeal.AcerolaJuice = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 0.3,
            buffIcon: 1631
        };
        if (arg2)
        {
            arg1.scripts.AcerolaJuice.config.lfStacks = arg1.scripts.AcerolaJuice.config.lfMaxStacks;
            ac.ApplyBuff(arg1, "AcerolaJuice", ds_map_find_value(ac.Buffs, "AcerolaJuice"), buffConfig);
        }
        return arg0;
    };
    
    variable_struct_set(playerCharacter.onHitEffects, "AcerolaJuice", 
    {
        heal: 0.2
    });
    if (!variable_struct_exists(playerCharacter.scripts, "AcerolaJuice"))
    {
        playerCharacter.scripts.AcerolaJuice = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                lfStacks: 0,
                lfMaxStacks: 4,
                timer: 0,
                maxTimer: 3,
                buffConfig: 
                {
                    buffIcon: 1631,
                    weight: 0.3
                }
            }
        };
    }
    var buffConfig = 
    {
        buffIcon: 1631,
        weight: 0.3
    };
    UpdateBuffIfExists("AcerolaJuice", buffConfig);
}, function()
{
    var buffConfig = 
    {
        buffIcon: 1631,
        weight: 0.4
    };
    
    playerCharacter.onHeal.AcerolaJuice = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 0.4,
            buffIcon: 1631
        };
        if (arg2)
        {
            arg1.scripts.AcerolaJuice.config.lfStacks = arg1.scripts.AcerolaJuice.config.lfMaxStacks;
            ac.ApplyBuff(arg1, "AcerolaJuice", ds_map_find_value(ac.Buffs, "AcerolaJuice"), buffConfig);
        }
        return arg0;
    };
    
    playerCharacter.scripts.AcerolaJuice.config.lfMaxStacks = 6;
    playerCharacter.scripts.AcerolaJuice.config.buffConfig.weight = buffConfig.weight;
    UpdateBuffIfExists("AcerolaJuice", buffConfig);
}, function()
{
    var buffConfig = 
    {
        buffIcon: 1631,
        weight: 0.5
    };
    
    playerCharacter.onHeal.AcerolaJuice = function(arg0, arg1, arg2)
    {
        var ac = 114;
        var buffConfig = 
        {
            weight: 0.5,
            buffIcon: 1631
        };
        if (arg2)
        {
            arg1.scripts.AcerolaJuice.config.lfStacks = arg1.scripts.AcerolaJuice.config.lfMaxStacks;
            ac.ApplyBuff(arg1, "AcerolaJuice", ds_map_find_value(ac.Buffs, "AcerolaJuice"), buffConfig);
        }
        return arg0;
    };
    
    playerCharacter.scripts.AcerolaJuice.config.lfMaxStacks = 8;
    playerCharacter.scripts.AcerolaJuice.config.buffConfig.weight = buffConfig.weight;
    UpdateBuffIfExists("AcerolaJuice", buffConfig);
}];
ds_map_set(PERKS, "AcerolaJuice", new Perk("AcerolaJuice", 
{
    optionName: global.TextContainer.AcerolaJuiceName.selectedLanguage,
    optionIcon: 1631,
    optionDescription: global.TextContainer.AcerolaJuiceDescription.selectedLanguage[0]
}, AcerolaJuiceOnApply));
var MelMelCookingOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "MelMelCooking"))
    {
        playerCharacter.scripts.MelMelCooking = 
        {
            Script: function(arg0, arg1)
            {
                if (arg0.scripts.MelMelCooking.config.timer > 0)
                {
                    arg0.scripts.MelMelCooking.config.timer--;
                }
                else
                {
                    for (var i = 0; i < arg1.cookingNumber; i++)
                    {
                        var cooking = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_MelMelCooking);
                        cooking.creator = arg0;
                        cooking.radius = 75;
                        cooking.healVal = arg1.healVal;
                    }
                    arg1.timer = arg1.maxTimer;
                }
            },
            
            config: 
            {
                timer: 0,
                cookingNumber: 3,
                maxTimer: 900,
                healVal: 4
            }
        };
    }
}, function()
{
    playerCharacter.scripts.MelMelCooking.config.cookingNumber = 4;
    playerCharacter.scripts.MelMelCooking.config.healVal = 6;
}, function()
{
    playerCharacter.scripts.MelMelCooking.config.cookingNumber = 5;
    playerCharacter.scripts.MelMelCooking.config.healVal = 8;
}];
ds_map_set(PERKS, "MelMelCooking", new Perk("MelMelCooking", 
{
    optionName: global.TextContainer.MelMelCookingName.selectedLanguage,
    optionIcon: 1462,
    optionDescription: global.TextContainer.MelMelCookingDescription.selectedLanguage[0]
}, MelMelCookingOnApply));
var SeisoRepOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "SeisoRep"))
    {
        playerCharacter.onTakeDamage.SeisoRep = function(arg0, arg1, arg2, arg3)
        {
            if (variable_struct_exists(arg3.buffs, "SeisoRep"))
            {
                arg3.scripts.SeisoRep.config.timer = arg3.scripts.SeisoRep.config.maxTimer;
                obj_AttackController.RemoveBuff(arg3, "SeisoRep");
                var buffConfig = 
                {
                    damage: arg3.scripts.SeisoRep.config.damage,
                    timer: 0,
                    maxTimer: 60
                };
                soundPlay([145], "SeisoRep", 5, 30);
                arg0 = 0;
                arg3.scripts.SeisoRep.config.unseisoTimer = 300;
                obj_AttackController.ApplyBuff(arg3, "SeisoRep3", ds_map_find_value(obj_AttackController.Buffs, "SeisoRep3"), 
                {
                    buffIcon: 2250
                });
            }
            return arg0;
        };
        
        playerCharacter.scripts.SeisoRep = 
        {
            Script: function(arg0, arg1)
            {
                var unseisoTimer;
                if (arg0.scripts.SeisoRep.config.timer < 1)
                {
                    obj_AttackController.ApplyBuff(arg0, "SeisoRep", ds_map_find_value(obj_AttackController.Buffs, "SeisoRep"));
                }
                else if (arg0.scripts.SeisoRep.config.timer > 0)
                {
                    arg0.scripts.SeisoRep.config.timer--;
                }
                if (arg1.unseisoTimer > 0)
                {
                    if ((arg1.unseisoTimer % 60) == 0)
                    {
                        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 50, obj_vfx);
                        vfx.sprite_index = spr_MelCookingPulse;
                        vfx.image_speed = 0;
                        vfx.image_alpha = 0.4;
                        vfx.image_xscale = 0.7;
                        vfx.image_yscale = 0.7;
                        vfx.alarm[1] = 1;
                        vfx.alarm[0] = 1;
                        vfx.offset_y = -16;
                        vfx.fadeSpeed = 0.01;
                        vfx.growthSpeed = 0.04;
                        vfx.followCharacter = arg0;
                    }
                    arg1.unseisoTimer--;
                    var debuffTargets = ds_list_create();
                    if (instance_exists(obj_Enemy))
                    {
                        collision_circle_list(arg0.x, arg0.y, 100, obj_Enemy, true, true, debuffTargets, false);
                    }
                    for (var i = 0; i < ds_list_size(debuffTargets); i++)
                    {
                        var target = ds_list_find_value(debuffTargets, i);
                        obj_AttackController.ApplyBuff(target, "SeisoRep2", ds_map_find_value(obj_AttackController.Buffs, "SeisoRep2"), 
                        {
                            damage: 2,
                            reapply: true,
                            maxTimer: 60,
                            timer: 0
                        });
                    }
                    ds_list_destroy(debuffTargets);
                    debuffTargets = -1;
                }
            },
            
            config: 
            {
                timer: 60,
                damage: 2,
                maxTimer: 720,
                unseisoTimer: 0
            }
        };
    }
}, function()
{
    playerCharacter.scripts.SeisoRep.config.damage = 2.5;
}, function()
{
    playerCharacter.scripts.SeisoRep.config.damage = 3;
}];
ds_map_set(PERKS, "SeisoRep", new Perk("SeisoRep", 
{
    optionName: global.TextContainer.SeisoRepName.selectedLanguage,
    optionIcon: 1101,
    optionDescription: global.TextContainer.SeisoRepDescription.selectedLanguage[0]
}, SeisoRepOnApply));
var CheerleaderOnApply = [function()
{
    playerCharacter.scripts.Cheerleader = 
    {
        Script: function(arg0, arg1)
        {
        },
        
        config: 
        {
            range: 100,
            circleTime: 0
        }
    };
    variable_struct_set(playerCharacter.onHitEffects, "Cheerleader", 
    {
        weight1: 0.02,
        weight2: 0.02,
        stacks: 1,
        maxStacks: 15,
        reapply: true
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "Cheerleader", 
    {
        weight1: 0.03,
        weight2: 0.03,
        stacks: 1,
        maxStacks: 15,
        reapply: true
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "Cheerleader", 
    {
        weight1: 0.04,
        weight2: 0.04,
        stacks: 1,
        maxStacks: 15,
        reapply: true
    });
}];
ds_map_set(PERKS, "Cheerleader", new Perk("Cheerleader", 
{
    optionName: global.TextContainer.CheerleaderName.selectedLanguage,
    optionIcon: 119,
    optionDescription: global.TextContainer.CheerleaderDescription.selectedLanguage[0]
}, CheerleaderOnApply));
var GodOnApply = [function()
{
    playerCharacter.scripts.God = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
    
    playerCharacter.onTakeDamage.God = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.scripts.God.config.timer == 0)
        {
            var roll = irandom(99);
            var beamDamage = 2;
            if (roll < 25)
            {
                if (variable_instance_exists(arg1, "creator"))
                {
                    obj_AttackController.ExecuteAttack("GodBeam", arg3, 
                    {
                        x: arg1.creator.x,
                        y: arg1.creator.y - 456,
                        followTarget: arg1.creator,
                        damage: beamDamage
                    });
                }
                else
                {
                    obj_AttackController.ExecuteAttack("GodBeam", arg3, 
                    {
                        x: arg1.x,
                        y: arg1.y - 456,
                        followTarget: arg1,
                        damage: beamDamage
                    });
                }
                arg3.scripts.God.config.timer = arg3.scripts.God.config.maxTimer;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.God = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.scripts.God.config.timer == 0)
        {
            var roll = irandom(99);
            var beamDamage = 4;
            if (roll < 33)
            {
                if (variable_instance_exists(arg1, "creator"))
                {
                    obj_AttackController.ExecuteAttack("GodBeam", arg3, 
                    {
                        x: arg1.creator.x,
                        y: arg1.creator.y - 456,
                        followTarget: arg1.creator,
                        damage: beamDamage
                    });
                }
                else
                {
                    obj_AttackController.ExecuteAttack("GodBeam", arg3, 
                    {
                        x: arg1.x,
                        y: arg1.y - 456,
                        followTarget: arg1,
                        damage: beamDamage
                    });
                }
                arg3.scripts.God.config.timer = arg3.scripts.God.config.maxTimer;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onTakeDamage.God = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.scripts.God.config.timer == 0)
        {
            var roll = irandom(99);
            var beamDamage = 6;
            if (roll < 50)
            {
                if (variable_instance_exists(arg1, "creator"))
                {
                    obj_AttackController.ExecuteAttack("GodBeam", arg3, 
                    {
                        x: arg1.creator.x,
                        y: arg1.creator.y - 456,
                        followTarget: arg1.creator,
                        damage: beamDamage
                    });
                }
                else
                {
                    obj_AttackController.ExecuteAttack("GodBeam", arg3, 
                    {
                        x: arg1.x,
                        y: arg1.y - 456,
                        followTarget: arg1,
                        damage: beamDamage
                    });
                }
                arg3.scripts.God.config.timer = arg3.scripts.God.config.maxTimer;
            }
        }
        return arg0;
    };
}];
ds_map_set(PERKS, "God", new Perk("God", 
{
    optionName: global.TextContainer.GodName.selectedLanguage,
    optionIcon: 1599,
    optionDescription: global.TextContainer.GodDescription.selectedLanguage[0]
}, GodOnApply));
var AromatherapyOnApply = [function()
{
    playerCharacter.scripts.Aromatherapy = 
    {
        Script: function(arg0)
        {
            var debuffTargets = ds_list_create();
            var radius = config.radius;
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg0.x, arg0.y, radius, obj_Enemy, true, true, debuffTargets, false);
            }
            for (var i = 0; i < min(50, ds_list_size(debuffTargets)); i++)
            {
                var target = ds_list_find_value(debuffTargets, i);
                obj_AttackController.ApplyBuff(target, "Aromatherapy", ds_map_find_value(obj_AttackController.Buffs, "Aromatherapy"), 
                {
                    reapply: true,
                    maxTimer: 90,
                    timer: 90,
                    chance: config.chance
                });
            }
            ds_list_destroy(debuffTargets);
            debuffTargets = -1;
        },
        
        config: 
        {
            circleTime: 0,
            radius: 100,
            chance: 15
        }
    };
    
    playerCharacter.customDrawScriptAbove.Aromatherapy = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.scripts.Aromatherapy.config.circleTime += 0.5;
            if (arg0.scripts.Aromatherapy.config.circleTime >= (arg0.scripts.Aromatherapy.config.radius / 1.5))
            {
                arg0.scripts.Aromatherapy.config.circleTime = 0;
            }
            draw_set_color(c_blue);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.Aromatherapy.config.radius - arg0.scripts.Aromatherapy.config.circleTime, true);
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.Aromatherapy.config.radius, true);
        }
    };
}, function()
{
    playerCharacter.scripts.Aromatherapy.config.radius = 125;
    playerCharacter.scripts.Aromatherapy.config.chance = 25;
}, function()
{
    playerCharacter.scripts.Aromatherapy.config.radius = 150;
    playerCharacter.scripts.Aromatherapy.config.chance = 35;
}];
ds_map_set(PERKS, "Aromatherapy", new Perk("Aromatherapy", 
{
    optionName: global.TextContainer.AromatherapyName.selectedLanguage,
    optionIcon: 104,
    optionDescription: global.TextContainer.AromatherapyDescription.selectedLanguage[0]
}, AromatherapyOnApply));
var BellyDancingOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "BellyDancing"))
    {
        playerCharacter.scripts.BellyDancing = 
        {
            Script: function(arg0, arg1)
            {
                var damageStacks, timer, stopTimer;
                if (arg1.timer < 1 && arg0.isMoving)
                {
                    var buffConfig = {};
                    var keys = variable_struct_get_names(arg1.buffConfig);
                    variable_struct_copy(arg1.buffConfig, buffConfig);
                    obj_AttackController.ApplyBuff(arg0, "BellyDancing", ds_map_find_value(obj_AttackController.Buffs, "BellyDancing"), buffConfig);
                    arg1.damageStacks++;
                    arg1.timer = arg1.maxTimer;
                }
                else if (arg0.isMoving)
                {
                    arg1.timer--;
                    arg1.stopTimer = 40;
                }
                else if (!arg0.isMoving)
                {
                    if (arg1.stopTimer > 0)
                    {
                        arg1.stopTimer--;
                    }
                }
                if (arg1.stopTimer == 0)
                {
                    if (variable_struct_exists(arg0.buffs, "BellyDancing"))
                    {
                        obj_AttackController.RemoveBuff(arg0, "BellyDancing");
                        obj_AttackController.ExecuteAttack("BellyDanceBurst", arg0, 
                        {
                            stackDamage: arg1.stackDamage,
                            damageStacks: arg1.damageStacks,
                            image_xscale: 1,
                            image_yscale: 1
                        });
                        arg1.stopTimer = -1;
                        arg1.damageStacks = 0;
                    }
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 60,
                stopTimer: 40,
                stackDamage: 0.2,
                damageStacks: 0,
                buffConfig: 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: 9999
                }
            }
        };
        
        playerCharacter.customDrawScriptBelow.BellyDancing = function(arg0)
        {
            if (arg0.scripts.BellyDancing.config.damageStacks > 0)
            {
                var size = min(10, (0.25 + (arg0.scripts.BellyDancing.config.damageStacks * 0.01)) * (0.95 + random(0.1)));
                if (global.lightFX)
                {
                    var randomDirection = 
                    {
                        x: lengthdir_x(40, irandom(359)),
                        y: lengthdir_y(40, irandom(359))
                    };
                    var randSize = random(0.2);
                    var vfx = instance_create_depth(320 + randomDirection.x, 180 + randomDirection.y, arg0.depth - 30, obj_vfxGUI);
                    vfx.sprite_index = spr_gachaorb;
                    vfx.image_xscale = 0.2 + randSize;
                    vfx.image_yscale = 0.2 + randSize;
                    vfx.image_alpha = 0.5;
                    vfx.alarm[0] = 1;
                    vfx.growthSpeed = -0.02;
                    vfx.add = true;
                    vfx.duration = 20;
                    vfx.speed = 2;
                    vfx.direction = point_direction(vfx.x, vfx.y, 320, 180);
                }
                draw_sprite_ext(spr_MelCookingPulse, 0, arg0.x, arg0.y - 16, size, size, 0, c_white, 0.2);
            }
        };
    }
}, function()
{
    playerCharacter.scripts.BellyDancing.config.stackDamage = 0.3;
}, function()
{
    playerCharacter.scripts.BellyDancing.config.stackDamage = 0.4;
}];
ds_map_set(PERKS, "BellyDancing", new Perk("BellyDancing", 
{
    optionName: global.TextContainer.BellyDancingName.selectedLanguage,
    optionIcon: 311,
    optionDescription: global.TextContainer.BellyDancingDescription.selectedLanguage[0]
}, BellyDancingOnApply));
var MukiroseOnApply = [function()
{
    playerCharacter.scripts.Mukirose = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 3
        }
    };
    
    playerCharacter.onDebuff.Mukirose = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        if (arg0.scripts.Mukirose.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll < 50)
            {
                var numberOfDebuffs = 0;
                if (instance_exists(arg5))
                {
                    for (var i = 0; i < array_length(arg5.debuffIcons); i++)
                    {
                        if (arg5.debuffIcons[i] > 0)
                        {
                            numberOfDebuffs++;
                        }
                    }
                    arg0.scripts.Mukirose.config.timer = arg0.scripts.Mukirose.config.maxTimer;
                    var dmgObj = obj_AttackController.CalculateDamage(arg5, arg0, 
                    {
                        damage: 0.25 * numberOfDebuffs
                    });
                    arg5.TakeDamage(dmgObj[0], arg0, dmgObj[1], "Mukirose", undefined, undefined, undefined, true);
                    var vfx = instance_create_depth(arg5.x, arg5.y - (16 * arg5.image_yscale), arg5.depth - 10, obj_vfx);
                    vfx.sprite_index = spr_AkiPunch;
                    vfx.image_speed = 1;
                    vfx.image_xscale = 2;
                    vfx.image_yscale = 2;
                    vfx.image_alpha = 1 * global.attackAlpha;
                    vfx.image_alpha = 0.9;
                    vfx.direction = irandom(360);
                    vfx.image_angle = vfx.direction;
                }
            }
        }
    };
}, function()
{
    playerCharacter.onDebuff.Mukirose = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        if (arg0.scripts.Mukirose.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll < 66)
            {
                var numberOfDebuffs = 0;
                if (instance_exists(arg5))
                {
                    for (var i = 0; i < array_length(arg5.debuffIcons); i++)
                    {
                        if (arg5.debuffIcons[i] > 0)
                        {
                            numberOfDebuffs++;
                        }
                    }
                    arg0.scripts.Mukirose.config.timer = arg0.scripts.Mukirose.config.maxTimer;
                    var dmgObj = obj_AttackController.CalculateDamage(arg5, arg0, 
                    {
                        damage: 0.5 * numberOfDebuffs
                    });
                    arg5.TakeDamage(dmgObj[0], arg0, dmgObj[1], "Mukirose", undefined, undefined, undefined, true);
                    var vfx = instance_create_depth(arg5.x, arg5.y - (16 * arg5.image_yscale), arg5.depth - 10, obj_vfx);
                    vfx.sprite_index = spr_AkiPunch;
                    vfx.image_speed = 1;
                    vfx.image_xscale = 2;
                    vfx.image_yscale = 2;
                    vfx.image_alpha = 0.9;
                    vfx.image_alpha = 1 * global.attackAlpha;
                    vfx.direction = irandom(360);
                    vfx.image_angle = vfx.direction;
                }
            }
        }
    };
}, function()
{
    playerCharacter.onDebuff.Mukirose = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        if (arg0.scripts.Mukirose.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll < 77)
            {
                var numberOfDebuffs = 0;
                if (instance_exists(arg5))
                {
                    for (var i = 0; i < array_length(arg5.debuffIcons); i++)
                    {
                        if (arg5.debuffIcons[i] > 0)
                        {
                            numberOfDebuffs++;
                        }
                    }
                    arg0.scripts.Mukirose.config.timer = arg0.scripts.Mukirose.config.maxTimer;
                    var dmgObj = obj_AttackController.CalculateDamage(arg5, arg0, 
                    {
                        damage: 0.75 * numberOfDebuffs
                    });
                    arg5.TakeDamage(dmgObj[0], arg0, dmgObj[1], "Mukirose", undefined, undefined, undefined, true);
                    var vfx = instance_create_depth(arg5.x, arg5.y - (16 * arg5.image_yscale), arg5.depth - 10, obj_vfx);
                    vfx.sprite_index = spr_AkiPunch;
                    vfx.image_speed = 1;
                    vfx.image_xscale = 2;
                    vfx.image_yscale = 2;
                    vfx.image_alpha = 0.9;
                    vfx.image_alpha = 1 * global.attackAlpha;
                    vfx.direction = irandom(360);
                    vfx.image_angle = vfx.direction;
                }
            }
        }
    };
}];
ds_map_set(PERKS, "Mukirose", new Perk("Mukirose", 
{
    optionName: global.TextContainer.MukiroseName.selectedLanguage,
    optionIcon: 1635,
    optionDescription: global.TextContainer.MukiroseDescription.selectedLanguage[0]
}, MukiroseOnApply));
var OozoraPoliceOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "OozoraPolice"))
    {
        playerCharacter.scripts.OozoraPolice = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer == 0)
                {
                    var buffConfig = 
                    {
                        reapply: true,
                        stacks: 1,
                        maxStacks: arg1.maxStacks,
                        buffIcon: 508
                    };
                    obj_AttackController.ApplyBuff(arg0, "OozoraPolice", ds_map_find_value(obj_AttackController.Buffs, "OozoraPolice"), buffConfig);
                    obj_AttackController.ApplyBuff(arg0, "OozoraPolice", ds_map_find_value(obj_AttackController.Buffs, "OozoraPolice"), buffConfig);
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 900,
                maxStacks: 4
            }
        };
        
        playerCharacter.onTakeDamage.OozoraPolice = function(arg0, arg1, arg2, arg3)
        {
            if (variable_struct_exists(arg3.buffs, "OozoraPolice"))
            {
                if (arg3.buffs.OozoraPolice.config.stacks > 1)
                {
                    arg3.buffs.OozoraPolice.config.stacks--;
                }
                else
                {
                    obj_AttackController.RemoveBuff(arg3, "OozoraPolice");
                }
                var targets = ds_list_create();
                if (instance_exists(obj_Enemy))
                {
                    var found = collision_circle_list(arg3.x, arg3.y, 40, obj_Enemy, true, true, targets, true);
                }
                if (ds_list_size(targets) > 0)
                {
                    for (var i = 0; i < ds_list_size(targets); i++)
                    {
                        if (ds_list_find_value(targets, i).isEnemy && !variable_instance_exists(ds_list_find_value(targets, i), "attackID") && !ds_list_find_value(targets, i).isBoss && !ds_list_find_value(targets, i).miniboss)
                        {
                            ds_list_find_value(targets, i).Die();
                            soundPlay([249], "arrested", 5, 10);
                            arg0 = -1;
                            if (global.showDamageText && instance_number(obj_damageText) < 100)
                            {
                                var hit = instance_create_depth(ds_list_find_value(targets, i).x, ds_list_find_value(targets, i).y - 40, ds_list_find_value(targets, i).depth - 1, obj_damageText);
                                hit.critted = false;
                                hit.damageValue = "ARRESTED!";
                                hit.hspeed = 0;
                                hit.vspeed = -2;
                            }
                        }
                    }
                }
                ds_list_destroy(targets);
                targets = -1;
            }
            return arg0;
        };
    }
}, function()
{
    playerCharacter.scripts.OozoraPolice.config.maxStacks = 6;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: playerCharacter.scripts.OozoraPolice.config.maxStacks,
        buffIcon: 508
    };
    UpdateBuffIfExists("OozoraPolice", buffConfig);
}, function()
{
    playerCharacter.scripts.OozoraPolice.config.maxStacks = 8;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: playerCharacter.scripts.OozoraPolice.config.maxStacks,
        buffIcon: 508
    };
    UpdateBuffIfExists("OozoraPolice", buffConfig);
}];
ds_map_set(PERKS, "OozoraPolice", new Perk("OozoraPolice", 
{
    optionName: global.TextContainer.OozoraPoliceName.selectedLanguage,
    optionIcon: 508,
    optionDescription: global.TextContainer.OozoraPoliceDescription.selectedLanguage[0]
}, OozoraPoliceOnApply));
var DuckASMROnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "DuckASMR"))
    {
        playerCharacter.scripts.DuckASMR = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer <= 0)
                {
                    obj_AttackController.ExecuteAttack("DuckASMR", arg0, 
                    {
                        x: arg0.x,
                        y: arg0.y,
                        damage: arg1.damage
                    });
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 600,
                damage: 1
            }
        };
    }
}, function()
{
    playerCharacter.scripts.DuckASMR.config.damage = 1.5;
}, function()
{
    playerCharacter.scripts.DuckASMR.config.damage = 2;
}];
ds_map_set(PERKS, "DuckASMR", new Perk("DuckASMR", 
{
    optionName: global.TextContainer.DuckASMRName.selectedLanguage,
    optionIcon: 1370,
    optionDescription: global.TextContainer.DuckASMRDescription.selectedLanguage[0]
}, DuckASMROnApply));
var RelentlessOptimismOnApply = [function()
{
    playerCharacter.haste += 5;
    if (!variable_struct_exists(playerCharacter.scripts, "RelentlessOptimism"))
    {
        playerCharacter.scripts.RelentlessOptimism = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 600
            }
        };
    }
    
    playerCharacter.onTakeDamage.RelentlessOptimism = function(arg0, arg1, arg2, arg3)
    {
        if (!arg3.invincible && arg0 > 0)
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10
            };
            var roll = irandom(99);
            if (roll < 20 && variable_struct_exists(arg3.scripts, "RelentlessOptimism") && arg3.scripts.RelentlessOptimism.config.timer == 0)
            {
                obj_AttackController.ApplyBuff(arg3, "RelentlessOptimism", ds_map_find_value(obj_AttackController.Buffs, "RelentlessOptimism"), buffConfig);
            }
        }
        return arg0;
    };
    
    playerCharacter.onDeath.RelentlessOptimism = function(arg0, arg1, arg2)
    {
        if (variable_struct_exists(arg0.buffs, "RelentlessOptimism"))
        {
            if (variable_struct_exists(arg0.scripts, "RelentlessOptimism"))
            {
                arg0.scripts.RelentlessOptimism.config.timer = arg0.scripts.RelentlessOptimism.config.maxTimer;
            }
            soundPlay([203], "revive", 10, 20);
            arg0.currentHP = 1;
            hpSus = arg0.currentHP - 1;
            Heal(arg0, arg0.buffs.RelentlessOptimism.config.stacks * (arg0.HP * 0.02), 0, true, false, false);
            arg0.invincibilityTimer = arg0.buffs.RelentlessOptimism.config.stacks * 30;
            arg0.invincible = true;
            arg0.stopDeath = true;
            var buffConfig = ds_map_find_value(obj_AttackController.Buffs, "RelentlessOptimism2");
            buffConfig.timer = arg0.buffs.RelentlessOptimism.config.stacks * 30;
            obj_AttackController.ApplyBuff(arg0, "RelentlessOptimism2", buffConfig, 
            {
                buffIcon: 1919
            });
            obj_AttackController.RemoveBuff(arg0, "RelentlessOptimism");
        }
    };
}, function()
{
    playerCharacter.haste += 10;
    
    playerCharacter.onTakeDamage.RelentlessOptimism = function(arg0, arg1, arg2, arg3)
    {
        if (!arg3.invincible)
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10
            };
            var roll = irandom(99);
            if (roll < 30 && variable_struct_exists(arg3.scripts, "RelentlessOptimism") && arg3.scripts.RelentlessOptimism.config.timer == 0)
            {
                obj_AttackController.ApplyBuff(arg3, "RelentlessOptimism", ds_map_find_value(obj_AttackController.Buffs, "RelentlessOptimism"), buffConfig);
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.haste += 15;
    
    playerCharacter.onTakeDamage.RelentlessOptimism = function(arg0, arg1, arg2, arg3)
    {
        if (!arg3.invincible)
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10
            };
            var roll = irandom(99);
            if (roll < 40 && variable_struct_exists(arg3.scripts, "RelentlessOptimism") && arg3.scripts.RelentlessOptimism.config.timer == 0)
            {
                obj_AttackController.ApplyBuff(arg3, "RelentlessOptimism", ds_map_find_value(obj_AttackController.Buffs, "RelentlessOptimism"), buffConfig);
            }
        }
        return arg0;
    };
}];
ds_map_set(PERKS, "RelentlessOptimism", new Perk("RelentlessOptimism", 
{
    optionName: global.TextContainer.RelentlessOptimismName.selectedLanguage,
    optionIcon: 1919,
    optionDescription: global.TextContainer.RelentlessOptimismDescription.selectedLanguage[0]
}, RelentlessOptimismOnApply));
var DemonWhisperOnApply = [function()
{
    playerCharacter.onCriticalHit.DemonWhisper = function(arg0, arg1, arg2, arg3)
    {
        if (arg0.scripts.DemonWhisper.config.converted < arg0.scripts.DemonWhisper.config.maxConverts)
        {
            var roll = irandom(99);
            if (roll < arg0.scripts.DemonWhisper.config.chance)
            {
                if (!arg2.isBoss && !arg2.miniboss)
                {
                    if (!variable_struct_exists(arg2.buffs, "DemonWhisper") && variable_struct_exists(arg2, "behaviours") && variable_struct_exists(arg2.behaviours, "followPlayer"))
                    {
                        soundPlay([151], "nurse", 15, 30);
                        obj_AttackController.ApplyBuff(arg2, "DemonWhisper", ds_map_find_value(obj_AttackController.Buffs, "DemonWhisper"), 
                        {
                            nonSkill: false
                        });
                        arg3 = -1;
                    }
                }
            }
        }
        return arg3;
    };
    
    playerCharacter.scripts.DemonWhisper = 
    {
        Script: function(arg0, arg1)
        {
        },
        
        config: 
        {
            converted: 0,
            maxConverts: 5,
            chance: 20
        }
    };
}, function()
{
    playerCharacter.scripts.DemonWhisper.config.chance = 27;
    playerCharacter.scripts.DemonWhisper.config.maxConverts = 10;
}, function()
{
    playerCharacter.scripts.DemonWhisper.config.chance = 33;
    playerCharacter.scripts.DemonWhisper.config.maxConverts = 15;
}];
ds_map_set(PERKS, "DemonWhisper", new Perk("DemonWhisper", 
{
    optionName: global.TextContainer.DemonWhisperName.selectedLanguage,
    optionIcon: 1665,
    optionDescription: global.TextContainer.DemonWhisperDescription.selectedLanguage[0]
}, DemonWhisperOnApply));
var DeliciousCookingOnApply = [function()
{
    playerCharacter.onKill.DeliciousCooking = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 20)
        {
            instance_create_depth(arg1.x, arg1.y - 16, arg1.depth, obj_Supplies);
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10,
                buffIcon: 1883
            };
            obj_AttackController.ApplyBuff(arg0, "DeliciousCookingSupplies", ds_map_find_value(obj_AttackController.Buffs, "DeliciousCookingSupplies"), buffConfig);
        }
        exit;
    };
    
    playerCharacter.scripts.DeliciousCooking = 
    {
        Script: function(arg0, arg1)
        {
            if (variable_struct_exists(arg0.buffs, "DeliciousCookingSupplies"))
            {
                if (arg0.buffs.DeliciousCookingSupplies.config.stacks >= 10)
                {
                    var buffConfig = 
                    {
                        reapply: true,
                        stacks: 1,
                        maxStacks: 10,
                        weight: arg1.weight,
                        loseStackOnRemove: true
                    };
                    Heal(arg0, arg0.HP * 0.1, 0, true, true, false);
                    obj_AttackController.ApplyBuff(arg0, "DeliciousCooking", ds_map_find_value(obj_AttackController.Buffs, "DeliciousCooking"), buffConfig);
                    obj_AttackController.RemoveBuff(arg0, "DeliciousCookingSupplies");
                }
            }
        },
        
        config: 
        {
            weight: 0.1
        }
    };
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 3,
        weight: 0.1,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("DeliciousCooking", buffConfig);
}, function()
{
    playerCharacter.onKill.DeliciousCooking = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 30)
        {
            instance_create_depth(arg1.x, arg1.y - 16, arg1.depth, obj_Supplies);
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10,
                buffIcon: 1883
            };
            obj_AttackController.ApplyBuff(arg0, "DeliciousCookingSupplies", ds_map_find_value(obj_AttackController.Buffs, "DeliciousCookingSupplies"), buffConfig);
        }
        exit;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 3,
        weight: 0.15,
        loseStackOnRemove: true
    };
    playerCharacter.scripts.DeliciousCooking.config.weight = 0.15;
    UpdateBuffIfExists("DeliciousCooking", buffConfig);
}, function()
{
    playerCharacter.onKill.DeliciousCooking = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 40)
        {
            instance_create_depth(arg1.x, arg1.y - 16, arg1.depth, obj_Supplies);
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 10,
                buffIcon: 1883
            };
            obj_AttackController.ApplyBuff(arg0, "DeliciousCookingSupplies", ds_map_find_value(obj_AttackController.Buffs, "DeliciousCookingSupplies"), buffConfig);
        }
        exit;
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 3,
        weight: 0.2,
        loseStackOnRemove: true
    };
    playerCharacter.scripts.DeliciousCooking.config.weight = 0.2;
    UpdateBuffIfExists("DeliciousCooking", buffConfig);
}];
ds_map_set(PERKS, "DeliciousCooking", new Perk("DeliciousCooking", 
{
    optionName: global.TextContainer.DeliciousCookingName.selectedLanguage,
    optionIcon: 1230,
    optionDescription: global.TextContainer.DeliciousCookingDescription.selectedLanguage[0]
}, DeliciousCookingOnApply));
var NurseOnApply = [function()
{
    playerCharacter.canCritHeal = true;
    
    playerCharacter.onCritHeal.Nurse = function(arg0, arg1, arg2)
    {
        if (variable_struct_exists(arg1.scripts, "Nurse") && arg1.scripts.Nurse.config.timer != 0)
        {
            return arg0;
        }
        var targets = ds_list_create();
        arg1.scripts.Nurse.config.timer = arg1.scripts.Nurse.config.maxTimer;
        arg0 *= 1.5;
        var statEffect = instance_create_depth(arg1.x, arg1.y - 8, arg1.depth - 1, obj_statEffect);
        statEffect.sprite_index = spr_ChocoPerk3;
        if (instance_exists(obj_Enemy))
        {
            var found = collision_circle_list(arg1.x, arg1.y, 200, obj_Enemy, true, true, targets, true);
        }
        if (ds_list_size(targets) > 0)
        {
            var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, 0), arg1, 
            {
                damage: 2,
                sureCrit: true
            });
            for (var i = 0; i < 3; i++)
            {
                var vfx = instance_create_depth(ds_list_find_value(targets, 0).x, ds_list_find_value(targets, 0).y, ds_list_find_value(targets, 0).depth - 10, obj_vfx);
                vfx.sprite_index = spr_HaatoRedHeart;
                vfx.image_speed = 0;
                vfx.image_xscale = 0.8;
                vfx.image_yscale = 0.8;
                vfx.image_alpha = 0.9;
                vfx.duration = 30;
                vfx.fadeSpeed = 0.02;
                vfx.alarm[1] = 1;
                vfx.alarm[2] = 1;
                vfx.facing = -1 + (irandom(1) * 2);
                vfx.rotSpeed = vfx.facing * random(2);
                vfx.hspeed = vfx.facing * (0.5 + random(2.5));
                vfx.vspeed = -2 - irandom(2);
                vfx.gravity = 0.2;
            }
            soundPlay([153], "nurse", 15, 30);
            for (var i = 0; i < ds_list_size(targets); i++)
            {
                if (ds_list_size(targets) > i && instance_exists(ds_list_find_value(targets, i)) && ds_list_find_value(targets, i).isEnemy)
                {
                    ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg1, true, "Nurse", undefined, undefined, undefined, true);
                }
            }
        }
        ds_list_destroy(targets);
        targets = -1;
        return arg0;
    };
    
    playerCharacter.scripts.Nurse = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 15
        }
    };
}, function()
{
    playerCharacter.canCritHeal = true;
    
    playerCharacter.onCritHeal.Nurse = function(arg0, arg1, arg2)
    {
        if (variable_struct_exists(arg1.scripts, "Nurse") && arg1.scripts.Nurse.config.timer != 0)
        {
            return arg0;
        }
        arg0 *= 1.75;
        arg1.scripts.Nurse.config.timer = arg1.scripts.Nurse.config.maxTimer;
        var statEffect = instance_create_depth(arg1.x, arg1.y - 8, arg1.depth - 1, obj_statEffect);
        statEffect.sprite_index = spr_ChocoPerk3;
        var targets = ds_list_create();
        if (instance_exists(obj_Enemy))
        {
            collision_circle_list(arg1.x, arg1.y, 200, obj_Enemy, true, true, targets, true);
        }
        if (ds_list_size(targets) > 0)
        {
            var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, 0), arg1, 
            {
                damage: 3,
                sureCrit: true
            });
            for (var i = 0; i < 3; i++)
            {
                var vfx = instance_create_depth(ds_list_find_value(targets, 0).x, ds_list_find_value(targets, 0).y, ds_list_find_value(targets, 0).depth - 10, obj_vfx);
                vfx.sprite_index = spr_HaatoRedHeart;
                vfx.image_speed = 0;
                vfx.image_xscale = 0.8;
                vfx.image_yscale = 0.8;
                vfx.image_alpha = 0.9;
                vfx.duration = 30;
                vfx.fadeSpeed = 0.02;
                vfx.alarm[1] = 1;
                vfx.alarm[2] = 1;
                vfx.facing = -1 + (irandom(1) * 2);
                vfx.rotSpeed = vfx.facing * random(2);
                vfx.hspeed = vfx.facing * (0.5 + random(2.5));
                vfx.vspeed = -2 - irandom(2);
                vfx.gravity = 0.2;
            }
            soundPlay([153], "nurse", 15, 30);
            for (var i = 0; i < ds_list_size(targets); i++)
            {
                if (ds_list_size(targets) > i && instance_exists(ds_list_find_value(targets, i)) && ds_list_find_value(targets, i).isEnemy)
                {
                    ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg1, true, "Nurse", undefined, undefined, undefined, true);
                }
            }
        }
        ds_list_destroy(targets);
        targets = -1;
        return arg0;
    };
}, function()
{
    playerCharacter.canCritHeal = true;
    
    playerCharacter.onCritHeal.Nurse = function(arg0, arg1, arg2)
    {
        if (variable_struct_exists(arg1.scripts, "Nurse") && arg1.scripts.Nurse.config.timer != 0)
        {
            return arg0;
        }
        arg0 *= 2;
        arg1.scripts.Nurse.config.timer = arg1.scripts.Nurse.config.maxTimer;
        var statEffect = instance_create_depth(arg1.x, arg1.y - 8, arg1.depth - 1, obj_statEffect);
        statEffect.sprite_index = spr_ChocoPerk3;
        var targets = ds_list_create();
        if (instance_exists(obj_Enemy))
        {
            collision_circle_list(arg1.x, arg1.y, 200, obj_Enemy, true, true, targets, true);
        }
        if (ds_list_size(targets) > 0)
        {
            var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, 0), arg1, 
            {
                damage: 4,
                sureCrit: true
            });
            for (var i = 0; i < 3; i++)
            {
                var vfx = instance_create_depth(ds_list_find_value(targets, 0).x, ds_list_find_value(targets, 0).y, ds_list_find_value(targets, 0).depth - 10, obj_vfx);
                vfx.sprite_index = spr_HaatoRedHeart;
                vfx.image_speed = 0;
                vfx.image_xscale = 0.8;
                vfx.image_yscale = 0.8;
                vfx.image_alpha = 0.9;
                vfx.duration = 30;
                vfx.fadeSpeed = 0.02;
                vfx.alarm[1] = 1;
                vfx.alarm[2] = 1;
                vfx.facing = -1 + (irandom(1) * 2);
                vfx.rotSpeed = vfx.facing * random(2);
                vfx.hspeed = vfx.facing * (0.5 + random(2.5));
                vfx.vspeed = -2 - irandom(2);
                vfx.gravity = 0.2;
            }
            soundPlay([153], "nurse", 15, 30);
            for (var i = 0; i < ds_list_size(targets); i++)
            {
                if (ds_list_size(targets) > i && instance_exists(ds_list_find_value(targets, i)) && ds_list_find_value(targets, i).isEnemy)
                {
                    ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg1, true, "Nurse", undefined, undefined, undefined, true);
                }
            }
        }
        ds_list_destroy(targets);
        targets = -1;
        return arg0;
    };
}];
ds_map_set(PERKS, "Nurse", new Perk("Nurse", 
{
    optionName: global.TextContainer.NurseName.selectedLanguage,
    optionIcon: 1213,
    optionDescription: global.TextContainer.NurseDescription.selectedLanguage[0]
}, NurseOnApply));
var GarlicOnApply = [function()
{
    if (!instance_exists(obj_Summon))
    {
        obj_PlayerManager.playerSummon = obj_MobManager.CreateSummon("Garlic");
    }
    playerCharacter.scripts.Garlic = 
    {
        Script: function(arg0, arg1)
        {
            var timer, specialMeter;
            if (instance_exists(obj_Summon) && obj_Summon.summonName == "Garlic")
            {
                if (point_distance(arg0.x, arg0.y, obj_Summon.x, obj_Summon.y) < arg1.radius)
                {
                    arg1.timer--;
                    if (arg1.timer <= 0)
                    {
                        arg0.specialMeter++;
                        arg1.timer = arg1.maxTimer;
                    }
                }
            }
        },
        
        config: 
        {
            radius: 60,
            timer: 90,
            maxTimer: 90,
            dodgeChance: 30
        }
    };
    
    playerCharacter.onTakeDamage.Garlic = function(arg0, arg1, arg2, arg3)
    {
        if (instance_exists(obj_Summon) && obj_Summon.summonName == "Garlic" && point_distance(arg3.x, arg3.y, obj_Summon.x, obj_Summon.y) < (arg3.scripts.Garlic.config.radius / 2))
        {
            var roll = irandom(99);
            if (roll <= arg3.scripts.Garlic.config.dodgeChance)
            {
                arg0 = 0;
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.scripts.Garlic.config.radius = 110;
    playerCharacter.scripts.Garlic.config.dodgeChance = 35;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "GarlicPulse").config.damage = 1.25;
    obj_PlayerManager.playerSummon.SetStats(
    {
        SPD: 1
    });
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "GarlicPulse").config.image_xscale = 1.8;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "GarlicPulse").config.image_yscale = 1.8;
}, function()
{
    playerCharacter.scripts.Garlic.config.radius = 160;
    playerCharacter.scripts.Garlic.config.dodgeChance = 40;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "GarlicPulse").config.damage = 1.5;
    obj_PlayerManager.playerSummon.SetStats(
    {
        SPD: 1
    });
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "GarlicPulse").config.image_xscale = 2.6;
    ds_map_find_value(obj_PlayerManager.playerSummon.attacks, "GarlicPulse").config.image_yscale = 2.6;
}];
ds_map_set(PERKS, "Garlic", new Perk("Garlic", 
{
    optionName: global.TextContainer.GarlicName.selectedLanguage,
    optionIcon: 707,
    optionDescription: global.TextContainer.GarlicDescription.selectedLanguage[0]
}, GarlicOnApply));
var CheekyBratOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "CheekyBrat"))
    {
        playerCharacter.scripts.CheekyBrat = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = arg1.maxTimer;
                    obj_AttackController.ApplyBuff(arg0, "CheekyDodge", ds_map_find_value(obj_AttackController.Buffs, "CheekyDodge"), 
                    {
                        buffIcon: 1670
                    });
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 900
            }
        };
    }
    
    playerCharacter.onTakeDamage.CheekyBrat = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (variable_struct_exists(arg3.buffs, "CheekyDodge"))
        {
            obj_AttackController.RemoveBuff(arg3, "CheekyDodge");
            arg0 = 0;
        }
        return arg0;
    };
    
    playerCharacter.onDodge.CheekyBrat = function(arg0, arg1, arg2, arg3)
    {
        var buffConfig = 
        {
            reapply: true,
            amount: 0.3,
            buffIcon: 978
        };
        soundPlay([233], "dodge", 30, 20);
        obj_AttackController.ApplyBuff(arg3, "CheekyBrat", ds_map_find_value(obj_AttackController.Buffs, "CheekyBrat"), buffConfig);
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        amount: 0.3,
        buffIcon: 978
    };
    UpdateBuffIfExists("CheekyBrat", buffConfig);
}, function()
{
    playerCharacter.onDodge.CheekyBrat = function(arg0, arg1, arg2, arg3)
    {
        var buffConfig = 
        {
            reapply: true,
            amount: 0.45,
            buffIcon: 978
        };
        soundPlay([233], "dodge", 30, 20);
        obj_AttackController.ApplyBuff(arg3, "CheekyBrat", ds_map_find_value(obj_AttackController.Buffs, "CheekyBrat"), buffConfig);
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        amount: 0.45,
        buffIcon: 978
    };
    UpdateBuffIfExists("CheekyBrat", buffConfig);
}, function()
{
    playerCharacter.onDodge.CheekyBrat = function(arg0, arg1, arg2, arg3)
    {
        var buffConfig = 
        {
            reapply: true,
            amount: 0.6,
            buffIcon: 978
        };
        soundPlay([233], "dodge", 30, 20);
        obj_AttackController.ApplyBuff(arg3, "CheekyBrat", ds_map_find_value(obj_AttackController.Buffs, "CheekyBrat"), buffConfig);
        return arg0;
    };
    
    var buffConfig = 
    {
        reapply: true,
        amount: 0.6,
        buffIcon: 978
    };
    UpdateBuffIfExists("CheekyBrat", buffConfig);
}];
ds_map_set(PERKS, "CheekyBrat", new Perk("CheekyBrat", 
{
    optionName: global.TextContainer.CheekyBratName.selectedLanguage,
    optionIcon: 1670,
    optionDescription: global.TextContainer.CheekyBratDescription.selectedLanguage[0]
}, CheekyBratOnApply));
var BlackMagicOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "BlackMagic"))
    {
        playerCharacter.scripts.BlackMagic = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer == 0)
                {
                    if (arg1.portal1 == -1)
                    {
                        arg1.portal1 = instance_create_depth(arg0.x, arg0.y, arg0.depth + 1, obj_ShionPortal);
                        arg1.portal1.creator = arg0;
                        arg1.portal1.damage = arg1.damage;
                        arg1.timer = arg1.maxTimer;
                    }
                    else if (arg1.portal2 == -1)
                    {
                        arg1.portal2 = instance_create_depth(arg0.x, arg0.y, arg0.depth + 1, obj_ShionPortal);
                        arg1.portal2.creator = arg0;
                        arg1.portal2.damage = arg1.damage;
                        arg1.portal1.otherPortal = arg1.portal2;
                        arg1.portal2.otherPortal = arg1.portal1;
                        arg1.timer = arg1.maxTimer;
                    }
                    else
                    {
                        var temp = arg1.portal1;
                        temp.canTeleport = false;
                        temp.alarm[0] = 60;
                        arg1.portal1.damage = arg1.damage;
                        arg1.portal1 = arg1.portal2;
                        arg1.portal2.damage = arg1.damage;
                        arg1.portal2 = temp;
                        arg1.portal2.x = arg0.x;
                        arg1.portal2.y = arg0.y;
                        arg1.timer = arg1.maxTimer;
                    }
                    obj_AttackController.ApplyBuff(arg0, "BlackMagic", ds_map_find_value(obj_AttackController.Buffs, "BlackMagic"));
                }
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 480,
                portal1: -1,
                portal2: -1,
                damage: 2
            }
        };
    }
}, function()
{
    playerCharacter.scripts.BlackMagic.config.damage = 3;
    if (playerCharacter.scripts.BlackMagic.config.portal1 > 0)
    {
        playerCharacter.scripts.BlackMagic.config.portal1.damage = 1.5;
    }
    if (playerCharacter.scripts.BlackMagic.config.portal2 > 0)
    {
        playerCharacter.scripts.BlackMagic.config.portal2.damage = 1.5;
    }
}, function()
{
    playerCharacter.scripts.BlackMagic.config.damage = 4;
    if (playerCharacter.scripts.BlackMagic.config.portal1 > 0)
    {
        playerCharacter.scripts.BlackMagic.config.portal1.damage = 2;
    }
    if (playerCharacter.scripts.BlackMagic.config.portal2 > 0)
    {
        playerCharacter.scripts.BlackMagic.config.portal2.damage = 2;
    }
}];
ds_map_set(PERKS, "BlackMagic", new Perk("BlackMagic", 
{
    optionName: global.TextContainer.BlackMagicName.selectedLanguage,
    optionIcon: 1929,
    optionDescription: global.TextContainer.BlackMagicDescription.selectedLanguage[0]
}, BlackMagicOnApply));
var AyameDefenseFieldOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "AyameDefenseField"))
    {
        playerCharacter.scripts.AyameDefenseField = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 600,
                hits: 0,
                maxHits: 6,
                invinTime: 120
            }
        };
    }
    
    playerCharacter.onTakeDamage.AyameDefenseField = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.scripts.AyameDefenseField.config.timer == 0)
        {
            if (arg3.scripts.AyameDefenseField.config.hits < arg3.scripts.AyameDefenseField.config.maxHits)
            {
                arg3.scripts.AyameDefenseField.config.hits++;
            }
            else
            {
                arg3.scripts.AyameDefenseField.config.hits = 0;
                arg3.invincible = true;
                arg3.invincibilityTimer = max(arg3.invincibilityTimer, arg3.scripts.AyameDefenseField.config.invinTime);
                var buffConfig = ds_map_find_value(obj_AttackController.Buffs, "AyameDefenseField");
                buffConfig.timer = arg3.scripts.AyameDefenseField.config.invinTime;
                obj_AttackController.ApplyBuff(arg3, "AyameDefenseField", buffConfig);
                soundPlay([267], "ayamdefensefield", 15, 15);
                
                arg3.customDrawScriptAbove.AyameDefenseField = function(arg0)
                {
                    var FXimage_index;
                    gpu_set_blendmode(bm_add);
                    arg0.FXimage_index++;
                    draw_sprite_ext(spr_AyameADF, arg0.FXimage_index / 2, arg0.x, arg0.y - 16, 1, 1, 0, c_white, 0.5);
                    gpu_set_blendmode(bm_normal);
                };
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.scripts.AyameDefenseField.config.invinTime = 180;
    playerCharacter.scripts.AyameDefenseField.config.maxHits = 5;
}, function()
{
    playerCharacter.scripts.AyameDefenseField.config.invinTime = 240;
    playerCharacter.scripts.AyameDefenseField.config.maxHits = 4;
}];
ds_map_set(PERKS, "AyameDefenseField", new Perk("AyameDefenseField", 
{
    optionName: global.TextContainer.AyameDefenseFieldName.selectedLanguage,
    optionIcon: 2135,
    optionDescription: global.TextContainer.AyameDefenseFieldDescription.selectedLanguage[0]
}, AyameDefenseFieldOnApply));

function NakiriumStepBuffApply(arg0, arg1)
{
    var enemies = ds_list_create();
    var amountOfEnemies = 0;
    var amountInView = 0;
    if (instance_exists(obj_Enemy))
    {
        amountOfEnemies = collision_circle_list(arg0.x, arg0.y, 150, obj_Enemy, true, true, enemies, false);
        for (var i = 0; i < amountOfEnemies; i++)
        {
            if (point_distance(arg0.x, arg0.y, ds_list_find_value(enemies, i).x, ds_list_find_value(enemies, i).y) < arg0.stepBuffs.Nakirium.config.distance)
            {
                amountInView++;
            }
        }
    }
    ds_list_destroy(enemies);
    enemies = -1;
    if (amountInView > arg1.maxAmount)
    {
        amountInView = arg1.maxAmount;
    }
    arg0.SPD += arg1.amount * amountInView;
}

var NakiriumOnApply = [function()
{
    playerCharacter.customDrawScriptAbove.Nakirium = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.stepBuffs.Nakirium.config.circleTime += 0.5;
            if (arg0.stepBuffs.Nakirium.config.circleTime >= (arg0.stepBuffs.Nakirium.config.distance / 1.5))
            {
                arg0.stepBuffs.Nakirium.config.circleTime = 0;
            }
            draw_set_color(c_red);
            draw_circle(arg0.x, arg0.y - 16, arg0.stepBuffs.Nakirium.config.distance, true);
        }
    };
    
    playerCharacter.stepBuffs.Nakirium = 
    {
        Apply: NakiriumStepBuffApply,
        config: 
        {
            amount: 0.02,
            maxAmount: 20,
            distance: 120,
            circleTime: 0
        }
    };
    
    playerCharacter.onKill.Nakirium = function(arg0, arg1, arg2)
    {
        if (point_distance(arg1.x, arg1.y, arg0.x, arg0.y) < arg0.stepBuffs.Nakirium.config.distance)
        {
            arg1.expvalue *= 1.1;
        }
    };
}, function()
{
    playerCharacter.stepBuffs.Nakirium = 
    {
        Apply: NakiriumStepBuffApply,
        config: 
        {
            amount: 0.03,
            maxAmount: 20,
            distance: 120,
            circleTime: 0
        }
    };
    
    playerCharacter.onKill.Nakirium = function(arg0, arg1, arg2)
    {
        if (point_distance(arg1.x, arg1.y, arg0.x, arg0.y) < arg0.stepBuffs.Nakirium.config.distance)
        {
            arg1.expvalue *= 1.15;
        }
    };
}, function()
{
    playerCharacter.stepBuffs.Nakirium = 
    {
        Apply: NakiriumStepBuffApply,
        config: 
        {
            amount: 0.04,
            maxAmount: 20,
            distance: 120,
            circleTime: 0
        }
    };
    
    playerCharacter.onKill.Nakirium = function(arg0, arg1, arg2)
    {
        if (point_distance(arg1.x, arg1.y, arg0.x, arg0.y) < arg0.stepBuffs.Nakirium.config.distance)
        {
            arg1.expvalue *= 1.2;
        }
    };
}];
ds_map_set(PERKS, "Nakirium", new Perk("Nakirium", 
{
    optionName: global.TextContainer.NakiriumName.selectedLanguage,
    optionIcon: 1604,
    optionDescription: global.TextContainer.NakiriumDescription.selectedLanguage[0]
}, NakiriumOnApply));
var OniLadyOnApply = [function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "OniSlash").config.onHitEffects.OniLady = {};
    
    playerCharacter.onKill.OniLady = function(arg0, arg1, arg2)
    {
        if (variable_instance_exists(arg1, "OniSlashHit") && arg1.OniSlashHit)
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 20,
                weight: 1,
                loseStackOnRemove: true
            };
            obj_AttackController.ApplyBuff(arg0, "OniLady", ds_map_find_value(obj_AttackController.Buffs, "OniLady"), buffConfig);
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: 1,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("OniLady", buffConfig);
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "OniSlash").config.onHitEffects.OniLady = {};
    
    playerCharacter.onKill.OniLady = function(arg0, arg1, arg2)
    {
        if (variable_instance_exists(arg1, "OniSlashHit") && arg1.OniSlashHit)
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 30,
                weight: 1,
                loseStackOnRemove: true
            };
            obj_AttackController.ApplyBuff(arg0, "OniLady", ds_map_find_value(obj_AttackController.Buffs, "OniLady"), buffConfig);
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 30,
        weight: 1,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("OniLady", buffConfig);
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "OniSlash").config.onHitEffects.OniLady = {};
    
    playerCharacter.onKill.OniLady = function(arg0, arg1, arg2)
    {
        if (variable_instance_exists(arg1, "OniSlashHit") && arg1.OniSlashHit)
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 40,
                weight: 1,
                loseStackOnRemove: true
            };
            obj_AttackController.ApplyBuff(arg0, "OniLady", ds_map_find_value(obj_AttackController.Buffs, "OniLady"), buffConfig);
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 40,
        weight: 1,
        loseStackOnRemove: true
    };
    UpdateBuffIfExists("OniLady", buffConfig);
}];
ds_map_set(PERKS, "OniLady", new Perk("OniLady", 
{
    optionName: global.TextContainer.OniLadyName.selectedLanguage,
    optionIcon: 2383,
    optionDescription: global.TextContainer.OniLadyDescription.selectedLanguage[0]
}, OniLadyOnApply));
var AquaMaidOnApply = [function()
{
    playerCharacter.pickupRange += 20;
    variable_struct_set(playerCharacter.onHitEffects, "CleanUpMaid", 
    {
        critDamage: 1.1
    });
}, function()
{
    playerCharacter.pickupRange += 40;
    variable_struct_set(playerCharacter.onHitEffects, "CleanUpMaid", 
    {
        critDamage: 1.2
    });
}, function()
{
    playerCharacter.pickupRange += 60;
    variable_struct_set(playerCharacter.onHitEffects, "CleanUpMaid", 
    {
        critDamage: 1.3
    });
}];
ds_map_set(PERKS, "AquaMaid", new Perk("AquaMaid", 
{
    optionName: global.TextContainer.AquaMaidName.selectedLanguage,
    optionIcon: 729,
    optionDescription: global.TextContainer.AquaMaidDescription.selectedLanguage[0]
}, AquaMaidOnApply));

function SololiveStepBuffApply(arg0, arg1)
{
    var enemies = ds_list_create();
    var amountOfEnemies = 0;
    var amountInView = 0;
    if (instance_exists(obj_Enemy))
    {
        amountOfEnemies = collision_circle_list(arg0.x, arg0.y, 75, obj_Enemy, true, true, enemies, false);
        if (amountOfEnemies > 0)
        {
            arg0.SPD += arg1.amount;
        }
        else
        {
            arg0.ATK += arg1.amount;
        }
    }
    ds_list_destroy(enemies);
    enemies = -1;
}

var SololiveOnApply = [function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 10;
        playerCharacter.UpdateHP();
    }
    
    playerCharacter.customDrawScriptAbove.Sololive = function(arg0)
    {
        if (global.showSkillRadius)
        {
            arg0.stepBuffs.Sololive.config.circleTime += 0.5;
            if (arg0.stepBuffs.Sololive.config.circleTime >= (arg0.stepBuffs.Sololive.config.distance / 1.5))
            {
                arg0.stepBuffs.Sololive.config.circleTime = 0;
            }
            draw_set_color(c_aqua);
            draw_circle(arg0.x, arg0.y - 16, arg0.stepBuffs.Sololive.config.distance, true);
        }
    };
    
    playerCharacter.stepBuffs.Sololive = 
    {
        Apply: SololiveStepBuffApply,
        config: 
        {
            amount: 0.4,
            distance: 75,
            circleTime: 0
        }
    };
}, function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 15;
        playerCharacter.UpdateHP();
    }
    playerCharacter.stepBuffs.Sololive = 
    {
        Apply: SololiveStepBuffApply,
        config: 
        {
            amount: 0.5,
            distance: 75,
            circleTime: 0
        }
    };
}, function()
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        playerCharacter.HP += 20;
        playerCharacter.UpdateHP();
    }
    playerCharacter.stepBuffs.Sololive = 
    {
        Apply: SololiveStepBuffApply,
        config: 
        {
            amount: 0.6,
            distance: 75,
            circleTime: 0
        }
    };
}];
ds_map_set(PERKS, "Sololive", new Perk("Sololive", 
{
    optionName: global.TextContainer.SololiveName.selectedLanguage,
    optionIcon: 173,
    optionDescription: global.TextContainer.SololiveDescription.selectedLanguage[0]
}, SololiveOnApply));
var KlutzOnApply = [function()
{
    playerCharacter.bonusProjectiles++;
    variable_struct_set(playerCharacter.onHitEffects, "Klutz", 
    {
        chance: 30
    });
}, function()
{
    playerCharacter.bonusProjectiles++;
    variable_struct_set(playerCharacter.onHitEffects, "Klutz", 
    {
        chance: 20
    });
}, function()
{
    playerCharacter.bonusProjectiles++;
    variable_struct_set(playerCharacter.onHitEffects, "Klutz", 
    {
        chance: 10
    });
}];
ds_map_set(PERKS, "Klutz", new Perk("Klutz", 
{
    optionName: global.TextContainer.KlutzName.selectedLanguage,
    optionIcon: 1587,
    optionDescription: global.TextContainer.KlutzDescription.selectedLanguage[0]
}, KlutzOnApply));
var LunarConstructionOnApply = [function()
{
    playerCharacter.onKill.LunarConstruction = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(99);
        if (rollChance < 20)
        {
            var supplies = instance_create_depth(arg1.x, arg1.y - 16, arg1.depth, obj_Supplies);
            supplies.sprite_index = spr_MoonaConstructionBlock;
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: global.SkillData.LunarConstruction.blocks,
                buffIcon: 910
            };
            obj_AttackController.ApplyBuff(arg0, "LunarConstruction", ds_map_find_value(obj_AttackController.Buffs, "LunarConstruction"), buffConfig);
        }
        exit;
    };
    
    playerCharacter.scripts.LunarConstruction = 
    {
        Script: function(arg0, arg1)
        {
            if (variable_struct_exists(arg0.buffs, "LunarConstruction"))
            {
                if (arg0.buffs.LunarConstruction.config.stacks >= global.SkillData.LunarConstruction.blocks)
                {
                    obj_AttackController.RemoveBuff(arg0, "LunarConstruction");
                    var lunarRabbit = instance_create_depth(arg0.x, arg0.y - 16, arg0.depth, obj_LunarRabbit);
                    lunarRabbit.creator = arg0;
                    lunarRabbit.damage = arg1.damage;
                    audio_play_sound(snd_dice, 0, 0);
                }
            }
        },
        
        config: 
        {
            damage: global.SkillData.LunarConstruction.damage[0]
        }
    };
}, function()
{
    playerCharacter.scripts.LunarConstruction.config.damage = global.SkillData.LunarConstruction.damage[1];
}, function()
{
    playerCharacter.scripts.LunarConstruction.config.damage = global.SkillData.LunarConstruction.damage[2];
}];
ds_map_set(PERKS, "LunarConstruction", new Perk("LunarConstruction", 
{
    optionName: global.TextContainer.LunarConstructionName.selectedLanguage,
    optionIcon: 2072,
    optionDescription: global.TextContainer.LunarConstructionDescription.selectedLanguage[0]
}, LunarConstructionOnApply));
var MoonSongOnApply = [function()
{
    if (!variable_struct_exists(weapons, "MoonSong"))
    {
        weapons.MoonSong = 
        {
            level: 0,
            id: "MoonSong"
        };
        AddAttack("MoonSong");
        InitializeAttack(ds_map_find_value(playerCharacter.attacks, "MoonSong"));
        ds_map_find_value(playerCharacter.attacks, "MoonSong").config.level = 1;
        weapons.MoonSong.level = 1;
    }
}, function()
{
    if (weapons.MoonSong.level == 1)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "MoonSong").timer;
        AddAttack("MoonSong");
        ds_map_find_value(playerCharacter.attacks, "MoonSong").timer = oldTimer;
    }
}, function()
{
    if (weapons.MoonSong.level == 2)
    {
        var oldTimer = ds_map_find_value(playerCharacter.attacks, "MoonSong").timer;
        AddAttack("MoonSong");
        ds_map_find_value(playerCharacter.attacks, "MoonSong").timer = oldTimer;
    }
}];
ds_map_set(PERKS, "MoonSong", new Perk("MoonSong", 
{
    optionName: global.TextContainer.MoonSongName.selectedLanguage,
    optionIcon: 428,
    optionDescription: global.TextContainer.MoonSongDescription.selectedLanguage[0]
}, MoonSongOnApply));
var HoshinovaOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Hoshinova"))
    {
        playerCharacter.onTakeDamage.Hoshinova = function(arg0, arg1, arg2, arg3)
        {
            var buffConfig = 
            {
                weight: global.SkillData.Hoshinova.DEF[0],
                buffIcon: 803
            };
            if (!variable_struct_exists(arg3.buffs, "Moona"))
            {
                soundPlay([89], "statUp", 10, 10);
                var statEffect = instance_create_depth(arg3.x, arg3.y - 8, arg3.depth + 1, obj_statEffect);
                statEffect.sprite_index = spr_MoonaMoonaBuff;
                statEffect.add = false;
            }
            obj_AttackController.ApplyBuff(arg3, "Moona", ds_map_find_value(obj_AttackController.Buffs, "Moona"), buffConfig);
            obj_AttackController.RemoveBuff(arg3, "Hoshinova");
            arg3.scripts.Hoshinova.config.timer = arg3.scripts.Hoshinova.config.maxTimer;
            return arg0;
        };
        
        playerCharacter.scripts.Hoshinova = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    var buffConfig = 
                    {
                        weight: arg1.weight
                    };
                    if (!variable_struct_exists(arg0.buffs, "Hoshinova"))
                    {
                        soundPlay([89], "statUp", 10, 10);
                        var statEffect = instance_create_depth(arg0.x, arg0.y - 8, arg0.depth + 1, obj_statEffect);
                        statEffect.sprite_index = spr_MoonaHoshinovaBuff;
                        obj_AttackController.ApplyBuff(arg0, "Hoshinova", ds_map_find_value(obj_AttackController.Buffs, "Hoshinova"), buffConfig);
                    }
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 300,
                weight: global.SkillData.Hoshinova.ATK[0]
            }
        };
    }
}, function()
{
    playerCharacter.onTakeDamage.Hoshinova = function(arg0, arg1, arg2, arg3)
    {
        var buffConfig = 
        {
            weight: global.SkillData.Hoshinova.DEF[1],
            buffIcon: 803
        };
        if (!variable_struct_exists(arg3.buffs, "Moona"))
        {
            soundPlay([89], "statUp", 10, 10);
            var statEffect = instance_create_depth(arg3.x, arg3.y - 8, arg3.depth + 1, obj_statEffect);
            statEffect.sprite_index = spr_MoonaMoonaBuff;
            statEffect.add = false;
        }
        obj_AttackController.ApplyBuff(arg3, "Moona", ds_map_find_value(obj_AttackController.Buffs, "Moona"), buffConfig);
        obj_AttackController.RemoveBuff(arg3, "Hoshinova");
        arg3.scripts.Hoshinova.config.timer = arg3.scripts.Hoshinova.config.maxTimer;
        return arg0;
    };
    
    playerCharacter.scripts.Hoshinova.config.weight = global.SkillData.Hoshinova.ATK[1];
    var buffConfig = 
    {
        weight: playerCharacter.scripts.Hoshinova.config.weight
    };
    UpdateBuffIfExists("Hoshinova", buffConfig);
}, function()
{
    playerCharacter.onTakeDamage.Hoshinova = function(arg0, arg1, arg2, arg3)
    {
        var buffConfig = 
        {
            weight: global.SkillData.Hoshinova.DEF[2],
            buffIcon: 803
        };
        if (!variable_struct_exists(arg3.buffs, "Moona"))
        {
            soundPlay([89], "statUp", 10, 10);
            var statEffect = instance_create_depth(arg3.x, arg3.y - 8, arg3.depth + 1, obj_statEffect);
            statEffect.sprite_index = spr_MoonaMoonaBuff;
            statEffect.add = false;
        }
        obj_AttackController.ApplyBuff(arg3, "Moona", ds_map_find_value(obj_AttackController.Buffs, "Moona"), buffConfig);
        obj_AttackController.RemoveBuff(arg3, "Hoshinova");
        arg3.scripts.Hoshinova.config.timer = arg3.scripts.Hoshinova.config.maxTimer;
        return arg0;
    };
    
    playerCharacter.scripts.Hoshinova.config.weight = global.SkillData.Hoshinova.ATK[2];
    var buffConfig = 
    {
        weight: playerCharacter.scripts.Hoshinova.config.weight
    };
    UpdateBuffIfExists("Hoshinova", buffConfig);
}];
ds_map_set(PERKS, "Hoshinova", new Perk("Hoshinova", 
{
    optionName: global.TextContainer.HoshinovaName.selectedLanguage,
    optionIcon: 640,
    optionDescription: global.TextContainer.HoshinovaDescription.selectedLanguage[0]
}, HoshinovaOnApply));
var DeezOnApply = [function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "Nuts").config.onHitEffects.CringeDamage = 
    {
        chance: global.SkillData.Deez.chance[0],
        percentage: global.SkillData.Deez.damage,
        attackID: "Deez"
    };
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "Nuts").config.onHitEffects.CringeDamage = 
    {
        chance: global.SkillData.Deez.chance[1],
        percentage: global.SkillData.Deez.damage,
        attackID: "Deez"
    };
}, function()
{
    ds_map_find_value(obj_AttackController.attackIndex, "Nuts").config.onHitEffects.CringeDamage = 
    {
        chance: global.SkillData.Deez.chance[2],
        percentage: global.SkillData.Deez.damage,
        attackID: "Deez"
    };
}];
ds_map_set(PERKS, "Deez", new Perk("Deez", 
{
    optionName: global.TextContainer.DeezName.selectedLanguage,
    optionIcon: 1504,
    optionDescription: global.TextContainer.DeezDescription.selectedLanguage[0]
}, DeezOnApply));
var NonstopNutsOnApply = [function()
{
    playerCharacter.scripts.NonstopNuts = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 10
        }
    };
    
    playerCharacter.onKill.NonstopNuts = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.NonstopNuts.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll <= global.SkillData.NonstopNuts.chance[0])
            {
                for (var i = 0; i < 8; i++)
                {
                    obj_AttackController.ExecuteAttack("NonstopNuts", arg0, 
                    {
                        damage: global.SkillData.NonstopNuts.damage[0],
                        image_xscale: 1,
                        image_yscale: 1,
                        direction: i * 45,
                        x: arg1.x,
                        y: arg1.y
                    });
                }
            }
        }
    };
}, function()
{
    playerCharacter.onKill.NonstopNuts = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.NonstopNuts.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll <= global.SkillData.NonstopNuts.chance[1])
            {
                for (var i = 0; i < 8; i++)
                {
                    obj_AttackController.ExecuteAttack("NonstopNuts", arg0, 
                    {
                        damage: global.SkillData.NonstopNuts.damage[1],
                        image_xscale: 1,
                        image_yscale: 1,
                        direction: i * 45,
                        x: arg1.x,
                        y: arg1.y
                    });
                }
            }
        }
    };
}, function()
{
    playerCharacter.onKill.NonstopNuts = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.NonstopNuts.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll <= global.SkillData.NonstopNuts.chance[2])
            {
                for (var i = 0; i < 8; i++)
                {
                    obj_AttackController.ExecuteAttack("NonstopNuts", arg0, 
                    {
                        damage: global.SkillData.NonstopNuts.damage[2],
                        image_xscale: 1,
                        image_yscale: 1,
                        direction: i * 45,
                        x: arg1.x,
                        y: arg1.y
                    });
                }
            }
        }
    };
}];
ds_map_set(PERKS, "NonstopNuts", new Perk("NonstopNuts", 
{
    optionName: global.TextContainer.NonstopNutsName.selectedLanguage,
    optionIcon: 1338,
    optionDescription: global.TextContainer.NonstopNutsDescription.selectedLanguage[0]
}, NonstopNutsOnApply));
var DLCOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.onPickUp, "DLC"))
    {
        obj_PlayerManager.playerSummon = [];
        playerCharacter.onPickUp.DLC = 
        {
            Script: function(arg0, arg1, arg2, arg3)
            {
                var stored, clones;
                if (arg2 == "HoloCoin")
                {
                    arg1.stored++;
                }
                if (arg1.stored >= 5)
                {
                    arg1.stored = 0;
                    if (arg1.clones < 3)
                    {
                        arg1.clones++;
                        var newClone = obj_MobManager.CreateSummon("RisuClone");
                        var dist = 40 + irandom(60);
                        var randDir = irandom(359);
                        newClone.randX = lengthdir_x(dist, randDir);
                        newClone.randY = lengthdir_y(dist, randDir);
                        newClone.attackEfficiency = arg1.currentEfficiency;
                        array_push(obj_PlayerManager.playerSummon, newClone);
                    }
                }
            },
            
            config: 
            {
                stored: 0,
                clones: 0,
                currentEfficiency: global.SkillData.DLC.damage[0]
            }
        };
        playerCharacter.scripts.DLC = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = arg1.maxTimer;
                    global.currentRunMoneyGained += floor((global.moneyMultiplier + other.moneyGain) * arg1.moneyGain);
                    if (global.moneyHeal)
                    {
                        Heal(227, 3, 1, true, false);
                    }
                    arg0.OnPickUp(arg0, "HoloCoin", true);
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 180,
                moneyGain: 1
            }
        };
    }
}, function()
{
    playerCharacter.scripts.DLC.config.moneyGain = 2;
    playerCharacter.onPickUp.DLC.config.currentEfficiency = global.SkillData.DLC.damage[1];
}, function()
{
    playerCharacter.scripts.DLC.config.moneyGain = 3;
    playerCharacter.onPickUp.DLC.config.currentEfficiency = global.SkillData.DLC.damage[2];
}];
ds_map_set(PERKS, "DLC", new Perk("DLC", 
{
    optionName: global.TextContainer.DLCName.selectedLanguage,
    optionIcon: 2192,
    optionDescription: global.TextContainer.DLCDescription.selectedLanguage[0]
}, DLCOnApply));
var ErofiOnApply = [function()
{
    playerCharacter.onTakeDamage.Erofi = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.scripts.Erofi.config.timer == 0)
        {
            var targets = ds_list_create();
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg3.x, arg3.y, global.SkillData.Erofi.distance, obj_Enemy, true, true, targets, false);
            }
            Heal(arg3, max(1, ds_list_size(targets) * (arg3.HP * arg3.scripts.Erofi.config.healAmount)), 0, true, false, false);
            ds_list_destroy(targets);
            targets = -1;
            arg3.scripts.Erofi.config.timer = arg3.scripts.Erofi.config.maxTimer;
        }
        return arg0;
    };
    
    playerCharacter.scripts.Erofi = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60,
            healAmount: global.SkillData.Erofi.heal[0]
        }
    };
}, function()
{
    playerCharacter.scripts.Erofi.config.healAmount = global.SkillData.Erofi.heal[1];
}, function()
{
    playerCharacter.scripts.Erofi.config.healAmount = global.SkillData.Erofi.heal[2];
}];
ds_map_set(PERKS, "Erofi", new Perk("Erofi", 
{
    optionName: global.TextContainer.ErofiName.selectedLanguage,
    optionIcon: 1659,
    optionDescription: global.TextContainer.ErofiDescription.selectedLanguage[0]
}, ErofiOnApply));
var AlienBrainwashingOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "AlienBrainwashing"))
    {
        playerCharacter.scripts.AlienBrainwashing = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    var amount = 0;
                    var targets = ds_list_create();
                    if (instance_exists(obj_Enemy))
                    {
                        collision_circle_list(arg0.x, arg0.y, 250, obj_Enemy, true, true, targets, true);
                    }
                    var buffConfig = 
                    {
                        reapply: true,
                        stacks: 1,
                        maxStacks: global.SkillData.AlienBrainwashing.maxTargets[arg1.level],
                        weight: 1,
                        buffIcon: 2142
                    };
                    for (var i = 0; i < min(arg1.maxStacks, ds_list_size(targets)); i++)
                    {
                        var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), arg0, 
                        {
                            damage: arg1.waveDamage
                        });
                        if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
                        {
                            ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg0, dmgObj[1], "AlienBrainwashing", undefined, undefined, undefined, true);
                        }
                        obj_AttackController.ApplyBuff(arg0, "AlienBrainwashing", ds_map_find_value(obj_AttackController.Buffs, "AlienBrainwashing"), buffConfig);
                        obj_AttackController.ApplyBuff(ds_list_find_value(targets, i), "Pacified", ds_map_find_value(obj_AttackController.Buffs, "Pacified"));
                    }
                    var vfx = instance_create_depth(arg0.x, arg0.y - 16, arg0.depth - 30, obj_vfx);
                    vfx.sprite_index = spr_GravityRing;
                    vfx.spriteColor = make_color_rgb(255, 88, 150);
                    vfx.image_xscale = 0.01;
                    vfx.image_yscale = 0.01;
                    vfx.image_alpha = 0.9;
                    vfx.followCharacter = arg0;
                    vfx.growthSpeed = 0.06;
                    vfx.fadeSpeed = 0.03;
                    vfx.alarm[0] = 1;
                    vfx.add = true;
                    vfx.duration = 60;
                    vfx.alarm[1] = 1;
                    vfx = instance_create_depth(arg0.x, arg0.y - 16, arg0.depth - 30, obj_vfx);
                    vfx.sprite_index = spr_GravityRing;
                    vfx.spriteColor = make_color_rgb(255, 88, 150);
                    vfx.image_xscale = 0.01;
                    vfx.image_yscale = 0.01;
                    vfx.image_alpha = 0.9;
                    vfx.followCharacter = arg0;
                    vfx.growthSpeed = 0.06;
                    vfx.fadeSpeed = 0.03;
                    vfx.alarm[0] = 16;
                    vfx.add = true;
                    vfx.duration = 75;
                    vfx.alarm[1] = 16;
                    vfx = instance_create_depth(arg0.x, arg0.y - 16, arg0.depth - 30, obj_vfx);
                    vfx.sprite_index = spr_GravityRing;
                    vfx.spriteColor = make_color_rgb(255, 88, 150);
                    vfx.image_xscale = 0.01;
                    vfx.image_yscale = 0.01;
                    vfx.image_alpha = 0.9;
                    vfx.followCharacter = arg0;
                    vfx.growthSpeed = 0.06;
                    vfx.fadeSpeed = 0.03;
                    vfx.alarm[0] = 31;
                    vfx.add = true;
                    vfx.duration = 90;
                    vfx.alarm[1] = 31;
                    soundPlay([236], "brainwash", 30, 10);
                    arg1.timer = arg1.maxTimer;
                    ds_list_destroy(targets);
                    targets = -1;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: global.SkillData.AlienBrainwashing.timer,
                maxStacks: 10,
                waveDamage: global.SkillData.AlienBrainwashing.damage[0],
                level: 0
            }
        };
    }
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: global.SkillData.AlienBrainwashing.maxTargets[0],
        weight: 1,
        buffIcon: 2142
    };
    UpdateBuffIfExists("AlienBrainwashing", buffConfig);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: global.SkillData.AlienBrainwashing.maxTargets[1],
        weight: 1,
        buffIcon: 2142
    };
    playerCharacter.scripts.AlienBrainwashing.config.maxStacks = global.SkillData.AlienBrainwashing.maxTargets[1];
    playerCharacter.scripts.AlienBrainwashing.config.waveDamage = global.SkillData.AlienBrainwashing.damage[1];
    UpdateBuffIfExists("AlienBrainwashing", buffConfig);
}, function()
{
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: global.SkillData.AlienBrainwashing.maxTargets[2],
        weight: 1,
        buffIcon: 2142
    };
    playerCharacter.scripts.AlienBrainwashing.config.maxStacks = global.SkillData.AlienBrainwashing.maxTargets[2];
    playerCharacter.scripts.AlienBrainwashing.config.waveDamage = global.SkillData.AlienBrainwashing.damage[2];
    UpdateBuffIfExists("AlienBrainwashing", buffConfig);
}];
ds_map_set(PERKS, "AlienBrainwashing", new Perk("AlienBrainwashing", 
{
    optionName: global.TextContainer.AlienBrainwashingName.selectedLanguage,
    optionIcon: 2142,
    optionDescription: global.TextContainer.AlienBrainwashingDescription.selectedLanguage[0]
}, AlienBrainwashingOnApply));
var PolyglotOnApply = [function()
{
    playerCharacter.onKill.Polyglot = function(arg0, arg1, arg2)
    {
        if (arg0.scripts.Polyglot.config.timer == 0)
        {
            var rollChance = irandom(100);
            if (rollChance <= 10)
            {
                var languageOrb = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_langOrb);
                languageOrb.stat = irandom(4);
                languageOrb.level = arg0.scripts.Polyglot.config.currentLevel;
                languageOrb.Set();
                arg0.scripts.Polyglot.config.timer = arg0.scripts.Polyglot.config.maxTimer;
            }
        }
        exit;
    };
    
    playerCharacter.scripts.Polyglot = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 300,
            currentLevel: 1,
            currentStat: 0
        }
    };
}, function()
{
    playerCharacter.scripts.Polyglot.config.currentLevel = 2;
    var buffStat = [2032, 1623, 676, 293, 353];
    var buffConfig = 
    {
        reapply: true,
        stat: playerCharacter.scripts.Polyglot.config.currentStat,
        level: playerCharacter.scripts.Polyglot.config.currentLevel,
        buffIcon: buffStat[playerCharacter.scripts.Polyglot.config.currentStat]
    };
    UpdateBuffIfExists("Polyglot", buffConfig);
}, function()
{
    playerCharacter.scripts.Polyglot.config.currentLevel = 3;
    var buffStat = [2032, 1623, 676, 293, 353];
    var buffConfig = 
    {
        reapply: true,
        stat: playerCharacter.scripts.Polyglot.config.currentStat,
        level: playerCharacter.scripts.Polyglot.config.currentLevel,
        buffIcon: buffStat[playerCharacter.scripts.Polyglot.config.currentStat]
    };
    UpdateBuffIfExists("Polyglot", buffConfig);
}];
ds_map_set(PERKS, "Polyglot", new Perk("Polyglot", 
{
    optionName: global.TextContainer.PolyglotName.selectedLanguage,
    optionIcon: 424,
    optionDescription: global.TextContainer.PolyglotDescription.selectedLanguage[0]
}, PolyglotOnApply));
var NinjutsuOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Ninjutsu"))
    {
        playerCharacter.scripts.Ninjutsu = 
        {
            Script: function(arg0, arg1)
            {
                var meter, timer, stopTimer;
                if (arg1.timer < 1 && arg0.isMoving)
                {
                    if (arg1.meter < 100)
                    {
                        arg1.meter++;
                        if (arg1.meter == 25 || arg1.meter == 50 || arg1.meter == 75 || arg1.meter == 100)
                        {
                            audio_play_sound(snd_chakracharge, 0, 0);
                            var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                            afterimage.sprite_index = arg0.sprite_index;
                            afterimage.image_speed = 0;
                            afterimage.image_index = arg0.image_index;
                            afterimage.image_xscale = arg0.image_xscale;
                            afterimage.image_yscale = arg0.image_yscale;
                            afterimage.afterimage_color = 16711680;
                            afterimage.image_angle = arg0.image_angle;
                            afterimage.image_alpha = 0.9;
                            afterimage.grow = true;
                            afterimage.growthRate = 0.15;
                        }
                        arg1.timer = arg1.maxTimer;
                    }
                }
                else if (arg0.isMoving)
                {
                    if (arg1.meter < 100)
                    {
                        arg1.timer--;
                    }
                    arg1.stopTimer = 30;
                }
                else if (!arg0.isMoving)
                {
                    if (arg1.stopTimer > 0)
                    {
                        arg1.stopTimer--;
                    }
                }
                if (arg1.stopTimer == 0)
                {
                    if (arg1.meter >= 25)
                    {
                        audio_play_sound(snd_jutsu, 0, 0);
                        var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                        afterimage.sprite_index = arg0.sprite_index;
                        afterimage.image_speed = 0;
                        afterimage.image_index = arg0.image_index;
                        afterimage.image_xscale = arg0.image_xscale;
                        afterimage.image_yscale = arg0.image_yscale;
                        afterimage.afterimage_color = 255;
                        afterimage.image_angle = arg0.image_angle;
                        afterimage.image_alpha = 0.9;
                        afterimage.grow = true;
                        afterimage.growthRate = 0.15;
                    }
                    if (arg1.meter >= 25 && arg1.meter < 50)
                    {
                        var xPos = lengthdir_x(75, arg0.direction);
                        var yPos = lengthdir_y(75, arg0.direction);
                        obj_AttackController.ExecuteAttack("Katon", arg0, 
                        {
                            damage: 0.6 * arg1.damageScale,
                            x: arg0.x + xPos,
                            y: arg0.y + yPos
                        });
                        arg1.meter = 0;
                    }
                    else if (arg1.meter >= 50 && arg1.meter < 75)
                    {
                        audio_play_sound(snd_suiton, 0, 0);
                        for (var i = 0; i < 10; i++)
                        {
                            obj_AttackController.ExecuteAttack("Suiton", arg0, 
                            {
                                direction: i * 36,
                                damage: 0.4 * arg1.damageScale
                            });
                        }
                        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
                        vfx.sprite_index = spr_SuitonBubble;
                        vfx.image_speed = 1;
                        vfx.image_xscale = 1;
                        vfx.image_yscale = 1;
                        vfx.image_alpha = 1;
                        vfx.offset_y = -16;
                        vfx.duration = 120;
                        vfx.followCharacter = arg0;
                        vfx.add = true;
                        Heal(arg0, arg0.HP * 0.25, 0);
                        arg0.invincible = true;
                        arg0.invincibilityTimer = 120;
                        arg1.meter = 0;
                    }
                    else if (arg1.meter >= 75 && arg1.meter < 100)
                    {
                        audio_play_sound(snd_doton, 0, 0);
                        obj_AttackController.ExecuteAttack("Doton", arg0, 
                        {
                            damage: 0.8 * arg1.damageScale
                        });
                        arg1.meter = 0;
                    }
                    else if (arg1.meter == 100)
                    {
                        audio_play_sound(snd_raiton, 0, 0);
                        obj_Cam.ExecuteShake(120, 4);
                        obj_PlayerManager.Dank(60);
                        var targets = ds_list_create();
                        if (instance_exists(obj_Enemy))
                        {
                            collision_circle_list(arg0.x, arg0.y, 320, obj_Enemy, true, true, targets, true);
                        }
                        if (ds_list_size(targets) > 0)
                        {
                            var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, 0), arg0, 
                            {
                                damage: 8 * arg1.damageScale
                            });
                            for (var i = 0; i < ds_list_size(targets); i++)
                            {
                                if (ds_list_size(targets) > i && instance_exists(ds_list_find_value(targets, i)) && ds_list_find_value(targets, i).isEnemy)
                                {
                                    ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg0, dmgObj[1], "Raiton", undefined, undefined, undefined, true);
                                    if (i < 50)
                                    {
                                        var vfx = instance_create_depth(ds_list_find_value(targets, i).x, ds_list_find_value(targets, i).y, ds_list_find_value(targets, i).depth - 10, obj_vfx);
                                        vfx.sprite_index = spr_OllieRaiton;
                                        vfx.image_speed = 1;
                                        vfx.image_xscale = 1;
                                        vfx.image_yscale = 1;
                                        vfx.image_alpha = 1;
                                        vfx.add = true;
                                    }
                                    ds_list_find_value(targets, i).Freeze(180);
                                }
                            }
                        }
                        ds_list_destroy(targets);
                        targets = -1;
                        arg1.meter = 0;
                    }
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 15,
                stopTimer: 30,
                damageScale: global.SkillData.Ninjutsu.damage[0],
                meter: 0
            }
        };
        
        playerCharacter.customDrawScriptBelow.Ninjutsu = function(arg0)
        {
            if (arg0.isMoving)
            {
                if (global.lightFX)
                {
                    var randomDirection = 
                    {
                        x: lengthdir_x(40, irandom(359)),
                        y: lengthdir_y(40, irandom(359))
                    };
                    var randSize = random(0.2);
                    var vfx = instance_create_depth(320 + randomDirection.x, 180 + randomDirection.y, arg0.depth - 30, obj_vfxGUI);
                    vfx.sprite_index = spr_OllieChakra;
                    vfx.image_xscale = 0.2 + randSize;
                    vfx.image_yscale = 0.2 + randSize;
                    vfx.image_alpha = 0.5;
                    vfx.alarm[0] = 1;
                    vfx.growthSpeed = -0.02;
                    vfx.add = true;
                    vfx.duration = 20;
                    vfx.speed = 2;
                    vfx.direction = point_direction(vfx.x, vfx.y, 320, 180);
                }
            }
        };
        
        customDrawScript.Ninjutsu = function(arg0)
        {
            if (!paused && instance_exists(playerCharacter))
            {
                draw_healthbar(24, 307, 136, 313, (playerCharacter.scripts.Ninjutsu.config.meter / 100) * 100, c_white, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, false, false);
                draw_sprite(spr_OllieNinjutsuGauge, 0, 80, 310);
            }
        };
    }
}, function()
{
    playerCharacter.scripts.Ninjutsu.config.damageScale = global.SkillData.Ninjutsu.damage[1];
}, function()
{
    playerCharacter.scripts.Ninjutsu.config.damageScale = global.SkillData.Ninjutsu.damage[2];
}];
ds_map_set(PERKS, "Ninjutsu", new Perk("Ninjutsu", 
{
    optionName: global.TextContainer.NinjutsuName.selectedLanguage,
    optionIcon: 147,
    optionDescription: global.TextContainer.NinjutsuDescription.selectedLanguage[0]
}, NinjutsuOnApply));

function UndeadStepBuffApply(arg0, arg1)
{
    if (arg0.scripts.Undead.config.hpLost > 0)
    {
        var gain = (arg0.scripts.Undead.config.hpLost div arg0.scripts.Undead.config.weight) * global.SkillData.Undead.ATK;
        arg0.ATK += gain;
    }
}

var UndeadOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Undead"))
    {
        playerCharacter.onKillingHit.Undead = function(arg0, arg1, arg2, arg3)
        {
            if (arg0 >= arg3.currentHP && arg3.scripts.Undead.config.timer == 0)
            {
                obj_AttackController.ApplyBuff(arg3, "Undead", ds_map_find_value(obj_AttackController.Buffs, "Undead"), 
                {
                    buffIcon: 693
                });
                arg3.scripts.Undead.config.timesDied++;
                obj_AttackController.ApplyBuff(arg3, "UndeadPenalty", ds_map_find_value(obj_AttackController.Buffs, "UndeadPenalty"), 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: 10,
                    buffIcon: 2111
                });
                arg3.scripts.Undead.config.timer = -1;
            }
            return arg0;
        };
        
        playerCharacter.scripts.Undead = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: global.SkillData.Undead.cooldown * 60,
                timesDied: 0,
                hpLost: 0,
                weight: global.SkillData.Undead.weight[0]
            }
        };
        playerCharacter.stepBuffs.Undead = 
        {
            Apply: UndeadStepBuffApply,
            config: {}
        };
    }
}, function()
{
    playerCharacter.scripts.Undead.config.weight = global.SkillData.Undead.weight[1];
}, function()
{
    playerCharacter.scripts.Undead.config.weight = global.SkillData.Undead.weight[2];
}];
ds_map_set(PERKS, "Undead", new Perk("Undead", 
{
    optionName: global.TextContainer.UndeadName.selectedLanguage,
    optionIcon: 693,
    optionDescription: global.TextContainer.UndeadDescription.selectedLanguage[0]
}, UndeadOnApply));
var SimpOfAllTimeOnApply = [function()
{
    playerCharacter.scripts.SimpOfAllTime = 
    {
        Script: function(arg0, arg1)
        {
            var healArray;
            for (var i = 0; i < array_length(arg1.healArray); i++)
            {
                if (arg1.healArray[i] > 0)
                {
                    arg1.healArray[i]--;
                }
            }
            for (var i = 0; i < array_length(arg1.healArray); i++)
            {
                if (arg1.healArray[i] == 0)
                {
                    Heal(arg0, 5, 1, true, false, false);
                    array_delete(arg1.healArray, i, 1);
                }
            }
        },
        
        config: 
        {
            healArray: [],
            level: 0
        }
    };
    var buffConfig = 
    {
        weight: 0.2
    };
    
    playerCharacter.onKill.SimpOfAllTime = function(arg0, arg1, arg2)
    {
        var rollChance = irandom(100);
        if (rollChance <= 3)
        {
            var SimpOfAllTime = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_hololiveMerch);
            SimpOfAllTime.Set(arg0.scripts.SimpOfAllTime.config.level);
        }
        exit;
    };
    
    UpdateBuffIfExists("SimpOfAllTime", buffConfig);
}, function()
{
    playerCharacter.scripts.SimpOfAllTime.config.level = 1;
}, function()
{
    playerCharacter.scripts.SimpOfAllTime.config.level = 2;
}];
ds_map_set(PERKS, "SimpOfAllTime", new Perk("SimpOfAllTime", 
{
    optionName: global.TextContainer.SimpOfAllTimeName.selectedLanguage,
    optionIcon: 746,
    optionDescription: global.TextContainer.SimpOfAllTimeDescription.selectedLanguage[0]
}, SimpOfAllTimeOnApply));
var WindMagicOnApply = [function()
{
    playerCharacter.onCriticalHit.WindMagic = function(arg0, arg1, arg2, arg3)
    {
        var ac = 114;
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 20,
            weight: global.SkillData.WindMagic.haste[arg0.scripts.WindMagic.config.level]
        };
        ac.ApplyBuff(arg0, "WindMagic", ds_map_find_value(ac.Buffs, "WindMagic"), buffConfig);
        var roll = irandom(99);
        if (arg0.scripts.WindMagic.config.timer == 0)
        {
            if (roll < global.SkillData.WindMagic.chance[arg0.scripts.WindMagic.config.level])
            {
                arg0.scripts.WindMagic.config.timer = arg0.scripts.WindMagic.config.maxTimer;
                obj_AttackController.ExecuteAttack("WindMagic", arg0, 
                {
                    damage: global.SkillData.WindMagic.damage[arg0.scripts.WindMagic.config.level]
                });
            }
        }
        return arg3;
    };
    
    playerCharacter.scripts.WindMagic = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.WindMagic.config.timer > 0)
            {
                arg0.scripts.WindMagic.config.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 20,
            level: 0,
            damage: global.SkillData.WindMagic.damage[0]
        }
    };
}, function()
{
    playerCharacter.scripts.WindMagic.config.level = 1;
    playerCharacter.scripts.WindMagic.config.damage = global.SkillData.WindMagic.damage[1];
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: global.SkillData.WindMagic.haste[playerCharacter.scripts.WindMagic.config.level]
    };
    UpdateBuffIfExists("WindMagic", buffConfig);
}, function()
{
    playerCharacter.scripts.WindMagic.config.level = 2;
    playerCharacter.scripts.WindMagic.config.damage = global.SkillData.WindMagic.damage[2];
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 20,
        weight: global.SkillData.WindMagic.haste[playerCharacter.scripts.WindMagic.config.level]
    };
    UpdateBuffIfExists("WindMagic", buffConfig);
}];
ds_map_set(PERKS, "WindMagic", new Perk("WindMagic", 
{
    optionName: global.TextContainer.WindMagicName.selectedLanguage,
    optionIcon: 2143,
    optionDescription: global.TextContainer.WindMagicDescription.selectedLanguage[0]
}, WindMagicOnApply));
var AttentionPleaseOnApply = [function()
{
    playerCharacter.scripts.AttentionPlease = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
            else
            {
                arg1.timer = arg1.maxTimer;
                var buffConfig = 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: 10,
                    weight: global.SkillData.AttentionPlease.crit[arg1.level]
                };
                var targets = ds_list_create();
                if (instance_exists(obj_Enemy))
                {
                    collision_circle_list(arg0.x, arg0.y, global.SkillData.AttentionPlease.distance, obj_Enemy, true, true, targets, false);
                }
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    obj_AttackController.ApplyBuff(arg0, "AttentionPlease", ds_map_find_value(obj_AttackController.Buffs, "AttentionPlease"), buffConfig);
                }
                var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 100, obj_vfx);
                vfx.sprite_index = spr_MelCookingPulse;
                vfx.duration = 60;
                vfx.image_alpha = 0.2;
                vfx.image_xscale = 2.4899999999999998;
                vfx.image_yscale = 1.992;
                vfx.alarm[1] = 15;
                vfx.fadeSpeed = 0.01;
                soundPlay([124], "attention", 20, 0);
                with (obj_Enemy)
                {
                    if (point_distance(x, y, obj_Player.x, obj_Player.y) > 150)
                    {
                        obj_AttackController.ApplyBuff(self, "AttentionPleaseDebuff", ds_map_find_value(obj_AttackController.Buffs, "AttentionPleaseDebuff"));
                    }
                }
                ds_list_destroy(targets);
                targets = -1;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 900,
            level: 0
        }
    };
}, function()
{
    playerCharacter.scripts.AttentionPlease.config.level = 1;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.AttentionPlease.crit[playerCharacter.scripts.AttentionPlease.config.level]
    };
    UpdateBuffIfExists("AttentionPlease", buffConfig);
}, function()
{
    playerCharacter.scripts.AttentionPlease.config.level = 2;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 10,
        weight: global.SkillData.AttentionPlease.crit[playerCharacter.scripts.AttentionPlease.config.level]
    };
    UpdateBuffIfExists("AttentionPlease", buffConfig);
}];
ds_map_set(PERKS, "AttentionPlease", new Perk("AttentionPlease", 
{
    optionName: global.TextContainer.AttentionPleaseName.selectedLanguage,
    optionIcon: 1011,
    optionDescription: global.TextContainer.AttentionPleaseDescription.selectedLanguage[0]
}, AttentionPleaseOnApply));
var LadyOfPeafowlOnApply = [function()
{
    playerCharacter.onPickUp.LadyOfPeafowl = 
    {
        Script: function(arg0, arg1, arg2, arg3)
        {
            if (arg2 == "HoloCoin")
            {
                if (variable_struct_exists(arg0.buffs, "LadyOfPeafowl"))
                {
                    var buffConfig = 
                    {
                        reapply: true,
                        stacks: 1,
                        maxStacks: global.SkillData.LadyOfPeafowl.maxStacks[arg1.level],
                        weight: 0.01
                    };
                    var buff = ds_map_find_value(obj_AttackController.Buffs, "LadyOfPeafowl");
                    variable_struct_set(buff, "timer", min(1800, arg0.buffs.LadyOfPeafowl.timer + (60 * (arg1.level + 1))));
                    obj_AttackController.ApplyBuff(arg0, "LadyOfPeafowl", buff, buffConfig);
                }
                else
                {
                    var buffConfig = 
                    {
                        reapply: true,
                        stacks: 1,
                        maxStacks: global.SkillData.LadyOfPeafowl.maxStacks[arg1.level],
                        weight: 0.01
                    };
                    obj_AttackController.ApplyBuff(arg0, "LadyOfPeafowl", ds_map_find_value(obj_AttackController.Buffs, "LadyOfPeafowl"), buffConfig);
                }
            }
        },
        
        config: 
        {
            level: 0
        }
    };
}, function()
{
    playerCharacter.onPickUp.LadyOfPeafowl.config.level = 1;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: global.SkillData.LadyOfPeafowl.maxStacks[playerCharacter.onPickUp.LadyOfPeafowl.config.level],
        weight: 0.01
    };
    UpdateBuffIfExists("LadyOfPeafowl", buffConfig);
}, function()
{
    playerCharacter.onPickUp.LadyOfPeafowl.config.level = 2;
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: global.SkillData.LadyOfPeafowl.maxStacks[playerCharacter.onPickUp.LadyOfPeafowl.config.level],
        weight: 0.01
    };
    UpdateBuffIfExists("LadyOfPeafowl", buffConfig);
}];
ds_map_set(PERKS, "LadyOfPeafowl", new Perk("LadyOfPeafowl", 
{
    optionName: global.TextContainer.LadyOfPeafowlName.selectedLanguage,
    optionIcon: 2417,
    optionDescription: global.TextContainer.LadyOfPeafowlDescription.selectedLanguage[0]
}, LadyOfPeafowlOnApply));
var LivingWeaponOnApply = [function()
{
    playerCharacter.scripts.LivingWeapon = 
    {
        Script: function(arg0, arg1)
        {
        },
        
        config: 
        {
            aura: -1
        }
    };
    
    playerCharacter.onKill.LivingWeapon = function(arg0, arg1, arg2)
    {
        var roll = irandom(99);
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 50,
            weight: global.SkillData.LivingWeapon.ATK[0],
            buffIcon: 936,
            loseStackOnRemove: true,
            level: 0
        };
        if (roll < 30)
        {
            obj_AttackController.ApplyBuff(arg0, "LivingWeapon", ds_map_find_value(obj_AttackController.Buffs, "LivingWeapon"), buffConfig);
        }
    };
    
    playerCharacter.onTakeDamage.LivingWeapon = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        if (arg0 < 1)
        {
            return arg0;
        }
        if (variable_struct_exists(arg3.buffs, "LivingWeapon"))
        {
            for (var i = 0; i < 5; i++)
            {
                obj_AttackController.RemoveBuff(arg3, "LivingWeapon");
            }
        }
        return arg0;
    };
}, function()
{
    playerCharacter.onKill.LivingWeapon = function(arg0, arg1, arg2)
    {
        var roll = irandom(99);
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 50,
            weight: global.SkillData.LivingWeapon.ATK[0],
            buffIcon: 936,
            loseStackOnRemove: true,
            level: 1
        };
        if (roll < 30)
        {
            obj_AttackController.ApplyBuff(arg0, "LivingWeapon", ds_map_find_value(obj_AttackController.Buffs, "LivingWeapon"), buffConfig);
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 50,
        weight: global.SkillData.LivingWeapon.ATK[1],
        buffIcon: 936,
        loseStackOnRemove: true,
        level: 1
    };
    UpdateBuffIfExists("LivingWeapon", buffConfig);
}, function()
{
    playerCharacter.onKill.LivingWeapon = function(arg0, arg1, arg2)
    {
        var roll = irandom(99);
        var buffConfig = 
        {
            reapply: true,
            stacks: 1,
            maxStacks: 50,
            weight: global.SkillData.LivingWeapon.ATK[0],
            buffIcon: 936,
            loseStackOnRemove: true,
            level: 2
        };
        if (roll < 30)
        {
            obj_AttackController.ApplyBuff(arg0, "LivingWeapon", ds_map_find_value(obj_AttackController.Buffs, "LivingWeapon"), buffConfig);
        }
    };
    
    var buffConfig = 
    {
        reapply: true,
        stacks: 1,
        maxStacks: 50,
        weight: global.SkillData.LivingWeapon.ATK[2],
        buffIcon: 936,
        loseStackOnRemove: true,
        level: 2
    };
    UpdateBuffIfExists("LivingWeapon", buffConfig);
}];
ds_map_set(PERKS, "LivingWeapon", new Perk("LivingWeapon", 
{
    optionName: global.TextContainer.LivingWeaponName.selectedLanguage,
    optionIcon: 936,
    optionDescription: global.TextContainer.LivingWeaponDescription.selectedLanguage[0]
}, LivingWeaponOnApply));
var SlumberOnApply = [function()
{
    playerCharacter.scripts.Slumber = 
    {
        Script: function(arg0, arg1)
        {
            var timer, buffTimer;
            if (!arg0.isMoving && !variable_struct_exists(arg0.buffs, "Awake"))
            {
                if (arg1.timer < arg1.maxTimer)
                {
                    arg1.timer++;
                }
                if (arg1.timer == arg1.maxTimer)
                {
                    if (arg1.buffTimer < 120)
                    {
                        arg1.buffTimer++;
                        with (obj_Enemy)
                        {
                            obj_AttackController.ApplyBuff(self, "SlumberSPDDebuff", ds_map_find_value(obj_AttackController.Buffs, "SlumberSPDDebuff"));
                        }
                        if ((arg1.buffTimer % 15) == 0)
                        {
                            var vfx = instance_create_depth(arg0.x, arg0.y - 25, arg0.depth - 20, obj_vfx);
                            vfx.sprite_index = spr_AnyaSleep;
                            vfx.image_speed = 0;
                            vfx.image_xscale = 0.5;
                            vfx.image_yscale = 0.5;
                            vfx.image_alpha = 0.8;
                            vfx.growthSpeed = 0.04;
                            vfx.hspeed = 0.2 + random(0.3);
                            vfx.vspeed = -0.2 - random(0.3);
                            vfx.alarm[0] = 1;
                            vfx.alarm[1] = 10;
                        }
                    }
                    else
                    {
                        obj_AttackController.ApplyBuff(arg0, "Resting", ds_map_find_value(obj_AttackController.Buffs, "Resting"), 
                        {
                            reapply: true,
                            buffIcon: 1209,
                            stacks: 1,
                            maxStacks: 10
                        });
                        Heal(arg0, arg1.healAmount * arg0.HP, 0);
                        arg1.buffTimer = 0;
                    }
                }
            }
            else
            {
                arg1.timer = 0;
                arg1.buffTimer = 120;
                if (variable_struct_exists(arg0.buffs, "Resting"))
                {
                    obj_AttackController.ApplyBuff(arg0, "Awake", ds_map_find_value(obj_AttackController.Buffs, "Awake"), 
                    {
                        buffIcon: 325
                    });
                }
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 40,
            buffTimer: 120,
            healAmount: global.SkillData.Slumber.heal[0]
        }
    };
}, function()
{
    playerCharacter.scripts.Slumber.config.healAmount = global.SkillData.Slumber.heal[1];
}, function()
{
    playerCharacter.scripts.Slumber.config.healAmount = global.SkillData.Slumber.heal[2];
}];
ds_map_set(PERKS, "Slumber", new Perk("Slumber", 
{
    optionName: global.TextContainer.SlumberName.selectedLanguage,
    optionIcon: 1209,
    optionDescription: global.TextContainer.SlumberDescription.selectedLanguage[0]
}, SlumberOnApply));
var CuttingDeepOnApply = [function()
{
    playerCharacter.pickupRange += global.SkillData.CuttingDeep.PUR[0];
    variable_struct_set(playerCharacter.onHitEffects, "CuttingDeepHit", 
    {
        chance: global.SkillData.CuttingDeep.chance[0]
    });
}, function()
{
    playerCharacter.pickupRange += global.SkillData.CuttingDeep.PUR[1];
    variable_struct_set(playerCharacter.onHitEffects, "CuttingDeepHit", 
    {
        chance: global.SkillData.CuttingDeep.chance[1]
    });
}, function()
{
    playerCharacter.pickupRange += global.SkillData.CuttingDeep.PUR[2];
    variable_struct_set(playerCharacter.onHitEffects, "CuttingDeepHit", 
    {
        chance: global.SkillData.CuttingDeep.chance[2]
    });
}];
ds_map_set(PERKS, "CuttingDeep", new Perk("CuttingDeep", 
{
    optionName: global.TextContainer.CuttingDeepName.selectedLanguage,
    optionIcon: 706,
    optionDescription: global.TextContainer.CuttingDeepDescription.selectedLanguage[0]
}, CuttingDeepOnApply));
var MaterialGrindOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "MaterialGrind"))
    {
        customDrawScript.MaterialGrind = function(arg0)
        {
            if (!paused && instance_exists(playerCharacter))
            {
                draw_sprite(spr_KaelaInventory, 0, 15, 240);
                draw_set_font(buffFont);
                draw_set_color(c_white);
                draw_set_halign(fa_left);
                draw_text(38, 261, "x " + string(playerCharacter.scripts.MaterialGrind.config.oreA));
                draw_text(38, 278, "x " + string(playerCharacter.scripts.MaterialGrind.config.oreB));
                draw_text(38, 295, "x " + string(playerCharacter.scripts.MaterialGrind.config.oreC));
            }
        };
        
        playerCharacter.onKill.MaterialGrind = function(arg0, arg1, arg2)
        {
            if (arg0.scripts.MaterialGrind.config.timer == 0)
            {
                var roll = irandom(99);
                if (roll <= global.SkillData.MaterialGrind.chance[arg0.scripts.MaterialGrind.config.level])
                {
                    arg0.scripts.MaterialGrind.config.timer = arg0.scripts.MaterialGrind.config.maxTimer;
                    var roll2 = irandom(99);
                    var oreType = 0;
                    if (roll2 < 10)
                    {
                        oreType = 2;
                    }
                    else if (roll2 < 40)
                    {
                        oreType = 1;
                    }
                    var rock = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_OreDeposit);
                    rock.sprite_index = spr_KaelaOre;
                    rock.oreType = oreType;
                    rock.image_speed = 0;
                    rock.image_index = oreType;
                    rock.HP = 1 + oreType + irandom(1);
                }
            }
        };
        
        playerCharacter.scripts.MaterialGrind = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                if (arg1.oreA > 9)
                {
                    arg1.oreA -= 10;
                    obj_AttackController.ApplyBuff(arg0, "Ore1", ds_map_find_value(obj_AttackController.Buffs, "Ore1"), 
                    {
                        buffIcon: 2200,
                        stacks: 1,
                        maxStacks: 999,
                        reapply: true
                    });
                }
                if (arg1.oreB > 9)
                {
                    arg1.oreB -= 10;
                    for (var i = 0; i < 2; i++)
                    {
                        obj_AttackController.ApplyBuff(arg0, "Ore1", ds_map_find_value(obj_AttackController.Buffs, "Ore1"), 
                        {
                            buffIcon: 2200,
                            stacks: 1,
                            maxStacks: 999,
                            reapply: true
                        });
                    }
                }
                if (arg1.oreC > 9)
                {
                    arg1.oreC -= 10;
                    for (var i = 0; i < 3; i++)
                    {
                        obj_AttackController.ApplyBuff(arg0, "Ore1", ds_map_find_value(obj_AttackController.Buffs, "Ore1"), 
                        {
                            buffIcon: 2200,
                            stacks: 3,
                            maxStacks: 999,
                            reapply: true
                        });
                    }
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 10,
                level: 0,
                oreA: 0,
                oreB: 0,
                oreC: 0
            }
        };
    }
}, function()
{
    playerCharacter.scripts.MaterialGrind.config.level = 1;
}, function()
{
    playerCharacter.scripts.MaterialGrind.config.level = 2;
}];
ds_map_set(PERKS, "MaterialGrind", new Perk("MaterialGrind", 
{
    optionName: global.TextContainer.MaterialGrindName.selectedLanguage,
    optionIcon: 2116,
    optionDescription: global.TextContainer.MaterialGrindDescription.selectedLanguage[0]
}, MaterialGrindOnApply));
var NoPressureOnApply = [function()
{
    playerCharacter.scripts.NoPressure = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
            else
            {
                arg1.timer = arg1.maxTimer;
                obj_AttackController.ExecuteAttack("NoPressure", arg0, 
                {
                    image_xscale: global.SkillData.NoPressure.size,
                    image_yscale: global.SkillData.NoPressure.size,
                    damage: global.SkillData.NoPressure.damage[arg1.level]
                });
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 120,
            level: 0
        }
    };
}, function()
{
    playerCharacter.scripts.NoPressure.config.level = 1;
}, function()
{
    playerCharacter.scripts.NoPressure.config.level = 2;
}];
ds_map_set(PERKS, "NoPressure", new Perk("NoPressure", 
{
    optionName: global.TextContainer.NoPressureName.selectedLanguage,
    optionIcon: 2228,
    optionDescription: global.TextContainer.NoPressureDescription.selectedLanguage[0]
}, NoPressureOnApply));
var TheBlacksmithOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "TheBlacksmith"))
    {
        playerCharacter.scripts.TheBlacksmith = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = arg1.maxTimer;
                    var targets = ds_list_create();
                    if (instance_exists(obj_Enemy))
                    {
                        collision_circle_list(arg0.x, arg0.y, arg1.range, obj_Enemy, true, true, targets, false);
                    }
                    for (var i = 0; i < arg1.number; i++)
                    {
                        if (ds_list_size(targets) > i)
                        {
                            var choseTarget = 0;
                            if (i == 0)
                            {
                                choseTarget = 0;
                            }
                            else
                            {
                                choseTarget = irandom(ds_list_size(targets) - 1);
                            }
                            obj_AttackController.ExecuteAttack("FallingAnvil", arg0, 
                            {
                                damage: global.SkillData.TheBlacksmith.damage[arg1.level],
                                x: ds_list_find_value(targets, choseTarget).x,
                                y: ds_list_find_value(targets, choseTarget).y - 200,
                                targetY: ds_list_find_value(targets, choseTarget).y,
                                level: arg1.level
                            });
                        }
                        else
                        {
                            obj_AttackController.ExecuteAttack("FallingAnvil", arg0, 
                            {
                                damage: global.SkillData.TheBlacksmith.damage[arg1.level],
                                x: arg0.x,
                                y: arg0.y - 200,
                                targetY: arg0.y,
                                level: arg1.level
                            });
                        }
                    }
                    ds_list_destroy(targets);
                    targets = -1;
                }
            },
            
            config: 
            {
                timer: 0,
                range: 300,
                maxTimer: 780,
                level: 0,
                number: 1
            }
        };
    }
}, function()
{
    playerCharacter.scripts.TheBlacksmith.config.level = 1;
    playerCharacter.scripts.TheBlacksmith.config.number = 2;
}, function()
{
    playerCharacter.scripts.TheBlacksmith.config.level = 2;
    playerCharacter.scripts.TheBlacksmith.config.number = 3;
}];
ds_map_set(PERKS, "TheBlacksmith", new Perk("TheBlacksmith", 
{
    optionName: global.TextContainer.TheBlacksmithName.selectedLanguage,
    optionIcon: 36,
    optionDescription: global.TextContainer.TheBlacksmithDescription.selectedLanguage[0]
}, TheBlacksmithOnApply));
var SecretAgentOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "SecretAgent"))
    {
        variable_struct_set(playerCharacter.onHitEffects, "StealthHit", 
        {
            damageMultiplier: global.SkillData.SecretAgent.multiplier[0]
        });
        playerCharacter.scripts.SecretAgent = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else if (!variable_struct_exists(arg0.buffs, "SecretAgent"))
                {
                    obj_AttackController.ApplyBuff(arg0, "SecretAgent", ds_map_find_value(obj_AttackController.Buffs, "SecretAgent"));
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: global.SkillData.SecretAgent.cooldown * 60
            }
        };
    }
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "StealthHit", 
    {
        damageMultiplier: global.SkillData.SecretAgent.multiplier[1]
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "StealthHit", 
    {
        damageMultiplier: global.SkillData.SecretAgent.multiplier[2]
    });
}];
ds_map_set(PERKS, "SecretAgent", new Perk("SecretAgent", 
{
    optionName: global.TextContainer.SecretAgentName.selectedLanguage,
    optionIcon: 2442,
    optionDescription: global.TextContainer.SecretAgentDescription.selectedLanguage[0]
}, SecretAgentOnApply));
var CatReflexesOnApply = [function()
{
    playerCharacter.scripts.CatReflexes = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.isMoving)
            {
                var buffConfig = 
                {
                    weight: global.SkillData.CatReflexes.crit[arg1.level]
                };
                obj_AttackController.ApplyBuff(arg0, "CatReflexes", ds_map_find_value(obj_AttackController.Buffs, "CatReflexes"), buffConfig);
            }
            else
            {
                obj_AttackController.RemoveBuff(arg0, "CatReflexes");
            }
            if (variable_struct_exists(arg0.buffs, "Invisible"))
            {
                var buffConfig = 
                {
                    weight: global.SkillData.CatReflexes.crit2,
                    noDisplay: true
                };
                obj_AttackController.ApplyBuff(arg0, "CatReflexes2", ds_map_find_value(obj_AttackController.Buffs, "CatReflexes2"), buffConfig);
            }
            else
            {
                obj_AttackController.RemoveBuff(arg0, "CatReflexes2");
            }
        },
        
        config: 
        {
            level: 0
        }
    };
}, function()
{
    playerCharacter.scripts.CatReflexes.config.level = 1;
    var buffConfig = 
    {
        weight: global.SkillData.CatReflexes.crit[playerCharacter.scripts.CatReflexes.config.level]
    };
    UpdateBuffIfExists("CatReflexes", buffConfig);
}, function()
{
    playerCharacter.scripts.CatReflexes.config.level = 2;
    var buffConfig = 
    {
        weight: global.SkillData.CatReflexes.crit[playerCharacter.scripts.CatReflexes.config.level]
    };
    UpdateBuffIfExists("CatReflexes", buffConfig);
}];
ds_map_set(PERKS, "CatReflexes", new Perk("CatReflexes", 
{
    optionName: global.TextContainer.CatReflexesName.selectedLanguage,
    optionIcon: 102,
    optionDescription: global.TextContainer.CatReflexesDescription.selectedLanguage[0]
}, CatReflexesOnApply));
var DataCollectionOnApply = [function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DataCollection", 
    {
        chance: global.SkillData.DataCollection.chance[0],
        bonusEXP: global.SkillData.DataCollection.bonusEXP[0]
    });
    playerCharacter.scripts.DataCollection = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 8
        }
    };
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DataCollection", 
    {
        chance: global.SkillData.DataCollection.chance[1],
        bonusEXP: global.SkillData.DataCollection.bonusEXP[1]
    });
}, function()
{
    variable_struct_set(playerCharacter.onHitEffects, "DataCollection", 
    {
        chance: global.SkillData.DataCollection.chance[2],
        bonusEXP: global.SkillData.DataCollection.bonusEXP[2]
    });
}];
ds_map_set(PERKS, "DataCollection", new Perk("DataCollection", 
{
    optionName: global.TextContainer.DataCollectionName.selectedLanguage,
    optionIcon: 285,
    optionDescription: global.TextContainer.DataCollectionDescription.selectedLanguage[0]
}, DataCollectionOnApply));
var RainCloudOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "RainCloud"))
    {
        playerCharacter.scripts.RainCloud = 
        {
            Script: function(arg0, arg1)
            {
                var clouds;
                if (arg1.clouds < arg1.maxClouds)
                {
                    obj_AttackController.ExecuteAttack("RainCloud", arg0);
                    arg1.clouds++;
                }
            },
            
            config: 
            {
                maxClouds: global.SkillData.RainCloud.number[0],
                clouds: 0,
                level: 0
            }
        };
    }
}, function()
{
    playerCharacter.scripts.RainCloud.config.maxClouds = global.SkillData.RainCloud.number[1];
    playerCharacter.scripts.RainCloud.config.level = 1;
}, function()
{
    playerCharacter.scripts.RainCloud.config.maxClouds = global.SkillData.RainCloud.number[2];
    playerCharacter.scripts.RainCloud.config.level = 2;
}];
ds_map_set(PERKS, "RainCloud", new Perk("RainCloud", 
{
    optionName: global.TextContainer.RainCloudName.selectedLanguage,
    optionIcon: 1992,
    optionDescription: global.TextContainer.RainCloudDescription.selectedLanguage[0]
}, RainCloudOnApply));
var PraiseOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Praise"))
    {
        playerCharacter.scripts.Praise = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                arg1.maxGauge = max(30, arg0.HP);
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.gauge += max(1, floor(arg0.HP * 0.05));
                    arg1.timer = arg1.maxTimer;
                }
                if (arg1.gauge >= arg1.maxGauge)
                {
                    arg1.gauge = 0;
                    obj_AttackController.ApplyBuff(arg0, "Praise", ds_map_find_value(obj_AttackController.Buffs, "Praise"), 
                    {
                        buffIcon: 2238,
                        weight: global.SkillData.Praise.ATK[arg1.level]
                    });
                }
            },
            
            config: 
            {
                maxGauge: 0,
                gauge: 0,
                level: 0,
                timer: 0,
                maxTimer: 60
            }
        };
    }
    
    playerCharacter.onTakeDamage.Praise = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.invincible)
        {
            return arg0;
        }
        if (arg3.shieldHP > 0)
        {
            return arg0;
        }
        if (arg0 < 1)
        {
            return arg0;
        }
        arg3.scripts.Praise.config.gauge = floor(arg3.scripts.Praise.config.gauge / 2);
        return arg0;
    };
    
    playerCharacter.onHeal.Praise = function(arg0, arg1, arg2)
    {
        arg1.scripts.Praise.config.gauge += arg0;
        return arg0;
    };
    
    customDrawScript.Praise = function(arg0)
    {
        if (!paused && instance_exists(playerCharacter))
        {
            draw_healthbar(33, 308, 79, 312, (playerCharacter.scripts.Praise.config.gauge / playerCharacter.scripts.Praise.config.maxGauge) * 100, c_white, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 1, false, false);
            draw_sprite(spr_KoboPraise, 0, 80, 310);
        }
    };
}, function()
{
    playerCharacter.scripts.Praise.config.level = 1;
    var buffConfig = 
    {
        buffIcon: 2238,
        weight: global.SkillData.Praise.ATK[playerCharacter.scripts.Praise.config.level]
    };
    UpdateBuffIfExists("Praise", buffConfig);
}, function()
{
    playerCharacter.scripts.Praise.config.level = 2;
    var buffConfig = 
    {
        buffIcon: 2238,
        weight: global.SkillData.Praise.ATK[playerCharacter.scripts.Praise.config.level]
    };
    UpdateBuffIfExists("Praise", buffConfig);
}];
ds_map_set(PERKS, "Praise", new Perk("Praise", 
{
    optionName: global.TextContainer.PraiseName.selectedLanguage,
    optionIcon: 2238,
    optionDescription: global.TextContainer.PraiseDescription.selectedLanguage[0]
}, PraiseOnApply));
var TantrumOnApply = [function()
{
    if (!variable_struct_exists(playerCharacter.scripts, "Tantrum"))
    {
        playerCharacter.scripts.Tantrum = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                maxGauge: 10,
                gauge: 0,
                level: 0,
                timer: 0,
                maxTimer: 20
            }
        };
    }
    
    playerCharacter.onTakeDamage.Tantrum = function(arg0, arg1, arg2, arg3)
    {
        if (arg3.scripts.Tantrum.config.gauge < arg3.scripts.Tantrum.config.maxGauge)
        {
            arg3.scripts.Tantrum.config.gauge++;
        }
        var roll = irandom(99);
        if (roll < (arg3.scripts.Tantrum.config.gauge * 3) && arg3.scripts.Tantrum.config.timer == 0)
        {
            arg3.scripts.Tantrum.config.gauge = 0;
            arg3.scripts.Tantrum.config.timer = arg3.scripts.Tantrum.config.maxTimer;
            Heal(arg3, global.SkillData.Tantrum.heal * arg3.HP, 0);
            obj_AttackController.ExecuteAttack("Tantrum", arg3, 
            {
                damage: global.SkillData.Tantrum.damage[arg3.scripts.Tantrum.config.level]
            });
        }
        return arg0;
    };
    
    customDrawScript.Tantrum = function(arg0)
    {
        if (!paused && instance_exists(playerCharacter))
        {
            draw_healthbar(80, 308, 126, 312, (playerCharacter.scripts.Tantrum.config.gauge / playerCharacter.scripts.Tantrum.config.maxGauge) * 100, c_white, c_red, c_red, 0, false, false);
            draw_sprite(spr_KoboTantrum, 0, 80, 310);
        }
    };
}, function()
{
    playerCharacter.scripts.Tantrum.config.level = 1;
}, function()
{
    playerCharacter.scripts.Tantrum.config.level = 2;
}];
ds_map_set(PERKS, "Tantrum", new Perk("Tantrum", 
{
    optionName: global.TextContainer.TantrumName.selectedLanguage,
    optionIcon: 2245,
    optionDescription: global.TextContainer.TantrumDescription.selectedLanguage[0]
}, TantrumOnApply));

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
