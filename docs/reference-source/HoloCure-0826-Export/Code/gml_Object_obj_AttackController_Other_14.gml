ds_map_set(attackIndex, "CalliDeath", new Attack("CalliDeath", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_Calli_death,
    attackTime: 120,
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    drawBehind: true,
    image_xscale: 2,
    image_yscale: 2,
    isSkill: true,
    optionType: "Skill",
    onHitEffects: 
    {
        DeathExplod: 
        {
            chance: 30,
            deathChance: 5,
            damage: 1,
            size: 1
        },
        Death: 
        {
            chance: 5,
            heal: 0,
            chance: 30,
            deathChance: 5,
            damage: 1,
            size: 1
        }
    }
}));

function PowerOfAtlantis()
{
    var randomPos = obj_MobManager.FindTargetInRange(
    {
        x: creator.x,
        y: creator.y
    }, 367, 150);
    x = randomPos.x;
    y = randomPos.y;
    
    OnCollideWithTarget = function(arg0)
    {
        if (collides)
        {
            HitTarget(arg0);
        }
        if (creator.isEnemy != arg0.isEnemy)
        {
            var dir = point_direction(arg0.x, arg0.y, x, y);
            var dist = 0.5;
            arg0.x += lengthdir_x(dist, dir);
            arg0.y += lengthdir_y(dist, dir);
        }
    };
}

ds_map_set(attackIndex, "PowerOfAtlantis", new Attack("PowerOfAtlantis", defaultConfig, 
{
    collides: true,
    damage: 0.3,
    sprite_index: spr_whirlpool,
    image_xscale: 1.5,
    image_yscale: 1.5,
    attackTime: 600,
    attackCount: 1,
    duration: 360,
    hitLimit: -1,
    hitCD: 30,
    drawBehind: true,
    isSkill: true,
    optionType: "Skill",
    playSound: [75],
    soundPitch: true,
    onCreate: PowerOfAtlantis,
    range: 80,
    height: 64,
    onHitEffects: 
    {
        Vulnerability: 
        {
            amount: 15
        }
    },
    levels: [
    {
        config: 
        {
            collides: true,
            damage: 0.4,
            attackCount: 2,
            image_xscale: 1.6,
            height: 102,
            image_yscale: 1.6,
            onHitEffects: 
            {
                Vulnerability: 
                {
                    amount: 30
                }
            }
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            image_xscale: 1.75,
            image_yscale: 1.75,
            height: 112,
            collides: true,
            damage: 0.5,
            onHitEffects: 
            {
                Vulnerability: 
                {
                    amount: 50
                }
            }
        }
    }],
    maxLevel: 3
}));

function _CreateTakodachi(arg0, arg1)
{
    with (arg0)
    {
        DropExp();
        instance_change(obj_Enemy, true);
        sprite_index = spr_takodachi;
        mask_index = spr_takodachi_mask;
        isEnemy = false;
        isConvertTako = true;
        invincible = true;
        global.enemyDefeated++;
        lifeTime = -1;
        SetStats(
        {
            ATK: -1
        });
        var sizeRandom = 1;
        image_xscale = sizeRandom;
        image_yscale = sizeRandom;
        transparent = true;
        stacks = 1;
        var keys = variable_struct_get_names(behaviours);
        for (var i = 0; i < array_length(keys); i++)
        {
            if (keys[i] != "followPlayer")
            {
                variable_struct_remove(behaviours, keys[i]);
            }
        }
        keys = variable_struct_get_names(customDrawScriptAbove);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_remove(customDrawScriptAbove, keys[i]);
        }
        keys = variable_struct_get_names(customDrawScriptBelow);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_remove(customDrawScriptBelow, keys[i]);
        }
        keys = variable_struct_get_names(scripts);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_remove(scripts, keys[i]);
        }
        keys = variable_struct_get_names(onTakeDamage);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_remove(onTakeDamage, keys[i]);
        }
        keys = variable_struct_get_names(buffs);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_remove(buffs, keys[i]);
        }
        if (!variable_struct_exists(behaviours, "followPlayer"))
        {
            behaviours.followPlayer = 
            {
                Script: function(arg0, arg1)
                {
                    with (arg0)
                    {
                        if (!instance_exists(followTarget))
                        {
                            return false;
                        }
                        if (canMove)
                        {
                            obj_MobManager.MoveToPosition(followTarget, self);
                        }
                    }
                },
                
                config: {}
            };
            lockFacing = false;
            knockbackImmune = false;
        }
        arg0.speed = 0;
        arg0.baseStats.SPD = 0.55;
        arg0.prebuffStats.SPD = 0.55;
        arg0.SPD = 0.55;
        arg0.followTarget = instance_find(obj_Player, 0);
        if (arg1)
        {
            behaviours.collideWithPlayer = 
            {
                Script: function(arg0, arg1)
                {
                    with (arg0)
                    {
                        var otherTako = instance_place(arg0.x, arg0.y, obj_Enemy);
                        if (place_meeting(x, y, obj_Player) && abs(obj_Player.y - arg0.y) < max(10, 10 * arg0.image_xscale) && abs(obj_Player.x - arg0.x) < max(10, 8 * arg0.image_xscale))
                        {
                            obj_AttackController.ExecuteAttack("TakoExplode", 227, 
                            {
                                x: arg0.x,
                                y: arg0.y,
                                image_xscale: 1 + (arg0.stacks * 0.1),
                                image_yscale: 1 + (arg0.stacks * 0.1),
                                isSkill: true,
                                damage: 0.1 * arg0.stacks,
                                knockback: 
                                {
                                    duration: min(20, 1 + (arg0.stacks div 5)),
                                    speed: min(20, 1 + (arg0.stacks div 5))
                                }
                            });
                            Heal(227, 1 * arg0.stacks, 1);
                            Die(false, false, undefined, true, true);
                        }
                        else if (otherTako != -4)
                        {
                            if (!otherTako.isEnemy && variable_instance_exists(otherTako, "isConvertTako"))
                            {
                                if (arg0.id > otherTako.id)
                                {
                                    arg0.stacks += otherTako.stacks;
                                    arg0.image_xscale = 1 + (arg0.stacks * 0.1);
                                    arg0.image_yscale = 1 + (arg0.stacks * 0.1);
                                    with (otherTako)
                                    {
                                        obj_StageManager.enemyAmount--;
                                        if (ds_exists(playerMesh, ds_type_list))
                                        {
                                            glr_mesh_destroy(playerMesh);
                                        }
                                        instance_destroy();
                                    }
                                }
                            }
                        }
                    }
                },
                
                config: {}
            };
        }
        else
        {
            scripts.PlayerCollision = 
            {
                Script: function(arg0, arg1)
                {
                    with (arg0)
                    {
                        if (place_meeting(x, y, obj_Player))
                        {
                            obj_StageManager.enemyAmount--;
                            Die(false, false, undefined, false, true);
                        }
                    }
                },
                
                config: {}
            };
        }
    }
    return arg0;
}

function TheAncientOne(arg0)
{
    var roll = irandom(99);
    if (attackObj.chance > roll)
    {
        var heals = attackObj.heals;
        if (arg0.miniboss || arg0.isBoss || !arg0.isEnemy)
        {
            exit;
        }
        obj_AttackController._CreateTakodachi(arg0, heals);
    }
    else if (arg0.isEnemy)
    {
        var dmgObj = obj_AttackController.CalculateDamage(arg0, 227, 
        {
            damage: 1.25
        });
        arg0.TakeDamage(dmgObj[0], attackObj, dmgObj[1], "AncientOne");
    }
}

function TheAncientOneOnCreate(arg0, arg1)
{
    target = obj_MobManager.FindTargetInRange(arg1);
    arg0.x = target.x;
    arg0.y = target.y;
}

ds_map_set(attackIndex, "TheAncientOne", new Attack("TheAncientOne", defaultConfig, 
{
    sprite_index: spr_InaConvertFX,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0.8,
    damage: 1,
    attackTime: 300,
    collides: false,
    playSound: false,
    hitLimit: -1,
    duration: 160,
    isSkill: true,
    soundChannel: "special",
    soundPrio: 30,
    optionType: "Skill",
    chance: global.SkillData.TheAncientOne.chance[0],
    heals: true,
    onCreate: TheAncientOneOnCreate,
    maxLevel: 3,
    levels: [
    {
        config: 
        {
            chance: global.SkillData.TheAncientOne.chance[1],
            heals: true,
            image_xscale: 2.25,
            image_yscale: 2.25,
            damage: 1.5,
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
                    radius: 100,
                    HitTarget: gml_Script_TheAncientOne_gml_Object_obj_AttackController_Other_14
                }
            }]
        }
    }, 
    {
        config: 
        {
            chance: global.SkillData.TheAncientOne.chance[2],
            heals: true,
            image_xscale: 2.5,
            image_yscale: 2.5,
            damage: 2,
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
                    radius: 120,
                    HitTarget: gml_Script_TheAncientOne_gml_Object_obj_AttackController_Other_14
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
            radius: 80,
            HitTarget: gml_Script_TheAncientOne_gml_Object_obj_AttackController_Other_14
        }
    }],
    script: TimelineCustomAttack
}));
ds_map_set(attackIndex, "Trailblazer", new Attack("Trailblazer", defaultConfig, 
{
    sprite_index: spr_KiaraEmbers,
    damage: global.SkillData.Trailblazer.damage[0],
    duration: 240,
    hitLimit: -1,
    isSkill: true,
    hitCD: 45,
    drawBehind: true,
    optionType: "Skill"
}));
ds_map_set(attackIndex, "HeadphoneKnockback", new Attack("HeadphoneKnockback", defaultConfig, 
{
    damage: -1,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 0,
    playSound: [233],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    drawBehind: true,
    knockback: 
    {
        duration: 10,
        speed: 10
    }
}));
ds_map_set(attackIndex, "HopeExplode", new Attack("HopeExplode", defaultConfig, 
{
    damage: -1,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 0,
    attackCount: 1,
    attackDelay: 30,
    isSkill: true,
    playSound: [233],
    hitLimit: -1,
    drawBehind: true,
    optionType: "Skill",
    knockback: 
    {
        duration: 10,
        speed: 10
    }
}));
ds_map_set(attackIndex, "TakoExplode", new Attack("TakoExplode", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 0,
    attackCount: 1,
    optionType: "Skill",
    isSkill: true,
    attackDelay: 30,
    playSound: [92],
    hitLimit: -1,
    drawBehind: true,
    knockback: 
    {
        duration: 1,
        speed: 1
    }
}));

SanaGravity = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.damage += arg0.image_xscale - 1;
        arg0.image_alpha = 0.9;
        arg0.collides = true;
        arg0.image_xscale = 0.01;
        arg0.image_yscale = 0.01;
    }
    if (arg0.lifetime > 20)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.lifetime++;
    arg0.image_xscale += (0.1 * (30 - arg0.lifetime)) / 30;
    arg0.image_yscale += (0.1 * (30 - arg0.lifetime)) / 30;
};

ds_map_set(attackIndex, "SanaGravity", new Attack("SanaGravity", defaultConfig, 
{
    damage: 1.25,
    collides: false,
    sprite_index: spr_GravityRing,
    attackTime: 300,
    attackCount: 1,
    attackDelay: 300,
    hitLimit: -1,
    duration: 30,
    lifetime: 0,
    optionType: "Skill",
    isSkill: true,
    image_alpha: 0,
    knockback: 
    {
        duration: 10,
        speed: 3,
        immunityBypass: true
    },
    script: SanaGravity,
    levels: [
    {
        config: 
        {
            damage: 1.5,
            knockback: 
            {
                duration: 10,
                speed: 5
            }
        }
    }, 
    {
        config: 
        {
            damage: 2,
            knockback: 
            {
                duration: 10,
                speed: 7
            }
        }
    }],
    maxLevel: 3
}));

TimeBubbleScript = function(arg0, arg1)
{
    var lifeTime;
    arg0.lifeTime++;
    if (arg0.lifeTime == 21)
    {
        arg0.sprite_index = spr_KroniiTimeBubble;
        arg0.collides = true;
    }
    if (arg0.lifeTime == 185)
    {
        arg0.sprite_index = spr_KroniiTimeBubbleEnd;
        arg0.collides = false;
    }
};

function TimeBubble()
{
    var randomPos = obj_MobManager.FindTargetInRange(
    {
        x: creator.x,
        y: creator.y
    }, 367, 100);
    x = randomPos.x;
    y = randomPos.y;
    
    OnCollideWithTarget = function(arg0)
    {
        if (creator.isEnemy != arg0.isEnemy && collides)
        {
            arg0.Freeze(30);
        }
    };
}

ds_map_set(attackIndex, "TimeBubble", new Attack("TimeBubble", defaultConfig, 
{
    collides: false,
    damage: -1,
    sprite_index: spr_KroniiTimeBubbleStart,
    image_xscale: 1.5,
    image_yscale: 1.5,
    attackTime: 600,
    minDelay: 245,
    playSound: [150],
    soundChannel: "timeBubble",
    soundPrio: 5,
    attackCount: 1,
    duration: 200,
    hitLimit: -1,
    isSkill: true,
    hitCD: 30,
    optionType: "Skill",
    onCreate: TimeBubble,
    lifeTime: 0,
    transparent: true,
    script: TimeBubbleScript,
    range: 80,
    levels: [
    {
        config: 
        {
            image_xscale: 1.65,
            image_yscale: 1.65
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.8,
            image_yscale: 1.8
        }
    }],
    maxLevel: 3
}));

function GuardianTree()
{
    var randomPos = obj_MobManager.FindTargetInRange(
    {
        x: creator.x,
        y: creator.y
    }, 367, 170);
    var facing = 1;
    if (!is_struct(randomPos))
    {
        facing = randomPos.image_xscale / abs(randomPos.image_xscale);
        image_xscale *= -facing;
    }
    x = randomPos.x + (10 * facing);
    y = randomPos.y + 2;
}

ds_map_set(attackIndex, "GuardianTree", new Attack("GuardianTree", defaultConfig, 
{
    damage: 2,
    sprite_index: spr_FaunaGuardianTree,
    attackTime: 0,
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    isSkill: true,
    optionType: "Skill",
    hitCD: 60,
    playSound: [98],
    image_xscale: 2,
    image_yscale: 2,
    onCreate: GuardianTree,
    knockback: 
    {
        duration: 10,
        speed: 15
    }
}));
ds_map_set(attackIndex, "KonKonShout", new Attack("KonKonShout", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 120,
    playSound: [100],
    image_xscale: 2,
    image_yscale: 2,
    attackCount: 1,
    isSkill: true,
    attackDelay: 30,
    optionType: "Skill",
    hitLimit: -1,
    drawBehind: true
}));

RoboDischarge = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.collides = true;
        arg0.damage = arg0.baseDamage + (global.PLAYERLEVEL * 0.01);
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "RoboDischarge", new Attack("RoboDischarge", defaultConfig, 
{
    sprite_index: spr_RobocoElectric,
    damage: 1,
    baseDamage: 1,
    image_xscale: 1,
    image_yscale: 1,
    playSound: [225],
    attackTime: 300,
    hitLimit: -1,
    projSpeed: 0,
    isSkill: true,
    collides: false,
    hitCD: 40,
    stayOnCreator: true,
    transparent: true,
    script: RoboDischarge,
    lifetime: 0,
    duration: 300
}));

SuiseiBlocks = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.gravity = 0.5;
        arg0.direction = 270;
        arg0.speed = 5;
        arg0.randomFacing = 90 * irandom(3);
        arg0.image_index = irandom((arg0.blockCount * 4) - 1);
    }
    arg0.image_angle = arg0.randomFacing + arg0.direction;
    if (arg0.speed > 15)
    {
        arg0.speed = 15;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "SuiseiBlocks", new Attack("SuiseiBlocks", defaultConfig, 
{
    attackTime: 75,
    damage: 0.75,
    faceCreatorDirection: true,
    sprite_index: spr_SuiseiFallingBlocks,
    playSound: [263],
    destroyOnHitLimit: true,
    ogHitLimit: 3,
    deflects: 2,
    image_xscale: 1,
    image_yscale: 1,
    image_speed: 0,
    duration: 120,
    optionType: "Skill",
    isSkill: true,
    randomFacing: 0,
    blockCount: 1,
    horMove: 0,
    verMove: 0,
    hitLimit: 7,
    script: SuiseiBlocks,
    hitCD: 30,
    lifetime: 0,
    onHitEffects: 
    {
        Flatten: 
        {
            resist: 300,
            chance: 30
        }
    }
}));

SuiseiStarBlocks = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.gravity = 0.5;
        arg0.direction = 270;
        arg0.speed = 5;
        arg0.randomFacing = 90 * irandom(3);
        arg0.image_index = irandom((arg0.blockCount * 4) - 1);
    }
    arg0.image_angle = arg0.randomFacing + arg0.direction;
    if (arg0.speed > 20)
    {
        arg0.speed = 20;
    }
    if (arg0.y > arg0.setY)
    {
        arg0.y = arg0.setY;
        arg0.speed = 0;
        arg0.gravity = 0;
        soundPlay([258], "explosion", 20, 30);
        if (global.screenshake)
        {
            obj_Cam.ExecuteShake(30, 5);
        }
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "SuiseiStarBlocks", new Attack("SuiseiStarBlocks", defaultConfig, 
{
    attackTime: 75,
    damage: 3,
    faceCreatorDirection: true,
    sprite_index: spr_SuiseiFallingBlocks,
    destroyOnHitLimit: true,
    image_xscale: 3,
    image_yscale: 3,
    image_speed: 0,
    drawBehind: true,
    duration: 120,
    setY: 0,
    randomFacing: 0,
    blockCount: 1,
    isSkill: true,
    horMove: 0,
    isMain: true,
    verMove: 0,
    hitLimit: -1,
    script: SuiseiStarBlocks,
    hitCD: 120,
    lifetime: 0,
    onHitEffects: 
    {
        Flatten: 
        {
            resist: 600,
            chance: 100
        }
    }
}));

SuiseiSpec = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(300);
    }
    if ((arg0.lifetime % 15) == 0)
    {
        ExecuteAttack("SuiseiStarBlocks", arg1, 
        {
            x: (arg1.x - 320) + (irandom(floor(4.848484848484849)) * 132) + 66,
            y: arg1.y - 180,
            setY: (arg1.y - 180) + (irandom(floor(2.727272727272727)) * 132) + 66,
            blockCount: 3
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "SuiseiSpec", new Attack("SuiseiSpec", defaultConfig, 
{
    attackTime: 60,
    hitLimit: -1,
    lifetime: 0,
    duration: 300,
    targetRandom: true,
    stayOnCreator: false,
    script: SuiseiSpec,
    emitter: 0,
    collides: false
}));

Nyeh = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.gravity = 0.1;
        arg0.vspeed = -2;
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Nyeh", new Attack("Nyeh", defaultConfig, 
{
    damage: 0.5,
    sprite_index: spr_MikoNyeh,
    attackTime: 120,
    image_alpha: 0.8,
    playSound: [223],
    attackCount: 1,
    attackDelay: 30,
    hitCD: 30,
    hitLimit: -1,
    optionType: "Skill",
    isSkill: true,
    duration: 30,
    lifetime: 0,
    image_xscale: 1.5,
    image_yscale: 1.5,
    script: Nyeh,
    onHitEffects: 
    {
        Nyeh: {}
    }
}));

Omen = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime < 5)
    {
        if (arg0.image_alpha < 1)
        {
            arg0.image_alpha += 0.2;
        }
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Omen", new Attack("Omen", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_MioOmen,
    attackTime: 120,
    playSound: [52],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    drawBehind: true,
    soundChannel: "omen",
    hitCD: 120,
    duration: 30,
    lifetime: 0,
    isSkill: true,
    optionType: "Skill",
    script: Omen,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0,
    onHitEffects: 
    {
        SpecDrain: 
        {
            amount: 1
        }
    }
}));

EncoreBurst = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.damage += arg0.damageStacks / 100;
        arg0.image_alpha = 0.6;
        arg0.collides = true;
        arg0.image_xscale = 0.01;
        arg0.image_yscale = 0.01;
        for (var i = 0; i < 30; i++)
        {
            var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_vfx);
            vfx.sprite_index = spr_AZKi_music;
            vfx.duration = 60;
            vfx.image_xscale = 0.4;
            vfx.image_yscale = 0.4;
            vfx.image_alpha = 0.8;
            vfx.hspeed = -7 + irandom(14);
            vfx.vspeed = -7 + irandom(14);
            vfx.gravity = 0.15;
            vfx.alarm[1] = 20;
        }
    }
    if (arg0.lifetime > 20)
    {
        arg0.image_alpha -= 0.08;
    }
    arg0.lifetime++;
    arg0.image_xscale += (0.1 * (30 - arg0.lifetime)) / 30;
    arg0.image_yscale += (0.1 * (30 - arg0.lifetime)) / 30;
};

ds_map_set(attackIndex, "EncoreBurst", new Attack("EncoreBurst", defaultConfig, 
{
    damage: 1,
    collides: false,
    sprite_index: spr_GravityRing,
    attackTime: 300,
    attackCount: 1,
    attackDelay: 300,
    hitLimit: -1,
    duration: 30,
    soundPitch: true,
    playSound: [11],
    isSkill: true,
    lifetime: 0,
    optionType: "Skill",
    image_alpha: 0,
    damageStacks: 0,
    knockback: 
    {
        duration: 5,
        speed: 3
    },
    script: EncoreBurst
}));

MelBat = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.direction = 60 + random(60);
        arg0.speed = 0.5 + random(1);
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
        arg0.direction -= min(abs(directionDifference), 5) * sign(directionDifference);
    }
    if (arg0.speed < 6)
    {
        arg0.speed += 0.2;
    }
    if (arg0.direction < 90 || arg0.direction >= 270)
    {
        arg0.image_xscale = abs(arg0.image_xscale);
    }
    else
    {
        arg0.image_xscale = -abs(arg0.image_xscale);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MelBat", new Attack("MelBat", defaultConfig, 
{
    damage: 1.2,
    sprite_index: spr_MelBat,
    attackTime: 120,
    playSound: [161],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    drawBehind: true,
    isSkill: true,
    speed: 2,
    range: 400,
    soundChannel: "bat",
    optionType: "Skill",
    hitCD: 45,
    duration: 180,
    projSpeed: 0,
    lifetime: 0,
    targetRandom: true,
    script: MelBat,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8
}));

GodBeam = function(arg0, arg1)
{
    var lifetime;
    arg0.image_angle = arg0.direction;
    arg0.image_xscale = 2;
    if (instance_exists(arg0.followTarget))
    {
        arg0.x = arg0.followTarget.x;
        arg0.y = arg0.followTarget.y - 456;
    }
    if (arg0.lifetime == 75)
    {
        arg0.collides = true;
        soundPlay([226], "laser", 10, 20);
        if (global.lightFX)
        {
            var vfx = instance_create_depth(arg0.x, (arg0.y - 456) + 10, arg0.depth - 10, obj_vfx);
            vfx.sprite_index = vfx_smoke;
            vfx.image_xscale = 2;
            vfx.image_yscale = 2;
            vfx = instance_create_depth(arg0.x, (arg0.y - 456) + 10, arg0.depth - 10, obj_vfx);
            vfx.sprite_index = vfx_smoke;
            vfx.image_xscale = -2;
            vfx.image_yscale = 2;
        }
        obj_Cam.ExecuteShake(30, 3);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "GodBeam", new Attack("GodBeam", defaultConfig, 
{
    sprite_index: spr_fubuLaser,
    attackTime: 180,
    damage: 3,
    collides: false,
    soundChannel: "laser",
    direction: 270,
    image_xscale: 1,
    image_yscale: 10,
    image_alpha: 0.8,
    isSkill: true,
    optionType: "Skill",
    soundPrio: 20,
    script: GodBeam,
    hitLimit: -1,
    faceCreatorDirection: false,
    homing: false,
    hitCD: 60,
    lifetime: 0,
    destroyOnHitLimit: false
}));

BellyDanceBurst = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (arg0.damageStacks > 100)
        {
            obj_Cam.ExecuteShake(90, 5);
        }
        arg0.damage += arg0.damageStacks * arg0.stackDamage;
        arg0.image_alpha = 0.6;
        arg0.collides = true;
        arg0.image_xscale = 0.01;
        arg0.image_yscale = 0.01;
        for (var i = 0; i < 30; i++)
        {
            var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_vfx);
            vfx.sprite_index = spr_AkiRose;
            vfx.image_speed = 0;
            vfx.image_index = irandom(4);
            vfx.duration = 60;
            vfx.image_xscale = 2;
            vfx.image_yscale = 2;
            vfx.image_alpha = 0.8;
            vfx.hspeed = -7 + irandom(14);
            vfx.vspeed = -7 + irandom(14);
            vfx.gravity = 0.15;
            vfx.alarm[1] = 20;
        }
    }
    if (arg0.lifetime > 20)
    {
        arg0.image_alpha -= 0.08;
    }
    arg0.lifetime++;
    arg0.spriteColor = make_color_rgb(255, 140, 140);
    arg0.image_xscale += (0.15 * (30 - arg0.lifetime)) / 30;
    arg0.image_yscale += (0.15 * (30 - arg0.lifetime)) / 30;
};

ds_map_set(attackIndex, "BellyDanceBurst", new Attack("BellyDanceBurst", defaultConfig, 
{
    damage: 0,
    collides: false,
    sprite_index: spr_GravityRing,
    attackTime: 300,
    attackCount: 1,
    attackDelay: 300,
    hitLimit: -1,
    hitCD: 60,
    duration: 30,
    soundPitch: true,
    isSkill: true,
    playSound: [11],
    soundChannel: "bellydanceburst",
    lifetime: 0,
    optionType: "Skill",
    image_alpha: 0,
    damageStacks: 0,
    knockback: 
    {
        duration: 5,
        speed: 3
    },
    script: BellyDanceBurst
}));
ds_map_set(attackIndex, "BubbaBark", new Attack("BubbaBark", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 120,
    attackCount: 1,
    attackDelay: 30,
    isSkill: true,
    hitLimit: -1,
    optionType: "Skill",
    drawBehind: true
}));
ds_map_set(attackIndex, "AnkimoTaunt", new Attack("AnkimoTaunt", defaultConfig, 
{
    damage: 0.5,
    sprite_index: spr_SoraAnkimo,
    mask_index: spr_SoraAnkimo,
    image_alpha: 0,
    attackTime: 600,
    stayOnCreator: true,
    attackCount: 1,
    duration: 600,
    isSkill: true,
    hitCD: 15,
    optionType: "Skill",
    starty: 0,
    hitLimit: -1,
    drawBehind: true,
    onHitEffects: 
    {
        AnkimoTaunt: 
        {
            chance: 20
        }
    },
    knockback: 
    {
        duration: 10,
        speed: 3
    }
}));

DuckASMR = function(arg0, arg1)
{
    var lifetime;
    arg0.image_xscale = 0.6 * logn(1.6, arg0.lifetime + 1);
    arg0.image_yscale = 0.6 * logn(1.6, arg0.lifetime + 1);
    arg0.image_alpha -= 0.024;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "DuckASMR", new Attack("DuckASMR", defaultConfig, 
{
    damage: 0.5,
    sprite_index: spr_SubaruASMR,
    attackTime: 120,
    playSound: [163],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    speed: 0,
    soundChannel: "asmr",
    hitCD: 45,
    duration: 35,
    projSpeed: 0,
    isSkill: true,
    lifetime: 0,
    optionType: "Skill",
    stayOnCreator: false,
    targetRandom: true,
    script: DuckASMR,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    onHitEffects: 
    {
        DuckASMRHit: {}
    }
}));
ds_map_set(attackIndex, "DemonWhisperCollision", new Attack("DemonWhisperCollision", defaultConfig, 
{
    damage: 0.5,
    image_alpha: 0,
    attackTime: 600,
    stayOnCreator: true,
    attackCount: 1,
    duration: 480,
    hitCD: 20,
    isSkill: true,
    optionType: "Skill",
    stayOnCreator: true,
    starty: 0,
    hitLimit: -1,
    drawBehind: true,
    attackDamageID: "DemonWhisper"
}));
ds_map_set(attackIndex, "GarlicPulse", new Attack("GarlicPulse", defaultConfig, 
{
    damage: 1,
    attackTime: 600,
    sprite_index: spr_ShionMagicPulse,
    image_alpha: 0.7,
    image_xscale: 1,
    image_yscale: 1,
    attackTime: 600,
    stayOnCreator: true,
    drawUnderAll: true,
    attackCount: 1,
    optionType: "Skill",
    duration: 600,
    isSkill: true,
    hitCD: 45,
    minDelay: 600,
    starty: 0,
    noMultiples: true,
    hitLimit: -1,
    transparent: true,
    drawBehind: true
}));
ds_map_set(attackIndex, "LunarRabbit", new Attack("LunarRabbit", defaultConfig, 
{
    damage: 2,
    sprite_index: spr_Explosion,
    attackTime: 0,
    image_xscale: 2,
    image_yscale: 2,
    attackCount: 1,
    hitCD: 45,
    attackDelay: 30,
    isSkill: true,
    playSound: [149],
    hitLimit: -1,
    optionType: "Skill",
    onHitEffects: 
    {
        SpecDrain: 
        {
            amount: 0.25
        }
    }
}));

function MoonSong()
{
    image_angle = 0;
    
    OnCollideWithTarget = function(arg0)
    {
        if (collides)
        {
            HitTarget(arg0);
        }
        if (creator.isEnemy != arg0.isEnemy)
        {
            var dir = point_direction(arg0.x, arg0.y, x, y);
            var dist = 1;
            arg0.x += lengthdir_x(dist, dir);
            arg0.y += lengthdir_y(dist, dir);
        }
    };
}

MoonSongMove = function(arg0, arg1)
{
    if (arg0.speed > 0.5)
    {
        arg0.speed *= 0.9;
    }
    else
    {
        arg0.speed = 0.5;
    }
};

ds_map_set(attackIndex, "MoonSong", new Attack("MoonSong", defaultConfig, 
{
    collides: true,
    damage: global.SkillData.MoonSong.damage[0],
    sprite_index: spr_MoonSong,
    image_xscale: global.SkillData.MoonSong.size[0],
    image_yscale: global.SkillData.MoonSong.size[0],
    attackTime: 600,
    attackCount: 1,
    duration: 240,
    speed: 13,
    image_alpha: 0.8,
    faceCreatorDirection: true,
    hitLimit: -1,
    hitCD: 30,
    isSkill: true,
    optionType: "Skill",
    playSound: [206],
    soundPitch: true,
    afterImageColor: 16711680,
    script: MoonSongMove,
    soundChannel: "moonsong",
    onCreate: MoonSong,
    range: 80,
    height: 64,
    levels: [
    {
        config: 
        {
            collides: true,
            damage: global.SkillData.MoonSong.damage[1],
            image_xscale: global.SkillData.MoonSong.size[1],
            height: 102,
            image_yscale: global.SkillData.MoonSong.size[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: global.SkillData.MoonSong.size[2],
            image_yscale: global.SkillData.MoonSong.size[2],
            height: 112,
            collides: true,
            damage: global.SkillData.MoonSong.damage[2]
        }
    }],
    maxLevel: 3
}));

Nuts = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.vspeed -= 2;
    }
    arg0.image_angle += 10;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "NonstopNuts", new Attack("NonstopNuts", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_RisuCashew,
    attackTime: 0,
    image_xscale: 2,
    image_yscale: 2,
    gravity: 0.1,
    speed: 6,
    attackCount: 1,
    hitCD: 45,
    attackDelay: 30,
    isSkill: true,
    script: Nuts,
    playSound: [46],
    hitLimit: 2,
    duration: 60,
    lifetime: 0,
    optionType: "Skill"
}));

Polyglot = function(arg0, arg1)
{
    var lifetime;
    arg0.image_xscale = 0.45 * logn(1.6, arg0.lifetime + 1);
    arg0.image_yscale = 0.45 * logn(1.6, arg0.lifetime + 1);
    arg0.image_alpha -= 0.024;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Polyglot", new Attack("Polyglot", defaultConfig, 
{
    damage: 2,
    sprite_index: spr_SubaruASMR,
    attackTime: 120,
    playSound: [149],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    speed: 0,
    soundChannel: "Polyglot",
    hitCD: 45,
    duration: 35,
    isSkill: true,
    projSpeed: 0,
    lifetime: 0,
    optionType: "Skill",
    stayOnCreator: false,
    targetRandom: true,
    script: Polyglot,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8
}));

Ninjutsu = function(arg0, arg1)
{
};

ds_map_set(attackIndex, "Katon", new Attack("Katon", defaultConfig, 
{
    sprite_index: spr_OllieKaton,
    damage: 0.8 * global.SkillData.Ninjutsu.damage[0],
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0.9,
    playSound: [190],
    attackTime: 300,
    hitLimit: -1,
    projSpeed: 0,
    isSkill: true,
    collides: true,
    hitCD: 5,
    lifetime: 0,
    onHitEffects: 
    {
        IceSlow: {}
    }
}));

Suiton = function(arg0, arg1)
{
    arg0.x = arg0.stayOn.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg0.stayOn.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.angle += arg0.projSpeed;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "Suiton", new Attack("Suiton", defaultConfig, 
{
    sprite_index: spr_OllieSuiton,
    damage: 0.3,
    attackTime: 360,
    image_xscale: 1.5,
    image_yscale: 1.5,
    minDelay: 300,
    hitLimit: -1,
    destroyOnHitLimit: false,
    knockback: 
    {
        speed: 4,
        duration: 4
    },
    duration: 150,
    hitCD: 30,
    angle: 0,
    radius: 70,
    isSkill: true,
    projSpeed: 9,
    afterImageColor: 16711680,
    optionType: "Skill",
    script: Suiton
}));

DotonProjectile = function(arg0, arg1)
{
    var times;
    if (arg0.randDir == -1)
    {
        arg0.randDir = irandom(359);
        arg0.image_angle = irandom(359);
        arg0.image_index = irandom(1);
    }
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
    if (arg0.times > 14)
    {
        if (arg0.times == 15)
        {
            soundPlay([295], "dotonprojectile", 3, 4);
            arg0.times = 16;
        }
        arg0.collides = true;
        arg0.speed = arg0.projSpeed;
    }
    else
    {
        if (arg0.times < 12)
        {
            var xDir = lengthdir_x(arg0.spawnSPD, arg0.randDir);
            var yDir = lengthdir_y(arg0.spawnSPD, arg0.randDir);
            arg0.x += xDir;
            arg0.y += yDir;
            arg0.spawnSPD -= 0.25;
        }
        if (arg0.target != "noTarget" && instance_exists(arg0.target))
        {
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
        }
        arg0.times++;
    }
};

ds_map_set(attackIndex, "DotonProjectile", new Attack("DotonProjectile", defaultConfig, 
{
    sprite_index: spr_OllieDoton,
    attackTime: 150,
    image_speed: 0,
    damage: 0.6,
    hitLimit: -1,
    hitCD: 60,
    image_xscale: 1.5,
    image_yscale: 1.5,
    projSpeed: 20,
    playSound: [62],
    soundChannel: "doton",
    faceCreatorDirection: true,
    duration: 60,
    targetRandom: true,
    isSkill: true,
    times: 0,
    randDir: -1,
    knockback: 
    {
        speed: 15,
        duration: 15
    },
    script: DotonProjectile,
    spawnSPD: 6,
    collides: false,
    afterImageColor: 4235519
}));

Doton = function(arg0, arg1)
{
    var lifetime;
    if ((arg0.lifetime % 5) == 0)
    {
        obj_AttackController.ExecuteAttack("DotonProjectile", arg1, 
        {
            damage: arg1.scripts.Ninjutsu.config.damageScale * arg0.damage,
            x: arg1.x,
            y: arg1.y - 16
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Doton", new Attack("Doton", defaultConfig, 
{
    damage: 0.3,
    attackTime: 360,
    image_xscale: 1.5,
    image_yscale: 1.5,
    minDelay: 300,
    collides: false,
    stayOnCreator: true,
    hitLimit: -1,
    destroyOnHitLimit: false,
    duration: 180,
    optionType: "Skill",
    script: Doton,
    lifetime: 0
}));
ds_map_set(attackIndex, "WindMagic", new Attack("WindMagic", defaultConfig, 
{
    sprite_index: spr_ReineWind,
    attackTime: 150,
    image_speed: 1,
    damage: 1,
    hitLimit: -1,
    hitCD: 60,
    image_xscale: 1.5,
    image_yscale: 1.5,
    playSound: [204],
    soundChannel: "wind",
    faceCreatorDirection: true,
    duration: 20,
    isSkill: true,
    speed: 15,
    targetRandom: false,
    script: TargettedProjectile,
    knockback: 
    {
        speed: 4,
        duration: 4
    },
    spawnSPD: 6,
    collides: true
}));

LivingWeapon = function(arg0, arg1)
{
    if (variable_struct_exists(arg1.buffs, "LivingWeapon") && arg1.buffs.LivingWeapon.config.stacks >= 10)
    {
        arg0.collides = true;
        arg0.creator = arg1;
        arg0.duration = 9999;
        arg0.damage = global.SkillData.LivingWeapon.damage[arg0.level] * (arg1.buffs.LivingWeapon.config.stacks div 10);
        arg0.image_alpha = 0.2 + ((0.1 * arg1.buffs.LivingWeapon.config.stacks) div 10);
    }
    else
    {
        arg0.duration = 1;
        arg1.scripts.LivingWeapon.config.aura = -1;
    }
};

ds_map_set(attackIndex, "LivingWeapon", new Attack("LivingWeapon", defaultConfig, 
{
    damage: 0,
    collides: false,
    attackTime: 600,
    sprite_index: spr_AnyaLivingWeapon,
    image_alpha: 0.75,
    image_xscale: 1.25,
    image_yscale: 1.25,
    attackTime: 600,
    script: LivingWeapon,
    stayOnCreator: true,
    level: 0,
    lifetime: 0,
    drawUnderAll: true,
    attackCount: 1,
    optionType: "Skill",
    isSkill: true,
    isMelee: true,
    duration: 9999,
    hitCD: 60,
    minDelay: 600,
    hitLimit: -1,
    drawBehind: true,
    noMultiples: true
}));

NoPressure = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime < 30)
    {
        arg0.image_alpha += 0.01;
    }
    if (arg0.duration < 30)
    {
        arg0.image_alpha -= 0.01;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "NoPressure", new Attack("NoPressure", defaultConfig, 
{
    damage: 0.5,
    attackTime: 600,
    sprite_index: spr_MelCookingPulse,
    image_alpha: 0,
    image_xscale: 1,
    image_yscale: 1,
    attackTime: 600,
    isSkill: true,
    script: NoPressure,
    stayOnCreator: true,
    onHitEffects: 
    {
        NoPressureHit: {}
    },
    lifetime: 0,
    drawUnderAll: true,
    attackCount: 1,
    optionType: "Skill",
    duration: 120,
    hitCD: 120,
    minDelay: 600,
    hitLimit: -1,
    drawBehind: true
}));

FallingAnvil = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.gravity = 1;
        arg0.direction = 270;
        arg0.speed = 5;
    }
    if (arg0.speed > 15)
    {
        arg0.speed = 15;
    }
    arg0.lifetime++;
    if (arg0.y > arg0.targetY)
    {
        var roll = irandom(99);
        if (roll < global.SkillData.TheBlacksmith.chance[arg0.level])
        {
            instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_holoAnvil);
            soundPlay([257], "anvil", 10, 75);
        }
        else
        {
            var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_vfx);
            vfx.sprite_index = spr_Anvil;
            vfx.duration = 60;
            vfx.image_alpha = 1;
            vfx.image_xscale = arg0.image_xscale;
            vfx.image_yscale = arg0.image_yscale;
            vfx.hspeed = -5 + irandom(10);
            vfx.vspeed = -3 - irandom(2);
            vfx.gravity = 0.15;
            vfx.alarm[1] = 30;
            vfx.alarm[2] = 1;
            vfx.rotSpeed = -5 + irandom(10);
            soundPlay([234], "anvilHit", 20, 0, true);
        }
        arg0.y = arg0.targetY;
        arg0.speed = 0;
        arg0.gravity = 0;
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "FallingAnvil", new Attack("FallingAnvil", defaultConfig, 
{
    attackTime: 75,
    damage: 3,
    faceCreatorDirection: true,
    sprite_index: spr_KaelaAnvil,
    targetY: 0,
    playSound: [263],
    destroyOnHitLimit: false,
    image_xscale: 1.5,
    image_yscale: 1.5,
    level: 0,
    image_speed: 0,
    duration: 120,
    optionType: "Skill",
    isSkill: true,
    hitLimit: -1,
    script: FallingAnvil,
    hitCD: 30,
    lifetime: 0
}));

RainCloudSet = function(arg0, arg1)
{
    arg0.emitter = part_emitter_create(global.psystem);
    part_system_depth(global.psystem, -9999);
};

RainCloud = function(arg0, arg1)
{
    var timer;
    if (arg0.timer == 0)
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
        else
        {
            randomIndex = floor(random(numTargets));
            arg0.target = ds_list_find_value(targets, randomIndex);
            arg0.timer = arg0.maxTimer;
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    else
    {
        arg0.timer--;
    }
    if (arg0.target != "noTarget" && instance_exists(arg0.target) && arg0.timer > 120)
    {
        if (arg0.x != arg0.target.x)
        {
            arg0.x += (arg0.target.x - arg0.x) * 0.05;
        }
        if (arg0.y != (arg0.target.y - (60 * arg0.image_xscale)))
        {
            arg0.y += (arg0.target.y - (60 * arg0.image_xscale) - arg0.y) * 0.05;
        }
        arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y - (60 * arg0.image_xscale));
    }
    else
    {
        arg0.target = "noTarget";
    }
    if (arg0.timer == 120)
    {
        arg0.collides = true;
        arg0.target = "noTarget";
        soundPlay([214], "rain", 60, 10);
        part_emitter_region(global.psystem, arg0.emitter, arg0.x - (25 * arg0.image_xscale), arg0.x + (25 * arg0.image_xscale), arg0.y - (30 * arg0.image_yscale), arg0.y + (10 * arg0.image_yscale), 0, 0);
        part_emitter_stream(global.psystem, arg0.emitter, global.partType22, 3);
    }
    else if (arg0.timer == 10)
    {
        arg0.collides = false;
        part_emitter_stream(global.psystem, arg0.emitter, global.partType22, 0);
    }
    arg0.damage = global.SkillData.RainCloud.damage[arg1.scripts.RainCloud.config.level];
    arg0.duration = 9999;
};

ds_map_set(attackIndex, "RainCloud", new Attack("RainCloud", defaultConfig, 
{
    attackTime: 75,
    damage: 1,
    collides: false,
    sprite_index: spr_KoboRaincloud,
    targetY: 0,
    playSound: [263],
    destroyOnHitLimit: false,
    image_xscale: 1.5,
    image_yscale: 1.5,
    level: 0,
    range: 300,
    duration: 9999,
    isSkill: true,
    optionType: "Skill",
    hitLimit: -1,
    target: "noTarget",
    script: RainCloud,
    emitter: -1,
    onCreate: RainCloudSet,
    hitCD: 20,
    lifetime: 0,
    timer: 0,
    maxTimer: 180
}));

Tantrum = function(arg0, arg1)
{
    var lifetime;
    arg0.image_xscale = 0.4 * logn(1.6, arg0.lifetime + 1);
    arg0.image_yscale = 0.4 * logn(1.6, arg0.lifetime + 1);
    arg0.image_alpha -= 0.024;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Tantrum", new Attack("Tantrum", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_SubaruASMR,
    attackTime: 120,
    playSound: [113],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    speed: 0,
    soundChannel: "tantrum",
    hitCD: 45,
    isSkill: true,
    duration: 35,
    projSpeed: 0,
    lifetime: 0,
    optionType: "Skill",
    stayOnCreator: false,
    targetRandom: true,
    script: Tantrum,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8
}));
