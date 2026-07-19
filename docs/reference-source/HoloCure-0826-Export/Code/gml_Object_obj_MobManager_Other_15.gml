ds_map_set(Mobs, "Moonafic", new Mob("Zecretary", 
{
    HP: 15,
    ATK: 4,
    SPD: 0.7,
    expvalue: 3,
    sprite_index: spr_Moonafic,
    mask_index: spr_Moonafic_mask,
    levels: [
    {
        HP: 120,
        ATK: 7,
        SPD: 0.8,
        sprite_index: spr_Moonafic2,
        expvalue: 4
    }, 
    {
        HP: 3000,
        ATK: 18,
        SPD: 0.8,
        sprite_index: spr_Moonafic2,
        expvalue: 20
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "MoonaficDasher", new Mob("MoonaficDasher", 
{
    HP: 200,
    ATK: 6,
    SPD: 20,
    expvalue: 2,
    sprite_index: spr_Moonafic,
    mask_index: spr_Moonafic_mask,
    ignoreWalls: true,
    knockbackImmune: true,
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
ds_map_set(Mobs, "MoonaficWall", new Mob("MoonaficWall", 
{
    HP: 600,
    ATK: 10,
    SPD: 0.07,
    sprite_index: spr_Moonafic2,
    mask_index: spr_Moonafic_mask,
    tangible: false,
    expvalue: 2,
    lifeTime: 1200
}));
ds_map_set(Mobs, "MoonabitoMiniBoss", new Mob("MoonabitoMiniBoss", 
{
    HP: 2000,
    ATK: 13,
    SPD: 0.9,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Moonabito,
    mask_index: spr_Moonabito_mask,
    expvalue: 600,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Risuner", new Mob("Risuner", 
{
    HP: 75,
    ATK: 5,
    SPD: 0.8,
    expvalue: 3,
    sprite_index: spr_Risuner,
    mask_index: spr_Risuner_mask,
    levels: [
    {
        HP: 150,
        ATK: 8,
        SPD: 0.9,
        sprite_index: spr_Risuner2,
        expvalue: 5
    }, 
    {
        HP: 3000,
        ATK: 18,
        SPD: 0.8,
        sprite_index: spr_Risuner2,
        expvalue: 20
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "RisunerDasher", new Mob("RisunerDasher", 
{
    HP: 200,
    ATK: 12,
    SPD: 15,
    expvalue: 2,
    knockbackImmune: true,
    sprite_index: spr_Risuner,
    mask_index: spr_Risuner_mask,
    levels: [
    {
        HP: 175,
        ATK: 15,
        SPD: 0.9,
        sprite_index: spr_Risuner2,
        expvalue: 3
    }, 
    {
        HP: 5000,
        ATK: 20,
        SPD: 25,
        sprite_index: spr_Risuner2,
        image_xscale: 2,
        image_yscale: 2,
        expvalue: 20,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 60
                }
            }
        }
    }],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargeStraight: 
        {
            config: 
            {
                waitTime: 1,
                warnTime: 90
            }
        }
    },
    maxLevel: 3
}));
ds_map_set(Mobs, "RiscotMiniBoss", new Mob("RiscotMiniBoss", 
{
    HP: 4000,
    ATK: 15,
    SPD: 1,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_Riscot,
    mask_index: spr_Riscot_mask,
    expvalue: 800,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Ioforia", new Mob("Ioforia", 
{
    HP: 100,
    ATK: 6,
    SPD: 0.8,
    expvalue: 4,
    sprite_index: spr_Ioforia,
    mask_index: spr_Ioforia_mask,
    levels: [
    {
        HP: 250,
        ATK: 9,
        SPD: 0.9,
        sprite_index: spr_Ioforia2,
        expvalue: 5
    }, 
    {
        HP: 3000,
        ATK: 18,
        SPD: 0.8,
        sprite_index: spr_Ioforia2,
        expvalue: 20
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "IoforiaMiniBoss", new Mob("IoforiaMiniBoss", 
{
    HP: 6000,
    ATK: 16,
    SPD: 1,
    image_xscale: 5,
    image_yscale: 5,
    sprite_index: spr_Ioforia2,
    mask_index: spr_Ioforia_mask,
    expvalue: 1200,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "ATKOtakuID", new Mob("ATKOtakuID", 
{
    HP: 1000,
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
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 25,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            debuffATK: obj_MobManager.behaviours.debuffATK
        }
    }, 
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
            debuffATK: obj_MobManager.behaviours.debuffATK
        }
    }],
    maxLevel: 3,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        debuffATK: obj_MobManager.behaviours.debuffATK,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "SPDOtakuID", new Mob("SPDOtakuID", 
{
    HP: 1600,
    ATK: 5,
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
        SPD: 1.2,
        image_xscale: 1,
        image_yscale: 1,
        expvalue: 25,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            debuffSPD: obj_MobManager.behaviours.debuffSPD
        }
    }, 
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
            debuffSPD: obj_MobManager.behaviours.debuffSPD
        }
    }],
    maxLevel: 3,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        debuffSPD: obj_MobManager.behaviours.debuffATK,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Zomerade", new Mob("Zomerade", 
{
    HP: 350,
    ATK: 10,
    SPD: 0.9,
    expvalue: 5,
    sprite_index: spr_Zomerade,
    mask_index: spr_Zomerade_mask,
    levels: [
    {
        HP: 700,
        ATK: 12,
        SPD: 1,
        sprite_index: spr_Zomerade2,
        expvalue: 7
    }, 
    {
        HP: 3000,
        ATK: 22,
        SPD: 1.2,
        sprite_index: spr_Zomerade2,
        expvalue: 15
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "ZomeradeHorde", new Mob("ZomeradeHorde", 
{
    HP: 300,
    ATK: 4,
    SPD: 1,
    lockFacing: false,
    sprite_index: spr_Zomerade,
    mask_index: spr_Zomerade_mask,
    expvalue: 1,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 300,
        ATK: 8,
        SPD: 1,
        expvalue: 2,
        sprite_index: spr_Zomerade2
    }, 
    {
        HP: 350,
        ATK: 5,
        SPD: 0.7,
        expvalue: 1,
        sprite_index: spr_Zomerade2,
        lifeTime: 2000,
        knockbackImmune: true
    }, 
    {
        HP: 1000,
        ATK: 8,
        SPD: 1.2,
        expvalue: 1,
        sprite_index: spr_Zomerade2,
        lifeTime: 2000,
        knockbackImmune: true
    }],
    maxLevel: 4,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "Merakyat", new Mob("Merakyat", 
{
    HP: 450,
    ATK: 10,
    SPD: 1,
    expvalue: 6,
    sprite_index: spr_Merakyat,
    mask_index: spr_Merakyat_mask,
    levels: [
    {
        HP: 900,
        ATK: 12,
        SPD: 1,
        sprite_index: spr_Merakyat2,
        expvalue: 8
    }, 
    {
        HP: 3000,
        ATK: 22,
        SPD: 1.2,
        sprite_index: spr_Merakyat2,
        expvalue: 15
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "MerakyatDasher", new Mob("MerkyatDasher", 
{
    HP: 1500,
    ATK: 10,
    SPD: 20,
    expvalue: 5,
    sprite_index: spr_Merakyat,
    mask_index: spr_Merakyat_mask,
    ignoreWalls: true,
    knockbackImmune: true,
    levels: [
    {
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }, 
    {
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }],
    maxLevel: 3,
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
ds_map_set(Mobs, "MerakyatMiniBoss", new Mob("MerakyatMiniBoss", 
{
    HP: 9000,
    ATK: 18,
    SPD: 1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Merakyat2,
    mask_index: spr_Merakyat_mask,
    expvalue: 1800,
    miniboss: true,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Melfriend", new Mob("Melfriend", 
{
    HP: 600,
    ATK: 11,
    SPD: 1,
    expvalue: 7,
    sprite_index: spr_Melfriend,
    mask_index: spr_Melfriend_mask,
    levels: [
    {
        HP: 1100,
        ATK: 13,
        SPD: 1,
        sprite_index: spr_Melfriend2,
        expvalue: 8
    }, 
    {
        HP: 3000,
        ATK: 22,
        SPD: 1.2,
        sprite_index: spr_Melfriend2,
        expvalue: 15
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "MelfriendMiniBoss", new Mob("MelfriendMiniBoss", 
{
    HP: 13000,
    ATK: 23,
    SPD: 1.1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Melfriend2,
    mask_index: spr_Melfriend_mask,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Udin", new Mob("Udin", 
{
    HP: 32000,
    ATK: 22,
    SPD: 1.1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Udin_walk,
    mask_index: spr_Udin_mask,
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
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        projectileAttackBoss2: obj_MobManager.behaviours.projectileAttackBoss,
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        homingDash: 
        {
            config: 
            {
                dashSprite: 1361,
                dashSPD: 15,
                stomp: true
            }
        },
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Koboker", new Mob("Koboker", 
{
    HP: 1200,
    ATK: 12,
    SPD: 0.8,
    expvalue: 10,
    sprite_index: spr_Koboker,
    mask_index: spr_Koboker_mask,
    levels: [
    {
        HP: 1800,
        ATK: 18,
        SPD: 0.4,
        sprite_index: spr_Koboker2,
        expvalue: 12,
        behaviours: 
        {
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
        image_xscale: 1.5,
        image_yscale: 1.5,
        expvalue: 25,
        lifeTime: 1600,
        behaviours: 
        {
            projectileAttackSlow: obj_MobManager.behaviours.projectileAttackSlow,
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            powerScaling: obj_MobManager.behaviours.powerScaling,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }],
    maxLevel: 3
}));
ds_map_set(Mobs, "KobokerWave", new Mob("KobokerWave", 
{
    HP: 1000,
    ATK: 12,
    SPD: 3,
    expvalue: 5,
    knockbackImmune: true,
    ignoreWalls: true,
    sprite_index: spr_Koboker,
    mask_index: spr_Koboker_mask,
    levels: [
    {
        HP: 2000,
        ATK: 18,
        SPD: 2.5,
        expvalue: 10
    }],
    maxLevel: 2,
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
    }
}));
ds_map_set(Mobs, "Cilus", new Mob("Cilus", 
{
    HP: 18000,
    ATK: 25,
    SPD: 1.1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Cilus,
    mask_index: spr_Cilus_mask,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Zecretary", new Mob("Zecretary", 
{
    HP: 1400,
    ATK: 14,
    SPD: 1,
    expvalue: 10,
    sprite_index: spr_Zecretary,
    mask_index: spr_Zecretary_mask,
    levels: [
    {
        HP: 2100,
        ATK: 20,
        SPD: 1.1,
        sprite_index: spr_Zecretary2,
        expvalue: 13
    }, 
    {
        HP: 2000,
        ATK: 20,
        SPD: 0.6,
        expvalue: 3
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "Bazo", new Mob("Bazo", 
{
    HP: 24000,
    ATK: 27,
    SPD: 1,
    image_xscale: 4,
    image_yscale: 4,
    sprite_index: spr_Bazo,
    mask_index: spr_Bazo_mask,
    expvalue: 3000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    behaviours: 
    {
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Pemaloe", new Mob("Pemaloe", 
{
    HP: 1600,
    ATK: 16,
    SPD: 1,
    expvalue: 11,
    sprite_index: spr_Pemaloe,
    mask_index: spr_Pemaloe_mask,
    levels: [
    {
        HP: 2200,
        ATK: 20,
        SPD: 1.2,
        sprite_index: spr_Pemaloe2,
        expvalue: 14
    }, 
    {
        HP: 5500,
        ATK: 35,
        SPD: 1.3,
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
ds_map_set(Mobs, "PemaloeHorde", new Mob("PemaloeHorde", 
{
    HP: 2000,
    ATK: 8,
    SPD: 2.5,
    lockFacing: false,
    sprite_index: spr_Pemaloe,
    mask_index: spr_Pemaloe_mask,
    expvalue: 3,
    lifeTime: 350,
    ignoreWalls: true,
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        horde: obj_MobManager.behaviours.horde
    },
    levels: [
    {
        HP: 300,
        ATK: 8,
        SPD: 1,
        expvalue: 3,
        sprite_index: spr_Zomerade2
    }],
    maxLevel: 2,
    onCreate: hordeOnCreate
}));
ds_map_set(Mobs, "PemaloeMiniBoss", new Mob("PemaloeMiniBoss", 
{
    HP: 35000,
    ATK: 30,
    SPD: 1.2,
    image_xscale: 5,
    image_yscale: 5,
    sprite_index: spr_Pemaloe2,
    mask_index: spr_Pemaloe_mask,
    expvalue: 2000,
    miniboss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false
}));
ds_map_set(Mobs, "Risusaurus", new Mob("Risusaurus", 
{
    HP: 57000,
    ATK: 20,
    SPD: 0.9,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Risusaurus,
    mask_index: spr_Risusaurus_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    attackTime: 180,
    tangible: false,
    canSpecial: true,
    hitboxHeight: 50,
    knockbackImmune: true,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        risusaurusFire: obj_MobManager.behaviours.risusaurusFire,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "IoUFO", new Mob("IoUFO", 
{
    HP: 55000,
    ATK: 25,
    SPD: 0.65,
    image_xscale: 3,
    image_yscale: 3,
    sprite_index: spr_IoUFO,
    mask_index: spr_IoUFO_mask,
    expvalue: 2000,
    tangible: false,
    canSpecial: true,
    hitboxHeight: 50,
    isBoss: true,
    maxLevel: 1,
    lifeTime: -1,
    tangible: false,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        projectileAttackBoss3: obj_MobManager.behaviours.projectileAttackBoss3,
        projectileAttackBoss2: obj_MobManager.behaviours.projectileAttackBoss2,
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Moontato", new Mob("Moontato", 
{
    HP: 53000,
    ATK: 24,
    SPD: 1.1,
    image_xscale: 2.5,
    image_yscale: 2.5,
    sprite_index: spr_Moontato,
    mask_index: spr_Moontato_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    tangible: false,
    attackTime: 180,
    hitboxHeight: 50,
    giantShadow: false,
    canSpecial: true,
    knockbackImmune: true,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        homingDash: 
        {
            config: 
            {
                dashSprite: 535,
                dashSPD: 20,
                stomp: false
            }
        },
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "Area15", new Mob("Area15", 
{
    HP: 999999,
    ATK: 0,
    SPD: 0,
    lifeTime: -1,
    sprite_index: spr_empty,
    isBoss: true,
    noDeathSound: true,
    onDeath: 
    {
        unlockWeapon: function()
        {
            DoAchievement("fourthboss");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "Sausage", "WEAPON");
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
        multiBossChecker: 
        {
            config: 
            {
                numBosses: 3
            }
        }
    }
}));
ds_map_set(Mobs, "S3HFinalMob", new Mob("S3HFinalMob", 
{
    HP: 500,
    ATK: 20,
    SPD: 1.8,
    expvalue: 15,
    sprite_index: [461, 1172, 1747, 637, 2293],
    image_xscale: 1.5,
    image_yscale: 1.5,
    maxLevel: 2,
    levels: [
    {
        HP: 1500,
        ATK: 20,
        SPD: 1,
        expvalue: 15
    }]
}));
ds_map_set(Mobs, "MoTAme", new Mob("MoTAme", 
{
    HP: 75000,
    ATK: 30,
    SPD: 1.1,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_PumpkinAme,
    mask_index: spr_MythorTreat_mask,
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
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        groundPound2: obj_MobManager.behaviours.groundPound2,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "MoTGura", new Mob("MoTGura", 
{
    HP: 78000,
    ATK: 35,
    SPD: 1.2,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_Gurasaur,
    mask_index: spr_MythorTreat_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    ignoreWalls: true,
    tangible: false,
    attackTime: 180,
    hitboxHeight: 50,
    giantShadow: false,
    canSpecial: true,
    knockbackImmune: true,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        homingDash: 
        {
            config: 
            {
                dashSprite: 445,
                dashSPD: 28,
                stomp: true,
                dashDelay: 20
            }
        },
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "MoTIna", new Mob("MoTIna", 
{
    HP: 80000,
    ATK: 28,
    SPD: 0.7,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_ScientistIna,
    mask_index: spr_MythorTreat_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    attackTime: 180,
    attackTime2: 120,
    tangible: false,
    canSpecial: true,
    hitboxHeight: 50,
    knockbackImmune: true,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        throwBeaker: obj_MobManager.behaviours.throwBeaker,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "MoTCalli", new Mob("MoTCalli", 
{
    HP: 83000,
    ATK: 28,
    SPD: 1.45,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_NurseCalli,
    mask_index: spr_MythorTreat_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    attackTime: 180,
    attackTime2: 120,
    tangible: false,
    canSpecial: true,
    hitboxHeight: 50,
    knockbackImmune: true,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chainsaw: obj_MobManager.behaviours.chainsaw,
        followPlayer: obj_MobManager.behaviours.followPlayer
    }
}));
ds_map_set(Mobs, "MoTKiara", new Mob("MoTKiara", 
{
    HP: 82000,
    ATK: 33,
    SPD: 1.2,
    image_xscale: 2,
    image_yscale: 2,
    sprite_index: spr_VampireKiara,
    mask_index: spr_MythorTreat_mask,
    lifeTime: -1,
    expvalue: 2000,
    isBoss: true,
    attackTime: 180,
    origin_x: 0,
    origin_y: 0,
    attackTime2: 120,
    tangible: false,
    canSpecial: true,
    hitboxHeight: 50,
    knockbackImmune: true,
    onDeath: 
    {
        multiBossDefeat: function()
        {
            if (variable_global_exists("multiBossDefeat"))
            {
                global.multiBossDefeat--;
            }
        }
    },
    behaviours: 
    {
        projectileAttackBoss2: 
        {
            config: 
            {
                maxCount: 5
            }
        },
        projectileAttackBoss3: obj_MobManager.behaviours.projectileAttackBoss3,
        aChanMovement: obj_MobManager.behaviours.aChanMovement,
        healBoss: obj_MobManager.behaviours.healBoss
    }
}));
ds_map_set(Mobs, "MythOrTreat", new Mob("MythOrTreat", 
{
    HP: 999999,
    ATK: 0,
    SPD: 0,
    lifeTime: -1,
    sprite_index: spr_empty,
    isBoss: true,
    noDeathSound: true,
    onDeath: 
    {
        unlockWeapon: function()
        {
            DoAchievement("3hard");
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
        multiBossChecker: 
        {
            config: 
            {
                numBosses: 5
            }
        }
    }
}));
