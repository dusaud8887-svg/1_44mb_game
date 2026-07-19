defaultConfig = 
{
    sprite_index: false,
    image_alpha: 1,
    image_xscale: 1,
    image_yscale: 1,
    image_angle: 0,
    afterImageColor: false,
    customDrawScriptBelow: false,
    customDrawScriptAbove: false,
    drawBehind: false,
    drawUnderAll: false,
    transparent: false,
    spriteColor: 16777215,
    fadeOut: false,
    fadeTime: 10,
    applyWeaponSize: false,
    stayOnCreator: false,
    script: false,
    onCreate: false,
    duration: -1,
    horizontalOnly: false,
    faceCreatorDirection: false,
    knockback: false,
    collides: true,
    destroyOnHitLimit: false,
    hitbox: false,
    noMultiples: false,
    resetSequence: false,
    subAttacks: [],
    countID: 0,
    eraseAttacks: false,
    eraseChance: 20,
    erasable: true,
    playSound: false,
    soundChannel: "projectiles",
    soundPrio: 5,
    soundCD: 5,
    soundPitch: false,
    startx: 0,
    starty: -16,
    startDistDirection: false,
    startDirection: 0,
    direction: 0,
    height: 0,
    StampVars: {},
    reverse: 0,
    isSkill: false,
    stepDirection: 0,
    stepx: 0,
    stepy: 0,
    flipx: 0,
    flipy: 0,
    attackCount: 1,
    maxAttackCount: 99,
    attackDelay: 0,
    lockCreatorDir: 0,
    optionIcon: 2173,
    optionType: "attack",
    optionName: "You forgot to put an attack name",
    optionDescription: "You forgot to put a description",
    weaponType: "None",
    damage: 0,
    effectDamage: 1,
    attackTime: 60,
    minDelay: 1,
    hitCD: 10,
    hitLimit: 1,
    deflects: 0,
    ogHitLimit: 1,
    level: 0,
    bonusCrit: 0,
    statusEffects: {},
    onHitEffects: {},
    availableMods: [],
    gainedMods: [],
    isMain: false,
    createdAttacks: [],
    CritMod: 0,
    isMelee: false,
    canAddProjectile: false,
    projOrientation: "",
    onDestroyedByHitLimit: 
    {
        Script: function(arg0, arg1)
        {
        },
        
        config: {}
    },
    onDeflect: {},
    weight: 3,
    enhancements: 0,
    maxLevel: 1,
    levels: [],
    projSpeed: 10,
    range: 320,
    homing: false,
    targetRandom: true,
    updatedDirection: false
};

function Attack(arg0, arg1, arg2) constructor
{
    attackID = arg0;
    config = {};
    variable_struct_copy(arg1, config);
    if (arg2)
    {
        variable_struct_copy(arg2, config);
    }
    config.attackID = arg0;
    config.optionID = arg0;
    config.level = 0;
    
    function Level(arg0)
    {
        config.level = arg0;
        for (var n = 0; n < (arg0 - 1); n++)
        {
            UpdateConfig(config.levels[n].config);
            if (config.resetSequence)
            {
                RemoveSequenceConfigIfExists();
            }
        }
    }
    
    function UpdateConfig(arg0)
    {
        var newConfig = {};
        variable_struct_copy(config, newConfig);
        variable_struct_copy(arg0, newConfig);
        var OHENames = variable_struct_get_names(config.onHitEffects);
        for (var i = 0; i < array_length(OHENames); i++)
        {
            if (!variable_struct_exists(newConfig.onHitEffects, OHENames[i]))
            {
                variable_struct_set(newConfig.onHitEffects, OHENames[i], variable_struct_get(config.onHitEffects, OHENames[i]));
            }
        }
        config = newConfig;
    }
    
    function RemoveSequenceConfigIfExists()
    {
        var playerAttack = ds_map_find_value(obj_Player.attacks, attackID);
        if (variable_struct_exists(playerAttack, "sequenceConfig"))
        {
            playerAttack.timer = max(playerAttack.config.minDelay, round(playerAttack.resetTimer / (1 + (obj_Player.haste / 100))));
            playerAttack.attackDelay = playerAttack.config.attackDelay;
            playerAttack.attackCount = 0;
            playerAttack.countID = 0;
            variable_struct_remove(playerAttack, "sequenceConfig");
        }
    }
}

if (variable_global_exists("newAttacks") && ds_exists(global.newAttacks, ds_type_map))
{
    ds_map_destroy(global.newAttacks);
    global.newAttacks = -1;
}
attackIndex = ds_map_create();
global.newAttacks = attackIndex;

function CircleHitbox()
{
    var targets = ds_list_create();
    if (!instance_exists(obj_Enemy))
    {
        exit;
    }
    var numberOfTargets = collision_ellipse_list(x - radius, y - (radius / 1.8), x + radius, y + (radius / 1.8), 367, true, true, targets, false);
    if (numberOfTargets > 0)
    {
        for (var i = 0; i < ds_list_size(targets); i++)
        {
            self.HitTarget(ds_list_find_value(targets, i));
        }
    }
    ds_list_destroy(targets);
    targets = -1;
}

function CircleHitboxDrawDebug()
{
    if (global.debug)
    {
        draw_set_colour(c_red);
        draw_ellipse(x - radius, y - (radius / 1.8), x + radius, y + (radius / 1.8), false);
        depth = -10000;
    }
}

function CircleHitboxDrawDebug2()
{
    if (global.debug)
    {
        draw_set_colour(c_red);
        draw_ellipse(x - radius, y - radius, x + radius, y + radius, false);
        depth = -10000;
    }
}

ds_map_set(attackIndex, "CircleHitbox", new Attack("CircleHitbox", defaultConfig, 
{
    hitLimit: -1,
    onCreate: CircleHitbox,
    collides: false,
    customDrawScriptBelow: CircleHitboxDrawDebug
}));
ds_map_set(attackIndex, "GuraTridentThrust", new Attack("GuraTridentThrust", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 70,
    damage: 1.6,
    faceCreatorDirection: true,
    sprite_index: spr_GuraTridentThrust,
    playSound: [114],
    image_xscale: 1.25,
    image_yscale: 1.5,
    hitLimit: -1,
    isMelee: true,
    hitCD: 20,
    isMain: true,
    levels: [
    {
        config: 
        {
            damage: 1.92,
            optionName: global.TextContainer.guraAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            startDirection: 5,
            stepDirection: -10,
            attackDelay: 3,
            optionName: global.TextContainer.guraAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 56,
            optionName: global.TextContainer.guraAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2.688,
            optionName: global.TextContainer.guraAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.56,
            image_yscale: 1.875,
            optionName: global.TextContainer.guraAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: 15,
            stepDirection: -15,
            attackDelay: 3,
            optionIcon: 239,
            optionName: global.TextContainer.guraAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    weaponType: "Melee",
    optionIcon: 1595,
    optionName: global.TextContainer.guraAttackName.selectedLanguage,
    optionDescription: global.TextContainer.guraAttackDesc.selectedLanguage[0]
}));

CustomDrawCalliSlash1 = function(arg0, arg1)
{
    if (!variable_instance_exists(arg0, "lockDirection"))
    {
        arg0.lockDirection = arg1.direction;
    }
    draw_sprite_ext(spr_CalliSlash2, arg0.image_index, arg1.x, arg1.y - 16, arg0.image_xscale, arg0.image_yscale, arg0.lockDirection - arg0.reverse, c_white, 1);
};

ds_map_set(attackIndex, "CalliSlash1", new Attack("CalliSlash1", defaultConfig, 
{
    stayOnCreator: true,
    faceCreatorDirection: true,
    attackTime: 100,
    damage: 1.4,
    hitLimit: -1,
    isMelee: true,
    sprite_index: spr_CalliSlash1,
    hitCD: 30,
    playSound: [114],
    levels: [
    {
        config: 
        {
            damage: 1.68,
            optionName: global.TextContainer.calliAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.15,
            image_yscale: 1.15,
            optionName: global.TextContainer.calliAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 2.184,
            optionName: global.TextContainer.calliAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 90,
            optionName: global.TextContainer.calliAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.25,
            image_yscale: 1.25,
            optionName: global.TextContainer.calliAttackName.selectedLanguage + " LVL 6",
            optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 3.0576,
            onHitEffects: 
            {
                Death: 
                {
                    chance: 10
                }
            },
            customDrawScriptBelow: CustomDrawCalliSlash1,
            optionIcon: 296,
            optionName: global.TextContainer.calliAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    attackDamageID: "ScytheSwing",
    optionIcon: 1485,
    optionName: global.TextContainer.calliAttackName.selectedLanguage,
    optionDescription: global.TextContainer.calliAttackDesc.selectedLanguage[0]
}));

ChainTentacle = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 20)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        ExecuteAttack("ChainTentacle", arg0.creator, 
        {
            damage: arg0.damage * 0.85,
            CritMod: arg0.CritMod,
            enhancements: arg0.enhancements,
            firstTentacle: arg0,
            StampVars: copyStampVars,
            onHitEffects: totalOnHitEffects,
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale,
            afterImageColor: arg0.afterImageColor,
            knockback: arg0.knockback,
            playSound: arg0.playSound
        });
    }
    arg0.lifetime++;
};

SecondTentacle = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.visible = true;
        if (instance_exists(arg0.firstTentacle))
        {
            arg0.x = arg0.firstTentacle.x + lengthdir_x(240, arg0.firstTentacle.direction);
            arg0.y = arg0.firstTentacle.y + lengthdir_y(240, arg0.firstTentacle.direction);
        }
        else
        {
            with (arg0)
            {
                instance_destroy();
                exit;
            }
        }
        arg0.image_angle = arg0.direction;
        if (!variable_instance_exists(arg0, "noChain"))
        {
            if (!variable_instance_exists(arg0, "target"))
            {
                targets = ds_list_create();
                numTargets = collision_circle_list(arg1.x, arg1.y, arg0.range, obj_Enemy, false, true, targets, true);
                targets = RemoveFriendly(targets);
                numTargets = ds_list_size(targets);
                if (numTargets == 0)
                {
                    arg0.target = "noTarget";
                    arg0.direction = arg1.direction;
                }
                else if (arg0.targetRandom)
                {
                    randomIndex = floor(random(numTargets));
                    arg0.target = ds_list_find_value(targets, randomIndex);
                }
                else
                {
                    arg0.target = ds_list_find_value(targets, 0);
                }
                ds_list_destroy(targets);
                targets = -1;
            }
            if (arg0.target != "noTarget" && instance_exists(arg0.target))
            {
                arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
                arg0.image_angle = arg0.direction;
            }
            var totalOnHitEffects = {};
            var copyStampVars = {};
            variable_struct_copy(arg0.StampVars, copyStampVars);
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            ExecuteAttack("ChainTentacle", arg0.creator, 
            {
                damage: arg0.damage,
                CritMod: arg0.CritMod,
                direction: arg0.direction - 20,
                image_xscale: arg0.image_xscale,
                image_yscale: arg0.image_yscale,
                enhancements: arg0.enhancements,
                firstTentacle: arg0.firstTentacle,
                StampVars: copyStampVars,
                onHitEffects: totalOnHitEffects,
                noChain: true,
                afterImageColor: arg0.afterImageColor,
                knockback: arg0.knockback,
                playSound: arg0.playSound
            });
            ExecuteAttack("ChainTentacle", arg0.creator, 
            {
                damage: arg0.damage,
                CritMod: arg0.CritMod,
                image_xscale: arg0.image_xscale,
                image_yscale: arg0.image_yscale,
                direction: arg0.direction + 20,
                enhancements: arg0.enhancements,
                firstTentacle: arg0.firstTentacle,
                StampVars: copyStampVars,
                onHitEffects: totalOnHitEffects,
                noChain: true,
                afterImageColor: arg0.afterImageColor,
                knockback: arg0.knockback,
                playSound: arg0.playSound
            });
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "ChainTentacle", new Attack("ChainTentacle", defaultConfig, 
{
    stayOnCreator: false,
    faceCreatorDirection: false,
    attackTime: 90,
    hitLimit: -1,
    hitCD: 60,
    isMelee: true,
    sprite_index: spr_InaAttackFX,
    playSound: [287],
    image_xscale: 1.875,
    image_yscale: 1.875,
    script: SecondTentacle,
    lifetime: 0,
    visible: false,
    isMain: true,
    weaponType: "Melee",
    attackDamageID: "InaTentacle"
}));
ds_map_set(attackIndex, "InaTentacle", new Attack("InaTentacle", defaultConfig, 
{
    stayOnCreator: true,
    faceCreatorDirection: true,
    attackTime: 90,
    damage: 1.2,
    hitLimit: -1,
    hitCD: 20,
    isMelee: true,
    sprite_index: spr_InaAttackFX,
    playSound: [287],
    image_xscale: 1.5,
    image_yscale: 1.5,
    levels: [
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.inaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 78,
            optionName: global.TextContainer.inaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.875,
            image_yscale: 1.875,
            optionName: global.TextContainer.inaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2.16,
            optionName: global.TextContainer.inaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 5,
                speed: 5
            },
            optionName: global.TextContainer.inaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            script: ChainTentacle,
            lifetime: 0,
            optionIcon: 344,
            optionName: global.TextContainer.inaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 1813,
    optionName: global.TextContainer.inaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.inaAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "AmePistol", new Attack("AmePistol", defaultConfig, 
{
    sprite_index: spr_Ame_bullet,
    attackTime: 80,
    duration: 120,
    damage: 1,
    playSound: [125],
    soundPitch: true,
    hitLimit: 1,
    speed: 5,
    hitCD: 20,
    faceCreatorDirection: true,
    homing: false,
    targetRandom: true,
    canAddProjectile: true,
    attackCount: 3,
    attackDelay: 6,
    destroyOnHitLimit: true,
    projOrientation: "none",
    range: 100,
    levels: [
    {
        config: 
        {
            attackCount: 5,
            hitLimit: 2,
            optionName: global.TextContainer.ameAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.ameAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            ogHitLimit: 3,
            deflects: 1,
            optionName: global.TextContainer.ameAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            hitLimit: 3,
            attackTime: 60,
            optionName: global.TextContainer.ameAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.ameAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                TimeTravelAttack: 
                {
                    storePercent: 0.15
                }
            },
            optionIcon: 1760,
            optionName: global.TextContainer.ameAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 480,
    optionName: global.TextContainer.ameAttackName.selectedLanguage,
    optionDescription: global.TextContainer.ameAttackDesc.selectedLanguage[0]
}));

SetBurnCD = function(arg0, arg1)
{
    if (!variable_struct_exists(arg1.scripts, "KiaraSlash"))
    {
        arg1.scripts.KiaraSlash = 
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
                maxTimer: 5
            }
        };
    }
};

ds_map_set(attackIndex, "KiaraSlash", new Attack("KiaraSlash", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 70,
    damage: 1.3,
    faceCreatorDirection: true,
    sprite_index: spr_KiaraSlash,
    playSound: [34],
    isMelee: true,
    image_xscale: 0.8,
    image_yscale: 0.8,
    hitLimit: -1,
    hitCD: 20,
    levels: [
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.kiaraAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1,
            image_yscale: 1,
            optionName: global.TextContainer.kiaraAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 60,
            optionName: global.TextContainer.kiaraAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            hitCD: 5,
            optionName: global.TextContainer.kiaraAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.872,
            optionName: global.TextContainer.kiaraAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 0.65,
            hitCD: 4,
            sprite_index: spr_KiaraFireSlash,
            image_xscale: 1.25,
            image_yscale: 1.25,
            playSound: [132],
            onCreate: SetBurnCD,
            optionIcon: 2061,
            onHitEffects: 
            {
                SlashBurn: 
                {
                    chance: 25
                }
            },
            optionName: global.TextContainer.kiaraAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 425,
    optionName: global.TextContainer.kiaraAttackName.selectedLanguage,
    optionDescription: global.TextContainer.kiaraAttackDesc.selectedLanguage[0]
}));

Nephilim = function(arg0, arg1)
{
    var config = {};
    if (arg0.config.level > 1)
    {
        var level = arg0.config.level;
        variable_struct_copy(arg0.config.levels[level - 2].config, config);
    }
    if (variable_struct_exists(arg0, "StampVars"))
    {
        config.StampVars = {};
        variable_struct_copy(arg0.StampVars, config.StampVars);
    }
    if (variable_struct_exists(arg0, "onHitEffects"))
    {
        config.onHitEffects = {};
        variable_struct_copy(arg0.onHitEffects, config.onHitEffects);
    }
    config.enhancements = arg0.enhancements;
    config.afterImageColor = arg0.afterImageColor;
    config.attackDamageID = "NephilimBlast";
    config.reverse = arg0.reverse;
    config.knockback = arg0.knockback;
    if (!variable_struct_exists(config, "damage"))
    {
        config.damage = 1;
    }
    if (variable_instance_exists(arg0, "effectDamage"))
    {
        config.damage = config.damage * arg0.effectDamage;
    }
    ExecuteAttack("NephilimBlast1", arg1, config);
    ExecuteAttack("NephilimBlast2", arg1, config);
};

ds_map_set(attackIndex, "NephilimBlast", new Attack("NephilimBlast", defaultConfig, 
{
    attackTime: 70,
    duration: 1,
    range: 100,
    onCreate: Nephilim,
    collides: false,
    attackDelay: 3,
    canAddProjectile: true,
    projOrientation: "none",
    subAttacks: ["NephilimBlast1", "NephilimBlast2"],
    playSound: [189],
    levels: [
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.irysAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            spread: 30,
            damage: 1.2,
            hitLimit: 5,
            optionName: global.TextContainer.irysAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            spread: 30,
            attackTime: 52,
            damage: 1.2,
            hitLimit: 5,
            optionName: global.TextContainer.irysAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            spread: 30,
            damage: 1.2,
            hitLimit: -1,
            optionName: global.TextContainer.irysAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            spread: 30,
            damage: 1.596,
            hitLimit: -1,
            destroyOnHitLimit: false,
            optionName: global.TextContainer.irysAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            hitLimit: -1,
            spread: 30,
            attackTime: 65,
            attackCount: 7,
            attackDelay: 3,
            minDelay: 35,
            damage: 0.25,
            optionIcon: 1127,
            optionName: global.TextContainer.irysAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 1028,
    optionName: global.TextContainer.irysAttackName.selectedLanguage,
    optionDescription: global.TextContainer.irysAttackDesc.selectedLanguage[0]
}));

Nephilim1 = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        arg0.origin_x = arg1.x;
        arg0.origin_y = arg1.y - 16;
        arg0.image_alpha = 1;
    }
    arg0.origin_x += lengthdir_x(arg0.speed, arg0.direction);
    arg0.origin_y += lengthdir_y(arg0.speed, arg0.direction);
    arg0.x = arg0.origin_x + lengthdir_x(sin(1.5707963267948966 + arg0.lifetime) * arg0.spread, arg0.direction + 90);
    arg0.y = arg0.origin_y + lengthdir_y(sin(1.5707963267948966 + arg0.lifetime) * arg0.spread, arg0.direction + 90);
    arg0.lifetime += 0.2;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "NephilimBlast1", new Attack("NephilimBlast1", defaultConfig, 
{
    sprite_index: spr_Irysblast_light,
    attackTime: 70,
    duration: 120,
    damage: 1,
    hitLimit: 2,
    speed: 5,
    lifetime: 0,
    faceCreatorDirection: true,
    homing: false,
    applyWeaponSize: true,
    targetRandom: true,
    destroyOnHitLimit: true,
    range: 100,
    spread: 20,
    isMain: true,
    script: Nephilim1
}));

Nephilim2 = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        arg0.origin_x = arg1.x;
        arg0.origin_y = arg1.y - 16;
        arg0.image_alpha = 1;
    }
    arg0.origin_x += lengthdir_x(arg0.speed, arg0.direction);
    arg0.origin_y += lengthdir_y(arg0.speed, arg0.direction);
    arg0.x = arg0.origin_x + lengthdir_x(-sin(1.5707963267948966 + arg0.lifetime) * arg0.spread, arg0.direction + 90);
    arg0.y = arg0.origin_y + lengthdir_y(-sin(1.5707963267948966 + arg0.lifetime) * arg0.spread, arg0.direction + 90);
    arg0.lifetime += 0.2;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "NephilimBlast2", new Attack("NephilimBlast2", defaultConfig, 
{
    sprite_index: spr_Irysblast_dark,
    attackTime: 70,
    duration: 120,
    damage: 1,
    hitLimit: 2,
    applyWeaponSize: true,
    speed: 5,
    lifetime: 0,
    isMain: true,
    faceCreatorDirection: true,
    homing: false,
    targetRandom: true,
    destroyOnHitLimit: true,
    range: 100,
    spread: 20,
    script: Nephilim2
}));

PlayDice = function(arg0, arg1)
{
    var lifetime;
    if (arg0.diceValue == 0)
    {
        arg0.collides = true;
        arg0.diceValue = 1 + floor(random(6));
        arg0.damage = arg0.diceValue * 0.35 * arg0.damageBuff * arg0.effectDamage;
        arg0.image_index = arg0.diceValue - 1;
    }
    if (arg0.speed > 0)
    {
        arg0.lifetime++;
        arg0.speed -= 0.7;
        arg0.image_angle += 10;
    }
    else
    {
        arg0.speed = 0;
    }
    if (arg0.lifetime == 8)
    {
        arg0.hitLimit = 1;
    }
};

ds_map_set(attackIndex, "PlayDice", new Attack("PlayDice", defaultConfig, 
{
    sprite_index: spr_BaeDice,
    image_speed: 0,
    image_xscale: 1.2,
    image_yscale: 1.2,
    attackTime: 75,
    duration: 80,
    damage: 0,
    damageBuff: 1,
    hitLimit: -1,
    deflects: 3,
    speed: 16,
    lifetime: 0,
    hitCD: 30,
    destroyOnHitLimit: false,
    canAddProjectile: true,
    startDirection: 0,
    stepDirection: -20,
    faceCreatorDirection: true,
    homing: false,
    range: 100,
    playSound: [263],
    soundPitch: true,
    script: PlayDice,
    projOrientation: "frontSpread",
    diceValue: 0,
    collides: false,
    levels: [
    {
        config: 
        {
            damageBuff: 1.3,
            optionName: global.TextContainer.baeAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            startDirection: 10,
            stepDirection: -20,
            optionName: global.TextContainer.baeAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            speed: 19,
            image_xscale: 1.5,
            image_yscale: 1.5,
            optionName: global.TextContainer.baeAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 12,
                speed: 3
            },
            optionName: global.TextContainer.baeAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damageBuff: 1.69,
            optionName: global.TextContainer.baeAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: 15,
            stepDirection: -15,
            optionIcon: 2021,
            sprite_index: spr_BaeDice2,
            optionName: global.TextContainer.baeAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 187,
    optionName: global.TextContainer.baeAttackName.selectedLanguage,
    optionDescription: global.TextContainer.baeAttackDesc.selectedLanguage[0]
}));

Clock = function(arg0, arg1)
{
    var config = {};
    if (arg0.config.level > 1)
    {
        var level = arg0.config.level;
        config = arg0.config.levels[level - 2].config;
    }
    if (variable_struct_exists(arg0, "StampVars"))
    {
        config.StampVars = {};
        variable_struct_copy(arg0.StampVars, config.StampVars);
    }
    if (variable_struct_exists(arg0, "onHitEffects"))
    {
        config.onHitEffects = {};
        variable_struct_copy(arg0.onHitEffects, config.onHitEffects);
    }
    config.enhancements = arg0.enhancements;
    config.afterImageColor = arg0.afterImageColor;
    config.attackDamageID = "KroniiClock";
    config.reverse = arg0.reverse;
    config.CritMod = arg0.CritMod;
    config.knockback = arg0.knockback;
    config.playSound = arg0.playSound;
    config.knockback = arg0.knockback;
    config.baseSize = arg0.baseSize;
    config.effectDamage = arg0.effectDamage;
    if (!variable_struct_exists(config, "damage"))
    {
        config.damage = 1;
    }
    ExecuteAttack("KroniiBigHand", arg1, config);
    ExecuteAttack("KroniiSmallHand", arg1, config);
};

ds_map_set(attackIndex, "KroniiClock", new Attack("KroniiClock", defaultConfig, 
{
    attackTime: 90,
    duration: 1,
    range: 100,
    onCreate: Clock,
    isMelee: true,
    baseSize: 1,
    playSound: [169, 12, 207],
    collides: false,
    levels: [
    {
        config: 
        {
            baseSize: 1.2,
            baseSize: 1.2,
            optionName: global.TextContainer.kroniiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            baseSize: 1.2,
            baseSize: 1.2,
            baseDamage: 1.82,
            optionName: global.TextContainer.kroniiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            baseSize: 1.2,
            baseSize: 1.2,
            baseDamage: 1.82,
            attackTime: 81,
            optionName: global.TextContainer.kroniiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            baseSize: 1.56,
            baseSize: 1.56,
            baseDamage: 1.82,
            attackTime: 81,
            optionName: global.TextContainer.kroniiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            baseSize: 1.56,
            baseSize: 1.56,
            baseDamage: 1.82,
            attackTime: 69,
            optionName: global.TextContainer.kroniiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            baseSize: 1.56,
            baseSize: 1.56,
            baseDamage: 2.73,
            onHitEffects: 
            {
                TimeFreeze: 
                {
                    freezeTime: 20
                }
            },
            optionIcon: 59,
            optionName: global.TextContainer.kroniiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 261,
    optionName: global.TextContainer.kroniiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.kroniiAttackDesc.selectedLanguage[0]
}));

HandsMultiplier = function(arg0, arg1)
{
    arg0.damage = arg0.baseDamage * arg0.multiplier * arg0.effectDamage;
    arg0.image_xscale = arg0.baseSize * arg0.multiplier * arg1.weaponSizeMultiplier;
    arg0.image_yscale = arg0.baseSize * arg0.multiplier * arg1.weaponSizeMultiplier;
    if (arg0.multiplier == 0.8)
    {
        TargettedProjectile(arg0, arg1);
    }
};

ds_map_set(attackIndex, "KroniiBigHand", new Attack("KroniiBigHand", defaultConfig, 
{
    sprite_index: spr_KroniiStab,
    attackTime: 90,
    baseSize: 1,
    damage: 1,
    baseDamage: 1.4,
    multiplier: 1.2,
    hitLimit: -1,
    isMelee: true,
    lifetime: 0,
    hitCD: 45,
    playSound: [169, 12, 207],
    stayOnCreator: true,
    faceCreatorDirection: true,
    homing: false,
    freeze: true,
    isMain: true,
    script: HandsMultiplier
}));
ds_map_set(attackIndex, "KroniiSmallHand", new Attack("KroniiSmallHand", defaultConfig, 
{
    sprite_index: spr_KroniiStab,
    attackTime: 90,
    baseSize: 1,
    damage: 1,
    baseDamage: 1.4,
    multiplier: 0.8,
    isMelee: true,
    hitLimit: -1,
    lifetime: 0,
    hitCD: 45,
    script: TargettedProjectile,
    stayOnCreator: true,
    faceCreatorDirection: true,
    homing: false,
    isMain: true,
    script: HandsMultiplier
}));

FaunaLeaf = function(arg0, arg1)
{
    var lifetime;
    if ((arg0.lifetime < 60 && arg0.homing) || !arg0.homing)
    {
        arg0.speed = arg0.projSpeed;
        arg0.image_angle += 25;
        if (!variable_instance_exists(arg0, "lockedX"))
        {
            arg0.lockedX = arg1.x;
            arg0.lockedY = arg1.y;
        }
        arg0.direction += arg0.dirChange;
    }
    else if (arg0.lifetime >= 60 && arg0.homing)
    {
        if (arg0.lifetime == 60)
        {
            if (!variable_instance_exists(arg0, "target"))
            {
                targets = ds_list_create();
                numTargets = collision_circle_list(arg1.x, arg1.y, arg0.range, obj_Enemy, false, true, targets, true);
                targets = RemoveFriendly(targets);
                numTargets = ds_list_size(targets);
                if (numTargets == 0)
                {
                    arg0.target = "noTarget";
                    arg0.direction = arg1.direction;
                    arg0.image_angle = arg0.direction - 90;
                }
                else if (arg0.targetRandom)
                {
                    randomIndex = floor(random(numTargets));
                    arg0.target = ds_list_find_value(targets, randomIndex);
                }
                else
                {
                    arg0.target = ds_list_find_value(targets, 0);
                }
                ds_list_destroy(targets);
                targets = -1;
            }
            if (arg0.target != "noTarget" && instance_exists(arg0.target))
            {
                arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
                arg0.image_angle = arg0.direction - 90;
            }
        }
        arg0.speed = arg0.projSpeed * 4;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "FaunaLeaf", new Attack("FaunaLeaf", defaultConfig, 
{
    sprite_index: spr_FaunaAttack,
    attackTime: 100,
    damage: 1.1,
    hitLimit: 3,
    lifetime: 0,
    hitCD: 45,
    projSpeed: 5,
    script: FaunaLeaf,
    playSound: [220],
    attackCount: 3,
    canAddProjectile: true,
    stepDirection: 120,
    startDirection: 0,
    horizontalOnly: false,
    destroyOnHitLimit: true,
    faceCreatorDirection: true,
    duration: 90,
    dirChange: 4,
    homing: false,
    projOrientation: "circle",
    levels: [
    {
        config: 
        {
            damage: 1.32,
            hitLimit: 8,
            optionName: global.TextContainer.faunaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 85,
            optionName: global.TextContainer.faunaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 5,
            startDirection: 0,
            stepDirection: 72,
            optionName: global.TextContainer.faunaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.3,
            image_yscale: 1.3,
            hitLimit: 13,
            optionName: global.TextContainer.faunaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.716,
            optionName: global.TextContainer.faunaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 7,
            startDirection: 0,
            stepDirection: 360/7,
            hitLimit: -1,
            destroyOnHitLimit: false,
            homing: true,
            optionIcon: 655,
            optionName: global.TextContainer.faunaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 1337,
    optionName: global.TextContainer.faunaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.faunaAttackDesc.selectedLanguage[0]
}));

AwakenedFeather = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 16 || arg0.lifetime == 32 || arg0.lifetime == 48)
    {
        targets = ds_list_create();
        numTargets = collision_circle_list(arg0.x, arg0.y, arg0.range, obj_Enemy, false, true, targets, true);
        targets = RemoveFriendly(targets);
        numTargets = ds_list_size(targets);
        if (numTargets == 0)
        {
            arg0.target = "noTarget";
            arg0.direction = floor(random(360));
        }
        else
        {
            randomIndex = floor(random(numTargets));
            arg0.target = ds_list_find_value(targets, randomIndex);
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    arg0.image_angle = arg0.direction;
    arg0.speed = arg0.projSpeed;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MumeiFeather", new Attack("MumeiFeather", defaultConfig, 
{
    sprite_index: spr_MumeiFeather,
    attackTime: 90,
    duration: 25,
    damage: 1.2,
    hitCD: 15,
    playSound: [46],
    soundPitch: true,
    hitLimit: 5,
    speed: 9,
    homing: false,
    targetRandom: false,
    canAddProjectile: true,
    projOrientation: "none",
    attackCount: 2,
    stepDirection: 6,
    startDirection: -3,
    attackDelay: 5,
    destroyOnHitLimit: true,
    range: 120,
    faceCreatorDirection: true,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.mumeiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            hitLimit: 10,
            optionName: global.TextContainer.mumeiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: -6,
            stepDirection: 6,
            attackDelay: 4,
            optionName: global.TextContainer.mumeiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 63,
            hitLimit: 15,
            optionName: global.TextContainer.mumeiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            startDirection: -10,
            stepDirection: 4,
            attackDelay: 4,
            optionName: global.TextContainer.mumeiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            script: AwakenedFeather,
            duration: 60,
            image_xscale: 1.5,
            image_yscale: 1.5,
            projSpeed: 16,
            faceCreatorDirection: true,
            afterImageColor: 255,
            optionIcon: 1023,
            optionName: global.TextContainer.mumeiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 830,
    optionName: global.TextContainer.mumeiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.mumeiAttackDesc.selectedLanguage[0]
}));

SanaPlanet = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.collides = true;
    }
    if (arg0.countID == 0)
    {
        arg0.collides = true;
        arg0.x = arg1.x + (arg0.radius * cos((arg0.angle * pi) / 180));
        arg0.y = (arg1.y - 16) + (arg0.radius * sin((arg0.angle * pi) / 180));
        arg0.angle += arg0.projSpeed;
    }
    else
    {
        arg0.x = arg1.x - (arg0.radius * cos((arg0.angle * pi) / 180));
        arg0.y = (arg1.y - 16) + (arg0.radius * sin((arg0.angle * pi) / 180));
        arg0.angle -= arg0.projSpeed;
    }
    arg0.lifetime++;
    arg0.image_angle = 0;
    arg0.visible = true;
};

ds_map_set(attackIndex, "SanaPlanet", new Attack("SanaPlanet", defaultConfig, 
{
    sprite_index: spr_SanaPlanet1,
    attackTime: 90,
    duration: 50,
    damage: 1.5,
    hitCD: 20,
    collides: false,
    playSound: [295],
    hitLimit: -1,
    homing: false,
    targetRandom: false,
    destroyOnHitLimit: false,
    angle: 1,
    lifetime: 0,
    radius: 50,
    projSpeed: 8,
    range: 100,
    script: SanaPlanet,
    visible: false,
    afterImageColor: 65535,
    levels: [
    {
        config: 
        {
            damage: 1.8,
            optionName: global.TextContainer.sanaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            radius: 60,
            optionName: global.TextContainer.sanaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 2.394,
            optionName: global.TextContainer.sanaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.56,
            image_yscale: 1.56,
            radius: 72,
            optionName: global.TextContainer.sanaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 80,
            optionName: global.TextContainer.sanaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 10,
                speed: 3
            },
            attackCount: 2,
            startDirection: 0,
            stepDirection: 1,
            optionIcon: 478,
            optionName: global.TextContainer.sanaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 812,
    optionName: global.TextContainer.sanaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.sanaAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "FubukiFoxTail", new Attack("FubukiFoxTail", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 70,
    damage: 1.5,
    faceCreatorDirection: true,
    sprite_index: spr_FubukiFoxTail,
    playSound: [20],
    image_xscale: 1,
    image_yscale: 1,
    hitLimit: -1,
    isMelee: true,
    hitCD: 20,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.8,
            optionName: global.TextContainer.fubukiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.fubukiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 10,
            stepDirection: 180,
            optionName: global.TextContainer.fubukiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 59,
            optionName: global.TextContainer.fubukiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.44,
            image_yscale: 1.44,
            optionName: global.TextContainer.fubukiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            swordLimit: 10,
            onHitEffects: 
            {
                FubukiSwordHit: 
                {
                    chance: 20
                }
            },
            optionIcon: 2354,
            optionName: global.TextContainer.fubukiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 1107,
    optionName: global.TextContainer.fubukiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.fubukiAttackDesc.selectedLanguage[0]
}));

TarotCards = function(arg0, arg1)
{
    var lifetime;
    arg0.speed -= 1;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "TarotCards", new Attack("TarotCards", defaultConfig, 
{
    sprite_index: spr_MioTarot,
    attackTime: 80,
    duration: 30,
    damage: 1.2,
    hitCD: 15,
    playSound: [46],
    soundPitch: true,
    hitLimit: 20,
    speed: 15,
    script: TarotCards,
    targetRandom: false,
    destroyOnHitLimit: true,
    canAddProjectile: true,
    projOrientation: "frontSpread",
    range: 200,
    faceCreatorDirection: true,
    lifetime: 0,
    attackCount: 2,
    attackDelay: 3,
    startDirection: -3,
    stepDirection: 5,
    levels: [
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.mioAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: -5,
            stepDirection: 5,
            attackDelay: 3,
            optionName: global.TextContainer.mioAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 68,
            optionName: global.TextContainer.mioAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            speed: 20,
            duration: 40,
            damage: 2,
            optionName: global.TextContainer.mioAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            startDirection: -10,
            stepDirection: 5,
            attackDelay: 3,
            optionName: global.TextContainer.mioAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                TarotDebuff: 
                {
                    chance: 30
                }
            },
            afterImageColor: 255,
            optionIcon: 1068,
            optionName: global.TextContainer.mioAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 1015,
    isMain: true,
    weaponType: "MultiShot",
    optionName: global.TextContainer.mioAttackName.selectedLanguage,
    optionDescription: global.TextContainer.mioAttackDesc.selectedLanguage[0]
}));

OkayuOnigiri = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.horMove = lengthdir_x(arg0.projSpeed, arg0.direction) * (0.8 + random(0.4));
        arg0.verMove = (-3 + lengthdir_y(arg0.projSpeed, arg0.direction)) * (0.8 + random(0.4));
    }
    if (arg0.horMove > 10)
    {
        arg0.horMove = 10;
    }
    if (arg0.verMove > 10)
    {
        arg0.verMove = 10;
    }
    arg0.x += arg0.horMove;
    arg0.y += arg0.verMove;
    arg0.gravity = 0.2;
    arg0.image_angle += 10;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "OkayuOnigiri", new Attack("OkayuOnigiri", defaultConfig, 
{
    attackTime: 75,
    damage: 1.2,
    faceCreatorDirection: true,
    sprite_index: spr_OkayuOnigiri,
    playSound: [46],
    destroyOnHitLimit: true,
    ogHitLimit: 8,
    deflects: 1,
    image_xscale: 1,
    image_yscale: 1,
    duration: 120,
    canAddProjectile: true,
    projOrientation: "none",
    projSpeed: 4.5,
    horMove: 0,
    verMove: 0,
    hitLimit: 3,
    script: OkayuOnigiri,
    hitCD: 30,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.okayuAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 3,
            optionName: global.TextContainer.okayuAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.4,
            image_yscale: 1.4,
            optionName: global.TextContainer.okayuAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            attackDelay: 3,
            optionName: global.TextContainer.okayuAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            projSpeed: 5.4,
            optionName: global.TextContainer.okayuAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                OnigiriSlow: {}
            },
            attackCount: 6,
            attackDelay: 3,
            optionIcon: 924,
            optionName: global.TextContainer.okayuAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 1319,
    isMain: true,
    weaponType: "MultiShot",
    optionName: global.TextContainer.okayuAttackName.selectedLanguage,
    optionDescription: global.TextContainer.okayuAttackDesc.selectedLanguage[0]
}));

function _KoronePunchOnCreate(arg0, arg1)
{
    var coneArcSize = arg0.config.coneArcSize;
    var newDirection = (arg1.direction - (coneArcSize / 2)) + random(coneArcSize) + arg0.reverse;
    var randomSize = 0.6 + (sqrt(random(100)) / 25);
    arg0.direction = newDirection;
    arg0.speed = arg0.punchSpeed * arg1.weaponSizeMultiplier;
    arg0.x += lengthdir_x(12, arg0.direction);
    arg0.y += lengthdir_y(12, arg0.direction);
    arg0.arcDirection = ((newDirection - (arg1.direction + arg0.reverse)) > 0) ? -1 : 1;
    arg0.sprite_index = (arg0.arcDirection == 1) ? spr_KoronePunchAlt : spr_KoronePunch;
    arg0.image_angle = arg0.direction;
    arg0.image_xscale *= randomSize;
    arg0.image_yscale *= randomSize;
    arg0.x += lengthdir_x(abs(((newDirection - arg1.direction) / coneArcSize) * 3), arg1.direction + (90 * arcDirection));
    arg0.y += lengthdir_y(abs(((newDirection - arg1.direction) / coneArcSize) * 3), arg1.direction + (90 * arcDirection));
}

function _KoronePunchScript(arg0, arg1)
{
    var lifetime;
    arg0.direction += arg0.arcDirection * 2;
    arg0.speed -= 1;
    arg0.image_angle = arg0.direction;
    if (arg0.lifetime > 10)
    {
        arg0.image_alpha -= 0.2;
    }
    if (arg0.lifetime == 1)
    {
        arg0.collides = true;
    }
    arg0.lifetime++;
}

ds_map_set(attackIndex, "KoronePunch", new Attack("KoronePunch", defaultConfig, 
{
    damage: 0.85,
    lifetime: 0,
    sprite_index: spr_tempkoropunch,
    attackTime: 60,
    attackCount: 2,
    attackDelay: 4,
    hitLimit: -1,
    isMelee: true,
    drawBehind: true,
    hitCD: 60,
    canAddProjectile: true,
    projOrientation: "none",
    collides: false,
    punchSpeed: 12,
    playSound: [46],
    soundChannel: "boxing",
    soundCD: 5,
    soundPitch: true,
    onCreate: _KoronePunchOnCreate,
    script: _KoronePunchScript,
    coneArcSize: 40,
    maxLevel: 7,
    levels: [
    {
        config: 
        {
            image_xscale: 1.25,
            image_yscale: 1.25,
            optionIcon: 1788,
            optionName: global.TextContainer.koroneAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.1,
            optionIcon: 1788,
            optionName: global.TextContainer.koroneAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackTime: 50,
            optionIcon: 1788,
            optionName: global.TextContainer.koroneAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[3],
            coneArcSize: 60
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            coneArcSize: 100,
            optionIcon: 1788,
            optionName: global.TextContainer.koroneAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 5,
            attackTime: 40,
            optionIcon: 1788,
            optionName: global.TextContainer.koroneAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[5],
            coneArcSize: 80
        }
    }, 
    {
        config: 
        {
            attackDelay: 2,
            punchSpeed: 15,
            afterImageColor: 255,
            optionIcon: 1578,
            optionName: global.TextContainer.koroneAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 1788,
    isMain: true,
    weaponType: "MultiShot",
    optionName: global.TextContainer.koroneAttackName.selectedLanguage,
    optionDescription: global.TextContainer.koroneAttackDesc.selectedLanguage[0]
}));

function YubiYubi(arg0)
{
    with (arg0)
    {
        obj_AttackController.ApplyBuff(id, "YubiYubi", ds_map_find_value(obj_AttackController.Buffs, "YubiYubi"));
    }
}

YubiYubiS = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 0.9;
        arg0.image_xscale = 0.01;
        arg0.image_yscale = 0.01;
    }
    if (arg0.lifetime == 10)
    {
        var targets = ds_list_create();
        if (instance_exists(obj_Enemy))
        {
            var numberOfTargets = collision_ellipse_list(arg0.x - arg0.radius, arg0.y - (arg0.radius / 1.8), arg0.x + arg0.radius, arg0.y + (arg0.radius / 1.8), 367, true, true, targets, false);
            if (numberOfTargets > 0)
            {
                for (var i = 0; i < ds_list_size(targets); i++)
                {
                    obj_AttackController.ApplyBuff(ds_list_find_value(targets, i), "YubiYubi", ds_map_find_value(obj_AttackController.Buffs, "YubiYubi"));
                }
            }
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    if (arg0.lifetime > 20)
    {
        if (arg0.image_alpha > 0)
        {
            arg0.image_alpha -= 0.1;
        }
    }
    arg0.lifetime++;
    if (arg0.image_alpha > 0)
    {
        arg0.image_xscale += (0.1 * (30 - arg0.lifetime)) / 30;
        arg0.image_yscale += (0.1 * (30 - arg0.lifetime)) / 30;
    }
};

ds_map_set(attackIndex, "YubiYubi", new Attack("YubiYubi", defaultConfig, 
{
    sprite_index: spr_GravityRing,
    image_xscale: 1.6,
    image_yscale: 1.6,
    image_alpha: 0,
    damage: 1,
    attackTime: 720,
    collides: false,
    playSound: false,
    hitLimit: -1,
    duration: 160,
    radius: 250,
    lifetime: 0,
    soundChannel: "special",
    soundPrio: 30,
    optionType: "Skill",
    chance: 30,
    playSound: [236],
    soundChannel: "brainwash",
    heals: true,
    script: YubiYubiS,
    stayOnCreator: true,
    maxLevel: 3,
    levels: [
    {
        config: 
        {
            image_xscale: 1.8,
            image_yscale: 1.8,
            timeline: [
            {
                frame: 1,
                type: "sound",
                object: [182],
                config: false
            }, 
            {
                frame: 60,
                type: "sound",
                object: [68],
                config: false
            }, 
            {
                frame: 60,
                object: "CircleHitbox",
                type: "attack",
                config: 
                {
                    radius: 200,
                    HitTarget: gml_Script_YubiYubi_gml_Object_obj_AttackController_Other_10
                }
            }]
        }
    }, 
    {
        config: 
        {
            image_xscale: 2,
            image_yscale: 2,
            timeline: [
            {
                frame: 1,
                type: "sound",
                object: [182],
                config: false
            }, 
            {
                frame: 60,
                type: "sound",
                object: [68],
                config: false
            }, 
            {
                frame: 60,
                object: "CircleHitbox",
                type: "attack",
                config: 
                {
                    radius: 250,
                    HitTarget: gml_Script_YubiYubi_gml_Object_obj_AttackController_Other_10
                }
            }]
        }
    }],
    timeline: [
    {
        frame: 1,
        type: "sound",
        object: [182],
        config: false
    }, 
    {
        frame: 60,
        type: "sound",
        object: [68],
        config: false
    }, 
    {
        frame: 60,
        object: "CircleHitbox",
        type: "attack",
        config: 
        {
            radius: 350,
            HitTarget: gml_Script_YubiYubi_gml_Object_obj_AttackController_Other_10
        }
    }]
}));
ds_map_set(attackIndex, "StarBurst", new Attack("StarBurst", defaultConfig, 
{
    damage: 1.5,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 120,
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    drawBehind: true,
    hitCD: 30,
    image_xscale: 1.5,
    image_yscale: 1.5,
    image_alpha: 0.7,
    isMain: true,
    attackDamageID: "BrightStar"
}));

BrightStar = function(arg0, arg1)
{
    var lifetime;
    if (arg0.speed > 0)
    {
        arg0.speed -= 0.2;
    }
    arg0.image_angle += 10;
    arg0.lifetime++;
    arg0.knockback.speed = 1 + arg0.speed;
    if (arg0.burst && arg0.duration == 1)
    {
        ExecuteAttack("StarBurst", arg1, 
        {
            enhancements: arg0.enhancements,
            x: arg0.x,
            y: arg0.y,
            image_xscale: arg0.image_xscale * 1.5,
            image_yscale: arg0.image_yscale * 1.5
        });
    }
};

ds_map_set(attackIndex, "BrightStar", new Attack("BrightStar", defaultConfig, 
{
    stayOnCreator: false,
    attackTime: 75,
    damage: 0.8,
    faceCreatorDirection: true,
    sprite_index: spr_SoraStar,
    playSound: [46],
    hitLimit: -1,
    canAddProjectile: true,
    projOrientation: "frontSpread",
    hitCD: 10,
    stepDirection: -40,
    afterImageColor: 65535,
    duration: 30,
    speed: 7,
    script: BrightStar,
    lifetime: 0,
    burst: false,
    knockback: 
    {
        duration: 5,
        speed: 1
    },
    levels: [
    {
        config: 
        {
            damage: 1,
            optionName: global.TextContainer.soraAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            duration: 90,
            optionName: global.TextContainer.soraAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            startDirection: 20,
            stepDirection: -40,
            optionName: global.TextContainer.soraAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.3,
            image_yscale: 1.3,
            optionName: global.TextContainer.soraAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: 30,
            stepDirection: -30,
            optionName: global.TextContainer.soraAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            burst: true,
            optionIcon: 1575,
            optionName: global.TextContainer.soraAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 647,
    optionName: global.TextContainer.soraAttackName.selectedLanguage,
    optionDescription: global.TextContainer.soraAttackDesc.selectedLanguage[0]
}));

DivaSong = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (arg0.fromCreator)
        {
            arg0.origin_x = arg1.x;
            arg0.origin_y = arg1.y - 16;
        }
        arg0.image_alpha = 1;
    }
    arg0.origin_x += lengthdir_x(arg0.projSpeed, arg0.direction);
    arg0.origin_y += lengthdir_y(arg0.projSpeed, arg0.direction);
    arg0.x = arg0.origin_x + lengthdir_x(sin(arg0.lifetime / 8) * 30 * arg0.travelWidth, arg0.direction + 90);
    arg0.y = arg0.origin_y + lengthdir_y(sin(arg0.lifetime / 8) * 30 * arg0.travelWidth, arg0.direction + 90);
    arg0.lifetime++;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "DivaSongBurst", new Attack("DivaSongBurst", defaultConfig, 
{
    stayOnCreator: false,
    attackTime: 70,
    damage: 0.9,
    sprite_index: spr_AZKi_music,
    image_alpha: 0,
    playSound: [6],
    hitLimit: -1,
    soundCD: 10,
    hitCD: 10,
    afterImageColor: 255,
    duration: 60,
    projSpeed: 4,
    soundPitch: true,
    script: DivaSong,
    image_xscale: 0.5,
    image_yscale: 0.5,
    lifetime: 0,
    travelWidth: 1,
    origin_x: x,
    fromCreator: false,
    origin_y: y,
    isMain: true,
    attackDamageID: "DivaSong"
}));
ds_map_set(attackIndex, "DivaSong", new Attack("DivaSong", defaultConfig, 
{
    stayOnCreator: false,
    attackTime: 70,
    damage: 1.35,
    faceCreatorDirection: true,
    sprite_index: spr_AZKi_music,
    image_alpha: 0,
    playSound: [6],
    hitLimit: -1,
    hitCD: 30,
    afterImageColor: 255,
    duration: 60,
    projSpeed: 4,
    soundPitch: true,
    script: DivaSong,
    lifetime: 0,
    travelWidth: 1,
    origin_x: x,
    origin_y: y,
    fromCreator: true,
    levels: [
    {
        config: 
        {
            damage: 1.62,
            optionName: global.TextContainer.azkiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 60,
            optionName: global.TextContainer.azkiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.3,
            image_yscale: 1.3,
            travelWidth: 1.3,
            optionName: global.TextContainer.azkiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2.025,
            projSpeed: 5,
            optionName: global.TextContainer.azkiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 45,
            optionName: global.TextContainer.azkiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                SongBurst: {}
            },
            optionIcon: 1304,
            optionName: global.TextContainer.azkiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Ranged",
    optionIcon: 346,
    optionName: global.TextContainer.azkiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.azkiAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "SakuraBurst", new Attack("SakuraBurst", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 120,
    image_alpha: 0.15,
    playSound: [218],
    attackCount: 1,
    attackDelay: 30,
    hitCD: 20,
    isMelee: true,
    hitLimit: -1,
    drawBehind: true,
    isMain: true,
    attackDamageID: "GOHEI"
}));

Gohei = function(arg0, arg1)
{
    var lifetime;
    arg0.image_yscale = abs(arg0.image_yscale);
    if (arg0.lifetime == 9)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        if (arg0.vuln)
        {
            totalOnHitEffects.Vulnerability = 
            {
                amount: 25
            };
            ExecuteAttack("SakuraBurst", arg1, 
            {
                damage: arg0.sakuraDamage * arg0.effectDamage,
                CritMod: arg0.CritMod,
                enhancements: arg0.enhancements,
                x: arg0.x + lengthdir_x(40 * arg0.image_xscale, arg0.direction),
                y: arg0.y + lengthdir_y(40 * arg0.image_xscale, arg0.direction),
                image_xscale: arg0.image_xscale * 0.65,
                image_yscale: arg0.image_yscale * 0.65,
                StampVars: copyStampVars,
                onHitEffects: totalOnHitEffects,
                afterImageColor: arg0.afterImageColor,
                knockback: arg0.knockback
            });
        }
        else
        {
            ExecuteAttack("SakuraBurst", arg1, 
            {
                damage: arg0.sakuraDamage * arg0.effectDamage,
                enhancements: arg0.enhancements,
                CritMod: arg0.CritMod,
                x: arg0.x + lengthdir_x(40 * arg0.image_xscale, arg0.direction),
                y: arg0.y + lengthdir_y(40 * arg0.image_xscale, arg0.direction),
                image_xscale: arg0.image_xscale * 0.65,
                image_yscale: arg0.image_yscale * 0.65,
                StampVars: copyStampVars,
                onHitEffects: totalOnHitEffects,
                afterImageColor: arg0.afterImageColor,
                knockback: arg0.knockback
            });
        }
        for (var i = 0; i < 25; i++)
        {
            var vfx = instance_create_depth(arg0.x + lengthdir_x(40 * arg0.image_xscale, arg0.direction), arg0.y + lengthdir_y(40 * arg0.image_xscale, arg0.direction), arg0.depth - 1, obj_vfx);
            vfx.sprite_index = spr_MikoSakura;
            vfx.image_speed = 0;
            vfx.direction = irandom(359);
            vfx.speed = (2 + random(4)) * arg0.image_xscale * 0.9;
            vfx.friction = 0.2;
            vfx.alarm[1] = 1;
            vfx.image_angle = irandom(359);
            vfx.rotSpeed = 1 + irandom(4);
            vfx.alarm[2] = 1;
            vfx.gravity = 0.05;
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "GOHEI", new Attack("GOHEI", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 85,
    damage: 0.4,
    sakuraDamage: 1.4,
    faceCreatorDirection: true,
    script: Gohei,
    sprite_index: spr_MikoGohei,
    playSound: [46],
    isMelee: true,
    soundPitch: true,
    image_xscale: 1.4,
    image_yscale: 1.4,
    lifetime: 0,
    vuln: false,
    knockback: 
    {
        duration: 10,
        speed: 4
    },
    levels: [
    {
        config: 
        {
            image_xscale: 1.68,
            image_yscale: 1.68,
            optionName: global.TextContainer.mikoAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 0.52,
            sakuraDamage: 1.82,
            optionName: global.TextContainer.mikoAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 20,
            optionName: global.TextContainer.mikoAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 72,
            optionName: global.TextContainer.mikoAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 2.18,
            image_yscale: 2.18,
            optionName: global.TextContainer.mikoAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            vuln: true,
            sprite_index: spr_MikoGohei2,
            afterImageColor: 255,
            optionIcon: 148,
            optionName: global.TextContainer.mikoAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 2177,
    optionName: global.TextContainer.mikoAttackName.selectedLanguage,
    optionDescription: global.TextContainer.mikoAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "AxeSwing", new Attack("AxeSwing", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 90,
    damage: 1.2,
    faceCreatorDirection: true,
    isMelee: true,
    sprite_index: spr_SuiseiAxeSwing,
    playSound: [114],
    soundPitch: true,
    image_xscale: 1,
    image_yscale: 1,
    hitLimit: -1,
    hitCD: 30,
    levels: [
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.suiseiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.suiseiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 80,
            optionName: global.TextContainer.suiseiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2,
            optionName: global.TextContainer.suiseiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.44,
            image_yscale: 1.44,
            optionName: global.TextContainer.suiseiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            sprite_index: spr_SuiseiAxeSwing2,
            sureCrit: true,
            CritMod: 1.5,
            optionIcon: 145,
            optionName: global.TextContainer.suiseiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 1689,
    optionName: global.TextContainer.suiseiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.suiseiAttackDesc.selectedLanguage[0]
}));

RoboChargeShot = function(arg0, arg1)
{
    var lifetime;
    arg0.speed += 0.5;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "RoboShot", new Attack("RoboShot", defaultConfig, 
{
    sprite_index: spr_Ame_bullet,
    attackTime: 80,
    duration: 120,
    damage: 0.6,
    playSound: [125],
    soundPitch: true,
    hitLimit: 3,
    speed: 6,
    faceCreatorDirection: true,
    homing: false,
    targetRandom: true,
    attackCount: 4,
    attackDelay: 5,
    canAddProjectile: true,
    projOrientation: "none",
    lifetime: 0,
    destroyOnHitLimit: true,
    range: 100,
    levels: [
    {
        config: 
        {
            attackCount: 5,
            optionName: global.TextContainer.robocoAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            hitLimit: 4,
            optionName: global.TextContainer.robocoAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 68,
            optionName: global.TextContainer.robocoAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 0.72,
            optionName: global.TextContainer.robocoAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 6,
            optionName: global.TextContainer.robocoAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            sprite_index: spr_RobocoChargedShot,
            attackCount: 1,
            hitCD: 6,
            damage: 2.6,
            transparent: true,
            speed: 5,
            optionIcon: 1630,
            afterImageColor: 16711680,
            hitLimit: -1,
            destroyOnHitLimit: false,
            script: RoboChargeShot,
            image_xscale: 2,
            image_yscale: 2,
            playSound: [184],
            soundChannel: "chargedshot",
            canAddProjectile: false,
            weaponType: "Ranged",
            projOrientation: "none",
            optionName: global.TextContainer.robocoAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[6],
            resetSequence: true
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 72,
    optionName: global.TextContainer.robocoAttackName.selectedLanguage,
    optionDescription: global.TextContainer.robocoAttackDesc.selectedLanguage[0]
}));

RedHeart = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (variable_instance_exists(arg1, "haatoMode"))
        {
            if (arg0.modeOverride == -1)
            {
                if (arg1.haatoMode < 2)
                {
                    arg0.heartMode = arg1.haatoMode;
                }
                else
                {
                    arg0.heartMode = 0;
                }
            }
            else
            {
                arg0.heartMode = arg0.modeOverride;
            }
            if (arg1.haatoMode == 2 && arg0.modeOverride == -1)
            {
                var totalOnHitEffects = {};
                var copyStampVars = {};
                variable_struct_copy(arg0.StampVars, copyStampVars);
                if (variable_struct_exists(arg0, "onHitEffects"))
                {
                    variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
                }
                obj_AttackController.ExecuteAttack("RedHeart", arg1, 
                {
                    faceCreatorDirection: false,
                    duration: arg0.duration,
                    image_xscale: arg0.image_xscale,
                    image_yscale: arg0.image_yscale,
                    enhancements: arg0.enhancements,
                    radius: arg0.radius,
                    damage: arg0.damage,
                    shootOut: arg0.shootOut,
                    direction: arg0.direction,
                    modeOverride: 1,
                    StampVars: copyStampVars,
                    onHitEffects: totalOnHitEffects,
                    CritMod: arg0.CritMod,
                    afterImageColor: arg0.afterImageColor,
                    knockback: arg0.knockback
                });
            }
            else if (arg0.heartMode == 1)
            {
                arg0.sprite_index = spr_HaatoBlackHeart;
                arg0.damage *= 1.5;
                arg0.knockback.speed = 0;
                arg0.knockback.duration = 0;
            }
            else
            {
                arg0.knockback.speed = 5;
                arg0.knockback.duration = 5;
            }
        }
        arg0.collides = true;
        arg0.centerPosX = arg1.x;
        arg0.centerPosY = arg1.y;
        arg0.playerDirection = arg1.direction + arg0.reverse;
        arg0.spinDir = -1 + (2 * (arg1.image_xscale > 0));
    }
    arg0.collides = true;
    if (arg0.duration < 20)
    {
        if (arg0.shootOut)
        {
            arg0.image_xscale += 0.05;
            arg0.image_yscale += 0.05;
            arg0.image_alpha -= 0.05;
        }
        else
        {
            arg0.image_xscale -= 0.05;
            arg0.image_yscale -= 0.05;
            arg0.image_alpha -= 0.05;
        }
    }
    if (variable_instance_exists(arg1, "haatoMode"))
    {
        if (arg0.heartMode == 0)
        {
            arg0.centerPosX = arg1.x;
            arg0.centerPosY = arg1.y;
        }
        else if (!arg0.shootOut || (arg0.duration >= 30 && arg0.shootOut))
        {
            arg0.centerPosX += lengthdir_x(arg0.projSpeed / 2, arg0.playerDirection);
            arg0.centerPosY += lengthdir_y(arg0.projSpeed / 2, arg0.playerDirection);
        }
        arg0.x = arg0.centerPosX + (arg0.spinDir * ((arg0.radius - (arg0.radius * (0.5 * arg0.heartMode))) * cos(((arg0.angle + arg0.direction) * pi) / 180)));
        arg0.y = (arg0.centerPosY - 16) + ((arg0.radius - (arg0.radius * (0.5 * arg0.heartMode))) * sin(((arg0.angle + arg0.direction) * pi) / 180));
    }
    arg0.angle += arg0.projSpeed;
    if (arg0.shootOut && arg0.duration < 30)
    {
        arg0.radius += (1 + (2 * arg0.heartMode)) * (arg0.projSpeed / 2) * (arg0.duration / 30);
    }
    arg0.image_angle = 0;
    arg0.visible = true;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "RedHeart", new Attack("RedHeart", defaultConfig, 
{
    sprite_index: spr_HaatoRedHeart,
    attackTime: 90,
    duration: 45,
    damage: 0.8,
    hitCD: 20,
    spinDir: 1,
    image_xscale: 0.8,
    image_yscale: 0.8,
    collides: false,
    playSound: [271],
    hitLimit: -1,
    homing: false,
    targetRandom: false,
    destroyOnHitLimit: false,
    angle: 1,
    centerPosX: 0,
    centerPosY: 0,
    lifetime: 0,
    heartMode: 0,
    modeOverride: -1,
    radius: 40,
    attackCount: 2,
    stepDirection: 180,
    canAddProjectile: true,
    projOrientation: "circle",
    playerDirection: 0,
    faceCreatorDirection: true,
    projSpeed: 8,
    shootOut: false,
    range: 100,
    script: RedHeart,
    visible: false,
    afterImageColor: 255,
    knockback: 
    {
        duration: 8,
        speed: 6
    },
    levels: [
    {
        config: 
        {
            damage: 0.84,
            optionName: global.TextContainer.haatoAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1,
            image_yscale: 1,
            radius: 36,
            optionName: global.TextContainer.haatoAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            stepDirection: 120,
            optionName: global.TextContainer.haatoAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            duration: 65,
            optionName: global.TextContainer.haatoAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1,
            optionName: global.TextContainer.haatoAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            shootOut: true,
            duration: 95,
            onHitEffects: 
            {
                RedHeartDebuff: 
                {
                    amount1: 30,
                    amount2: 0.3
                }
            },
            optionIcon: 2210,
            optionName: global.TextContainer.haatoAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 1076,
    optionName: global.TextContainer.haatoAttackName.selectedLanguage,
    optionDescription: global.TextContainer.haatoAttackDesc.selectedLanguage[0]
}));

KapuKapu = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 8)
    {
        arg0.collides = true;
    }
    if (arg0.lifetime == 15)
    {
        if (arg0.second)
        {
            var totalOnHitEffects = {};
            var copyStampVars = {};
            variable_struct_copy(arg0.StampVars, copyStampVars);
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            obj_AttackController.ExecuteAttack("KapuKapu", arg1, 
            {
                damage: arg0.damage,
                faceCreatorDirection: true,
                reverse: arg0.reverse,
                direction: arg0.direction,
                image_angle: arg0.direction,
                image_xscale: arg0.image_xscale * 1.4,
                image_yscale: arg0.image_yscale * 1.4,
                enhancements: arg0.enhancements,
                second: false,
                StampVars: copyStampVars,
                onHitEffects: totalOnHitEffects,
                CritMod: arg0.CritMod,
                afterImageColor: arg0.afterImageColor,
                knockback: arg0.knockback
            });
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "KapuKapu", new Attack("KapuKapu", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 80,
    damage: 1.5,
    faceCreatorDirection: true,
    sprite_index: spr_MelKapu,
    playSound: [262],
    image_xscale: 1,
    image_yscale: 1,
    isMelee: true,
    script: KapuKapu,
    hitLimit: -1,
    hitCD: 30,
    collides: false,
    isMain: true,
    second: false,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            onHitEffects: 
            {
                Kapu: 
                {
                    chance: 15,
                    heal: 0.05
                }
            },
            optionName: global.TextContainer.melAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.15,
            image_yscale: 1.15,
            optionName: global.TextContainer.melAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 1.8,
            optionName: global.TextContainer.melAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 68,
            optionName: global.TextContainer.melAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 2.25,
            optionName: global.TextContainer.melAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            second: true,
            optionName: global.TextContainer.melAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    weaponType: "Melee",
    optionIcon: 74,
    optionName: global.TextContainer.melAttackName.selectedLanguage,
    optionDescription: global.TextContainer.melAttackDesc.selectedLanguage[0]
}));

Ebifrion = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        arg0.direction = (arg1.direction + ((30 * arg0.swingSpeed) / 2) + arg0.swungArc) - arg0.reverse;
        arg0.collides = true;
        arg0.image_alpha = 1;
    }
    arg0.image_angle = arg0.direction;
    arg0.swungArc -= arg0.swingSpeed;
    arg0.direction = arg1.direction + arg0.reverse + ((30 * arg0.swingSpeed) / 2) + arg0.swungArc;
};

ds_map_set(attackIndex, "Ebifrion", new Attack("Ebifrion", defaultConfig, 
{
    stayOnCreator: true,
    faceCreatorDirection: false,
    attackTime: 90,
    damage: 1.4,
    hitLimit: -1,
    collides: false,
    isMelee: true,
    image_alpha: 0,
    sprite_index: spr_MatsuriEbifrion,
    script: Ebifrion,
    image_xscale: 1,
    image_yscale: 1,
    hitCD: 15,
    duration: 30,
    swingSpeed: 5,
    swungArc: 0,
    lifetime: 0,
    playSound: [20],
    levels: [
    {
        config: 
        {
            damage: 1.68,
            optionName: global.TextContainer.matsuriAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.12,
            image_yscale: 1.12,
            optionName: global.TextContainer.matsuriAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            swingSpeed: 6,
            optionName: global.TextContainer.matsuriAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2,
            optionName: global.TextContainer.matsuriAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.34,
            image_yscale: 1.34,
            optionName: global.TextContainer.matsuriAttackName.selectedLanguage + " LVL 6",
            optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 2.6,
            onHitEffects: 
            {
                EbifrionHit: 
                {
                    chance: 15
                }
            },
            afterImageColor: 4235519,
            optionIcon: 2311,
            optionName: global.TextContainer.matsuriAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 2467,
    optionName: global.TextContainer.matsuriAttackName.selectedLanguage,
    optionDescription: global.TextContainer.matsuriAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "AikBeam", new Attack("AikBeam", defaultConfig, 
{
    sprite_index: spr_AkiAikBeam,
    attackTime: 180,
    damage: 1.4,
    collides: true,
    playSound: [122],
    soundChannel: "laser",
    soundCD: 8,
    direction: 270,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    soundPrio: 20,
    hitLimit: -1,
    faceCreatorDirection: false,
    homing: false,
    hitCD: 60,
    lifetime: 0,
    destroyOnHitLimit: false,
    attackDamageID: "Aik"
}));

Aik = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.beamSize = arg0.image_xscale * 0.8;
        arg0.image_xscale = 1;
        arg0.image_yscale = 1;
        arg0.direction = (arg0.direction - 45) + irandom(90);
    }
    if (!variable_instance_exists(arg0, "target") || (variable_instance_exists(arg0, "target") && arg0.target == "noTarget"))
    {
        targets = ds_list_create();
        numTargets = collision_circle_list(arg1.x, arg1.y, arg0.range, obj_Enemy, false, true, targets, true);
        targets = RemoveFriendly(targets);
        numTargets = ds_list_size(targets);
        if (numTargets == 0)
        {
            arg0.target = "noTarget";
            arg0.direction = arg1.direction;
        }
        else if (arg0.countID == 0)
        {
            arg0.target = ds_list_find_value(targets, 0);
        }
        else
        {
            randomIndex = floor(random(numTargets));
            arg0.target = ds_list_find_value(targets, randomIndex);
        }
        ds_list_destroy(targets);
        targets = -1;
        if (arg0.target == "noTarget")
        {
            arg0.target = 
            {
                x: (arg1.x - 100) + irandom(200),
                y: (arg1.y - 100) + irandom(200)
            };
        }
    }
    else if (arg0.target != "noTarget")
    {
        if (instance_exists(arg0.target) && arg0.lifetime <= 30)
        {
            var frontPoint_x = arg0.target.x - lengthdir_x(50, point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y - 16));
            var frontPoint_y = arg0.target.y - 16 - lengthdir_y(50, point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y - 16));
            var moveDistance = point_distance(arg0.x, arg0.y, frontPoint_x, frontPoint_y);
            var directionToEnemy = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y - 16);
            var directionDifference = angle_difference(arg0.direction, directionToEnemy);
            arg0.direction -= min(abs(directionDifference), 10) * sign(directionDifference);
            if (abs(moveDistance) > 15)
            {
                arg0.speed = arg0.projSpeed * (moveDistance / 100);
            }
            else
            {
                arg0.speed = 0;
            }
        }
        else
        {
            arg0.speed = 0;
        }
        arg0.image_angle = arg0.direction;
    }
    if (arg0.lifetime == 30)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        var sprite = 1467;
        if (arg0.crossBeam)
        {
            sprite = 1742;
        }
        obj_AttackController.ExecuteAttack("AikBeam", arg1, 
        {
            sprite_index: sprite,
            x: arg0.x,
            y: arg0.y,
            direction: arg0.direction,
            image_angle: arg0.image_angle,
            image_xscale: arg0.beamSize,
            image_yscale: arg0.beamSize,
            depth: arg0.depth - 50,
            damage: arg0.damage,
            enhancements: arg0.enhancements,
            StampVars: copyStampVars,
            onHitEffects: totalOnHitEffects,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            applyWeaponSize: true
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Aik", new Attack("Aik", defaultConfig, 
{
    sprite_index: spr_AkiAik,
    attackTime: 90,
    duration: 50,
    damage: 1.6,
    collides: false,
    playSound: [21],
    soundCD: 15,
    soundPitch: true,
    script: Aik,
    hitLimit: -1,
    projSpeed: 8,
    homing: false,
    targetRandom: false,
    attackCount: 2,
    attackDelay: 8,
    faceCreatorDirection: true,
    afterImageColor: 16711680,
    destroyOnHitLimit: false,
    canAddProjectile: true,
    projOrientation: "none",
    lifetime: 0,
    image_xscale: 1,
    image_yscale: 1,
    beamSize: 0.8,
    crossBeam: false,
    range: 250,
    levels: [
    {
        config: 
        {
            damage: 1.92,
            optionName: global.TextContainer.akiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.akiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            optionName: global.TextContainer.akiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 76,
            optionName: global.TextContainer.akiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            optionName: global.TextContainer.akiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 2.496,
            crossBeam: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
            onHitEffects: 
            {
                Vulnerability3: 
                {
                    chance: 30,
                    amount: 30
                }
            },
            optionIcon: 262,
            optionName: global.TextContainer.akiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 2029,
    optionName: global.TextContainer.akiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.akiAttackDesc.selectedLanguage[0]
}));

BaseballPitch = function(arg0, arg1)
{
    var lifetime, deathTime;
    if (arg0.lifetime == 0)
    {
        arg0.randPitch = -1 + random(2);
        arg0.aimedDirection = arg0.direction;
        arg0.horMove = lengthdir_x(arg0.projSpeed, arg0.aimedDirection);
        arg0.verMove = -1 + lengthdir_y(arg0.projSpeed + arg0.randPitch, arg0.aimedDirection);
    }
    if (arg0.initBonus)
    {
        arg0.damage = arg0.baseDamage * (1 + (arg0.deathTime / 15));
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_vfx);
        vfx.sprite_index = spr_DragonFire;
        vfx.duration = 120;
        vfx.add = true;
        vfx.followCharacter = arg0;
        vfx.followAngle = arg0.direction;
        vfx.image_alpha = 0.6;
    }
    arg0.horMove = lengthdir_x(arg0.projSpeed, arg0.aimedDirection);
    arg0.verMove = -1 + lengthdir_y(arg0.projSpeed + arg0.randPitch, arg0.aimedDirection);
    arg0.collides = true;
    if (arg0.horMove > 16)
    {
        arg0.horMove = 16;
    }
    if (arg0.horMove < -16)
    {
        arg0.horMove = -16;
    }
    if (arg0.verMove > 16)
    {
        arg0.verMove = 16;
    }
    if (arg0.verMove < -16)
    {
        arg0.verMove = -16;
    }
    arg0.x += arg0.horMove;
    arg0.y += arg0.verMove;
    arg0.gravity = 0.1;
    arg0.image_angle = arg0.lifetime * 30;
    arg0.lifetime++;
    if (arg0.deathTime > 0)
    {
        arg0.deathTime--;
    }
};

ds_map_set(attackIndex, "BaseballPitch", new Attack("BaseballPitch", defaultConfig, 
{
    sprite_index: spr_SubaruBaseball,
    attackTime: 60,
    duration: 120,
    deathTime: 15,
    damage: 1.4,
    baseDamage: 1.4,
    playSound: [46],
    soundPitch: true,
    hitLimit: 3,
    collides: false,
    projSpeed: 8,
    hitCD: 20,
    aimedDirection: 0,
    faceCreatorDirection: true,
    randPitch: 0,
    homing: false,
    targetRandom: false,
    horMove: 0,
    deflects: 1,
    ogHitLimit: 2,
    verMove: 0,
    projOrientation: "none",
    attackDelay: 4,
    image_xscale: 1.2,
    image_yscale: 1.2,
    initBonus: false,
    script: BaseballPitch,
    lifetime: 0,
    destroyOnHitLimit: false,
    range: 100,
    levels: [
    {
        config: 
        {
            damage: 1.68,
            baseDamage: 1.68,
            optionName: global.TextContainer.subaruAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 42,
            optionName: global.TextContainer.subaruAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            projSpeed: 16,
            knockback: 
            {
                duration: 4,
                speed: 2
            },
            optionName: global.TextContainer.subaruAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 21,
            optionName: global.TextContainer.subaruAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            hitLimit: 8,
            ogHitLimit: 5,
            damage: 2,
            baseDamage: 2,
            optionName: global.TextContainer.subaruAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            initBonus: true,
            image_xscale: 1.4,
            image_yscale: 1.4,
            afterImageColor: 255,
            optionIcon: 2146,
            optionName: global.TextContainer.subaruAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Ranged",
    optionIcon: 224,
    optionName: global.TextContainer.subaruAttackName.selectedLanguage,
    optionDescription: global.TextContainer.subaruAttackDesc.selectedLanguage[0]
}));

LoveNeedle = function(arg0, arg1)
{
    arg0.speed /= 1.2;
};

ds_map_set(attackIndex, "LoveNeedle", new Attack("LoveNeedle", defaultConfig, 
{
    sprite_index: spr_ChocoNeedle,
    attackTime: 90,
    duration: 30,
    damage: 1.5,
    playSound: [20],
    soundPitch: true,
    hitLimit: -1,
    speed: 25,
    collides: true,
    hitCD: 30,
    lifetime: 0,
    stepDirection: -10,
    faceCreatorDirection: true,
    canAddProjectile: true,
    targetRandom: false,
    projOrientation: "frontSpread",
    script: LoveNeedle,
    lifetime: 0,
    destroyOnHitLimit: false,
    range: 100,
    levels: [
    {
        config: 
        {
            damage: 1.8,
            optionName: global.TextContainer.chocoAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.chocoAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 7,
            startDirection: 5,
            optionName: global.TextContainer.chocoAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 76,
            damage: 2.34,
            optionName: global.TextContainer.chocoAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: 10,
            speed: 31,
            optionName: global.TextContainer.chocoAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                needleHit: 
                {
                    chance: 20,
                    heal: 5,
                    multiplier: 1.5
                }
            },
            needleHitOnce: true,
            optionIcon: 2361,
            afterImageColor: make_color_rgb(255, 88, 150),
            optionName: global.TextContainer.chocoAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 1610,
    optionName: global.TextContainer.chocoAttackName.selectedLanguage,
    optionDescription: global.TextContainer.chocoAttackDesc.selectedLanguage[0]
}));

MurasakiHoming = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.speed = 5 + random(3);
        if (!variable_instance_exists(arg0, "target") || (variable_instance_exists(arg0, "target") && !instance_exists(arg0.target)))
        {
            targets = ds_list_create();
            numTargets = collision_circle_list(arg1.x, arg1.y, arg0.range, obj_Enemy, false, true, targets, true);
            targets = RemoveFriendly(targets);
            numTargets = ds_list_size(targets);
            if (numTargets == 0)
            {
                arg0.target = "noTarget";
                arg0.direction = arg1.direction;
            }
            else if (arg0.targetRandom)
            {
                randomIndex = floor(random(numTargets));
                arg0.target = ds_list_find_value(targets, randomIndex);
            }
            else
            {
                arg0.target = ds_list_find_value(targets, 0);
            }
            ds_list_destroy(targets);
            targets = -1;
        }
    }
    if (arg0.target == "noTarget")
    {
        targets = ds_list_create();
        numTargets = collision_circle_list(arg1.x, arg1.y, arg0.range, obj_Enemy, false, true, targets, true);
        targets = RemoveFriendly(targets);
        numTargets = ds_list_size(targets);
        if (numTargets == 0)
        {
            arg0.target = "noTarget";
            arg0.direction = arg1.direction;
        }
        else if (arg0.targetRandom)
        {
            randomIndex = floor(random(numTargets));
            arg0.target = ds_list_find_value(targets, randomIndex);
        }
        else
        {
            arg0.target = ds_list_find_value(targets, 0);
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    if (arg0.target != "noTarget" && instance_exists(arg0.target))
    {
        var directionToEnemy = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
        var directionDifference = angle_difference(arg0.direction, directionToEnemy);
        arg0.direction -= min(abs(directionDifference), 30) * sign(directionDifference);
    }
    if (arg0.speed < 20)
    {
        arg0.speed += 2;
    }
    arg0.image_angle = arg0.direction;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MurasakiHoming", new Attack("MurasakiHoming", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_ShionMagic,
    attackTime: 120,
    playSound: [150],
    attackCount: 1,
    collides: true,
    attackDelay: 30,
    hitLimit: 1,
    drawBehind: true,
    speed: 5,
    range: 400,
    soundChannel: "murasakihoming",
    hitCD: 45,
    duration: 180,
    isMain: true,
    projSpeed: 0,
    lifetime: 0,
    destroyOnHitLimit: true,
    targetRandom: false,
    script: MurasakiHoming,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    afterImageColor: 16711680,
    attackDamageID: "MurasakiBolt"
}));

MurasakiBolt = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 2)
    {
        arg0.collides = true;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MurasakiBolt", new Attack("MurasakiBolt", defaultConfig, 
{
    sprite_index: spr_ShionMagic,
    attackTime: 65,
    duration: 15,
    damage: 1.4,
    playSound: [260],
    soundPitch: true,
    speed: 12,
    collides: false,
    hitCD: 30,
    hitLimit: 5,
    lifetime: 0,
    faceCreatorDirection: true,
    targetRandom: false,
    script: MurasakiBolt,
    lifetime: 0,
    canAddProjectile: true,
    stepDirection: 20,
    projOrientation: "frontSpread",
    destroyOnHitLimit: true,
    levels: [
    {
        config: 
        {
            attackCount: 2,
            startDirection: -10,
            optionName: global.TextContainer.shionAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            hitLimit: 8,
            optionName: global.TextContainer.shionAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 1.68,
            speed: 15,
            optionName: global.TextContainer.shionAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 52,
            optionName: global.TextContainer.shionAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: -20,
            optionName: global.TextContainer.shionAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                MurasakiHit: 
                {
                    chance: 30
                }
            },
            optionIcon: 2371,
            afterImageColor: 16711680,
            optionName: global.TextContainer.shionAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 153,
    optionName: global.TextContainer.shionAttackName.selectedLanguage,
    optionDescription: global.TextContainer.shionAttackDesc.selectedLanguage[0]
}));

SpiritFire = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        arg0.speed = 3 + random(2);
        arg0.lockedX = arg0.stayOn.x;
        arg0.lockedY = arg0.stayOn.y;
        arg0.lifetime = 1;
    }
    arg0.image_angle = 0;
    arg0.direction = point_direction(arg0.x, arg0.y, arg0.lockedX, arg0.lockedY) + 90;
};

ds_map_set(attackIndex, "SpiritFire", new Attack("SpiritFire", defaultConfig, 
{
    sprite_index: spr_AyameSpiritFire,
    attackTime: 120,
    playSound: [121],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    speed: 3,
    soundChannel: "spiritfire",
    hitCD: 45,
    duration: 180,
    projSpeed: 0,
    isMain: true,
    lifetime: 0,
    destroyOnHitLimit: true,
    targetRandom: false,
    script: SpiritFire,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    afterImageColor: 16711680,
    isMain: true,
    attackDamageID: "OniSlash"
}));

SlashSprite = function(arg0, arg1)
{
    if (arg0.countID == 1 && arg0.changeSprite)
    {
        arg0.sprite_index = spr_AyameSlash2;
    }
    arg0.image_alpha = 1;
};

OniSlash = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 5)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        ExecuteAttack("OniSlash", arg0.creator, 
        {
            sprite_index: arg0.sprite_index,
            damage: arg0.damage,
            enhancements: arg0.enhancements,
            StampVars: copyStampVars,
            onHitEffects: totalOnHitEffects,
            attackCount: 1,
            CritMod: arg0.CritMod,
            afterImageColor: arg0.afterImageColor,
            knockback: arg0.knockback,
            faceCreatorDirection: false,
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale,
            startDirection: 0,
            image_angle: arg0.image_angle + 180,
            playSound: arg0.playSound
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "OniSlash", new Attack("OniSlash", defaultConfig, 
{
    sprite_index: spr_AyameSlash,
    attackTime: 100,
    duration: 15,
    damage: 1,
    playSound: [114],
    soundPitch: true,
    image_xscale: 0.9,
    image_yscale: 0.9,
    image_alpha: 0,
    onCreate: SlashSprite,
    collides: true,
    attackCount: 2,
    stepDirection: 40,
    attackDelay: 5,
    startDirection: -20,
    hitCD: 30,
    hitLimit: -1,
    lifetime: 0,
    faceCreatorDirection: true,
    targetRandom: false,
    lifetime: 0,
    destroyOnHitLimit: false,
    changeSprite: true,
    levels: [
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.ayameAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1,
            image_yscale: 1,
            optionName: global.TextContainer.ayameAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 85,
            optionName: global.TextContainer.ayameAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            script: OniSlash,
            optionName: global.TextContainer.ayameAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.ayameAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            sprite_index: spr_AyameOniSlash,
            image_xscale: 1.1,
            image_yscale: 1.1,
            changeSprite: false,
            onHitEffects: 
            {
                SpiritSlash: 
                {
                    chance: 50
                }
            },
            optionIcon: 2369,
            afterImageColor: 16711680,
            optionName: global.TextContainer.ayameAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 2215,
    optionName: global.TextContainer.ayameAttackName.selectedLanguage,
    optionDescription: global.TextContainer.ayameAttackDesc.selectedLanguage[0]
}));

OkayuOnigiri = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.horMove = lengthdir_x(arg0.projSpeed, arg0.direction) * (0.9 + random(0.2));
        arg0.verMove = (-2 + lengthdir_y(arg0.projSpeed, arg0.direction)) * (0.9 + random(0.2));
    }
    if (arg0.horMove > 10)
    {
        arg0.horMove = 10;
    }
    if (arg0.verMove > 10)
    {
        arg0.verMove = 10;
    }
    arg0.x += arg0.horMove;
    arg0.y += arg0.verMove;
    arg0.gravity = 0.2;
    arg0.image_angle += 30;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "CleaningBroom", new Attack("CleaningBroom", defaultConfig, 
{
    attackTime: 100,
    damage: 1.1,
    faceCreatorDirection: true,
    sprite_index: spr_AquaBroom,
    playSound: [46],
    destroyOnHitLimit: true,
    image_xscale: 1,
    image_yscale: 1,
    hitLimit: -1,
    duration: 120,
    canAddProjectile: true,
    projOrientation: "none",
    projSpeed: 6,
    horMove: 0,
    stepDirection: 20,
    verMove: 0,
    script: OkayuOnigiri,
    hitCD: 30,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.32,
            optionName: global.TextContainer.aquaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 5,
                speed: 10
            },
            optionName: global.TextContainer.aquaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 3,
            startDirection: -10,
            optionName: global.TextContainer.aquaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.15,
            image_yscale: 1.15,
            optionName: global.TextContainer.aquaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 85,
            optionName: global.TextContainer.aquaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 3,
            startDirection: -20,
            afterImageColor: 16776960,
            onHitEffects: 
            {
                Wet: 
                {
                    chance: 30
                }
            },
            optionIcon: 2280,
            optionName: global.TextContainer.aquaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 1128,
    isMain: true,
    weaponType: "MultiShot",
    optionName: global.TextContainer.aquaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.aquaAttackDesc.selectedLanguage[0]
}));

FullMoon = function(arg0, arg1)
{
    var lifetime;
    arg0.image_alpha -= 1/30;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "FullMoon", new Attack("FullMoon", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_MoonaCrescent3,
    attackTime: 120,
    playSound: [50],
    soundChannel: "fullmoon",
    attackCount: 1,
    collides: true,
    attackDelay: 60,
    hitLimit: -1,
    drawBehind: true,
    hitCD: 60,
    duration: 30,
    drawUnderAll: true,
    projSpeed: 0,
    lifetime: 0,
    destroyOnHitLimit: true,
    targetRandom: false,
    script: FullMoon,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    attackDamageID: "CrescentMoon"
}));

function CrescentOnCreate(arg0, arg1)
{
    if (variable_struct_exists(arg1.buffs, "MoonaSpecial"))
    {
        arg0.highTide = true;
        arg0.sprite_index = spr_MoonaHighSlash;
        arg0.image_alpha = 1;
        arg0.damage *= 2;
        soundPlay([166], "moonslash", 15, 30, true);
        arg0.drawBehind = true;
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
        vfx.sprite_index = spr_MoonaHighSlash;
        vfx.add = true;
        vfx.alarm[1] = 1;
        vfx.fadeSpeed = 0.02;
        vfx.duration = 60;
        vfx.image_xscale = arg0.image_xscale;
        vfx.image_yscale = arg0.image_yscale;
        vfx.image_angle = arg0.image_angle;
        vfx.image_alpha = 1;
        vfx.followCharacter = arg0;
    }
}

CrescentMoon = function(arg0, arg1)
{
    var lifetime;
    if (!arg0.highTide)
    {
        arg0.image_angle += 8;
        var fwd = sin(arg0.lifetime / 20);
        var vert = sin(arg0.lifetime / 10);
        arg0.x = arg1.x + lengthdir_x(fwd * arg0.mdistance, arg0.direction) + lengthdir_x(vert * arg0.mwidth, arg0.direction + 90);
        arg0.y = arg1.y + lengthdir_y(fwd * arg0.mdistance, arg0.direction) + lengthdir_y(vert * arg0.mwidth, arg0.direction + 90);
        arg0.image_alpha = 1;
    }
    else
    {
        arg0.depth = arg1.depth + 50;
        if (arg0.duration < 20)
        {
            arg0.image_alpha -= 0.05;
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "CrescentMoon", new Attack("CrescentMoon", defaultConfig, 
{
    attackTime: 100,
    damage: 1.3,
    faceCreatorDirection: true,
    sprite_index: spr_MoonaCrescent,
    playSound: [199],
    destroyOnHitLimit: true,
    image_xscale: 1,
    image_yscale: 1,
    mdistance: 100,
    highTide: false,
    mwidth: 40,
    hitLimit: -1,
    duration: 60,
    onCreate: CrescentOnCreate,
    image_alpha: 0,
    canAddProjectile: false,
    projOrientation: "none",
    script: CrescentMoon,
    hitCD: 30,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.moonaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.moonaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 85,
            optionName: global.TextContainer.moonaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.56,
            image_yscale: 1.56,
            mdistance: 130,
            mwidth: 52,
            optionName: global.TextContainer.moonaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 2.028,
            optionName: global.TextContainer.moonaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            targetsHit: 0,
            sprite_index: spr_MoonaCrescent2,
            afterImageColor: 8388736,
            optionIcon: 909,
            onHitEffects: 
            {
                FullMoonHit: {}
            },
            optionName: global.TextContainer.moonaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 2165,
    isMain: true,
    weaponType: "Melee",
    optionName: global.TextContainer.moonaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.moonaAttackDesc.selectedLanguage[0]
}));

Nuts = function(arg0, arg1)
{
    var bounce, lifetime;
    if (arg0.bounce > 0)
    {
        if (arg0.x < camera_get_view_x(view_camera[0]))
        {
            arg0.direction += 60 - irandom(120);
            arg0.hspeed = abs(arg0.hspeed);
            arg0.bounce--;
        }
        if (arg0.x > (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])))
        {
            arg0.direction += 60 - irandom(120);
            arg0.hspeed = -abs(arg0.hspeed);
            arg0.bounce--;
        }
        if (arg0.y < camera_get_view_y(view_camera[0]))
        {
            arg0.direction += 60 - irandom(120);
            arg0.vspeed = abs(arg0.vspeed);
            arg0.bounce--;
        }
        if (arg0.y > (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])))
        {
            arg0.direction += 60 - irandom(120);
            arg0.vspeed = -abs(arg0.vspeed);
            arg0.bounce--;
        }
    }
    arg0.image_angle += 10;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Nuts", new Attack("Nuts", defaultConfig, 
{
    attackTime: 80,
    damage: 1,
    faceCreatorDirection: true,
    sprite_index: spr_RisuCashew,
    playSound: [46],
    destroyOnHitLimit: true,
    image_xscale: 1,
    image_yscale: 1,
    hitLimit: 8,
    speed: 5,
    attackCount: 3,
    stepDirection: 10,
    startDirection: -10,
    script: Nuts,
    duration: 60,
    canAddProjectile: true,
    projOrientation: "frontSpread",
    hitCD: 30,
    bounce: 0,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.risuAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            stepDirection: 10,
            startDirection: -20,
            optionName: global.TextContainer.risuAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 68,
            optionName: global.TextContainer.risuAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 5,
            stepDirection: 10,
            startDirection: -25,
            optionName: global.TextContainer.risuAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.44,
            speed: 7.5,
            optionName: global.TextContainer.risuAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.3,
            image_yscale: 1.3,
            hitLimit: 8,
            bounce: 1,
            duration: 150,
            optionIcon: 2221,
            optionName: global.TextContainer.risuAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 665,
    isMain: true,
    weaponType: "MultiShot",
    optionName: global.TextContainer.risuAttackName.selectedLanguage,
    optionDescription: global.TextContainer.risuAttackDesc.selectedLanguage[0]
}));

PaintBrush = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 1;
        arg0.collides = true;
        if (arg0.countID == 1)
        {
            arg0.image_yscale *= -1;
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "PaintBrush", new Attack("PaintBrush", defaultConfig, 
{
    attackTime: 90,
    damage: 1,
    faceCreatorDirection: true,
    sprite_index: spr_IofiBrushSwing1,
    playSound: [46],
    destroyOnHitLimit: false,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0,
    hitLimit: -1,
    collides: false,
    attackCount: 1,
    script: PaintBrush,
    stayOnCreator: true,
    canAddProjectile: false,
    hitCD: 30,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.iofiAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 15,
            optionName: global.TextContainer.iofiAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.iofiAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 12,
            optionName: global.TextContainer.iofiAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            optionName: global.TextContainer.iofiAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            sprite_index: spr_IofiBrushSwing2,
            afterImageColor: 32768,
            onHitEffects: 
            {
                Painted: 
                {
                    amount: 15,
                    chance: 10
                }
            },
            optionIcon: 2345,
            optionName: global.TextContainer.iofiAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 259,
    isMain: true,
    weaponType: "Melee",
    optionName: global.TextContainer.iofiAttackName.selectedLanguage,
    optionDescription: global.TextContainer.iofiAttackDesc.selectedLanguage[0]
}));

SwordSpin = function(arg0, arg1)
{
    var lifetime;
    arg0.sprite_index = spr_OllieSwordSpin;
    arg0.image_angle += 25;
    arg0.lifetime++;
    if (arg0.lifetime <= 25)
    {
        if (arg0.speed > 0)
        {
            arg0.speed *= 0.9;
        }
        else
        {
            arg0.speed = 0;
        }
    }
    else
    {
        arg0.speed += 0.5;
        arg0.direction = point_direction(arg0.x, arg0.y, arg1.x, arg1.y);
    }
};

ds_map_set(attackIndex, "SwordSpin", new Attack("SwordSpin", defaultConfig, 
{
    damage: 1.2,
    sprite_index: spr_OllieSwordSpin,
    attackTime: 120,
    attackCount: 1,
    collides: true,
    attackDelay: 60,
    hitLimit: -1,
    hitCD: 15,
    duration: 50,
    speed: 20,
    isMain: true,
    lifetime: 0,
    destroyOnHitLimit: true,
    targetRandom: false,
    faceCreatorDirection: true,
    script: SwordSpin,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 1,
    attackDamageID: "OllieSword"
}));

OllieSwordThrow = function(arg0, arg1)
{
    var config = {};
    if (arg0.config.level > 1)
    {
        var level = arg0.config.level;
        variable_struct_copy(arg0.config.levels[level - 2].config, config);
    }
    if (variable_struct_exists(arg0, "StampVars"))
    {
        config.StampVars = {};
        variable_struct_copy(arg0.StampVars, config.StampVars);
    }
    if (variable_struct_exists(arg0, "onHitEffects"))
    {
        config.onHitEffects = {};
        variable_struct_copy(arg0.onHitEffects, config.onHitEffects);
    }
    config.enhancements = arg0.enhancements;
    config.attackDamageID = "OllieSword";
    config.reverse = arg0.reverse;
    config.knockback = arg0.knockback;
    config.applyWeaponSize = true;
    if (!variable_struct_exists(config, "damage"))
    {
        config.damage = arg0.damage;
    }
    if (variable_instance_exists(arg0, "effectDamage"))
    {
        config.damage = config.damage * arg0.effectDamage;
    }
    obj_AttackController.ExecuteAttack("SwordSpin", arg1, config);
};

ds_map_set(attackIndex, "OllieSword", new Attack("OllieSword", defaultConfig, 
{
    attackTime: 90,
    damage: 1.3,
    faceCreatorDirection: true,
    sprite_index: spr_OllieSword,
    playSound: [114],
    destroyOnHitLimit: false,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 1,
    hitLimit: -1,
    collides: true,
    attackCount: 1,
    stayOnCreator: true,
    canAddProjectile: false,
    hitCD: 20,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.ollieAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.ollieAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 81,
            optionName: global.TextContainer.ollieAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2.028,
            image_xscale: 1.56,
            image_yscale: 1.56,
            optionName: global.TextContainer.ollieAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 73,
            optionName: global.TextContainer.ollieAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            sprite_index: spr_OllieSword2,
            afterImageColor: 255,
            onCreate: OllieSwordThrow,
            optionIcon: 122,
            optionName: global.TextContainer.ollieAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 370,
    isMain: true,
    weaponType: "Melee",
    optionName: global.TextContainer.ollieAttackName.selectedLanguage,
    optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[0]
}));

SpreadFeather = function(arg0, arg1)
{
    var lifetime;
    arg0.direction += 1;
    arg0.image_angle = arg0.direction;
    if (arg0.lifetime == 10 && arg0.createSpread)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        ExecuteAttack("ReineFeather", arg0.creator, 
        {
            sprite_index: arg0.sprite_index,
            damage: arg0.damage,
            enhancements: arg0.enhancements,
            StampVars: copyStampVars,
            onHitEffects: totalOnHitEffects,
            createSpread: false,
            CritMod: arg0.CritMod,
            afterImageColor: arg0.afterImageColor,
            knockback: arg0.knockback,
            faceCreatorDirection: false,
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale,
            startDirection: 0,
            speed: 13,
            direction: arg0.direction + 180,
            image_angle: arg0.image_angle + 180,
            playSound: arg0.playSound
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "ReineFeather", new Attack("ReineFeather", defaultConfig, 
{
    sprite_index: spr_ReineFeather,
    attackTime: 100,
    duration: 15,
    damage: 1.2,
    hitCD: 15,
    playSound: [46],
    soundPitch: true,
    hitLimit: -1,
    speed: 10,
    targetRandom: false,
    canAddProjectile: true,
    script: SpreadFeather,
    projOrientation: "spread",
    attackCount: 2,
    stepDirection: 10,
    createSpread: false,
    startDirection: -15,
    attackDelay: 8,
    destroyOnHitLimit: true,
    range: 120,
    faceCreatorDirection: true,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            attackCount: 3,
            stepDirection: 10,
            startDirection: -15,
            optionName: global.TextContainer.reineAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.reineAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 85,
            optionName: global.TextContainer.reineAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            stepDirection: 8,
            startDirection: -20,
            attackDelay: 7,
            optionName: global.TextContainer.reineAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            attackCount: 5,
            stepDirection: 7,
            startDirection: -19,
            attackDelay: 6,
            speed: 13,
            optionName: global.TextContainer.reineAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 5,
            stepDirection: 10,
            startDirection: -25,
            attackDelay: 5,
            script: SpreadFeather,
            faceCreatorDirection: true,
            afterImageColor: 16711680,
            createSpread: true,
            optionIcon: 1887,
            optionName: global.TextContainer.reineAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 301,
    optionName: global.TextContainer.reineAttackName.selectedLanguage,
    optionDescription: global.TextContainer.reineAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "LargeKeris", new Attack("LargeKeris", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_AnyaLargeKeris,
    attackTime: 120,
    playSound: [263],
    soundChannel: "SummonKeris",
    attackCount: 1,
    attackDelay: 30,
    image_xscale: 1.5,
    image_yscale: 1.5,
    fadeOut: true,
    duration: 30,
    fadeTime: 10,
    weaponType: "Melee",
    hitCD: 60,
    isMelee: true,
    hitLimit: -1,
    drawBehind: true,
    afterImageColor: 16711680,
    isMain: true,
    attackDamageID: "Keris",
    knockback: 
    {
        duration: 10,
        speed: 4
    }
}));

Keris = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.collides = true;
        arg0.image_alpha = 1;
        var perp = arg1.direction;
        arg0.x = arg1.x + lengthdir_x(130 + arg0.extraRange, perp);
        arg0.y = (arg1.y - 16) + lengthdir_y(130 + arg0.extraRange, perp);
        if (arg0.largeKeris && arg0.countID == 0)
        {
            var targets = ds_list_create();
            var pickUpRange = 40 + ((40 * arg1.pickupRange) / 100);
            if (instance_exists(obj_Enemy))
            {
                collision_circle_list(arg1.x, arg1.y, pickUpRange, obj_Enemy, true, true, targets, false);
            }
            var fourRandom = [];
            var targetSize = min(4, ds_list_size(targets));
            while (array_length(fourRandom) < targetSize)
            {
                var randomIndex = irandom(ds_list_size(targets) - 1);
                if (!array_exists(fourRandom, randomIndex))
                {
                    array_push(fourRandom, randomIndex);
                }
            }
            for (var i = 0; i < targetSize; i++)
            {
                obj_AttackController.ExecuteAttack("LargeKeris", arg1, 
                {
                    damage: arg0.damage / 1.5,
                    x: ds_list_find_value(targets, i).x,
                    y: ds_list_find_value(targets, i).y,
                    enhancements: arg0.enhancements,
                    applyWeaponSize: true
                }, true);
            }
            ds_list_destroy(targets);
            targets = -1;
        }
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Keris", new Attack("Keris", defaultConfig, 
{
    sprite_index: spr_AnyaKeris,
    attackTime: 90,
    damage: 1,
    duration: 30,
    hitCD: 60,
    collides: false,
    image_alpha: 0,
    playSound: [114, 34],
    soundPitch: true,
    hitLimit: -1,
    targetRandom: false,
    image_xscale: 1.5,
    image_yscale: 1.5,
    canAddProjectile: false,
    script: Keris,
    projOrientation: "spread",
    attackCount: 1,
    largeKeris: false,
    extraRange: 0,
    createSpread: false,
    startDirection: 0,
    destroyOnHitLimit: true,
    range: 120,
    faceCreatorDirection: true,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            attackCount: 2,
            startDirection: -12.5,
            stepDirection: 25,
            optionName: global.TextContainer.anyaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.anyaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 76.5,
            optionName: global.TextContainer.anyaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: -25,
            stepDirection: 25,
            optionName: global.TextContainer.anyaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            startDirection: -37.5,
            stepDirection: 25,
            image_xscale: 2.25,
            extraRange: 20,
            image_yscale: 2.25,
            optionName: global.TextContainer.anyaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            largeKeris: true,
            damage: 1.5,
            optionIcon: 2331,
            optionName: global.TextContainer.anyaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 969,
    optionName: global.TextContainer.anyaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.anyaAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "Minerals", new Attack("Minerals", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_KaelaMinerals,
    image_speed: 0,
    attackTime: 120,
    playSound: [66],
    soundChannel: "minerals",
    attackCount: 1,
    image_xscale: 1.5,
    image_yscale: 1.5,
    duration: 120,
    weaponType: "Melee",
    hitCD: 60,
    projSpeed: 0,
    gravity: 0.5,
    isMelee: true,
    hitLimit: 10,
    destroyOnHitLimit: true,
    isMain: true,
    attackDamageID: "BlacksmithHammer"
}));

BlacksmithHammer = function(arg0, arg1)
{
    var lifetime;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "BlacksmithHammer", new Attack("BlacksmithHammer", defaultConfig, 
{
    sprite_index: spr_KaelaHammer,
    attackTime: 70,
    damage: 1.2,
    hitCD: 60,
    collides: true,
    playSound: [46],
    soundPitch: true,
    hitLimit: -1,
    targetRandom: false,
    image_xscale: 1.2,
    image_yscale: 1.2,
    canAddProjectile: false,
    projOrientation: "spread",
    attackCount: 1,
    faceCreatorDirection: true,
    stayOnCreator: true,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.kaelaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.44,
            image_yscale: 1.44,
            optionName: global.TextContainer.kaelaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 60,
            optionName: global.TextContainer.kaelaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 5,
                speed: 5
            },
            optionName: global.TextContainer.kaelaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 2.028,
            image_xscale: 1.872,
            image_yscale: 1.872,
            optionName: global.TextContainer.kaelaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                MineralHit: 
                {
                    chance: 30
                }
            },
            damage: 2.6364,
            sprite_index: spr_KaelaHammer2,
            afterImageColor: 4235519,
            optionIcon: 2352,
            optionName: global.TextContainer.kaelaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 1494,
    optionName: global.TextContainer.kaelaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.kaelaAttackDesc.selectedLanguage[0]
}));

SilentPistol = function(arg0, arg1)
{
    if (variable_struct_exists(arg1.buffs, "Invisible"))
    {
        arg0.sprite_index = spr_ZetaBigBullet;
        arg0.speed *= 3;
        arg0.image_xscale *= 2;
        arg0.image_yscale *= 2;
        var vfx = instance_create_depth(arg1.x, arg1.y - 16, arg1.depth + 50, obj_vfx);
        vfx.sprite_index = spr_ZetaFlash;
        vfx.image_speed = 0;
        vfx.direction = arg1.direction;
        vfx.image_angle = arg1.direction;
        vfx.image_alpha = 0.3;
        vfx.image_xscale = 2;
        vfx.image_yscale = 2;
        vfx.add = true;
        vfx.alarm[1] = 1;
        vfx.fadeSpeed = 0.05;
        vfx.duration = 30;
    }
    else
    {
        arg0.image_alpha = 1;
    }
};

ds_map_set(attackIndex, "SilentPistol", new Attack("SilentPistol", defaultConfig, 
{
    sprite_index: spr_ZetaPistol,
    attackTime: 90,
    damage: 0.9,
    hitCD: 60,
    collides: true,
    playSound: [246],
    soundPitch: true,
    hitLimit: -1,
    speed: 11,
    attackCount: 2,
    attackDelay: 5,
    duration: 90,
    targetRandom: false,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0,
    canAddProjectile: true,
    onCreate: SilentPistol,
    projOrientation: "none",
    faceCreatorDirection: true,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.1,
            optionName: global.TextContainer.zetaAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 76,
            optionName: global.TextContainer.zetaAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            optionName: global.TextContainer.zetaAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 3,
                speed: 3
            },
            optionName: global.TextContainer.zetaAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            speed: 15,
            damage: 1.463,
            optionName: global.TextContainer.zetaAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            onHitEffects: 
            {
                PiercerShot: {}
            },
            sprite_index: spr_ZetaPistol2,
            afterImageColor: 16711680,
            shotBuffed: 0,
            optionIcon: 2268,
            optionName: global.TextContainer.zetaAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "MultiShot",
    optionIcon: 1759,
    optionName: global.TextContainer.zetaAttackName.selectedLanguage,
    optionDescription: global.TextContainer.zetaAttackDesc.selectedLanguage[0]
}));
ds_map_set(attackIndex, "UmbrellaRain", new Attack("UmbrellaRain", defaultConfig, 
{
    sprite_index: spr_CEOTears,
    attackTime: 150,
    damage: 1,
    hitLimit: 10,
    speed: 8,
    gravity: 0.2,
    image_xscale: 1,
    image_yscale: 1,
    attackDamageID: "Umbrella",
    hitCD: 30,
    duration: 60,
    lifetime: 0,
    destroyOnHitLimit: true
}));

Umbrella = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 4)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        soundPlay([33], "umbrellarain", 15, 15);
        for (var i = 0; i < 10; i++)
        {
            obj_AttackController.ExecuteAttack("UmbrellaRain", arg1, 
            {
                damage: arg0.damage / 1.5,
                enhancements: arg0.enhancements,
                StampVars: copyStampVars,
                onHitEffects: totalOnHitEffects,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                faceCreatorDirection: false,
                image_xscale: arg0.image_xscale,
                image_yscale: arg0.image_yscale,
                direction: (arg0.direction - 45) + irandom(90),
                image_angle: arg0.image_angle
            });
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Umbrella", new Attack("Umbrella", defaultConfig, 
{
    sprite_index: spr_KoboUmbrella,
    attackTime: 90,
    damage: 1.1,
    hitCD: 60,
    collides: true,
    stayOnCreator: true,
    playSound: [46],
    soundPitch: true,
    hitLimit: -1,
    targetRandom: false,
    image_xscale: 1,
    image_yscale: 1,
    canAddProjectile: false,
    projOrientation: "none",
    faceCreatorDirection: true,
    lifetime: 0,
    levels: [
    {
        config: 
        {
            damage: 1.32,
            optionName: global.TextContainer.koboAttackName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            optionName: global.TextContainer.koboAttackName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 3,
                speed: 3
            },
            optionName: global.TextContainer.koboAttackName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 76,
            optionName: global.TextContainer.koboAttackName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.5,
            image_yscale: 1.5,
            damage: 1.65,
            optionName: global.TextContainer.koboAttackName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            afterImageColor: 16711680,
            script: Umbrella,
            optionIcon: 228,
            optionName: global.TextContainer.koboAttackName.selectedLanguage + " " + global.TextContainer.awakenedTag.selectedLanguage,
            optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    isMain: true,
    weaponType: "Melee",
    optionIcon: 1779,
    optionName: global.TextContainer.koboAttackName.selectedLanguage,
    optionDescription: global.TextContainer.koboAttackDesc.selectedLanguage[0]
}));
event_user(3);
event_user(4);
event_user(5);
event_user(6);
event_user(7);
if (variable_global_exists("attacksLibrary"))
{
    if (ds_exists(global.attacksLibrary, ds_type_map))
    {
        ds_map_destroy(global.attacksLibrary);
        global.attacksLibrary = -1;
    }
}
global.attacksLibrary = ds_map_create();
ds_map_copy(global.attacksLibrary, attackIndex);
