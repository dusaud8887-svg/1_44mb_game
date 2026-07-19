function Mob(arg0, arg1 = {}, arg2 = 
{
    HP: 15,
    HPregen: 0,
    SPD: 1,
    crit: 0,
    haste: 0,
    DB: 0,
    DR: 1,
    attackCount: 0,
    hitLimit: 0,
    expvalue: 5,
    ATK: 2,
    hitCDTimer: 0,
    hitCD: 10,
    miniboss: false,
    isBoss: false,
    mask_index: spr_ShrimpMask,
    BonusDamageTaken: 0,
    CritVuln: 0,
    lockFacing: true,
    canSpecial: false,
    upsideDown: false,
    scaledStats: false,
    knockbackImmune: false,
    hitboxHeight: 15,
    ignoreHalu: false,
    ignorePoltato: false,
    achievementMap: false,
    height: 32,
    width: 32,
    level: 1,
    levels: [{}, {}, {}],
    maxLevel: 3,
    ignoreLimit: false,
    isBoss: false,
    isEnemy: true,
    tangible: true,
    lifeTime: 3600,
    hitCDTimer: 0,
    haluBuffed: false,
    shooter: false,
    noDeathSound: false,
    bomber: false,
    ignoreThis: false,
    poltatoNerfed: false,
    hitCD: 15,
    expvalue: 3,
    enhancements: 0,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}) constructor
{
    config = {};
    variable_struct_copy(arg2, config);
    variable_struct_copy(arg1, config);
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
    if (config.achievementMap != false)
    {
        keys = variable_struct_get_names(config.achievementMap);
        for (var i = 0; i < array_length(keys); i++)
        {
            if (ds_map_find_value(global.achievementsMap, array_get(keys, i)).unlocked)
            {
                variable_struct_remove(config.achievementMap, keys[i]);
            }
            else
            {
                variable_struct_set(obj_MobManager.mobAchievementCounters, keys[i], variable_struct_get(config.achievementMap, keys[i]));
            }
        }
    }
    id = arg0;
}

if (variable_global_exists("Mobs") && ds_exists(global.Mobs, ds_type_map))
{
    ds_map_destroy(global.Mobs);
    global.Mobs = -1;
}
Mobs = ds_map_create();
global.Mobs = Mobs;
ds_map_set(Mobs, "TestMob", new Mob("TestMob", 
{
    ATK: 1,
    HP: 25,
    SPD: 1,
    image_xscale: 2,
    image_yscale: 2,
    tangible: false,
    sprite_index: testEnemy,
    ignoreThis: true
}));
ds_map_set(Mobs, "Shrimp", new Mob("Shrimp", 
{
    HP: 8,
    ATK: 2,
    SPD: 0.35,
    expvalue: 6,
    sprite_index: spr_Shrimp,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    levels: [
    {
        HP: 125,
        ATK: 5,
        SPD: 0.6,
        sprite_index: spr_Shrimp2,
        expvalue: 12
    }, 
    {
        HP: 25,
        ATK: 4,
        SPD: 0.8,
        sprite_index: spr_Shrimp2,
        expvalue: 7
    }, 
    {
        HP: 50,
        ATK: 25,
        SPD: 0.1,
        lifeTime: 2,
        sprite_index: spr_Shrimp2,
        expvalue: 7
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "ShrimpWall", new Mob("Shrimp", 
{
    HP: 500,
    ATK: 5,
    SPD: 0.05,
    sprite_index: spr_Shrimp,
    tangible: false,
    expvalue: 10,
    lifeTime: 1500
}));
ds_map_set(Mobs, "ShrimpMiniBoss", new Mob("ShrimpMiniBoss", 
{
    HP: 600,
    ATK: 6,
    SPD: 0.5,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Shrimp,
    expvalue: 200,
    miniboss: true,
    levels: [
    {
        HP: 2500,
        ATK: 10,
        SPD: 0.9,
        expvalue: 1000,
        sprite_index: spr_Shrimp2
    }, 
    {
        HP: 1500,
        ATK: 10,
        SPD: 0.9,
        expvalue: 500,
        sprite_index: spr_Shrimp2
    }],
    maxLevel: 3,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Deadbeat", new Mob("Deadbeat", 
{
    HP: 40,
    ATK: 4,
    SPD: 0.4,
    sprite_index: spr_Deadbeat,
    expvalue: 7,
    levels: [
    {
        HP: 150,
        ATK: 7,
        SPD: 0.6,
        sprite_index: spr_Deadbeat2,
        expvalue: 9
    }, 
    {
        HP: 380,
        ATK: 5,
        SPD: 0.65,
        sprite_index: spr_DeadbeatShielded,
        expvalue: 8,
        lifeTime: 500,
        knockbackImmune: true
    }, 
    {
        HP: 80,
        ATK: 7,
        SPD: 1,
        sprite_index: spr_Deadbeat3,
        expvalue: 8
    }, 
    {
        HP: 1500,
        ATK: 20,
        SPD: 0.1,
        sprite_index: spr_Deadbeat3,
        expvalue: 4
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "DeadBeatMiniBoss", new Mob("DeadBeatMiniBoss", 
{
    HP: 3500,
    ATK: 11,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Deadbeat2,
    expvalue: 1500,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Takodachi", new Mob("Takodachi", 
{
    HP: 80,
    ATK: 4,
    SPD: 0.4,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_takodachi,
    mask_index: spr_takodachi_mask,
    expvalue: 8,
    levels: [
    {
        HP: 220,
        ATK: 8,
        SPD: 0.65,
        sprite_index: spr_Takodachi2,
        expvalue: 9
    }, 
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        sprite_index: spr_Takodachi2,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 240,
        ATK: 9,
        SPD: 0.9,
        sprite_index: spr_Takodachi2,
        expvalue: 8
    }, 
    {
        sprite_index: spr_Takodachi2,
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        sprite_index: spr_takodachi,
        HP: 1900,
        ATK: 24,
        SPD: 1.4,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 12
    }, 
    {
        sprite_index: spr_Takodachi2,
        HP: 3000,
        ATK: 25,
        SPD: 1.4,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 15
    }, 
    {
        sprite_index: spr_TakodachiArmored,
        HP: 3000,
        ATK: 25,
        SPD: 0,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 15,
        lifeTime: 420,
        invincible: true,
        invincibilityTimer: 9999,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackSlow,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 5500,
        ATK: 33,
        SPD: 1.1,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 9
}));
ds_map_set(Mobs, "TakodachiMiniBoss", new Mob("TakodachiMiniBoss", 
{
    HP: 1800,
    ATK: 10,
    SPD: 0.75,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_takodachi,
    mask_index: spr_takodachi_mask,
    expvalue: 600,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    maxLevel: 2,
    levels: [
    {
        HP: 48000,
        ATK: 30,
        SPD: 1.3,
        image_xscale: 4,
        image_yscale: 4,
        sprite_index: spr_Takodachi2,
        mask_index: spr_takodachi_mask,
        expvalue: 2000,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }]
}));
ds_map_set(Mobs, "KFP", new Mob("KFP", 
{
    HP: 20,
    ATK: 2,
    SPD: 1,
    sprite_index: spr_KFP,
    expvalue: 3,
    levels: [
    {
        HP: 50,
        ATK: 4,
        SPD: 1.15,
        sprite_index: spr_KFP2,
        expvalue: 7
    }, 
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        sprite_index: spr_KFP2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        sprite_index: spr_KFP2,
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 1900,
        ATK: 20,
        SPD: 1.5,
        sprite_index: spr_KFP2,
        expvalue: 13
    }, 
    {
        HP: 5500,
        ATK: 33,
        SPD: 1.1,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 6
}));
ds_map_set(Mobs, "KFPMiniBoss", new Mob("KFPMiniBoss", 
{
    HP: 2000,
    ATK: 8,
    SPD: 1.2,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_KFP2,
    expvalue: 650,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    maxLevel: 2,
    levels: [
    {
        HP: 60000,
        ATK: 30,
        SPD: 1.4,
        image_xscale: 4,
        image_yscale: 4,
        sprite_index: spr_KFP2,
        expvalue: 2000,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }]
}));
ds_map_set(Mobs, "KFPHorde", new Mob("KFPHorde", 
{
    HP: 25,
    ATK: 1,
    SPD: 1.65,
    lockFacing: false,
    sprite_index: spr_KFP,
    lifeTime: 350,
    expvalue: 2,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 100,
        ATK: 2,
        SPD: 2,
        sprite_index: spr_KFP2,
        expvalue: 5
    }, 
    {
        HP: 5000,
        ATK: 10,
        SPD: 3,
        sprite_index: spr_KFP2,
        expvalue: 5
    }],
    maxLevel: 3,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "BigBubba", new Mob("BigBubba", 
{
    HP: 180,
    ATK: 7,
    SPD: 0.8,
    sprite_index: spr_Investigaters,
    mask_index: spr_Investigaters_mask,
    expvalue: 9,
    levels: [
    {
        HP: 1000,
        ATK: 12,
        SPD: 0.8,
        sprite_index: spr_BubbaE,
        mask_index: spr_BubbaMask,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 20
    }, 
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        sprite_index: spr_BubbaE,
        mask_index: spr_BubbaMask,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 350,
        ATK: 11,
        SPD: 0.9,
        sprite_index: spr_Investigaters2,
        mask_index: spr_Investigaters_mask,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 9
    }, 
    {
        HP: 750,
        ATK: 16,
        SPD: 1,
        sprite_index: spr_BubbaE,
        mask_index: spr_BubbaMask,
        expvalue: 11
    }, 
    {
        sprite_index: spr_Investigaters2,
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 2300,
        ATK: 26,
        SPD: 1.4,
        sprite_index: spr_Investigaters2,
        mask_index: spr_Investigaters_mask,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 14
    }, 
    {
        HP: 5500,
        ATK: 33,
        SPD: 1.1,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 8
}));
ds_map_set(Mobs, "BubbaCharger", new Mob("BubbaCharger", 
{
    HP: 3500,
    ATK: 25,
    SPD: 1.2,
    expvalue: 15,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_BubbaE,
    mask_index: spr_BubbaMask,
    canSpecial: true,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        homingDash: 
        {
            config: 
            {
                dashSprite: 2349,
                dashSPD: 25,
                stomp: true
            }
        }
    }
}));
ds_map_set(Mobs, "BubbaChargerMiniBoss", new Mob("BubbaChargerMiniBoss", 
{
    HP: 80000,
    ATK: 34,
    SPD: 1.4,
    expvalue: 2000,
    canSpecial: true,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_BubbaE2,
    mask_index: spr_BubbaMask,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    hitboxHeight: 40,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        homingDash: 
        {
            config: 
            {
                dashSprite: 637,
                dashSPD: 25,
                stomp: true
            }
        }
    }
}));
ds_map_set(Mobs, "AngelFairy", new Mob("AngelFairy", 
{
    HP: 30,
    ATK: 6,
    SPD: 0.7,
    sprite_index: spr_AngelFairy,
    mask_index: spr_bloomgloom_mask,
    expvalue: 12,
    levels: [
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "DevilFairy", new Mob("DevilFairy", 
{
    HP: 30,
    ATK: 6,
    SPD: 0.7,
    sprite_index: spr_DevilFairy,
    mask_index: spr_bloomgloom_mask,
    expvalue: 12,
    levels: [
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "Fubura", new Mob("Fubura", 
{
    HP: 8000,
    ATK: 15,
    SPD: 0.8,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_fubuzilla,
    mask_index: spr_fubuzilla_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    hitboxHeight: 50,
    attackTime: 180,
    tangible: false,
    canSpecial: true,
    knockbackImmune: true,
    onDeath: 
    {
        unlockWeapon: function()
        {
            DoAchievement("midboss");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "HoloLaser", "WEAPON");
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        fireLaser: obj_MobManager.behaviours.fireLaser,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Rats", new Mob("Rats", 
{
    HP: 100,
    ATK: 5,
    SPD: 1.1,
    sprite_index: spr_Rats,
    mask_index: spr_RatsMask,
    expvalue: 8,
    levels: [
    {
        expvalue: 5,
        SPD: 1
    }, 
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 300,
        ATK: 12,
        SPD: 1.2,
        expvalue: 9
    }, 
    {
        HP: 500,
        ATK: 16,
        SPD: 20,
        lifeTime: 420,
        expvalue: 9,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 60
                }
            }
        }
    }, 
    {
        HP: 600,
        ATK: 15,
        SPD: 1,
        expvalue: 10
    }, 
    {
        HP: 2500,
        ATK: 20,
        SPD: 25,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 60
                }
            }
        }
    }],
    maxLevel: 7
}));
ds_map_set(Mobs, "RatHorde", new Mob("RatHorde", 
{
    HP: 70,
    ATK: 2,
    SPD: 1.7,
    sprite_index: spr_Rats,
    lockFacing: false,
    expvalue: 5,
    lifeTime: 350,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 150,
        ATK: 8,
        SPD: 2
    }],
    maxLevel: 2,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "Kromies", new Mob("Kromies", 
{
    HP: 350,
    ATK: 9,
    SPD: 0.8,
    sprite_index: [1058, 1190],
    expvalue: 10,
    levels: [
    {
        HP: 3000,
        ATK: 15,
        SPD: 0.4,
        sprite_index: spr_KromieKing,
        expvalue: 15,
        image_xscale: 2,
        image_yscale: 2
    }, 
    {
        HP: 3000,
        ATK: 9,
        SPD: 0.7,
        sprite_index: spr_KromieKing,
        image_xscale: 2,
        image_yscale: 2,
        lifeTime: 1600,
        expvalue: 25,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 1100,
        ATK: 17,
        SPD: 1,
        sprite_index: spr_KromieKing,
        expvalue: 12,
        image_xscale: 1.5,
        image_yscale: 1.5
    }, 
    {
        HP: 3000,
        ATK: 12,
        SPD: 1,
        sprite_index: spr_KromieKing,
        expvalue: 12,
        image_xscale: 1.25,
        image_yscale: 1.25
    }, 
    {
        sprite_index: spr_KromieKing,
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 6
}));
ds_map_set(Mobs, "KromieKing", new Mob("KromieKing", 
{
    HP: 5500,
    ATK: 18,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_KromieKing,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    levels: [
    {
        HP: 8000,
        ATK: 22,
        SPD: 1,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 10
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "ShrimpGang", new Mob("Shrimp", 
{
    HP: 700,
    ATK: 10,
    SPD: 0.9,
    expvalue: 12,
    sprite_index: [461, 1020],
    levels: [
    {
        HP: 3000,
        ATK: 8,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 600,
        ATK: 13,
        SPD: 0.9,
        image_xscale: 1,
        image_yscale: 1,
        sprite_index: [461, 1020],
        expvalue: 10
    }, 
    {
        sprite_index: [461, 1020],
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 1500,
        ATK: 20,
        SPD: 1.3,
        image_xscale: 1,
        image_yscale: 1,
        sprite_index: [461, 1020],
        expvalue: 10
    }],
    maxLevel: 5
}));
ds_map_set(Mobs, "DeadbeatGang", new Mob("DeadbeatGang", 
{
    HP: 750,
    ATK: 11,
    SPD: 0.7,
    expvalue: 12,
    sprite_index: [1172, 204],
    levels: [
    {
        HP: 3000,
        ATK: 9,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 900,
        ATK: 14,
        SPD: 0.9,
        image_xscale: 1,
        image_yscale: 1,
        sprite_index: [1172, 204],
        expvalue: 10
    }, 
    {
        sprite_index: [1172, 204],
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 1800,
        ATK: 21,
        SPD: 1.2,
        image_xscale: 1,
        image_yscale: 1,
        shieldHP: 500,
        sprite_index: spr_DeadbeatGangShielded,
        expvalue: 11,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            shieldRecover: 
            {
                config: 
                {
                    maxShield: 500
                }
            }
        }
    }],
    maxLevel: 5
}));
ds_map_set(Mobs, "ShrimpGangMiniBoss", new Mob("ShrimpGangMiniBoss", 
{
    HP: 7500,
    ATK: 18,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_ShrimpGangA,
    expvalue: 1200,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "DeadbeatGangMiniBoss", new Mob("DeadbeatGangMiniBoss", 
{
    HP: 7500,
    ATK: 18,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_DeadbeatGangA,
    expvalue: 1200,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    maxLevel: 2,
    levels: [
    {
        HP: 35000,
        shieldHP: 5000,
        ATK: 25,
        SPD: 1,
        mask_index: spr_DeadbeatGangShielded,
        image_xscale: 4,
        image_yscale: 4,
        expvalue: 2000,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            shieldRecover: 
            {
                config: 
                {
                    maxShield: 5000,
                    timer: 1800,
                    maxTimer: 1800
                }
            }
        }
    }]
}));
ds_map_set(Mobs, "Hoomans", new Mob("Hoomans", 
{
    HP: 750,
    ATK: 10,
    SPD: 1,
    expvalue: 11,
    image_xscale: 1.5,
    image_yscale: 1.5,
    mask_index: spr_HoomansMask,
    sprite_index: [715, 778],
    levels: [
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        mask_index: spr_HoomansMask,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 5000,
        ATK: 20,
        SPD: 25,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 60
                }
            }
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "Saplings", new Mob("Saplings", 
{
    HP: 900,
    ATK: 12,
    SPD: 0.7,
    expvalue: 11,
    sprite_index: [66, 365, 635],
    levels: [
    {
        HP: 3000,
        ATK: 14,
        SPD: 0.4,
        expvalue: 15,
        sprite_index: spr_SaplingKing,
        image_xscale: 2,
        image_yscale: 2
    }, 
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        sprite_index: spr_SaplingKing,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 2000,
        ATK: 20,
        SPD: 1.2,
        expvalue: 14,
        sprite_index: spr_SaplingKing,
        image_xscale: 1.5,
        image_yscale: 1.5
    }, 
    {
        HP: 6000,
        ATK: 20,
        SPD: 0.05,
        expvalue: 12,
        knockbackImmune: true,
        lifeTime: 600,
        tangible: false,
        sprite_index: spr_SaplingKing,
        image_xscale: 1.5,
        image_yscale: 1.5
    }, 
    {
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        sprite_index: spr_SaplingKing,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 6
}));
ds_map_set(Mobs, "SaplingMiniBoss", new Mob("SaplingMiniBoss", 
{
    HP: 11000,
    ATK: 18,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_SaplingKing,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    levels: [
    {
        HP: 20000,
        ATK: 25,
        SPD: 1.2,
        expvalue: 2000,
        sprite_index: spr_SaplingKingGolden
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "Sanalites", new Mob("Sanalites", 
{
    HP: 2000,
    ATK: 16,
    SPD: 0.6,
    sprite_index: spr_BreadDog,
    mask_index: spr_BreadDog_mask,
    image_xscale: 2,
    image_yscale: 2,
    expvalue: 14,
    levels: [
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 2300,
        ATK: 23,
        SPD: 1.1,
        expvalue: 17
    }, 
    {
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "SmollAme", new Mob("SmollAme", 
{
    HP: 25000,
    ATK: 20,
    SPD: 1.2,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_SmollAme_walk,
    mask_index: spr_SmollAme_hitbox,
    lifeTime: -1,
    expvalue: 5000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    giantShadow: false,
    canSpecial: true,
    knockbackImmune: true,
    groundPoundMake: true,
    onDeath: 
    {
        unlockWeapon: function()
        {
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "GorillasPaw", "ITEM");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "HOLO HOUSE", "STAGE");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2", "STAGE");
            DoAchievement("firstboss");
        },
        
        winGame: function()
        {
            if (global.gameMode == 0)
            {
                return obj_PlayerManager.GameWin();
            }
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        groundPound: obj_MobManager.behaviours.groundPound,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Yagoos", new Mob("Yagoos", 
{
    HP: 9000,
    ATK: 5,
    SPD: 1.2,
    sprite_index: testEnemy,
    image_xscale: 2,
    image_yscale: 2,
    expvalue: 25,
    ignoreThis: true,
    miniboss: true,
    noBox: true,
    lifeTime: 900,
    levels: [
    {
        HP: 15000,
        ATK: 10,
        SPD: 2
    }, 
    {
        ATK: 7,
        SPD: 1.35
    }],
    achievementMap: 
    {
        CEOnow: 1
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        powerScaling: obj_MobManager.behaviours.powerScaling,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 3
}));
ds_map_set(Mobs, "Sukonbu", new Mob("Sukonbu", 
{
    HP: 10,
    ATK: 3,
    SPD: 0.65,
    expvalue: 6,
    sprite_index: spr_Sukonbu,
    levels: [
    {
        HP: 230,
        ATK: 8,
        SPD: 0.8,
        sprite_index: spr_Sukonbu2,
        expvalue: 8
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "SukonbuMiniBoss", new Mob("SukonbuMiniBoss", 
{
    HP: 800,
    ATK: 8,
    SPD: 0.75,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Sukonbu,
    expvalue: 400,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Miofa", new Mob("Miofa", 
{
    HP: 40,
    ATK: 4,
    SPD: 0.7,
    expvalue: 7,
    sprite_index: [1185, 2059],
    levels: [
    {
        HP: 240,
        ATK: 8,
        SPD: 0.85,
        sprite_index: [1185, 2059],
        expvalue: 8
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "MiofaMiniBoss", new Mob("MiofaMiniBoss", 
{
    HP: 2200,
    ATK: 10,
    SPD: 0.9,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: [1185, 2059],
    expvalue: 650,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Onigiriya", new Mob("Onigiriya", 
{
    HP: 80,
    ATK: 7,
    SPD: 0.75,
    expvalue: 7,
    sprite_index: spr_Onigiriya,
    levels: [
    {
        HP: 280,
        ATK: 10,
        SPD: 0.9,
        sprite_index: spr_Onigiriya2,
        expvalue: 9
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        sprite_index: spr_Onigiriya2,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "OnigiriyaMiniBoss", new Mob("OnigiriyaMiniBoss", 
{
    HP: 3800,
    ATK: 13,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Onigiriya2,
    expvalue: 1500,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Koronesuki", new Mob("Koronesuki", 
{
    HP: 120,
    ATK: 6,
    SPD: 0.65,
    expvalue: 8,
    sprite_index: spr_Koronesuki,
    mask_index: spr_Koronesuki_mask,
    levels: [
    {
        HP: 300,
        ATK: 10,
        SPD: 0.8,
        sprite_index: spr_Koronesuki2,
        expvalue: 9
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        sprite_index: spr_Koronesuki2,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "KoronesukiMiniBoss", new Mob("KoronesukiMiniBoss", 
{
    HP: 3000,
    ATK: 10,
    SPD: 0.9,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Koronesuki,
    mask_index: spr_Koronesuki_mask,
    expvalue: 650,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "SSRB", new Mob("SSRB", 
{
    HP: 100,
    ATK: 3,
    SPD: 0.4,
    expvalue: 8,
    bomber: true,
    sprite_index: spr_SSRB,
    levels: [
    {
        HP: 350,
        ATK: 5,
        SPD: 0.7,
        expvalue: 12,
        sprite_index: spr_SSRB2
    }, 
    {
        HP: 500,
        ATK: 5,
        SPD: 0.8,
        expvalue: 15,
        sprite_index: spr_SSRB2
    }, 
    {
        HP: 1000,
        ATK: 18,
        SPD: 0.6,
        sprite_index: spr_SSRB2,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 90,
                    radius: 75
                }
            }
        }
    }],
    maxLevel: 4,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        selfDestruct: 
        {
            config: 
            {
                warnTime: 120,
                radius: 80
            }
        }
    }
}));
ds_map_set(Mobs, "Fububird", new Mob("Fububird", 
{
    HP: 90,
    ATK: 6,
    SPD: 3,
    expvalue: 8,
    sprite_index: spr_FubuBird,
    mask_index: spr_FubuBird_mask,
    ignoreWalls: true,
    levels: [
    {
        HP: 175,
        ATK: 7,
        SPD: 0.85,
        sprite_index: spr_FubuBird,
        expvalue: 8,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 200,
        ATK: 10,
        SPD: 0.5,
        sprite_index: spr_FubuBird,
        expvalue: 14
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        waveMovement: 
        {
            config: 
            {
                travelWidth: 40,
                waveSpeed: 15
            }
        }
    },
    maxLevel: 4
}));
ds_map_set(Mobs, "FububirdHorde", new Mob("FububirdHorde", 
{
    HP: 30,
    ATK: 2,
    SPD: 1.8,
    lockFacing: false,
    sprite_index: spr_FubuBird,
    expvalue: 7,
    lifeTime: 350,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 100,
        ATK: 2,
        SPD: 2,
        sprite_index: spr_KFP2,
        expvalue: 5
    }],
    maxLevel: 2,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "35P", new Mob("35P", 
{
    HP: 200,
    ATK: 8,
    SPD: 0.8,
    expvalue: 9,
    sprite_index: spr_35p,
    mask_index: spr_35p_mask,
    levels: [
    {
        HP: 1400,
        ATK: 14,
        SPD: 1.2,
        sprite_index: spr_35p2,
        expvalue: 15
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        sprite_index: [1141, 1940],
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "Mikodanye", new Mob("Mikodanye", 
{
    HP: 15000,
    ATK: 15,
    SPD: 0.7,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Mikodanye,
    mask_index: spr_Mikodanye_mask,
    lifeTime: -1,
    expvalue: 2200,
    isBoss: true,
    attackTime: 180,
    attackTime2: 120,
    tangible: false,
    canSpecial: true,
    hitboxHeight: 50,
    knockbackImmune: true,
    onDeath: {},
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        fireBreath: obj_MobManager.behaviours.fireBreath,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Soratomo", new Mob("Soratomo", 
{
    HP: 250,
    ATK: 6,
    SPD: 0.9,
    sprite_index: spr_Soratomo,
    mask_index: spr_Soratomo_mask,
    expvalue: 10,
    levels: [
    {
        HP: 1300,
        ATK: 11,
        SPD: 1,
        sprite_index: spr_Soratomo2,
        mask_index: spr_Soratomo_mask,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 15
    }, 
    {
        HP: 200,
        ATK: 5,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 14
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "SoratomoMiniBoss", new Mob("SoratomoMiniBoss", 
{
    HP: 6000,
    ATK: 15,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Soratomo,
    mask_index: spr_Soratomo_mask,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Pioneers", new Mob("Pioneers", 
{
    HP: 450,
    ATK: 9,
    SPD: 0.8,
    sprite_index: spr_Pioneers,
    mask_index: spr_Pioneers_mask,
    expvalue: 11,
    levels: [
    {
        HP: 1400,
        ATK: 10,
        SPD: 0.9,
        sprite_index: spr_Pioneers2,
        mask_index: spr_Pioneers_mask,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 15
    }, 
    {
        HP: 2500,
        ATK: 17,
        SPD: 0.6,
        sprite_index: spr_Pioneers2,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "PioneersMiniBoss", new Mob("PioneersMiniBoss", 
{
    HP: 6000,
    ATK: 15,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Pioneers,
    mask_index: spr_Pioneers_mask,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Hoshiyomi", new Mob("Hoshiyomi", 
{
    HP: 800,
    ATK: 10,
    SPD: 0.8,
    sprite_index: spr_Hoshiyomi,
    mask_index: spr_Hoshiyomi_mask,
    image_xscale: 1.5,
    image_yscale: 1.5,
    expvalue: 13,
    levels: [
    {
        HP: 1300,
        ATK: 14,
        SPD: 0.9,
        sprite_index: spr_BubbaE,
        mask_index: spr_BubbaMask,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 16
    }, 
    {
        HP: 1000,
        ATK: 15,
        SPD: 3,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            waveMovement: obj_MobManager.behaviours.waveMovement
        }
    }, 
    {
        HP: 2500,
        ATK: 17,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "Robosa", new Mob("Robosa", 
{
    HP: 1100,
    ATK: 11,
    SPD: 0.8,
    sprite_index: spr_Robosa,
    mask_index: spr_Robosa_mask,
    image_xscale: 1.5,
    image_yscale: 1.5,
    expvalue: 13,
    levels: [
    {
        HP: 2500,
        ATK: 16,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "RobosaMiniBoss", new Mob("RobosaMiniBoss", 
{
    HP: 10000,
    ATK: 18,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Robosa,
    mask_index: spr_Robosa_mask,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "SSRBMiniBoss", new Mob("SSRBMiniBoss", 
{
    HP: 15000,
    ATK: 11,
    SPD: 0.8,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_SSRB2,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    knockbackImmune: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        timedSelfDestruct: 
        {
            config: 
            {
                warnTime: 900,
                radius: 3000
            }
        }
    }
}));
ds_map_set(Mobs, "HoloStaff", new Mob("HoloStaff", 
{
    HP: 2600,
    ATK: 16,
    SPD: 0.6,
    expvalue: 18,
    sprite_index: [1435, 786],
    mask_index: spr_Staff_mask,
    image_xscale: 1.25,
    image_yscale: 1.25,
    levels: [
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.6,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "AChanBoss", new Mob("AChanBoss", 
{
    HP: 43000,
    ATK: 20,
    SPD: 1,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_AchanBoss,
    mask_index: spr_AchanBoss,
    lifeTime: -1,
    expvalue: 6000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    canSpecial: true,
    knockbackImmune: true,
    origin_x: -1,
    origin_y: -1,
    onDeath: 
    {
        unlockWeapon: function()
        {
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "CEOTears", "WEAPON");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3", "STAGE");
            DoAchievement("secondboss");
        },
        
        winGame: function()
        {
            if (global.gameMode == 0)
            {
                return obj_PlayerManager.GameWin();
            }
        }
    },
    behaviours: 
    {
        aChanAttacks: obj_MobManager.behaviours.aChanAttacks,
        aChanMovement: obj_MobManager.behaviours.aChanMovement
    }
}));
ds_map_set(Mobs, "SSRBH", new Mob("SSRBH", 
{
    HP: 80,
    ATK: 5,
    SPD: 0.8,
    expvalue: 8,
    bomber: true,
    sprite_index: spr_SSRB,
    levels: [
    {
        HP: 400,
        ATK: 4,
        SPD: 0.7,
        expvalue: 12,
        sprite_index: spr_SSRB2,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 90,
                    radius: 75
                }
            }
        }
    }, 
    {
        HP: 500,
        ATK: 5,
        SPD: 0.8,
        expvalue: 15,
        sprite_index: spr_SSRB2
    }, 
    {
        HP: 500,
        ATK: 5,
        SPD: 0.8,
        expvalue: 15,
        sprite_index: spr_SSRB2,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 120,
                    radius: 100
                }
            }
        }
    }, 
    {
        HP: 1000,
        ATK: 10,
        SPD: 0.1,
        expvalue: 10,
        sprite_index: spr_SSRB2,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 480,
                    radius: 200
                }
            }
        }
    }, 
    {
        HP: 2000,
        ATK: 8,
        SPD: 0.6,
        expvalue: 10,
        sprite_index: spr_SSRB2,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 100,
                    radius: 90
                }
            }
        }
    }, 
    {
        HP: 10000,
        ATK: 10,
        SPD: 6,
        expvalue: 10,
        image_xscale: 2,
        image_yscale: 2,
        sprite_index: spr_SSRB2,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 240,
                    radius: 250
                }
            }
        }
    }, 
    {
        HP: 2000,
        ATK: 16,
        SPD: 0.8,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        sprite_index: spr_SSRB2,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 90,
                    radius: 130
                }
            }
        }
    }],
    maxLevel: 8,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        selfDestruct: 
        {
            config: 
            {
                warnTime: 80,
                radius: 125
            }
        }
    }
}));
ds_map_set(Mobs, "KFPH", new Mob("KFPH", 
{
    HP: 250,
    ATK: 15,
    SPD: 15,
    tangible: false,
    sprite_index: spr_KFP2,
    expvalue: 5,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 30,
                warnTime: 50
            }
        }
    },
    levels: [
    {
        HP: 2500,
        ATK: 20,
        SPD: 25,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 60
                }
            }
        }
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "HoomansH", new Mob("HoomansH", 
{
    HP: 500,
    ATK: 10,
    SPD: 4,
    expvalue: 10,
    image_xscale: 1.5,
    image_yscale: 1.5,
    mask_index: spr_HoomansMask,
    sprite_index: [715, 778],
    levels: [
    {
        HP: 1600,
        ATK: 18,
        SPD: 1.1,
        expvalue: 13,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 1800,
        ATK: 20,
        SPD: 25,
        expvalue: 13,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 50
                }
            }
        }
    }],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        waveMovement: 
        {
            config: 
            {
                travelWidth: 50,
                waveSpeed: 15
            }
        }
    },
    maxLevel: 3
}));
ds_map_set(Mobs, "Bloom", new Mob("Bloom", 
{
    HP: 4000,
    ATK: 15,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_AngelFairy,
    expvalue: 400,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Gloom", new Mob("Gloom", 
{
    HP: 4000,
    ATK: 15,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_DevilFairy,
    expvalue: 400,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "GuyRys", new Mob("GuyRys", 
{
    HP: 440,
    ATK: 10,
    SPD: 1,
    expvalue: 10,
    sprite_index: spr_Guyrys,
    mask_index: spr_Guyrys_mask,
    image_xscale: 1,
    image_yscale: 1,
    levels: [
    {
        HP: 2000,
        ATK: 10,
        SPD: 0.6,
        expvalue: 5,
        lifeTime: 1200
    }, 
    {
        HP: 2500,
        ATK: 18,
        SPD: 0.9,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 15
    }, 
    {
        HP: 5000,
        ATK: 20,
        SPD: 0.9,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "RatHordeH", new Mob("RatHordeH", 
{
    HP: 150,
    ATK: 5,
    SPD: 2,
    sprite_index: spr_Rats,
    lockFacing: false,
    expvalue: 5,
    lifeTime: 350,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [{}],
    maxLevel: 1,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "InvestigatorsMiniBoss", new Mob("InvestigatorsMiniBoss", 
{
    HP: 5000,
    ATK: 17,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Investigaters,
    mask_index: spr_Investigaters_mask,
    expvalue: 1750,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Irysocrats", new Mob("Irysocrats", 
{
    HP: 500,
    ATK: 15,
    SPD: 4,
    sprite_index: [27, 1454],
    expvalue: 11,
    levels: [
    {
        HP: 3000,
        ATK: 10,
        SPD: 0.7,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        waveMovement: 
        {
            config: 
            {
                travelWidth: 50,
                waveSpeed: 15
            }
        }
    },
    maxLevel: 2
}));
ds_map_set(Mobs, "SmollAmeH", new Mob("SmollAmeH", 
{
    HP: 12000,
    ATK: 20,
    SPD: 1.2,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_SmollAme_walk,
    mask_index: spr_SmollAme_hitbox,
    lifeTime: -1,
    expvalue: 1500,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    giantShadow: false,
    canSpecial: true,
    knockbackImmune: true,
    groundPoundMake: true,
    hitboxHeight: 50,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        groundPound: obj_MobManager.behaviours.groundPound,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "FuburaH", new Mob("FuburaH", 
{
    HP: 15000,
    ATK: 22,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_fubuzilla,
    mask_index: spr_fubuzilla_mask,
    lifeTime: -1,
    expvalue: 1500,
    isBoss: true,
    attackTime: 180,
    hitboxHeight: 50,
    tangible: false,
    canSpecial: true,
    knockbackImmune: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        fireLaser2: obj_MobManager.behaviours.fireLaser2,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "HoomansMiniBoss", new Mob("HoomansMiniBoss", 
{
    HP: 18000,
    ATK: 25,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_HoomansA,
    mask_index: spr_HoomansMask,
    expvalue: 1500,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "SaplingTree", new Mob("SaplingTree", 
{
    HP: 1500,
    ATK: 20,
    SPD: 0.01,
    expvalue: 15,
    image_xscale: 1.5,
    image_yscale: 1.5,
    ignoreThis: true,
    sprite_index: spr_SaplingTree,
    mask_index: spr_SaplingTree_mask,
    attackTime: 0,
    tangible: false,
    lifeTime: 600,
    shooter: true,
    attackTime: 180,
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttack: obj_MobManager.behaviours.projectileAttack,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Yatagarasu", new Mob("Yatagarasu", 
{
    HP: 30000,
    ATK: 30,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Sanalites,
    mask_index: spr_SanalitesMask,
    expvalue: 2500,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    maxLevel: 1
}));
ds_map_set(Mobs, "Bae3D", new Mob("Bae3D", 
{
    HP: 72000,
    ATK: 27,
    SPD: 1.2,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Bae3D_walk,
    mask_index: spr_Bae3D_mask,
    lifeTime: -1,
    expvalue: 6000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    hitboxHeight: 50,
    giantShadow: false,
    canSpecial: true,
    knockbackImmune: true,
    onDeath: 
    {
        unlockWeapon: function()
        {
            DoAchievement("1hard");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2 (HARD)", "STAGE");
        },
        
        winGame: function()
        {
            if (global.gameMode == 0)
            {
                return obj_PlayerManager.GameWin();
            }
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        backflip: obj_MobManager.behaviours.backflip,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));

GoldDrop = function(arg0, arg1, arg2, arg3)
{
    var hitNumber;
    if (arg3.isDead)
    {
        return arg0;
    }
    if (arg3.invincible)
    {
        return arg0;
    }
    if (arg3.shieldHP > 0)
    {
        return arg0;
    }
    if (arg3.hitNumber > 0)
    {
        arg3.hitNumber--;
        var money = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_HoloCoinDrop);
        money.direction = floor(random(360));
        money.speed = 2 + random(3);
        money.amountVal = arg3.coinValue;
    }
    else
    {
        for (var i = 0; i < 30; i++)
        {
            var money = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_HoloCoinDrop);
            money.direction = floor(random(360));
            money.speed = 3 + random(4);
            money.image_index = irandom(sprite_get_number(spr_holoCoin));
            money.amountVal = arg3.coinValue;
        }
        DoAchievement("payday");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "PiggyBank", "ITEM");
        arg3.Die(false, false);
    }
    return arg0;
};

ds_map_set(Mobs, "GoldenYagoo", new Mob("GoldenYagoo", 
{
    HP: 9999999999,
    ATK: 0,
    SPD: 2.75,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_GoldenYagoo,
    mask_index: spr_GoldenYagoo_mask,
    lifeTime: 1500,
    expvalue: 0,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    changeDirectionTime: 5,
    ignoreThis: true,
    firstMove: true,
    newPointX: 0,
    newPointY: 0,
    hitNumber: 50,
    coinValue: 5,
    knockbackImmune: true,
    onTakeDamage: 
    {
        goldDrop: GoldDrop
    },
    behaviours: 
    {
        moveRandom: obj_MobManager.behaviours.moveRandom
    },
    achievementMap: 
    {
        payDay: 1
    }
}));

SilverDrop = function(arg0, arg1, arg2, arg3)
{
    var hitNumber;
    if (arg3.isDead)
    {
        return arg0;
    }
    if (arg3.invincible)
    {
        return arg0;
    }
    if (arg3.shieldHP > 0)
    {
        return arg0;
    }
    if (arg3.hitNumber > 0)
    {
        arg3.hitNumber--;
        var money = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_HoloCoinDrop);
        money.direction = floor(random(360));
        money.speed = 2 + random(3);
        money.amountVal = arg3.coinValue;
    }
    else
    {
        var droppedsticker = instance_create_depth(arg3.x, arg3.y - 20, arg3.depth, obj_Sticker);
        droppedsticker.RollSticker();
        soundPlay([298], "sticker", 10, 75);
        arg3.Die(false, false);
    }
    return arg0;
};

ds_map_set(Mobs, "SilverYagoo", new Mob("SilverYagoo", 
{
    HP: 9999999999,
    ATK: 0,
    SPD: 2.5,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_SilverYagoo,
    mask_index: spr_GoldenYagoo_mask,
    lifeTime: 1500,
    expvalue: 0,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    changeDirectionTime: 5,
    firstMove: true,
    newPointX: 0,
    ignoreThis: true,
    newPointY: 0,
    noBox: true,
    hitNumber: 30,
    coinValue: 3,
    knockbackImmune: true,
    onTakeDamage: 
    {
        silverDrop: SilverDrop
    },
    behaviours: 
    {
        moveRandom: obj_MobManager.behaviours.moveRandom
    },
    achievementMap: 
    {
        freeStickers: 1
    }
}));
