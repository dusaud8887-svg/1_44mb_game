FubuLaser = function(arg0, arg1)
{
    var lifeTime;
    arg0.image_angle = 0;
    if (instance_exists(arg1))
    {
        if (arg0.lifeTime < 65)
        {
            arg0.image_xscale = (4 * arg1.image_xscale) / abs(arg1.image_xscale);
        }
        arg0.lifeTime++;
        if (arg0.lifeTime == 75)
        {
            arg0.collides = true;
            soundPlay([226], "laser", 10, 20);
        }
    }
    else
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

LaserAOE = function(arg0, arg1)
{
    if (instance_exists(arg0) && instance_exists(arg1))
    {
        if (arg0.lifeTime < 65)
        {
            draw_set_alpha(1);
            draw_set_color(make_color_rgb(255, 170, 170));
            draw_rectangle((arg0.x + (56 * (arg1.image_xscale / abs(arg1.image_xscale)))) - 1, arg0.y - 56 - 1, arg0.x + (1600 * (arg1.image_xscale / abs(arg1.image_xscale))) + 1, arg0.y + 56 + 1, true);
            draw_set_alpha(0.1 + abs(0.3 * sin(arg0.lifeTime / 10)));
            draw_set_color(c_red);
            draw_rectangle(arg0.x + (56 * (arg1.image_xscale / abs(arg1.image_xscale))), arg0.y - 56, arg0.x + (1600 * (arg1.image_xscale / abs(arg1.image_xscale))), arg0.y + 56, false);
            draw_set_alpha(1);
        }
    }
};

ds_map_set(attackIndex, "Fubulaser", new Attack("Fubulaser", defaultConfig, 
{
    sprite_index: spr_fubuLaser,
    attackTime: -1,
    damage: 0.25,
    soundChannel: "laser",
    soundPrio: 20,
    image_xscale: 4,
    image_yscale: 8,
    hitLimit: -1,
    faceCreatorDirection: true,
    homing: false,
    hitCD: 60,
    destroyOnHitLimit: false,
    stayOnCreator: true,
    horizontalOnly: true,
    collides: false,
    lifeTime: 0,
    script: FubuLaser,
    starty: -80,
    facing: 1,
    customDrawScriptBelow: LaserAOE,
    erasable: false
}));

FubuLaser2 = function(arg0, arg1)
{
    var lifetime;
    if (instance_exists(arg1))
    {
        if (arg0.lifetime == 0)
        {
            arg0.image_speed = 0;
            arg0.aimingDirection = point_direction(arg1.x, arg1.y - arg0.beamHeight - 4, obj_Player.x, obj_Player.y);
        }
        if (arg0.lifetime == 45)
        {
            arg0.image_speed = 1;
            arg0.image_alpha = 1;
        }
        if (instance_exists(arg1) && arg0.lifetime < 110)
        {
            var newDir = point_direction(arg1.x, arg1.y - arg0.beamHeight - 4, obj_Player.x, obj_Player.y);
            var directionDifference = angle_difference(newDir, arg0.aimingDirection);
            arg0.aimingDirection += min(abs(directionDifference), arg0.turnRate) * sign(directionDifference);
            arg0.image_angle = arg0.aimingDirection;
        }
        arg0.lifetime++;
        if (arg0.lifetime == 120)
        {
            arg0.collides = true;
            soundPlay([226], "laser", 10, 20);
        }
    }
    else
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

LaserAOE2 = function(arg0, arg1)
{
    if (instance_exists(arg0) && instance_exists(arg1))
    {
        if (arg0.lifetime < 110)
        {
            draw_set_alpha(1);
            draw_set_color(make_color_rgb(255, 170, 170));
            draw_rectangle_rotated(arg1.x + lengthdir_x(56, arg0.aimingDirection), (arg1.y - arg0.beamHeight) + lengthdir_y(56, arg0.aimingDirection), -1, -57, 1601, 57, arg0.aimingDirection, true);
            draw_set_alpha(0.1 + abs(0.3 * sin(arg0.lifetime / 10)));
            draw_set_color(c_red);
            draw_rectangle_rotated(arg1.x + lengthdir_x(56, arg0.aimingDirection), (arg1.y - arg0.beamHeight) + lengthdir_y(56, arg0.aimingDirection), 0, -56, 1600, 56, arg0.aimingDirection, false);
            draw_set_alpha(1);
            draw_rectangle_rotated(arg1.x + lengthdir_x(56, arg0.aimingDirection), (arg1.y - arg0.beamHeight) + lengthdir_y(56, arg0.aimingDirection), 0, (arg0.lifetime / 120) * -56, 1600, (arg0.lifetime / 120) * 56, arg0.aimingDirection, true);
        }
    }
};

ds_map_set(attackIndex, "Fubulaser2", new Attack("Fubulaser2", defaultConfig, 
{
    sprite_index: spr_fubuLaser,
    attackTime: -1,
    damage: 0.25,
    soundChannel: "laser",
    soundPrio: 20,
    image_xscale: 4,
    image_alpha: 0,
    image_yscale: 8,
    hitLimit: -1,
    turnRate: 0.08,
    faceCreatorDirection: true,
    homing: false,
    hitCD: 60,
    beamHeight: 80,
    aimingDirection: 0,
    destroyOnHitLimit: false,
    stayOnCreator: true,
    collides: false,
    lifetime: 0,
    script: FubuLaser2,
    starty: -80,
    facing: 1,
    customDrawScriptBelow: LaserAOE2,
    erasable: false
}));
ds_map_set(attackIndex, "MikodanyeFire", new Attack("MikodanyeFire", defaultConfig, 
{
    sprite_index: spr_DragonFire,
    damage: 0.03,
    collides: true,
    speed: 17,
    hitLimit: -1,
    isEnemy: true,
    afterImageColor: 4235519,
    faceCreatorDirection: false,
    image_xscale: 0.8,
    image_yscale: 0.8,
    image_alpha: 0.8,
    lifetime: 0,
    playSound: [275],
    soundChannel: "mikodanyefire",
    soundCD: 10,
    soundPrio: 5,
    soundPitch: true,
    stayOnCreator: false,
    duration: 30
}));

MikoFireBreath = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (instance_exists(arg1))
        {
            arg0.aimingDirection = point_direction(arg1.x, arg1.y - 84, obj_Player.x, obj_Player.y);
        }
    }
    arg0.image_angle = 0;
    if (instance_exists(arg1))
    {
        if (arg1.followTarget != -4)
        {
            var newDir = point_direction(arg1.x, arg1.y - 84, obj_Player.x, obj_Player.y);
            var directionDifference = angle_difference(newDir, arg0.aimingDirection);
            arg0.aimingDirection += min(abs(directionDifference), 0.3) * sign(directionDifference);
        }
        if (arg0.lifetime > 180)
        {
            var setDir = (arg0.aimingDirection - 30) + irandom(60);
            obj_AttackController.ExecuteAttack("MikodanyeFire", arg1, 
            {
                direction: setDir,
                image_angle: setDir,
                speed: 6 + irandom(4),
                x: arg0.x,
                y: arg0.y
            });
        }
        arg0.lifetime++;
    }
    else
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

FireBreathAOE = function(arg0, arg1)
{
    if (instance_exists(arg0) && instance_exists(arg1))
    {
        if (arg0.lifetime == 0)
        {
            arg0.aimingDirection = point_direction(arg1.x, arg1.y - 84, obj_Player.x, obj_Player.y);
            soundPlay([251], "bossWarning", 10, 50, false);
        }
        if (arg0.lifetime < 180)
        {
            var drawAlpha = 0.1 + abs(0.3 * sin(arg0.lifetime / 10));
            draw_sprite_ext(spr_Mikofirewarning, 0, arg1.x, arg1.y - 84, 1, 1, arg0.aimingDirection, c_white, drawAlpha);
        }
    }
};

ds_map_set(attackIndex, "MikoFireBreath", new Attack("MikoFireBreath", defaultConfig, 
{
    attackTime: -1,
    damage: 0.25,
    hitLimit: -1,
    faceCreatorDirection: true,
    destroyOnHitLimit: false,
    stayOnCreator: true,
    aimingDirection: 0,
    horizontalOnly: false,
    collides: false,
    script: MikoFireBreath,
    starty: -84,
    lifetime: 0,
    duration: 420,
    facing: 1,
    customDrawScriptBelow: FireBreathAOE
}));

RisuFireBreath = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        if (instance_exists(arg1))
        {
            arg0.aimingDirection = point_direction(arg1.x, arg1.y - 84, obj_Player.x, obj_Player.y);
        }
    }
    arg0.image_angle = 0;
    if (instance_exists(arg1))
    {
        if (arg1.followTarget != -4)
        {
            var newDir = point_direction(arg1.x, arg1.y - 84, obj_Player.x, obj_Player.y);
            var directionDifference = angle_difference(newDir, arg0.aimingDirection);
            arg0.aimingDirection += min(abs(directionDifference), 0.2) * sign(directionDifference);
        }
        if (arg0.lifetime > 180)
        {
            var setDir = (arg0.aimingDirection - 30) + irandom(60);
            obj_AttackController.ExecuteAttack("MikodanyeFire", arg1, 
            {
                direction: setDir,
                image_angle: setDir,
                speed: 5 + irandom(4),
                depth: arg1.depth - 10,
                x: arg0.x,
                y: arg0.y
            });
        }
        arg0.lifetime++;
    }
    else
    {
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "RisuFireBreath", new Attack("RisuFireBreath", defaultConfig, 
{
    attackTime: -1,
    damage: 0.2,
    hitLimit: -1,
    faceCreatorDirection: true,
    destroyOnHitLimit: false,
    stayOnCreator: true,
    aimingDirection: 0,
    horizontalOnly: false,
    collides: false,
    script: RisuFireBreath,
    starty: -84,
    lifetime: 0,
    duration: 420,
    facing: 1,
    customDrawScriptBelow: FireBreathAOE
}));

MikodanyeLavaPool = function(arg0, arg1)
{
    arg0.lifetime += 1;
    if (arg0.lifetime == 40)
    {
        arg0.collides = true;
        arg0.sprite_index = spr_Mikodanye_lava_loop;
        arg0.image_index = 0;
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
        arg0.collides = false;
    }
};

ds_map_set(attackIndex, "MikodanyeLavaPool", new Attack("MikodanyeLavaPool", defaultConfig, 
{
    sprite_index: spr_Mikodanye_lava_start,
    collides: false,
    projSpeed: 0,
    hitLimit: -1,
    depth: 0,
    destroyOnHitLimit: false,
    script: MikodanyeLavaPool,
    playSound: [196],
    lifetime: 0,
    erasable: false
}));

MikodanyeLava = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.maxlifetime = 40 + floor(random(30));
        arg0.target = instance_find(obj_Player, 0);
        arg0.direction = (point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y) - 15) + irandom(30);
        arg0.image_angle = arg0.direction;
        arg0.speed = arg0.projSpeed + random(3);
        arg0.vspeed += -(3 + random(3));
    }
    arg0.lifetime++;
    arg0.gravity = 0.2;
    if (arg0.lifetime >= arg0.maxlifetime || (arg0.target != "noTarget" && instance_exists(arg0.target) && point_distance(arg0.x, arg0.y, arg0.target.x, arg0.target.y) < 30 && arg0.lifetime > 15))
    {
        if (!arg0.hasCreated)
        {
            arg0.hasCreated = true;
            ExecuteAttack("MikodanyeLavaPool", arg1, 
            {
                damage: arg0.damage,
                duration: arg0.ogDuration,
                ogDuration: arg0.ogDuration,
                hitCD: arg0.hitCD,
                x: arg0.x,
                y: arg0.y,
                image_xscale: arg0.image_xscale,
                image_yscale: arg0.image_yscale * 0.8
            });
            arg0.duration = 5;
            arg0.visible = false;
        }
    }
};

ds_map_set(attackIndex, "MikodanyeLava", new Attack("MikodanyeLava", defaultConfig, 
{
    sprite_index: spr_EliteLavaBucket,
    damage: 0.03,
    attackTime: 300,
    image_xscale: 1.2,
    image_yscale: 1.2,
    hitLimit: -1,
    projSpeed: 8,
    hitCD: 30,
    collides: false,
    script: MikodanyeLava,
    playSound: [263],
    duration: 300,
    ogDuration: 300,
    targetRandom: true,
    destroyOnHitLimit: false,
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    erasable: false,
    maxlifetime: 10 + floor(random(15))
}));

PoisonBeakerPool = function(arg0, arg1)
{
    arg0.lifetime += 1;
    if (arg0.lifetime == 20)
    {
        arg0.collides = true;
        arg0.sprite_index = spr_PoisonPool_Loop;
        arg0.image_index = 0;
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
        arg0.collides = false;
        arg0.sprite_index = spr_PoisonPool_End;
        arg0.image_index = 0;
    }
};

ds_map_set(attackIndex, "PoisonBeakerPool", new Attack("PoisonBeakerPool", defaultConfig, 
{
    sprite_index: spr_PoisonPool_Start,
    collides: false,
    projSpeed: 0,
    hitLimit: -1,
    depth: 0,
    destroyOnHitLimit: false,
    script: PoisonBeakerPool,
    playSound: [116],
    lifetime: 0,
    erasable: false
}));

PoisonBeaker = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.maxlifetime = 40 + floor(random(30));
        arg0.target = instance_find(obj_Player, 0);
        arg0.direction = (point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y) - 15) + irandom(30);
        arg0.image_angle = arg0.direction;
        arg0.speed = arg0.projSpeed + random(3);
        arg0.vspeed += -(3 + random(3));
    }
    arg0.lifetime++;
    arg0.gravity = 0.2;
    if (arg0.lifetime >= arg0.maxlifetime || (arg0.target != "noTarget" && instance_exists(arg0.target) && point_distance(arg0.x, arg0.y, arg0.target.x, arg0.target.y) < 30 && arg0.lifetime > 15))
    {
        if (!arg0.hasCreated)
        {
            arg0.hasCreated = true;
            ExecuteAttack("PoisonBeakerPool", arg1, 
            {
                damage: arg0.damage,
                duration: arg0.ogDuration,
                ogDuration: arg0.ogDuration,
                hitCD: arg0.hitCD,
                x: arg0.x,
                y: arg0.y,
                image_xscale: arg0.image_xscale * 1.5,
                image_yscale: arg0.image_yscale * 1.5
            });
            arg0.duration = 5;
            arg0.visible = false;
        }
    }
};

ds_map_set(attackIndex, "PoisonBeaker", new Attack("PoisonBeaker", defaultConfig, 
{
    sprite_index: spr_MoTIna_Pot,
    damage: 0.06,
    attackTime: 300,
    image_xscale: 1,
    image_yscale: 1,
    hitLimit: -1,
    projSpeed: 8,
    hitCD: 30,
    collides: false,
    script: PoisonBeaker,
    playSound: [263],
    duration: 300,
    ogDuration: 300,
    targetRandom: true,
    destroyOnHitLimit: false,
    hasCreated: false,
    lifetime: 0,
    isEnemy: false,
    erasable: false,
    maxlifetime: 10 + floor(random(15))
}));
ds_map_set(attackIndex, "EnemySlash", new Attack("EnemySlash", defaultConfig, 
{
    attackTime: 90,
    damage: 0.18,
    faceCreatorDirection: false,
    sprite_index: spr_OllieSword,
    playSound: [114],
    destroyOnHitLimit: false,
    image_xscale: 1.5,
    image_yscale: 1.5,
    image_alpha: 1,
    hitLimit: -1,
    collides: true,
    attackCount: 1,
    stayOnCreator: true,
    canAddProjectile: false,
    hitCD: 30,
    lifetime: 0,
    maxLevel: 1,
    optionIcon: 370,
    weaponType: "Melee",
    optionName: global.TextContainer.ollieAttackName.selectedLanguage,
    optionDescription: global.TextContainer.ollieAttackDesc.selectedLanguage[0]
}));

function CircleHitboxDrawDebug()
{
    if (global.debug)
    {
        draw_set_colour(c_red);
        draw_ellipse(x - radius, y - (radius / ratio), x + radius, y + (radius / ratio), false);
        depth = -10000;
    }
}

function CircleHitboxEnemy()
{
    var targets = ds_list_create();
    if (!instance_exists(obj_Player))
    {
        exit;
    }
    var numberOfTargets = collision_ellipse_list(x - radius, y - (radius / ratio), x + radius, y + (radius / ratio), 227, true, true, targets, false);
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

ds_map_set(attackIndex, "AmeGroundPound", new Attack("AmeGroundPound", defaultConfig, 
{
    hitLimit: -1,
    damage: 0.25,
    hitCD: 60,
    onCreate: CircleHitboxEnemy,
    collides: false,
    customDrawScriptBelow: CircleHitboxDrawDebug,
    radius: 120,
    ratio: 1.8,
    erasable: false
}));
ds_map_set(attackIndex, "BaeGroundPound", new Attack("BaeGroundPound", defaultConfig, 
{
    hitLimit: -1,
    damage: 0.25,
    hitCD: 60,
    onCreate: CircleHitboxEnemy,
    collides: false,
    customDrawScriptBelow: CircleHitboxDrawDebug,
    radius: 120,
    ratio: 1,
    erasable: false
}));
ds_map_set(attackIndex, "EHGroundPound", new Attack("EHGroundPound", defaultConfig, 
{
    hitLimit: -1,
    damage: 0.32,
    hitCD: 60,
    onCreate: CircleHitboxEnemy,
    collides: false,
    customDrawScriptBelow: CircleHitboxDrawDebug,
    radius: 130,
    ratio: 1,
    erasable: false
}));
ds_map_set(attackIndex, "ShubangelionSmash", new Attack("BaeGroundPound", defaultConfig, 
{
    hitLimit: -1,
    damage: 0.3,
    hitCD: 60,
    onCreate: CircleHitboxEnemy,
    collides: false,
    customDrawScriptBelow: CircleHitboxDrawDebug,
    radius: 250,
    ratio: 1,
    erasable: false
}));

function SelfDestruct()
{
    var targets = ds_list_create();
    if (!instance_exists(obj_Player))
    {
        exit;
    }
    var numberOfTargets = collision_ellipse_list(x - radius, y - radius, x + radius, y + radius, 227, true, true, targets, false);
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

function CircleHitboxDrawDebug2()
{
    if (global.debug)
    {
        draw_set_colour(c_red);
        draw_ellipse(x - radius, y - radius, x + radius, y + radius, false);
        depth = -10000;
    }
}

ds_map_set(attackIndex, "SelfDestruct", new Attack("SelfDestruct", defaultConfig, 
{
    hitLimit: -1,
    damage: 0.1,
    hitCD: 60,
    onCreate: SelfDestruct,
    collides: false,
    playSound: [0],
    soundChannel: "bigexplosion",
    customDrawScriptBelow: CircleHitboxDrawDebug2,
    radius: 50,
    starty: 0,
    erasable: false
}));

function TargetPlayer()
{
    if (instance_exists(obj_Player))
    {
        direction = point_direction(x, y, obj_Player.x, obj_Player.y + 4);
        speed = 3;
    }
}

ds_map_set(attackIndex, "AChanBullet1", new Attack("AChanBullet1", defaultConfig, 
{
    sprite_index: spr_AChan_bullet1,
    damage: 0.07,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    projSpeed: 3,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    targetRandom: true,
    onCreate: TargetPlayer,
    destroyOnHitLimit: true
}));
ds_map_set(attackIndex, "AChanBullet2", new Attack("AChanBullet2", defaultConfig, 
{
    sprite_index: spr_AChan_bullet2,
    damage: 0.06,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    speed: 4,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    targetRandom: true,
    destroyOnHitLimit: true
}));

AChanBullet3 = function(arg0, arg1)
{
    if (arg0.startingDir == -1)
    {
        arg0.startingDir = arg0.direction;
    }
    arg0.direction += (1.2 * arg0.duration) / 300;
};

ds_map_set(attackIndex, "AChanBullet3", new Attack("AChanBullet3", defaultConfig, 
{
    sprite_index: spr_AChan_bullet3,
    damage: 0.085,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    speed: 2,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    script: AChanBullet3,
    targetRandom: true,
    startingDir: -1,
    destroyOnHitLimit: true
}));

AChanBullet4 = function(arg0, arg1)
{
    if (arg0.startingDir == -1)
    {
        arg0.startingDir = arg0.direction;
    }
    arg0.direction -= (1.2 * arg0.duration) / 300;
};

ds_map_set(attackIndex, "AChanBullet4", new Attack("AChanBullet4", defaultConfig, 
{
    sprite_index: spr_AChan_bullet2,
    damage: 0.085,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    speed: 2,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    script: AChanBullet4,
    targetRandom: true,
    startingDir: -1,
    destroyOnHitLimit: true
}));
ds_map_set(attackIndex, "AChanBullet5", new Attack("AChanBullet5", defaultConfig, 
{
    sprite_index: spr_AChan_bullet1,
    damage: 0.05,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    speed: 5,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    targetRandom: true,
    destroyOnHitLimit: true
}));
ds_map_set(attackIndex, "Bae3DBullet", new Attack("Bae3DBullet", defaultConfig, 
{
    sprite_index: spr_AChan_bullet2,
    damage: 0.085,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    speed: 3,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    targetRandom: true,
    startingDir: -1,
    destroyOnHitLimit: true
}));

NodokaBullet1 = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        arg0.origin_x = arg1.x;
        arg0.origin_y = arg1.y - 16;
        arg0.image_alpha = 1;
    }
    arg0.origin_x += lengthdir_x(arg0.speed, arg0.direction);
    arg0.origin_y += lengthdir_y(arg0.speed, arg0.direction);
    arg0.x = arg0.origin_x + lengthdir_x(arg0.waveDir * sin(1.5707963267948966 + arg0.lifetime) * arg0.spread, arg0.direction + 90);
    arg0.y = arg0.origin_y + lengthdir_y(arg0.waveDir * sin(1.5707963267948966 + arg0.lifetime) * arg0.spread, arg0.direction + 90);
    arg0.lifetime += 0.2;
    arg0.image_angle = 0;
};

ds_map_set(attackIndex, "NodokaBullet1", new Attack("NodokaBullet1", defaultConfig, 
{
    sprite_index: spr_AChan_bullet1,
    damage: 0.05,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    speed: 5,
    playSound: [255],
    soundChannel: "achanbullet",
    script: NodokaBullet1,
    soundCD: 6,
    waveDir: 1,
    origin_x: -1,
    origin_y: -1,
    lifetime: 0,
    spread: 35,
    duration: 300,
    targetRandom: true,
    destroyOnHitLimit: true
}));

function TargetPlayer2(arg0, arg1)
{
    if (instance_exists(obj_Player))
    {
        direction = point_direction(arg0.x, arg0.y, obj_Player.x, obj_Player.y - 16);
        speed = arg0.projSpeed;
    }
}

ds_map_set(attackIndex, "EnemyBullet", new Attack("EnemyBullet", defaultConfig, 
{
    sprite_index: spr_AChan_bullet2,
    damage: 0.07,
    attackTime: 30,
    hitCD: 30,
    hitLimit: 1,
    projSpeed: 3,
    playSound: [255],
    soundChannel: "achanbullet",
    soundCD: 6,
    duration: 300,
    targetRandom: true,
    onCreate: TargetPlayer2,
    destroyOnHitLimit: true
}));
ds_map_set(attackIndex, "ShubangelionRockHitBox", new Attack("ShubangelionRockHitBox", defaultConfig, 
{
    hitLimit: -1,
    damage: 0.15,
    hitCD: 60,
    onCreate: CircleHitboxEnemy,
    collides: false,
    radius: 65,
    ratio: 1
}));

ShubangelionRocks = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime > arg0.waitTime)
    {
        arg0.speed = 25;
        arg0.image_alpha = 1;
    }
    if (arg0.lifetime == 0)
    {
        arg0.image_index = irandom(3);
    }
    if (arg0.y > arg0.setY)
    {
        arg0.y = arg0.setY;
        arg0.speed = 0;
        for (var i = 0; i < 5; i++)
        {
            var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 1, obj_vfx);
            vfx.sprite_index = spr_ShubangelionRocks_Small;
            vfx.image_speed = 0;
            vfx.image_xscale = 2;
            vfx.image_yscale = 2;
            vfx.image_index = irandom(4);
            vfx.hspeed = -5 + random(10);
            vfx.vspeed = -5 - random(3);
            vfx.image_angle = irandom(359);
            vfx.duration = 60;
            vfx.gravity = 0.3;
        }
        soundPlay([241], "rocks", 10, 30, true);
        obj_AttackController.ExecuteAttack("ShubangelionRockHitBox", arg1, 
        {
            ratio: 1,
            x: arg0.x,
            y: arg0.y
        });
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

ds_map_set(attackIndex, "ShubangelionRocks", new Attack("ShubangelionRockHitBox", defaultConfig, 
{
    sprite_index: spr_ShubangelionRocks_Big,
    attackTime: 150,
    damage: 0.1,
    hitLimit: -1,
    collides: false,
    speed: 0,
    script: ShubangelionRocks,
    image_xscale: 2,
    image_alpha: 0,
    image_speed: 0,
    image_yscale: 2,
    hitCD: 30,
    direction: 270,
    duration: 120,
    setY: 0,
    lifetime: 0
}));
