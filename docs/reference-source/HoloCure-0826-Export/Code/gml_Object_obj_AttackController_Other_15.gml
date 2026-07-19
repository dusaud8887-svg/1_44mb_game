/// Decompiler warnings:
// gml_Script_anon_gml_Object_obj_AttackController_Other_15_7930_gml_Object_obj_AttackController_Other_15: Data left over on VM stack at end of fragment (2 elements).

PsychoAxe = function(arg0, arg1)
{
    arg0.speed = arg0.projSpeed;
    if (!variable_instance_exists(arg0, "lockedX"))
    {
        arg0.lockedX = arg0.stayOn.x;
        arg0.lockedY = arg0.stayOn.y;
    }
    arg0.direction = point_direction(arg0.x, arg0.y, arg0.lockedX, arg0.lockedY) + 90;
};

ds_map_set(attackIndex, "PsychoAxe", new Attack("PsychoAxe", defaultConfig, 
{
    sprite_index: spr_PsychoAxe,
    damage: 1.3,
    attackTime: 240,
    hitLimit: 10,
    hitCD: 50,
    projSpeed: 10,
    script: PsychoAxe,
    playSound: [192],
    duration: 180,
    afterImageColor: 65535,
    destroyOnHitLimit: true,
    maxLevel: 7,
    weight: 3,
    levels: [
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            damage: 1.56,
            optionName: global.TextContainer.PsychoAxeName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 192,
            optionName: global.TextContainer.PsychoAxeName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 2.07,
            image_xscale: 1.44,
            image_yscale: 1.44,
            optionName: global.TextContainer.PsychoAxeName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            hitLimit: -1,
            duration: 240,
            optionName: global.TextContainer.PsychoAxeName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 2.16,
            image_yscale: 2.16,
            optionName: global.TextContainer.PsychoAxeName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 3.1122,
            optionName: global.TextContainer.PsychoAxeName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 1793,
    weaponType: "Ranged",
    optionType: "Weapon",
    optionName: global.TextContainer.PsychoAxeName.selectedLanguage,
    optionDescription: global.TextContainer.PsychoAxeDescription.selectedLanguage[0],
    availableMods: ["Damage", "Size", "Crit", "Knockback", "Haste"]
}));

Glowstick = function(arg0, arg1)
{
    TargettedProjectile(arg0, arg1);
    arg0.speed -= 0.2;
};

GlowstickExplode = function(arg0, arg1)
{
};

ds_map_set(attackIndex, "Glowstick", new Attack("Glowstick", defaultConfig, 
{
    sprite_index: spr_GlowStick,
    damage: 1.2,
    attackTime: 240,
    hitCD: 30,
    hitLimit: 3,
    projSpeed: 8,
    script: Glowstick,
    playSound: [97],
    duration: 180,
    targetRandom: true,
    afterImageColor: 16711680,
    destroyOnHitLimit: true,
    onDestroyedByHitLimit: 
    {
        Script: function(arg0, arg1)
        {
            var totalOnHitEffects = {};
            var copyStampVars = {};
            variable_struct_copy(arg0.StampVars, copyStampVars);
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            obj_AttackController.ExecuteAttack("GlowstickExplosion", arg0.creator, 
            {
                damage: arg0.damage * 1.5,
                enhancements: arg0.enhancements,
                image_xscale: arg0.image_xscale * 1.5,
                image_yscale: arg0.image_yscale * 1.5,
                x: arg0.x,
                y: arg0.y,
                onHitEffects: totalOnHitEffects,
                knockback: arg0.knockback,
                CritMod: arg0.CritMod,
                gainedMods: arg0.gainedMods,
                attackDamageID: "Glowstick"
            }, true);
        },
        
        config: {}
    },
    maxLevel: 7,
    weight: 4,
    levels: [
    {
        config: 
        {
            damage: 1.44,
            optionName: global.TextContainer.GlowstickName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            hitLimit: 8,
            attackCount: 2,
            attackDelay: 5,
            optionName: global.TextContainer.GlowstickName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.25,
            image_yscale: 1.25,
            optionName: global.TextContainer.GlowstickName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 5,
            optionName: global.TextContainer.GlowstickName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.9152,
            optionName: global.TextContainer.GlowstickName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            attackDelay: 5,
            optionName: global.TextContainer.GlowstickName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 1176,
    weaponType: "MultiShot",
    optionType: "Weapon",
    optionName: global.TextContainer.GlowstickName.selectedLanguage,
    optionDescription: global.TextContainer.GlowstickDescription.selectedLanguage[0],
    optionID: "Glowstick",
    availableMods: ["Damage", "Size", "Crit", "Knockback", "Projectile", "Haste"]
}));
ds_map_set(attackIndex, "GlowstickExplosion", new Attack("GlowstickExplosion", defaultConfig, 
{
    sprite_index: spr_GlowStickExplode,
    damage: 2,
    attackTime: 0,
    hitCD: 60,
    hitLimit: -1,
    playSound: [48],
    destroyOnHitLimit: false,
    attackDamageID: "Glowstick",
    optionType: "WeaponEffect"
}));

Spidercooking = function(arg0, arg1)
{
    var lifetime2;
    if (arg0.lifetime2 == 0)
    {
        var haachama = variable_struct_exists(obj_PlayerManager.perks, "StrongestIdol");
        arg0.damage = arg0.damage * (1 + (haachama * 0.15));
        arg0.emitter = part_emitter_create(global.psystem);
    }
    if (instance_exists(arg0))
    {
        arg0.lifeTime += 0.05;
        arg0.image_alpha = 0.3 + (cos(arg0.lifeTime) / 10);
        part_emitter_region(global.psystem, arg0.emitter, arg0.stayOn.x - (50 * arg0.image_xscale), arg0.stayOn.x + (50 * arg0.image_xscale), arg0.stayOn.y - (50 * arg0.image_yscale), arg0.stayOn.y + (50 * arg0.image_yscale), 1, 0);
        part_emitter_burst(global.psystem, arg0.emitter, global.partType1, 2 * arg0.image_xscale);
    }
    arg0.lifetime2++;
    if (arg0.lifetime2 >= 595)
    {
        part_emitter_destroy(global.psystem, arg0.emitter);
    }
};

ds_map_set(attackIndex, "SpiderCooking", new Attack("SpiderCooking", defaultConfig, 
{
    sprite_index: spr_spidercooking,
    damage: 0.9,
    noMultiples: true,
    image_xscale: 1.1,
    image_yscale: 1.1,
    attackTime: 600,
    minDelay: 600,
    hitLimit: -1,
    projSpeed: 0,
    isMelee: true,
    hitCD: 45,
    stayOnCreator: true,
    image_alpha: 0,
    script: Spidercooking,
    lifeTime: 0,
    lifetime2: 0,
    duration: 601,
    targetRandom: true,
    drawBehind: true,
    maxLevel: 7,
    weight: 4,
    levels: [
    {
        config: 
        {
            image_xscale: 1.265,
            image_yscale: 1.265,
            optionName: global.TextContainer.SpiderCookingName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.17,
            optionName: global.TextContainer.SpiderCookingName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.58125,
            image_yscale: 1.58125,
            optionName: global.TextContainer.SpiderCookingName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            hitCD: 36,
            optionName: global.TextContainer.SpiderCookingName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.404,
            optionName: global.TextContainer.SpiderCookingName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 8,
                speed: 3
            },
            optionName: global.TextContainer.SpiderCookingName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 2046,
    weaponType: "Melee",
    optionType: "Weapon",
    optionName: global.TextContainer.SpiderCookingName.selectedLanguage,
    optionDescription: global.TextContainer.SpiderCookingDescription.selectedLanguage[0],
    optionID: "SpiderCooking",
    availableMods: ["Damage", "Size", "Crit", "Knockback", "HitRate"]
}));
ds_map_set(attackIndex, "HoloLaser", new Attack("HoloLaser", defaultConfig, 
{
    sprite_index: spr_HoloBeam,
    attackTime: 180,
    damage: 3,
    playSound: [226],
    soundChannel: "laser",
    soundPrio: 20,
    hitLimit: -1,
    faceCreatorDirection: true,
    homing: false,
    hitCD: 60,
    destroyOnHitLimit: false,
    horizontalOnly: true,
    knockback: 
    {
        duration: 10,
        speed: 15
    },
    maxLevel: 7,
    weight: 3,
    levels: [
    {
        config: 
        {
            image_yscale: 1.3,
            optionName: global.TextContainer.HoloLaserName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackTime: 150,
            optionName: global.TextContainer.HoloLaserName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 4,
            optionName: global.TextContainer.HoloLaserName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 120,
            optionName: global.TextContainer.HoloLaserName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_yscale: 2,
            optionName: global.TextContainer.HoloLaserName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            stepDirection: 180,
            horizontalOnly: true,
            optionName: global.TextContainer.HoloLaserName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 251,
    weaponType: "Ranged",
    optionType: "Weapon",
    optionName: global.TextContainer.HoloLaserName.selectedLanguage,
    optionDescription: global.TextContainer.HoloLaserDescription.selectedLanguage[0],
    optionID: "HoloLaser",
    availableMods: ["Damage", "Size", "Crit", "Haste"]
}));

tailplugcharge = function(arg0, arg1)
{
    var times;
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
            soundPlay([273, 108, 256], "tailplug", 3, 4);
            arg0.times = 16;
        }
        arg0.collides = true;
        arg0.speed = arg0.projSpeed;
    }
    else
    {
        if (arg0.times < 12)
        {
            arg0.y -= 0.5 * (12 - arg0.times);
        }
        if (arg0.target != "noTarget" && instance_exists(arg0.target))
        {
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
            arg0.image_angle = arg0.direction;
        }
        arg0.times++;
    }
};

ds_map_set(attackIndex, "Tailplug", new Attack("Tailplug", defaultConfig, 
{
    sprite_index: spr_TailPlug,
    attackTime: 150,
    damage: 1.4,
    hitLimit: -1,
    projSpeed: 20,
    playSound: [209],
    faceCreatorDirection: true,
    duration: 45,
    targetRandom: true,
    times: 0,
    script: tailplugcharge,
    collides: false,
    afterImageColor: 4235519,
    maxLevel: 7,
    weight: 4,
    levels: [
    {
        config: 
        {
            damage: 1.68,
            optionName: global.TextContainer.TailplugName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 5,
            optionName: global.TextContainer.TailplugName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 2.184,
            optionName: global.TextContainer.TailplugName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 5,
            optionName: global.TextContainer.TailplugName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 15,
                speed: 7
            },
            optionName: global.TextContainer.TailplugName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            attackDelay: 5,
            optionName: global.TextContainer.TailplugName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 1962,
    weaponType: "MultiShot",
    optionType: "Weapon",
    optionName: global.TextContainer.TailplugName.selectedLanguage,
    optionDescription: global.TextContainer.TailplugDescription.selectedLanguage[0],
    optionID: "Tailplug",
    availableMods: ["Damage", "Crit", "Projectile", "Haste"]
}));

BLBook = function(arg0, arg1)
{
    arg0.x = arg0.stayOn.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg0.stayOn.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.angle += arg0.projSpeed;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "BLBook", new Attack("BLBook", defaultConfig, 
{
    sprite_index: spr_BLBook,
    damage: 1.4,
    attackTime: 360,
    minDelay: 300,
    hitLimit: 7,
    destroyOnHitLimit: true,
    duration: 120,
    hitCD: 20,
    angle: 0,
    radius: 50,
    projSpeed: 3,
    knockback: 
    {
        duration: 5,
        speed: 2
    },
    attackCount: 3,
    startDirection: 0,
    stepDirection: 120,
    afterImageColor: 255,
    script: BLBook,
    maxLevel: 7,
    weight: 3,
    levels: [
    {
        config: 
        {
            attackCount: 4,
            startDirection: 0,
            stepDirection: 90,
            optionName: global.TextContainer.BLBookName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.82,
            duration: 300,
            optionName: global.TextContainer.BLBookName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 5,
            stepDirection: 72,
            optionName: global.TextContainer.BLBookName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            radius: 75,
            projSpeed: 5,
            optionName: global.TextContainer.BLBookName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 6,
            stepDirection: 60,
            optionName: global.TextContainer.BLBookName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 2.548,
            optionName: global.TextContainer.BLBookName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 798,
    weaponType: "MultiShot",
    projOrientation: "circle",
    optionType: "Weapon",
    optionName: global.TextContainer.BLBookName.selectedLanguage,
    optionDescription: global.TextContainer.BLBookDescription.selectedLanguage[0],
    optionID: "BLBook",
    availableMods: ["Damage", "Size", "Crit", "Projectile"]
}));

musicnote = function(arg0, arg1)
{
    arg0.image_angle = 0;
    arg0.y -= lengthdir_y(1, arg0.direction) * arg0.projSpeed;
    arg0.lifetime += 0.1;
    if (arg0.direction == 90)
    {
        arg0.x -= sin(1.5707963267948966 + arg0.lifetime) * arg0.width;
    }
    else
    {
        arg0.x += sin(1.5707963267948966 + arg0.lifetime) * arg0.width;
    }
};

ds_map_set(attackIndex, "IdolSong", new Attack("IdolSong", defaultConfig, 
{
    sprite_index: spr_MusicalNote,
    damage: 1.3,
    attackTime: 200,
    hitLimit: -1,
    projSpeed: 1,
    width: 7,
    hitCD: 20,
    script: musicnote,
    duration: 150,
    destroyOnHitLimit: true,
    attackCount: 2,
    startDirection: 90,
    stepDirection: 180,
    lifetime: 0,
    afterImageColor: 16711680,
    weight: 3,
    maxLevel: 7,
    levels: [
    {
        config: 
        {
            damage: 1.625,
            optionName: global.TextContainer.IdolSongName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            width: 10,
            projSpeed: 1.2,
            optionName: global.TextContainer.IdolSongName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.25,
            image_yscale: 1.25,
            optionName: global.TextContainer.IdolSongName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 160,
            optionName: global.TextContainer.IdolSongName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.56,
            image_yscale: 1.56,
            optionName: global.TextContainer.IdolSongName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 2.43,
            optionName: global.TextContainer.IdolSongName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 575,
    weaponType: "Ranged",
    optionType: "Weapon",
    optionName: global.TextContainer.IdolSongName.selectedLanguage,
    optionDescription: global.TextContainer.IdolSongDescription.selectedLanguage[0],
    optionID: "IdolSong",
    availableMods: ["Damage", "Size", "Crit", "Haste"]
}));

cuttingboard = function(arg0, arg1)
{
    if (arg0.lifetime == 0 && variable_struct_exists(global.charSelected, "flat"))
    {
        arg0.damage *= 1.3;
        arg0.image_xscale *= 1.3;
        arg0.image_yscale *= 1.3;
    }
    arg0.collides = true;
    arg0.lifetime += 1;
    if (arg0.lifetime < 30)
    {
        arg0.speed = -arg0.projSpeed + ((arg0.lifetime / 30) * arg0.projSpeed);
    }
    else
    {
        arg0.speed = 0;
    }
};

ds_map_set(attackIndex, "CuttingBoard", new Attack("CuttingBoard", defaultConfig, 
{
    sprite_index: spr_CuttingBoard,
    damage: 1.3,
    attackTime: 180,
    hitLimit: -1,
    projSpeed: 7,
    hitCD: 20,
    script: cuttingboard,
    duration: 120,
    playSound: [263],
    destroyOnHitLimit: false,
    stepDirection: 180,
    lifetime: 0,
    collides: false,
    faceCreatorDirection: true,
    afterImageColor: 16711680,
    knockback: 
    {
        duration: 20,
        speed: 7
    },
    weight: 2,
    maxLevel: 7,
    levels: [
    {
        config: 
        {
            image_xscale: 1.3,
            image_yscale: 1.3,
            optionName: global.TextContainer.CuttingBoardName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.625,
            optionName: global.TextContainer.CuttingBoardName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            projSpeed: 10,
            optionName: global.TextContainer.CuttingBoardName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 2.535,
            optionName: global.TextContainer.CuttingBoardName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 150,
            optionName: global.TextContainer.CuttingBoardName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: 270,
            stepDirection: 90,
            optionName: global.TextContainer.CuttingBoardName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 116,
    weaponType: "Ranged",
    optionType: "Weapon",
    optionName: global.TextContainer.CuttingBoardName.selectedLanguage,
    optionDescription: global.TextContainer.CuttingBoardDescription.selectedLanguage[0],
    optionID: "CuttingBoard",
    availableMods: ["Damage", "Size", "Crit", "Haste"]
}));

lavapool = function(arg0, arg1)
{
    arg0.lifetime += 1;
    if (arg0.lifetime == 28)
    {
        arg0.creator = instance_find(obj_PlayerManager, 0).playerCharacter;
        arg0.collides = true;
        arg0.sprite_index = spr_LavaPoolLoop;
        arg0.image_index = 0;
    }
    if (arg0.lifetime == (arg0.ogDuration - 20))
    {
        arg0.sprite_index = spr_LavaPoolEnd;
        arg0.image_index = 0;
        arg0.duration = -1;
        arg0.collides = false;
    }
};

ds_map_set(attackIndex, "LavaPool", new Attack("LavaPool", defaultConfig, 
{
    sprite_index: spr_LavaPoolStart,
    collides: false,
    projSpeed: 0,
    hitLimit: -1,
    depth: 0,
    destroyOnHitLimit: false,
    script: lavapool,
    playSound: [196],
    drawUnderAll: true,
    lifetime: 0,
    attackDamageID: "EliteLava",
    optionType: "WeaponEffect"
}));

EliteLava = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.maxlifetime = 10 + floor(random(30));
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
        arg0.speed = arg0.projSpeed;
        arg0.vspeed += -3;
    }
    arg0.lifetime++;
    arg0.gravity = 0.3;
    if (arg0.lifetime >= arg0.maxlifetime || (arg0.target != "noTarget" && instance_exists(arg0.target) && point_distance(arg0.x, arg0.y, arg0.target.x, arg0.target.y) < 20))
    {
        if (!arg0.hasCreated)
        {
            arg0.hasCreated = true;
            var elite = variable_struct_exists(obj_PlayerManager.perks, "Elite");
            ExecuteAttack("LavaPool", arg0, 
            {
                damage: arg0.damage,
                duration: arg0.ogDuration,
                ogDuration: arg0.ogDuration,
                hitCD: arg0.hitCD,
                enhancements: arg0.enhancements,
                gainedMods: arg0.gainedMods,
                image_xscale: arg0.image_xscale + (elite * 0.1),
                image_yscale: (arg0.image_yscale * 0.8) + (elite * 0.08)
            }, true);
            arg0.duration = 5;
            arg0.visible = false;
        }
    }
};

ds_map_set(attackIndex, "EliteLava", new Attack("EliteLava", defaultConfig, 
{
    sprite_index: spr_EliteLavaBucket,
    damage: 0.8,
    attackTime: 300,
    image_xscale: 0.9,
    image_yscale: 0.9,
    hitLimit: -1,
    projSpeed: 6,
    hitCD: 45,
    collides: false,
    script: EliteLava,
    playSound: [263],
    duration: 180,
    ogDuration: 180,
    attackDelay: 5,
    targetRandom: true,
    destroyOnHitLimit: false,
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    maxlifetime: 10 + floor(random(15)),
    weight: 3,
    maxLevel: 7,
    levels: [
    {
        config: 
        {
            image_xscale: 1.1,
            image_yscale: 1.1,
            optionName: global.TextContainer.EliteLavaName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 5,
            optionName: global.TextContainer.EliteLavaName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 1.2,
            duration: 270,
            ogDuration: 270,
            optionName: global.TextContainer.EliteLavaName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.EliteLavaName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 5,
            optionName: global.TextContainer.EliteLavaName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            attackDelay: 5,
            image_xscale: 1.32,
            image_yscale: 1.32,
            optionName: global.TextContainer.EliteLavaName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 1378,
    weaponType: "MultiShot",
    optionType: "Weapon",
    optionName: global.TextContainer.EliteLavaName.selectedLanguage,
    optionDescription: global.TextContainer.EliteLavaDescription.selectedLanguage[0],
    optionID: "EliteLava",
    availableMods: ["Damage", "Size", "Crit", "Haste", "HitRate"]
}));

Explode = function(arg0, arg1)
{
    var timeline;
    if (arg0.timeline == 0)
    {
        arg0.creator = instance_find(obj_PlayerManager, 0).playerCharacter;
        arg0.collides = true;
    }
    arg0.timeline++;
    if (arg0.timeline == 10)
    {
        arg0.collides = false;
    }
};

ds_map_set(attackIndex, "BombExplode", new Attack("BombExplode", defaultConfig, 
{
    sprite_index: spr_bombExplode,
    collides: false,
    projSpeed: 0,
    hitLimit: -1,
    destroyOnHitLimit: false,
    timeline: 0,
    playSound: [48],
    soundChannel: "explode",
    soundPrio: 20,
    script: Explode,
    attackDamageID: "HoloBomb",
    optionType: "WeaponEffect"
}));

HoloBomb = function(arg0, arg1)
{
    var lifetime;
    if (arg0.speed > 0)
    {
        arg0.speed -= 0.6;
    }
    else
    {
        arg0.speed = 0;
    }
    arg0.lifetime--;
    if (arg0.lifetime < 1)
    {
        if (!arg0.hasCreated)
        {
            arg0.hasCreated = true;
            var totalOnHitEffects = {};
            var copyStampVars = {};
            variable_struct_copy(arg0.StampVars, copyStampVars);
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            ExecuteAttack("BombExplode", arg0, 
            {
                damage: arg0.damage,
                hitCD: arg0.hitCD,
                image_xscale: arg0.sizeUp,
                image_yscale: arg0.sizeUp,
                enhancements: arg0.enhancements,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                CritMod: arg0.CritMod,
                starty: 10
            }, true);
            if (arg0.hasCreated)
            {
                visible = false;
            }
        }
    }
};

function HoloBombCollide()
{
    image_angle = 0;
    
    OnCollideWithTarget = function(arg0)
    {
        if (isEnemy != arg0.isEnemy && collides)
        {
            if (!hasCreated)
            {
                hasCreated = true;
                var totalOnHitEffects = {};
                if (variable_struct_exists(self, "onHitEffects"))
                {
                    variable_struct_copy(onHitEffects, totalOnHitEffects);
                }
                obj_AttackController.ExecuteAttack("BombExplode", id, 
                {
                    damage: damage,
                    hitCD: hitCD,
                    image_xscale: sizeUp,
                    image_yscale: sizeUp,
                    enhancements: enhancements,
                    knockback: knockback,
                    onHitEffects: totalOnHitEffects,
                    gainedMods: gainedMods,
                    CritMod: CritMod,
                    starty: 10
                }, true);
                if (hasCreated)
                {
                    visible = false;
                }
            }
        }
    };
}

ds_map_set(attackIndex, "HoloBomb", new Attack("HoloBomb", defaultConfig, 
{
    sprite_index: spr_HoloBombThrow,
    damage: 1.7,
    attackTime: 120,
    hitLimit: -1,
    speed: 7,
    hitCD: 20,
    collides: true,
    script: HoloBomb,
    onCreate: HoloBombCollide,
    duration: 630,
    destroyOnHitLimit: false,
    playSound: [263],
    soundPitch: true,
    hasCreated: false,
    lifetime: 600,
    isEnemy: false,
    faceCreatorDirection: true,
    stepDirection: 360,
    drawBehind: true,
    sizeUp: 1,
    starty: -8,
    sizeUp: 1.44,
    weight: 3,
    maxLevel: 7,
    levels: [
    {
        config: 
        {
            sizeUp: 1.656,
            optionName: global.TextContainer.HoloBombName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 2.04,
            optionName: global.TextContainer.HoloBombName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 5,
            stepDirection: 180,
            startDirection: 0,
            optionName: global.TextContainer.HoloBombName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 96,
            optionName: global.TextContainer.HoloBombName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            sizeUp: 1.9872,
            optionName: global.TextContainer.HoloBombName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 5,
            startDirection: 120,
            stepDirection: 120,
            optionName: global.TextContainer.HoloBombName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 277,
    weaponType: "MultiShot",
    projOrientation: "circle",
    optionType: "Weapon",
    optionName: global.TextContainer.HoloBombName.selectedLanguage,
    optionDescription: global.TextContainer.HoloBombDescription.selectedLanguage[0],
    optionID: "HoloBomb",
    availableMods: ["Damage", "Size", "Crit", "Haste", "Knockback"]
}));

XPotato = function(arg0, arg1)
{
    arg0.image_angle += 30;
    if (arg0.x < camera_get_view_x(view_camera[0]))
    {
        arg0.direction += 60 - irandom(120);
        arg0.hspeed = abs(arg0.hspeed);
    }
    if (arg0.x > (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])))
    {
        arg0.direction += 60 - irandom(120);
        arg0.hspeed = -abs(arg0.hspeed);
    }
    if (arg0.y < camera_get_view_y(view_camera[0]))
    {
        arg0.direction += 60 - irandom(120);
        arg0.vspeed = abs(arg0.vspeed);
    }
    if (arg0.y > (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])))
    {
        arg0.direction += 60 - irandom(120);
        arg0.vspeed = -abs(arg0.vspeed);
    }
    if (arg0.duration < 2)
    {
        var totalOnHitEffects = {};
        var copyStampVars = {};
        variable_struct_copy(arg0.StampVars, copyStampVars);
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        ExecuteAttack("XPotatoBlast", arg1, 
        {
            damage: arg0.damage * 2,
            enhancements: arg0.enhancements,
            image_xscale: arg0.blastSize,
            image_yscale: arg0.blastSize,
            x: arg0.x,
            y: arg0.y,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
    }
};

ds_map_set(attackIndex, "XPotatoBlast", new Attack("XPotatoBlast", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_PotatoExplosion,
    attackTime: 120,
    playSound: [48],
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    attackDamageID: "XPotato",
    optionType: "WeaponEffect"
}));
ds_map_set(attackIndex, "XPotato", new Attack("XPotato", defaultConfig, 
{
    sprite_index: spr_XPotato,
    damage: 0.9,
    attackTime: 210,
    hitLimit: 10,
    destroyOnHitLimit: true,
    playSound: [46],
    duration: 180,
    hitCD: 20,
    faceCreatorDirection: true,
    targetRandom: true,
    lifetime: 0,
    speed: 5,
    attackCount: 1,
    blastSize: 0.8,
    script: XPotato,
    onDestroyedByHitLimit: 
    {
        Script: function(arg0, arg1)
        {
            var totalOnHitEffects = {};
            var copyStampVars = {};
            variable_struct_copy(arg0.StampVars, copyStampVars);
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            obj_AttackController.ExecuteAttack("XPotatoBlast", arg0.creator, 
            {
                damage: arg0.damage * 2,
                enhancements: arg0.enhancements,
                image_xscale: arg0.blastSize,
                image_yscale: arg0.blastSize,
                x: arg0.x,
                y: arg0.y,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods
            }, true);
        },
        
        config: {}
    },
    weight: 2,
    maxLevel: 7,
    levels: [
    {
        config: 
        {
            blastSize: 1,
            optionName: global.TextContainer.XPotatoName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 5,
            stepDirection: 5,
            optionName: global.TextContainer.XPotatoName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            damage: 1.43,
            speed: 6.5,
            optionName: global.TextContainer.XPotatoName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 127,
            hitLimit: -1,
            optionName: global.TextContainer.XPotatoName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.3,
            image_yscale: 1.3,
            blastSize: 1,
            optionName: global.TextContainer.XPotatoName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            stepDirection: 5,
            attackDelay: 5,
            optionName: global.TextContainer.XPotatoName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 1922,
    weaponType: "MultiShot",
    optionType: "Weapon",
    optionName: global.TextContainer.XPotatoName.selectedLanguage,
    optionDescription: global.TextContainer.XPotatoDescription.selectedLanguage[0],
    optionID: "XPotato",
    availableMods: ["Damage", "Size", "Crit", "Projectile", "Haste"]
}));
ds_map_set(attackIndex, "WamyWater", new Attack("WamyWater", defaultConfig, 
{
    stayOnCreator: true,
    attackTime: 120,
    damage: 1.1,
    faceCreatorDirection: true,
    sprite_index: spr_WamyWaterSplash,
    playSound: [96],
    soundPitch: true,
    image_xscale: 1.2,
    image_yscale: 1.2,
    hitLimit: -1,
    hitCD: 30,
    knockback: 
    {
        duration: 10,
        speed: 5
    },
    weight: 3,
    levels: [
    {
        config: 
        {
            damage: 1.32,
            optionName: global.TextContainer.WamyWaterName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.44,
            image_yscale: 1.44,
            optionName: global.TextContainer.WamyWaterName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 10,
                speed: 8
            },
            optionName: global.TextContainer.WamyWaterName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackTime: 96,
            optionName: global.TextContainer.WamyWaterName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            damage: 1.716,
            optionName: global.TextContainer.WamyWaterName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            image_xscale: 2,
            image_yscale: 2,
            onHitEffects: 
            {
                StopMove: {}
            },
            optionName: global.TextContainer.WamyWaterName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[6]
        }
    }],
    maxLevel: 7,
    optionIcon: 1263,
    weaponType: "Melee",
    optionName: global.TextContainer.WamyWaterName.selectedLanguage,
    optionDescription: global.TextContainer.WamyWaterDescription.selectedLanguage[0],
    optionType: "Weapon",
    optionID: "WamyWater",
    availableMods: ["Damage", "Size", "Crit", "Haste", "Knockback"]
}));
ds_map_set(attackIndex, "CEOTears", new Attack("CEOTears", defaultConfig, 
{
    sprite_index: spr_CEOTears,
    damage: 1,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    projSpeed: 4,
    playSound: [255],
    soundChannel: "tears",
    soundCD: 6,
    duration: 90,
    targetRandom: true,
    script: TargettedProjectile,
    destroyOnHitLimit: true,
    maxLevel: 7,
    weight: 2,
    levels: [
    {
        config: 
        {
            damage: 1.2,
            optionName: global.TextContainer.CEOTearsName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            optionName: global.TextContainer.CEOTearsName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 20,
            optionName: global.TextContainer.CEOTearsName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            damage: 1.44,
            projSpeed: 5,
            optionName: global.TextContainer.CEOTearsName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 10,
            optionName: global.TextContainer.CEOTearsName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 4,
            optionName: global.TextContainer.CEOTearsName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 2065,
    weaponType: "MultiShot",
    optionType: "Weapon",
    optionName: global.TextContainer.CEOTearsName.selectedLanguage,
    optionDescription: global.TextContainer.CEOTearsDescription.selectedLanguage[0],
    optionID: "CEOTears",
    availableMods: ["Damage", "Size", "Crit", "Projectile", "Haste"]
}));

ENCurse = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 5)
    {
        arg0.collides = true;
    }
    if (arg0.targetted)
    {
        if (!variable_instance_exists(arg0, "target"))
        {
            targets = ds_list_create();
            numTargets = collision_circle_list(arg0.x, arg0.y, arg0.range, obj_Enemy, false, true, targets, true);
            targets = RemoveFriendly(targets);
            numTargets = ds_list_size(targets);
            if (numTargets == 0)
            {
                arg0.target = "noTarget";
                arg0.direction = arg1.direction;
                arg0.speed = arg0.projSpeed;
            }
            else if (arg0.targetRandom)
            {
                randomIndex = floor(random(numTargets));
                if (variable_instance_exists(arg0, "ignoreTarget"))
                {
                    arg0.target = ds_list_find_value(targets, randomIndex);
                    while (numTargets > 1 && arg0.target == arg0.ignoreTarget)
                    {
                        randomIndex = floor(random(numTargets));
                        arg0.target = ds_list_find_value(targets, randomIndex);
                    }
                }
                else
                {
                    arg0.target = ds_list_find_value(targets, randomIndex);
                }
            }
            else
            {
                arg0.target = ds_list_find_value(targets, 0);
            }
            ds_list_destroy(targets);
            targets = -1;
        }
        if (!arg0.updatedDirection && arg0.target != "noTarget" && instance_exists(arg0.target))
        {
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
            arg0.speed = arg0.projSpeed;
            arg0.image_angle = arg0.direction;
        }
        if (!arg0.homing)
        {
            arg0.updatedDirection = true;
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "ENCurse", new Attack("ENCurse", defaultConfig, 
{
    sprite_index: spr_ENCurseBlast,
    damage: 1.44,
    attackTime: 110,
    hitCD: 30,
    hitLimit: 1,
    speed: 7,
    image_xscale: 1.5,
    image_ysscale: 1.5,
    collides: true,
    projSpeed: 7,
    playSound: [121],
    soundChannel: "curse",
    soundCD: 6,
    duration: 90,
    range: 100,
    targetted: false,
    hardLimit: 3,
    targetRandom: true,
    lifetime: 0,
    afterImageColor: 8388736,
    faceCreatorDirection: true,
    destroyOnHitLimit: true,
    stepDirection: 20,
    maxLevel: 7,
    script: ENCurse,
    onHitEffects: 
    {
        ChainCurse: 
        {
            chance: 70,
            grow: false
        }
    },
    weight: 2,
    levels: [
    {
        config: 
        {
            onHitEffects: 
            {
                ChainCurse: 
                {
                    chance: 80,
                    grow: false
                }
            },
            optionName: global.TextContainer.ENCurseName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            damage: 1.87,
            onHitEffects: 
            {
                ChainCurse: 
                {
                    chance: 80,
                    grow: false
                }
            },
            optionName: global.TextContainer.ENCurseName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            range: 125,
            onHitEffects: 
            {
                ChainCurse: 
                {
                    chance: 80,
                    grow: false
                }
            },
            optionName: global.TextContainer.ENCurseName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            startDirection: -10,
            stepDirection: 20,
            onHitEffects: 
            {
                ChainCurse: 
                {
                    chance: 90,
                    grow: false
                }
            },
            optionName: global.TextContainer.ENCurseName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 93,
            onHitEffects: 
            {
                ChainCurse: 
                {
                    chance: 90,
                    grow: false
                }
            },
            optionName: global.TextContainer.ENCurseName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            startDirection: -10,
            stepDirection: 10,
            onHitEffects: 
            {
                ChainCurse: 
                {
                    chance: 90,
                    grow: true
                }
            },
            optionName: global.TextContainer.ENCurseName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 2248,
    weaponType: "MultiShot",
    projOrientation: "frontSpread",
    optionType: "Weapon",
    optionName: global.TextContainer.ENCurseName.selectedLanguage,
    optionDescription: global.TextContainer.ENCurseDescription.selectedLanguage[0],
    optionID: "ENCurse",
    availableMods: ["Damage", "Size", "Crit", "Projectile", "Haste"]
}));

BounceBall = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.collides = true;
        arg0.image_xscale = 0.6 + (global.charSelected.sizeGrade * 0.1);
        arg0.image_yscale = 0.6 + (global.charSelected.sizeGrade * 0.1);
        if (arg0.knockback != false)
        {
            arg0.knockback.speed = 3 + (global.charSelected.sizeGrade * 2);
        }
        arg0.image_alpha = 1;
        if (!variable_instance_exists(arg0, "target"))
        {
            targets = ds_list_create();
            numTargets = collision_circle_list(arg0.x, arg0.y, arg0.range, obj_Enemy, false, true, targets, true);
            targets = RemoveFriendly(targets);
            numTargets = ds_list_size(targets);
            if (numTargets == 0)
            {
                arg0.target = "noTarget";
                arg0.y = arg1.x;
                arg0.x = arg0.y - 150;
            }
            else if (arg0.targetRandom)
            {
                randomIndex = floor(random(numTargets));
                if (variable_instance_exists(arg0, "ignoreTarget"))
                {
                    arg0.target = ds_list_find_value(targets, randomIndex);
                    while (numTargets > 1 && arg0.target == arg0.ignoreTarget)
                    {
                        randomIndex = floor(random(numTargets));
                        arg0.target = ds_list_find_value(targets, randomIndex);
                    }
                }
                else
                {
                    arg0.target = ds_list_find_value(targets, randomIndex);
                }
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
            arg0.x = arg0.target.x;
            arg0.y = arg0.target.y - 150;
        }
    }
    arg0.image_angle += 10;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "BounceBall", new Attack("BounceBall", defaultConfig, 
{
    sprite_index: spr_BounceBall,
    damage: 1.4,
    attackTime: 120,
    hitCD: 30,
    hitLimit: 1,
    deflects: 10,
    speed: 8,
    direction: 270,
    gravity: 0.5,
    collides: true,
    playSound: [263],
    soundCD: 6,
    duration: 180,
    range: 300,
    image_alpha: 0,
    collides: true,
    targetRandom: true,
    lifetime: 0,
    destroyOnHitLimit: true,
    maxLevel: 7,
    onDeflect: 
    {
        Script: function(arg0, arg1)
        {
            arg0.direction += 45 + random(90);
            arg0.speed /= 1.2;
        },
        
        config: {}
    },
    script: BounceBall,
    weight: 4,
    levels: [
    {
        config: 
        {
            damage: 1.56,
            optionName: global.TextContainer.BounceBallName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[1]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 5,
            optionName: global.TextContainer.BounceBallName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            knockback: 
            {
                duration: 5,
                speed: 3
            },
            optionName: global.TextContainer.BounceBallName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            attackCount: 3,
            attackDelay: 5,
            optionName: global.TextContainer.BounceBallName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 102,
            optionName: global.TextContainer.BounceBallName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            damage: 2.028,
            attackCount: 4,
            attackDelay: 5,
            optionName: global.TextContainer.BounceBallName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 815,
    weaponType: "MultiShot",
    optionType: "Weapon",
    optionName: global.TextContainer.BounceBallName.selectedLanguage,
    optionDescription: global.TextContainer.BounceBallDescription.selectedLanguage[0],
    optionID: "BounceBall",
    availableMods: ["Damage", "Size", "Crit", "Projectile", "Haste"]
}));

Sausage = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
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
            }
            else if (arg0.targetRandom)
            {
                randomIndex = floor(random(numTargets));
                if (variable_instance_exists(arg0, "ignoreTarget"))
                {
                    arg0.target = ds_list_find_value(targets, randomIndex);
                    while (array_length(numTargets) > 1 && arg0.target == arg0.ignoreTarget)
                    {
                        randomIndex = floor(random(numTargets));
                        arg0.target = ds_list_find_value(targets, randomIndex);
                    }
                }
                else
                {
                    arg0.target = ds_list_find_value(targets, randomIndex);
                }
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
            if (arg0.sausageCombo)
            {
                if (arg0.countID == 0)
                {
                    arg0.image_yscale = -arg0.image_yscale;
                }
                else if (arg0.countID == 1)
                {
                    arg0.knockback = 
                    {
                        duration: 10,
                        speed: 10
                    };
                }
            }
            arg0.image_alpha = 1;
            arg0.collides = true;
            soundPlay([46], "projectile", 10, 10, true);
            arg0.direction = point_direction(arg1.x, arg1.y, arg0.target.x, arg0.target.y);
            arg0.image_angle = arg0.direction;
        }
    }
    arg0.lifetime++;
    if (arg0.target == "noTarget")
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "Sausage", new Attack("Sausage", defaultConfig, 
{
    sprite_index: spr_SausageSwing,
    damage: 1.6,
    attackTime: 90,
    hitCD: 30,
    hitLimit: -1,
    collides: false,
    soundCD: 6,
    range: 60,
    speed: 0,
    projSpeed: 0,
    stayOnCreator: true,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0,
    collides: false,
    targetRandom: false,
    lifetime: 0,
    destroyOnHitLimit: false,
    sausageCombo: false,
    maxLevel: 7,
    script: Sausage,
    weight: 3,
    levels: [
    {
        config: 
        {
            damage: 1.92,
            optionName: global.TextContainer.SausageName.selectedLanguage + " LV 2",
            optionDescription: global.TextContainer.SausageDescription.selectedLanguage[1]
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
            optionName: global.TextContainer.SausageName.selectedLanguage + " LV 3",
            optionDescription: global.TextContainer.SausageDescription.selectedLanguage[2]
        }
    }, 
    {
        config: 
        {
            attackTime: 72,
            optionName: global.TextContainer.SausageName.selectedLanguage + " LV 4",
            optionDescription: global.TextContainer.SausageDescription.selectedLanguage[3]
        }
    }, 
    {
        config: 
        {
            image_xscale: 1.2,
            image_yscale: 1.2,
            range: 80,
            damage: 2.5,
            optionName: global.TextContainer.SausageName.selectedLanguage + " LV 5",
            optionDescription: global.TextContainer.SausageDescription.selectedLanguage[4]
        }
    }, 
    {
        config: 
        {
            attackTime: 57,
            optionName: global.TextContainer.SausageName.selectedLanguage + " LV 6",
            optionDescription: global.TextContainer.SausageDescription.selectedLanguage[5]
        }
    }, 
    {
        config: 
        {
            attackCount: 2,
            attackDelay: 10,
            damage: 1.3,
            sausageCombo: true,
            optionName: global.TextContainer.SausageName.selectedLanguage + " LV MAX",
            optionDescription: global.TextContainer.SausageDescription.selectedLanguage[6]
        }
    }],
    optionIcon: 19,
    weaponType: "Melee",
    optionType: "Weapon",
    optionName: global.TextContainer.SausageName.selectedLanguage,
    optionDescription: global.TextContainer.SausageDescription.selectedLanguage[0],
    optionID: "Sausage",
    availableMods: ["Damage", "Size", "Crit", "Haste", "Knockback"]
}));
ds_map_set(attackIndex, "BombSticker", new Attack("BombSticker", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_Explosion,
    attackTime: 0,
    attackCount: 1,
    hitCD: 30,
    image_xscale: 1,
    playSound: [48],
    image_yscale: 1,
    image_alpha: 0.8,
    attackDelay: 30,
    hitLimit: -1
}));
