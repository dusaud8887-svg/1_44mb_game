function FoodRecipes()
{
    Food = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) constructor
    {
        id = arg0;
        OnApply = arg2;
        optionIcon = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
        optionType = "Food";
        optionName = arg1.optionName;
        optionDescription = variable_struct_exists(arg1, "optionDescription") ? arg1.optionDescription : global.TextContainer.stockTooltip.selectedLanguage;
        optionID = arg0;
        recipe = arg3;
        inventoryNumber = arg5;
        inventoryType = arg6;
        mainIngredient = arg4;
        useNumber = arg7;
        
        function Apply(arg0)
        {
            if (OnApply != undefined)
            {
                self.OnApply(arg0);
            }
        }
    };
    
    global.FOOD = ds_map_create();
    var orderNum = 0;
    var newFood = "tempura";
    var newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    var applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "Tempura", ds_map_find_value(obj_AttackController.Buffs, "Tempura"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 834,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        shrimp: 2,
        wheat: 1
    }, "shrimp", orderNum, "Food", 5));
    orderNum++;
    newFood = "tunasandwich";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "TunaSandwich", ds_map_find_value(obj_AttackController.Buffs, "TunaSandwich"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1601,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        tuna: 2,
        tomato: 1,
        wheat: 1
    }, "tuna", orderNum, "Food", 5));
    orderNum++;
    newFood = "sushiset";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "SushiSet", ds_map_find_value(obj_AttackController.Buffs, "SushiSet"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 180,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        clownfish: 1,
        shrimp: 1,
        tuna: 1,
        rice: 1
    }, "clownfish", orderNum, "Food", 3));
    orderNum++;
    newFood = "pokebowl";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "PokeBowl", ds_map_find_value(obj_AttackController.Buffs, "PokeBowl"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1105,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        koifish: 2,
        tuna: 1,
        shrimp: 1,
        rice: 2
    }, "koifish", orderNum, "Food", 5));
    orderNum++;
    newFood = "lobsterdinner";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "LobsterDinner", ds_map_find_value(obj_AttackController.Buffs, "LobsterDinner"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1517,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        lobster: 1,
        potato: 2,
        wheat: 3,
        greenbeans: 2
    }, "lobster", orderNum, "Food", 3));
    orderNum++;
    newFood = "pufferfishmeal";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "PufferFishMeal", ds_map_find_value(obj_AttackController.Buffs, "PufferFishMeal"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 71,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        pufferfish: 3,
        rice: 2,
        onion: 2,
        radish: 2
    }, "pufferfish", orderNum, "Food", 3));
    orderNum++;
    newFood = "vegetarianburger";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "VegetarianBurger", ds_map_find_value(obj_AttackController.Buffs, "VegetarianBurger"), 
        {
            buffIcon: 1398,
            reapply: true,
            stacks: 10,
            maxStacks: 10,
            loseStackOnRemove: true
        });
        arg0.scripts.VegetarianBurger = 
        {
            Script: function(arg0, arg1)
            {
                var uses;
                if (arg0.isMoving)
                {
                    if (arg0.currentHP <= (arg0.HP * 0.25))
                    {
                        if (arg1.uses > 0)
                        {
                            Heal(arg0, arg0.HP * 0.5, 0, 1, true, false);
                            arg1.uses--;
                            obj_AttackController.RemoveBuff(arg0, "VegetarianBurger");
                        }
                    }
                }
            },
            
            config: 
            {
                uses: 10
            }
        };
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1398,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        wheat: 4,
        potato: 2,
        onion: 2
    }, "wheat", orderNum, "Food", 5));
    orderNum++;
    newFood = "turtlesoup";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        var getItem = ds_map_find_value(obj_PlayerManager.ITEMS, "StudyGlasses");
        if (!is_undefined(getItem))
        {
            getItem.weight *= 10;
        }
        getItem = ds_map_find_value(obj_PlayerManager.ITEMS, "LabCoat");
        if (!is_undefined(getItem))
        {
            getItem.weight *= 10;
        }
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1078,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        turtle: 2,
        potato: 2,
        carrot: 2,
        onion: 2,
        peppers: 1
    }, "turtle", orderNum, "Food", 3));
    orderNum++;
    newFood = "unagidon";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "UnagiDon", ds_map_find_value(obj_AttackController.Buffs, "UnagiDon"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 802,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        eel: 2,
        rice: 4
    }, "eel", orderNum, "Food", 5));
    orderNum++;
    newFood = "calamariset";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "CalamariSet", ds_map_find_value(obj_AttackController.Buffs, "CalamariSet"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1154,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        squid: 2,
        radish: 2,
        peppers: 2,
        wheat: 5
    }, "squid", orderNum, "Food", 5));
    orderNum++;
    newFood = "mantaraysoup";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        global.lives++;
        obj_PlayerManager.livesGained++;
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 2186,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        mantaray: 2,
        shrimp: 1,
        carrot: 2,
        peppers: 1,
        corn: 1
    }, "mantaray", orderNum, "Food", 3));
    orderNum++;
    newFood = "fruitsandwich";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        obj_AttackController.ApplyBuff(arg0, "FruitSandwich", ds_map_find_value(obj_AttackController.Buffs, "FruitSandwich"), 
        {
            noDisplay: true
        });
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1429,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        strawberry: 5,
        wheat: 3
    }, "strawberry", orderNum, "Food", 5));
    orderNum++;
    newFood = "burgermeal";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        global.fruitFoodBuff = 2;
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 300,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        wheat: 2,
        tomato: 2,
        onion: 2
    }, "wheat", orderNum, "Food", 5));
    orderNum++;
    newFood = "strangeseafoodsoup";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        var getItem = ds_map_find_value(obj_PlayerManager.ITEMS, "Halu");
        if (!is_undefined(getItem))
        {
            getItem.weight *= 10;
        }
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 2139,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        squid: 2,
        turtle: 2,
        radish: 2,
        garlic: 2,
        corn: 2
    }, "squid", orderNum, "Food", 3));
    orderNum++;
    newFood = "vegetablesoup";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        arg0.scripts.VegetableSoup = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer == 0)
                {
                    arg1.timer = arg1.maxTimer;
                    arg0.invincibilityTimer += 300;
                    arg0.invincible = true;
                    audio_play_sound(snd_friendzone, 0, 0);
                    obj_AttackController.ApplyBuff(arg0, "VegetableSoup", ds_map_find_value(obj_AttackController.Buffs, "VegetableSoup"), 
                    {
                        buffIcon: 578
                    });
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 1800,
                maxTimer: 1800
            }
        };
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 578,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        corn: 5,
        peppers: 3,
        carrot: 2,
        onion: 2,
        tomato: 3
    }, "corn", orderNum, "Food", 3));
    orderNum++;
    newFood = "bbqsquid";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        arg0.onTakeDamage.BBQSquid = function(arg0, arg1, arg2, arg3)
        {
            if (variable_instance_exists(arg1, "creator"))
            {
                if (arg1.creator.isEnemy)
                {
                    arg0 *= 0.66;
                }
            }
            return arg0;
        };
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1616,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        squid: 5,
        onion: 5,
        radish: 3,
        potato: 3,
        garlic: 2
    }, "squid", orderNum, "Food", 3));
    orderNum++;
    newFood = "spicyudon";
    newFoodToolTip = variable_struct_get(global.TextContainer, "d_" + newFood);
    
    applyFunction = function(arg0)
    {
        arg0.onTakeDamage.SpicyUdon = function(arg0, arg1, arg2, arg3)
        {
            if (arg3.scripts.SpicyUdon.config.timer == 0 && variable_instance_exists(arg3, "specialMeter") && !arg3.invincible && arg0 > 0)
            {
                var specGain = floor(arg3.specCD * (arg3.specMod - (arg3.specCDR / 100))) * 0.02;
                arg3.specialMeter += specGain;
                arg3.scripts.SpicyUdon.config.timer = arg3.scripts.SpicyUdon.config.maxTimer;
            }
            return arg0;
        };
        
        arg0.scripts.SpicyUdon = 
        {
            Script: function(arg0, arg1)
            {
                if (arg0.scripts.SpicyUdon.config.timer > 0)
                {
                    arg0.scripts.SpicyUdon.config.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 14
            }
        };
    };
    
    ds_map_set(global.FOOD, newFood, new Food(newFood, 
    {
        optionIcon: 1191,
        optionName: newFoodToolTip.selectedLanguage[0],
        optionDescription: newFoodToolTip.selectedLanguage[1]
    }, applyFunction, 
    {
        squid: 5,
        wheat: 5,
        shrimp: 3,
        greenbeans: 3,
        garlic: 2
    }, "squid", orderNum, "Food", 5));
    orderNum++;
}
