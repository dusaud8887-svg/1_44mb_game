if (!variable_global_exists("StatusEffects"))
{
    StatusEffects = ds_map_create();
    global.StatusEffects = StatusEffects;
}
else
{
    ds_map_destroy(global.StatusEffects);
    global.StatusEffects = -1;
    StatusEffects = ds_map_create();
    global.StatusEffects = StatusEffects;
}

function PerformTick(arg0, arg1, arg2)
{
    var duration, timer;
    if (arg1.timer <= 0)
    {
        ds_map_find_value(StatusEffects, arg2)(arg0, arg1, arg2);
        arg1.timer = arg1.resetTimer;
        arg1.duration--;
    }
    else
    {
        arg1.timer--;
    }
    if (arg1.duration == 0)
    {
        variable_struct_remove(arg0.hasStatusEffects, arg2);
    }
}

ds_map_set(StatusEffects, "TESTBLEED", function(arg0, arg1, arg2)
{
    var damage = arg1.damage;
    arg0.TakeDamage(damage);
});
if (!variable_global_exists("OnHitEffects"))
{
    OnHitEffects = ds_map_create();
    global.OnHitEffects = OnHitEffects;
}
else
{
    ds_map_destroy(global.OnHitEffects);
    global.OnHitEffects = -1;
    OnHitEffects = ds_map_create();
    global.OnHitEffects = OnHitEffects;
}
ds_map_set(OnHitEffects, "INSTADEATH", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg3, "isBoss") && !arg3.isBoss && !arg3.miniboss)
    {
        if (variable_struct_exists(arg4, "chance"))
        {
            var roll = irandom(100);
            if (arg4.chance > roll)
            {
                arg3.Die(false, true, arg1);
                if (global.showDamageText && instance_number(obj_damageText) < 100)
                {
                    var hit = instance_create_depth(arg3.x, arg3.y - 30, arg3.depth - 1, obj_damageText);
                    hit.critted = false;
                    hit.damageValue = "KO!";
                    if (!is_undefined(arg1) && instance_exists(arg1))
                    {
                        if (variable_instance_exists(arg1, "CritMod"))
                        {
                            hit.CritMod = arg1.CritMod;
                        }
                    }
                    hit.hspeed = 0;
                    hit.vspeed = -2;
                }
            }
        }
        else
        {
            arg3.Die(false, true, arg1);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DeathExplod", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        if (arg0 >= arg3.currentHP)
        {
            ExecuteAttack("CalliDeath", arg1.creator, 
            {
                damage: arg4.damage,
                x: arg3.x,
                y: arg3.y - 20,
                image_xscale: arg4.size,
                image_yscale: arg4.size,
                onHitEffects: 
                {
                    DeathExplod: 
                    {
                        chance: arg4.chance,
                        deathChance: arg4.deathChance,
                        damage: arg4.damage,
                        size: arg4.size
                    },
                    Death: 
                    {
                        chance: arg4.deathChance,
                        heal: 0
                    }
                }
            });
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Death", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!arg3.isBoss && !arg3.miniboss)
    {
        var roll = irandom(99);
        if (roll < arg4.chance)
        {
            arg3.Die(false, true, arg1);
            if (variable_struct_exists(obj_PlayerManager.perks, "Workaholic"))
            {
                var buffConfig = 
                {
                    reapply: true,
                    stacks: 1,
                    maxStacks: 20,
                    weight: 0.02,
                    buffSpeed: false
                };
                if (obj_PlayerManager.perks.Workaholic.level == 1)
                {
                    buffConfig.weight = 0.02;
                }
                else if (obj_PlayerManager.perks.Workaholic.level == 2)
                {
                    buffConfig.weight = 0.03;
                }
                else
                {
                    buffConfig.weight = 0.04;
                    buffConfig.buffSpeed = true;
                }
                ApplyBuff(arg1.creator, "Workaholic", ds_map_find_value(Buffs, "Workaholic"), buffConfig);
            }
            if (variable_struct_exists(ds_map_find_value(attackIndex, "CalliSlash1").config.onHitEffects, "DeathExplod"))
            {
                var explodConfig = ds_map_find_value(attackIndex, "CalliSlash1").config.onHitEffects.DeathExplod;
                roll = irandom(99);
                if (roll < explodConfig.chance)
                {
                    ExecuteAttack("CalliDeath", arg1.creator, 
                    {
                        damage: explodConfig.damage,
                        x: arg3.x,
                        y: arg3.y - 20,
                        image_xscale: explodConfig.size,
                        image_yscale: explodConfig.size,
                        onHitEffects: 
                        {
                            DeathExplod: 
                            {
                                chance: explodConfig.chance,
                                deathChance: explodConfig.deathChance,
                                damage: explodConfig.damage,
                                size: explodConfig.size
                            },
                            Death: 
                            {
                                chance: explodConfig.deathChance,
                                heal: 0
                            }
                        }
                    });
                }
            }
            if (global.showDamageText && instance_number(obj_damageText) < 100)
            {
                var hit = instance_create_depth(arg3.x, arg3.y - 30, arg3.depth - 1, obj_damageText);
                hit.critted = false;
                hit.damageValue = "KO!";
                if (!is_undefined(arg1) && instance_exists(arg1))
                {
                    if (variable_instance_exists(arg1, "CritMod"))
                    {
                        hit.CritMod = arg1.CritMod;
                    }
                }
                hit.hspeed = 0;
                hit.vspeed = -2;
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "SlashBurn", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_struct_exists(arg1.creator.scripts, "KiaraSlash"))
    {
        if (arg1.creator.scripts.KiaraSlash.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll < arg4.chance)
            {
                ExecuteAttack("Trailblazer", arg1.creator, 
                {
                    x: (arg3.x - 5) + random(10),
                    y: ((arg3.y - 5) + random(10)) - 16,
                    damage: 0.2,
                    duration: 300,
                    attackDamageID: "KiaraSlash"
                });
                arg1.creator.scripts.KiaraSlash.config.timer = arg1.creator.scripts.KiaraSlash.config.maxTimer;
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "MoneyHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (arg4.chance > roll)
    {
        var amount = 1 + irandom(2);
        for (var i = 0; i < amount; i++)
        {
            var money = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_HoloCoinDrop);
            money.amountVal = 3;
            money.direction = floor(random(360));
            money.speed = 4 + random(5);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "MineralHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (arg4.chance > roll)
    {
        var amount = 2 + irandom(3);
        for (var i = 0; i < amount; i++)
        {
            obj_AttackController.ExecuteAttack("Minerals", arg1.creator, 
            {
                damage: arg1.damage * 0.4,
                x: arg3.x,
                image_index: irandom(3),
                y: arg3.y,
                direction: 30 + irandom(90),
                speed: 5 + irandom(7),
                applyWeaponSize: true
            });
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "HopeSoda", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator"))
    {
        if (variable_struct_exists(arg1.creator.scripts, "HopeSoda"))
        {
            if (arg1.creator.scripts.HopeSoda.config.attackHits < 9)
            {
                arg1.creator.scripts.HopeSoda.config.attackHits++;
            }
            else
            {
                arg1.creator.scripts.HopeSoda.config.attackHits = 0;
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "UnitSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var found = false;
    for (var i = 0; i < 3; i++)
    {
        if (global.currentStickers[i] != -1 && global.currentStickers[i].optionID == "UnitSticker")
        {
            found = true;
        }
    }
    if (found)
    {
        if (variable_instance_exists(arg1, "optionType"))
        {
            if ((arg1.optionType == "Weapon" || arg1.optionType == "Collab" || arg1.optionType == "SuperCollab" || arg1.optionType == "WeaponEffect") && !arg1.isMain)
            {
                arg0 *= arg4.multiplier;
            }
        }
    }
    else if (variable_instance_exists(arg1, "creator"))
    {
        variable_struct_remove(arg1.creator.onHitEffects, "UnitSticker");
    }
    return round(arg0);
});
ds_map_set(OnHitEffects, "candyHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (!variable_instance_exists(arg3, "candyActivated") || (variable_instance_exists(arg3, "candyActivated") && arg3.candyActivated != arg1.id))
    {
        if (roll < arg4.chance)
        {
            arg3.candyActivated = arg1.id;
            arg3.TakeDamage(arg0 / 3, arg1, arg2, "Candy");
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "StarSummon", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < 40)
    {
        obj_AttackController.ExecuteAttack("FallingStar", arg1.creator, 
        {
            x: arg3.x - 300,
            y: arg3.y - 300,
            applyWeaponSize: true
        });
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Trailblazer", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "Trailblazer", ds_map_find_value(obj_AttackController.Buffs, "Trailblazer"), 
    {
        amount: 0.3
    });
    return arg0;
});
ds_map_set(OnHitEffects, "CritVulnHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "CritVulnDebuff", ds_map_find_value(obj_AttackController.Buffs, "CritVulnDebuff"), 
    {
        amount: arg4.amount
    });
    return arg0;
});
ds_map_set(OnHitEffects, "UnderwaterDebuff", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "UnderwaterDebuff", ds_map_find_value(obj_AttackController.Buffs, "UnderwaterDebuff"));
    return arg0;
});
ds_map_set(OnHitEffects, "RifleCharge", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var charge;
    if (variable_instance_exists(arg1, "charge"))
    {
        arg1.charge++;
    }
    return arg0;
});
ds_map_set(OnHitEffects, "FocusShades", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg2)
    {
        obj_AttackController.ApplyBuff(arg3, "FocusShades", ds_map_find_value(obj_AttackController.Buffs, "FocusShades"), 
        {
            damage: arg1.damage
        });
    }
    return arg0;
});
ds_map_set(OnHitEffects, "ForbiddenWah", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var timesHit;
    if (!variable_instance_exists(arg1, "timesHit"))
    {
        arg1.timesHit = 1;
    }
    else
    {
        if (arg1.timesHit < 4)
        {
            arg1.timesHit++;
        }
        if (arg1.timesHit == 4)
        {
            arg0 *= arg4.multiplier;
            if (global.lightFX)
            {
                if (instance_number(obj_vfx) < 30)
                {
                    var VFX = instance_create_depth(arg3.x, arg3.y - (6 * arg3.image_yscale), arg3.depth - 10, obj_vfx);
                    VFX.sprite_index = spr_InaBonkStick;
                    VFX.image_alpha = 1;
                    VFX.image_xscale = 2;
                    VFX.image_yscale = 2;
                    VFX.duration = 20;
                    VFX.gravity = 0.3;
                    VFX.hspeed = -5 + random(10);
                    VFX.vspeed = -3 - random(3);
                    VFX.alarm[2] = 1;
                    VFX.alarm[1] = 5;
                    VFX.rotSpeed = -4 + (irandom(1) * 8);
                }
            }
            arg1.timesHit = 0;
            soundPlay([109], "bonk", 30, 30, true);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "ImDieBomb", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!variable_struct_exists(arg3.scripts, "ImDieBomb"))
    {
        arg3.scripts.ImDieBomb = 
        {
            Script: function(arg0, arg1)
            {
            },
            
            config: 
            {
                creator: arg1.creator,
                enhancements: arg1.enhancements,
                CritMod: arg1.CritMod,
                knockback: arg1.knockback,
                onHitEffects: arg1.onHitEffects,
                gainedMods: arg1.gainedMods,
                attackDamageID: "ImDie",
                amount: 1
            }
        };
        
        arg3.onDeath.ImDieBomb = function(arg0, arg1, arg2)
        {
            if (variable_struct_exists(arg1.scripts, "ImDieBomb"))
            {
                for (var i = 0; i < arg1.scripts.ImDieBomb.config.amount; i++)
                {
                    var theBomb = arg1.scripts.ImDieBomb.config;
                    var totalOnHitEffects = {};
                    if (variable_struct_exists(theBomb, "onHitEffects"))
                    {
                        variable_struct_copy(theBomb.onHitEffects, totalOnHitEffects);
                    }
                    variable_struct_remove(totalOnHitEffects, "ImDieBomb");
                    obj_AttackController.ExecuteAttack("ImDieExplode", theBomb.creator, 
                    {
                        x: arg1.x,
                        y: arg1.y,
                        enhancements: theBomb.enhancements,
                        CritMod: theBomb.CritMod,
                        knockback: theBomb.knockback,
                        onHitEffects: totalOnHitEffects,
                        gainedMods: theBomb.gainedMods,
                        attackDamageID: "ImDie"
                    }, true);
                }
            }
        };
        
        arg3.customDrawScriptAbove.ImDieBomb = function(arg0)
        {
            draw_sprite_ext(spr_ImDieBomb, 0, arg0.x, arg0.y - (16 * arg0.image_yscale), arg0.image_xscale, arg0.image_yscale, 0, c_white, 1);
        };
    }
    else
    {
        arg3.scripts.ImDieBomb.config.amount++;
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Frozen", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var attacker = -1;
    if (instance_exists(arg1))
    {
        if (variable_instance_exists(arg1, "creator"))
        {
            attacker = arg1.creator;
        }
        else
        {
            attacker = arg1;
        }
    }
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        if (!variable_struct_exists(arg3.scripts, "Frozen"))
        {
            arg3.Freeze(arg4.time);
            arg3.spriteColor = make_color_rgb(143, 211, 255);
            arg3.scripts.Frozen = 
            {
                Script: function(arg0, arg1)
                {
                    var timer, totalTime;
                    if (instance_exists(arg0))
                    {
                        if (arg0.scripts.Frozen.config.totalTime < (arg0.scripts.Frozen.config.endTimer / 4))
                        {
                            if (arg1.timer > 0)
                            {
                                arg1.timer--;
                            }
                            else
                            {
                                var dmgObj = obj_AttackController.CalculateDamage(arg0, arg1.attacker, 
                                {
                                    damage: 0.75
                                });
                                arg0.TakeDamage(dmgObj[0], arg1.attacker, dmgObj[1], arg1.attackID);
                                arg1.timer = arg1.maxTimer;
                            }
                        }
                        if (arg1.totalTime < arg1.endTimer)
                        {
                            arg1.totalTime++;
                        }
                        else
                        {
                            variable_struct_remove(arg0.scripts, "Frozen");
                        }
                    }
                },
                
                config: 
                {
                    maxTimer: 20,
                    timer: 0,
                    endTimer: arg4.time * 4,
                    totalTime: 0,
                    attackID: arg4.attackID,
                    attacker: attacker
                }
            };
            
            arg3.customDrawScriptAbove.Frozen = function(arg0)
            {
                if (variable_struct_exists(arg0.scripts, "Frozen"))
                {
                    if (arg0.scripts.Frozen.config.totalTime < (arg0.scripts.Frozen.config.endTimer / 4))
                    {
                        gpu_set_blendmode(bm_add);
                        draw_sprite_ext(spr_SnowSakeFrozen, 0, arg0.x, arg0.y, arg0.image_xscale * 1.3, arg0.image_yscale * 1.3, 0, c_white, 0.6);
                        gpu_set_blendmode(bm_normal);
                    }
                }
            };
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Wet", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var Wet;
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        arg3.spriteColor = 16776960;
        if (variable_instance_exists(arg3, "Wet"))
        {
            arg3.Wet++;
        }
        else
        {
            arg3.Wet = 1;
        }
    }
    if (variable_instance_exists(arg3, "Wet"))
    {
        arg0 = floor(arg0 + (arg0 * (arg3.Wet * 0.2)));
    }
    return arg0;
});
ds_map_set(OnHitEffects, "CleanUpMaid", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var player = instance_find(obj_Player, 0);
    var pickUpRange = 40 + ((40 * player.pickupRange) / 100);
    if (arg2)
    {
        if (point_distance(arg3.x, arg3.y, player.x, player.y) < pickUpRange)
        {
            arg0 *= arg4.critDamage;
        }
    }
    return floor(arg0);
});
ds_map_set(OnHitEffects, "Klutz", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (!variable_instance_exists(arg1, "weaponType"))
    {
        return arg0;
    }
    if (arg1.weaponType == "MultiShot")
    {
        if (roll < arg4.chance)
        {
            arg0 /= 2;
        }
    }
    return floor(arg0);
});

function _ApplyDamageCallback(arg0, arg1)
{
    arg0.ApplyDamage(arg1.damage, arg1.attack, arg1.critted);
}

ds_map_set(OnHitEffects, "IdolDream", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg0 > 0)
    {
        var roll;
        if (instance_exists(obj_Player))
        {
            roll = irandom(99);
        }
        if (roll < 50)
        {
            Heal(227, arg0 * 0.1, 0, true, false);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "AcerolaJuice", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "attackID") && arg1.attackID == "MelBat")
    {
        return arg0;
    }
    if (!variable_instance_exists(arg1, "attackID"))
    {
        return arg0;
    }
    var player = instance_find(obj_Player, 0);
    if (variable_struct_exists(player.scripts, "AcerolaJuice"))
    {
        if (player.scripts.AcerolaJuice.config.timer == 0 && player.scripts.AcerolaJuice.config.lfStacks > 0)
        {
            if (arg0 > 0)
            {
                if (instance_exists(player))
                {
                    Heal(player, max(1, player.HP * random(arg4.heal)), 1, true, false, true);
                }
            }
            player.scripts.AcerolaJuice.config.lfStacks--;
            player.scripts.AcerolaJuice.config.timer = player.scripts.AcerolaJuice.config.maxTimer;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Banned", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!arg3.isBoss && !arg3.miniboss)
    {
        arg3.Die(false, true, arg1);
        if (global.showDamageText && instance_number(obj_damageText) < 100)
        {
            var hit = instance_create_depth(arg3.x, arg3.y - 30, arg3.depth - 1, obj_damageText);
            hit.critted = false;
            hit.damageValue = "BANNED!";
            if (!is_undefined(arg1) && instance_exists(arg1))
            {
                if (variable_instance_exists(arg1, "CritMod"))
                {
                    hit.CritMod = arg1.CritMod;
                }
            }
            hit.hspeed = 0;
            hit.vspeed = -2;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "SharkBites", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll <= arg4.chance)
    {
        if (instance_exists(arg3))
        {
            var buffConfig = 
            {
                reapply: true,
                stacks: 1,
                maxStacks: 5,
                weight: arg4.vuln,
                heal: arg4.heal
            };
            if (variable_struct_exists(arg3.buffs, "SharkBites"))
            {
                if (arg3.buffs.SharkBites.config.stacks < arg3.buffs.SharkBites.config.maxStacks)
                {
                    ApplyBuff(arg3, "SharkBites", ds_map_find_value(Buffs, "SharkBites"), buffConfig);
                    if (global.lightFX)
                    {
                        var biteVFX = instance_create_depth(arg3.x, arg3.y - (20 * arg3.image_yscale), arg3.depth - 10, obj_vfx);
                        biteVFX.sprite_index = spr_GuraSharkBite;
                        biteVFX.image_xscale = arg3.image_xscale;
                        biteVFX.image_yscale = arg3.image_yscale;
                        biteVFX.image_alpha = 0.8;
                        biteVFX.add = true;
                    }
                }
            }
            else
            {
                ApplyBuff(arg3, "SharkBites", ds_map_find_value(Buffs, "SharkBites"), buffConfig);
                if (global.lightFX)
                {
                    var biteVFX = instance_create_depth(arg3.x, arg3.y - (20 * arg3.image_yscale), arg3.depth - 10, obj_vfx);
                    biteVFX.sprite_index = spr_GuraSharkBite;
                    biteVFX.image_xscale = arg3.image_xscale;
                    biteVFX.image_yscale = arg3.image_yscale;
                    biteVFX.image_alpha = 0.8;
                    biteVFX.add = true;
                }
            }
            
            arg3.onDeath.SharkBites = function(arg0, arg1, arg2)
            {
                var player = instance_find(obj_Player, 0);
                var healStacks = 0;
                for (var i = 0; i < arg1.buffs.SharkBites.config.stacks; i++)
                {
                    var roll = irandom(100);
                    if (roll <= 20)
                    {
                        healStacks++;
                    }
                }
                if (instance_exists(player) && healStacks > 0)
                {
                    Heal(player, healStacks * (player.HP * arg1.buffs.SharkBites.config.heal), 1);
                }
            };
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DuckASMRHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var dist = point_distance(arg1.x, arg1.y, arg3.x, arg3.y);
    var increase = max(0, (min(180, 180 - max(0, dist - 20)) / 180) * 3);
    if (dist < 75)
    {
        arg3.Freeze(120);
    }
    arg0 = floor(arg0 + (arg0 * increase));
    return arg0;
});
ds_map_set(OnHitEffects, "EnemyThen", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg3.object_index != obj_Enemy)
    {
        return arg0;
    }
    if (!variable_instance_exists(arg1, "creator"))
    {
        return arg0;
    }
    var roll = irandom(99);
    if (roll <= arg4.chance)
    {
        if (instance_exists(arg3))
        {
            var buffConfig = 
            {
                weight: arg4.vuln
            };
            if (!variable_struct_exists(arg3.buffs, "EnemyThen"))
            {
                if (arg1.creator.scripts.EnemyThen.config.targetNum < 13)
                {
                    ApplyBuff(arg3, "EnemyThen", ds_map_find_value(Buffs, "EnemyThen"), buffConfig);
                    
                    arg3.onDeath.EnemyThen = function(arg0, arg1, arg2)
                    {
                        if (arg2)
                        {
                            if (variable_struct_exists(arg1.buffs, "EnemyThen"))
                            {
                                if (obj_Player.scripts.EnemyThen.config.targetNum > 0)
                                {
                                    obj_Player.scripts.EnemyThen.config.targetNum--;
                                }
                                variable_struct_remove(arg1.buffs, "EnemyThen");
                            }
                            exit;
                        }
                        var player = instance_find(obj_Player, 0);
                        if (instance_exists(player))
                        {
                            if (variable_struct_exists(arg1.buffs, "EnemyThen"))
                            {
                                if (obj_Player.scripts.EnemyThen.config.targetNum > 0)
                                {
                                    player.scripts.EnemyThen.config.targetNum--;
                                }
                                variable_struct_remove(arg1.buffs, "EnemyThen");
                                if (player.scripts.EnemyThen.config.healTimer == 0)
                                {
                                    var roll = irandom(99);
                                    if (roll < player.scripts.EnemyThen.config.healChance)
                                    {
                                        Heal(player, player.scripts.EnemyThen.config.heal, 1, 1, false);
                                    }
                                }
                            }
                        }
                    };
                    
                    arg3.customDrawScriptAbove.EnemyThen = function(arg0)
                    {
                        if (variable_struct_exists(arg0.buffs, "EnemyThen"))
                        {
                            draw_sprite_ext(spr_SoraTarget, 0, arg0.x, arg0.y, arg0.image_xscale, arg0.image_yscale, 0, c_white, 0.5);
                        }
                    };
                }
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "UndeadSlash", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg3.object_index != obj_Enemy)
    {
        return arg0;
    }
    if (!variable_instance_exists(arg1, "creator"))
    {
        return arg0;
    }
    var extraDamage = arg4.multiply * arg0;
    var roll = irandom(99);
    if (roll <= arg4.chance)
    {
        if (instance_exists(arg3))
        {
            if (!variable_struct_exists(arg3.scripts, "UndeadSlash"))
            {
                arg3.scripts.UndeadSlash = 
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
                            arg0.TakeDamage(arg1.damage, arg1.atkObj, arg1.critted, "OllieSword");
                            arg1.timer = 180;
                            variable_struct_remove(arg0.scripts, "UndeadSlash");
                        }
                    },
                    
                    config: 
                    {
                        timer: 180,
                        damage: extraDamage,
                        atkObj: arg1.creator,
                        critted: arg2
                    }
                };
                
                arg3.customDrawScriptAbove.UndeadSlash = function(arg0)
                {
                    if (variable_struct_exists(arg0.scripts, "UndeadSlash"))
                    {
                        draw_sprite_ext(spr_OllieUndeadMark, 0, arg0.x, arg0.y, arg0.image_xscale, arg0.image_yscale, 0, c_white, 0.8);
                    }
                };
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "TimeFreeze", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!arg3.isBoss)
    {
        arg3.Freeze(arg4.freezeTime);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DynamiteBodyConvert", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!arg3.isBoss && !arg3.miniboss)
    {
        var roll = irandom(99);
        if (roll < arg4.chance)
        {
            if (!variable_struct_exists(arg3.buffs, "DemonWhisper") && variable_struct_exists(arg3, "behaviours") && variable_struct_exists(arg3.behaviours, "followPlayer"))
            {
                soundPlay([151], "nurse", 15, 30);
                arg0 = -1;
                obj_AttackController.ApplyBuff(arg3, "DemonWhisper", ds_map_find_value(obj_AttackController.Buffs, "DemonWhisper"), 
                {
                    nonSkill: true
                });
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DownUnder", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_struct_exists(arg4, "chance"))
    {
        var roll = irandom(100);
        if (arg4.chance > roll)
        {
            obj_AttackController.ApplyBuff(arg3, "DownUnder", ds_map_find_value(obj_AttackController.Buffs, "DownUnder"), arg4);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "MurasakiHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(100);
    var onHitEffectsCopy = {};
    variable_struct_copy(arg1.onHitEffects, onHitEffectsCopy);
    variable_struct_remove(onHitEffectsCopy, "MurasakiHit");
    if (arg4.chance > roll)
    {
        obj_AttackController.ExecuteAttack("MurasakiHoming", arg1.creator, 
        {
            enhancements: arg1.enhancements,
            image_xscale: arg1.image_xscale,
            image_yscale: arg1.image_yscale,
            damage: arg1.damage * 1.5,
            target: arg3,
            direction: arg1.creator.direction - 90,
            CritMod: arg1.CritMod,
            knockback: arg1.knockback,
            onHitEffects: onHitEffectsCopy
        });
        obj_AttackController.ExecuteAttack("MurasakiHoming", arg1.creator, 
        {
            enhancements: arg1.enhancements,
            image_xscale: arg1.image_xscale,
            image_yscale: arg1.image_yscale,
            damage: arg1.damage * 1.5,
            target: arg3,
            direction: arg1.creator.direction - 90,
            CritMod: arg1.CritMod,
            knockback: arg1.knockback,
            onHitEffects: onHitEffectsCopy
        });
    }
    return arg0;
});
ds_map_set(OnHitEffects, "SpiritSlash", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(100);
    if (arg4.chance > roll)
    {
        if (arg0 > arg3.currentHP)
        {
            obj_AttackController.ExecuteAttack("SpiritFire", arg1.creator, 
            {
                damage: arg1.damage * 3,
                enhancements: arg1.enhancements,
                faceCreatorDirection: false,
                x: arg3.x,
                y: arg3.y,
                image_xscale: arg1.image_xscale,
                image_yscale: arg1.image_yscale
            });
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "MainBoost", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator"))
    {
        if (variable_instance_exists(arg1, "isMain") && arg1.isMain)
        {
            var boost = arg1.creator.HP div arg4.divide;
            arg0 = floor(arg0 + ((arg0 * boost) / 100));
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "OniLady", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    arg3.OniSlashHit = true;
    return arg0;
});
ds_map_set(OnHitEffects, "Flatten", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        obj_AttackController.ApplyBuff(arg3, "Flatten", ds_map_find_value(obj_AttackController.Buffs, "Flatten"), arg4);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "MiKoroneHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var elite = variable_struct_exists(obj_PlayerManager.perks, "Elite");
    obj_AttackController.ExecuteAttack("LavaPool", 227, 
    {
        damage: 0.5,
        duration: 240,
        ogDuration: 240,
        hitCD: 15,
        enhancements: arg1.enhancements,
        gainedMods: arg1.gainedMods,
        image_xscale: arg1.image_xscale / 3,
        image_yscale: (arg1.image_yscale / 3) * 0.8,
        playSound: [],
        image_alpha: 0.7,
        soundChannel: "mikorone",
        soundCD: 20,
        x: arg3.x,
        y: arg3.y,
        attackDamageID: "MiKorone",
        optionType: "WeaponEffect"
    }, true);
    if (!variable_struct_exists(arg3.scripts, "MikoroneHit"))
    {
        arg3.burningTime = 0;
        
        arg3.customDrawScriptBelow.MiKoroneHit = function(arg0)
        {
            draw_sprite_ext(spr_DragonFire, arg0.burningTime div 4, arg0.x, arg0.y - (10 * arg0.image_yscale), abs(arg0.image_xscale) * 1.5, abs(arg0.image_xscale) * 1.5, 270, c_white, 0.7);
        };
        
        arg3.scripts.MiKoroneHit = 
        {
            Script: function(arg0, arg1)
            {
                var burningTime, timer;
                arg0.burningTime++;
                if (arg1.timer == 0)
                {
                    obj_AttackController.ExecuteAttack("LavaPool", 227, 
                    {
                        damage: 1.3,
                        duration: 240,
                        ogDuration: 240,
                        hitCD: 10,
                        enhancements: arg1.aEnhancements,
                        gainedMods: arg1.aMods,
                        image_xscale: arg1.size,
                        image_yscale: arg1.size * 0.8,
                        image_alpha: 0.7,
                        playSound: [],
                        soundChannel: "mikorone",
                        soundCD: 20,
                        x: arg0.x,
                        y: arg0.y,
                        attackDamageID: "MiKorone"
                    }, true);
                    arg1.timer = arg1.maxTimer;
                }
                else
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 45,
                maxTimer: 45,
                aEnhancements: arg1.enhancements,
                aMods: arg1.gainedMods,
                size: arg1.image_xscale / 3
            }
        };
    }
    return arg0;
});
ds_map_set(OnHitEffects, "YubiHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg0 > arg3.currentHP)
    {
        obj_AttackController.ApplyBuff(227, "Yubi", ds_map_find_value(obj_AttackController.Buffs, "Yubi"), ds_map_find_value(obj_AttackController.Buffs, "Yubi").currentConfig);
        instance_create_depth(arg3.x, arg3.y - 16, arg3.depth, obj_Yubis);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DemonLordHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "DemonLord", ds_map_find_value(obj_AttackController.Buffs, "DemonLord"), arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "NyehHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (!variable_instance_exists(arg1, "attackID"))
    {
        return arg0;
    }
    if (arg1.attackID == "Nyeh")
    {
        return arg0;
    }
    if (variable_struct_exists(arg1.creator.scripts, "BabyLanguage"))
    {
        if (arg1.creator.scripts.BabyLanguage.config.timer == 0)
        {
            if (roll < arg4.chance)
            {
                ExecuteAttack("Nyeh", arg1.creator, 
                {
                    damage: arg4.damage,
                    x: arg3.x,
                    y: arg3.y - 16,
                    image_xscale: 1.5,
                    image_yscale: 1.5
                });
                arg1.creator.scripts.BabyLanguage.config.timer = arg1.creator.scripts.BabyLanguage.config.maxTimer;
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Nyeh", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "BabyLanguage", ds_map_find_value(obj_AttackController.Buffs, "BabyLanguage"), arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "PiercerShot", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var shotBuffed;
    if (variable_instance_exists(arg1, "shotBuffed"))
    {
        if (arg1.shotBuffed < 10)
        {
            if (!variable_instance_exists(arg1, "damageMultiplier"))
            {
                arg1.damageMultiplier = 0.1;
            }
            else
            {
                arg1.damageMultiplier += 0.1;
            }
            arg1.shotBuffed++;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Cheerleader", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator") && instance_exists(arg1.creator))
    {
        if (point_distance(arg3.x, arg3.y, arg1.creator.x, arg1.creator.y) <= 100)
        {
            obj_AttackController.ApplyBuff(arg1.creator, "Cheerleader", ds_map_find_value(obj_AttackController.Buffs, "Cheerleader"), arg4);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "FubukiSwordHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var swordLimit;
    if (variable_struct_exists(arg4, "chance") && variable_instance_exists(arg1, "swordLimit"))
    {
        var roll = irandom(100);
        if (arg4.chance > roll && arg1.swordLimit > 0)
        {
            arg1.swordLimit--;
            var ranDir = irandom(3);
            var swordX = 0;
            var swordY = 0;
            switch (ranDir)
            {
                case 0:
                    swordX = camera_get_view_x(view_camera[0]) + 640;
                    swordY = camera_get_view_y(view_camera[0]) + random(360);
                    break;
                case 1:
                    swordX = camera_get_view_x(view_camera[0]) + random(640);
                    swordY = camera_get_view_y(view_camera[0]);
                    break;
                case 2:
                    swordX = camera_get_view_x(view_camera[0]);
                    swordY = camera_get_view_y(view_camera[0]) + random(360);
                    break;
                case 3:
                    swordX = camera_get_view_x(view_camera[0]) + random(640);
                    swordY = camera_get_view_y(view_camera[0]) + 360;
                    break;
            }
            ExecuteAttack("FubukiSword", arg1.creator, 
            {
                damage: arg1.damage,
                x: swordX,
                y: swordY,
                damage: 1,
                towardsX: arg3.x,
                towardsY: arg3.y,
                enhancements: arg1.enhancements,
                attackDamageID: "FubukiFoxTail",
                applyWeaponSize: true
            });
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "OnigiriSlow", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "OnigiriSlow", ds_map_find_value(obj_AttackController.Buffs, "OnigiriSlow"), arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "SummonLightning", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "target"))
    {
        arg1.target = "noTarget";
    }
    if (arg1.lightningCD == 0)
    {
        arg1.lightningCD = 20;
        ExecuteAttack("LightningWeinerLightning", arg1.creator, 
        {
            damage: arg1.damage * 2.2,
            x: arg3.x,
            y: arg3.y + 15,
            enhancements: arg1.enhancements,
            attackDamageID: "LightningWeiner",
            applyWeaponSize: true
        }, true);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "SpiderBurst", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    arg1.emitter = part_emitter_create(global.psystem);
    var creator = -1;
    if (variable_instance_exists(arg1, "creator") && variable_struct_exists(arg1.creator.scripts, "PurityAndInsanity") && arg1.creator.scripts.PurityAndInsanity.config.spiderTimer == 0)
    {
        if (roll <= arg4.chance)
        {
            var ttargets = ds_list_create();
            if (global.lightFX)
            {
                part_emitter_region(global.psystem, arg1.emitter, arg1.x - arg4.radius, arg1.x + arg4.radius, arg1.y - arg4.radius, arg1.y + arg4.radius, 1, 0);
                part_emitter_burst(global.psystem, arg1.emitter, global.partType1, 30);
            }
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg1.x, arg1.y, arg4.radius, obj_Enemy, true, true, ttargets, false);
            }
            for (var i = 0; i < ds_list_size(ttargets); i++)
            {
                var ttarget = ds_list_find_value(ttargets, i);
                obj_AttackController.ApplyBuff(ttarget, "SpiderPoison", ds_map_find_value(obj_AttackController.Buffs, "SpiderPoison"), 
                {
                    stacks: 1,
                    maxStacks: 5,
                    damage: arg4.damage,
                    reapply: true,
                    maxTimer: 60,
                    timer: 0
                });
            }
            ds_list_destroy(ttargets);
            ttargets = -1;
            audio_play_sound(snd_insanityspider, 20, false);
            var vfx = instance_create_depth(arg1.x, arg1.y, arg1.depth + 50, obj_vfx);
            vfx.sprite_index = spr_HaatoSpider;
            vfx.image_speed = 0;
            vfx.speed = 0;
            vfx.alarm[0] = 1;
            vfx.image_alpha = 0.6;
            vfx.alarm[1] = 1;
            vfx.image_xscale = 1.5;
            vfx.image_yscale = 1.5;
            vfx.growthSpeed = 0.03;
            vfx.fadeSpeed = 0.02;
            arg1.creator.scripts.PurityAndInsanity.config.spiderTimer = arg1.creator.scripts.PurityAndInsanity.config.spiderMaxTimer;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "EbifrionHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_struct_exists(arg4, "chance"))
    {
        var roll = irandom(100);
        if (arg4.chance > roll)
        {
            var vfx = instance_create_depth(arg3.x, arg3.y, arg3.depth - 20, obj_vfx);
            vfx.sprite_index = spr_GlowStickExplode_Orange;
            vfx.image_xscale = 1.5;
            vfx.image_yscale = 1.5;
            obj_Cam.ExecuteShake(20, 3);
            arg0 *= 2;
            soundPlay([270], "heavyhit", 20, 30);
            arg1.knockback = 
            {
                duration: 25,
                speed: 20
            };
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "CuttingDeepHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "weaponType"))
    {
        if (arg1.weaponType == "Melee" && point_distance(arg3.x, arg3.y, obj_Player.x, obj_Player.y) <= (40 + ((40 * obj_Player.pickupRange) / 100)))
        {
            var roll = irandom(99);
            if (roll < arg4.chance)
            {
                soundPlay([155], "slashed", 15, 10, true);
                if (global.lightFX)
                {
                    var vfx = instance_create_depth(arg3.x, arg3.y - (17 * arg3.image_yscale), arg1.depth - 50, obj_vfx);
                    vfx.sprite_index = spr_AnyaCutDeep;
                    vfx.image_alpha = 0.8;
                    vfx.image_xscale = arg3.image_xscale * 1.5;
                    vfx.image_yscale = arg3.image_yscale * 1.5;
                    vfx.depth = arg3.depth - 50;
                    vfx.image_angle = irandom(359);
                    vfx.add = true;
                }
                arg3.TakeDamage(arg0, arg1, arg2);
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "RedHeartDebuff", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "heartMode"))
    {
        switch (arg1.heartMode)
        {
            case 0:
                ApplyBuff(arg3, "AkaiDEF", ds_map_find_value(obj_AttackController.Buffs, "AkaiDEF"), arg4);
                break;
            case 1:
                ApplyBuff(arg3, "AkaiATK", ds_map_find_value(obj_AttackController.Buffs, "AkaiATK"), arg4);
                break;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Painted", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    obj_AttackController.ApplyBuff(arg3, "Painted", ds_map_find_value(obj_AttackController.Buffs, "Painted"), 
    {
        amount: arg4.amount
    });
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        obj_AttackController.ExecuteAttack("IofiPaint", arg1.creator, 
        {
            x: arg3.x,
            y: arg3.y,
            damage: arg1.damage / 2,
            spriteColor: make_color_hsv(irandom(255), 255, 255),
            drawUnderAll: true,
            duration: 300,
            hitCD: 300,
            applyWeaponSize: true
        });
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Vulnerability", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ApplyBuff(arg3, "Vulnerability", ds_map_find_value(obj_AttackController.Buffs, "Vulnerability"), arg4);
    OnDebuffApply("Vulnerability", arg0, arg1, arg2, arg3, arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "Vulnerability2", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ApplyBuff(arg3, "Vulnerability2", ds_map_find_value(obj_AttackController.Buffs, "Vulnerability2"), arg4);
    OnDebuffApply("Vulnerability2", arg0, arg1, arg2, arg3, arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "Vulnerability3", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        ApplyBuff(arg3, "Vulnerability2", ds_map_find_value(obj_AttackController.Buffs, "Vulnerability2"), arg4);
        OnDebuffApply("Vulnerability2", arg0, arg1, arg2, arg3, arg4);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "StopMove", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ApplyBuff(arg3, "StopMove", ds_map_find_value(obj_AttackController.Buffs, "StopMove"), arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "NoPressureHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var kaelaPressure;
    if (variable_instance_exists(arg3, "kaelaPressure"))
    {
        for (var i = 0; i < arg3.kaelaPressure; i++)
        {
            arg0 *= 1.25;
        }
        if (arg3.kaelaPressure < 10)
        {
            arg3.kaelaPressure++;
        }
    }
    else
    {
        arg3.kaelaPressure = 1;
    }
    ApplyBuff(arg3, "NoPressure", ds_map_find_value(obj_AttackController.Buffs, "NoPressure"), arg4);
    return round(arg0);
});
ds_map_set(OnHitEffects, "ChainCurse", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    var targets = ds_list_create();
    var numTargets = collision_circle_list(arg1.x, arg1.y, arg1.range, obj_Enemy, false, true, targets, true);
    targets = RemoveFriendly(targets);
    numTargets = ds_list_size(targets);
    if (numTargets > 1)
    {
        if (roll < arg4.chance)
        {
            var newDamage = arg1.damage;
            if (arg4.grow)
            {
                newDamage *= 1.1;
            }
            ExecuteAttack("ENCurse", arg1.creator, 
            {
                damage: newDamage,
                x: arg3.x,
                y: arg3.y - 16,
                image_xscale: arg1.image_xscale,
                image_yscale: arg1.image_yscale,
                collides: false,
                ignoreTarget: arg3,
                targetted: true,
                playSound: [200],
                soundPitch: true,
                soundChannel: "cursespread",
                drawBehind: false,
                soundCD: 15,
                enhancements: arg1.enhancements,
                onHitEffects: arg1.onHitEffects,
                afterImageColor: arg1.afterImageColor,
                script: ENCurse
            });
            var vfx = instance_create_depth(arg1.x, arg1.y, arg1.depth - 50, obj_vfx);
            vfx.sprite_index = spr_spidercooking;
            vfx.image_speed = 0;
            vfx.image_alpha = 0.8;
            vfx.image_xscale = 0.3;
            vfx.image_yscale = 0.3;
            vfx.add = true;
            vfx.alarm[1] = 1;
            vfx.alarm[0] = 1;
            vfx.fadeSpeed = 0.02;
            vfx.growthSpeed = 0.03;
        }
    }
    ds_list_destroy(targets);
    targets = -1;
    return arg0;
});
ds_map_set(OnHitEffects, "IceSlow", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ApplyBuff(arg3, "IceSlow", ds_map_find_value(obj_AttackController.Buffs, "IceSlow"), arg4);
    OnDebuffApply("IceSlow", arg0, arg1, arg2, arg3, arg4);
    return arg0;
});
ds_map_set(OnHitEffects, "SlowDown", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        ApplyBuff(arg3, "SlowDown", ds_map_find_value(obj_AttackController.Buffs, "SlowDown"), arg4);
        OnDebuffApply("SlowDown", arg0, arg1, arg2, arg3, arg4);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "NinjaHeadband", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "weaponType"))
    {
        if (arg1.weaponType == "Melee")
        {
            arg0 *= arg4.multiplier;
        }
    }
    return floor(arg0);
});
ds_map_set(OnHitEffects, "Beetle", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg5)
    {
        arg0 *= (arg4.multiplier + (global.PLAYERLEVEL / 100));
    }
    return floor(arg0);
});
ds_map_set(OnHitEffects, "FullMoonHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var targetsHit;
    if (variable_instance_exists(arg1, "targetsHit"))
    {
        arg1.targetsHit++;
        if ((arg1.targetsHit % 5) == 0)
        {
            ExecuteAttack("FullMoon", arg1.creator, 
            {
                x: arg1.x,
                y: arg1.y,
                damage: arg1.damage * 1.5,
                enhancements: arg1.enhancements,
                CritMod: arg1.CritMod,
                image_xscale: arg1.image_xscale * 1.5,
                image_yscale: arg1.image_yscale * 1.5,
                knockback: arg1.knockback,
                CritMod: arg1.CritMod,
                attackDamageID: arg1.attackID
            });
        }
    }
    return floor(arg0);
});
ds_map_set(OnHitEffects, "SlowDownSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        ApplyBuff(arg3, "SlowDown", ds_map_find_value(obj_AttackController.Buffs, "SlowDown"), arg4);
        OnDebuffApply("SlowDown", arg0, arg1, arg2, arg3, arg4);
        if (!variable_struct_exists(arg3.buffs, "SlowDownSticker"))
        {
            arg3.scripts.SlowDownSticker = 
            {
                Script: function(arg0, arg1)
                {
                    var timer, totalTimer;
                    if (arg1.timer == 0)
                    {
                        arg1.timer = arg1.maxTimer;
                        var dmgObj = obj_AttackController.CalculateDamage(arg0, 227, 
                        {
                            damage: arg1.damage
                        });
                        if (instance_exists(arg0) && variable_instance_exists(arg0, "isEnemy") && arg0.isEnemy)
                        {
                            arg0.TakeDamage(dmgObj[0], 227, dmgObj[1], arg1.attackID);
                        }
                    }
                    else
                    {
                        arg1.timer--;
                    }
                    if (arg1.totalTimer == 0)
                    {
                        if (instance_exists(arg0))
                        {
                            variable_struct_remove(arg0.scripts, "SlowDownSticker");
                        }
                    }
                    else
                    {
                        arg1.totalTimer--;
                    }
                },
                
                config: 
                {
                    damage: arg1.damage * arg4.mult,
                    attackID: arg1.attackID,
                    timer: 0,
                    maxTimer: 60,
                    totalTimer: 300
                }
            };
        }
        else if (variable_struct_exists(arg3.scripts, "SlowDownSticker"))
        {
            arg3.scripts.SlowDownSticker.config.damage = arg1.damage * arg4.mult;
            arg3.scripts.SlowDownSticker.config.totalTimer = 300;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "ColdSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_struct_exists(arg3.resists, "ColdSticker"))
    {
        return arg0;
    }
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        if (!variable_struct_exists(arg3.scripts, "ColdSticker"))
        {
            var attacker = -1;
            if (instance_exists(arg1))
            {
                if (variable_instance_exists(arg1, "creator"))
                {
                    attacker = arg1.creator;
                }
                else
                {
                    attacker = arg1;
                }
            }
            ApplyBuff(arg3, "ColdStamp", ds_map_find_value(obj_AttackController.Buffs, "ColdStamp"), arg4);
            arg3.scripts.ColdSticker = 
            {
                Script: function(arg0, arg1)
                {
                    var timer, totalTimer;
                    if (arg1.timer == 0)
                    {
                        if (!variable_struct_exists(arg0.scripts, "Frozen"))
                        {
                            arg1.timer = -1;
                            arg0.Freeze(180);
                            arg0.spriteColor = make_color_rgb(143, 211, 255);
                            arg0.scripts.Frozen = 
                            {
                                Script: function(arg0, arg1)
                                {
                                    var timer, totalTime;
                                    if (instance_exists(arg0))
                                    {
                                        if (arg0.scripts.Frozen.config.totalTime < arg0.scripts.Frozen.config.endTimer)
                                        {
                                            if (arg1.timer > 0)
                                            {
                                                arg1.timer--;
                                            }
                                            else if (instance_exists(arg0) && variable_struct_exists(arg0.scripts, "ColdSticker"))
                                            {
                                                var dmgObj = obj_AttackController.CalculateDamage(arg0, arg1.attacker, 
                                                {
                                                    damage: arg0.scripts.ColdSticker.config.damage
                                                });
                                                arg0.TakeDamage(dmgObj[0], arg1.attacker, dmgObj[1], arg0.scripts.ColdSticker.config.attackID);
                                                arg1.timer = arg1.maxTimer;
                                            }
                                        }
                                        if (arg1.totalTime < arg1.endTimer)
                                        {
                                            arg1.totalTime++;
                                        }
                                        else
                                        {
                                            variable_struct_remove(arg0.scripts, "Frozen");
                                        }
                                    }
                                },
                                
                                config: 
                                {
                                    attacker: arg1.attacker,
                                    maxTimer: 20,
                                    timer: 0,
                                    endTimer: 180,
                                    totalTime: 0
                                }
                            };
                            
                            arg0.customDrawScriptAbove.Frozen = function(arg0)
                            {
                                if (variable_struct_exists(arg0.scripts, "Frozen"))
                                {
                                    if (arg0.scripts.Frozen.config.totalTime < arg0.scripts.Frozen.config.endTimer)
                                    {
                                        gpu_set_blendmode(bm_add);
                                        draw_sprite_ext(spr_SnowSakeFrozen, 0, arg0.x, arg0.y, arg0.image_xscale * 1.3, arg0.image_yscale * 1.3, 0, c_white, 0.6);
                                        gpu_set_blendmode(bm_normal);
                                    }
                                }
                            };
                        }
                    }
                    else
                    {
                        arg1.timer--;
                    }
                    if (arg1.totalTimer == 0)
                    {
                        if (instance_exists(arg0))
                        {
                            variable_struct_remove(arg0.scripts, "ColdSticker");
                        }
                    }
                    else
                    {
                        arg1.totalTimer--;
                    }
                },
                
                config: 
                {
                    damage: arg1.damage * arg4.mult,
                    attacker: attacker,
                    attackID: arg1.attackID,
                    timer: 240,
                    maxTimer: 240,
                    totalTimer: 421
                }
            };
            arg3.onCollide.ColdSticker = 
            {
                Script: function(arg0, arg1, arg2, arg3)
                {
                    if (!arg3.isEnemy)
                    {
                        if (!arg3.invincible && arg3.shieldHP > 0)
                        {
                            if (variable_struct_exists(arg0.scripts, "ColdSticker"))
                            {
                                variable_struct_remove(arg0.scripts, "ColdSticker");
                                variable_struct_remove(arg0.onCollide, "ColdSticker");
                            }
                        }
                    }
                    return arg1;
                },
                
                config: {}
            };
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "WeakenSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        ApplyBuff(arg3, "Weaken", ds_map_find_value(obj_AttackController.Buffs, "Weaken"), arg4);
        OnDebuffApply("Weaken", arg0, arg1, arg2, arg3, arg4);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "TimeTravelAttack", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!variable_struct_exists(arg3.scripts, "TimeTravelAttack"))
    {
        arg3.scripts.TimeTravelAttack = 
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
                    arg0.TakeDamage(arg1.storedDamage, 227, false, "AmePistol");
                    arg1.storedDamage = 0;
                    soundPlay([14], "timetravelattack", 20, 0, true);
                    if (global.lightFX)
                    {
                        var vfx = instance_create_depth(arg0.x, arg0.y - (16 * arg0.image_yscale), arg0.depth + 10, obj_vfx);
                        vfx.sprite_index = spr_AmeClockGear;
                        vfx.add = true;
                        vfx.alarm[2] = 1;
                        vfx.rotSpeed = 5;
                        vfx.alarm[1] = 1;
                        vfx.duration = 20;
                        vfx.image_xscale = arg0.image_xscale / 2.2;
                        vfx.image_yscale = arg0.image_yscale / 2.2;
                    }
                    variable_struct_remove(arg0.scripts, "TimeTravelAttack");
                    variable_struct_remove(arg0.onTakeDamage, "TimeTravelAttack");
                }
            },
            
            config: 
            {
                timer: 120,
                storedDamage: 0,
                storePercent: arg4.storePercent
            }
        };
        
        arg3.onTakeDamage.TimeTravelAttack = function(arg0, arg1, arg2, arg3)
        {
            if (variable_struct_exists(arg3.scripts, "TimeTravelAttack"))
            {
                if (arg0 > 0)
                {
                    arg3.scripts.TimeTravelAttack.config.storedDamage += floor(arg0 * 0.2);
                    show_debug_message(arg3.scripts.TimeTravelAttack.config.storedDamage);
                }
            }
            else
            {
                variable_struct_remove(arg3.onTakeDamage, "TimeTravelAttack");
            }
            return arg0;
        };
    }
    return arg0;
});
ds_map_set(OnHitEffects, "GreedSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var bonusChance = min(10, arg0 div 10);
    if (!variable_struct_exists(arg1, "triggeredGreed") && variable_struct_exists(arg4, "chance"))
    {
        var roll = irandom(99);
        if ((arg4.chance + bonusChance) > roll)
        {
            var money = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_HoloCoinDrop);
            money.amountVal = 1 + bonusChance;
            money.direction = floor(random(360));
            money.speed = 3 + random(2);
            arg1.triggeredGreed = true;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "BombSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!variable_struct_exists(arg1, "triggeredBomb") && variable_struct_exists(arg1.creator.scripts, "BombSticker") && arg1.creator.scripts.BombSticker.config.timer == 0)
    {
        var roll = irandom(99);
        if (roll < arg4.chance)
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg1, "onHitEffects"))
            {
                variable_struct_copy(arg1.onHitEffects, totalOnHitEffects);
            }
            if (variable_struct_exists(totalOnHitEffects, "BombSticker"))
            {
                variable_struct_remove(totalOnHitEffects, "BombSticker");
            }
            ExecuteAttack("BombSticker", arg1.creator, 
            {
                x: arg3.x,
                y: arg3.y,
                damage: arg1.damage * 0.3,
                enhancements: arg1.enhancements,
                CritMod: arg1.CritMod,
                image_xscale: 1.3,
                image_yscale: 1.3,
                enhancements: arg1.enhancements,
                knockback: arg1.knockback,
                CritMod: arg1.CritMod,
                onHitEffects: totalOnHitEffects,
                attackDamageID: arg1.attackID
            });
            arg1.triggeredBomb = true;
            arg1.creator.scripts.BombSticker.config.timer = arg1.creator.scripts.BombSticker.config.maxTimer;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "CopySticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var player = instance_find(obj_Player, 0);
    if (variable_struct_exists(player.scripts, "CopySticker") && !arg3.isObstacle)
    {
        if (player.scripts.CopySticker.config.currentTarget == -1)
        {
            player.scripts.CopySticker.config.currentTarget = arg3;
        }
        else if (player.scripts.CopySticker.config.currentTarget != arg3)
        {
            if (instance_exists(player.scripts.CopySticker.config.currentTarget))
            {
                var aID = "";
                if (variable_instance_exists(arg1, "attackID"))
                {
                    aID = arg1.attackID;
                }
                player.scripts.CopySticker.config.currentTarget.TakeDamage(max(1, floor(arg0 * player.scripts.CopySticker.config.damage)), arg1, arg2, aID, false, true, true, false);
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "LifeSteal", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        if (arg0 >= arg3.currentHP)
        {
            if (variable_instance_exists(arg1, "creator"))
            {
                if (instance_exists(arg1.creator))
                {
                    Heal(arg1.creator, arg4.heal, 1, true, false, true);
                }
            }
            else if (instance_exists(arg1))
            {
                Heal(arg1, arg4.heal, 1, true, false, true);
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "StealthHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_struct_exists(arg1, "creator") && variable_struct_exists(arg1.creator.buffs, "Invisible"))
    {
        arg0 *= (1 + arg4.damageMultiplier);
        var roll = irandom(99);
        if (global.lightFX)
        {
            if (roll < 50)
            {
                var VFX = instance_create_depth(arg3.x, arg3.y - (6 * arg3.image_yscale), arg3.depth - 10, obj_vfx);
                VFX.sprite_index = spr_ZetaStealthHit;
                VFX.image_alpha = global.attackAlpha;
                VFX.image_angle = irandom(359);
                VFX.image_xscale = arg3.image_xscale;
                VFX.image_yscale = arg3.image_yscale;
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DataCollection", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_struct_exists(arg1, "weaponType") && arg1.weaponType != "Melee")
    {
        var roll = irandom(99);
        if (arg2 && roll < arg4.chance && variable_instance_exists(arg3, "expvalue") && !arg3.isBoss && !arg3.miniboss && obj_Player.scripts.DataCollection.config.timer == 0)
        {
            var VFX = instance_create_depth(arg3.x, arg3.y - (16 * arg3.image_yscale), arg3.depth - 100, obj_vfx);
            VFX.sprite_index = spr_ZetaData;
            VFX.image_alpha = 1;
            VFX.duration = 45;
            VFX.alarm[1] = 30;
            VFX.image_xscale = abs(arg3.image_xscale) * 1.5;
            VFX.image_yscale = arg3.image_yscale * 1.5;
            VFX.image_alpha = 0.8;
            var dropexp = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_PreCreate);
            dropexp.expVal = arg3.expvalue * arg4.bonusEXP;
            dropexp.direction = floor(random(360));
            dropexp.speed = 2 + random(3);
            soundPlay([128], "data", 40, 0, true);
            with (dropexp)
            {
                instance_change(obj_EXP, true);
            }
            obj_Player.scripts.DataCollection.config.timer = obj_Player.scripts.DataCollection.config.maxTimer;
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "eldritchHorror", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    obj_AttackController.ApplyBuff(arg3, "HorrorSlow", ds_map_find_value(obj_AttackController.Buffs, "HorrorSlow"));
    OnDebuffApply("HorrorSlow", arg0, arg1, arg2, arg3, arg4);
    if (roll < arg4.chance)
    {
        if (arg0 >= arg3.currentHP)
        {
            if (variable_instance_exists(arg1, "creator"))
            {
                if (instance_exists(arg1.creator))
                {
                    Heal(arg1.creator, max(1, irandom(arg1.creator.HP * arg4.heal)), 1, true, false, true);
                }
            }
            else if (instance_exists(arg1))
            {
                Heal(arg1, max(1, irandom(arg1.creator.HP * arg4.heal)), 1, true, false, true);
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Kapu", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        if (variable_instance_exists(arg1, "creator") && instance_exists(arg1.creator))
        {
            Heal(arg1.creator, max(1, arg4.heal * arg1.creator.HP), 1, true, false, true);
        }
        else
        {
            var attacker = arg1;
            if (instance_exists(attacker))
            {
                Heal(attacker, max(1, arg4.heal * attacker.HP), 1, true, false, true);
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "needleHit", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var _x = lengthdir_x(10, arg1.direction);
    var _y = lengthdir_y(10, arg1.direction);
    if (collision_line(arg1.x - _x, arg1.y - _y, arg1.x + _x, arg1.y + _y, arg3, false, true) != -4)
    {
        soundPlay([292], "needlehit", 10, 30);
        arg0 *= arg4.multiplier;
        var vfx = instance_create_depth(arg3.x, arg3.y, arg3.depth - 20, obj_vfx);
        vfx.sprite_index = spr_ChocoNeedleFX;
        vfx.image_xscale = 1;
        vfx.image_yscale = 1;
        vfx.image_angle = irandom(359);
    }
    if (arg2)
    {
        if (variable_instance_exists(arg1, "needleHitOnce") && arg1.needleHitOnce)
        {
            var roll = irandom(99);
            if (roll < arg4.chance)
            {
                if (variable_instance_exists(arg1, "creator") && instance_exists(arg1.creator))
                {
                    Heal(arg1.creator, arg4.heal, 1, true, false, true);
                    arg1.needleHitOnce = false;
                }
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "Stun", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        obj_AttackController.ApplyBuff(arg3, "StunSticker", ds_map_find_value(obj_AttackController.Buffs, "StunSticker"), 
        {
            resist: 600,
            freezeTime: 90
        });
    }
    return arg0;
});
ds_map_set(OnHitEffects, "CringeDamage", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg3.mentalTimer == 0 && !arg3.isBoss && !arg3.miniboss)
    {
        var roll = irandom(99);
        if (roll < arg4.chance)
        {
            soundPlay([30], "cringe", 10, 10, true);
            if (global.lightFX)
            {
                var VFX = instance_create_depth(arg3.x, arg3.y - (6 * arg3.image_yscale), arg3.depth - 10, obj_vfx);
                VFX.sprite_index = spr_CringeDamage;
                VFX.image_alpha = 1;
                VFX.image_xscale = arg3.image_xscale;
                VFX.image_yscale = arg3.image_yscale;
            }
            arg3.TakeDamage(arg3.HP * arg4.percentage, 227, false, arg4.attackID, undefined, undefined, undefined, false, true);
            arg3.ApplyMentalDamage();
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "LifeStealSticker", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator") && instance_exists(arg1.creator))
    {
        if (variable_struct_exists(arg1.creator.scripts, "LifeStealSticker") && arg1.creator.scripts.LifeStealSticker.config.timer == 0)
        {
            var roll = irandom(99);
            if (roll < arg4.chance)
            {
                if (instance_exists(arg1.creator))
                {
                    Heal(arg1.creator, max(1, arg1.creator.HP * random(arg4.heal)), 1, true, false, true);
                    arg1.creator.scripts.LifeStealSticker.config.timer = arg1.creator.scripts.LifeStealSticker.config.maxTimer;
                }
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "ProximityDamage", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator") && instance_exists(arg1.creator))
    {
        var distance = point_distance(arg1.creator.x, arg1.creator.y, arg3.x, arg3.y);
        if (distance <= 150)
        {
            var increase = min(1, (1 - (min(150, distance) / 150)) + 0.1);
            arg0 += (arg0 * increase * arg4.maxDamage);
            arg0 = floor(arg0);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "DevilHat", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator") && instance_exists(arg1.creator))
    {
        var distance = point_distance(arg1.creator.x, arg1.creator.y, arg3.x, arg3.y);
        if (distance >= 150)
        {
            arg0 *= arg4.damageMultiplier;
            arg0 = floor(arg0);
        }
        else
        {
            arg0 *= (1 - (0.1 * global.negativeEffects));
            arg0 = floor(arg0);
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "TarotDebuff", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(2);
    var roll2 = irandom(99);
    if (roll2 < arg4.chance)
    {
        obj_AttackController.ApplyBuff(arg3, "TarotDebuff", ds_map_find_value(obj_AttackController.Buffs, "TarotDebuff"), 
        {
            debuffType: roll
        });
        OnDebuffApply("TarotDebuff", arg0, arg1, arg2, arg3, arg4);
    }
    return arg0;
});
ds_map_set(OnHitEffects, "CreateOmen", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg1, "creator"))
    {
        if (instance_exists(arg1.creator))
        {
            if (arg1.creator.scripts.Omen.config.timer == 0)
            {
                var roll = irandom(99);
                if (roll < arg4.chance)
                {
                    arg1.creator.scripts.Omen.config.timer = arg1.creator.scripts.Omen.config.maxTimer;
                    obj_AttackController.ExecuteAttack("Omen", arg1.creator, 
                    {
                        damage: arg4.damage,
                        x: arg1.x,
                        y: arg1.y,
                        image_xscale: 1,
                        image_yscale: 1
                    });
                }
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "SpecDrain", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (arg0 >= arg3.currentHP)
    {
        if (variable_instance_exists(arg1, "creator"))
        {
            if (instance_exists(arg1.creator))
            {
                arg1.creator.specialMeter += arg4.amount;
            }
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "SongBurst", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < 30)
    {
        if (variable_instance_exists(arg1, "creator"))
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg1, "onHitEffects"))
            {
                variable_struct_copy(arg1.onHitEffects, totalOnHitEffects);
            }
            variable_struct_remove(totalOnHitEffects, "SongBurst");
            obj_AttackController.ExecuteAttack("DivaSongBurst", arg1.creator, 
            {
                damage: arg1.damage * 0.75,
                direction: arg1.direction + 90,
                origin_x: arg1.x,
                origin_y: arg1.y,
                image_xscale: arg1.image_xscale,
                image_yscale: arg1.image_yscale,
                onHitEffects: totalOnHitEffects,
                CritMod: arg1.CritMod,
                knockback: arg1.knockback
            });
            obj_AttackController.ExecuteAttack("DivaSongBurst", arg1.creator, 
            {
                damage: arg1.damage / 2,
                direction: arg1.direction - 90,
                origin_x: arg1.x,
                origin_y: arg1.y,
                image_xscale: arg1.image_xscale,
                image_yscale: arg1.image_yscale,
                onHitEffects: totalOnHitEffects,
                CritMod: arg1.CritMod,
                knockback: arg1.knockback
            });
        }
    }
    return arg0;
});
ds_map_set(OnHitEffects, "AnkimoTaunt", function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var roll = irandom(99);
    if (roll < arg4.chance)
    {
        ApplyBuff(arg3, "AnkimoTaunt", ds_map_find_value(obj_AttackController.Buffs, "AnkimoTaunt"), arg4);
    }
    return arg0;
});
if (!variable_global_exists("Buffs"))
{
    Buffs = ds_map_create();
    global.Buffs = Buffs;
}
else
{
    ds_map_destroy(global.Buffs);
    global.Buffs = -1;
    Buffs = ds_map_create();
    global.Buffs = Buffs;
}

function ApplyBuff(arg0, arg1, arg2 = 
{
    timer: 300
}, arg3 = {})
{
    arg0.checkEffects = 1;
    if (!instance_exists(arg0))
    {
        exit;
    }
    if (variable_struct_exists(arg0.resists, arg1))
    {
        exit;
    }
    if (!variable_struct_exists(arg0.buffs, arg1))
    {
        arg0.ResetStatsToPreStepBuff();
        arg2.Apply(arg0, arg3);
        if (!instance_exists(arg0))
        {
            exit;
        }
        arg0.SnapshotPrebuffStats();
        variable_struct_set(arg0.buffs, arg1, 
        {
            Apply: arg2.Apply,
            timer: arg2.timer,
            Callback: arg2.Callback,
            config: arg3
        });
        if (variable_struct_exists(arg3, "resist"))
        {
            variable_struct_set(arg0.resists, arg1, 
            {
                timer: arg3.resist
            });
        }
    }
    else
    {
        var buff = variable_struct_get(arg0.buffs, arg1);
        if (!variable_struct_exists(buff.config, "noRefresh"))
        {
            buff.timer = arg2.timer;
        }
        if (variable_struct_exists(arg3, "reapply"))
        {
            if (arg3.reapply)
            {
                arg0.ResetStatsToPreStepBuff();
                buff.Callback(arg0, buff.config);
                if (variable_struct_exists(buff.config, "stacks"))
                {
                    if (buff.config.stacks < buff.config.maxStacks)
                    {
                        buff.config.stacks++;
                    }
                    if (buff.config.stacks > buff.config.maxStacks)
                    {
                        buff.config.stacks = buff.config.maxStacks;
                    }
                }
                buff.Apply(arg0, buff.config);
                if (instance_exists(arg0))
                {
                    arg0.SnapshotPrebuffStats();
                }
            }
        }
    }
}

function RemoveBuff(arg0, arg1)
{
    if (!instance_exists(arg0))
    {
        exit;
    }
    if (!variable_struct_exists(arg0.buffs, arg1))
    {
        exit;
    }
    var buff = variable_struct_get(arg0.buffs, arg1);
    if (variable_struct_exists(buff.config, "stacks"))
    {
        if (variable_struct_exists(buff.config, "loseStackOnRemove"))
        {
            if (buff.timer != -1)
            {
                buff.timer = ds_map_find_value(obj_AttackController.Buffs, arg1).timer;
            }
            arg0.ResetStatsToPreStepBuff();
            buff.Callback(arg0, buff.config);
            buff.config.stacks -= buff.config.loseStackOnRemove;
            buff.config.stacks = max(0, buff.config.stacks);
            buff.Apply(arg0, buff.config);
            arg0.SnapshotPrebuffStats();
            if (buff.config.stacks < 1)
            {
                arg0.ResetStatsToPreStepBuff();
                buff.Callback(arg0, buff.config);
                arg0.SnapshotPrebuffStats();
                variable_struct_remove(arg0.buffs, arg1);
            }
            exit;
        }
        else
        {
            arg0.ResetStatsToPreStepBuff();
            buff.Callback(arg0, buff.config);
            if (buff.config.stacks > 0)
            {
                buff.config.stacks = 1;
            }
        }
    }
    else
    {
        arg0.ResetStatsToPreStepBuff();
        buff.Callback(arg0, buff.config);
    }
    arg0.SnapshotPrebuffStats();
    variable_struct_remove(arg0.buffs, arg1);
}

function VulnerabilityApply(arg0, arg1)
{
    if (arg0.debuffIcons[1] == 0)
    {
        arg0.debuffIcons[1] += 1;
    }
    arg0.BonusDamageTaken += arg1.amount;
    if (!variable_struct_exists(arg0.buffs, "Vulnerability"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function VulnerabilityRemove(arg0, arg1)
{
    if (arg0.debuffIcons[1] == 1)
    {
        arg0.debuffIcons[1] -= 1;
    }
    arg0.BonusDamageTaken -= arg1.amount;
}

ds_map_set(Buffs, "Vulnerability", 
{
    timer: 60,
    Apply: VulnerabilityApply,
    Callback: VulnerabilityRemove
});

function Vulnerability2Apply(arg0, arg1)
{
    if (arg0.debuffIcons[1] == 0)
    {
        arg0.debuffIcons[1] += 1;
    }
    arg0.BonusDamageTaken += arg1.amount;
    if (!variable_struct_exists(arg0.buffs, "Vulnerability"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function Vulnerability2Remove(arg0, arg1)
{
    if (arg0.debuffIcons[1] == 1)
    {
        arg0.debuffIcons[1] -= 1;
    }
    arg0.BonusDamageTaken -= arg1.amount;
}

ds_map_set(Buffs, "Vulnerability2", 
{
    timer: 240,
    Apply: Vulnerability2Apply,
    Callback: Vulnerability2Remove
});

function TempuraApply(arg0, arg1)
{
    arg0.ATK += 0.3;
}

function TempuraRemove(arg0, arg1)
{
    arg0.ATK -= 0.3;
}

ds_map_set(Buffs, "Tempura", 
{
    timer: -1,
    Apply: TempuraApply,
    Callback: TempuraRemove
});

function TunaSandwichApply(arg0, arg1)
{
    arg0.SPD += 0.25;
}

function TunaSandwichRemove(arg0, arg1)
{
    arg0.SPD -= 0.25;
}

ds_map_set(Buffs, "TunaSandwich", 
{
    timer: -1,
    Apply: TunaSandwichApply,
    Callback: TunaSandwichRemove
});

function SushiSetApply(arg0, arg1)
{
    arg0.crit += 10;
}

function SushiSetRemove(arg0, arg1)
{
    arg0.crit -= 10;
}

ds_map_set(Buffs, "SushiSet", 
{
    timer: -1,
    Apply: SushiSetApply,
    Callback: SushiSetRemove
});

function PokeBowlApply(arg0, arg1)
{
    arg0.pickupRange += 40;
}

function PokeBowlRemove(arg0, arg1)
{
    arg0.pickupRange -= 40;
}

ds_map_set(Buffs, "PokeBowl", 
{
    timer: -1,
    Apply: PokeBowlApply,
    Callback: PokeBowlRemove
});

function FruitSandwichApply(arg0, arg1)
{
    global.moneyMultiplier += 0.3;
}

function FruitSandwichRemove(arg0, arg1)
{
    global.moneyMultiplier -= 0.3;
}

ds_map_set(Buffs, "FruitSandwich", 
{
    timer: -1,
    Apply: FruitSandwichApply,
    Callback: FruitSandwichRemove
});

function LobsterDinnerApply(arg0, arg1)
{
    arg0.haste += 10;
}

function LobsterDinnerRemove(arg0, arg1)
{
    arg0.haste -= 10;
}

ds_map_set(Buffs, "LobsterDinner", 
{
    timer: -1,
    Apply: LobsterDinnerApply,
    Callback: LobsterDinnerRemove
});

function PufferFishMealApply(arg0, arg1)
{
    arg0.ATK += 0.2;
    arg0.SPD += 0.2;
    arg0.crit += 10;
    arg0.pickupRange += 20;
    arg0.haste += 10;
    arg0.HP += 10;
}

function PufferFishMealRemove(arg0, arg1)
{
    arg0.ATK -= 0.1;
    arg0.SPD -= 0.1;
    arg0.crit -= 10;
    arg0.pickupRange -= 10;
    arg0.haste -= 10;
    arg0.HP -= 10;
}

ds_map_set(Buffs, "PufferFishMeal", 
{
    timer: -1,
    Apply: PufferFishMealApply,
    Callback: PufferFishMealRemove
});

function VegetarianBurgerApply(arg0, arg1)
{
}

function VegetarianBurgerRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "VegetarianBurger", 
{
    timer: -1,
    Apply: VegetarianBurgerApply,
    Callback: VegetarianBurgerRemove
});

function TurtleSoupApply(arg0, arg1)
{
    arg0.expMultiplier += 0.15;
}

function TurtleSoupRemove(arg0, arg1)
{
    arg0.expMultiplier -= 0.15;
}

ds_map_set(Buffs, "TurtleSoup", 
{
    timer: -1,
    Apply: TurtleSoupApply,
    Callback: TurtleSoupRemove
});

function UnagiDonApply(arg0, arg1)
{
    arg0.HP += 20;
}

function UnagiDonRemove(arg0, arg1)
{
    arg0.HP -= 20;
}

ds_map_set(Buffs, "UnagiDon", 
{
    timer: -1,
    Apply: UnagiDonApply,
    Callback: UnagiDonRemove
});

function CalamariSetApply(arg0, arg1)
{
    arg0.HP += 40;
}

function CalamariSetRemove(arg0, arg1)
{
    arg0.HP -= 40;
}

ds_map_set(Buffs, "CalamariSet", 
{
    timer: -1,
    Apply: CalamariSetApply,
    Callback: CalamariSetRemove
});

function VegetableSoupApply(arg0, arg1)
{
}

function VegetableSoupRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "VegetableSoup", 
{
    timer: 300,
    Apply: VegetableSoupApply,
    Callback: VegetableSoupRemove
});

function StunStickerApply(arg0, arg1)
{
    if (!arg0.isBoss)
    {
        arg0.Freeze(arg1.freezeTime);
    }
}

function StunStickerRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "StunSticker", 
{
    timer: 90,
    Apply: StunStickerApply,
    Callback: StunStickerRemove
});

function ShortHeightApply(arg0, arg1)
{
    arg0.SPD *= 1 + arg1.weight;
}

function ShortHeightRemove(arg0, arg1)
{
    arg0.SPD *= 1 / (1 + arg1.weight);
}

ds_map_set(Buffs, "ShortHeight", 
{
    timer: 180,
    Apply: ShortHeightApply,
    Callback: ShortHeightRemove
});

function GuraSpecialApply(arg0, arg1)
{
    arg0.runSprite = arg0.sprites[1].sprite2;
    arg0.idleSprite = arg0.sprites[1].sprite1;
    arg0.ATK += 0.5;
    arg0.SPD += 0.25;
    arg0.scripts.GuraSpecial = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
                    var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                    afterimage.sprite_index = arg0.sprite_index;
                    afterimage.image_speed = 0;
                    afterimage.image_index = arg0.image_index;
                    afterimage.image_xscale = arg0.image_xscale;
                    afterimage.image_yscale = arg0.image_yscale;
                    afterimage.afterimage_color = 255;
                    afterimage.image_angle = arg0.image_angle;
                    afterimage.image_alpha = 0.8;
                    afterimage.grow = true;
                    afterimage.growthRate = 0.1;
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function GuraSpecialRemove(arg0, arg1)
{
    arg0.runSprite = arg0.sprites[0].sprite2;
    arg0.idleSprite = arg0.sprites[0].sprite1;
    arg0.ATK -= 0.5;
    arg0.SPD -= 0.25;
    variable_struct_remove(arg0.scripts, "GuraSpecial");
}

ds_map_set(Buffs, "GuraSpecial", 
{
    timer: 900,
    Apply: GuraSpecialApply,
    Callback: GuraSpecialRemove
});

function TheRapperApply(arg0, arg1)
{
    arg0.BonusDamageTaken += arg1.amount;
    arg0.debuffIcons[1] = true;
    if (!variable_struct_exists(arg0.buffs, "TheRapper"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
    if (arg1.crit)
    {
        arg0.CritVuln += 20;
    }
}

function TheRapperRemove(arg0, arg1)
{
    arg0.BonusDamageTaken -= arg1.amount;
    arg0.debuffIcons[1] = false;
    if (arg1.crit)
    {
        arg0.CritVuln += -20;
    }
}

ds_map_set(Buffs, "TheRapper", 
{
    timer: 60,
    Apply: TheRapperApply,
    Callback: TheRapperRemove
});

function CalliSpecialApply(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "CalliSlash1").config.damage = ds_map_find_value(arg0.attacks, "CalliSlash1").config.damage * 3;
    arg0.CritMod += 1.5;
    arg0.scripts.CalliSpecial = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
                    var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                    afterimage.sprite_index = arg0.sprite_index;
                    afterimage.image_speed = 0;
                    afterimage.image_index = arg0.image_index;
                    afterimage.image_xscale = arg0.image_xscale;
                    afterimage.image_yscale = arg0.image_yscale;
                    afterimage.afterimage_color = 8388736;
                    afterimage.image_angle = arg0.image_angle;
                    afterimage.image_alpha = 0.8;
                    afterimage.grow = true;
                    afterimage.growthRate = 0.1;
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function CalliSpecialRemove(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "CalliSlash1").config.damage = ds_map_find_value(arg0.attacks, "CalliSlash1").config.damage * (1/3);
    arg0.CritMod -= 1.5;
    variable_struct_remove(arg0.scripts, "CalliSpecial");
}

ds_map_set(Buffs, "CalliSpecial", 
{
    timer: 900,
    Apply: CalliSpecialApply,
    Callback: CalliSpecialRemove
});

function AmeTimeTravelerApply(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "AmePistol").resetTimer = ds_map_find_value(arg0.attacks, "AmePistol").resetTimer * 0.5;
}

function AmeTimeTravelerRemove(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "AmePistol").resetTimer = ds_map_find_value(arg0.attacks, "AmePistol").resetTimer * 2;
}

ds_map_set(Buffs, "AmeTimeTraveler", 
{
    timer: 600,
    Apply: AmeTimeTravelerApply,
    Callback: AmeTimeTravelerRemove
});

function WorkaholicApply(arg0, arg1)
{
    arg0.ATK += arg1.stacks * arg1.weight;
    if (arg1.buffSpeed)
    {
        arg0.SPD += (arg1.stacks * arg1.weight) / 2;
    }
}

function WorkaholicRemove(arg0, arg1)
{
    arg0.ATK += -arg1.stacks * arg1.weight;
    if (arg1.buffSpeed)
    {
        arg0.SPD += -(arg1.stacks * arg1.weight) / 2;
    }
    variable_struct_remove(arg0.customDrawScriptAbove, "Workaholic");
}

ds_map_set(Buffs, "Workaholic", 
{
    timer: 300,
    Apply: WorkaholicApply,
    Callback: WorkaholicRemove
});

function TheVoidApply(arg0, arg1)
{
    var timer;
    arg0.SPD *= 1 - arg1.amount;
    arg0.debuffIcons[2] = true;
    if (!variable_struct_exists(arg0.buffs, "TheVoid"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
    if (arg1.damage > 0)
    {
        var dmgObj = obj_AttackController.CalculateDamage(arg0, 227, 
        {
            damage: arg1.damage
        });
        if (arg1.timer == 0)
        {
            if (arg0.isEnemy)
            {
                arg0.TakeDamage(dmgObj[0], 227, dmgObj[1], "TheVoid", undefined, undefined, undefined, true);
            }
            if (arg0.currentHP <= (arg0.HP * 0.2))
            {
                var roll = irandom(99);
                if (roll < 20)
                {
                    if (arg0.miniboss || arg0.isBoss || !arg0.isEnemy)
                    {
                        exit;
                    }
                    obj_AttackController._CreateTakodachi(arg0, true);
                }
            }
            arg1.timer = arg1.maxTimer;
        }
        else
        {
            arg1.timer--;
        }
    }
}

function TheVoidRemove(arg0, arg1)
{
    arg0.SPD *= 1 / (1 - arg1.amount);
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "TheVoid", 
{
    timer: 60,
    Apply: TheVoidApply,
    Callback: TheVoidRemove
});

function TrailblazerApply(arg0, arg1)
{
    arg0.SPD *= 1 - arg1.amount;
    arg0.debuffIcons[2] = true;
    if (!variable_struct_exists(arg0.buffs, "Trailblazer"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function TrailblazerRemove(arg0, arg1)
{
    arg0.SPD *= 1 / (1 - arg1.amount);
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "Trailblazer", 
{
    timer: 180,
    Apply: TrailblazerApply,
    Callback: TrailblazerRemove
});

function DancerApply(arg0, arg1)
{
    arg0.ATK += arg1.stacks * arg1.weight;
    if (arg1.buffCrit)
    {
        arg0.crit += arg1.stacks;
    }
}

function DancerRemove(arg0, arg1)
{
    variable_struct_remove(arg0.customDrawScriptAbove, "Dancer");
    arg0.ATK += -arg1.stacks * arg1.weight;
    if (arg1.buffCrit)
    {
        arg0.crit += -arg1.stacks;
    }
}

ds_map_set(Buffs, "Dancer", 
{
    timer: 80,
    Apply: DancerApply,
    Callback: DancerRemove
});

function ImmortalPhoenixApply(arg0, arg1)
{
    arg0.scripts.ImmortalPhoenix = 
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
                arg1.timer = 3;
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
        },
        
        config: 
        {
            timer: 0
        }
    };
    
    arg0.onDeath.ImmortalPhoenix = function(arg0, arg1, arg2)
    {
        arg0.currentHP = 1;
        hpSus = arg0.currentHP - 1;
        Heal(arg0, arg0.HP, 0, true, false);
        arg0.invincible = true;
        arg0.invincibilityTimer += 120;
        if (variable_struct_exists(arg0.scripts, "Plushie"))
        {
            arg0.scripts.Plushie.config.damageDebt = 0;
        }
        obj_AttackController.ExecuteAttack("PhoenixKB", arg0, 
        {
            attackDamageID: "KiaraPhoenix"
        });
        obj_AttackController.RemoveBuff(arg0, "ImmortalPhoenix");
        arg0.stopDeath = true;
    };
}

function ImmortalPhoenixRemove(arg0, arg1)
{
    variable_struct_remove(arg0.onDeath, "ImmortalPhoenix");
    variable_struct_remove(arg0.scripts, "ImmortalPhoenix");
}

ds_map_set(Buffs, "ImmortalPhoenix", 
{
    timer: 900,
    Apply: ImmortalPhoenixApply,
    Callback: ImmortalPhoenixRemove
});

function PhoenixShieldApply(arg0, arg1)
{
}

function PhoenixShieldRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "PhoenixShield", 
{
    timer: -1,
    Apply: PhoenixShieldApply,
    Callback: PhoenixShieldRemove
});

function HalfAngelApply(arg0, arg1)
{
    arg0.HP += round(arg1.stacks * arg1.weight);
}

function HalfAngelRemove(arg0, arg1)
{
    arg0.HP += -floor(arg1.stacks * arg1.weight);
    if (variable_struct_get(arg0.buffs, "HalfAngel").timer == 0)
    {
        if (arg0.currentHP > arg0.HP)
        {
            arg0.currentHP = arg0.HP;
        }
    }
}

ds_map_set(Buffs, "HalfAngel", 
{
    timer: 300,
    Apply: HalfAngelApply,
    Callback: HalfAngelRemove
});

function HalfDemonApply(arg0, arg1)
{
    arg0.ATK += arg1.stacks * arg1.weight;
}

function HalfDemonRemove(arg0, arg1)
{
    arg0.ATK += -arg1.stacks * arg1.weight;
}

ds_map_set(Buffs, "HalfDemon", 
{
    timer: 300,
    Apply: HalfDemonApply,
    Callback: HalfDemonRemove
});

function PerfectionApply(arg0, arg1)
{
    arg0.ATK += arg1.weight;
    arg0.SPD += arg1.weight;
    arg0.pickupRange += arg1.weight * 100;
    arg0.haste += arg1.weight2;
    arg0.crit += arg1.weight2;
}

function PerfectionRemove(arg0, arg1)
{
    arg0.ATK += -arg1.weight;
    arg0.SPD += -arg1.weight;
    arg0.pickupRange += -arg1.weight * 100;
    arg0.haste += -arg1.weight2;
    arg0.crit += -arg1.weight2;
}

ds_map_set(Buffs, "Perfection", 
{
    timer: -1,
    Apply: PerfectionApply,
    Callback: PerfectionRemove
});

function KroniicopterApply(arg0, arg1)
{
    arg0.SPD += arg1.weight / 100;
    arg0.haste += arg1.weight;
}

function KroniicopterRemove(arg0, arg1)
{
    arg0.SPD += -arg1.weight / 100;
    arg0.haste += -arg1.weight;
}

ds_map_set(Buffs, "Kroniicopter", 
{
    timer: 300,
    Apply: KroniicopterApply,
    Callback: KroniicopterRemove
});

function StudyGlassesApply(arg0, arg1)
{
    arg0.weaponBonus += arg1.stacks * 0.003;
}

function StudyGlassesRemove(arg0, arg1)
{
    arg0.weaponBonus -= arg1.stacks * 0.003;
}

ds_map_set(Buffs, "StudyGlasses", 
{
    timer: -1,
    Apply: StudyGlassesApply,
    Callback: StudyGlassesRemove
});

function SuperChattoTimeApply(arg0, arg1)
{
    arg0.ATK += (arg1.stacks div 10) * 0.01;
}

function SuperChattoTimeRemove(arg0, arg1)
{
    arg0.ATK -= (arg1.stacks div 10) * 0.01;
}

ds_map_set(Buffs, "SuperChattoTime", 
{
    timer: -1,
    Apply: SuperChattoTimeApply,
    Callback: SuperChattoTimeRemove
});

function PikiPikiPimanApply(arg0, arg1)
{
    arg0.crit += arg1.weight;
}

function PikiPikiPimanRemove(arg0, arg1)
{
    arg0.crit += -arg1.weight;
}

ds_map_set(Buffs, "PikiPikiPiman", 
{
    timer: 600,
    Apply: PikiPikiPimanApply,
    Callback: PikiPikiPimanRemove
});

function ChickensFeatherApply(arg0, arg1)
{
}

function ChickensFeatherRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "ChickensFeather", 
{
    timer: -1,
    Apply: ChickensFeatherApply,
    Callback: ChickensFeatherRemove
});

function SakeApply(arg0, arg1)
{
    arg0.crit += arg1.stacks * arg1.weight * global.positiveEffects;
}

function SakeRemove(arg0, arg1)
{
    arg0.crit += -(arg1.stacks * arg1.weight * global.positiveEffects);
}

ds_map_set(Buffs, "Sake", 
{
    timer: -1,
    Apply: SakeApply,
    Callback: SakeRemove
});

function Sake2Apply(arg0, arg1)
{
    arg0.crit += arg1.weight * global.positiveEffects;
}

function Sake2Remove(arg0, arg1)
{
    arg0.crit += -arg1.weight * global.positiveEffects;
}

ds_map_set(Buffs, "Sake2", 
{
    timer: 600,
    Apply: Sake2Apply,
    Callback: Sake2Remove
});

function StopMoveApply(arg0, arg1)
{
    arg0.canMove = false;
}

function StopMoveRemove(arg0, arg1)
{
    arg0.canMove = true;
}

ds_map_set(Buffs, "StopMove", 
{
    timer: 30,
    Apply: StopMoveApply,
    Callback: StopMoveRemove
});

function MembershipApply(arg0, arg1)
{
}

function MembershipRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Membership", 
{
    timer: -1,
    Apply: MembershipApply,
    Callback: MembershipRemove
});

function GWSPillApply(arg0, arg1)
{
}

function GWSPillRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "GWSPill", 
{
    timer: -1,
    Apply: GWSPillApply,
    Callback: GWSPillRemove
});

function WhispererApply(arg0, arg1)
{
}

function WhispererRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Whisperer", 
{
    timer: -1,
    Apply: WhispererApply,
    Callback: WhispererRemove
});

function MotherNatureApply(arg0, arg1)
{
}

function MotherNatureRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "MotherNature", 
{
    timer: 600,
    Apply: WhispererApply,
    Callback: WhispererRemove
});

function SaplingApply(arg0, arg1)
{
    arg0.ATK += arg1.weight;
    arg0.SPD += arg1.weight2;
}

function SaplingRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight;
    arg0.SPD -= arg1.weight2;
}

ds_map_set(Buffs, "Sapling", 
{
    timer: 900,
    Apply: SaplingApply,
    Callback: SaplingRemove
});

function DownUnderApply(arg0, arg1)
{
    arg0.canMove = false;
    arg0.BonusDamageTaken += arg1.vuln;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = false;
    }
    arg0.upsideDown = true;
    if (variable_instance_exists(arg0, "tangible"))
    {
        arg0.wasTangible = arg0.tangible;
    }
    arg0.tangible = false;
    if (arg1.vuln > 0)
    {
        arg0.debuffIcons[1] = true;
    }
}

function DownUnderRemove(arg0, arg1)
{
    arg0.canMove = true;
    arg0.tangible = arg0.wasTangible;
    arg0.BonusDamageTaken -= arg1.vuln;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = true;
    }
    arg0.upsideDown = false;
    arg0.debuffIcons[1] = false;
}

ds_map_set(Buffs, "DownUnder", 
{
    timer: 120,
    Apply: DownUnderApply,
    Callback: DownUnderRemove
});

function PlushieApply(arg0, arg1)
{
    arg0.ATK -= arg1.weight;
}

function PlushieRemove(arg0, arg1)
{
    arg0.ATK += arg1.weight;
}

ds_map_set(Buffs, "Plushie", 
{
    timer: 180,
    Apply: PlushieApply,
    Callback: PlushieRemove
});

function AstrologyApply(arg0, arg1)
{
    switch (arg1.stat)
    {
        case 0:
            arg0.ATK += arg1.weight1;
            break;
        case 1:
            arg0.SPD += arg1.weight1;
            break;
        case 2:
            arg0.crit += arg1.weight1 * 100;
            break;
        case 3:
            arg0.pickupRange += arg1.weight1 * 100;
            break;
        case 4:
            arg0.haste += arg1.weight1 * 100;
            break;
    }
}

function AstrologyRemove(arg0, arg1)
{
    switch (arg1.stat)
    {
        case 0:
            arg0.ATK -= arg1.weight1;
            break;
        case 1:
            arg0.SPD -= arg1.weight1;
            break;
        case 2:
            arg0.crit -= arg1.weight1 * 100;
            break;
        case 3:
            arg0.pickupRange -= arg1.weight1 * 100;
            break;
        case 4:
            arg0.haste -= arg1.weight1 * 100;
            break;
    }
}

ds_map_set(Buffs, "Astrology", 
{
    timer: 899,
    Apply: AstrologyApply,
    Callback: AstrologyRemove
});

function RulerOfSpaceApply(arg0, arg1)
{
    arg0.ATK += (arg0.weaponSizeMultiplier - 1) * 2;
}

function RulerOfSpaceRemove(arg0, arg1)
{
    arg0.ATK -= (arg0.weaponSizeMultiplier - 1) * 2;
}

ds_map_set(Buffs, "RulerOfSpace", 
{
    timer: -1,
    Apply: RulerOfSpaceApply,
    Callback: RulerOfSpaceRemove
});

function BloodthirstApply(arg0, arg1)
{
}

function BloodthirstRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Bloodthirst", 
{
    timer: -1,
    Apply: BloodthirstApply,
    Callback: BloodthirstRemove
});

function Bloodthirst2Apply(arg0, arg1)
{
    arg0.ATK += arg1.weight;
    arg0.spriteColor = make_color_rgb(255, 155, 155);
}

function Bloodthirst2Remove(arg0, arg1)
{
    arg0.ATK -= arg1.weight;
    arg0.spriteColor = 16777215;
}

ds_map_set(Buffs, "Bloodthirst2", 
{
    timer: 600,
    Apply: Bloodthirst2Apply,
    Callback: Bloodthirst2Remove
});

function MumeiHorrorApply(arg0, arg1)
{
    arg0.haste += arg1.weight;
}

function MumeiHorrorRemove(arg0, arg1)
{
    arg0.haste -= arg1.weight;
}

ds_map_set(Buffs, "MumeiHorror", 
{
    timer: 600,
    Apply: MumeiHorrorApply,
    Callback: MumeiHorrorRemove
});

function TimeTravelerApply(arg0, arg1)
{
    arg0.SPD *= 0.2;
    arg0.image_speed *= 0.2;
    arg0.debuffIcons[2] = true;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = false;
    }
}

function TimeTravelerRemove(arg0, arg1)
{
    arg0.SPD *= 5;
    arg0.image_speed = 1;
    arg0.debuffIcons[2] = false;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = true;
    }
}

ds_map_set(Buffs, "TimeTraveler", 
{
    timer: 2,
    Apply: TimeTravelerApply,
    Callback: TimeTravelerRemove
});

function MatsuriTimeApply(arg0, arg1)
{
    arg0.SPD *= 0.3;
    arg0.debuffIcons[2] = true;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = false;
    }
}

function MatsuriTimeRemove(arg0, arg1)
{
    arg0.SPD *= 3.3333333333333335;
    arg0.debuffIcons[2] = false;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = true;
    }
}

ds_map_set(Buffs, "MatsuriTime", 
{
    timer: 30,
    Apply: MatsuriTimeApply,
    Callback: MatsuriTimeRemove
});

function SanaSpecialApply(arg0, arg1)
{
    arg0.image_alpha = 0;
}

function SanaSpecialRemove(arg0, arg1)
{
    arg0.image_alpha = 1;
}

ds_map_set(Buffs, "SanaSpecial", 
{
    timer: 600,
    Apply: SanaSpecialApply,
    Callback: SanaSpecialRemove
});

function BaeSpecialApply(arg0, arg1)
{
    arg0.haste += 999;
}

function BaeSpecialRemove(arg0, arg1)
{
    arg0.haste -= 999;
}

ds_map_set(Buffs, "BaeSpecial", 
{
    timer: 300,
    Apply: BaeSpecialApply,
    Callback: BaeSpecialRemove
});

function SharkBitesApply(arg0, arg1)
{
    arg0.BonusDamageTaken += arg1.stacks * arg1.weight;
    arg0.debuffIcons[1] = arg1.stacks;
    if (!variable_struct_exists(arg0.buffs, "SharkBites"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function SharkBitesRemove(arg0, arg1)
{
    arg0.BonusDamageTaken -= arg1.stacks * arg1.weight;
    arg0.debuffIcons[1] = false;
}

ds_map_set(Buffs, "SharkBites", 
{
    timer: -1,
    Apply: SharkBitesApply,
    Callback: SharkBitesRemove
});

function FriendzoneApply(arg0, arg1)
{
    arg0.SPD += arg1.SPDBuff;
    arg0.afterImageOn = 16777215;
}

function FriendzoneRemove(arg0, arg1)
{
    arg0.SPD -= arg1.SPDBuff;
    arg0.afterImageOn = false;
}

ds_map_set(Buffs, "Friendzone", 
{
    timer: -1,
    Apply: FriendzoneApply,
    Callback: FriendzoneRemove
});

function Friendzone2Apply(arg0, arg1)
{
    arg0.SPD += arg1.SPDBuff;
    arg0.afterImageOn = make_color_rgb(77, 187, 255);
}

function Friendzone2Remove(arg0, arg1)
{
    arg0.SPD -= arg1.SPDBuff;
    arg0.afterImageOn = false;
}

ds_map_set(Buffs, "Friendzone2", 
{
    timer: 180,
    Apply: Friendzone2Apply,
    Callback: Friendzone2Remove
});

function FubukiStormApply(arg0, arg1)
{
}

function FubukiStormRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "FubukiStorm", 
{
    timer: 300,
    Apply: FubukiStormApply,
    Callback: FubukiStormRemove
});

function OnigiriSlowApply(arg0, arg1)
{
    arg0.SPD *= 0.7;
    arg0.debuffIcons[2] = true;
    if (!variable_struct_exists(arg0.buffs, "OnigiriSlow"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function OnigiriSlowRemove(arg0, arg1)
{
    arg0.SPD *= 1.4285714285714286;
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "OnigiriSlow", 
{
    timer: 180,
    Apply: OnigiriSlowApply,
    Callback: OnigiriSlowRemove
});

function YummyApply(arg0, arg1)
{
    arg0.ATK += arg1.weight1;
    arg0.SPD += arg1.weight2;
    arg0.crit += arg1.weight3;
}

function YummyRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight1;
    arg0.SPD -= arg1.weight2;
    arg0.crit -= arg1.weight3;
}

ds_map_set(Buffs, "Yummy", 
{
    timer: 480,
    Apply: YummyApply,
    Callback: YummyRemove
});

function SensitiveVoiceApply(arg0, arg1)
{
    arg0.canAttack = false;
    arg0.spriteColor = make_color_rgb(255, 97, 159);
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = false;
    }
}

function SensitiveVoiceRemove(arg0, arg1)
{
    arg0.canAttack = true;
    arg0.spriteColor = 16777215;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = true;
    }
}

ds_map_set(Buffs, "SensitiveVoice", 
{
    timer: 240,
    Apply: SensitiveVoiceApply,
    Callback: SensitiveVoiceRemove
});

function MoguMoguApply(arg0, arg1)
{
    arg0.SPD += 0.5;
    arg0.afterImageOn = make_color_rgb(206, 127, 255);
    arg0.noShowHit = true;
    arg0.onCollide.MoguMogu = 
    {
        Script: function(arg0, arg1, arg2, arg3)
        {
            if (!arg3.isBoss && !arg3.miniboss && arg3.isEnemy)
            {
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
                arg3.Die(false, true, arg0);
            }
            else
            {
            }
            return arg1;
        },
        
        config: {}
    };
}

function MoguMoguRemove(arg0, arg1)
{
    arg0.SPD -= 0.5;
    arg0.noShowHit = false;
    arg0.afterImageOn = false;
    if (variable_struct_exists(arg0.onCollide, "MoguMogu"))
    {
        variable_struct_remove(arg0.onCollide, "MoguMogu");
    }
}

ds_map_set(Buffs, "MoguMogu", 
{
    timer: 360,
    Apply: MoguMoguApply,
    Callback: MoguMoguRemove
});

function HiSpecApply(arg0, arg1)
{
    arg0.ATK += 1;
    arg0.SPD += 1;
    arg0.pickupRange += 100;
    arg0.crit += 50;
    arg0.haste += 50;
}

function HiSpecRemove(arg0, arg1)
{
    arg0.ATK -= 1;
    arg0.SPD -= 1;
    arg0.pickupRange -= 100;
    arg0.crit -= 50;
    arg0.haste -= 50;
}

ds_map_set(Buffs, "HiSpec", 
{
    timer: 480,
    Apply: HiSpecApply,
    Callback: HiSpecRemove
});

function StellarApply(arg0, arg1)
{
    arg0.ATK += arg1.stacks * arg1.weight;
}

function StellarRemove(arg0, arg1)
{
    arg0.ATK -= arg1.stacks * arg1.weight;
}

ds_map_set(Buffs, "Stellar", 
{
    timer: 240,
    Apply: StellarApply,
    Callback: StellarRemove
});

function SuicopathApply(arg0, arg1)
{
    arg0.crit += arg1.stacks * arg1.weight;
}

function SuicopathRemove(arg0, arg1)
{
    arg0.crit -= arg1.stacks * arg1.weight;
}

ds_map_set(Buffs, "Suicopath", 
{
    timer: 240,
    Apply: SuicopathApply,
    Callback: SuicopathRemove
});

function FlattenApply(arg0, arg1)
{
    arg0.canMove = false;
    arg0.image_yscale *= 0.4;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = false;
    }
}

function FlattenRemove(arg0, arg1)
{
    arg0.canMove = true;
    arg0.image_yscale *= 2.5;
    if (variable_instance_exists(arg0, "canSpecial"))
    {
        arg0.canSpecial = true;
    }
}

ds_map_set(Buffs, "Flatten", 
{
    timer: 300,
    Apply: FlattenApply,
    Callback: FlattenRemove
});

function BabyLanguageApply(arg0, arg1)
{
    arg0.ATK *= 0.7;
    arg0.SPD *= 0.7;
    arg0.debuffIcons[0] = true;
    arg0.debuffIcons[2] = true;
    if (!variable_struct_exists(arg0.buffs, "BabyLanguage"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function BabyLanguageRemove(arg0, arg1)
{
    arg0.ATK *= 1.4285714285714286;
    arg0.SPD *= 1.4285714285714286;
    arg0.debuffIcons[0] = false;
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "BabyLanguage", 
{
    timer: 180,
    Apply: BabyLanguageApply,
    Callback: BabyLanguageRemove
});

function ErogeHeroApply(arg0, arg1)
{
}

function ErogeHeroRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "ErogeHero", 
{
    timer: 240,
    Apply: ErogeHeroApply,
    Callback: ErogeHeroRemove
});

function EliteApply(arg0, arg1)
{
    arg0.ATK += arg1.weight1;
    arg0.SPD += arg1.weight2;
}

function EliteRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight1;
    arg0.SPD -= arg1.weight2;
}

ds_map_set(Buffs, "Elite", 
{
    timer: 240,
    Apply: EliteApply,
    Callback: EliteRemove
});

function DemonLordApply(arg0, arg1)
{
    arg0.BonusDamageTaken += 50;
    arg0.debuffIcons[1] = true;
    if (!variable_struct_exists(arg0.buffs, "DemonLord"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function DemonLordRemove(arg0, arg1)
{
    arg0.BonusDamageTaken -= 50;
    arg0.debuffIcons[1] = false;
}

ds_map_set(Buffs, "DemonLord", 
{
    timer: 300,
    Apply: DemonLordApply,
    Callback: DemonLordRemove
});

function IceSlowApply(arg0, arg1)
{
    arg0.SPD *= 0.85;
    arg0.debuffIcons[2] = true;
    if (!variable_struct_exists(arg0.buffs, "IceSlow"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function IceSlowRemove(arg0, arg1)
{
    arg0.SPD *= 1.1764705882352942;
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "IceSlow", 
{
    timer: 60,
    Apply: IceSlowApply,
    Callback: IceSlowRemove
});

function HorrorSlowApply(arg0, arg1)
{
    arg0.SPD *= 0.7;
    arg0.debuffIcons[2] = true;
    if (!variable_struct_exists(arg0.buffs, "HorrorSlow"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function HorrorSlowRemove(arg0, arg1)
{
    arg0.SPD *= 1.4285714285714286;
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "HorrorSlow", 
{
    timer: 30,
    Apply: HorrorSlowApply,
    Callback: HorrorSlowRemove
});

function EnemyThenApply(arg0, arg1)
{
    arg0.BonusDamageTaken += arg1.weight;
    arg0.debuffIcons[1] = true;
    obj_Player.scripts.EnemyThen.config.targetNum++;
}

function EnemyThenRemove(arg0, arg1)
{
    arg0.BonusDamageTaken -= arg1.weight;
    arg0.debuffIcons[1] = false;
    if (obj_Player.scripts.EnemyThen.config.targetNum > 0)
    {
        obj_Player.scripts.EnemyThen.config.targetNum--;
    }
}

ds_map_set(Buffs, "EnemyThen", 
{
    timer: 600,
    Apply: EnemyThenApply,
    Callback: EnemyThenRemove
});

function AnkimoTauntApply(arg0, arg1)
{
    arg0.canMove = false;
}

function AnkimoTauntRemove(arg0, arg1)
{
    if (arg0.frozenTime == 0)
    {
        arg0.canMove = true;
    }
}

ds_map_set(Buffs, "AnkimoTaunt", 
{
    timer: 180,
    Apply: AnkimoTauntApply,
    Callback: AnkimoTauntRemove
});

function IdolDreamApply(arg0, arg1)
{
    arg0.ATK += 0.5;
    arg0.healMultiplier += 0.5;
}

function IdolDreamRemove(arg0, arg1)
{
    arg0.ATK -= 0.5;
    arg0.healMultiplier -= 0.5;
}

ds_map_set(Buffs, "IdolDream", 
{
    timer: 600,
    Apply: IdolDreamApply,
    Callback: IdolDreamRemove
});

function HatotaurusApply(arg0, arg1)
{
    arg0.DR *= 0.7;
}

function HatotaurusRemove(arg0, arg1)
{
    arg0.DR *= 1.4285714285714286;
}

ds_map_set(Buffs, "Hatotaurus", 
{
    timer: 360,
    Apply: HatotaurusApply,
    Callback: HatotaurusRemove
});

function InugamiEnduranceApply(arg0, arg1)
{
}

function InugamiEnduranceRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "InugamiEndurance", 
{
    timer: -1,
    Apply: InugamiEnduranceApply,
    Callback: InugamiEnduranceRemove
});

function InugamiVengeanceApply(arg0, arg1)
{
    arg0.DR *= 1 - arg1.weight;
    arg0.spriteColor = make_color_rgb(255, 120, 120);
    arg0.ATK += arg1.atkBonus * 0.01;
    arg0.afterImageOn = 4235519;
}

function InugamiVengeanceRemove(arg0, arg1)
{
    arg0.DR *= 1 / (1 - arg1.weight);
    arg0.spriteColor = 16777215;
    arg0.ATK -= arg1.atkBonus * 0.01;
    arg0.afterImageOn = false;
}

ds_map_set(Buffs, "InugamiVengeance", 
{
    timer: 420,
    Apply: InugamiVengeanceApply,
    Callback: InugamiVengeanceRemove,
    currentConfig: 
    {
        weight: 0.1,
        atkBonus: 20,
        buffIcon: 1554
    },
    levelConfig: [
    {
        weight: 0.2,
        atkBonus: 40,
        buffIcon: 1554
    }, 
    {
        weight: 0.3,
        atkBonus: 60,
        buffIcon: 1554
    }]
});

function YubiYubiApply(arg0, arg1)
{
    with (obj_AttackController)
    {
        arg0.SPD *= 0.8;
        arg0.debuffIcons[2] = true;
        if (!variable_struct_exists(arg0.buffs, "YubiYubi"))
        {
            obj_AttackController.DebuffVFX(arg0);
        }
        
        arg0.customDrawScriptAbove.YubiYubi = function(arg0)
        {
            draw_sprite(spr_Yubi_icon, 0, arg0.x, arg0.y - (30 * arg0.image_yscale));
        };
        
        arg0.onDeath.YubiYubi = function(arg0, arg1, arg2)
        {
            if (arg2)
            {
                exit;
            }
            ApplyBuff(227, "Yubi", ds_map_find_value(Buffs, "Yubi"), ds_map_find_value(Buffs, "Yubi").currentConfig);
            instance_create_depth(arg1.x, arg1.y - 16, arg1.depth, obj_Yubis);
        };
    }
}

function YubiYubiRemove(arg0, arg1)
{
    arg0.SPD *= 1.25;
    arg0.debuffIcons[2] = false;
    variable_struct_remove(arg0.customDrawScriptAbove, "YubiYubi");
    variable_struct_remove(arg0.onDeath, "YubiYubi");
}

ds_map_set(Buffs, "YubiYubi", 
{
    timer: 600,
    Apply: YubiYubiApply,
    Callback: YubiYubiRemove
});

function YubiApply(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "KoronePunch").resetTimer = ds_map_find_value(arg0.attacks, "KoronePunch").resetTimer * (1 / (1 + (arg1.hasteBonus * 0.01 * arg1.stacks)));
    arg0.haste += arg1.globalHasteBonus * arg1.stacks;
}

function YubiRemove(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "KoronePunch").resetTimer = ds_map_find_value(arg0.attacks, "KoronePunch").resetTimer * (1 + (arg1.hasteBonus * 0.01 * arg1.stacks));
    arg0.haste -= arg1.globalHasteBonus * arg1.stacks;
}

ds_map_set(Buffs, "Yubi", 
{
    timer: 480,
    Apply: YubiApply,
    Callback: YubiRemove,
    currentConfig: 
    {
        stacks: 1,
        reapply: true,
        maxStacks: 30,
        buffIcon: 240,
        hasteBonus: 1,
        globalHasteBonus: 0.5,
        loseStackOnRemove: 10
    },
    levelConfig: [
    {
        stacks: 1,
        reapply: true,
        maxStacks: 30,
        buffIcon: 240,
        hasteBonus: 2,
        globalHasteBonus: 0.75,
        loseStackOnRemove: 10
    }, 
    {
        stacks: 1,
        reapply: true,
        maxStacks: 30,
        buffIcon: 240,
        hasteBonus: 3,
        globalHasteBonus: 1,
        loseStackOnRemove: 10
    }]
});

function ChocoCoronetApply(arg0, arg1)
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        arg0.HP += arg1.weight;
    }
}

function ChocoCoronetRemove(arg0, arg1)
{
    if (ds_map_find_value(global.PlayerSave, "challenge") == 0)
    {
        arg0.HP -= arg1.weight;
    }
}

ds_map_set(Buffs, "ChocoCoronet", 
{
    timer: 600,
    Apply: ChocoCoronetApply,
    Callback: ChocoCoronetRemove
});

function TarotDebuffApply(arg0, arg1)
{
    switch (arg1.debuffType)
    {
        case 0:
            arg0.ATK *= 0.8;
            break;
        case 1:
            arg0.BonusDamageTaken += 20;
            break;
        case 2:
            arg0.SPD *= 0.8;
            break;
    }
    if (!variable_struct_exists(arg0.buffs, "TarotDebuff"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function TarotDebuffRemove(arg0, arg1)
{
    switch (arg1.debuffType)
    {
        case 0:
            arg0.ATK *= 1.25;
            break;
        case 1:
            arg0.BonusDamageTaken -= 20;
            break;
        case 2:
            arg0.SPD *= 1.25;
            break;
    }
    arg0.debuffIcons[arg1.debuffType] = false;
}

ds_map_set(Buffs, "TarotDebuff", 
{
    timer: -1,
    Apply: TarotDebuffApply,
    Callback: TarotDebuffRemove
});

function EnemyChargeApply(arg0, arg1)
{
    arg0.ATK *= 2;
    arg0.SPD *= 20;
}

function EnemyChargeRemove(arg0, arg1)
{
    arg0.ATK /= 2;
    arg0.SPD /= 20;
}

ds_map_set(Buffs, "EnemyCharge", 
{
    timer: -1,
    Apply: EnemyChargeApply,
    Callback: EnemyChargeRemove
});

function VirtualDivaApply(arg0, arg1)
{
    arg0.haste += arg1.weight * arg1.stacks;
}

function VirtualDivaRemove(arg0, arg1)
{
    arg0.haste -= arg1.weight * arg1.stacks;
}

ds_map_set(Buffs, "VirtualDiva", 
{
    timer: -1,
    Apply: VirtualDivaApply,
    Callback: VirtualDivaRemove
});

function PerformanceApply(arg0, arg1)
{
    arg0.SPD += arg1.weight1 * arg1.stacks;
}

function PerformanceRemove(arg0, arg1)
{
    arg0.SPD -= arg1.weight1 * arg1.stacks;
}

ds_map_set(Buffs, "Performance", 
{
    timer: -1,
    Apply: PerformanceApply,
    Callback: PerformanceRemove
});

function EncoreApply(arg0, arg1)
{
}

function EncoreRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Encore", 
{
    timer: 420,
    Apply: EncoreApply,
    Callback: EncoreRemove
});

function PoltatoPCApply(arg0, arg1)
{
    arg0.image_xscale *= 1.5;
    arg0.image_yscale *= 1.5;
}

function PoltatoPCRemove(arg0, arg1)
{
    arg0.image_xscale *= 2/3;
    arg0.image_yscale *= 2/3;
}

ds_map_set(Buffs, "PoltatoPC", 
{
    timer: -1,
    Apply: PoltatoPCApply,
    Callback: PoltatoPCRemove
});

function HaatoModeApply(arg0, arg1)
{
}

function HaatoModeRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "HaatoMode", 
{
    timer: -1,
    Apply: HaatoModeApply,
    Callback: HaatoModeRemove
});

function HaachamaModeApply(arg0, arg1)
{
}

function HaachamaModeRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "HaachamaMode", 
{
    timer: -1,
    Apply: HaachamaModeApply,
    Callback: HaachamaModeRemove
});

function CoexistenceApply(arg0, arg1)
{
    if (variable_instance_exists(arg0.buffs, "Coexistence") && arg0.buffs.Coexistence.config.stacks == arg0.buffs.Coexistence.config.maxStacks)
    {
        arg0.afterImageOn = 65535;
    }
}

function CoexistenceRemove(arg0, arg1)
{
    arg0.afterImageOn = false;
}

ds_map_set(Buffs, "Coexistence", 
{
    timer: -1,
    Apply: CoexistenceApply,
    Callback: CoexistenceRemove
});

function FinalHaatoApply(arg0, arg1)
{
    arg0.scripts.FinalHaato = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
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
                    afterimage.growthRate = 0.2;
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function FinalHaatoRemove(arg0, arg1)
{
    if (variable_instance_exists(arg0, "savedMode"))
    {
        arg0.haatoMode = arg0.savedMode;
        arg0.OnSpecial(arg0);
    }
    variable_struct_remove(arg0.scripts, "FinalHaato");
}

ds_map_set(Buffs, "FinalHaato", 
{
    timer: 600,
    Apply: FinalHaatoApply,
    Callback: FinalHaatoRemove
});

function SpiderPoisonApply(arg0, arg1)
{
    arg0.spriteColor = 8388736;
    if (!variable_struct_exists(arg0.buffs, "SpiderPoison"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
    if (!variable_struct_exists(arg0.buffs, "SpiderPoison"))
    {
        arg0.customDrawScriptAbove.SpiderPoison = function(arg0)
        {
            if (variable_struct_exists(arg0.buffs, "SpiderPoison") && variable_struct_exists(arg0.scripts, "SpiderPoison"))
            {
                draw_set_font(buffFont_tiny);
                draw_set_color(c_white);
                draw_sprite_ext(spr_HaatoSpider_Debuff, 0, arg0.x, arg0.y - (arg0.image_yscale * 35), arg0.image_xscale, arg0.image_yscale, 0, c_white, 0.7);
                draw_text_scribble(arg0.x, arg0.y - (arg0.image_yscale * 36), arg0.scripts.SpiderPoison.config.stacks);
            }
        };
        
        arg0.scripts.SpiderPoison = 
        {
            Script: function(arg0, arg1)
            {
                var timer, totalTimer;
                if (!instance_exists(arg0))
                {
                    exit;
                }
                if (arg1.timer == 0)
                {
                    arg1.timer = arg1.maxTimer;
                    var dmgObj = obj_AttackController.CalculateDamage(arg0, 227, 
                    {
                        damage: arg1.damage * arg1.stacks
                    });
                    if (instance_exists(arg0) && arg0.isEnemy)
                    {
                        arg0.TakeDamage(dmgObj[0], 227, dmgObj[1], "PurityAndInsanity", undefined, undefined, undefined, true);
                    }
                }
                else
                {
                    arg1.timer--;
                }
                if (arg1.totalTimer == 0)
                {
                    if (instance_exists(arg0))
                    {
                        arg0.spriteColor = 16777215;
                        variable_struct_remove(arg0.scripts, "SpiderPoison");
                    }
                }
                else
                {
                    arg1.totalTimer--;
                }
            },
            
            config: 
            {
                damage: arg1.damage,
                timer: 0,
                maxTimer: 60,
                stacks: 1,
                maxStacks: 5,
                totalTimer: 300
            }
        };
    }
    else if (variable_struct_exists(arg0.scripts, "SpiderPoison"))
    {
        if (arg0.scripts.SpiderPoison.config.stacks < arg0.scripts.SpiderPoison.config.maxStacks)
        {
            arg0.scripts.SpiderPoison.config.stacks++;
        }
        arg0.scripts.SpiderPoison.config.totalTimer = 300;
    }
}

function SpiderPoisonRemove(arg0, arg1)
{
    arg0.spriteColor = 16777215;
}

ds_map_set(Buffs, "SpiderPoison", 
{
    timer: 301,
    Apply: SpiderPoisonApply,
    Callback: SpiderPoisonRemove
});

function PreAcerolaJuiceApply(arg0, arg1)
{
}

function PreAcerolaJuiceRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "PreAcerolaJuice", 
{
    timer: 2400,
    Apply: PreAcerolaJuiceApply,
    Callback: PreAcerolaJuiceRemove
});

function AcerolaJuiceApply(arg0, arg1)
{
    arg0.ATK += arg1.weight;
    arg0.SPD += arg1.weight;
}

function AcerolaJuiceRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight;
    arg0.SPD -= arg1.weight;
}

ds_map_set(Buffs, "AcerolaJuice", 
{
    timer: 300,
    Apply: AcerolaJuiceApply,
    Callback: AcerolaJuiceRemove
});

function MelMelCookingApply(arg0, arg1)
{
    var newTarget = arg1.cookingTarget;
    if (instance_exists(newTarget))
    {
        if (variable_instance_exists(arg0, "followTarget"))
        {
            arg0.followTarget = arg1.cookingTarget;
        }
        arg0.scripts.MelMelCookingDebuff = 
        {
            Script: function(arg0, arg1)
            {
                if (!instance_exists(arg0.followTarget))
                {
                    arg0.followTarget = instance_find(obj_Player, 0);
                    variable_struct_remove(arg0.scripts, "MelMelCookingDebuff");
                }
            },
            
            config: 
            {
                cookingTarget: newTarget
            }
        };
    }
}

function MelMelCookingRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "MelMelCooking", 
{
    timer: 300,
    Apply: MelMelCookingApply,
    Callback: MelMelCookingRemove
});

function BanpireApply(arg0, arg1)
{
    arg0.runSprite = arg0.sprites[1].sprite2;
    arg0.idleSprite = arg0.sprites[1].sprite1;
}

function BanpireRemove(arg0, arg1)
{
    arg0.runSprite = arg0.sprites[0].sprite2;
    arg0.idleSprite = arg0.sprites[0].sprite1;
}

ds_map_set(Buffs, "Banpire", 
{
    timer: 240,
    Apply: BanpireApply,
    Callback: BanpireRemove
});

function SeisoRepApply(arg0, arg1)
{
    arg0.afterImageOn = 4235519;
}

function SeisoRepRemove(arg0, arg1)
{
    arg0.afterImageOn = false;
}

ds_map_set(Buffs, "SeisoRep", 
{
    timer: -1,
    Apply: SeisoRepApply,
    Callback: SeisoRepRemove
});

function SeisoRep2Apply(arg0, arg1)
{
    var timer;
    if (arg1.damage > 0)
    {
        var dmgObj = obj_AttackController.CalculateDamage(arg0, 227, 
        {
            damage: arg1.damage
        });
        if (arg1.timer == 0)
        {
            if (arg0.isEnemy)
            {
                arg0.Freeze(30);
                arg0.TakeDamage(dmgObj[0], 227, dmgObj[1], "SeisoRep", undefined, undefined, undefined, true);
            }
            arg1.timer = arg1.maxTimer;
        }
        else
        {
            arg1.timer--;
        }
    }
}

function SeisoRep2Remove(arg0, arg1)
{
}

ds_map_set(Buffs, "SeisoRep2", 
{
    timer: 300,
    Apply: SeisoRep2Apply,
    Callback: SeisoRep2Remove
});

function SeisoRep3Apply(arg0, arg1)
{
}

function SeisoRep3Remove(arg0, arg1)
{
}

ds_map_set(Buffs, "SeisoRep3", 
{
    timer: 300,
    Apply: SeisoRep3Apply,
    Callback: SeisoRep3Remove
});

function WasshoiApply(arg0, arg1)
{
    arg0.ATK += arg1.weight1;
    arg0.SPD += arg1.weight2;
}

function WasshoiRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight1;
    arg0.SPD -= arg1.weight2;
}

ds_map_set(Buffs, "Wasshoi", 
{
    timer: 300,
    Apply: WasshoiApply,
    Callback: WasshoiRemove
});

function CheerleaderApply(arg0, arg1)
{
    arg0.ATK += arg1.stacks * arg1.weight1;
    arg0.SPD += arg1.stacks * arg1.weight2;
}

function CheerleaderRemove(arg0, arg1)
{
    arg0.ATK -= arg1.stacks * arg1.weight1;
    arg0.SPD -= arg1.stacks * arg1.weight2;
}

ds_map_set(Buffs, "Cheerleader", 
{
    timer: 240,
    Apply: CheerleaderApply,
    Callback: CheerleaderRemove
});

function AromatherapyApply(arg0, arg1)
{
    var timer;
    var roll = irandom(99);
    if (arg1.timer == 0)
    {
        if (arg0.isEnemy)
        {
            if (roll <= arg1.chance)
            {
                var rollStat = irandom(2);
                switch (rollStat)
                {
                    case 0:
                        obj_AttackController.ApplyBuff(arg0, "AromaATK", ds_map_find_value(obj_AttackController.Buffs, "AromaATK"), 
                        {
                            reapply: true,
                            stacks: 1,
                            maxStacks: 3,
                            weight: 0.1
                        });
                        obj_AttackController.OnDebuffApply("AromaATK", 0, instance_find(obj_Player, 0), false, arg0, arg1);
                        break;
                    case 1:
                        obj_AttackController.ApplyBuff(arg0, "AromaSPD", ds_map_find_value(obj_AttackController.Buffs, "AromaSPD"), 
                        {
                            reapply: true,
                            stacks: 1,
                            maxStacks: 3,
                            weight: 0.1
                        });
                        obj_AttackController.OnDebuffApply("AromaSPD", 0, instance_find(obj_Player, 0), false, arg0, arg1);
                        break;
                    case 2:
                        obj_AttackController.ApplyBuff(arg0, "AromaDEF", ds_map_find_value(obj_AttackController.Buffs, "AromaDEF"), 
                        {
                            reapply: true,
                            stacks: 1,
                            maxStacks: 3,
                            weight: 10
                        });
                        obj_AttackController.OnDebuffApply("AromaDEF", 0, instance_find(obj_Player, 0), false, arg0, arg1);
                        break;
                }
            }
        }
        arg1.timer = arg1.maxTimer;
    }
    else
    {
        arg1.timer--;
    }
}

function AromatherapyRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Aromatherapy", 
{
    timer: -1,
    Apply: AromatherapyApply,
    Callback: AromatherapyRemove
});

function AromaATKApply(arg0, arg1)
{
    arg0.ATK -= arg1.weight * arg1.stacks;
    arg0.debuffIcons[0] += arg1.stacks;
    if (!variable_struct_exists(arg0.buffs, "AromaATK"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function AromaATKRemove(arg0, arg1)
{
    arg0.ATK += arg1.weight * arg1.stacks;
    if (arg0.debuffIcons[0] > 0)
    {
        arg0.debuffIcons[0] -= arg1.stacks;
    }
}

ds_map_set(Buffs, "AromaATK", 
{
    timer: 720,
    Apply: AromaATKApply,
    Callback: AromaATKRemove
});

function AromaSPDApply(arg0, arg1)
{
    arg0.SPD -= arg1.weight * arg1.stacks;
    arg0.debuffIcons[2] += arg1.stacks;
    if (!variable_struct_exists(arg0.buffs, "AromaSPD"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function AromaSPDRemove(arg0, arg1)
{
    arg0.SPD += arg1.weight * arg1.stacks;
    if (arg0.debuffIcons[2] > 0)
    {
        arg0.debuffIcons[2] -= arg1.stacks;
    }
}

ds_map_set(Buffs, "AromaSPD", 
{
    timer: 720,
    Apply: AromaSPDApply,
    Callback: AromaSPDRemove
});

function AromaDEFApply(arg0, arg1)
{
    arg0.BonusDamageTaken += arg1.weight * arg1.stacks;
    arg0.debuffIcons[1] += arg1.stacks;
    if (!variable_struct_exists(arg0.buffs, "AromaDEF"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function AromaDEFRemove(arg0, arg1)
{
    arg0.BonusDamageTaken -= arg1.weight * arg1.stacks;
    if (arg0.debuffIcons[1] > 0)
    {
        arg0.debuffIcons[1] -= arg1.stacks;
    }
}

ds_map_set(Buffs, "AromaDEF", 
{
    timer: 720,
    Apply: AromaDEFApply,
    Callback: AromaDEFRemove
});

function BellyDancingApply(arg0, arg1)
{
}

function BellyDancingRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "BellyDancing", 
{
    timer: -1,
    Apply: BellyDancingApply,
    Callback: BellyDancingRemove
});

function MukiroseApply(arg0, arg1)
{
    arg0.ATK += arg1.weight1 * arg1.stacks;
    arg0.SPD += arg1.weight2 * arg1.stacks;
}

function MukiroseRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight1 * arg1.stacks;
    arg0.SPD -= arg1.weight2 * arg1.stacks;
}

ds_map_set(Buffs, "Mukirose", 
{
    timer: 300,
    Apply: MukiroseApply,
    Callback: MukiroseRemove
});

function ShallysApply(arg0, arg1)
{
}

function ShallysRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Shallys", 
{
    timer: 360,
    Apply: ShallysApply,
    Callback: ShallysRemove
});

function SlowDownApply(arg0, arg1)
{
    arg0.SPD *= 1 - arg1.amount;
    arg0.debuffIcons[2] = true;
    arg0.spriteColor = make_color_rgb(112, 217, 127);
    if (!variable_struct_exists(arg0.buffs, "SlowDown"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function SlowDownRemove(arg0, arg1)
{
    arg0.spriteColor = 16777215;
    arg0.SPD *= 1 / (1 - arg1.amount);
    arg0.debuffIcons[2] = false;
}

ds_map_set(Buffs, "SlowDown", 
{
    timer: 180,
    Apply: SlowDownApply,
    Callback: SlowDownRemove
});

function ColdStampApply(arg0, arg1)
{
    arg0.spriteColor = make_color_rgb(196, 231, 255);
    if (!variable_struct_exists(arg0.buffs, "ColdStamp"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function ColdStampRemove(arg0, arg1)
{
    arg0.spriteColor = 16777215;
}

ds_map_set(Buffs, "ColdStamp", 
{
    timer: 240,
    Apply: ColdStampApply,
    Callback: ColdStampRemove
});

function WeakenApply(arg0, arg1)
{
    arg0.ATK *= 1 - arg1.amount;
    arg0.BonusDamageTaken += arg1.amount2;
    if (arg0.debuffIcons[1] == 0)
    {
        arg0.debuffIcons[1] = true;
    }
    arg0.debuffIcons[0] = true;
    if (!variable_struct_exists(arg0.buffs, "Weaken"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function WeakenRemove(arg0, arg1)
{
    var debuffIcons;
    arg0.ATK *= 1 / (1 - arg1.amount);
    arg0.debuffIcons[0] = false;
    arg0.debuffIcons[1]--;
}

ds_map_set(Buffs, "Weaken", 
{
    timer: 180,
    Apply: WeakenApply,
    Callback: WeakenRemove
});

function RelentlessOptimismApply(arg0, arg1)
{
}

function RelentlessOptimismRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "RelentlessOptimism", 
{
    timer: -1,
    Apply: RelentlessOptimismApply,
    Callback: RelentlessOptimismRemove
});

function RelentlessOptimism2Apply(arg0, arg1)
{
}

function RelentlessOptimism2Remove(arg0, arg1)
{
}

ds_map_set(Buffs, "RelentlessOptimism2", 
{
    timer: 1,
    Apply: RelentlessOptimism2Apply,
    Callback: RelentlessOptimism2Remove
});

function OozoraPoliceApply(arg0, arg1)
{
}

function OozoraPoliceRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "OozoraPolice", 
{
    timer: -1,
    Apply: OozoraPoliceApply,
    Callback: OozoraPoliceRemove
});

function DemonWhisperApply(arg0, arg1)
{
    arg0.isEnemy = false;
    arg0.invincible = true;
    arg0.invincibilityTimer = 5;
    arg0.spriteColor = make_color_rgb(255, 88, 150);
    if (instance_exists(obj_Player))
    {
        arg0.ATK = obj_Player.ATK + (arg0.ATK / 10);
        arg0.SPD = obj_Player.SPD + arg0.SPD;
        if (variable_struct_exists(obj_Player.scripts, "DemonWhisper"))
        {
            if (!arg1.nonSkill)
            {
                obj_Player.scripts.DemonWhisper.config.converted++;
            }
        }
    }
    if (variable_struct_exists(arg0, "behaviours") && !variable_struct_exists(arg0.behaviours, "DemonWhisper"))
    {
        var newCopy = {};
        variable_struct_copy(obj_MobManager.behaviours.DemonWhisper, newCopy);
        arg0.behaviours.DemonWhisper = newCopy;
        obj_AttackController.ExecuteAttack("DemonWhisperCollision", arg0, 
        {
            sprite_index: arg0.sprite_index,
            mask_index: arg0.mask_index,
            attackDamageID: "DemonWhisper"
        });
        with (arg0)
        {
            UpdateBehaviorKeys();
        }
    }
    
    arg0.onDeath.DemonWhisper = function(arg0, arg1, arg2)
    {
        if (variable_struct_exists(arg1.buffs, "DemonWhisper"))
        {
            if (!arg1.buffs.DemonWhisper.config.nonSkill)
            {
                obj_Player.scripts.DemonWhisper.config.converted--;
            }
        }
    };
    
    arg0.customDrawScriptBelow.DemonWhisper = function(arg0)
    {
        draw_sprite_ext(spr_ChocoHeart, 0, arg0.x, arg0.y, arg0.image_xscale, arg0.image_yscale, 0, c_white, 0.7);
    };
}

function DemonWhisperRemove(arg0, arg1)
{
    arg0.isEnemy = true;
    arg0.invincible = true;
    arg0.invincibilityTimer = 5;
    arg0.ATK = arg0.baseStats.ATK;
    arg0.SPD = arg0.baseStats.SPD;
    arg0.spriteColor = 16777215;
    if (variable_struct_exists(obj_Player.scripts, "DemonWhisper"))
    {
        if (!arg0.buffs.DemonWhisper.config.nonSkill)
        {
            obj_Player.scripts.DemonWhisper.config.converted--;
        }
    }
    if (variable_struct_exists(arg0.customDrawScriptBelow, "DemonWhisper"))
    {
        variable_struct_remove(arg0.customDrawScriptBelow, "DemonWhisper");
    }
}

ds_map_set(Buffs, "DemonWhisper", 
{
    timer: 480,
    Apply: DemonWhisperApply,
    Callback: DemonWhisperRemove
});

function DeliciousCookingSuppliesApply(arg0, arg1)
{
}

function DeliciousCookingSuppliesRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "DeliciousCookingSupplies", 
{
    timer: -1,
    Apply: DeliciousCookingSuppliesApply,
    Callback: DeliciousCookingSuppliesRemove
});

function DeliciousCookingApply(arg0, arg1)
{
    arg0.CritMod += arg1.weight * arg1.stacks;
}

function DeliciousCookingRemove(arg0, arg1)
{
    arg0.CritMod -= arg1.weight * arg1.stacks;
}

ds_map_set(Buffs, "DeliciousCooking", 
{
    timer: 600,
    Apply: DeliciousCookingApply,
    Callback: DeliciousCookingRemove
});

function DynamiteBodyApply(arg0, arg1)
{
    arg0.ATK *= 0.3;
    arg0.BonusDamageTaken += 70;
    arg0.debuffIcons[0] = true;
    if (arg0.debuffIcons[1] == 0)
    {
        arg0.debuffIcons[1] += 1;
    }
    if (!variable_struct_exists(arg0.buffs, "DynamiteBody"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function DynamiteBodyRemove(arg0, arg1)
{
    arg0.ATK *= 3.3333333333333335;
    arg0.BonusDamageTaken -= 70;
    arg0.debuffIcons[1] -= 1;
    arg0.debuffIcons[0] = false;
}

ds_map_set(Buffs, "DynamiteBody", 
{
    timer: 600,
    Apply: DynamiteBodyApply,
    Callback: DynamiteBodyRemove
});

function CheekyDodgeApply(arg0, arg1)
{
}

function CheekyDodgeRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "CheekyDodge", 
{
    timer: -1,
    Apply: CheekyDodgeApply,
    Callback: CheekyDodgeRemove
});

function CheekyBratApply(arg0, arg1)
{
    arg0.ATK += arg1.amount;
}

function CheekyBratRemove(arg0, arg1)
{
    arg0.ATK -= arg1.amount;
}

ds_map_set(Buffs, "CheekyBrat", 
{
    timer: 600,
    Apply: CheekyBratApply,
    Callback: CheekyBratRemove
});

function BlackMagicApply(arg0, arg1)
{
}

function BlackMagicRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "BlackMagic", 
{
    timer: 480,
    Apply: BlackMagicApply,
    Callback: BlackMagicRemove
});

function GarlicBuffApply(arg0, arg1)
{
}

function GarlicBuffRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "GarlicBuff", 
{
    timer: -1,
    Apply: GarlicBuffApply,
    Callback: GarlicBuffRemove
});

function ShionSpecialApply(arg0, arg1)
{
    arg0.image_alpha = 0;
    arg0.stopAttacks = true;
    arg0.SPD += 0.5;
}

function ShionSpecialRemove(arg0, arg1)
{
    arg0.image_alpha = 1;
    arg0.stopAttacks = false;
    arg0.SPD -= 0.5;
}

ds_map_set(Buffs, "ShionSpecial", 
{
    timer: 200,
    Apply: ShionSpecialApply,
    Callback: ShionSpecialRemove
});

function AyameDefenseFieldApply(arg0, arg1)
{
}

function AyameDefenseFieldRemove(arg0, arg1)
{
    arg0.scripts.AyameDefenseField.config.timer = arg0.scripts.AyameDefenseField.config.maxTimer;
    obj_AttackController.ApplyBuff(arg0, "AyameDefenseFieldCD", ds_map_find_value(obj_AttackController.Buffs, "AyameDefenseFieldCD"), 
    {
        buffIcon: 1399
    });
    variable_struct_remove(arg0.customDrawScriptAbove, "AyameDefenseField");
}

ds_map_set(Buffs, "AyameDefenseField", 
{
    timer: 120,
    Apply: AyameDefenseFieldApply,
    Callback: AyameDefenseFieldRemove
});

function AyameDefenseFieldCDApply(arg0, arg1)
{
}

function AyameDefenseFieldCDRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "AyameDefenseFieldCD", 
{
    timer: 600,
    Apply: AyameDefenseFieldCDApply,
    Callback: AyameDefenseFieldCDRemove
});

function OniSpiritApply(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "OniSlash").resetTimer = ds_map_find_value(arg0.attacks, "OniSlash").resetTimer * 0.33;
    arg0.DR *= 0.5;
}

function OniSpiritRemove(arg0, arg1)
{
    ds_map_find_value(arg0.attacks, "OniSlash").resetTimer = ds_map_find_value(arg0.attacks, "OniSlash").resetTimer * 3;
    arg0.DR *= 2;
}

ds_map_set(Buffs, "OniSpirit", 
{
    timer: 240,
    Apply: OniSpiritApply,
    Callback: OniSpiritRemove
});

function NakiriumApply(arg0, arg1)
{
}

function NakiriumRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Nakirium", 
{
    timer: -1,
    Apply: NakiriumApply,
    Callback: NakiriumRemove
});

function OniLadyApply(arg0, arg1)
{
    arg0.haste += arg1.weight * arg1.stacks;
}

function OniLadyRemove(arg0, arg1)
{
    arg0.haste -= arg1.weight * arg1.stacks;
}

ds_map_set(Buffs, "OniLady", 
{
    timer: 60,
    Apply: OniLadyApply,
    Callback: OniLadyRemove
});

function DebuffATKApply(arg0, arg1)
{
    arg0.ATK -= 0.5;
    arg0.debuffIcons[0] += 1;
    if (!variable_struct_exists(arg0.buffs, "DebuffATK"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function DebuffATKRemove(arg0, arg1)
{
    arg0.ATK += 0.5;
    arg0.debuffIcons[0] -= 1;
}

ds_map_set(Buffs, "DebuffATK", 
{
    timer: 60,
    Apply: DebuffATKApply,
    Callback: DebuffATKRemove
});

function DebuffSPDApply(arg0, arg1)
{
    arg0.SPD -= 0.5;
    arg0.debuffIcons[2] += 1;
    if (!variable_struct_exists(arg0.buffs, "DebuffSPD"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function DebuffSPDRemove(arg0, arg1)
{
    arg0.SPD += 0.5;
    arg0.debuffIcons[2] -= 1;
}

ds_map_set(Buffs, "DebuffSPD", 
{
    timer: 60,
    Apply: DebuffSPDApply,
    Callback: DebuffSPDRemove
});

function AkaiDEFApply(arg0, arg1)
{
    if (arg0.debuffIcons[1] == 0)
    {
        arg0.debuffIcons[1] += 1;
    }
    arg0.BonusDamageTaken += arg1.amount1;
    if (!variable_struct_exists(arg0.buffs, "AkaiDEF"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function AkaiDEFRemove(arg0, arg1)
{
    if (arg0.debuffIcons[1] == 1)
    {
        arg0.debuffIcons[1] -= 1;
    }
    arg0.BonusDamageTaken -= arg1.amount1;
}

ds_map_set(Buffs, "AkaiDEF", 
{
    timer: 600,
    Apply: AkaiDEFApply,
    Callback: AkaiDEFRemove
});

function AkaiATKApply(arg0, arg1)
{
    if (arg0.debuffIcons[0] == 0)
    {
        arg0.debuffIcons[0] += 1;
    }
    arg0.ATK *= 1 - arg1.amount2;
    if (!variable_struct_exists(arg0.buffs, "AkaiATK"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function AkaiATKRemove(arg0, arg1)
{
    if (arg0.debuffIcons[0] == 1)
    {
        arg0.debuffIcons[0] -= 1;
    }
    arg0.ATK *= 1 / (1 - arg1.amount2);
}

ds_map_set(Buffs, "AkaiATK", 
{
    timer: 600,
    Apply: AkaiATKApply,
    Callback: AkaiATKRemove
});

function HoshinovaApply(arg0, arg1)
{
    arg0.ATK += arg1.weight;
}

function HoshinovaRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight;
}

ds_map_set(Buffs, "Hoshinova", 
{
    timer: -1,
    Apply: HoshinovaApply,
    Callback: HoshinovaRemove
});

function MoonaApply(arg0, arg1)
{
    arg0.DR *= arg1.weight;
}

function MoonaRemove(arg0, arg1)
{
    arg0.DR *= 1 / arg1.weight;
}

ds_map_set(Buffs, "Moona", 
{
    timer: 300,
    Apply: MoonaApply,
    Callback: MoonaRemove
});

function LunarConstructionApply(arg0, arg1)
{
}

function LunarConstructionRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "LunarConstruction", 
{
    timer: -1,
    Apply: LunarConstructionApply,
    Callback: LunarConstructionRemove
});

function MoonaSpecialApply(arg0, arg1)
{
    arg0.runSprite = arg0.sprites[1].sprite2;
    arg0.idleSprite = arg0.sprites[1].sprite1;
    arg0.ATK += 1;
    arg0.SPD += 1;
    arg0.scripts.MoonaSpecial = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
                    var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                    afterimage.sprite_index = arg0.sprite_index;
                    afterimage.image_speed = 0;
                    afterimage.image_index = arg0.image_index;
                    afterimage.image_xscale = arg0.image_xscale;
                    afterimage.image_yscale = arg0.image_yscale;
                    afterimage.afterimage_color = 65535;
                    afterimage.image_angle = arg0.image_angle;
                    afterimage.image_alpha = 0.8;
                    afterimage.grow = true;
                    afterimage.growthRate = 0.2;
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function MoonaSpecialRemove(arg0, arg1)
{
    arg0.runSprite = arg0.sprites[0].sprite2;
    arg0.idleSprite = arg0.sprites[0].sprite1;
    arg0.ATK -= 0.5;
    arg0.SPD -= 1;
    variable_struct_remove(arg0.scripts, "MoonaSpecial");
}

ds_map_set(Buffs, "MoonaSpecial", 
{
    timer: 720,
    Apply: MoonaSpecialApply,
    Callback: MoonaSpecialRemove
});

function CritVulnDebuffApply(arg0, arg1)
{
    arg0.CritVuln += arg1.amount;
    arg0.spriteColor = 32768;
}

function CritVulnDebuffRemove(arg0, arg1)
{
    arg0.CritVuln -= arg1.amount;
    arg0.spriteColor = 16777215;
}

ds_map_set(Buffs, "CritVulnDebuff", 
{
    timer: 600,
    Apply: CritVulnDebuffApply,
    Callback: CritVulnDebuffRemove
});

function PaintedApply(arg0, arg1)
{
    arg0.CritVuln += arg1.amount;
    arg0.spriteColor = make_color_hsv(irandom(255), 255, 255);
}

function PaintedRemove(arg0, arg1)
{
    arg0.CritVuln -= arg1.amount;
    arg0.spriteColor = 16777215;
}

ds_map_set(Buffs, "Painted", 
{
    timer: 600,
    Apply: PaintedApply,
    Callback: PaintedRemove
});

function AlienBrainwashingApply(arg0, arg1)
{
    arg0.crit += arg1.stacks * arg1.weight;
}

function AlienBrainwashingRemove(arg0, arg1)
{
    arg0.crit -= arg1.stacks * arg1.weight;
}

ds_map_set(Buffs, "AlienBrainwashing", 
{
    timer: 899,
    Apply: AlienBrainwashingApply,
    Callback: AlienBrainwashingRemove
});

function PolyglotApply(arg0, arg1)
{
    switch (arg1.stat)
    {
        case 0:
            arg0.ATK += global.SkillData.Polyglot.weight1[arg1.level - 1];
            break;
        case 1:
            arg0.SPD += global.SkillData.Polyglot.weight1[arg1.level - 1];
            break;
        case 2:
            arg0.crit += global.SkillData.Polyglot.weight2[arg1.level - 1];
            break;
        case 3:
            arg0.pickupRange += global.SkillData.Polyglot.weight1[arg1.level - 1] * 100;
            break;
        case 4:
            arg0.haste += global.SkillData.Polyglot.weight2[arg1.level - 1];
            break;
    }
}

function PolyglotRemove(arg0, arg1)
{
    switch (arg1.stat)
    {
        case 0:
            arg0.ATK -= global.SkillData.Polyglot.weight1[arg1.level - 1];
            break;
        case 1:
            arg0.SPD -= global.SkillData.Polyglot.weight1[arg1.level - 1];
            break;
        case 2:
            arg0.crit -= global.SkillData.Polyglot.weight2[arg1.level - 1];
            break;
        case 3:
            arg0.pickupRange -= global.SkillData.Polyglot.weight1[arg1.level - 1] * 100;
            break;
        case 4:
            arg0.haste -= global.SkillData.Polyglot.weight2[arg1.level - 1];
            break;
    }
}

ds_map_set(Buffs, "Polyglot", 
{
    timer: -1,
    Apply: PolyglotApply,
    Callback: PolyglotRemove
});

function PacifiedApply(arg0, arg1)
{
    arg0.canAttack = false;
    arg0.spriteColor = 8388736;
    if (variable_struct_exists(arg0, "behaviours") && variable_struct_exists(arg0.behaviours, "followPlayer"))
    {
        arg0.SPD = -arg0.SPD / 2;
    }
}

function PacifiedRemove(arg0, arg1)
{
    arg0.canAttack = true;
    arg0.spriteColor = 16777215;
    if (variable_struct_exists(arg0, "behaviours") && variable_struct_exists(arg0.behaviours, "followPlayer"))
    {
        arg0.SPD = -arg0.SPD * 2;
    }
}

ds_map_set(Buffs, "Pacified", 
{
    timer: 180,
    Apply: PacifiedApply,
    Callback: PacifiedRemove
});

function FocusShadesApply(arg0, arg1)
{
    if (!variable_struct_exists(arg0.scripts, "FocusShadeBleed"))
    {
        arg0.scripts.FocusShadeBleed = 
        {
            Script: function(arg0, arg1)
            {
                var timer, totalTimer;
                if (!instance_exists(arg0))
                {
                    exit;
                }
                if (arg1.timer == 0)
                {
                    arg1.timer = arg1.maxTimer;
                    var dmgObj = obj_AttackController.CalculateDamage(arg0, 227, 
                    {
                        damage: arg1.damage
                    });
                    if (instance_exists(arg0) && arg0.isEnemy)
                    {
                        arg0.spriteColor = make_color_rgb(255, 100, 100);
                        arg0.TakeDamage(dmgObj[0], 227, dmgObj[1], "FocusShades", undefined, undefined, undefined, false);
                    }
                }
                else
                {
                    arg1.timer--;
                }
                if (arg1.totalTimer == 0)
                {
                    if (instance_exists(arg0))
                    {
                        arg0.spriteColor = 16777215;
                        variable_struct_remove(arg0.scripts, "FocusShadeBleed");
                        obj_AttackController.RemoveBuff(arg0, "FocusShades");
                    }
                }
                else
                {
                    arg1.totalTimer--;
                }
            },
            
            config: 
            {
                damage: arg1.damage,
                timer: 0,
                maxTimer: 60,
                totalTimer: 301
            }
        };
    }
}

function FocusShadesRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "FocusShades", 
{
    timer: 301,
    Apply: FocusShadesApply,
    Callback: FocusShadesRemove
});

function UndeadApply(arg0, arg1)
{
    arg0.canNotDie = true;
    arg0.spriteColor = make_color_rgb(100, 100, 100);
    arg0.scripts.UndeadAE = 
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
                arg1.timer = 3;
                var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                afterimage.sprite_index = arg0.sprite_index;
                afterimage.image_speed = 0;
                afterimage.image_index = arg0.image_index;
                afterimage.image_xscale = arg0.image_xscale;
                afterimage.image_yscale = arg0.image_yscale;
                afterimage.afterimage_color = 0;
                afterimage.image_angle = arg0.image_angle;
                afterimage.image_alpha = 0.8;
                afterimage.grow = true;
                afterimage.growthRate = 0.15;
                afterimage.add = false;
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function UndeadRemove(arg0, arg1)
{
    arg0.canNotDie = false;
    arg0.spriteColor = 16777215;
    variable_struct_remove(arg0.scripts, "UndeadAE");
    obj_AttackController.ApplyBuff(arg0, "Undead2", ds_map_find_value(obj_AttackController.Buffs, "Undead2"), 
    {
        buffIcon: 225
    });
    arg0.scripts.Undead.config.timer = arg0.scripts.Undead.config.maxTimer;
    if (arg0.currentHP < 1)
    {
        arg0.Die();
    }
}

ds_map_set(Buffs, "Undead", 
{
    timer: global.SkillData.Undead.duration * 60,
    Apply: UndeadApply,
    Callback: UndeadRemove
});

function Undead2Apply(arg0, arg1)
{
}

function Undead2Remove(arg0, arg1)
{
}

ds_map_set(Buffs, "Undead2", 
{
    timer: global.SkillData.Undead.cooldown * 60,
    Apply: Undead2Apply,
    Callback: Undead2Remove
});

function UndeadPenaltyApply(arg0, arg1)
{
    arg0.scripts.Undead.config.hpLost = 0;
    var halfTimes = arg1.stacks;
    var halfHP = arg0.HP;
    var difference = 0;
    while (halfTimes > 0)
    {
        halfTimes--;
        halfHP /= 2;
        difference = arg0.HP - halfHP;
        arg0.HP = max(1, arg0.HP / 2);
        arg0.UpdateHP();
        arg0.scripts.Undead.config.hpLost += difference;
    }
}

function UndeadPenaltyRemove(arg0, arg1)
{
    if (!ds_map_find_value(global.PlayerSave, "challenge"))
    {
        arg0.HP += arg0.scripts.Undead.config.hpLost;
        arg0.UpdateHP();
    }
    arg0.scripts.Undead.config.hpLost = 0;
}

ds_map_set(Buffs, "UndeadPenalty", 
{
    timer: 3600,
    Apply: UndeadPenaltyApply,
    Callback: UndeadPenaltyRemove
});

function SimpOfAllTimeApply(arg0, arg1)
{
    arg0.haste += arg1.weight * 100;
    arg0.SPD += arg1.weight;
}

function SimpOfAllTimeRemove(arg0, arg1)
{
    arg0.haste -= arg1.weight * 100;
    arg0.SPD -= arg1.weight;
}

ds_map_set(Buffs, "SimpOfAllTime", 
{
    timer: 480,
    Apply: SimpOfAllTimeApply,
    Callback: SimpOfAllTimeRemove
});

function WindMagicApply(arg0, arg1)
{
    arg0.haste += arg1.weight * arg1.stacks;
}

function WindMagicRemove(arg0, arg1)
{
    arg0.haste -= arg1.weight * arg1.stacks;
}

ds_map_set(Buffs, "WindMagic", 
{
    timer: 300,
    Apply: WindMagicApply,
    Callback: WindMagicRemove
});

function AttentionPleaseApply(arg0, arg1)
{
    arg0.crit += arg1.weight * arg1.stacks;
}

function AttentionPleaseRemove(arg0, arg1)
{
    arg0.crit -= arg1.weight * arg1.stacks;
}

ds_map_set(Buffs, "AttentionPlease", 
{
    timer: 900,
    Apply: AttentionPleaseApply,
    Callback: AttentionPleaseRemove
});

function AttentionPleaseDebuffApply(arg0, arg1)
{
    arg0.SPD *= 1 - (global.SkillData.AttentionPlease.SPD / 100);
    if (arg0.debuffIcons[2] == 0)
    {
        arg0.debuffIcons[2] += 1;
    }
    if (!variable_struct_exists(arg0.buffs, "AttentionPleaseDebuff"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function AttentionPleaseDebuffRemove(arg0, arg1)
{
    arg0.SPD *= 1 / (1 - (global.SkillData.AttentionPlease.SPD / 100));
    arg0.debuffIcons[2] -= 1;
}

ds_map_set(Buffs, "AttentionPleaseDebuff", 
{
    timer: 300,
    Apply: AttentionPleaseDebuffApply,
    Callback: AttentionPleaseDebuffRemove
});

function LadyOfPeafowlApply(arg0, arg1)
{
    arg0.CritMod += arg1.weight * arg1.stacks;
}

function LadyOfPeafowlRemove(arg0, arg1)
{
    arg0.CritMod -= arg1.weight * arg1.stacks;
}

ds_map_set(Buffs, "LadyOfPeafowl", 
{
    timer: 600,
    Apply: LadyOfPeafowlApply,
    Callback: LadyOfPeafowlRemove
});

function TonjokApply(arg0, arg1)
{
    arg0.scripts.ReineSpecial = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
                    var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                    afterimage.sprite_index = arg0.sprite_index;
                    afterimage.image_speed = 0;
                    afterimage.image_index = arg0.image_index;
                    afterimage.image_xscale = arg0.image_xscale;
                    afterimage.image_yscale = arg0.image_yscale;
                    afterimage.afterimage_color = 16711680;
                    afterimage.image_angle = arg0.image_angle;
                    afterimage.image_alpha = 0.8;
                    afterimage.grow = true;
                    afterimage.growthRate = 0.1;
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function TonjokRemove(arg0, arg1)
{
    variable_struct_remove(arg0.scripts, "ReineSpecial");
}

ds_map_set(Buffs, "Tonjok", 
{
    timer: -1,
    Apply: TonjokApply,
    Callback: TonjokRemove
});

function KanaCocoEffectApply(arg0, arg1)
{
    arg0.DB += 0.3;
}

function KanaCocoEffectRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "KanaCocoEffect", 
{
    timer: -1,
    Apply: KanaCocoEffectApply,
    Callback: KanaCocoEffectRemove
});

function SnowQueenEffectApply(arg0, arg1)
{
    arg0.crit += 20;
}

function SnowQueenEffectRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "SnowQueenEffect", 
{
    timer: -1,
    Apply: SnowQueenEffectApply,
    Callback: SnowQueenEffectRemove
});

function JingisukanEffectApply(arg0, arg1)
{
    if (!ds_map_find_value(global.PlayerSave, "challenge"))
    {
        arg0.HP += 100;
        arg0.UpdateHP();
    }
}

function JingisukanEffectRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "JingisukanEffect", 
{
    timer: -1,
    Apply: JingisukanEffectApply,
    Callback: JingisukanEffectRemove
});

function IdolLiveEffectApply(arg0, arg1)
{
    arg0.specMod -= 0.3;
}

function IdolLiveEffectRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "IdolLiveEffect", 
{
    timer: -1,
    Apply: IdolLiveEffectApply,
    Callback: IdolLiveEffectRemove
});

function IdolLiveBuffApply(arg0, arg1)
{
    arg0.ATK += 0.5;
    arg0.SPD += 0.5;
    arg0.pickupRange += 50;
    arg0.haste += 50;
    arg0.crit += 50;
    arg0.IdolLiveEmitter = part_emitter_create(global.psystem);
    arg0.scripts.IdolLive.config.emitterOn = true;
}

function IdolLiveBuffRemove(arg0, arg1)
{
    arg0.ATK -= 0.5;
    arg0.SPD -= 0.5;
    arg0.pickupRange -= 50;
    arg0.haste -= 50;
    arg0.crit -= 50;
    arg0.scripts.IdolLive.config.emitterOn = false;
}

ds_map_set(Buffs, "IdolLiveBuff", 
{
    timer: 600,
    Apply: IdolLiveBuffApply,
    Callback: IdolLiveBuffRemove
});

function LivingWeaponApply(arg0, arg1)
{
    arg0.ATK += arg1.weight * (arg1.stacks div 10);
    if (arg1.stacks >= 10)
    {
        if (variable_struct_exists(arg0.scripts, "LivingWeapon"))
        {
            if (arg0.scripts.LivingWeapon.config.aura == -1)
            {
                arg0.scripts.LivingWeapon.config.aura = obj_AttackController.ExecuteAttack("LivingWeapon", 227, 
                {
                    level: arg1.level
                });
            }
        }
    }
}

function LivingWeaponRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight * (arg1.stacks div 10);
}

ds_map_set(Buffs, "LivingWeapon", 
{
    timer: -1,
    Apply: LivingWeaponApply,
    Callback: LivingWeaponRemove
});

function RestingApply(arg0, arg1)
{
    arg0.DB -= 0.07 * arg1.stacks;
    arg0.DR *= 1 - (0.05 * arg1.stacks);
    
    arg0.customDrawScriptAbove.Slumber = function(arg0)
    {
        draw_sprite_ext(spr_AnyaSleepBubble, 0, arg0.x, arg0.y - 16, (arg0.buffs.Resting.config.stacks * 0.1) + 1, (arg0.buffs.Resting.config.stacks * 0.1) + 1, 0, c_white, 0.2 + (arg0.buffs.Resting.config.stacks * 0.1));
    };
}

function RestingRemove(arg0, arg1)
{
    arg0.DB += 0.07 * arg1.stacks;
    arg0.DR *= 1 / (1 - (0.05 * arg1.stacks));
    variable_struct_remove(arg0.customDrawScriptAbove, "Slumber");
}

ds_map_set(Buffs, "Resting", 
{
    timer: 130,
    Apply: RestingApply,
    Callback: RestingRemove
});

function AwakeApply(arg0, arg1)
{
}

function AwakeRemove(arg0, arg1)
{
}

ds_map_set(Buffs, "Awake", 
{
    timer: 120,
    Apply: AwakeApply,
    Callback: AwakeRemove
});

function SlumberSPDDebuffApply(arg0, arg1)
{
    arg0.SPD *= 1 - global.SkillData.Slumber.SPD;
    if (arg0.debuffIcons[2] == 0)
    {
        arg0.debuffIcons[2] += 1;
    }
    if (!variable_struct_exists(arg0.buffs, "SlumberSPDDebuff"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
}

function SlumberSPDDebuffRemove(arg0, arg1)
{
    arg0.SPD *= 1 / (1 - global.SkillData.Slumber.SPD);
    arg0.debuffIcons[2] -= 1;
}

ds_map_set(Buffs, "SlumberSPDDebuff", 
{
    timer: 90,
    Apply: SlumberSPDDebuffApply,
    Callback: SlumberSPDDebuffRemove
});

function BladeFormApply(arg0, arg1)
{
    arg0.image_alpha = 0;
    arg0.SPD += 1;
}

function BladeFormRemove(arg0, arg1)
{
    arg0.image_alpha = 1;
    arg0.SPD -= 1;
}

ds_map_set(Buffs, "BladeForm", 
{
    timer: 480,
    Apply: BladeFormApply,
    Callback: BladeFormRemove
});

function Ore1Apply(arg0, arg1)
{
    arg0.weaponBonus += 0.01 * arg1.stacks;
}

function Ore1Remove(arg0, arg1)
{
    arg0.weaponBonus -= 0.01 * arg1.stacks;
}

ds_map_set(Buffs, "Ore1", 
{
    timer: -1,
    Apply: Ore1Apply,
    Callback: Ore1Remove
});

function Ore2Apply(arg0, arg1)
{
    arg0.weaponBonus += 0.02 * arg1.stacks;
}

function Ore2Remove(arg0, arg1)
{
    arg0.weaponBonus -= 0.02 * arg1.stacks;
}

ds_map_set(Buffs, "Ore2", 
{
    timer: -1,
    Apply: Ore2Apply,
    Callback: Ore2Remove
});

function Ore3Apply(arg0, arg1)
{
    arg0.weaponBonus += 0.03 * arg1.stacks;
}

function Ore3Remove(arg0, arg1)
{
    arg0.weaponBonus -= 0.03 * arg1.stacks;
}

ds_map_set(Buffs, "Ore3", 
{
    timer: -1,
    Apply: Ore3Apply,
    Callback: Ore3Remove
});

function NoPressureApply(arg0, arg1)
{
    arg0.SPD *= 0.85;
    if (!variable_struct_exists(arg0.buffs, "NoPressure"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
    arg0.debuffIcons[2] += 1;
}

function NoPressureRemove(arg0, arg1)
{
    arg0.SPD *= 1.1764705882352942;
    arg0.kaelaPressure -= 1;
    arg0.debuffIcons[2] -= 1;
}

ds_map_set(Buffs, "NoPressure", 
{
    timer: 240,
    Apply: NoPressureApply,
    Callback: NoPressureRemove
});

function HappinessApply(arg0, arg1)
{
    arg0.ATK += 0.5;
    arg0.SPD += 0.5;
    arg0.haste += 50;
    arg0.scripts.Happiness = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
                    var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
                    afterimage.sprite_index = arg0.sprite_index;
                    afterimage.image_speed = 0;
                    afterimage.image_index = arg0.image_index;
                    afterimage.image_xscale = arg0.image_xscale;
                    afterimage.image_yscale = arg0.image_yscale;
                    afterimage.afterimage_color = 65535;
                    afterimage.image_angle = arg0.image_angle;
                    afterimage.image_alpha = 0.8;
                    afterimage.grow = true;
                    afterimage.growthRate = 0.1;
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function HappinessRemove(arg0, arg1)
{
    arg0.ATK -= 0.5;
    arg0.SPD -= 0.5;
    arg0.haste -= 50;
    variable_struct_remove(arg0.scripts, "Happiness");
}

ds_map_set(Buffs, "Happiness", 
{
    timer: 600,
    Apply: HappinessApply,
    Callback: HappinessRemove
});

function SprintApply(arg0, arg1)
{
    arg0.SPD += 2;
}

function SprintRemove(arg0, arg1)
{
    arg0.SPD -= 2;
}

ds_map_set(Buffs, "Sprint", 
{
    timer: 15,
    Apply: SprintApply,
    Callback: SprintRemove
});

function SecretAgentApply(arg0, arg1)
{
    arg0.onTakeDamage.SecretAgent = function(arg0, arg1, arg2, arg3)
    {
        if (!variable_struct_exists(arg3.buffs, "Invisible"))
        {
            soundPlay([134], "invisible", 30, 0, true);
            obj_AttackController.ApplyBuff(arg3, "Invisible", ds_map_find_value(obj_AttackController.Buffs, "Invisible"), 
            {
                buffIcon: 2166
            });
            arg0 = 0;
            arg3.invincible = true;
            arg3.invincibilityTimer = max(240, arg3.invincibilityTimer);
            obj_AttackController.RemoveBuff(arg3, "SecretAgent");
        }
        return arg0;
    };
}

function SecretAgentRemove(arg0, arg1)
{
    variable_struct_remove(arg0.onTakeDamage, "SecretAgent");
    arg0.scripts.SecretAgent.config.timer = arg0.scripts.SecretAgent.config.maxTimer;
}

ds_map_set(Buffs, "SecretAgent", 
{
    timer: -1,
    Apply: SecretAgentApply,
    Callback: SecretAgentRemove
});

function CatReflexesApply(arg0, arg1)
{
    arg0.crit += arg1.weight;
}

function CatReflexesRemove(arg0, arg1)
{
    arg0.crit -= arg1.weight;
}

ds_map_set(Buffs, "CatReflexes", 
{
    timer: -1,
    Apply: CatReflexesApply,
    Callback: CatReflexesRemove
});

function CatReflexes2Apply(arg0, arg1)
{
    arg0.crit += arg1.weight;
}

function CatReflexes2Remove(arg0, arg1)
{
    arg0.crit -= arg1.weight;
}

ds_map_set(Buffs, "CatReflexes2", 
{
    timer: -1,
    Apply: CatReflexes2Apply,
    Callback: CatReflexes2Remove
});

function InvisibleApply(arg0, arg1)
{
    arg0.image_alpha = 0.3;
}

function InvisibleRemove(arg0, arg1)
{
    arg0.image_alpha = 1;
}

ds_map_set(Buffs, "Invisible", 
{
    timer: 240,
    Apply: InvisibleApply,
    Callback: InvisibleRemove
});

function PraiseApply(arg0, arg1)
{
    arg0.ATK += arg1.weight;
}

function PraiseRemove(arg0, arg1)
{
    arg0.ATK -= arg1.weight;
}

ds_map_set(Buffs, "Praise", 
{
    timer: 600,
    Apply: PraiseApply,
    Callback: PraiseRemove
});

function UnderwaterApply(arg0, arg1)
{
    arg0.SPD += 1;
    arg0.scripts.KoboSpecial = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg0.currentHP > 0)
            {
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
                else
                {
                    arg1.timer = 3;
                    var randSize = 0.15 + random(0.3);
                    var vfx = instance_create_depth((arg0.x - 10) + irandom(20), arg0.y - 10 - irandom(5), arg0.depth - 55, obj_vfx);
                    vfx.sprite_index = spr_KoboBubbles;
                    vfx.image_speed = 0;
                    vfx.image_xscale = randSize;
                    vfx.image_yscale = randSize;
                    vfx.image_alpha = 0.8;
                    vfx.duration = 25;
                    vfx.add = true;
                    vfx.vspeed = -1 - random(2);
                }
            }
        },
        
        config: 
        {
            timer: 0
        }
    };
}

function UnderwaterRemove(arg0, arg1)
{
    arg0.SPD -= 1;
    variable_struct_remove(arg0.scripts, "KoboSpecial");
}

ds_map_set(Buffs, "Underwater", 
{
    timer: 600,
    Apply: UnderwaterApply,
    Callback: UnderwaterRemove
});

function UnderwaterDebuffApply(arg0, arg1)
{
    arg0.SPD *= 0.25;
    if (!variable_struct_exists(arg0.buffs, "UnderwaterDebuff"))
    {
        obj_AttackController.DebuffVFX(arg0);
    }
    arg0.debuffIcons[2] += 1;
}

function UnderwaterDebuffRemove(arg0, arg1)
{
    arg0.SPD *= 4;
    arg0.debuffIcons[2] -= 1;
}

ds_map_set(Buffs, "UnderwaterDebuff", 
{
    timer: 60,
    Apply: UnderwaterDebuffApply,
    Callback: UnderwaterDebuffRemove
});
