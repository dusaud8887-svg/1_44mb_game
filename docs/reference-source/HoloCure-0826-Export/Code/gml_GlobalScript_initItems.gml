function initItems()
{
    ITEMS = ds_map_create();
    
    Item = function(arg0, arg1, arg2 = 5, arg3, arg4) constructor
    {
        id = arg0;
        level = -1;
        maxLevel = arg2;
        OnApply = arg3;
        OnRemove = arg4;
        name = arg1.optionName;
        optionIcon = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
        optionType = "Item";
        optionName = arg1.optionName;
        alloptionDescription = variable_struct_exists(arg1, "optionDescription") ? arg1.optionDescription : global.TextContainer.stockTooltip.selectedLanguage;
        optionDescription = is_array(alloptionDescription) ? alloptionDescription[0] : arg1.optionDescription;
        optionID = arg0;
        itemType = arg1.itemType;
        weight = variable_struct_exists(arg1, "weight") ? arg1.weight : 1;
        
        function Apply()
        {
            if (OnApply != undefined)
            {
                if (typeof(OnApply) == "array")
                {
                    self.OnApply[level]();
                }
                else
                {
                    self.OnApply();
                }
            }
        }
        
        function Remove()
        {
            if (OnRemove != undefined)
            {
                if (typeof(OnRemove) == "array")
                {
                    self.OnRemove[level]();
                }
                else
                {
                    self.OnRemove();
                }
            }
        }
        
        function LevelUp()
        {
            if (level >= (maxLevel - 1))
            {
                show_debug_message("ERROR, TRYING TO LEVEL ITEM " + name + " BEYOND MAX LEVEL: " + string(maxLevel));
                exit;
            }
            level++;
            optionName = name + " LV " + string(level + 2);
        }
    };
    
    SuccubusHorn = [function()
    {
        playerCharacter.onKill.SuccubusHorn = function(arg0, arg1)
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
        playerCharacter.onKill.SuccubusHorn = function(arg0, arg1)
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
        playerCharacter.onKill.SuccubusHorn = function(arg0, arg1)
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
        optionName: global.TextContainer.SuccubusHornName.selectedLanguage,
        optionDescription: global.TextContainer.SuccubusHornDescription.selectedLanguage[0],
        itemType: "Healing",
        weight: 3
    }, 3, SuccubusHorn, SuccubusHornRemove));
    
    function _ApplyExtraLifeIfAvailable()
    {
        if (global.lives > 1)
        {
            playerCharacter.Die = function()
            {
                OnDeath(self, -1);
                if (variable_struct_exists(scripts, "Plushie"))
                {
                    scripts.Plushie.config.damageDebt = 0;
                }
                if (stopDeath)
                {
                    stopDeath = false;
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
                with (obj_Enemy)
                {
                    if (!miniboss && !isBoss)
                    {
                        Die();
                    }
                }
                global.lives--;
                if (global.lives == 1)
                {
                    playerCharacter.Die = function()
                    {
                        with (playerCharacter)
                        {
                            if (isAlive)
                            {
                                OnDeath(self, -1);
                                if (variable_struct_exists(scripts, "Plushie"))
                                {
                                    scripts.Plushie.config.damageDebt = 0;
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
    
    ChickensFeather = [function()
    {
        if (!variable_instance_exists(227, "chickensFeatherApplied"))
        {
            obj_Player.chickensFeatherApplied = 1;
            global.lives++;
        }
        _ApplyExtraLifeIfAvailable();
    }, function()
    {
        if (obj_Player.chickensFeatherApplied == 1)
        {
            obj_Player.chickensFeatherApplied = 2;
            global.lives++;
        }
        _ApplyExtraLifeIfAvailable();
    }, function()
    {
        if (obj_Player.chickensFeatherApplied == 2)
        {
            obj_Player.chickensFeatherApplied = -1;
            global.lives++;
        }
        _ApplyExtraLifeIfAvailable();
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
        optionName: global.TextContainer.ChickensFeatherName.selectedLanguage,
        optionDescription: global.TextContainer.ChickensFeatherDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 3,
        weight: 2
    }, 3, ChickensFeather, ChickensFeatherRemove));
    StudyGlasses = [function()
    {
        playerCharacter.expMultiplier = 1.1;
    }, function()
    {
        playerCharacter.expMultiplier = 1.15;
    }, function()
    {
        playerCharacter.expMultiplier = 1.2;
    }, function()
    {
        playerCharacter.expMultiplier = 1.25;
    }, function()
    {
        playerCharacter.expMultiplier = 1.3;
    }, function()
    {
        playerCharacter.expMultiplier = 1.4;
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
        optionDescription: global.TextContainer.StudyGlassesDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 5,
        weight: 3
    }, 5, StudyGlasses, StudyGlassesRemove, true));
    BodyPillow = [function()
    {
        playerCharacter.DR *= 0.95;
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
        playerCharacter.shieldHP = playerCharacter.scripts.BodyPillow.config.shieldHP;
    }, function()
    {
        playerCharacter.DR *= 0.9;
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
                shieldHP: 20
            }
        };
        playerCharacter.shieldHP = playerCharacter.scripts.BodyPillow.config.shieldHP;
    }, function()
    {
        playerCharacter.DR *= 0.85;
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
                shieldHP: 25
            }
        };
        playerCharacter.shieldHP = playerCharacter.scripts.BodyPillow.config.shieldHP;
    }, function()
    {
        playerCharacter.DR *= 0.8;
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
                shieldHP: 30
            }
        };
        playerCharacter.shieldHP = playerCharacter.scripts.BodyPillow.config.shieldHP;
    }, function()
    {
        playerCharacter.DR *= 0.75;
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
                shieldHP: 35
            }
        };
        playerCharacter.shieldHP = playerCharacter.scripts.BodyPillow.config.shieldHP;
    }, function()
    {
        playerCharacter.DR *= 0.7;
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
        playerCharacter.shieldHP = playerCharacter.scripts.BodyPillow.config.shieldHP;
    }];
    
    BodyPillowRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "BodyPillow", new Item("BodyPillow", 
    {
        optionIcon: 1891,
        optionIcon_Super: 853,
        optionName: global.TextContainer.BodyPillowName.selectedLanguage,
        optionDescription: global.TextContainer.BodyPillowDescription.selectedLanguage[0],
        itemType: "Utility",
        weight: 3
    }, 5, BodyPillow, BodyPillowRemove, true));
    HolyMilk = [function()
    {
        playerCharacter.weaponSizeMultiplier += 0.1;
        playerCharacter.pickupRange += 30;
    }, function()
    {
        playerCharacter.weaponSizeMultiplier += 0.15;
        playerCharacter.pickupRange += 40;
    }, function()
    {
        playerCharacter.weaponSizeMultiplier += 0.2;
        playerCharacter.pickupRange += 50;
    }, function()
    {
        playerCharacter.weaponSizeMultiplier += 0.3;
        playerCharacter.pickupRange += 100;
        if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
        {
            playerCharacter.HP += 20;
        }
    }];
    
    HolyMilkRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "HolyMilk", new Item("HolyMilk", 
    {
        optionIcon: 189,
        optionIcon_Super: 449,
        optionName: global.TextContainer.HolyMilkName.selectedLanguage,
        optionDescription: global.TextContainer.HolyMilkDescription.selectedLanguage[0],
        itemType: "Stat",
        weight: 1
    }, 3, HolyMilk, HolyMilkRemove, true));
    PikiPikiPiman = [function()
    {
        playerCharacter.scripts.PikiPikiPiman = 
        {
            Script: function(arg0, arg1)
            {
                if (arg0.scripts.PikiPikiPiman.config.timer > 0)
                {
                    arg0.scripts.PikiPikiPiman.config.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 12
            }
        };
        
        playerCharacter.onTakeDamage.PikiPikiPiman = function(arg0, arg1, arg2, arg3)
        {
            if (arg3.scripts.PikiPikiPiman.config.timer == 0 && variable_instance_exists(arg3, "specialMeter") && !arg3.invincible && arg0 > 0)
            {
                var specGain = floor(arg3.specCD * (arg3.specMod - (arg3.specCDR / 100))) * 0.02;
                arg3.specialMeter += specGain;
                arg3.scripts.PikiPikiPiman.config.timer = arg3.scripts.PikiPikiPiman.config.maxTimer;
            }
            return arg0;
        };
    }, function()
    {
        playerCharacter.onTakeDamage.PikiPikiPiman = function(arg0, arg1, arg2, arg3)
        {
            if (arg3.scripts.PikiPikiPiman.config.timer == 0 && variable_instance_exists(arg3, "specialMeter") && !arg3.invincible && arg0 > 0)
            {
                var specGain = floor(arg3.specCD * (arg3.specMod - (arg3.specCDR / 100))) * 0.03;
                arg3.specialMeter += specGain;
                arg3.scripts.PikiPikiPiman.config.timer = arg3.scripts.PikiPikiPiman.config.maxTimer;
            }
            return arg0;
        };
    }, function()
    {
        playerCharacter.onTakeDamage.PikiPikiPiman = function(arg0, arg1, arg2, arg3)
        {
            if (arg3.scripts.PikiPikiPiman.config.timer == 0 && variable_instance_exists(arg3, "specialMeter") && !arg3.invincible && arg0 > 0)
            {
                var specGain = floor(arg3.specCD * (arg3.specMod - (arg3.specCDR / 100))) * 0.04;
                arg3.specialMeter += specGain;
                arg3.scripts.PikiPikiPiman.config.timer = arg3.scripts.PikiPikiPiman.config.maxTimer;
            }
            return arg0;
        };
    }];
    
    PikiPikiPimanRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "PikiPikiPiman", new Item("PikiPikiPiman", 
    {
        optionIcon: 1551,
        optionName: global.TextContainer.PikiPikiPimanName.selectedLanguage,
        optionDescription: global.TextContainer.PikiPikiPimanDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 3,
        weight: 4
    }, 3, PikiPikiPiman, PikiPikiPimanRemove));
    Sake = [function()
    {
        var buffConfig = 
        {
            weight: 10
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
                    weight: 10
                };
                if (arg1.timer >= arg1.maxTimer)
                {
                    obj_AttackController.ApplyBuff(arg0, "Sake", ds_map_find_value(obj_AttackController.Buffs, "Sake"), buffConfig);
                }
                else
                {
                    arg1.timer++;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 300,
                weight: 10
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
            obj_AttackController.RemoveBuff(arg3, "Sake");
            arg3.scripts.Sake.config.timer = 0;
            return arg0;
        };
        
        UpdateBuffIfExists("Sake", buffConfig);
        UpdateBuffIfExists("Sake2", buffConfig);
    }, function()
    {
        var buffConfig = 
        {
            weight: 15
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
                    weight: 15
                };
                if (arg1.timer >= arg1.maxTimer)
                {
                    obj_AttackController.ApplyBuff(arg0, "Sake", ds_map_find_value(obj_AttackController.Buffs, "Sake"), buffConfig);
                }
                else
                {
                    arg1.timer++;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 300,
                weight: 10
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
            obj_AttackController.RemoveBuff(arg3, "Sake");
            arg3.scripts.Sake.config.timer = 0;
            return arg0;
        };
        
        UpdateBuffIfExists("Sake", buffConfig);
        UpdateBuffIfExists("Sake2", buffConfig2);
    }, function()
    {
        var buffConfig = 
        {
            weight: 20
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
                    weight: 20
                };
                if (arg1.timer >= arg1.maxTimer)
                {
                    obj_AttackController.ApplyBuff(arg0, "Sake", ds_map_find_value(obj_AttackController.Buffs, "Sake"), buffConfig);
                }
                else
                {
                    arg1.timer++;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 300,
                weight: 10
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
            obj_AttackController.RemoveBuff(arg3, "Sake");
            arg3.scripts.Sake.config.timer = 0;
            return arg0;
        };
        
        UpdateBuffIfExists("Sake", buffConfig);
        UpdateBuffIfExists("Sake2", buffConfig);
    }];
    
    SakeRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "Sake", new Item("Sake", 
    {
        optionIcon: 1873,
        optionName: global.TextContainer.SakeName.selectedLanguage,
        optionDescription: global.TextContainer.SakeDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 3,
        weight: 4
    }, 3, Sake, SakeRemove));
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
        optionDescription: global.TextContainer.FullMealDescription.selectedLanguage[0],
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
        optionDescription: global.TextContainer.UberSheepDescription.selectedLanguage[0],
        itemType: "Healing",
        weight: 4
    }, 5, UberSheep, UberSheepRemove));
    InjectionScript = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 1)
            {
            }
            else
            {
            }
            if (arg0.currentHP > 1 && arg1.timer <= 0)
            {
                var minDam = max(2, floor(arg0.HP * 0.05));
                if ((arg0.currentHP - minDam) <= 0)
                {
                    minDam = arg0.currentHP - 1;
                }
                minDam = minDam * global.negativeEffects;
                if (minDam > 0)
                {
                    arg0.ApplyDamage(minDam, undefined, false, false);
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
        playerCharacter.ATK += 0.4;
        playerCharacter.scripts.InjectionAsacoco = InjectionScript;
    }, function()
    {
        playerCharacter.ATK += 0.6;
        playerCharacter.scripts.InjectionAsacoco = InjectionScript;
    }, function()
    {
        playerCharacter.ATK += 0.8;
        playerCharacter.scripts.InjectionAsacoco = InjectionScript;
    }];
    
    InjectionAsacocoRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "InjectionAsacoco", new Item("InjectionAsacoco", 
    {
        optionIcon: 658,
        optionName: global.TextContainer.InjectionAsacocoName.selectedLanguage,
        optionDescription: global.TextContainer.InjectionAsacocoDescription.selectedLanguage[0],
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
    }];
    
    HeadphonesRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "Headphones", new Item("Headphones", 
    {
        optionIcon: 1588,
        optionName: global.TextContainer.HeadphonesName.selectedLanguage,
        optionDescription: global.TextContainer.HeadphonesDescription.selectedLanguage[0],
        itemType: "Utility",
        weight: 4
    }, 5, Headphones, HeadphonesRemove));
    FaceMask = [function()
    {
        playerCharacter.BonusDamageTaken += 30 * global.negativeEffects;
        playerCharacter.DB += 0.3;
        playerCharacter.haste += 10;
    }];
    
    FaceMaskRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "FaceMask", new Item("FaceMask", 
    {
        optionIcon: 1047,
        optionName: global.TextContainer.FaceMaskName.selectedLanguage,
        optionDescription: global.TextContainer.FaceMaskDescription.selectedLanguage[0],
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
        optionDescription: global.TextContainer.GorillasPawDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 3,
        weight: 3
    }, 3, GorillasPaw, GorillasPawRemove, true));
    EnergyDrink = [function()
    {
        playerCharacter.haste += 10;
        playerCharacter.SPD += 0.3;
        playerCharacter.HP = max(1, playerCharacter.HP * (1 - (0.2 * global.negativeEffects)));
    }, function()
    {
        playerCharacter.haste += 15;
        playerCharacter.SPD += 0.4;
        playerCharacter.HP = max(1, playerCharacter.HP * (1 - (0.2 * global.negativeEffects)));
    }, function()
    {
        playerCharacter.haste += 20;
        playerCharacter.SPD += 0.5;
        playerCharacter.HP = max(1, playerCharacter.HP * (1 - (0.2 * global.negativeEffects)));
    }, function()
    {
        playerCharacter.haste += 30;
        playerCharacter.SPD += 0.6;
    }];
    
    EnergyDrinkRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "EnergyDrink", new Item("EnergyDrink", 
    {
        optionIcon: 596,
        optionIcon_Super: 2471,
        optionName: global.TextContainer.EnergyDrinkName.selectedLanguage,
        optionDescription: global.TextContainer.EnergyDrinkDescription.selectedLanguage[0],
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
                        arg0.ApplyDamage(hurt, undefined, false, false);
                        arg1.damageDebt -= hurt;
                        arg1.timer = arg1.maxTimer;
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
        optionDescription: global.TextContainer.PlushieDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 3,
        weight: 4
    }, 3, Plushie, PlushieRemove));
    SuperChattoTime = [function()
    {
        global.coinAutoPick = true;
        global.moneyMultiplier = 1.2;
    }, function()
    {
        global.coinAutoPick = true;
        global.moneyMultiplier = 1.4;
    }, function()
    {
        global.coinAutoPick = true;
        global.moneyMultiplier = 1.6;
    }, function()
    {
        global.coinAutoPick = true;
        global.moneyMultiplier = 1.8;
    }, function()
    {
        global.coinAutoPick = true;
        global.moneyMultiplier = 2;
    }, function()
    {
        global.coinAutoPick = true;
        global.moneyMultiplier = 2.5;
        global.moneyHeal = true;
    }];
    
    SuperChattoTimeRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "SuperChattoTime", new Item("SuperChattoTime", 
    {
        optionIcon: 2127,
        optionIcon_Super: 1918,
        optionName: global.TextContainer.SuperChattoTimeName.selectedLanguage,
        optionDescription: global.TextContainer.SuperChattoTimeDescription.selectedLanguage[0],
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
        optionDescription: global.TextContainer.IdolCostumeDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 5,
        weight: 1
    }, 5, IdolCostume, IdolCostumeRemove, true));
    CreditCard = [function()
    {
        global.anvilDropChanceBuff = 0.18;
        global.enhanceCostMultiplier = 0.8;
    }, function()
    {
        global.anvilDropChanceBuff = 0.28;
        global.enhanceCostMultiplier = 0.75;
    }, function()
    {
        global.anvilDropChanceBuff = 0.38;
        global.enhanceCostMultiplier = 0.7;
    }, function()
    {
        global.anvilDropChanceBuff = 0.45;
        global.enhanceCostMultiplier = 0.65;
    }, function()
    {
        global.anvilDropChanceBuff = 0.5;
        global.enhanceCostMultiplier = 0.6;
    }];
    
    CreditCardRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "CreditCard", new Item("CreditCard", 
    {
        optionIcon: 2370,
        optionName: global.TextContainer.CreditCardName.selectedLanguage,
        optionDescription: global.TextContainer.CreditCardDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 5,
        weight: 4
    }, 5, CreditCard, CreditCardRemove));
    Bandaid = [function()
    {
        if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
        {
            playerCharacter.HP += 10;
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
                    if (arg0.scripts.Bandaid.config.timer == 0 && arg0.currentHP > 0)
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
            playerCharacter.HP += 20;
        }
        playerCharacter.scripts.Bandaid.config.damageAbsorb = 0.9;
        playerCharacter.scripts.Bandaid.config.healAmount = 0.1;
    }, function()
    {
        if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
        {
            playerCharacter.HP += 30;
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
        optionDescription: global.TextContainer.BandaidDescription.selectedLanguage[0],
        itemType: "Healing",
        maxLevel: 3,
        weight: 4
    }, 3, Bandaid, BandaidRemove));
    
    function MembershipStepBuffApply(arg0, arg1)
    {
        if (global.currentRunMoneyGained > 0)
        {
            obj_AttackController.ApplyBuff(arg0, "Membership", ds_map_find_value(obj_AttackController.Buffs, "Membership"), {});
            arg0.ATK += arg0.scripts.Membership.config.weight1;
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
        optionDescription: global.TextContainer.MembershipDescription.selectedLanguage[0],
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
                weight: 15
            }
        };
    }, function()
    {
        playerCharacter.stepBuffs.GWSPill = 
        {
            Apply: GWSPillStepBuffApply,
            config: 
            {
                weight: 20
            }
        };
    }, function()
    {
        playerCharacter.stepBuffs.GWSPill = 
        {
            Apply: GWSPillStepBuffApply,
            config: 
            {
                weight: 25
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
        optionDescription: global.TextContainer.GWSPillDescription.selectedLanguage[0],
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
        optionDescription: global.TextContainer.HaluDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 5,
        weight: 3
    }, 5, Halu, HaluRemove));
    Limiter = [function()
    {
        playerCharacter.pickupRange += 100;
    }, function()
    {
        playerCharacter.pickupRange += 200;
    }, function()
    {
        playerCharacter.pickupRange += 300;
    }];
    
    LimiterRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "Limiter", new Item("Limiter", 
    {
        optionIcon: 893,
        optionName: global.TextContainer.LimiterName.selectedLanguage,
        optionDescription: global.TextContainer.LimiterDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 3,
        weight: 4
    }, 3, Limiter, LimiterRemove));
    PiggyBank = [function()
    {
        playerCharacter.SPD += 0.15;
        playerCharacter.pickupRange -= 50 * global.negativeEffects;
        playerCharacter.scripts.PiggyBank = 
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
                    global.currentRunMoneyGained += ((1 + arg0.moneyGain) * global.stageCoinBonus);
                    arg1.timer = arg1.maxTimer;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 60
            }
        };
    }];
    
    PiggyBankRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "PiggyBank", new Item("PiggyBank", 
    {
        optionIcon: 1478,
        optionName: global.TextContainer.PiggyBankName.selectedLanguage,
        optionDescription: global.TextContainer.PiggyBankDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 1,
        weight: 2
    }, 1, PiggyBank, PiggyBankRemove));
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
    }];
    
    HopeSodaRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "HopeSoda", new Item("HopeSoda", 
    {
        optionIcon: 207,
        optionName: global.TextContainer.HopeSodaName.selectedLanguage,
        optionDescription: global.TextContainer.HopeSodaDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 3,
        weight: 2
    }, 5, HopeSoda, HopeSodaRemove));
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
        optionDescription: global.TextContainer.BlacksmithsGearDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 3,
        weight: 1
    }, 3, BlacksmithsGear, BlacksmithsGearRemove));
    Shacklesss = [function()
    {
        global.negativeEffects = 0.8;
    }, function()
    {
        global.negativeEffects = 0.6;
    }, function()
    {
        global.negativeEffects = 0.4;
    }, function()
    {
        global.negativeEffects = 0.2;
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
        optionDescription: global.TextContainer.ShacklesssDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 3,
        weight: 1
    }, 5, Shacklesss, ShacklesssRemove));
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
                range: 150,
                circleTime: 0
            }
        };
        
        playerCharacter.customDrawScriptAbove.DevilHat = function(arg0)
        {
            arg0.scripts.DevilHat.config.circleTime += 0.5;
            if (arg0.scripts.DevilHat.config.circleTime >= (arg0.scripts.DevilHat.config.range / 1.5))
            {
                arg0.scripts.DevilHat.config.circleTime = 0;
            }
            draw_set_color(make_color_rgb(210, 100, 255));
            draw_circle(arg0.x, arg0.y - 16, arg0.scripts.DevilHat.config.range, true);
        };
    }, function()
    {
        variable_struct_set(playerCharacter.onHitEffects, "DevilHat", 
        {
            damageMultiplier: 1.35
        });
    }, function()
    {
        variable_struct_set(playerCharacter.onHitEffects, "DevilHat", 
        {
            damageMultiplier: 1.5
        });
    }];
    
    DevilHatRemove = function()
    {
    };
    
    ds_map_set(ITEMS, "DevilHat", new Item("DevilHat", 
    {
        optionIcon: 987,
        optionName: global.TextContainer.DevilHatName.selectedLanguage,
        optionDescription: global.TextContainer.DevilHatDescription.selectedLanguage[0],
        itemType: "Stat",
        maxLevel: 5,
        weight: 2
    }, 3, DevilHat, DevilHatRemove));
    Breastplate = [function()
    {
        playerCharacter.DR *= 0.9;
        playerCharacter.SPD -= 0.2 * global.negativeEffects;
        
        playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
        {
            var roll = irandom(99);
            if (roll < 30)
            {
                audio_play_sound(snd_attackreflect, 10, 0);
                var totalDam = 1.5;
                var attacker = 0;
                if (variable_instance_exists(arg1, "creator"))
                {
                    attacker = arg1.creator;
                }
                else
                {
                    attacker = arg1;
                }
                var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
                {
                    damage: totalDam
                });
                attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1]);
            }
            return arg0;
        };
    }, function()
    {
        playerCharacter.DR *= 0.85;
        playerCharacter.SPD -= 0.2 * global.negativeEffects;
        
        playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
        {
            var roll = irandom(99);
            if (roll < 40)
            {
                audio_play_sound(snd_attackreflect, 10, 0);
                var totalDam = 2;
                var attacker = 0;
                if (variable_instance_exists(arg1, "creator"))
                {
                    attacker = arg1.creator;
                }
                else
                {
                    attacker = arg1;
                }
                var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
                {
                    damage: totalDam
                });
                attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1]);
            }
            return arg0;
        };
    }, function()
    {
        playerCharacter.DR *= 0.8;
        playerCharacter.SPD -= 0.2 * global.negativeEffects;
        
        playerCharacter.onTakeDamage.Breastplate = function(arg0, arg1, arg2, arg3)
        {
            var roll = irandom(99);
            if (roll < 50)
            {
                audio_play_sound(snd_attackreflect, 10, 0);
                var totalDam = 2.5;
                var attacker = 0;
                if (variable_instance_exists(arg1, "creator"))
                {
                    attacker = arg1.creator;
                }
                else
                {
                    attacker = arg1;
                }
                var dmgObj = obj_AttackController.CalculateDamage(attacker, arg3, 
                {
                    damage: totalDam
                });
                attacker.TakeDamage(dmgObj[0], arg3, dmgObj[1]);
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
        optionName: global.TextContainer.BreastplateName.selectedLanguage,
        optionDescription: global.TextContainer.BreastplateDescription.selectedLanguage[0],
        itemType: "Utility",
        maxLevel: 3,
        weight: 2
    }, 3, Breastplate, BreastplateRemove));
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
            multiplier: 1.1
        });
    }, function()
    {
        playerCharacter.SPD += 0.4 * global.positiveEffects;
        variable_struct_set(playerCharacter.onHitEffects, "NinjaHeadband", 
        {
            multiplier: 1.2
        });
    }, function()
    {
        playerCharacter.SPD += 0.6 * global.positiveEffects;
        variable_struct_set(playerCharacter.onHitEffects, "NinjaHeadband", 
        {
            multiplier: 1.3
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
        itemType: "Stat",
        maxLevel: 3,
        weight: 2
    }, 3, FocusShades, FocusShadesRemove));
    LabCoat = [function()
    {
        global.moneyMultiplier -= 0.25;
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
                    global.experience += (obj_PlayerManager.toNextLevel * arg1.expRate * (arg0.expMultiplier + arg0.EXP));
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
        global.moneyMultiplier -= 0.25;
        playerCharacter.scripts.LabCoat.config.maxRate = 0.03;
    }, function()
    {
        global.moneyMultiplier -= 0.25;
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
        itemType: "Stat",
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
    if (variable_global_exists("itemsLibrary"))
    {
        ds_map_destroy(global.itemsLibrary);
        global.itemsLibrary = -1;
    }
    global.itemsLibrary = ds_map_create();
    ds_map_copy(global.itemsLibrary, ITEMS);
    ds_map_destroy(ITEMS);
    ITEMS = -1;
}
