/// Decompiler warnings:
// gml_Script_anon_gml_Object_obj_AttackController_Other_16_11314_gml_Object_obj_AttackController_Other_16: Data left over on VM stack at end of fragment (2 elements).
// gml_Script_anon_gml_Object_obj_AttackController_Other_16_88230_gml_Object_obj_AttackController_Other_16: Data left over on VM stack at end of fragment (2 elements).

IdolConcert = function(arg0, arg1)
{
    var lifetime;
    arg0.speed -= 0.2;
    if (arg0.lifetime == 0)
    {
        arg0.sprite_index = arg0.colorArray[arg0.direction div 45];
        arg0.image_alpha = 1;
    }
    arg0.lifetime++;
    if (arg0.lifetime == 44)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        obj_AttackController.ExecuteAttack("IdolConcertExplosion", arg0.creator, 
        {
            damage: arg0.damage * 2.25,
            enhancements: arg0.enhancements,
            image_xscale: arg0.image_xscale * 2,
            image_yscale: arg0.image_yscale * 2,
            sprite_index: arg0.expArray[arg0.direction div 45],
            x: arg0.x,
            y: arg0.y,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            attackDamageID: "IdolConcert"
        }, true);
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "IdolConcert", new Attack("IdolConcert", defaultConfig, 
{
    sprite_index: spr_GlowStick,
    colorArray: [1031, 1440, 991, 1260, 314, 1340, 2149, 1024],
    expArray: [1195, 694, 154, 921, 1052, 1816, 35, 396],
    damage: 1.75,
    attackTime: 120,
    minDelay: 40,
    hitCD: 20,
    hitLimit: -1,
    image_xscale: 2,
    image_yscale: 2,
    speed: 8,
    projSpeed: 8,
    image_alpha: 0,
    script: IdolConcert,
    lifetime: 0,
    playSound: [97],
    duration: 60,
    targetRandom: true,
    afterImageColor: 16711680,
    destroyOnHitLimit: true,
    maxLevel: 1,
    attackCount: 8,
    startDirection: 0,
    stepDirection: -45,
    attackDelay: 5,
    knockback: 
    {
        duration: 7,
        speed: 3
    },
    optionIcon: 1679,
    weaponType: "Ranged",
    optionType: "Collab",
    combos: ["Glowstick", "IdolSong"],
    optionName: global.TextContainer.IdolConcertName.selectedLanguage,
    optionDescription: global.TextContainer.IdolConcertDescription.selectedLanguage[0],
    optionID: "IdolConcert"
}));

IdolConcertExplod = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (global.lightFX)
        {
            arg0.emitter = part_emitter_create(global.psystem);
            part_emitter_region(global.psystem, arg0.emitter, arg0.x, arg0.x, arg0.y, arg0.y, 0, 0);
            part_emitter_burst(global.psystem, arg0.emitter, global.partType7, 100);
        }
    }
    arg0.lifetime++;
    arg0.image_xscale += arg0.lifetime / 15;
    arg0.image_yscale += arg0.lifetime / 15;
    arg0.image_alpha -= 0.07;
    if (arg0.image_alpha < 0.4)
    {
        arg0.collides = false;
    }
    if (arg0.image_alpha < 0)
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "IdolConcertExplosion", new Attack("IdolConcertExplosion", defaultConfig, 
{
    sprite_index: spr_GlowStickExplode,
    damage: 2,
    image_xscale: 0.2,
    image_yscale: 0.2,
    attackTime: 0,
    hitCD: 90,
    hitLimit: -1,
    lifetime: 0,
    emitter: 0,
    duration: 15,
    playSound: [48],
    script: IdolConcertExplod,
    destroyOnHitLimit: false,
    attackDamageID: "IdolConcert",
    optionType: "WeaponEffect"
}));

LightBeamBeam = function(arg0, arg1)
{
    TargettedProjectile(arg0, arg1);
    arg0.speed = 0;
};

ds_map_set(attackIndex, "LightBeamBeam", new Attack("LightBeamBeam", defaultConfig, 
{
    sprite_index: spr_LightBeam,
    attackTime: 240,
    image_yscale: 4,
    image_xscale: 3,
    damage: 3,
    projSpeed: 0,
    range: 400,
    playSound: [226],
    soundChannel: "laser",
    script: LightBeamBeam,
    soundPrio: 20,
    hitLimit: -1,
    faceCreatorDirection: false,
    homing: false,
    hitCD: 60,
    targetRandom: true,
    destroyOnHitLimit: false,
    attackDamageID: "LightBeam",
    optionType: "WeaponEffect"
}));

LightBeam = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        TargettedProjectile(arg0, arg1);
    }
    arg0.speed -= 0.2;
    arg0.lifetime++;
    if (arg0.lifetime == 44)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        obj_AttackController.ExecuteAttack("LightBeamBeam", arg0.creator, 
        {
            damage: arg0.damage * 3,
            enhancements: arg0.enhancements,
            x: arg0.x,
            y: arg0.y,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale
        }, true);
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "LightBeam", new Attack("LightBeam", defaultConfig, 
{
    sprite_index: spr_GlowStick_Yellow,
    damage: 1,
    attackTime: 50,
    minDelay: 10,
    hitCD: 15,
    hitLimit: -1,
    image_xscale: 2,
    image_yscale: 2,
    speed: 8,
    projSpeed: 8,
    image_alpha: 1,
    script: LightBeam,
    lifetime: 0,
    playSound: [97],
    duration: 60,
    attackCount: 4,
    stepDirection: 90,
    range: 400,
    targetRandom: true,
    afterImageColor: 16711680,
    destroyOnHitLimit: true,
    maxLevel: 1,
    optionIcon: 1800,
    weaponType: "MultiShot",
    optionType: "Collab",
    combos: ["Glowstick", "HoloLaser"],
    optionName: global.TextContainer.LightBeamName.selectedLanguage,
    optionDescription: global.TextContainer.LightBeamDescription.selectedLanguage[0],
    optionID: "LightBeam"
}));

BLAxe = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 1;
        arg0.collides = true;
        arg0.lifetime++;
        if (arg0.makeContinue > 0)
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            ExecuteAttack("BLAxe", arg0.creator, 
            {
                makeContinue: arg0.makeContinue - 1,
                direction: arg0.direction + 180,
                enhancements: arg0.enhancements,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                applyWeaponSize: true,
                gainedMods: arg0.gainedMods
            }, true);
        }
    }
    arg0.x = arg1.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg1.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.angle += arg0.projSpeed;
};

ds_map_set(attackIndex, "BLAxe", new Attack("BLAxe", defaultConfig, 
{
    sprite_index: spr_PsychoAxe,
    image_xscale: 2,
    image_yscale: 2,
    damage: 1.25,
    attackTime: 110,
    hitLimit: -1,
    duration: 110,
    hitCD: 20,
    angle: 0,
    radius: 160,
    collides: false,
    image_alpha: 0,
    projSpeed: 10,
    lifetime: 0,
    makeContinue: 2,
    startDirection: 0,
    stepDirection: 180,
    afterImageColor: 65535,
    script: BLAxe,
    maxLevel: 1,
    optionID: "BLAxe",
    attackDamageID: "BLLover",
    optionType: "WeaponEffect"
}));

BLLoverBooks = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 1;
        arg0.collides = true;
        arg0.lifetime++;
        if (arg0.makeContinue > 0)
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            if (variable_struct_exists(obj_PlayerManager.perks, "Suicopath"))
            {
                variable_struct_set(totalOnHitEffects, "LifeSteal", 
                {
                    chance: 10,
                    heal: 3
                });
            }
            ExecuteAttack("BLLoverBooks", arg0.creator, 
            {
                makeContinue: arg0.makeContinue - 1,
                direction: arg0.direction + 60,
                enhancements: arg0.enhancements,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true
            }, true);
        }
    }
    arg0.x = arg1.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg1.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.angle += arg0.projSpeed;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "BLLoverBooks", new Attack("BLLoverBooks", defaultConfig, 
{
    sprite_index: spr_BLBookS,
    damage: 0.5,
    attackTime: 110,
    collides: false,
    image_alpha: 0,
    image_xscale: 1.5,
    image_yscale: 1.5,
    lifetime: 0,
    hitLimit: -1,
    duration: 110,
    hitCD: 40,
    angle: 0,
    radius: 90,
    projSpeed: 8,
    makeContinue: 6,
    startDirection: 0,
    stepDirection: 45,
    afterImageColor: 16711680,
    script: BLLoverBooks,
    maxLevel: 1,
    optionID: "BLLoverBooks",
    attackDamageID: "BLLover",
    optionType: "WeaponEffect"
}));

BLLover = function(arg0, arg1)
{
    var totalOnHitEffects = {};
    if (variable_struct_exists(arg0, "onHitEffects"))
    {
        variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
    }
    if (variable_struct_exists(obj_PlayerManager.perks, "Suicopath"))
    {
        variable_struct_set(totalOnHitEffects, "LifeSteal", 
        {
            chance: 10,
            heal: 3
        });
    }
    ExecuteAttack("BLLoverBooks", arg1, 
    {
        enhancements: arg0.enhancements,
        enhancements: arg0.enhancements,
        CritMod: arg0.CritMod,
        knockback: arg0.knockback,
        onHitEffects: totalOnHitEffects,
        gainedMods: arg0.gainedMods,
        applyWeaponSize: true
    }, true);
    ExecuteAttack("BLAxe", arg1, 
    {
        enhancements: arg0.enhancements,
        enhancements: arg0.enhancements,
        CritMod: arg0.CritMod,
        knockback: arg0.knockback,
        onHitEffects: totalOnHitEffects,
        gainedMods: arg0.gainedMods,
        applyWeaponSize: true
    }, true);
};

ds_map_set(attackIndex, "BLLover", new Attack("BLLover", defaultConfig, 
{
    attackTime: 110,
    minDelay: 110,
    duration: 2,
    onCreate: BLLover,
    maxLevel: 1,
    collides: false,
    splitCount: 8,
    optionType: "Collab",
    combos: ["BLBook", "PsychoAxe"],
    weaponType: "Melee",
    optionIcon: 1514,
    optionName: global.TextContainer.BLLoverName.selectedLanguage,
    optionDescription: global.TextContainer.BLLoverDescription.selectedLanguage[0],
    optionID: "BLLover",
    createdAttacks: ["BLLoverBooks", "BLAxe"]
}));

CookingPool = function(arg0, arg1)
{
    var lifetime2;
    if (instance_exists(arg0))
    {
        if (arg0.lifetime2 == 0)
        {
            var haachama = variable_struct_exists(obj_PlayerManager.perks, "StrongestIdol");
            arg0.damage = arg0.damage * (1 + (haachama * 0.15));
            arg0.emitter = part_emitter_create(global.psystem);
        }
        if (arg0.lifetime2 < 20)
        {
            if (arg0.currentSize < arg0.maxSize)
            {
                var elite = variable_struct_exists(obj_PlayerManager.perks, "Elite");
                arg0.currentSize += 0.1;
                arg0.image_xscale = arg0.currentSize + (elite * 0.1);
                arg0.image_yscale = arg0.currentSize + (elite * 0.1);
            }
        }
        arg0.lifetime2++;
        arg0.lifeTime += 0.05;
        arg0.image_alpha = 0.3 - (0.25 * (arg0.lifetime2 / 300));
        part_emitter_region(global.psystem, arg0.emitter, arg0.x - (50 * arg0.image_xscale), arg0.x + (50 * arg0.image_xscale), arg0.y - (50 * arg0.image_yscale), arg0.y + (50 * arg0.image_yscale), 1, 0);
        part_emitter_burst(global.psystem, arg0.emitter, global.partType1, 2 * arg0.image_xscale);
        if (arg0.lifetime2 >= 295)
        {
            part_emitter_destroy(global.psystem, arg0.emitter);
        }
    }
};

ds_map_set(attackIndex, "CookingPool", new Attack("CookingPool", defaultConfig, 
{
    sprite_index: spr_spidercooking,
    maxSize: 2,
    lifetime2: 0,
    currentSize: 0,
    image_xscale: 0,
    image_yscale: 0,
    attackTime: 150,
    hitLimit: -1,
    projSpeed: 0,
    drawBehind: true,
    drawUnderAll: true,
    hitCD: 30,
    stayOnCreator: false,
    image_alpha: 0,
    script: CookingPool,
    lifeTime: 0,
    duration: 300,
    targetRandom: true,
    drawBehind: true,
    attackDamageID: "EliteCooking",
    optionType: "WeaponEffect"
}));

EliteCooking = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.maxlifetime = 5 + floor(random(20));
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
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            arg0.hasCreated = true;
            ExecuteAttack("CookingPool", arg0.creator, 
            {
                damage: arg0.damage,
                enhancements: arg0.enhancements,
                x: arg0.x,
                y: arg0.y,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true
            }, true);
            arg0.duration = 5;
            arg0.visible = false;
        }
    }
};

ds_map_set(attackIndex, "EliteCooking", new Attack("EliteCooking", defaultConfig, 
{
    sprite_index: spr_EliteCooking,
    damage: 0.65,
    attackTime: 35,
    image_xscale: 0.9,
    image_yscale: 0.9,
    minDelay: 10,
    hitLimit: -1,
    projSpeed: 9,
    hitCD: 30,
    collides: false,
    script: EliteCooking,
    playSound: [263],
    soundPitch: true,
    duration: 70,
    splitCount: 6,
    targetRandom: true,
    destroyOnHitLimit: false,
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    maxlifetime: 5,
    range: 400,
    maxLevel: 1,
    optionIcon: 1249,
    weaponType: "Ranged",
    optionType: "Collab",
    combos: ["EliteLava", "SpiderCooking"],
    optionName: global.TextContainer.EliteCookingName.selectedLanguage,
    optionDescription: global.TextContainer.EliteCookingDescription.selectedLanguage[0],
    optionID: "EliteCooking"
}));
ds_map_set(attackIndex, "BreatheInAsacocoExplode", new Attack("BreatheInAsacocoExplode", defaultConfig, 
{
    sprite_index: spr_bombExplode,
    image_alpha: 0.7,
    collides: false,
    image_xscale: 3,
    iamge_yscale: 3,
    projSpeed: 0,
    hitLimit: -1,
    destroyOnHitLimit: false,
    timeline: 0,
    playSound: [48],
    soundChannel: "explode",
    soundPrio: 20,
    script: Explode,
    attackDamageID: "BreatheInAsacoco",
    optionType: "WeaponEffect"
}));

BreatheInAsacoco = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 60)
    {
        arg0.hspeed = -6 + random(12);
        arg0.vspeed = -10 - random(3);
        arg0.gravity = 0.5;
        arg0.spinRate = -10 + irandom(20);
    }
    arg0.lifetime--;
    arg0.image_angle += arg0.spinRate;
    if (arg0.lifetime < 1)
    {
        if (!arg0.hasCreated)
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            arg0.hasCreated = true;
            ExecuteAttack("BreatheInAsacocoExplode", arg0, 
            {
                damage: arg0.damage,
                enhancements: arg0.enhancements,
                hitCD: arg0.hitCD,
                image_xscale: arg0.sizeUp,
                image_yscale: arg0.sizeUp,
                starty: 20,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods
            }, true);
            if (arg0.hasCreated)
            {
                visible = false;
            }
        }
    }
};

function BreatheInAsacocoCollide()
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
                obj_AttackController.ExecuteAttack("BreatheInAsacocoExplode", id, 
                {
                    damage: damage,
                    enhancements: enhancements,
                    hitCD: hitCD,
                    image_xscale: sizeUp,
                    image_yscale: sizeUp,
                    starty: 20,
                    CritMod: CritMod,
                    knockback: knockback,
                    onHitEffects: totalOnHitEffects,
                    gainedMods: gainedMods
                }, true);
                if (hasCreated)
                {
                    visible = false;
                }
            }
        }
    };
}

ds_map_set(attackIndex, "BreatheInAsacoco", new Attack("BreatheInAsacoco", defaultConfig, 
{
    sprite_index: spr_BreatheAsacoco,
    damage: 2.4,
    attackTime: 45,
    hitLimit: -1,
    speed: 0,
    hitCD: 20,
    minDelay: 20,
    collides: true,
    spinRate: 0,
    script: BreatheInAsacoco,
    onCreate: BreatheInAsacocoCollide,
    duration: 60,
    destroyOnHitLimit: false,
    playSound: [274],
    soundPitch: true,
    hasCreated: false,
    lifetime: 60,
    attackCount: 5,
    attackDelay: 5,
    isEnemy: false,
    faceCreatorDirection: true,
    drawBehind: true,
    sizeUp: 2,
    starty: -16,
    maxLevel: 1,
    weaponType: "MultiShot",
    combos: ["HoloBomb", "Tailplug"],
    optionIcon: 196,
    optionType: "Collab",
    optionName: global.TextContainer.BreatheInAsacocoName.selectedLanguage,
    optionDescription: global.TextContainer.BreatheInAsacocoDescription.selectedLanguage[0],
    optionID: "BreatheInAsacoco"
}));

FlatBoard = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (variable_struct_exists(global.charSelected, "flat"))
        {
            arg0.damage *= 1.2;
            arg0.image_xscale *= 1.2;
            arg0.image_yscale *= 1.2;
        }
        arg0.image_alpha = 1;
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
            if (arg0.target != "noTarget")
            {
                arg0.determinedX = arg0.target.x;
                arg0.determinedY = arg0.target.y;
            }
            else
            {
                arg0.determinedX = (arg1.x - 200) + random(400);
                arg0.determinedY = (arg1.y - 150) + random(300);
            }
            arg0.x = arg0.determinedX;
            arg0.y = arg0.determinedY - 300;
            ds_list_destroy(targets);
            targets = -1;
        }
        arg0.collides = true;
        arg0.vspeed = 40;
    }
    if (arg0.y > arg0.determinedY)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        ExecuteAttack("BreatheInAsacocoExplode", arg0.creator, 
        {
            damage: 1,
            enhancements: arg0.enhancements,
            hitCD: 60,
            image_xscale: 2,
            image_yscale: 2,
            x: arg0.x,
            y: arg0.y,
            image_alpha: 0.5,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            attackDamageID: "FlatBoard"
        }, true);
        arg0.vspeed = 0;
        arg0.y = arg0.determinedY - 1;
        soundPlay([258], "explosion", 20, 30);
        arg0.depth += 1000;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "FlatBoard", new Attack("FlatBoard", defaultConfig, 
{
    sprite_index: spr_flatboard,
    image_alpha: 0,
    image_xscale: 1.5,
    image_yscale: 1.5,
    damage: 2.2,
    attackTime: 40,
    hitLimit: 10,
    speed: 0,
    hitCD: 120,
    minDelay: 10,
    determinedX: 0,
    determinedY: 0,
    collides: true,
    spinRate: 0,
    range: 200,
    attackCount: 2,
    script: FlatBoard,
    duration: 120,
    drawUnderAll: true,
    drawBehind: true,
    destroyOnHitLimit: false,
    playSound: [274],
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    maxLevel: 1,
    weaponType: "MultiShot",
    combos: ["HoloBomb", "CuttingBoard"],
    optionIcon: 860,
    optionType: "Collab",
    optionName: global.TextContainer.FlatBoardName.selectedLanguage,
    optionDescription: global.TextContainer.FlatBoardDescription.selectedLanguage[0],
    optionID: "FlatBoard"
}));

MiComet = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 1;
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
            if (arg0.target != "noTarget")
            {
                arg0.determinedX = arg0.target.x;
                arg0.determinedY = arg0.target.y;
            }
            else
            {
                arg0.determinedX = (arg1.x - 100) + random(200);
                arg0.determinedY = (arg1.y - 100) + random(200);
            }
            arg0.x = arg0.determinedX - 300;
            arg0.y = arg0.determinedY - 300;
            ds_list_destroy(targets);
            targets = -1;
        }
        arg0.collides = true;
        arg0.hspeed = 40;
        arg0.vspeed = 40;
    }
    arg0.lifetime++;
    if (arg0.y > arg0.determinedY)
    {
        var elite = variable_struct_exists(obj_PlayerManager.perks, "Elite");
        if (variable_struct_exists(obj_PlayerManager.perks, "Suicopath"))
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            variable_struct_set(totalOnHitEffects, "LifeSteal", 
            {
                chance: 10,
                heal: 3
            });
            ExecuteAttack("LavaPool", arg0.creator, 
            {
                damage: 1.75,
                enhancements: arg0.enhancements,
                hitCD: 30,
                ogDuration: 120,
                duration: 120,
                image_xscale: 3 + (elite * 0.1),
                image_yscale: 2.4 + (elite * 0.08),
                image_alpha: 0.7,
                x: arg0.x,
                y: arg0.y - 30,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true,
                attackDamageID: "MiComet",
                optionType: "WeaponEffect"
            }, true);
            var fx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
            fx.image_xscale = arg0.image_xscale;
            fx.image_yscale = arg0.image_yscale;
            fx.image_alpha = 0.8;
            fx.sprite_index = spr_MiCometSplash;
            arg0.vspeed = 0;
            arg0.hspeed = 0;
            arg0.y = arg0.determinedY - 1;
            arg0.depth += 1000;
        }
        else
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            ExecuteAttack("LavaPool", arg0.creator, 
            {
                damage: 1.75,
                enhancements: arg0.enhancements,
                hitCD: 30,
                ogDuration: 120,
                duration: 120,
                image_xscale: 3 + (elite * 0.1),
                image_yscale: 2.4 + (elite * 0.08),
                image_alpha: 0.7,
                x: arg0.x,
                y: arg0.y - 30,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                attackDamageID: "MiComet",
                applyWeaponSize: true,
                optionType: "WeaponEffect"
            }, true);
            var fx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
            fx.image_xscale = arg0.image_xscale;
            fx.image_yscale = arg0.image_yscale;
            fx.image_alpha = 0.8;
            fx.sprite_index = spr_MiCometSplash;
            arg0.vspeed = 0;
            arg0.hspeed = 0;
            arg0.y = arg0.determinedY - 1;
            arg0.depth += 1000;
        }
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "MiComet", new Attack("MiComet", defaultConfig, 
{
    sprite_index: spr_MiComet,
    image_alpha: 0,
    image_xscale: 2,
    image_yscale: 2,
    damage: 3,
    attackTime: 60,
    hitLimit: -1,
    speed: 0,
    hitCD: 60,
    determinedX: 0,
    determinedY: 0,
    collides: true,
    spinRate: 0,
    range: 150,
    minDelay: 5,
    script: MiComet,
    duration: 120,
    drawBehind: true,
    destroyOnHitLimit: false,
    playSound: [28],
    soundChannel: "Comet",
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    maxLevel: 1,
    combos: ["EliteLava", "PsychoAxe"],
    optionIcon: 1615,
    weaponType: "Ranged",
    optionType: "Collab",
    optionName: global.TextContainer.MiCometName.selectedLanguage,
    optionDescription: global.TextContainer.MiCometDescription.selectedLanguage[0],
    optionID: "MiComet"
}));

DragonBeam = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 1)
    {
        arg0.x += -5 + random(10);
        arg0.y += -5 + random(10);
        arg0.speed = 15 + random(10);
        arg0.direction += -8 + random(16);
        arg0.image_angle = arg0.direction;
        arg0.collides = true;
        arg0.image_alpha = 0.8;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "DragonBeam", new Attack("DragonBeam", defaultConfig, 
{
    sprite_index: spr_DragonFire,
    damage: 0.5,
    collides: false,
    attackTime: 3,
    hitCD: 15,
    speed: 15,
    minDelay: 3,
    hitLimit: 4,
    afterImageColor: 4235519,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0,
    script: DragonBeam,
    lifetime: 0,
    knockback: 
    {
        duration: 3,
        speed: 1
    },
    playSound: [275],
    soundCD: 10,
    soundPitch: true,
    stayOnCreator: false,
    duration: 20,
    destroyOnHitLimit: true,
    maxLevel: 1,
    attackCount: 4,
    optionIcon: 1300,
    faceCreatorDirection: true,
    weaponType: "MultiShot",
    optionType: "Collab",
    combos: ["Tailplug", "HoloLaser"],
    optionName: global.TextContainer.DragonBeamName.selectedLanguage,
    optionDescription: global.TextContainer.DragonBeamDescription.selectedLanguage[0],
    optionID: "DragonBeam"
}));

RapDogExplod = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
    }
    arg0.lifetime++;
    arg0.image_alpha -= 0.05;
    if (arg0.image_alpha < 0.4)
    {
        arg0.collides = false;
    }
    if (arg0.image_alpha < 0)
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "RapDogExplod", new Attack("RapDogExplod", defaultConfig, 
{
    sprite_index: spr_GlowStickExplode,
    damage: 4,
    image_xscale: 0.2,
    image_yscale: 0.2,
    image_alpha: 0.7,
    attackTime: 0,
    hitCD: 60,
    hitLimit: -1,
    lifetime: 0,
    duration: 15,
    playSound: [131],
    script: RapDogExplod,
    attackDamageID: "RapDog",
    destroyOnHitLimit: false,
    onHitEffects: 
    {
        Vulnerability2: 
        {
            amount: 20
        }
    },
    optionType: "WeaponEffect"
}));

RapDog = function(arg0, arg1)
{
    var bounceCD;
    arg0.image_angle += 10;
    if (arg0.x < camera_get_view_x(view_camera[0]))
    {
        if (arg0.bounceCD == 0)
        {
            arg0.bounced = true;
        }
        arg0.direction += 60 - irandom(120);
        arg0.hspeed = abs(arg0.hspeed);
    }
    if (arg0.x > (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])))
    {
        if (arg0.bounceCD == 0)
        {
            arg0.bounced = true;
        }
        arg0.direction += 60 - irandom(120);
        arg0.hspeed = -abs(arg0.hspeed);
    }
    if (arg0.y < camera_get_view_y(view_camera[0]))
    {
        if (arg0.bounceCD == 0)
        {
            arg0.bounced = true;
        }
        arg0.direction += 60 - irandom(120);
        arg0.vspeed = abs(arg0.vspeed);
    }
    if (arg0.y > (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])))
    {
        if (arg0.bounceCD == 0)
        {
            arg0.bounced = true;
        }
        arg0.direction += 60 - irandom(120);
        arg0.vspeed = -abs(arg0.vspeed);
    }
    if (arg0.bounceCD > 0)
    {
        arg0.bounceCD--;
    }
    if (arg0.bounced)
    {
        arg0.bounced = false;
        arg0.bounceCD = 10;
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        variable_struct_set(totalOnHitEffects, "Vulnerability2", 
        {
            amount: 15
        });
        obj_AttackController.ExecuteAttack("RapDogExplod", arg0.creator, 
        {
            damage: arg0.damage * 1.3,
            enhancements: arg0.enhancements,
            image_xscale: arg0.image_xscale * 1.2,
            image_yscale: arg0.image_yscale * 1.2,
            sprite_index: spr_Ame_bubbabark,
            x: arg0.x,
            y: arg0.y,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods
        }, true);
    }
};

ds_map_set(attackIndex, "RapDog", new Attack("RapDog", defaultConfig, 
{
    sprite_index: spr_RapDog,
    damage: 1,
    attackTime: 35,
    hitCD: 15,
    speed: 10,
    hitLimit: -1,
    afterImageColor: 4235519,
    image_xscale: 1.75,
    image_yscale: 1.75,
    script: RapDog,
    lifetime: 0,
    playSound: [131],
    soundCD: 20,
    soundPitch: true,
    stayOnCreator: false,
    duration: 150,
    bounced: false,
    bounceCD: 0,
    destroyOnHitLimit: false,
    maxLevel: 1,
    optionIcon: 1585,
    faceCreatorDirection: true,
    weaponType: "Ranged",
    optionType: "Collab",
    combos: ["XPotato", "IdolSong"],
    optionName: global.TextContainer.RapDogName.selectedLanguage,
    optionDescription: global.TextContainer.RapDogDescription.selectedLanguage[0],
    optionID: "RapDog"
}));

MLIcicle = function(arg0, arg1)
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
            if (ds_list_find_value(targets, randomIndex).isEnemy)
            {
                arg0.target = ds_list_find_value(targets, randomIndex);
            }
        }
        else if (ds_list_find_value(targets, randomIndex).isEnemy)
        {
            arg0.target = ds_list_find_value(targets, 0);
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    if (arg0.times > 1)
    {
        arg0.collides = true;
        arg0.speed = arg0.projSpeed;
    }
    else
    {
        arg0.image_angle = arg0.direction;
        arg0.image_alpha = 1;
        if (arg0.times < 1)
        {
            arg0.y -= 0.5 * (12 - arg0.times);
        }
        if (arg0.target != "noTarget" && instance_exists(arg0.target))
        {
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
        }
        arg0.times++;
    }
};

ds_map_set(attackIndex, "MLIcicle", new Attack("MLIcicle", defaultConfig, 
{
    sprite_index: spr_Icicle,
    image_alpha: 0,
    attackTime: 150,
    damage: 0.7,
    hitLimit: 7,
    projSpeed: 20,
    hitCD: 15,
    playSound: [291],
    soundPrio: 1,
    soundCD: 8,
    destroyOnHitLimit: true,
    faceCreatorDirection: true,
    duration: 25,
    targetRandom: true,
    times: 0,
    script: MLIcicle,
    collides: false,
    afterImageColor: 16711680,
    attackDamageID: "MariLamy",
    onHitEffects: 
    {
        IceSlow: {}
    },
    optionType: "WeaponEffect"
}));

MariLamy = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 1;
        arg0.collides = true;
    }
    if ((arg0.lifetime % 8) == 0)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        variable_struct_set(totalOnHitEffects, "IceSlow", {});
        ExecuteAttack("MLIcicle", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: arg0.x,
            y: arg0.y,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods
        }, true);
    }
    arg0.x = arg1.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg1.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.angle += arg0.projSpeed;
    arg0.image_angle = 0;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MariLamy", new Attack("MariLamy", defaultConfig, 
{
    sprite_index: spr_MariLamyBook,
    damage: 0.25,
    attackTime: 110,
    collides: false,
    image_alpha: 0,
    image_xscale: 1.3,
    image_yscale: 1.3,
    lifetime: 0,
    hitLimit: -1,
    duration: 110,
    minDelay: 110,
    hitCD: 40,
    angle: 0,
    attackCount: 5,
    radius: 75,
    projSpeed: 6,
    startDirection: 0,
    stepDirection: 72,
    afterImageColor: 16711680,
    script: MariLamy,
    maxLevel: 1,
    weaponType: "MultiShot",
    optionIcon: 2272,
    optionType: "Collab",
    combos: ["BLBook", "WamyWater"],
    optionName: global.TextContainer.MariLamyName.selectedLanguage,
    optionDescription: global.TextContainer.MariLamyDescription.selectedLanguage[0],
    optionID: "MariLamy"
}));

BrokenDreamsTears = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        var haachama = variable_struct_exists(obj_PlayerManager.perks, "StrongestIdol");
        arg0.damage = arg0.damage * (1 + (haachama * 0.15));
    }
    if (arg0.y > arg0.setY)
    {
        arg0.y = arg0.setY;
        arg0.speed = 0;
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 1, obj_vfx);
        vfx.sprite_index = spr_RainFloor;
        with (arg0)
        {
            instance_destroy();
        }
    }
    if (instance_exists(arg0))
    {
        arg0.lifetime++;
    }
};

ds_map_set(attackIndex, "BrokenDreamsTears", new Attack("BrokenDreamsTears", defaultConfig, 
{
    sprite_index: spr_CEOTears,
    attackTime: 150,
    damage: 1.2,
    hitLimit: 5,
    speed: 30,
    script: BrokenDreamsTears,
    image_xscale: 1.5,
    image_yscale: 1.5,
    image_angle: 300,
    attackDamageID: "BrokenDreams",
    hitCD: 30,
    direction: 300,
    duration: 40,
    setY: 0,
    lifetime: 0,
    optionType: "WeaponEffect"
}));

BrokenDreams = function(arg0, arg1)
{
    var lifetime;
    if (!audio_is_playing(snd_rain))
    {
        audio_play_sound(snd_rain, 99, true);
    }
    if ((arg0.lifetime % 8) == 0)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            variable_struct_remove(totalOnHitEffects, "IceSlow");
        }
        ExecuteAttack("BrokenDreamsTears", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: (arg1.x - 450) + irandom(640),
            y: arg1.y - 200 - irandom(100),
            setY: (arg1.y - 150) + irandom(300),
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        ExecuteAttack("BrokenDreamsTears", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: (arg1.x - 450) + irandom(640),
            y: arg1.y - 200 - irandom(100),
            setY: (arg1.y - 150) + irandom(300),
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        ExecuteAttack("BrokenDreamsTears", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: (arg1.x - 450) + irandom(640),
            y: arg1.y - 200 - irandom(100),
            setY: (arg1.y - 150) + irandom(300),
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        ExecuteAttack("BrokenDreamsTears", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: (arg1.x - 450) + irandom(640),
            y: arg1.y - 200 - irandom(100),
            setY: (arg1.y - 150) + irandom(300),
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        ExecuteAttack("BrokenDreamsTears", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: (arg1.x - 450) + irandom(640),
            y: arg1.y - 200 - irandom(100),
            setY: (arg1.y - 150) + irandom(300),
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        ExecuteAttack("BrokenDreamsTears", arg0.creator, 
        {
            enhancements: arg0.enhancements,
            x: (arg1.x - 450) + irandom(640),
            y: arg1.y - 200 - irandom(100),
            setY: (arg1.y - 150) + irandom(300),
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        var extraProj = 0;
        if (variable_instance_exists(arg0, "extraProj"))
        {
            extraProj = arg0.extraProj;
        }
        var extraTears = arg1.bonusProjectiles + extraProj;
        while (extraTears > 0)
        {
            ExecuteAttack("BrokenDreamsTears", arg0.creator, 
            {
                enhancements: arg0.enhancements,
                x: (arg1.x - 450) + irandom(640),
                y: arg1.y - 200 - irandom(100),
                setY: (arg1.y - 150) + irandom(300),
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true
            }, true);
            extraTears--;
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "BrokenDreams", new Attack("BrokenDreams", defaultConfig, 
{
    sprite_index: spr_BrokenDreams,
    damage: 1,
    attackTime: 120,
    image_xscale: 1.3,
    image_yscale: 1.3,
    image_alpha: 0.8,
    lifetime: 0,
    hitLimit: -1,
    duration: 120,
    minDelay: 10,
    hitCD: 40,
    maxAttackCount: 1,
    script: BrokenDreams,
    stayOnCreator: true,
    maxLevel: 1,
    splitCount: 6,
    weaponType: "MultiShot",
    optionIcon: 214,
    optionType: "Collab",
    combos: ["CEOTears", "SpiderCooking"],
    optionName: global.TextContainer.BrokenDreamsName.selectedLanguage,
    optionDescription: global.TextContainer.BrokenDreamsDescription.selectedLanguage[0],
    optionID: "BrokenDreams",
    onHitEffects: 
    {
        IceSlow: {}
    }
}));

StreamOfTears = function(arg0, arg1)
{
    var lifetime;
    arg0.direction += 2;
    arg0.image_angle = arg0.direction;
    arg0.lifetime++;
    soundPlay([235], "tears", 5, 10, false);
};

ds_map_set(attackIndex, "StreamOfTears", new Attack("StreamOfTears", defaultConfig, 
{
    sprite_index: spr_StreamTears,
    damage: 2.75,
    attackTime: 360,
    image_xscale: 1.3,
    image_yscale: 4,
    image_alpha: 0.3,
    transparent: true,
    lifetime: 0,
    hitLimit: -1,
    duration: 360,
    minDelay: 360,
    hitCD: 30,
    attackCount: 2,
    stepDirection: 180,
    startDirection: 0,
    script: StreamOfTears,
    stayOnCreator: true,
    maxLevel: 1,
    optionIcon: 1008,
    weaponType: "Ranged",
    optionType: "Collab",
    combos: ["CEOTears", "HoloLaser"],
    optionName: global.TextContainer.StreamOfTearsName.selectedLanguage,
    optionDescription: global.TextContainer.StreamOfTearsDescription.selectedLanguage[0],
    optionID: "StreamOfTears",
    knockback: 
    {
        duration: 10,
        speed: 7
    }
}));

AbsoluteWallInit = function(arg0, arg1)
{
    arg0.angle = arg1.direction + (arg0.countID * 90);
    if (variable_struct_exists(global.charSelected, "flat"))
    {
        arg0.damage *= 1.2;
        arg0.image_xscale *= 1.2;
        arg0.image_yscale *= 1.2;
    }
    arg0.x = arg1.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg1.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction + 180) * pi) / 180));
    arg0.image_angle = arg0.angle;
    arg0.image_alpha = 0.8;
};

AbsoluteWall = function(arg0, arg1)
{
    var lifetime;
    var directionDifference = angle_difference(arg1.direction + (arg0.countID * 90), arg0.angle);
    arg0.angle += min(abs(directionDifference), arg0.changeSpeed) * sign(directionDifference);
    arg0.image_angle = arg0.angle;
    arg0.x = arg1.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg1.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction + 180) * pi) / 180));
    arg0.lifetime++;
};

ds_map_set(attackIndex, "AbsoluteWall", new Attack("AbsoluteWall", defaultConfig, 
{
    sprite_index: spr_CuttingBoard,
    damage: 2,
    attackTime: 600,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0,
    angle: 0,
    transparent: true,
    lifetime: 0,
    hitLimit: -1,
    duration: 600,
    eraseAttacks: true,
    eraseChance: 10,
    radius: 80,
    changeSpeed: 15,
    minDelay: 600,
    hitCD: 30,
    attackCount: 4,
    onCreate: AbsoluteWallInit,
    script: AbsoluteWall,
    stayOnCreator: true,
    maxLevel: 1,
    optionIcon: 1160,
    weaponType: "Melee",
    optionType: "Collab",
    combos: ["CuttingBoard", "BounceBall"],
    optionName: global.TextContainer.AbsoluteWallName.selectedLanguage,
    optionDescription: global.TextContainer.AbsoluteWallDescription.selectedLanguage[0],
    optionID: "AbsoluteWall",
    afterImageColor: 16711680,
    knockback: 
    {
        duration: 15,
        speed: 16
    }
}));

RingOfFitnessBalls = function(arg0, arg1)
{
    arg0.image_xscale = 0.6 + (global.charSelected.sizeGrade * 0.1 * arg1.weaponSizeMultiplier);
    arg0.image_yscale = 0.6 + (global.charSelected.sizeGrade * 0.1 * arg1.weaponSizeMultiplier);
};

ds_map_set(attackIndex, "RingOfFitness", new Attack("RingOfFitness", defaultConfig, 
{
    sprite_index: spr_BounceBall,
    damage: 2,
    attackTime: 75,
    image_xscale: 0.5,
    image_yscale: 0.5,
    image_alpha: 0.9,
    lifetime: 0,
    hitLimit: 1,
    duration: 120,
    deflects: 10,
    onDeflect: 
    {
        Script: function(arg0, arg1)
        {
            arg0.direction += 60 + random(120);
        },
        
        config: {}
    },
    minDelay: 10,
    onCreate: RingOfFitnessBalls,
    hitCD: 30,
    attackCount: 15,
    speed: 10,
    stepDirection: 18,
    startDirection: 0,
    stayOnCreator: false,
    faceCreatorDirection: true,
    maxLevel: 1,
    optionIcon: 1391,
    weaponType: "MultiShot",
    projOrientation: "circle",
    destroyOnHitLimit: true,
    optionType: "Collab",
    combos: ["BounceBall", "CEOTears"],
    optionName: global.TextContainer.RingOfFitnessName.selectedLanguage,
    optionDescription: global.TextContainer.RingOfFitnessDescription.selectedLanguage[0],
    optionID: "RingOfFitness"
}));

BoneBrosAttack = function(arg0, arg1)
{
    arg0.image_angle = arg0.direction;
};

ds_map_set(attackIndex, "BoneBrosSlash", new Attack("BoneBrosSlash", defaultConfig, 
{
    sprite_index: spr_BoneBrosSlash,
    attackTime: 150,
    damage: 1.25,
    hitLimit: 10,
    image_xscale: 1.5,
    image_yscale: 1.5,
    speed: 15,
    hitCD: 30,
    playSound: [114],
    soundChannel: "bonebrosslash",
    attackDamageID: "BoneBros",
    soundPitch: true,
    onCreate: BoneBrosAttack,
    duration: 30,
    lifetime: 0,
    afterImageColor: 255,
    optionType: "WeaponEffect"
}));
ds_map_set(attackIndex, "BoneBrosBullet", new Attack("BoneBrosSlash", defaultConfig, 
{
    sprite_index: spr_Ame_bullet,
    attackTime: 150,
    damage: 1,
    hitLimit: 5,
    speed: 30,
    image_xscale: 1.25,
    image_yscale: 1.25,
    speed: 15,
    hitCD: 30,
    playSound: [125],
    soundChannel: "bonebrosbullet",
    attackDamageID: "BoneBros",
    soundPitch: true,
    onCreate: BoneBrosAttack,
    duration: 30,
    destroyOnHitLimit: true,
    lifetime: 0,
    afterImageColor: 16711680,
    optionType: "WeaponEffect"
}));

BoneBros = function(arg0, arg1)
{
    var extraProj, lifetime;
    if (arg0.lifetime == 0)
    {
        if (variable_instance_exists(arg0, "extraProj"))
        {
            arg0.extraProj += arg1.bonusProjectiles;
        }
        else
        {
            arg0.extraProj = arg1.bonusProjectiles;
        }
    }
    if ((arg0.lifetime % 5) == 0)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        obj_AttackController.ExecuteAttack("BoneBrosSlash", arg1, 
        {
            damage: arg0.damage * 1.3,
            direction: (arg1.direction - 30) + irandom(60),
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        if (variable_instance_exists(arg0, "extraProj") && arg0.extraProj > 0)
        {
            obj_AttackController.ExecuteAttack("BoneBrosSlash", arg1, 
            {
                damage: arg0.damage * 1.3,
                direction: (arg1.direction - 30) + irandom(60),
                enhancements: arg0.enhancements,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true
            }, true);
            arg0.extraProj--;
        }
    }
    if ((arg0.lifetime % 3) == 0)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        obj_AttackController.ExecuteAttack("BoneBrosBullet", arg1, 
        {
            damage: arg0.damage * 1.1,
            direction: ((arg1.direction - 15) + irandom(30)) - 180,
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            applyWeaponSize: true
        }, true);
        if (variable_instance_exists(arg0, "extraProj") && arg0.extraProj > 0)
        {
            obj_AttackController.ExecuteAttack("BoneBrosBullet", arg1, 
            {
                damage: arg0.damage * 1.1,
                direction: ((arg1.direction - 15) + irandom(30)) - 180,
                enhancements: arg0.enhancements,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true
            }, true);
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "BoneBros", new Attack("BoneBros", defaultConfig, 
{
    damage: 1,
    attackTime: 60,
    image_xscale: 0.75,
    image_yscale: 0.75,
    image_alpha: 0.9,
    lifetime: 0,
    hitLimit: 1,
    duration: 30,
    minDelay: 20,
    hitCD: 30,
    attackCount: 1,
    maxAttackCount: 1,
    splitCount: 6,
    stepDirection: 18,
    startDirection: 0,
    stayOnCreator: false,
    maxLevel: 1,
    optionIcon: 775,
    script: BoneBros,
    weaponType: "MultiShot",
    projOrientation: "frontSpread",
    optionType: "Collab",
    combos: ["CuttingBoard", "ENCurse"],
    optionName: global.TextContainer.BoneBrosName.selectedLanguage,
    optionDescription: global.TextContainer.BoneBrosDescription.selectedLanguage[0],
    optionID: "BoneBros"
}));

MiKoroneCreate = function(arg0, arg1)
{
    var elite = variable_struct_exists(obj_PlayerManager.perks, "Elite");
    arg0.image_xscale = (2 + (elite * 0.1)) * arg1.weaponSizeMultiplier;
    arg0.image_yscale = (2 + (elite * 0.1)) * arg1.weaponSizeMultiplier;
    arg0.x = (arg1.x + 450) - irandom(640);
    arg0.y = arg1.y - 200 - irandom(100);
    arg0.setY = arg1.y + 200;
    var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth + 20, obj_vfx);
    vfx.sprite_index = spr_DragonFire;
    vfx.image_xscale = arg0.image_xscale;
    vfx.image_yscale = arg0.image_yscale;
    vfx.duration = 120;
    vfx.add = true;
    vfx.followCharacter = arg0;
    vfx.followAngle = arg0.direction;
    vfx.image_alpha = 0.6;
};

MiKorone = function(arg0, arg1)
{
    var lifetime;
    arg0.lifetime++;
    if (arg0.y > arg0.setY)
    {
        arg0.y = arg0.setY;
        arg0.speed = 0;
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "MiKorone", new Attack("MiKorone", defaultConfig, 
{
    sprite_index: spr_XPotato,
    attackTime: 150,
    damage: 2,
    hitLimit: 1,
    destroyOnHitLimit: true,
    speed: 20,
    onCreate: MiKoroneCreate,
    script: MiKorone,
    image_xscale: 2,
    image_yscale: 2,
    image_angle: 300,
    hitCD: 30,
    direction: 240,
    duration: 180,
    minDelay: 10,
    setY: 0,
    playSound: [190],
    lifetime: 0,
    attackCount: 5,
    attackDelay: 7,
    maxLevel: 1,
    minDelay: 30,
    onHitEffects: 
    {
        MiKoroneHit: {}
    },
    optionIcon: 536,
    script: MiKorone,
    weaponType: "MultiShot",
    projOrientation: "frontSpread",
    optionType: "Collab",
    combos: ["EliteLava", "XPotato"],
    optionName: global.TextContainer.MiKoroneName.selectedLanguage,
    optionDescription: global.TextContainer.MiKoroneDescription.selectedLanguage[0],
    optionID: "MiKorone"
}));

ImDieExplode = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_Cam.ExecuteShake(80, 3);
        arg0.image_alpha = 0.6;
        arg0.collides = true;
        arg0.image_xscale = 0.01;
        arg0.image_yscale = 0.01;
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 1, obj_vfx);
        vfx.sprite_index = spr_bombExplode;
        vfx.image_xscale = 5;
        vfx.image_yscale = 5;
        vfx.image_alpha = 0.7;
    }
    if (arg0.lifetime > 20)
    {
        arg0.image_alpha -= 0.01;
    }
    arg0.lifetime++;
    arg0.spriteColor = 4235519;
    arg0.image_xscale += 0.05;
    arg0.image_yscale += 0.05;
};

ds_map_set(attackIndex, "ImDieExplode", new Attack("ImDieExplode", defaultConfig, 
{
    damage: 3,
    collides: false,
    sprite_index: spr_ImDieExplosion,
    attackTime: 300,
    attackCount: 1,
    hitLimit: -1,
    hitCD: 30,
    duration: 95,
    soundPitch: true,
    playSound: [0],
    soundChannel: "ImDie",
    attackDamageID: "ImDie",
    lifetime: 0,
    transparent: true,
    image_alpha: 0,
    knockback: 
    {
        duration: 10,
        speed: 10
    },
    script: ImDieExplode,
    optionType: "WeaponEffect"
}));

ImDie = function(arg0, arg1)
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
    arg0.image_angle = 0;
    arg0.lifetime--;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "ImDie", new Attack("ImDie", defaultConfig, 
{
    sprite_index: spr_ImDieBomb,
    damage: 1,
    attackTime: 180,
    lifetime: 0,
    hitLimit: 1,
    duration: 300,
    minDelay: 60,
    image_xscale: 1.5,
    image_yscale: 1.5,
    hitCD: 30,
    speed: 15,
    destroyOnHitLimit: true,
    script: ImDie,
    onHitEffects: 
    {
        ImDieBomb: {}
    },
    faceCreatorDirection: true,
    stayOnCreator: false,
    playSound: [263],
    maxLevel: 1,
    optionIcon: 904,
    weaponType: "Ranged",
    optionType: "Collab",
    combos: ["XPotato", "HoloBomb"],
    optionName: global.TextContainer.ImDieName.selectedLanguage,
    optionDescription: global.TextContainer.ImDieDescription.selectedLanguage[0],
    optionID: "ImDie"
}));

SnowSakeExplode = function(arg0, arg1)
{
    var lifetime;
    arg0.image_xscale = 0.5 * logn(1.5, arg0.lifetime + 1) * arg1.weaponSizeMultiplier;
    arg0.image_yscale = 0.5 * logn(1.5, arg0.lifetime + 1) * arg1.weaponSizeMultiplier;
    arg0.image_alpha -= 0.04;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "SnowSakeExplode", new Attack("SnowSakeExplode", defaultConfig, 
{
    damage: 3,
    collides: true,
    sprite_index: spr_SnowSakeFlake,
    attackTime: 360,
    attackCount: 1,
    hitLimit: -1,
    hitCD: 30,
    duration: 30,
    soundPitch: true,
    playSound: [282],
    soundChannel: "SnowSake",
    attackDamageID: "SnowSake",
    lifetime: 0,
    transparent: true,
    image_alpha: 1,
    script: SnowSakeExplode,
    optionType: "WeaponEffect"
}));

SnowSake = function(arg0, arg1)
{
    var lifetime;
    if (arg0.speed > 0)
    {
        arg0.speed -= 0.3;
    }
    if (arg0.lifetime == 30)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        totalOnHitEffects.Frozen = 
        {
            chance: 30,
            time: 120,
            attackID: "SnowSake"
        };
        obj_AttackController.ExecuteAttack("SnowSakeExplode", arg1, 
        {
            x: arg0.x,
            y: arg0.y,
            damage: arg0.damage * 2,
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods
        }, true);
    }
    arg0.lifetime++;
    arg0.image_angle -= 5;
};

ds_map_set(attackIndex, "SnowSake", new Attack("SnowSake", defaultConfig, 
{
    sprite_index: spr_SnowSakeBottle,
    damage: 2,
    attackTime: 200,
    lifetime: 0,
    hitLimit: -1,
    duration: 31,
    minDelay: 60,
    image_xscale: 1,
    image_yscale: 1,
    hitCD: 30,
    attackCount: 3,
    attackDelay: 10,
    stepDirection: 120,
    speed: 10,
    destroyOnHitLimit: true,
    script: SnowSake,
    faceCreatorDirection: true,
    stayOnCreator: false,
    afterImageColor: 16711680,
    playSound: [263],
    maxLevel: 1,
    optionIcon: 2379,
    projOrientation: "circle",
    weaponType: "MultiShot",
    optionType: "Collab",
    combos: ["WamyWater", "Glowstick"],
    optionName: global.TextContainer.SnowSakeName.selectedLanguage,
    optionDescription: global.TextContainer.SnowSakeDescription.selectedLanguage[0],
    optionID: "SnowSake"
}));

function EldritchHorrorCreate()
{
    scale = image_xscale;
    image_xscale = 0;
    image_yscale = 0;
    var haachama = variable_struct_exists(obj_PlayerManager.perks, "StrongestIdol");
    damage *= (1 + (haachama * 0.15));
    var randomPos = obj_MobManager.FindTargetInRange(
    {
        x: creator.x,
        y: creator.y
    }, 367, 170);
    x = randomPos.x;
    y = randomPos.y;
    
    OnCollideWithTarget = function(arg0)
    {
        if (collides)
        {
            HitTarget(arg0);
        }
    };
}

EldritchHorror = function(arg0, arg1)
{
    var lifetime;
    if ((arg0.lifetime % 5) == 0 && arg0.lifetime > 10 && arg0.duration > 30)
    {
        var randDir = irandom(359);
        var randX = -175 + ((irandom(350) * arg0.scale) / 3.5);
        var randY = -120 + ((irandom(240) * arg0.scale) / 3.5);
        var randomX = lengthdir_x(randX, randDir);
        var randomY = lengthdir_y(randY, randDir);
        var fx = instance_create_depth(arg0.x + randomX, arg0.y + randomY, arg0.depth - 10, obj_vfx);
        fx.sprite_index = arg0.randomFX[irandom(3)];
        fx.image_xscale = arg0.image_xscale * (-1 + (irandom(1) * 2));
        fx.image_yscale = arg0.image_yscale;
        fx.image_alpha = 1;
    }
    if ((arg0.lifetime % 2) == 0 && arg0.duration > 80)
    {
        var randDir = irandom(359);
        var randX = -175 + ((irandom(350) * arg0.scale) / 3.5);
        var randY = -120 + ((irandom(240) * arg0.scale) / 3.5);
        var randomX = lengthdir_x(randX, randDir);
        var randomY = lengthdir_y(randY, randDir);
        var fx = instance_create_depth(arg0.x + randomX, arg0.y + randomY, arg0.depth - 10, obj_vfx);
        fx.sprite_index = spr_EldritchSmoke;
        fx.image_speed = 0;
        fx.image_index = irandom(2);
        fx.hspeed = -1 + random(2);
        fx.image_xscale = 2 * (-1 + (irandom(1) * 2));
        fx.image_yscale = 2;
        fx.image_alpha = 0.7;
        fx.alarm[1] = 70;
        fx.duration = 90;
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    if (arg0.lifetime < 10)
    {
        arg0.image_xscale += 0.1 * arg0.scale;
        arg0.image_yscale += 0.1 * arg0.scale;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "EldritchHorror", new Attack("EldritchHorror", defaultConfig, 
{
    collides: true,
    damage: 2.8,
    sprite_index: spr_EldrichHorrorPool,
    image_xscale: 3.5,
    image_yscale: 3.5,
    attackTime: 390,
    attackCount: 1,
    duration: 240,
    hitLimit: -1,
    hitCD: 20,
    minDelay: 120,
    randomFX: [1752, 1433, 1557, 697],
    drawBehind: true,
    playSound: [70],
    soundChannel: "horror",
    soundPitch: true,
    scale: 1,
    script: EldritchHorror,
    onCreate: EldritchHorrorCreate,
    range: 180,
    height: 64,
    lifetime: 0,
    drawUnderAll: true,
    onHitEffects: 
    {
        eldritchHorror: 
        {
            chance: 30,
            heal: 0.07
        }
    },
    maxLevel: 1,
    optionIcon: 983,
    projOrientation: "circle",
    weaponType: "Ranged",
    optionType: "Collab",
    combos: ["ENCurse", "SpiderCooking"],
    optionName: global.TextContainer.EldritchHorrorName.selectedLanguage,
    optionDescription: global.TextContainer.EldritchHorrorDescription.selectedLanguage[0],
    optionID: "EldritchHorror"
}));

LegendarySausage = function(arg0, arg1)
{
    var lifetime;
    if (arg1.isMoving)
    {
        if (arg0.extraSpeed < 30)
        {
            arg0.extraSpeed += 0.25;
        }
    }
    else if (arg0.extraSpeed > 0)
    {
        arg0.extraSpeed -= 0.2;
    }
    arg0.direction -= 2 + arg0.extraSpeed;
    arg0.image_angle = arg0.direction;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "LegendarySausage", new Attack("LegendarySausage", defaultConfig, 
{
    collides: true,
    damage: 3,
    sprite_index: spr_LegendarySausage,
    image_xscale: 2,
    image_yscale: 2,
    attackTime: 400,
    attackCount: 1,
    duration: 240,
    hitLimit: -1,
    extraSpeed: 0,
    hitCD: 10,
    minDelay: 240,
    soundPitch: true,
    script: LegendarySausage,
    range: 180,
    height: 64,
    lifetime: 0,
    stayOnCreator: true,
    afterImageColor: 16711680,
    knockback: 
    {
        duration: 4,
        speed: 4
    },
    maxLevel: 1,
    optionIcon: 495,
    projOrientation: "circle",
    weaponType: "Melee",
    optionType: "Collab",
    combos: ["Sausage", "BLBook"],
    optionName: global.TextContainer.LegendarySausageName.selectedLanguage,
    optionDescription: global.TextContainer.LegendarySausageDescription.selectedLanguage[0],
    optionID: "LegendarySausage"
}));

FallingStar = function(arg0, arg1)
{
    var lifetime;
    arg0.image_angle += 10;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "FallingStar", new Attack("FallingStar", defaultConfig, 
{
    damage: 0.75,
    collides: true,
    sprite_index: spr_StarHalberdStar,
    attackTime: 360,
    attackCount: 1,
    hitLimit: 5,
    hitCD: 30,
    duration: 60,
    destroyOnHitLimit: true,
    soundPitch: true,
    playSound: [81],
    soundChannel: "FallingStar",
    soundCD: 20,
    attackDamageID: "StarHalberd",
    lifetime: 0,
    direction: 315,
    speed: 15,
    image_alpha: 1,
    afterImageColor: 65535,
    script: FallingStar,
    optionType: "WeaponEffect"
}));

StarHalberd = function(arg0, arg1)
{
    arg0.image_angle = arg0.direction;
    arg0.direction -= arg0.swingSpeed;
};

ds_map_set(attackIndex, "StarHalberd", new Attack("StarHalberd", defaultConfig, 
{
    stayOnCreator: true,
    faceCreatorDirection: true,
    attackTime: 90,
    damage: 2.5,
    hitLimit: -1,
    collides: true,
    isMelee: true,
    image_alpha: 1,
    sprite_index: spr_StarHalberd,
    script: StarHalberd,
    image_xscale: 1.5,
    image_yscale: 1.5,
    hitCD: 30,
    duration: 40,
    CritMod: 1.5,
    swingSpeed: 5,
    swungArc: 0,
    soundChannel: "StarHalberd",
    onHitEffects: 
    {
        StarSummon: {}
    },
    lifetime: 0,
    afterImageColor: 16711680,
    playSound: [247],
    maxLevel: 1,
    optionIcon: 1510,
    faceCreatorDirection: true,
    weaponType: "Melee",
    optionType: "Collab",
    combos: ["PsychoAxe", "IdolSong"],
    optionName: global.TextContainer.StarHalberdName.selectedLanguage,
    optionDescription: global.TextContainer.StarHalberdDescription.selectedLanguage[0],
    optionID: "StarHalberd"
}));
ds_map_set(attackIndex, "LightningWeinerLightning", new Attack("LightningWeinerLightning", defaultConfig, 
{
    damage: 0.9,
    collides: true,
    sprite_index: spr_RobocoHiSpec,
    attackTime: 360,
    hitLimit: 10,
    image_xscale: 1,
    image_yscale: 3,
    hitCD: 30,
    soundPitch: true,
    playSound: [86],
    soundChannel: "Lightning",
    soundCD: 30,
    attackDamageID: "LightningWeiner",
    lifetime: 0,
    image_alpha: 0.75,
    optionType: "WeaponEffect"
}));

LightningWeiner = function(arg0, arg1)
{
    var lifetime, lightningCD;
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
            var directionToEnemy = point_direction(arg0.x, arg0.y, arg1.x, arg1.y);
            var directionDifference = angle_difference(arg0.direction, directionToEnemy);
            arg0.direction -= min(abs(directionDifference), 10) * sign(directionDifference);
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
        arg0.direction -= min(abs(directionDifference), 10) * sign(directionDifference);
    }
    if (arg0.speed < 15)
    {
        arg0.speed += 0.3;
    }
    arg0.image_angle = arg0.direction;
    arg0.lifetime++;
    if (arg0.lightningCD > 0)
    {
        arg0.lightningCD--;
    }
};

ds_map_set(attackIndex, "LightningWeiner", new Attack("LightningWeiner", defaultConfig, 
{
    faceCreatorDirection: true,
    attackTime: 300,
    damage: 0.8,
    hitLimit: -1,
    collides: true,
    minDelay: 240,
    lightningCD: 0,
    image_alpha: 1,
    sprite_index: spr_LightningWeiner,
    script: LightningWeiner,
    image_xscale: 1.5,
    image_yscale: 1.5,
    hitCD: 30,
    attackCount: 4,
    duration: 240,
    startDirection: -30,
    stepDirection: 20,
    projSpeed: 0,
    lifetime: 0,
    range: 250,
    destroyOnHitLimit: true,
    targetRandom: true,
    onHitEffects: 
    {
        SummonLightning: {}
    },
    soundChannel: "LightningWeiner",
    lifetime: 0,
    afterImageColor: 16711680,
    playSound: [263],
    maxLevel: 1,
    optionIcon: 1210,
    faceCreatorDirection: true,
    weaponType: "MultiShot",
    optionType: "Collab",
    combos: ["Sausage", "Tailplug"],
    optionName: global.TextContainer.LightningWeinerName.selectedLanguage,
    optionDescription: global.TextContainer.LightningWeinerDescription.selectedLanguage[0],
    optionID: "LightningWeiner"
}));

CurseBallCurse = function(arg0, arg1)
{
    var lifetime;
    arg0.image_xscale = 0.4 * logn(1.6, arg0.lifetime + 1) * arg1.weaponSizeMultiplier;
    arg0.image_yscale = 0.4 * logn(1.6, arg0.lifetime + 1) * arg1.weaponSizeMultiplier;
    arg0.image_alpha -= 0.024;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "CurseBallCurse", new Attack("CurseBallCurse", defaultConfig, 
{
    damage: 3,
    sprite_index: spr_MelCookingPulse,
    attackTime: 120,
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    speed: 0,
    soundChannel: "asmr",
    spriteColor: 8388736,
    hitCD: 45,
    duration: 35,
    projSpeed: 0,
    lifetime: 0,
    attackDamageID: "CurseBall",
    stayOnCreator: false,
    script: CurseBallCurse,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    optionType: "WeaponEffect"
}));

CurseBall = function(arg0, arg1)
{
    var addTimeCD, lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_xscale = 2 + (global.charSelected.sizeGrade * 0.2);
        arg0.image_yscale = 2 + (global.charSelected.sizeGrade * 0.2);
    }
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
    arg0.image_angle += arg0.speed;
    if (arg0.speed > 0)
    {
        arg0.speed -= 0.1;
    }
    if (point_distance(arg0.x, arg0.y, arg1.x, arg1.y) < (20 * abs(arg0.image_xscale)))
    {
        arg0.direction = (arg1.direction - 15) + irandom(30);
        arg0.speed = 18;
        soundPlay([51], "bouncedball", 20, 0, 1);
        if (arg0.addTimeCD == 0)
        {
            arg0.duration += 60;
            arg0.addTimeCD = 30;
        }
    }
    if (arg0.addTimeCD > 0)
    {
        arg0.addTimeCD--;
    }
    if ((arg0.lifetime % 60) == 0)
    {
        obj_AttackController.ExecuteAttack("CurseBallCurse", arg1, 
        {
            x: arg0.x,
            y: arg0.y,
            enhancements: arg0.enhancements
        }, true);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "CurseBall", new Attack("CurseBall", defaultConfig, 
{
    stayOnCreator: false,
    faceCreatorDirection: true,
    attackTime: 660,
    damage: 4,
    hitLimit: -1,
    collides: true,
    minDelay: 300,
    image_alpha: 1,
    addTimeCD: 0,
    sprite_index: spr_Curseball,
    script: CurseBall,
    image_xscale: 2,
    image_yscale: 2,
    speed: 5,
    hitCD: 30,
    duration: 600,
    soundChannel: "CurseBall",
    knockback: 
    {
        duration: 7,
        speed: 5
    },
    lifetime: 0,
    afterImageColor: 8388736,
    playSound: [263],
    maxLevel: 1,
    optionIcon: 609,
    faceCreatorDirection: true,
    weaponType: "Range",
    optionType: "Collab",
    combos: ["ENCurse", "BounceBall"],
    optionName: global.TextContainer.CurseBallName.selectedLanguage,
    optionDescription: global.TextContainer.CurseBallDescription.selectedLanguage[0],
    optionID: "CurseBall"
}));

KanaCoco2 = function(arg0, arg1)
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
                arg0.direction = (arg1.direction - 10) + irandom(20);
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
    if (arg0.target != "noTarget" && instance_exists(arg0.target))
    {
        var directionToEnemy = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
        var directionDifference = angle_difference(arg0.direction, directionToEnemy);
        arg0.direction -= min(abs(directionDifference), 30) * sign(directionDifference);
    }
    if (arg0.speed < 15)
    {
        arg0.speed += 2;
    }
    arg0.image_angle = arg0.direction;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "KanaCoco2", new Attack("KanaCoco2", defaultConfig, 
{
    sprite_index: spr_KanaCoco2,
    attackTime: 150,
    image_speed: 0,
    hitLimit: 3,
    hitCD: 60,
    image_xscale: 1.25,
    image_yscale: 1.25,
    projSpeed: 15,
    destroyOnHitLimit: true,
    playSound: [275],
    soundChannel: "constantfire",
    soundCD: 10,
    soundPitch: true,
    faceCreatorDirection: false,
    duration: 40,
    targetRandom: true,
    isSkill: true,
    times: 0,
    lifetime: 0,
    randDir: -1,
    knockback: 
    {
        speed: 5,
        duration: 3
    },
    script: KanaCoco2,
    afterImageColor: 16711680,
    optionType: "WeaponEffect"
}));

KanaCoco = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 1)
    {
        arg0.x += -5 + random(10);
        arg0.y += -5 + random(10);
        arg0.speed = 15 + random(10);
        arg0.direction += -20 + random(40);
        arg0.image_angle = arg0.direction;
        arg0.collides = true;
        arg0.image_alpha = 0.9;
    }
    if (arg0.lifetime == 4)
    {
        obj_AttackController.ExecuteAttack("KanaCoco2", arg1, 
        {
            damage: arg0.damage * 1.5,
            enhancements: arg0.enhancements,
            x: arg1.x,
            y: arg1.y - 16,
            direction: (arg1.direction - 90) + (irandom(1) * 180),
            applyWeaponSize: true
        });
    }
    arg0.lifetime++;
};

KanaCocoApply = function(arg0)
{
    obj_AttackController.ApplyBuff(arg0, "KanaCocoEffect", ds_map_find_value(Buffs, "KanaCocoEffect"), 
    {
        buffIcon: 1238
    });
};

ds_map_set(attackIndex, "KanaCoco", new Attack("KanaCoco", defaultConfig, 
{
    sprite_index: spr_KanaCocoAttack,
    damage: 0.6,
    collides: false,
    attackTime: 7,
    hitCD: 15,
    speed: 15,
    minDelay: 7,
    hitLimit: 15,
    afterImageColor: 255,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0,
    script: KanaCoco,
    soundChannel: "constantfire",
    lifetime: 0,
    knockback: 
    {
        duration: 5,
        speed: 3
    },
    playSound: [275],
    soundCD: 10,
    soundPitch: true,
    stayOnCreator: false,
    duration: 20,
    destroyOnHitLimit: false,
    maxLevel: 1,
    attackCount: 3,
    optionIcon: 1238,
    superCollabEffect: KanaCocoApply,
    faceCreatorDirection: true,
    weaponType: "MultiShot",
    optionType: "SuperCollab",
    combos: ["DragonBeam", "GorillasPaw"],
    optionName: global.TextContainer.KanaCocoName.selectedLanguage,
    optionDescription: global.TextContainer.KanaCocoDescription.selectedLanguage[0],
    optionID: "KanaCoco"
}));

IdolLiveGlowstick = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.sprite_index = arg0.colorArray[arg0.colorIndex];
    }
    arg0.radius = sin(arg0.lifetime / 20) * 150;
    arg0.x = arg0.stayOn.x + (arg0.radius * cos(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.y = (arg0.stayOn.y - 16) + (arg0.radius * sin(((arg0.angle + arg0.direction) * pi) / 180));
    arg0.angle += arg0.projSpeed;
    arg0.image_angle = 0;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "IdolLiveGlowstick", new Attack("IdolLiveGlowstick", defaultConfig, 
{
    sprite_index: spr_GlowStick,
    damage: 1,
    colorArray: [1031, 1440, 991, 1260, 314, 1340, 2149, 1024],
    attackTime: 360,
    minDelay: 300,
    image_xscale: 1.5,
    image_yscale: 1.5,
    colorIndex: 0,
    hitLimit: -1,
    destroyOnHitLimit: false,
    duration: 60,
    hitCD: 20,
    angle: 0,
    lifetime: 0,
    radius: 0,
    projSpeed: 3,
    knockback: 
    {
        duration: 5,
        speed: 5
    },
    afterImageColor: 16711680,
    script: IdolLiveGlowstick,
    optionType: "WeaponEffect"
}));

IdolLiveParticle = function(arg0, arg1)
{
    var lifetime;
    if (arg0.speed > 0)
    {
        arg0.speed *= 0.95;
    }
    if (arg0.lifetime == 0)
    {
        arg0.image_angle = irandom(359);
        arg0.speed += -3 + random(6);
        var randSize = 0.5 + random(1.5);
        arg0.image_xscale = randSize * arg1.weaponSizeMultiplier;
        arg0.image_yscale = randSize * arg1.weaponSizeMultiplier;
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    arg0.image_angle += 10;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "IdolLiveParticle", new Attack("IdolLiveParticle", defaultConfig, 
{
    damage: 1,
    collides: true,
    sprite_index: spr_IdolLiveParticle,
    attackTime: 360,
    attackCount: 1,
    hitLimit: -1,
    hitCD: 10,
    speed: 18,
    duration: 60,
    soundPitch: true,
    attackDamageID: "IdolLive",
    lifetime: 0,
    transparent: true,
    image_alpha: 0.75,
    script: IdolLiveParticle,
    knockback: 
    {
        duration: 10,
        speed: 10
    },
    optionType: "WeaponEffect"
}));

IdolLiveParticleCreator = function(arg0, arg1)
{
    for (var i = 0; i < 8; i++)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        obj_AttackController.ExecuteAttack("IdolLiveGlowstick", arg0.creator, 
        {
            damage: arg0.damage,
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            attackDamageID: "IdolLive",
            direction: i * 45,
            colorIndex: i,
            applyWeaponSize: true
        }, true);
    }
};

ILPC = function(arg0, arg1)
{
    var lifetime;
    arg0.image_alpha -= 0.05;
    if (arg0.lifetime == 60)
    {
        obj_PlayerManager.ExecuteFlash(0.3);
        soundPlay([149], "idollivecreator", 10, 30, false);
        for (var i = 0; i < 50; i++)
        {
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            obj_AttackController.ExecuteAttack("IdolLiveParticle", arg0.creator, 
            {
                damage: arg0.damage * 1.5,
                enhancements: arg0.enhancements,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                attackDamageID: "IdolLive",
                direction: irandom(360),
                image_xscale: arg0.image_xscale,
                image_yscale: arg0.image_yscale
            }, true);
        }
    }
    if (arg0.lifetime > 60 && arg0.lifetime < 90)
    {
        var totalOnHitEffects = {};
        if (variable_struct_exists(arg0, "onHitEffects"))
        {
            variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
        }
        obj_AttackController.ExecuteAttack("IdolLiveMusic", arg0.creator, 
        {
            damage: arg0.damage / 1.5,
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            attackDamageID: "IdolLive",
            direction: irandom(360),
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale
        }, true);
        obj_AttackController.ExecuteAttack("IdolLiveMusic", arg0.creator, 
        {
            damage: arg0.damage / 1.5,
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            attackDamageID: "IdolLive",
            direction: irandom(360),
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale
        }, true);
        obj_AttackController.ExecuteAttack("IdolLiveMusic", arg0.creator, 
        {
            damage: arg0.damage / 1.5,
            enhancements: arg0.enhancements,
            CritMod: arg0.CritMod,
            knockback: arg0.knockback,
            onHitEffects: totalOnHitEffects,
            gainedMods: arg0.gainedMods,
            attackDamageID: "IdolLive",
            direction: irandom(360),
            image_xscale: arg0.image_xscale,
            image_yscale: arg0.image_yscale
        }, true);
    }
    arg0.lifetime++;
};

IdolLiveMusic = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.sprite_index = arg0.expArray[arg0.direction div 45];
        arg0.image_alpha = 1;
        arg0.origin_x = arg1.x;
        arg0.origin_y = arg1.y - 16;
        arg0.direction = irandom(360);
    }
    arg0.origin_x += lengthdir_x(arg0.projSpeed, arg0.direction);
    arg0.origin_y += lengthdir_y(arg0.projSpeed, arg0.direction);
    arg0.x = arg0.origin_x + lengthdir_x(sin(arg0.lifetime / 16) * 40 * arg0.travelWidth, arg0.direction + 90);
    arg0.y = arg0.origin_y + lengthdir_y(sin(arg0.lifetime / 16) * 40 * arg0.travelWidth, arg0.direction + 90);
    arg0.lifetime++;
    arg0.image_angle = 0;
    if (arg0.lifetime == 0)
    {
    }
    arg0.lifetime++;
};

IdolLiveApply = function(arg0)
{
    obj_AttackController.ApplyBuff(arg0, "IdolLiveEffect", ds_map_find_value(Buffs, "IdolLiveEffect"), 
    {
        buffIcon: 2429
    });
    arg0.onSpecial.IdolLive = 
    {
        Script: function(arg0, arg1)
        {
            if (arg0.scripts.IdolLive.config.timer == 0)
            {
                arg0.scripts.IdolLive.config.timer = arg0.scripts.IdolLive.config.maxTimer;
                obj_AttackController.ApplyBuff(arg0, "IdolLiveBuff", ds_map_find_value(obj_AttackController.Buffs, "IdolLiveBuff"), 
                {
                    buffIcon: 1104
                });
            }
        },
        
        config: {}
    };
    arg0.scripts.IdolLive = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
            if (arg1.emitterOn)
            {
                part_emitter_stream(global.psystem, arg1.emitter, global.partType19, 3);
                part_emitter_region(global.psystem, arg1.emitter, arg0.x - 16, arg0.x + 16, arg0.y, arg0.y - 30, 0, 0);
            }
            else
            {
                part_emitter_stream(global.psystem, arg1.emitter, global.partType19, 0);
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 1800,
            emitter: part_emitter_create(global.psystem),
            emitterOn: false
        }
    };
};

ds_map_set(attackIndex, "IdolLiveMusic", new Attack("IdolLiveMusic", defaultConfig, 
{
    sprite_index: spr_GlowStick,
    colorArray: [1031, 1440, 991, 1260, 314, 1340, 2149, 1024],
    expArray: [1195, 694, 154, 921, 1052, 1816, 35, 396],
    damage: 0.7,
    attackTime: 240,
    minDelay: 240,
    hitCD: 20,
    hitLimit: 7,
    image_xscale: 1,
    image_yscale: 1,
    speed: 15,
    projSpeed: 5,
    image_alpha: 0,
    script: IdolLiveMusic,
    lifetime: 0,
    travelWidth: 1,
    duration: 60,
    targetRandom: true,
    afterImageColor: 16711680,
    destroyOnHitLimit: true,
    attackCount: 1,
    resetSequence: true,
    attackDelay: 6,
    knockback: 
    {
        duration: 7,
        speed: 3
    },
    optionType: "WeaponEffect"
}));
ds_map_set(attackIndex, "IdolLive", new Attack("IdolLive", defaultConfig, 
{
    collides: false,
    attackTime: 240,
    sprite_index: spr_gacha_holologo,
    hitLimit: 10,
    hitCD: 20,
    damage: 0.8,
    duration: 240,
    soundPitch: true,
    drawBehind: true,
    stayOnCreator: true,
    attackDamageID: "IdolLive",
    playSound: [97],
    soundChannel: "idollivecreator",
    lifetime: 0,
    splitCount: 10,
    image_alpha: 0.8,
    onCreate: IdolLiveParticleCreator,
    script: ILPC,
    superCollabEffect: IdolLiveApply,
    maxLevel: 1,
    attackCount: 1,
    optionIcon: 2429,
    weaponType: "Ranged",
    optionType: "SuperCollab",
    combos: ["IdolConcert", "IdolCostume"],
    optionName: global.TextContainer.IdolLiveName.selectedLanguage,
    optionDescription: global.TextContainer.IdolLiveDescription.selectedLanguage[0],
    optionID: "IdolLive"
}));

SnowQueen = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime >= 10)
    {
        arg0.collides = true;
    }
    arg0.image_xscale = 3;
    arg0.image_yscale = 2.0999999999999996;
    arg0.lifetime++;
    if (!audio_is_playing(snd_snowqueenwind))
    {
        audio_play_sound(snd_snowqueenwind, 0, true);
    }
};

SnowQueenApply = function(arg0)
{
    if (!variable_struct_exists(arg0.scripts, "SnowQueen"))
    {
        arg0.scripts.SnowQueen = 
        {
            Script: function(arg0, arg1)
            {
                part_emitter_region(global.psystem, arg1.emitter, arg0.x - 800, arg0.x + 200, arg0.y - 500, arg0.y + 100, 0, 0);
                part_emitter_region(global.psystem, arg1.emitter2, arg0.x, arg0.x, arg0.y, arg0.y, 0, 0);
                if (!arg1.emitterOn)
                {
                    audio_play_sound(snd_snowqueenwind, 0, true);
                    arg1.emitterOn = true;
                    part_emitter_stream(global.psystem, arg1.emitter, global.partType23, 1);
                    part_emitter_stream(global.psystem, arg1.emitter2, global.partType24, 1);
                }
            },
            
            config: 
            {
                emitter: part_emitter_create(global.psystem),
                emitter2: part_emitter_create(global.psystem),
                emitterOn: false
            }
        };
    }
    variable_struct_remove(arg0.scripts, "Sake");
    variable_struct_remove(arg0.onHeal, "Sake");
    variable_struct_remove(arg0.onTakeDamage, "Sake");
    RemoveBuff(arg0, "Sake");
    RemoveBuff(arg0, "Sake2");
    obj_AttackController.ApplyBuff(arg0, "SnowQueenEffect", ds_map_find_value(Buffs, "SnowQueenEffect"), 
    {
        buffIcon: 2100
    });
};

ds_map_set(attackIndex, "SnowQueen", new Attack("SnowQueen", defaultConfig, 
{
    damage: 2.2,
    sprite_index: spr_SnowSakeFlake,
    collides: false,
    attackTime: 300,
    minDelay: 300,
    hitLimit: -1,
    hitCD: 30,
    image_xscale: 2.5,
    image_yscale: 2.5,
    image_alpha: 0,
    drawUnderAll: true,
    range: 300,
    onHitEffects: 
    {
        Frozen: 
        {
            chance: 40,
            time: 120,
            attackID: "SnowQueen"
        }
    },
    drawBehind: true,
    script: SnowQueen,
    lifetime: 0,
    stayOnCreator: true,
    duration: 320,
    transparent: true,
    destroyOnHitLimit: false,
    maxLevel: 1,
    attackCount: 1,
    optionIcon: 2100,
    superCollabEffect: SnowQueenApply,
    faceCreatorDirection: false,
    weaponType: "Ranged",
    optionType: "SuperCollab",
    combos: ["SnowSake", "Sake"],
    optionName: global.TextContainer.SnowQueenName.selectedLanguage,
    optionDescription: global.TextContainer.SnowQueenDescription.selectedLanguage[0],
    optionID: "SnowQueen"
}));

JingisukanPool = function(arg0, arg1)
{
    var lifetime2, healCD;
    if (instance_exists(arg0))
    {
        if (arg0.lifetime2 == 0)
        {
            var haachama = variable_struct_exists(obj_PlayerManager.perks, "StrongestIdol");
            arg0.damage = arg0.damage * (1 + (haachama * 0.15));
            arg0.emitter = part_emitter_create(global.psystem);
        }
        if (arg0.lifetime2 < 20)
        {
            if (arg0.currentSize < arg0.maxSize)
            {
                var elite = variable_struct_exists(obj_PlayerManager.perks, "Elite");
                arg0.currentSize += 0.1;
                arg0.image_xscale = arg0.currentSize + (elite * 0.1);
                arg0.image_yscale = arg0.currentSize + (elite * 0.1);
            }
        }
        arg0.lifetime2++;
        arg0.lifeTime += 0.05;
        arg0.image_alpha = 0.3 - (0.25 * (arg0.lifetime2 / 300));
        part_emitter_region(global.psystem, arg0.emitter, arg0.x - (50 * arg0.image_xscale), arg0.x + (50 * arg0.image_xscale), arg0.y - (50 * arg0.image_yscale), arg0.y + (50 * arg0.image_yscale), 1, 0);
        part_emitter_stream(global.psystem, arg0.emitter, global.partType11, 1);
        if (arg0.lifetime2 >= 295)
        {
            part_emitter_destroy(global.psystem, arg0.emitter);
        }
    }
    if (arg0.healCD == 0)
    {
        if (point_distance(arg0.x, arg0.y, arg1.x, arg1.y) <= ((sprite_get_width(spr_HealPulse) * arg0.image_xscale) / 2))
        {
            Heal(arg1, 3, 1, true, true, false);
            arg0.healCD = 60;
        }
    }
    else
    {
        arg0.healCD--;
    }
};

ds_map_set(attackIndex, "JingisukanPool", new Attack("JingisukanPool", defaultConfig, 
{
    sprite_index: spr_HealPulse,
    maxSize: 1.75,
    lifetime2: 0,
    currentSize: 0,
    image_xscale: 0,
    image_yscale: 0,
    attackTime: 150,
    hitLimit: -1,
    projSpeed: 0,
    drawBehind: true,
    drawUnderAll: true,
    hitCD: 25,
    healCD: 60,
    splitCount: 6,
    stayOnCreator: false,
    image_alpha: 0,
    script: JingisukanPool,
    lifeTime: 0,
    duration: 300,
    targetRandom: true,
    drawBehind: true,
    attackDamageID: "Jingisukan",
    optionType: "WeaponEffect"
}));

Jingisukan = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.maxlifetime = 5 + floor(random(20));
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
            var totalOnHitEffects = {};
            if (variable_struct_exists(arg0, "onHitEffects"))
            {
                variable_struct_copy(arg0.onHitEffects, totalOnHitEffects);
            }
            arg0.hasCreated = true;
            ExecuteAttack("JingisukanPool", arg0.creator, 
            {
                damage: arg0.damage,
                enhancements: arg0.enhancements,
                x: arg0.x,
                y: arg0.y,
                CritMod: arg0.CritMod,
                knockback: arg0.knockback,
                onHitEffects: totalOnHitEffects,
                gainedMods: arg0.gainedMods,
                applyWeaponSize: true
            }, true);
            arg0.duration = 5;
            arg0.visible = false;
        }
    }
};

JingisukanApply = function(arg0)
{
    obj_AttackController.ApplyBuff(arg0, "JingisukanEffect", ds_map_find_value(Buffs, "JingisukanEffect"), 
    {
        buffIcon: 930
    });
    arg0.scripts.UberSheep = 
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
            maxTimer: max(1, 480 * (1 / (1 + (arg0.haste / 100))))
        }
    };
    global.foodDropChanceBuff = 0.15;
};

ds_map_set(attackIndex, "Jingisukan", new Attack("Jingisukan", defaultConfig, 
{
    sprite_index: spr_JingisukanIcon,
    damage: 0.8,
    attackTime: 35,
    image_xscale: 0.9,
    image_yscale: 0.9,
    minDelay: 10,
    hitLimit: -1,
    projSpeed: 9,
    hitCD: 30,
    collides: false,
    script: Jingisukan,
    playSound: [263],
    soundPitch: true,
    duration: 70,
    targetRandom: true,
    destroyOnHitLimit: false,
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    maxlifetime: 5,
    range: 400,
    maxLevel: 1,
    optionIcon: 930,
    superCollabEffect: JingisukanApply,
    weaponType: "Ranged",
    optionType: "SuperCollab",
    combos: ["EliteCooking", "UberSheep"],
    optionName: global.TextContainer.JingisukanName.selectedLanguage,
    optionDescription: global.TextContainer.JingisukanDescription.selectedLanguage[0],
    optionID: "Jingisukan"
}));
