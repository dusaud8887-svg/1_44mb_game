ds_map_set(Mobs, "Matsurisu", new Mob("Matsurisu", 
{
    HP: 12,
    ATK: 3,
    SPD: 0.7,
    expvalue: 6,
    sprite_index: spr_Matsurisu,
    levels: [
    {
        HP: 150,
        ATK: 8,
        SPD: 0.9,
        sprite_index: spr_Matsurisu2,
        expvalue: 8
    }, 
    {
        HP: 275,
        ATK: 10,
        SPD: 0.9,
        sprite_index: spr_Matsurisu2,
        expvalue: 8
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        HP: 50,
        ATK: 9,
        SPD: 1.1,
        sprite_index: spr_Matsurisu3,
        expvalue: 4
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
ds_map_set(Mobs, "MatsurisuDasher", new Mob("MatsurisuDasher", 
{
    HP: 150,
    ATK: 10,
    SPD: 20,
    expvalue: 5,
    sprite_index: spr_Matsurisu,
    ignoreWalls: true,
    levels: [
    {
        HP: 1000,
        knockbackImmune: true,
        ATK: 12,
        SPD: 25,
        expvalue: 3,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 60
                }
            }
        }
    }],
    maxLevel: 2,
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
}));
ds_map_set(Mobs, "MatsurisuMiniBoss", new Mob("MatsurisuMiniBoss", 
{
    HP: 1000,
    ATK: 10,
    SPD: 0.8,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Matsurisu,
    expvalue: 500,
    miniboss: true,
    maxLevel: 2,
    lifeTime: -1,
    tangible: false,
    levels: [
    {
        HP: 4500,
        ATK: 18,
        SPD: 1.2,
        image_xscale: 3,
        image_yscale: 3,
        sprite_index: spr_Matsurisu3,
        expvalue: 1000,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }]
}));
ds_map_set(Mobs, "Haaton", new Mob("Haaton", 
{
    HP: 45,
    ATK: 4,
    SPD: 0.7,
    expvalue: 6,
    sprite_index: spr_Haaton,
    mask_index: spr_Haaton_mask,
    levels: [
    {
        sprite_index: spr_Haaton2,
        HP: 200,
        ATK: 9,
        SPD: 0.8,
        expvalue: 7
    }, 
    {
        sprite_index: spr_Haaton2,
        HP: 325,
        ATK: 9,
        SPD: 0.8,
        expvalue: 8
    }, 
    {
        sprite_index: spr_Haaton2,
        HP: 3000,
        ATK: 18,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 0.4,
        expvalue: 20
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        sprite_index: spr_Haaton2,
        HP: 165,
        ATK: 10,
        SPD: 1.2,
        expvalue: 5
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
    maxLevel: 7
}));
ds_map_set(Mobs, "HaatonMiniBoss", new Mob("HaatonMiniBoss", 
{
    HP: 4000,
    ATK: 12,
    SPD: 1,
    image_xscale: 5,
    image_yscale: 5,
    sprite_index: spr_Haaton2,
    mask_index: spr_Haaton_mask,
    expvalue: 700,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "HaatonWall", new Mob("HaatonWall", 
{
    HP: 50,
    ATK: 6,
    SPD: 0.25,
    expvalue: 4,
    sprite_index: spr_HaatonWall,
    mask_index: spr_Haaton_mask,
    levels: [
    {
        HP: 300,
        ATK: 10,
        SPD: 0.8,
        expvalue: 9
    }],
    maxLevel: 2
}));
ds_map_set(Mobs, "Kapumin", new Mob("Kapumin", 
{
    HP: 90,
    ATK: 8,
    SPD: 0.8,
    expvalue: 7,
    sprite_index: spr_Kapumin,
    mask_index: spr_Kapumin_mask,
    levels: [
    {
        HP: 60,
        ATK: 5,
        SPD: 0.5,
        expvalue: 5
    }, 
    {
        HP: 150,
        ATK: 10,
        SPD: 0.9,
        expvalue: 6
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        HP: 400,
        ATK: 12,
        SPD: 1.3,
        expvalue: 6
    }, 
    {
        HP: 350,
        ATK: 12,
        SPD: 0.5,
        expvalue: 2
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
    maxLevel: 7
}));
ds_map_set(Mobs, "ObakeMiniBoss", new Mob("ObakeMiniBoss", 
{
    HP: 6000,
    ATK: 14,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Obakechan,
    mask_index: spr_Obakechan_mask,
    expvalue: 1400,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "ObakeMiniBossH", new Mob("ObakeMiniBoss", 
{
    HP: 7500,
    ATK: 20,
    SPD: 1.3,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Obakechan,
    mask_index: spr_Obakechan_mask,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "KapuminHorde", new Mob("KapuminHorde", 
{
    HP: 40,
    ATK: 3,
    SPD: 2,
    lockFacing: false,
    sprite_index: spr_Kapumin,
    mask_index: spr_Kapumin_mask,
    expvalue: 5,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 100,
        ATK: 4,
        SPD: 2,
        expvalue: 6
    }, 
    {
        HP: 200,
        ATK: 8,
        SPD: 2.5,
        expvalue: 3,
        knockbackImmune: true
    }],
    maxLevel: 3,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "KapuminDasher", new Mob("KapuminDasher", 
{
    HP: 2000,
    ATK: 20,
    SPD: 25,
    expvalue: 7,
    sprite_index: spr_Kapumin,
    mask_index: spr_Kapumin_mask,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
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
}));
ds_map_set(Mobs, "Oruyanke", new Mob("Oruyanke", 
{
    HP: 80,
    ATK: 4,
    SPD: 0.5,
    expvalue: 7,
    bomber: true,
    sprite_index: spr_Oruyanke,
    mask_index: spr_Oruyanke_mask,
    levels: [
    {
        HP: 200,
        ATK: 6,
        SPD: 0.6,
        expvalue: 8
    }, 
    {
        HP: 500,
        ATK: 8,
        SPD: 0.6,
        expvalue: 8
    }, 
    {
        HP: 2000,
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
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 90,
                    radius: 80
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
                warnTime: 140,
                radius: 90
            }
        }
    }
}));
ds_map_set(Mobs, "Rosetai", new Mob("Rosetai", 
{
    HP: 140,
    ATK: 9,
    SPD: 0.8,
    expvalue: 7,
    sprite_index: spr_Rosetai,
    mask_index: spr_Rosetai_mask,
    levels: [
    {
        HP: 250,
        ATK: 13,
        SPD: 0.8,
        expvalue: 8,
        sprite_index: spr_Rosetai2
    }, 
    {
        HP: 400,
        ATK: 10,
        SPD: 0.2,
        expvalue: 8,
        sprite_index: spr_Rosetai2
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
        sprite_index: spr_Rosetai2,
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
    }, 
    {
        HP: 500,
        ATK: 14,
        SPD: 1.2,
        expvalue: 7,
        sprite_index: spr_Rosetai3,
        mask_index: spr_Rosetai_mask
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
ds_map_set(Mobs, "RosetaiCharger", new Mob("RosetaiCharger", 
{
    HP: 1000,
    ATK: 16,
    SPD: 1,
    canSpecial: true,
    expvalue: 9,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_Rosetai4,
    mask_index: spr_Rosetai_mask,
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
                dashSprite: 623,
                dashSPD: 22,
                stomp: false
            }
        }
    }
}));
ds_map_set(Mobs, "RosetaiMiniBoss", new Mob("RosetaiMiniBoss", 
{
    HP: 7500,
    ATK: 13,
    SPD: 1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Rosetai3,
    expvalue: 1700,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "HealerOtaku", new Mob("HealerOtaku", 
{
    HP: 750,
    ATK: 3,
    SPD: 1,
    expvalue: 10,
    tangible: false,
    lifeTime: -1,
    ignoreThis: true,
    sprite_index: spr_HealerOtaku,
    mask_index: spr_Staff_mask,
    levels: [
    {
        HP: 1500,
        ATK: 5,
        SPD: 1.2,
        expvalue: 10
    }, 
    {
        HP: 2500,
        ATK: 8,
        SPD: 1.4,
        expvalue: 15
    }, 
    {
        HP: 5000,
        ATK: 25,
        SPD: 1.7,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            healEnemies: obj_MobManager.behaviours.healEnemies
        }
    }],
    maxLevel: 4,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        healEnemies: obj_MobManager.behaviours.healEnemies,
        followRandomEnemies: obj_MobManager.behaviours.followRandomEnemies
    }
}));
ds_map_set(Mobs, "Shubangelion", new Mob("Shubangelion", 
{
    HP: 24000,
    ATK: 22,
    SPD: 1.1,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Shubangelion_walk,
    mask_index: spr_Shubangelion_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    tangible: false,
    attackTime: 180,
    hitboxHeight: 50,
    giantShadow: false,
    canSpecial: true,
    knockbackImmune: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        groundPunch: obj_MobManager.behaviours.groundPunch,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 2,
    levels: [
    {
        HP: 35000,
        ATK: 30,
        SPD: 1.2
    }]
}));
ds_map_set(Mobs, "Subatomo", new Mob("Subatomo", 
{
    HP: 200,
    ATK: 12,
    SPD: 0.9,
    expvalue: 8,
    sprite_index: spr_Subatomo,
    mask_index: spr_Subatomo_mask,
    levels: [
    {
        HP: 1300,
        ATK: 15,
        SPD: 1,
        sprite_index: spr_Subatomo2,
        expvalue: 13
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        HP: 750,
        ATK: 14,
        SPD: 1.4,
        sprite_index: spr_Subatomo2,
        expvalue: 7
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
    maxLevel: 5
}));
ds_map_set(Mobs, "SubatomoHorde", new Mob("SubatomoHorde", 
{
    HP: 150,
    ATK: 5,
    SPD: 2,
    lockFacing: false,
    sprite_index: spr_Subatomo,
    mask_index: spr_Subatomo_mask,
    expvalue: 5,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    maxLevel: 1,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "Chocomate", new Mob("Chocomate", 
{
    HP: 350,
    ATK: 14,
    SPD: 1,
    expvalue: 9,
    sprite_index: spr_Chocomate,
    mask_index: spr_Chocomate_mask,
    levels: [
    {
        HP: 1500,
        ATK: 15,
        SPD: 1,
        sprite_index: spr_Chocomate,
        expvalue: 14
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        HP: 800,
        ATK: 15,
        SPD: 1.2,
        sprite_index: spr_Chocomate,
        expvalue: 8
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
    maxLevel: 5
}));
ds_map_set(Mobs, "ChocomateHorde", new Mob("ChocomateHorde", 
{
    HP: 300,
    ATK: 6,
    SPD: 3,
    lockFacing: false,
    sprite_index: spr_Chocomate,
    mask_index: spr_Chocomate_mask,
    expvalue: 3,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [{}],
    maxLevel: 1,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "ChocomateDasher", new Mob("ChocomateDasher", 
{
    HP: 1000,
    ATK: 15,
    SPD: 25,
    expvalue: 7,
    sprite_index: spr_Chocomate,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 30,
                warnTime: 70
            }
        }
    }
}));
ds_map_set(Mobs, "ChocomateMiniBoss", new Mob("ChocomateMiniBoss", 
{
    HP: 7000,
    ATK: 18,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Chocolat,
    mask_index: spr_Chocolat_mask,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 2,
    lifeTime: -1,
    tangible: false,
    levels: [
    {
        HP: 12000,
        ATK: 24,
        SPD: 1.35,
        image_xscale: 3,
        image_yscale: 3,
        sprite_index: spr_Chocolat,
        mask_index: spr_Chocolat_mask,
        expvalue: 2000,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }]
}));
ds_map_set(Mobs, "Shiokko", new Mob("Shiokko", 
{
    HP: 750,
    ATK: 14,
    SPD: 0.9,
    expvalue: 11,
    shooter: true,
    sprite_index: spr_Shiokko,
    levels: [
    {
        HP: 1000,
        ATK: 17,
        SPD: 0.4,
        sprite_index: spr_Shiokko2,
        expvalue: 15,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 750,
        ATK: 16,
        SPD: 1.3,
        sprite_index: spr_Shiokko2,
        expvalue: 8
    }, 
    {
        HP: 6000,
        ATK: 20,
        SPD: 0.1,
        lifeTime: 600,
        sprite_index: spr_Shiokko2,
        expvalue: 4,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
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
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 6
}));
ds_map_set(Mobs, "AquaCrew", new Mob("AquaCrew", 
{
    HP: 900,
    ATK: 10,
    SPD: 1,
    expvalue: 15,
    sprite_index: [1321, 52],
    levels: [
    {
        HP: 1600,
        ATK: 16,
        SPD: 1.1,
        expvalue: 16
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        HP: 900,
        ATK: 17,
        SPD: 1.4,
        expvalue: 9
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
    maxLevel: 5
}));
ds_map_set(Mobs, "AquaCrewHorde", new Mob("AquaCrewHorde", 
{
    HP: 400,
    ATK: 8,
    SPD: 2,
    lockFacing: false,
    sprite_index: [1321, 52],
    expvalue: 7,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    maxLevel: 1,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "AquaCrewMiniBoss", new Mob("AquaCrewMiniBoss", 
{
    HP: 9000,
    ATK: 22,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_AquaCrewA,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "ShiokkoMiniBoss", new Mob("ShiokkoMiniBoss", 
{
    HP: 9000,
    ATK: 22,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Shiokko,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 2,
    lifeTime: -1,
    tangible: false,
    levels: [
    {
        HP: 18000,
        ATK: 27,
        SPD: 1,
        image_xscale: 3,
        image_yscale: 3,
        sprite_index: spr_Shiokko2,
        expvalue: 2000,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }]
}));
ds_map_set(Mobs, "Nakirigumi", new Mob("Nakirigumi", 
{
    HP: 1300,
    ATK: 16,
    SPD: 0.9,
    expvalue: 13,
    sprite_index: spr_Nakirigumi,
    mask_index: spr_Nakirigumi_mask,
    levels: [
    {
        HP: 2500,
        ATK: 19,
        SPD: 1,
        expvalue: 17,
        sprite_index: spr_Nakirigumi2,
        mask_index: spr_Nakirigumi_mask
    }, 
    {
        HP: 4000,
        ATK: 25,
        SPD: 0.8,
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
    }, 
    {
        HP: 1200,
        ATK: 18,
        SPD: 1.4,
        expvalue: 10,
        sprite_index: spr_Nakirigumi2,
        mask_index: spr_Nakirigumi_mask
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
    maxLevel: 5
}));
ds_map_set(Mobs, "NakirigumiWave", new Mob("NakirigumiWave", 
{
    HP: 2000,
    ATK: 12,
    SPD: 3,
    expvalue: 10,
    sprite_index: spr_Nakirigumi2,
    mask_index: spr_Nakirigumi_mask,
    ignoreWalls: true,
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
    maxLevel: 2
}));
ds_map_set(Mobs, "NakirigumiMiniBoss", new Mob("NakirigumiMiniBoss", 
{
    HP: 19000,
    ATK: 24,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Nakirigumi2,
    mask_index: spr_Nakirigumi_mask,
    expvalue: 3000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "PoyoyoMiniBoss", new Mob("PoyoyoMiniBoss", 
{
    HP: 25000,
    ATK: 26,
    SPD: 1,
    image_xscale: 5,
    image_yscale: 5,
    sprite_index: spr_Poyoyo,
    mask_index: spr_Poyoyo_mask,
    expvalue: 3500,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    hitboxHeight: 40
}));
ds_map_set(Mobs, "BabySpiders", new Mob("BabySpiders", 
{
    HP: 1000,
    ATK: 15,
    SPD: 0.6,
    expvalue: 10,
    sprite_index: spr_BabySpiders,
    maxLevel: 1
}));

EldrichSummon = function()
{
    obj_Cam.ExecuteShake(60, 10);
    soundPlay([8], "amegroundpound", 10, 30);
};

ds_map_set(Mobs, "EldrichHaachama", new Mob("Bae3D", 
{
    HP: 55000,
    ATK: 25,
    SPD: 0.75,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_EldrichHaachama_walk,
    mask_index: spr_EldrichHaachama_mask,
    lifeTime: -1,
    expvalue: 6000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    hitboxHeight: 50,
    giantShadow: false,
    canSpecial: true,
    onCreate: EldrichSummon,
    knockbackImmune: true,
    onDeath: 
    {
        unlockWeapon: function()
        {
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "ENCurse", "WEAPON");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 4", "STAGE");
            DoAchievement("thirdboss");
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
        eldrichhaachama: obj_MobManager.behaviours.eldrichhaachama,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "EldrichHaachamaH", new Mob("Bae3D", 
{
    HP: 35000,
    ATK: 25,
    SPD: 0.75,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_EldrichHaachama_walk,
    mask_index: spr_EldrichHaachama_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    hitboxHeight: 50,
    giantShadow: false,
    canSpecial: true,
    onCreate: EldrichSummon,
    knockbackImmune: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        eldrichhaachama: obj_MobManager.behaviours.eldrichhaachama,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "SukonbuH", new Mob("SukonbuH", 
{
    HP: 40,
    ATK: 5,
    SPD: 0.85,
    expvalue: 6,
    sprite_index: spr_Sukonbu2,
    levels: [
    {
        HP: 400,
        ATK: 14,
        SPD: 0.9,
        sprite_index: spr_Miteiru,
        mask_index: spr_Miteiru_mask,
        expvalue: 8
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
    }, 
    {
        HP: 275,
        ATK: 11,
        SPD: 1.3,
        sprite_index: spr_Miteiru,
        mask_index: spr_Miteiru_mask,
        expvalue: 6
    }],
    maxLevel: 4
}));
ds_map_set(Mobs, "MiteiruH", new Mob("MiteiruH", 
{
    HP: 2000,
    ATK: 15,
    SPD: 0.9,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Miteiru,
    mask_index: spr_Miteiru_mask,
    expvalue: 500,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "SukonbuMiniBossH", new Mob("SukonbuMiniBossH", 
{
    HP: 3000,
    ATK: 14,
    SPD: 1.1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Miteiru,
    mask_index: spr_Miteiru_mask,
    expvalue: 1000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "MiofaH", new Mob("MiofaH", 
{
    HP: 100,
    ATK: 8,
    SPD: 0.9,
    expvalue: 7,
    sprite_index: [1185, 2059],
    levels: [
    {
        HP: 600,
        ATK: 15,
        SPD: 0.8,
        sprite_index: [372, 2435],
        expvalue: 9
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "MiofaMiniBossH", new Mob("MiofaMiniBossH", 
{
    HP: 6000,
    ATK: 16,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Miofa_B_Shielded,
    expvalue: 1000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "OnigiriyaH", new Mob("OnigiriyaH", 
{
    HP: 180,
    ATK: 10,
    SPD: 1,
    expvalue: 8,
    sprite_index: spr_Onigiriya2,
    levels: [
    {
        HP: 600,
        ATK: 15,
        SPD: 1.1,
        sprite_index: spr_Onigiriya2,
        expvalue: 9
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "OnigiriyaMiniBossH", new Mob("OnigiriyaMiniBossH", 
{
    HP: 8000,
    ATK: 16,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Onigiriya2,
    expvalue: 1500,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "KoronesukiH", new Mob("KoronesukiH", 
{
    HP: 350,
    ATK: 10,
    SPD: 1,
    expvalue: 8,
    sprite_index: spr_Koronesuki2,
    mask_index: spr_Koronesuki_mask,
    levels: [
    {
        HP: 650,
        ATK: 16,
        SPD: 1,
        sprite_index: spr_Koronesuki2,
        expvalue: 10
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "KoronesukiMiniBossH", new Mob("KoronesukiMiniBossH", 
{
    HP: 8000,
    ATK: 15,
    SPD: 1.1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Koronesuki2,
    mask_index: spr_Koronesuki_mask,
    expvalue: 1000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "SSRBH2", new Mob("SSRBH2", 
{
    HP: 200,
    ATK: 5,
    SPD: 0.4,
    expvalue: 8,
    sprite_index: spr_SSRB,
    levels: [
    {
        HP: 1200,
        ATK: 15,
        SPD: 1,
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
    maxLevel: 2,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        selfDestruct: 
        {
            config: 
            {
                warnTime: 150,
                radius: 70
            }
        }
    }
}));
ds_map_set(Mobs, "FububirdH", new Mob("FububirdH", 
{
    HP: 350,
    ATK: 10,
    SPD: 4,
    expvalue: 6,
    sprite_index: spr_FubuBird,
    mask_index: spr_FubuBird_mask,
    ignoreWalls: true,
    levels: [
    {
        HP: 350,
        ATK: 14,
        SPD: 1,
        sprite_index: spr_FubuBird,
        expvalue: 8,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "FububirdHordeH", new Mob("FububirdHordeH", 
{
    HP: 200,
    ATK: 5,
    SPD: 2,
    lockFacing: false,
    sprite_index: spr_FubuBird,
    expvalue: 6,
    lifeTime: 350,
    ignoreWalls: true,
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
ds_map_set(Mobs, "FububirdDasherH", new Mob("FububirdDasherH", 
{
    HP: 800,
    ATK: 20,
    SPD: 25,
    expvalue: 5,
    sprite_index: spr_FubuBird,
    mask_index: spr_FubuBird_mask,
    ignoreWalls: true,
    tangible: false,
    knockbackImmune: true,
    levels: [
    {
        HP: 3000,
        ATK: 30,
        SPD: 25,
        sprite_index: spr_KFP2,
        expvalue: 5,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 60
                }
            }
        }
    }, 
    {
        HP: 2000,
        ATK: 20,
        SPD: 25,
        sprite_index: spr_FubuBird,
        mask_index: spr_FubuBird_mask,
        expvalue: 5,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 40
                }
            }
        }
    }, 
    {
        HP: 5500,
        ATK: 33,
        SPD: 30,
        image_xscale: 1.5,
        image_yscale: 1.5,
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
                    waitTime: 1,
                    warnTime: 40
                }
            }
        }
    }],
    maxLevel: 4,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargeStraight: 
        {
            config: 
            {
                waitTime: 1,
                warnTime: 60
            }
        }
    }
}));
ds_map_set(Mobs, "35PH", new Mob("35PH", 
{
    HP: 900,
    ATK: 17,
    SPD: 1.2,
    expvalue: 11,
    sprite_index: spr_35p2,
    mask_index: spr_35p_mask,
    levels: [
    {
        HP: 1400,
        ATK: 14,
        SPD: 1.4,
        sprite_index: spr_35p2,
        expvalue: 15
    }, 
    {
        HP: 2750,
        ATK: 27,
        SPD: 1.2,
        expvalue: 17,
        sprite_index: spr_35p2
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
    maxLevel: 4
}));
ds_map_set(Mobs, "35PDasherH", new Mob("35PDasherH", 
{
    HP: 1000,
    ATK: 20,
    SPD: 25,
    expvalue: 7,
    sprite_index: spr_35p2,
    mask_index: spr_35p_mask,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 20,
                warnTime: 70
            }
        }
    }
}));
ds_map_set(Mobs, "MikodanyeH", new Mob("MikodanyeH", 
{
    HP: 15000,
    ATK: 18,
    SPD: 0.7,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Mikodanye,
    mask_index: spr_Mikodanye_mask,
    lifeTime: -1,
    expvalue: 2000,
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
ds_map_set(Mobs, "AChanBossH", new Mob("AChanBossH", 
{
    HP: 15000,
    ATK: 20,
    SPD: 1,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_AchanBoss,
    mask_index: spr_AchanBoss,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    canSpecial: true,
    knockbackImmune: true,
    origin_x: -1,
    origin_y: -1,
    behaviours: 
    {
        aChanAttacks: obj_MobManager.behaviours.aChanAttacks,
        aChanMovement: obj_MobManager.behaviours.aChanMovement
    }
}));
ds_map_set(Mobs, "SoratomoH", new Mob("SoratomoH", 
{
    HP: 1000,
    ATK: 19,
    SPD: 1.2,
    sprite_index: spr_Soratomo2,
    mask_index: spr_Soratomo_mask,
    expvalue: 10,
    levels: [
    {
        HP: 2750,
        ATK: 27,
        SPD: 1.4,
        sprite_index: spr_Soratomo2,
        mask_index: spr_Soratomo_mask,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 18
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "SoratomoDasherH", new Mob("SoratomoDasherH", 
{
    HP: 1500,
    ATK: 18,
    SPD: 30,
    expvalue: 7,
    sprite_index: spr_Soratomo2,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 15,
                warnTime: 60
            }
        }
    }
}));
ds_map_set(Mobs, "SoratomoMiniBossH", new Mob("SoratomoMiniBossH", 
{
    HP: 13000,
    ATK: 25,
    SPD: 1.4,
    image_xscale: 6,
    image_yscale: 6,
    sprite_index: spr_Soratomo,
    mask_index: spr_Soratomo_mask,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "PioneersH", new Mob("PioneersH", 
{
    HP: 1300,
    ATK: 21,
    SPD: 1.2,
    sprite_index: spr_Pioneers,
    mask_index: spr_Pioneers_mask,
    expvalue: 11,
    levels: [
    {
        HP: 1000,
        expvalue: 8,
        SPD: 0.9
    }, 
    {
        HP: 2750,
        ATK: 27,
        SPD: 1.4,
        sprite_index: spr_Pioneers2,
        mask_index: spr_Pioneers_mask,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 18
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
    maxLevel: 4
}));
ds_map_set(Mobs, "PioneersDasherH", new Mob("PioneersDasherH", 
{
    HP: 1500,
    ATK: 25,
    SPD: 30,
    tangible: false,
    expvalue: 7,
    sprite_index: spr_Pioneers2,
    mask_index: spr_Pioneers_mask,
    ignoreWalls: true,
    levels: [],
    maxLevel: 1,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 30,
                warnTime: 80
            }
        }
    }
}));
ds_map_set(Mobs, "PioneersMiniBossH", new Mob("PioneersMiniBossH", 
{
    HP: 20000,
    ATK: 28,
    SPD: 1.25,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Pioneers2,
    mask_index: spr_Pioneers_mask,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "HoshiyomiH", new Mob("HoshiyomiH", 
{
    HP: 1700,
    ATK: 21,
    SPD: 1.3,
    sprite_index: spr_Hoshiyomi2,
    mask_index: spr_Hoshiyomi_mask,
    image_xscale: 1.5,
    image_yscale: 1.5,
    expvalue: 14,
    levels: [
    {
        HP: 2750,
        ATK: 27,
        SPD: 1.4,
        expvalue: 18
    }, 
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "HoshiyomiMiniBossH", new Mob("HoshiyomiMiniBossH", 
{
    HP: 25000,
    ATK: 30,
    SPD: 1.2,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Hoshiyomi2,
    mask_index: spr_Hoshiyomi_mask,
    expvalue: 2500,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "HoshiyomiHordeH", new Mob("HoshiyomiHordeH", 
{
    HP: 500,
    ATK: 10,
    SPD: 2.5,
    lockFacing: false,
    sprite_index: spr_Hoshiyomi2,
    mask_index: spr_Hoshiyomi_mask,
    expvalue: 5,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 100,
        ATK: 4,
        SPD: 2,
        expvalue: 6
    }],
    maxLevel: 2,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "HoshiyomiWave", new Mob("HoshiyomiWave", 
{
    HP: 2000,
    ATK: 20,
    SPD: 3,
    expvalue: 10,
    sprite_index: spr_Hoshiyomi2,
    mask_index: spr_Hoshiyomi_mask,
    ignoreWalls: true,
    levels: [
    {
        HP: 2500,
        ATK: 25,
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
    maxLevel: 2
}));
ds_map_set(Mobs, "RobosaH", new Mob("RobosaH", 
{
    HP: 2200,
    ATK: 24,
    SPD: 1.2,
    sprite_index: spr_Robosa,
    mask_index: spr_Robosa_mask,
    image_xscale: 1.5,
    image_yscale: 1.5,
    expvalue: 16,
    levels: [
    {
        HP: 3000,
        ATK: 30,
        SPD: 1.2,
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
ds_map_set(Mobs, "RobosaShooterH", new Mob("RobosaH", 
{
    HP: 1800,
    ATK: 18,
    SPD: 0.5,
    sprite_index: spr_Robosa2,
    mask_index: spr_Robosa_mask,
    shooter: true,
    image_xscale: 1.5,
    image_yscale: 1.5,
    expvalue: 16,
    levels: [
    {
        HP: 2500,
        ATK: 30,
        SPD: 0.6,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 2
}));
ds_map_set(Mobs, "RobosaMiniBossH", new Mob("RobosaMiniBossH", 
{
    HP: 30000,
    ATK: 34,
    SPD: 1.2,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Robosa2,
    mask_index: spr_Robosa_mask,
    expvalue: 3000,
    shooter: false,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "HoloStaffH", new Mob("HoloStaffH", 
{
    HP: 3500,
    ATK: 30,
    SPD: 0.5,
    expvalue: 20,
    sprite_index: [1435, 786],
    mask_index: spr_Staff_mask,
    image_xscale: 1.5,
    image_yscale: 1.5,
    levels: [
    {
        HP: 1000,
        ATK: 20,
        SPD: 0.5,
        expvalue: 10
    }, 
    {
        HP: 3000,
        ATK: 30,
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
    maxLevel: 3
}));
ds_map_set(Mobs, "NodokaBoss", new Mob("NodokaBoss", 
{
    HP: 90000,
    ATK: 30,
    SPD: 1,
    image_xscale: 1.5,
    image_yscale: 1.5,
    sprite_index: spr_NodokaBoss,
    mask_index: spr_NodokaBoss,
    lifeTime: -1,
    expvalue: 6000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    shooter: false,
    canSpecial: true,
    knockbackImmune: true,
    origin_x: -1,
    origin_y: -1,
    onDeath: 
    {
        unlockWeapon: function()
        {
            DoAchievement("2hard");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3 (HARD)", "STAGE");
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
        NodokaAttacks: obj_MobManager.behaviours.NodokaAttacks,
        aChanMovement: obj_MobManager.behaviours.aChanMovement
    }
}));
ds_map_set(Mobs, "SSRBH2", new Mob("SSRBH", 
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
                warnTime: 90,
                radius: 100
            }
        }
    }
}));
ds_map_set(Mobs, "OruyankeMiniBoss", new Mob("OruyankeMiniBoss", 
{
    HP: 10000,
    ATK: 10,
    SPD: 0,
    image_xscale: 5,
    image_yscale: 5,
    sprite_index: spr_Oruyanke,
    mask_index: spr_Oruyanke_mask,
    expvalue: 2000,
    miniboss: true,
    lifeTime: -1,
    tangible: false,
    knockbackImmune: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        endlessTimedSelfDestruct: 
        {
            config: 
            {
                warnTime: 900,
                radius: 3000
            }
        }
    }
}));
ds_map_set(Mobs, "ATKOtaku", new Mob("ATKOtaku", 
{
    HP: 4000,
    ATK: 10,
    SPD: 1,
    expvalue: 15,
    tangible: false,
    lifeTime: -1,
    ignoreThis: true,
    sprite_index: spr_DebuffOtakuA,
    mask_index: spr_Staff_mask,
    levels: [
    {
        HP: 5000,
        ATK: 20,
        SPD: 1.2,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            debuffATK: obj_MobManager.behaviours.healEnemies
        }
    }],
    maxLevel: 2,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        debuffATK: obj_MobManager.behaviours.debuffATK,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "SPDOtaku", new Mob("SPDOtaku", 
{
    HP: 4000,
    ATK: 10,
    SPD: 1.2,
    expvalue: 15,
    tangible: false,
    lifeTime: -1,
    ignoreThis: true,
    sprite_index: spr_DebuffOtakuB,
    mask_index: spr_Staff_mask,
    levels: [
    {
        HP: 5000,
        ATK: 20,
        SPD: 1.4,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            debuffSPD: obj_MobManager.behaviours.healEnemies
        }
    }],
    maxLevel: 2,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        debuffSPD: obj_MobManager.behaviours.debuffATK,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "SSRBH3", new Mob("SSRBH3", 
{
    HP: 20000,
    ATK: 10,
    SPD: 0,
    expvalue: 5,
    ignoreWalls: true,
    image_xscale: 3,
    image_yscale: 3,
    bomber: true,
    knockbackImmune: true,
    tangible: false,
    sprite_index: spr_SSRB2,
    levels: [],
    maxLevel: 8,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        selfDestruct: 
        {
            config: 
            {
                warnTime: 450,
                radius: 130,
                immediateTrigger: true
            }
        }
    }
}));
ds_map_set(Mobs, "SSRBH4", new Mob("SSRBH4", 
{
    HP: 1000,
    ATK: 10,
    SPD: 0,
    expvalue: 5,
    ignoreWalls: true,
    image_xscale: 3,
    image_yscale: 3,
    tangible: false,
    bomber: true,
    sprite_index: spr_SSRB,
    knockbackImmune: true,
    levels: [],
    maxLevel: 8,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer,
        selfDestruct: 
        {
            config: 
            {
                warnTime: 450,
                radius: 130,
                immediateTrigger: true
            }
        }
    }
}));
