GuraSharkSpecial = function(arg0)
{
    ApplyBuff(arg0, "GuraSpecial", ds_map_find_value(Buffs, "GuraSpecial"), 
    {
        buffIcon: 901
    });
};

ds_map_set(attackIndex, "GuraSharkSpecial", new Attack("GuraSharkSpecial", defaultConfig, 
{
    sprite_index: spr_GuraSharkSpecial,
    image_xscale: 1.25,
    image_yscale: 1.25,
    image_alpha: 0.8,
    damage: 5,
    attackTime: 120,
    playSound: [205],
    soundChannel: "special",
    soundPrio: 30,
    hitLimit: -1,
    duration: 175,
    startDistDirection: 0,
    collides: false,
    timeline: [
    {
        frame: 44,
        object: "CircleHitbox",
        type: "attack",
        config: 
        {
            damage: 5,
            radius: 250,
            collides: false
        }
    }, 
    {
        frame: 44,
        type: "shake",
        config: false
    }, 
    {
        frame: 44,
        type: "function",
        object: GuraSharkSpecial
    }, 
    {
        frame: 44,
        type: "sound",
        object: [7],
        config: false
    }],
    script: TimelineCustomAttack,
    isMain: true
}));

CalliSpecialFunction = function(arg0)
{
    ApplyBuff(arg0, "CalliSpecial", ds_map_find_value(Buffs, "CalliSpecial"), 
    {
        buffIcon: 2120
    });
};

function CalliImpact()
{
    draw_sprite_ext(spr_Calli_specialfx_front, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
}

ds_map_set(attackIndex, "CalliSpecial", new Attack("CalliSpecial", defaultConfig, 
{
    sprite_index: spr_Calli_specialfx,
    image_xscale: 0.8,
    image_yscale: 0.8,
    image_alpha: 0.8,
    damage: 3,
    stayOnCreator: true,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    isMain: true,
    duration: 150,
    collides: false,
    soundChannel: "special",
    customDrawScriptAbove: CalliImpact,
    soundPrio: 30,
    timeline: [
    {
        frame: 1,
        type: "sound",
        object: [178],
        config: false
    }, 
    {
        frame: 50,
        type: "sound",
        object: [68],
        config: false
    }, 
    {
        frame: 50,
        object: "CircleHitbox",
        type: "attack",
        config: 
        {
            damage: 1,
            radius: 200
        }
    }, 
    {
        frame: 50,
        type: "shake"
    }, 
    {
        frame: 50,
        type: "function",
        object: CalliSpecialFunction
    }],
    script: TimelineCustomAttack
}));

TakoSpin = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(300);
    }
    if (arg0.spinSpeed < 30)
    {
        arg0.spinSpeed += 0.2;
    }
    arg0.image_angle -= arg0.spinSpeed;
    obj_Cam.ExecuteShake(30, 3);
    arg0.lifetime++;
};

ds_map_set(attackIndex, "InaSpecial", new Attack("InaSpecial", defaultConfig, 
{
    sprite_index: spr_Ina_wheel,
    image_xscale: 1.3,
    image_yscale: 1.3,
    damage: 2.1,
    isMain: true,
    stayOnCreator: true,
    attackTime: 120,
    playSound: [160],
    soundChannel: "special",
    soundPrio: 30,
    hitLimit: -1,
    lifetime: 0,
    duration: room_speed * 5,
    drawBehind: true,
    spinSpeed: 0,
    script: TakoSpin,
    knockback: 
    {
        duration: 20,
        speed: 2,
        immunityBypass: true
    }
}));
ds_map_set(attackIndex, "PhoenixKB", new Attack("PhoenixKB", defaultConfig, 
{
    damage: -1,
    isMain: true,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 150,
    image_xscale: 3,
    image_yscale: 3,
    image_alpha: 0.8,
    hitCD: 120,
    hitLimit: -1,
    knockback: 
    {
        duration: 15,
        speed: 8
    }
}));
ds_map_set(attackIndex, "PhoenixExplosion", new Attack("PhoenixExplosion", defaultConfig, 
{
    damage: 6,
    isMain: true,
    sprite_index: spr_KiaraExplosion,
    attackTime: 150,
    image_xscale: 1.5,
    image_yscale: 1.5,
    hitCD: 120,
    hitLimit: -1,
    drawBehind: true,
    playSound: [28],
    attackDamageID: "KiaraPhoenix"
}));

KiaraPhoenix = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime < 103 && (arg0.lifetime % 3) == 0)
    {
        var vfx = instance_create_depth(irandom(640), 370, -9999, obj_screenVFX);
        vfx.sprite_index = spr_FireVFX;
        vfx.image_yscale = 0.5 + random(1);
        vfx.vspeed = -15 - random(10);
        vfx.image_alpha = 0.8;
        vfx.alarm[0] = 120;
    }
    if (arg0.lifetime == 1)
    {
        obj_PlayerManager.Dank(160);
        ApplyBuff(arg1, "ImmortalPhoenix", ds_map_find_value(Buffs, "ImmortalPhoenix"), 
        {
            buffIcon: 524
        });
        soundPlay([175], "phoenix", 10, 50);
    }
    if (arg0.lifetime == 55)
    {
        ExecuteAttack("PhoenixKB", arg1);
        obj_Cam.ExecuteShake(90);
        soundPlay([250], "phoenix", 60, 50);
        var vfx = instance_create_depth(arg0.x, arg0.y, -9999, obj_vfx);
        vfx.sprite_index = spr_KiaraPhoenix;
        vfx.add = true;
        vfx.image_index = 25;
        vfx.image_speed = 0;
        vfx.image_alpha = 0.8;
        vfx.alarm[0] = 1;
        vfx.alarm[1] = 1;
    }
    if (arg0.lifetime > 65)
    {
        var posX = lengthdir_x(175, arg0.startExplosionDir);
        var posY = lengthdir_y(140, arg0.startExplosionDir);
        if ((arg0.lifetime % 5) == 0 && arg0.lifetime < 120)
        {
            ExecuteAttack("PhoenixExplosion", arg1, 
            {
                startx: posX,
                starty: posY
            });
            arg0.startExplosionDir += 36;
        }
        posX = lengthdir_x(175, arg0.startBlazeDir);
        posY = lengthdir_y(140, arg0.startBlazeDir);
        if ((arg0.lifetime % 1) == 0)
        {
            ExecuteAttack("Trailblazer", arg1, 
            {
                startx: posX,
                starty: posY,
                damage: 0.5,
                duration: 600
            });
            arg0.startBlazeDir += 5;
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "KiaraPhoenix", new Attack("KiaraPhoenix", defaultConfig, 
{
    sprite_index: spr_KiaraPhoenix,
    image_xscale: 1.25,
    image_yscale: 1.25,
    collides: false,
    stayOnCreator: true,
    attackTime: 120,
    hitLimit: -1,
    duration: 140,
    drawBehind: true,
    isMain: true,
    lifetime: 0,
    image_alpha: 0.8,
    script: KiaraPhoenix,
    startExplosionDir: 90,
    startBlazeDir: 90,
    afterImageColor: 65535,
    knockback: 
    {
        duration: 20,
        speed: 6,
        immunityBypass: true
    }
}));

function HealingCircle()
{
    draw_set_alpha(0.15);
    draw_ellipse_color(x - 225, y - 132, x + 225, y + 132, c_white, make_color_rgb(252, 255, 142), false);
    draw_set_alpha(1);
}

MotherNature = function(arg0, arg1)
{
    var healCD, lifetime;
    if (arg0.lifetime == 1)
    {
        obj_PlayerManager.Dank(600);
        obj_Cam.ExecuteShake();
        obj_AttackController.ApplyBuff(arg1, "MotherNature", ds_map_find_value(obj_AttackController.Buffs, "MotherNature"), 
        {
            buffIcon: 143
        });
        soundPlay([84], "tree", 10, 50);
        arg0.emitter = part_emitter_create(global.psystem);
        part_emitter_region(global.psystem, arg0.emitter, arg0.x - 200, arg0.x + 200, arg0.y - 70, arg0.y - 270, 1, 0);
        part_emitter_stream(global.psystem, arg0.emitter, global.partType6, 2);
        part_system_depth(global.psystem, -9999);
    }
    if (arg0.lifetime == 5)
    {
        arg0.sprite_index = spr_FaunaTree;
    }
    if (arg0.lifetime >= 597)
    {
        part_emitter_destroy(global.psystem, arg0.emitter);
    }
    with (arg0)
    {
        if (arg0.healCD < 1)
        {
            if (place_meeting(x, y, arg1))
            {
                Heal(arg1, floor(arg1.HP * 0.25), 1);
                arg0.healCD = 60;
            }
        }
        if (place_meeting(x, y, arg1))
        {
            arg1.invincible = true;
            arg1.invincibilityTimer = 1;
        }
    }
    arg0.healCD--;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MotherNature", new Attack("MotherNature", defaultConfig, 
{
    sprite_index: spr_FaunaTreeFlash,
    image_xscale: 1.5,
    image_yscale: 1.5,
    image_alpha: 0.5,
    mask_index: spr_FaunaTreeMask,
    collides: false,
    emitter: 0,
    stayOnCreator: false,
    attackTime: 120,
    hitLimit: -1,
    duration: 600,
    drawBehind: true,
    drawUnderAll: false,
    lifetime: 0,
    healCD: 0,
    script: MotherNature,
    afterImageColor: 65535,
    customDrawScriptBelow: HealingCircle
}));

function AmeClock()
{
    if (image_alpha > 0)
    {
        draw_sprite_ext(spr_AmeClock, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.8 * image_alpha);
        draw_sprite_ext(spr_AmeHourHand, 0, x, y, image_xscale, image_yscale, hourHand, c_white, 0.8 * image_alpha);
        draw_sprite_ext(spr_AmeMinHand, 0, x, y, image_xscale, image_yscale, minHand, c_white, 0.8 * image_alpha);
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(spr_AmeClockGear, 0, x - 300, (y + 170) - (lifetime / 4), image_xscale * 2, image_yscale * 2, 30 + (lifetime * 1.5), c_white, 0.7 * image_alpha);
        draw_sprite_ext(spr_AmeClockGear, 0, x + 320, y - 50 - (lifetime / 4), image_xscale, image_yscale, 60 + (lifetime * 1.1), c_white, 0.7 * image_alpha);
        draw_sprite_ext(spr_AmeClockGear, 0, x - 200, y - 90 - (lifetime / 4), image_xscale / 2, image_yscale / 2, 100 + (lifetime * 1.2), c_white, 0.7 * image_alpha);
        draw_sprite_ext(spr_AmeClockGear, 0, x + 120, (y + 200) - (lifetime / 4), image_xscale * 0.7, image_yscale * 0.7, 250 + (lifetime * 1.7), c_white, 0.7 * image_alpha);
        gpu_set_blendmode(bm_normal);
        hourHand += (1 * spinRate);
        minHand += (2 * spinRate);
        if ((lifetime % 20) == 0)
        {
            if (spinRate > 0.5)
            {
                spinRate *= 0.7;
            }
        }
        if (lifetime > 180)
        {
            image_xscale += 0.2;
            image_yscale += 0.2;
            image_alpha -= 0.08;
        }
    }
}

AmeTimeTraveler = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 1)
    {
        obj_PlayerManager.Dank(200);
        obj_Cam.ExecuteShake();
        soundPlay([110], "timeslow", 10, 50);
        ApplyBuff(arg1, "AmeTimeTraveler", ds_map_find_value(Buffs, "AmeTimeTraveler"), 
        {
            buffIcon: 2124
        });
    }
    arg0.lifetime++;
    with (obj_Enemy)
    {
        obj_AttackController.ApplyBuff(id, "TimeTraveler", ds_map_find_value(obj_AttackController.Buffs, "TimeTraveler"));
    }
};

ds_map_set(attackIndex, "AmeTimeTraveler", new Attack("AmeTimeTraveler", defaultConfig, 
{
    image_xscale: 1,
    image_yscale: 1,
    damage: -1,
    stayOnCreator: true,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    duration: 600,
    collides: false,
    isMain: true,
    script: AmeTimeTraveler,
    lifetime: 0,
    drawBehind: true,
    drawUnderAll: true,
    customDrawScriptBelow: AmeClock,
    hourHand: 0,
    minHand: 0,
    spinRate: 20,
    afterImageColor: 65535
}));

RulerOfTimeBlast = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
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
    arg0.image_xscale += (0.08 * (30 - arg0.lifetime)) / 30;
    arg0.image_yscale += (0.08 * (30 - arg0.lifetime)) / 30;
};

ds_map_set(attackIndex, "RulerOfTimeBlast", new Attack("RulerOfTimeBlast", defaultConfig, 
{
    damage: 1,
    sprite_index: spr_KroniiTimeGate_blast,
    attackTime: 120,
    image_alpha: 0,
    image_xscale: 0,
    image_yscale: 0,
    attackCount: 1,
    playSound: [104],
    soundChannel: "special",
    hitCD: 30,
    attackDelay: 30,
    isMain: true,
    hitLimit: -1,
    duration: 30,
    lifetime: 0,
    drawBehind: true,
    attackDamageID: "RulerOfTime",
    onHitEffects: 
    {
        TimeFreeze: 
        {
            freezeTime: 120
        }
    },
    script: RulerOfTimeBlast
}));

function RulerOfTimeClock()
{
    if (image_alpha > 0)
    {
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(spr_KroniiTimeGate, 0, x, y, image_xscale * 2.5, image_yscale * 2.5, -lifetime * 2, c_white, 0.4 * image_alpha);
        draw_sprite_ext(spr_KroniiTimeGate, 0, x, y, image_xscale, image_yscale, lifetime, c_white, 0.4 * image_alpha);
        draw_sprite_ext(spr_KroniiTimeGate_Minute, 0, x, y, image_xscale, image_yscale, minHand, c_white, 0.75 * image_alpha);
        draw_sprite_ext(spr_KroniiTimeGate_Hour, 0, x, y, image_xscale, image_yscale, hourHand, c_white, 0.75 * image_alpha);
        gpu_set_blendmode(bm_normal);
        if (lifetime < 720)
        {
            minHand--;
        }
        if (lifetime < 720 && (lifetime % 60) == 0)
        {
            secondTick = 5;
        }
        if (secondTick > 0)
        {
            secondTick--;
            hourHand -= 6;
        }
        if (lifetime > 720)
        {
            image_xscale += 0.2;
            image_yscale += 0.2;
            image_alpha -= 0.08;
            soundPlay([103], "timegateend", 120, 50);
        }
    }
}

RulerOfTime = function(arg0, arg1)
{
    var number, lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(750);
        obj_Cam.ExecuteShake(60, 5);
        arg0.emitter = part_emitter_create(global.psystem);
        part_system_depth(global.psystem, -9999);
    }
    if (global.lightFX)
    {
        if ((arg0.lifetime % 5) == 0)
        {
            part_emitter_region(global.psystem, arg0.emitter, arg0.x - 300, arg0.x + 300, arg0.y - 200, arg0.y + 200, 0, 0);
            part_emitter_burst(global.psystem, arg0.emitter, global.partType8, 5);
        }
    }
    if (arg0.lifetime < 720 && (arg0.lifetime % 60) == 0)
    {
        arg0.number++;
        obj_AttackController.ExecuteAttack("RulerOfTimeBlast", arg0.creator, 
        {
            damage: arg0.damage * arg0.number,
            enhancements: arg0.enhancements,
            x: arg0.x,
            y: arg0.y
        });
    }
    if (arg0.lifetime > 720)
    {
        part_emitter_destroy(global.psystem, arg0.emitter);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "RulerOfTime", new Attack("RulerOfTime", defaultConfig, 
{
    image_xscale: 1,
    image_yscale: 1,
    damage: 0.4,
    isMain: true,
    stayOnCreator: true,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    duration: 780,
    collides: false,
    playSound: [133],
    soundChannel: "special",
    emitter: 0,
    script: RulerOfTime,
    lifetime: 0,
    drawBehind: true,
    drawUnderAll: true,
    customDrawScriptBelow: RulerOfTimeClock,
    hourHand: 0,
    minHand: 0,
    number: 0,
    secondTick: 0
}));

GiantSana = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        ApplyBuff(arg1, "SanaSpecial", ds_map_find_value(Buffs, "SanaSpecial"), 
        {
            buffIcon: 1937
        });
        obj_Cam.ExecuteShake();
        arg1.specMustWait = 601;
        arg1.invincible = true;
        arg1.invincibilityTimer = 600;
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
        vfx.sprite_index = vfx_smoke;
        vfx.image_xscale = -5;
        vfx.image_yscale = 5;
        vfx.image_alpha = 0.75;
        vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
        vfx.sprite_index = vfx_smoke;
        vfx.image_xscale = 5;
        vfx.image_yscale = 5;
        vfx.image_alpha = 0.75;
    }
    arg0.lifetime++;
    if (arg0.lifetime < 15)
    {
        arg0.sizeUp += 0.5;
        arg0.image_yscale = arg0.sizeUp;
        if (instance_exists(obj_Cam))
        {
            var cam = instance_find(obj_Cam, 0);
            cam.charCenterY = 16 * arg0.image_yscale;
        }
    }
    if (arg0.lifetime > 584)
    {
        arg0.sizeUp -= 0.5;
        arg0.image_yscale = arg0.sizeUp;
        if (instance_exists(obj_Cam))
        {
            var cam = instance_find(obj_Cam, 0);
            cam.charCenterY = 16 * arg0.image_yscale;
        }
    }
    arg0.sprite_index = arg1.sprite_index;
    arg0.image_index = arg1.image_index;
    arg0.depth = arg1.depth;
    arg0.x = arg1.x;
    arg0.y = arg1.y;
    arg0.image_xscale = (arg0.sizeUp * arg1.image_xscale) / abs(arg1.image_xscale);
    if (arg0.lifetime >= 595)
    {
        arg1.image_alpha = 1;
        arg1.invincible = false;
        if (instance_exists(obj_Cam))
        {
            var cam = instance_find(obj_Cam, 0);
            cam.charCenterY = 16;
            with (obj_EXP)
            {
                if (isInView)
                {
                    picked = true;
                }
            }
            with (obj_HoloCoinDrop)
            {
                if (isInView)
                {
                    picked = true;
                }
            }
        }
    }
};

ds_map_set(attackIndex, "GiantSana", new Attack("GiantSana", defaultConfig, 
{
    image_xscale: 5,
    image_yscale: 5,
    image_alpha: 0.9,
    damage: 2,
    isMain: true,
    stayOnCreator: false,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    hitCD: 30,
    playSound: [222],
    duration: 600,
    collides: true,
    stayOnCreator: false,
    script: GiantSana,
    lifetime: 0,
    sizeUp: 1,
    starty: 50,
    knockback: 
    {
        duration: 10,
        speed: 10,
        immunityBypass: true
    }
}));

MumeiHorror = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg1.invincible = true;
        arg1.invincibilityTimer = max(arg1.invincibilityTimer, 120);
    }
    if (arg0.lifetime == 10)
    {
        instance_create_depth(x, y, arg0.depth, obj_horror);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MumeiHorror", new Attack("MumeiHorror", defaultConfig, 
{
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.9,
    damage: 0,
    stayOnCreator: false,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    duration: 30,
    collides: false,
    script: MumeiHorror,
    lifetime: 0
}));

HopeExplodes = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_Cam.ExecuteShake(30, 3);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "HopeExplodes", new Attack("HopeExplodes", defaultConfig, 
{
    sprite_index: spr_IrysExplosionB,
    damage: 2.5,
    image_xscale: 3,
    image_yscale: 3,
    stayOnCreator: false,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    collides: true,
    hitCD: 60,
    playSound: [149],
    collides: true,
    lifetime: 0,
    isMain: true,
    script: HopeExplodes,
    attackDamageID: "HopeDescends"
}));

HopeFlower = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.image_alpha = 0.7;
        arg0.image_angle = irandom(360);
        arg0.x = (arg1.x - 200) + random(400);
        arg0.y = (arg1.y - 280) + random(100);
        arg0.hspeed = -3 + random(6);
        arg0.vspeed = 4;
        arg0.explodeTime = 40 + irandom(30);
    }
    arg0.image_angle += 4;
    arg0.lifetime++;
    if (arg0.lifetime == arg0.explodeTime)
    {
        ExecuteAttack("HopeExplodes", arg1, 
        {
            x: arg0.x,
            y: arg0.y
        });
        with (arg0)
        {
            instance_destroy();
        }
    }
};

ds_map_set(attackIndex, "HopeFlower", new Attack("HopeFlower", defaultConfig, 
{
    sprite_index: spr_IrysFlower,
    damage: 0,
    image_alpha: 0,
    image_xscale: 1.5,
    image_yscale: 1.5,
    stayOnCreator: false,
    drawBehind: true,
    drawUnderAll: true,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    isMain: true,
    collides: false,
    duration: 120,
    collides: false,
    script: HopeFlower,
    lifetime: 0,
    explodeTime: 50,
    attackDamageID: "HopeDescends"
}));

HopeDescends = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(320);
    }
    if ((arg0.lifetime % 20) == 0 && arg0.lifetime < 320)
    {
        ExecuteAttack("HopeFlower", arg1);
    }
    if (arg0.lifetime > 320)
    {
        arg0.image_alpha -= 0.05;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "HopeDescends", new Attack("HopeDescends", defaultConfig, 
{
    sprite_index: spr_IrysLight,
    image_alpha: 0.4,
    damage: 0,
    stayOnCreator: true,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    collides: false,
    isMain: true,
    hitCD: 30,
    playSound: [217],
    duration: 340,
    collides: false,
    script: HopeDescends,
    lifetime: 0,
    transparent: true
}));

BaeSpecial = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        ApplyBuff(arg1, "BaeSpecial", ds_map_find_value(Buffs, "BaeSpecial"), 
        {
            buffIcon: 2071
        });
        obj_Cam.ExecuteShake();
    }
    if (arg0.lifetime > 300)
    {
        arg0.image_alpha -= 0.02;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "BaeSpecial", new Attack("BaeSpecial", defaultConfig, 
{
    damage: 0,
    sprite_index: spr_animezoom,
    image_alpha: 0.4,
    transparent: true,
    stayOnCreator: false,
    collides: false,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    hitCD: 30,
    playSound: [222],
    duration: 320,
    stayOnCreator: true,
    script: BaeSpecial,
    lifetime: 0,
    starty: 0
}));

FubukiSword = function(arg0, arg1)
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
            arg0.direction = point_direction(arg0.x, arg0.y, arg1.x, arg1.y);
            arg0.image_angle = arg0.direction;
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
            soundPlay([34], "fubukistorm", 5, 4, true);
            arg0.times = 16;
        }
        arg0.collides = true;
        arg0.speed = arg0.projSpeed;
    }
    else
    {
        if (variable_instance_exists(arg0, "towardsX"))
        {
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.towardsX, arg0.towardsY);
            arg0.image_angle = arg0.direction;
        }
        else if (arg0.target != "noTarget" && instance_exists(arg0.target))
        {
            arg0.direction = point_direction(arg0.x, arg0.y, arg0.target.x, arg0.target.y);
            arg0.image_angle = arg0.direction;
        }
        arg0.times++;
    }
};

ds_map_set(attackIndex, "FubukiSword", new Attack("FubukiSword", defaultConfig, 
{
    sprite_index: spr_FubukiSword,
    attackTime: 150,
    damage: 1.25,
    hitLimit: -1,
    projSpeed: 35,
    isMain: true,
    playSound: [209],
    faceCreatorDirection: true,
    duration: 45,
    targetRandom: true,
    times: 0,
    script: FubukiSword,
    image_xscale: 2,
    image_yscale: 2,
    collides: false,
    afterImageColor: make_color_rgb(77, 187, 255),
    attackDamageID: "FubukiStorm"
}));

FubukiStorm = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(300);
        ApplyBuff(arg1, "FubukiStorm", ds_map_find_value(Buffs, "FubukiStorm"), 
        {
            buffIcon: 1600
        });
        arg1.invincible = true;
        arg1.invincibilityTimer = 300;
        arg0.emitter = part_emitter_create(global.psystem);
    }
    if (global.lightFX)
    {
        if ((arg0.lifetime % 3) == 0 && arg0.lifetime < 270)
        {
            part_emitter_region(global.psystem, arg0.emitter, arg0.x - 800, arg0.x + 200, arg0.y - 500, arg0.y + 100, 0, 0);
            part_emitter_burst(global.psystem, arg0.emitter, global.partType9, 7);
        }
    }
    if (arg0.lifetime > 270)
    {
        part_emitter_destroy(global.psystem, arg0.emitter);
    }
    if ((arg0.lifetime % 4) == 0)
    {
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
        ExecuteAttack("FubukiSword", arg1, 
        {
            x: swordX,
            y: swordY
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "FubukiStorm", new Attack("FubukiStorm", defaultConfig, 
{
    attackTime: 60,
    hitLimit: -1,
    lifetime: 0,
    isMain: true,
    duration: 300,
    targetRandom: true,
    stayOnCreator: true,
    script: FubukiStorm,
    emitter: 0,
    collides: false
}));

HatotaurusFists = function(arg0, arg1)
{
    var lifetime;
    if (global.screenshake)
    {
        obj_Cam.ExecuteShake(30, 2);
    }
    if (arg1.direction < 90 || arg1.direction > 270)
    {
        arg0.image_xscale = abs(arg0.image_xscale);
    }
    else if (arg1.direction > 90 && arg1.direction < 270)
    {
        arg0.image_xscale = -abs(arg0.image_xscale);
    }
    arg0.direction = 0;
    var vfx = instance_create_depth(arg0.x + (arg0.image_xscale * (50 + irandom(80))), (arg0.y - 90) + irandom(180), arg0.depth - 1, obj_vfx);
    vfx.sprite_index = spr_MioHatoPunches;
    if ((arg0.lifetime % 5) == 0)
    {
        soundPlay([31], "punchwoosh", 6, 20, true);
    }
    if ((arg0.lifetime % 7) == 0)
    {
        soundPlay([138], "punchimpact", 7, 40, true);
    }
    vfx.image_xscale = arg0.image_xscale;
    vfx.image_yscale = 2.5;
    vfx.add = true;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "HatotaurusFists", new Attack("HatotaurusFists", defaultConfig, 
{
    sprite_index: spr_MioHato_fists,
    attackTime: 60,
    hitLimit: -1,
    lifetime: 0,
    duration: 335,
    stayOnCreator: true,
    isMain: true,
    damage: 1.8,
    hitCD: 5,
    direction: 0,
    startDirection: 0,
    faceCreatorDirection: false,
    image_xscale: 2,
    image_yscale: 2.5,
    afterImageColor: 255,
    script: HatotaurusFists,
    attackDamageID: "Hatotaurus",
    starty: -50,
    lifetime: 0,
    knockback: 
    {
        duration: 3,
        speed: 2,
        immunityBypass: true
    }
}));

Hatotaurus = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(360);
        arg0.image_alpha = 0;
        var vfx = instance_create_depth(arg1.x, arg1.y, -99999, obj_vfx);
        vfx.duration = 360;
        vfx.followCharacter = arg1;
        vfx.sprite_index = spr_animezoom;
        vfx.image_alpha = 0.5;
        obj_AttackController.ApplyBuff(arg1, "Hatotaurus", ds_map_find_value(obj_AttackController.Buffs, "Hatotaurus"), 
        {
            buffIcon: 1827
        });
        vfx = instance_create_depth(arg1.x, arg1.y, -99999, obj_vfx);
        vfx.followCharacter = arg1;
        vfx.sprite_index = spr_MioGoGo;
        vfx.image_alpha = 0.85;
        vfx.duration = 100;
        vfx = instance_create_depth(arg1.x, arg1.y, -99999, obj_vfx);
        vfx.followCharacter = arg1;
        vfx.sprite_index = spr_MioGoGo2;
        vfx.image_alpha = 0.85;
        vfx.duration = 100;
        vfx = instance_create_depth(arg1.x, arg1.y, -99999, obj_vfx);
        vfx.followCharacter = arg1;
        vfx.sprite_index = spr_MioGoGo3;
        vfx.image_alpha = 0.85;
        vfx.duration = 100;
    }
    if (arg0.lifetime < 11)
    {
        if (arg0.image_alpha < 1)
        {
            arg0.image_alpha += 0.1;
        }
    }
    if (arg0.duration < 11)
    {
        arg0.image_alpha -= 0.1;
    }
    if (arg0.lifetime == 25)
    {
        arg0.sprite_index = spr_MioHato_loop;
        arg0.image_index = 0;
        obj_AttackController.ExecuteAttack("HatotaurusFists", arg1);
    }
    if (arg1.direction < 90 || arg1.direction > 270)
    {
        arg0.image_xscale = abs(arg0.image_xscale);
    }
    else if (arg1.direction > 90 && arg1.direction < 270)
    {
        arg0.image_xscale = -abs(arg0.image_xscale);
    }
    arg0.image_yscale = 1.5;
    arg0.direction = 0;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Hatotaurus", new Attack("Hatotaurus", defaultConfig, 
{
    sprite_index: spr_MioHato_start,
    attackTime: 60,
    hitLimit: -1,
    lifetime: 0,
    duration: 360,
    targetRandom: true,
    stayOnCreator: true,
    isMain: true,
    direction: 0,
    startDirection: 0,
    faceCreatorDirection: false,
    image_xscale: 1.5,
    image_yscale: 1.5,
    script: Hatotaurus,
    collides: false,
    afterImageColor: 255
}));

MoguMogu = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(360);
        arg1.invincible = true;
        arg1.invincibilityTimer = max(arg1.invincibilityTimer, 360);
        ApplyBuff(arg1, "MoguMogu", ds_map_find_value(Buffs, "MoguMogu"), 
        {
            buffIcon: 1826
        });
    }
    if (arg0.lifetime > 60)
    {
        arg0.image_xscale += 0.2;
        arg0.image_yscale += 0.2;
        arg0.image_alpha -= 0.08;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "MoguMogu", new Attack("MoguMogu", defaultConfig, 
{
    sprite_index: spr_OkayuMoguMoguTime,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    damage: 0,
    transparent: true,
    drawBehind: true,
    stayOnCreator: true,
    attackTime: 120,
    playSound: [245],
    hitLimit: -1,
    duration: 90,
    collides: false,
    script: MoguMogu,
    lifetime: 0
}));

function _KoroneYubigeddon(arg0, arg1)
{
    for (var quadrant = 0; quadrant < 4; quadrant++)
    {
        for (var i = 0; i < 3; i++)
        {
            var range = irandom(arg0.range);
            var dir = irandom(90) + (quadrant * 90);
            var pos = 
            {
                x: lengthdir_x(range, dir) + arg1.x,
                y: lengthdir_y(range, dir) + arg1.y
            };
            obj_AttackController.ExecuteAttack("KoroneYubi", arg1, pos);
        }
    }
}

ds_map_set(attackIndex, "KoroneYubigeddon", new Attack("KoroneYubigeddon", defaultConfig, 
{
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.8,
    damage: 0,
    transparent: true,
    drawBehind: true,
    stayOnCreator: true,
    attackTime: 120,
    playSound: [245],
    hitLimit: -1,
    collides: false,
    onCreate: _KoroneYubigeddon,
    duration: 420,
    lifetime: 0,
    range: 300,
    initial: 1,
    amountOfYubis: 16
}));
ds_map_set(attackIndex, "YubiExplosion", new Attack("YubiExplosion", defaultConfig, 
{
    sprite_index: spr_Explosion,
    damage: 3,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0.9,
    attackTime: 0,
    hitCD: 60,
    isMain: true,
    hitLimit: -1,
    lifetime: 0,
    playSound: [87],
    soundChannel: "yubiexplosion",
    attackDamageID: "KoroneYubi",
    destroyOnHitLimit: false,
    onHitEffects: 
    {
        YubiHit: {}
    }
}));

YubiExplodes = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.duration -= irandom(15);
        arg0.depth = -arg0.y + 50;
        obj_Cam.ExecuteShake(40, 4);
        obj_PlayerManager.Dank(120);
    }
    if (arg0.duration == 1)
    {
        obj_AttackController.ExecuteAttack("YubiExplosion", arg1, 
        {
            x: arg0.x,
            y: arg0.y - 40
        });
        obj_Cam.ExecuteShake(60, 5);
    }
    arg0.lifetime++;
};

function YubiSetTimer(arg0, arg1)
{
    arg0.explosionTimer = irandom(30);
    arg0.brainwashTimer = irandom(30);
}

function BlueFinger()
{
    if (lifetime > 25)
    {
        image_speed = 0;
    }
    if (lifetime > 50)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_blue, (0.8 * (lifetime - 50)) / 50);
    }
}

ds_map_set(attackIndex, "KoroneYubi", new Attack("KoroneYubi", defaultConfig, 
{
    sprite_index: spr_KoroneYubigeddon,
    damage: 2,
    attackDelay: 120,
    hitLimit: -1,
    hitCD: 60,
    lifetime: 0,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0.9,
    isMain: true,
    duration: 100,
    playSound: [179],
    soundChannel: "yubi",
    script: YubiExplodes,
    onCreate: YubiSetTimer,
    customDrawScriptAbove: BlueFinger,
    onHitEffects: 
    {
        YubiHit: {}
    }
}));
ds_map_set(attackIndex, "IdolWings", new Attack("IdolWings", defaultConfig, 
{
    damage: 0.7,
    stayOnCreator: true,
    attackTime: 600,
    playSound: false,
    hitLimit: -1,
    duration: 600,
    isMain: true,
    hitCD: 60,
    drawBehind: true,
    sprite_index: spr_SoraWings,
    image_alpha: 0.5,
    image_xscale: 3,
    image_yscale: 3,
    attackDamageID: "IdolDream",
    starty: 0,
    onHitEffects: 
    {
        IdolDream: {}
    }
}));

IdolDream = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(600);
        var wings = instance_create_depth(arg1.x, arg1.y, arg1.depth - 5, obj_wings);
        wings.image_xscale = 3;
        wings.image_yscale = 3;
        ExecuteAttack("IdolWings", arg1);
        ApplyBuff(arg1, "IdolDream", ds_map_find_value(Buffs, "IdolDream"), 
        {
            buffIcon: 1007
        });
        if (global.lightFX)
        {
            arg0.emitter = part_emitter_create(global.psystem);
            part_emitter_region(global.psystem, arg0.emitter, arg1.x - 200, arg1.x + 200, arg1.y - 70, arg1.y - 270, 1, 0);
            part_emitter_stream(global.psystem, arg0.emitter, global.partType6, 1);
            part_system_depth(global.psystem, -9999);
        }
    }
    arg0.lifetime++;
    if (part_emitter_exists(global.psystem, arg0.emitter))
    {
        part_emitter_region(global.psystem, arg0.emitter, arg1.x - 200, arg1.x + 200, arg1.y - 70, arg1.y - 270, 1, 0);
    }
};

ds_map_set(attackIndex, "IdolDream", new Attack("IdolDream", defaultConfig, 
{
    damage: -1,
    stayOnCreator: true,
    attackTime: 600,
    playSound: false,
    hitLimit: -1,
    duration: 600,
    isMain: true,
    collides: false,
    playSound: [217],
    sprite_index: spr_IrysLight,
    emitter: 0,
    image_alpha: 0.3,
    lifetime: 0,
    transparent: true,
    script: IdolDream
}));

ConcertLights = function(arg0, arg1)
{
    var lifetime;
    arg0.image_angle += arg0.rotSpeed;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "ConcertLights", new Attack("ConcertLights", defaultConfig, 
{
    damage: 1.35,
    stayOnCreator: true,
    attackTime: 360,
    playSound: false,
    hitLimit: -1,
    duration: 360,
    isMain: true,
    hitCD: 15,
    drawBehind: true,
    transparent: true,
    image_alpha: 1,
    image_xscale: 2,
    lifetime: 0,
    rotSpeed: 2,
    image_yscale: 0.8,
    script: ConcertLights,
    starty: -16,
    playSound: [11],
    attackDamageID: "FullConcert",
    soundChannel: "twinkle",
    knockback: 
    {
        duration: 3,
        speed: 2,
        immunityBypass: true
    }
}));

FullConcert = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(360);
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_yellowlight,
            image_angle: 45
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_greenlight,
            image_angle: 90
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_red_light,
            image_angle: 135
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_purplelight,
            image_angle: 180
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_bluelight,
            image_angle: 225
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_yellowlight,
            image_angle: 270
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_greenlight,
            image_angle: 315
        });
        ExecuteAttack("ConcertLights", arg1, 
        {
            sprite_index: spr_gacha_red_light,
            image_angle: 0
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "FullConcert", new Attack("FullConcert", defaultConfig, 
{
    damage: -1,
    stayOnCreator: true,
    attackTime: 360,
    playSound: false,
    hitLimit: -1,
    duration: 600,
    collides: false,
    playSound: [242],
    emitter: 0,
    image_alpha: 0.2,
    isMain: true,
    lifetime: 0,
    transparent: true,
    script: FullConcert
}));

HiSpec = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(480);
        obj_Cam.ExecuteShake(60, 4);
        ApplyBuff(arg1, "HiSpec", ds_map_find_value(Buffs, "HiSpec"), 
        {
            buffIcon: 459
        });
        audio_play_sound(snd_hispec, 50, 0);
        var vfx = instance_create_depth(arg1.x, arg1.y, arg1.depth + 55, obj_vfx);
        vfx.sprite_index = spr_RobocoHiSpec;
        vfx.add = true;
        vfx.followCharacter = arg1;
    }
    if (arg0.lifetime == 5)
    {
        ExecuteAttack("RoboDischarge", arg1, 
        {
            baseDamage: 3,
            sprite_index: spr_RobocoElectricSpec,
            image_xscale: 1,
            image_yscale: 1,
            duration: 70,
            isSkill: false,
            isMain: true,
            attackDamageID: "HiSpec"
        });
    }
    if ((arg0.lifetime % 3) == 0)
    {
        var afterimage = instance_create_depth(arg1.x, arg1.y, arg1.depth + 55, obj_afterImage);
        afterimage.sprite_index = arg1.sprite_index;
        afterimage.image_speed = 0;
        afterimage.image_index = arg1.image_index;
        afterimage.image_xscale = arg1.image_xscale;
        afterimage.image_yscale = arg1.image_yscale;
        afterimage.afterimage_color = 255;
        afterimage.image_angle = arg1.image_angle;
        afterimage.image_alpha = 0.8;
        afterimage.grow = true;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "HiSpec", new Attack("HiSpec", defaultConfig, 
{
    damage: 0,
    transparent: true,
    drawBehind: true,
    stayOnCreator: true,
    attackTime: 480,
    hitLimit: -1,
    duration: 480,
    collides: false,
    script: HiSpec,
    lifetime: 0
}));
ds_map_set(attackIndex, "DemonLordFire", new Attack("DemonLordFire", defaultConfig, 
{
    sprite_index: spr_DragonFire,
    damage: 0.4,
    collides: false,
    speed: 15,
    hitLimit: -1,
    isMain: true,
    afterImageColor: 4235519,
    faceCreatorDirection: false,
    direction: 90,
    image_angle: 90,
    image_xscale: 0.8,
    image_yscale: 0.8,
    image_alpha: 0.6,
    lifetime: 0,
    playSound: [275],
    soundChannel: "demonlord",
    soundCD: 10,
    soundPrio: 5,
    soundPitch: true,
    stayOnCreator: false,
    duration: 20,
    attackDamageID: "DemonLord"
}));

DemonLord = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(480);
        obj_Cam.ExecuteShake(60, 6);
        if (global.lightFX)
        {
            arg0.emitter = part_emitter_create(global.psystem);
            part_emitter_stream(global.psystem, arg0.emitter, global.partType10, 2);
            part_system_depth(global.psystem, -9999);
        }
    }
    if (global.lightFX)
    {
        if (part_emitter_exists(global.psystem, arg0.emitter))
        {
            part_emitter_region(global.psystem, arg0.emitter, arg0.x - 250, arg0.x + 250, arg0.y + 200, arg0.y - 200, 1, 0);
        }
    }
    var dist = irandom(250);
    if (arg0.lifetime > 29)
    {
        ExecuteAttack("DemonLordFire", arg1, 
        {
            x: arg1.x + lengthdir_x(dist, irandom(359)),
            y: arg1.y + lengthdir_y(dist, irandom(359))
        });
        ExecuteAttack("DemonLordFire", arg1, 
        {
            x: arg1.x + lengthdir_x(dist, irandom(359)),
            y: arg1.y + lengthdir_y(dist, irandom(359))
        });
    }
    if (arg0.lifetime == 28)
    {
        arg0.collides = true;
        arg0.sprite_index = spr_MikoDemonLord_Loop;
        arg0.image_index = 0;
    }
    if (arg0.duration < 10)
    {
        if (part_emitter_exists(global.psystem, arg0.emitter))
        {
            part_emitter_destroy(global.psystem, arg0.emitter);
        }
        arg0.image_alpha -= 0.1;
    }
    if (global.lightFX)
    {
        if (arg0.lifetime < 60 && (arg0.lifetime % 3) == 0)
        {
            var vfx = instance_create_depth(irandom(640), 370, -9999, obj_screenVFX);
            vfx.sprite_index = spr_FireVFX;
            vfx.image_yscale = 0.5 + random(1);
            vfx.vspeed = -15 - random(10);
            vfx.image_alpha = 0.8;
            vfx.alarm[0] = 120;
        }
    }
    arg0.lifetime += 1;
};

ds_map_set(attackIndex, "DemonLord", new Attack("DemonLord", defaultConfig, 
{
    sprite_index: spr_MikoDemonLord_Start,
    collides: false,
    projSpeed: 0,
    hitLimit: -1,
    drawBehind: true,
    isMain: true,
    stayOnCreator: true,
    destroyOnHitLimit: false,
    emitter: -1,
    faceCreatorDirection: false,
    hitCD: 30,
    damage: 0.8,
    drawUnderAll: true,
    duration: 480,
    script: DemonLord,
    image_xscale: 4.5,
    image_yscale: 3,
    image_alpha: 0.5,
    playSound: [54],
    soundPrio: 50,
    lifetime: 0,
    starty: 0,
    onHitEffects: 
    {
        DemonLordHit: {}
    }
}));

ChangeOfHeart = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.collides = true;
        audio_play_sound(snd_formchange, 30, 0);
        if (arg1.haatoMode == 0)
        {
            obj_PlayerManager.Dank(2);
            obj_AttackController.ApplyBuff(arg1, "HaachamaMode", ds_map_find_value(obj_AttackController.Buffs, "HaachamaMode"), 
            {
                buffIcon: 800
            });
            obj_AttackController.RemoveBuff(arg1, "HaatoMode");
            arg0.sprite_index = spr_HaatoBlackHeart;
            arg0.knockback.speed = 1;
            arg0.knockback.duration = 1;
            arg0.damage *= 3;
            arg1.haatoMode = 1;
            var afterimage = instance_create_depth(arg1.x, arg1.y, arg1.depth + 55, obj_afterImage);
            afterimage.sprite_index = arg1.sprite_index;
            afterimage.image_speed = 0;
            afterimage.image_index = arg1.image_index;
            afterimage.image_xscale = arg1.image_xscale;
            afterimage.image_yscale = arg1.image_yscale;
            afterimage.afterimage_color = 8388736;
            afterimage.image_angle = arg1.image_angle;
            afterimage.image_alpha = 1;
            afterimage.grow = true;
            afterimage.growthRate = 0.15;
        }
        else if (arg1.haatoMode == 1)
        {
            obj_PlayerManager.Dank(2);
            obj_AttackController.ApplyBuff(arg1, "HaatoMode", ds_map_find_value(obj_AttackController.Buffs, "HaatoMode"), 
            {
                buffIcon: 2144
            });
            obj_AttackController.RemoveBuff(arg1, "HaachamaMode");
            arg1.haatoMode = 0;
            var afterimage = instance_create_depth(arg1.x, arg1.y, arg1.depth + 55, obj_afterImage);
            arg0.sprite_index = spr_HaatoRedHeart;
            arg0.knockback.speed = 10;
            arg0.knockback.duration = 10;
            afterimage.sprite_index = arg1.sprite_index;
            afterimage.image_speed = 0;
            afterimage.image_index = arg1.image_index;
            afterimage.image_xscale = arg1.image_xscale;
            afterimage.image_yscale = arg1.image_yscale;
            afterimage.afterimage_color = 255;
            afterimage.image_angle = arg1.image_angle;
            afterimage.image_alpha = 1;
            afterimage.grow = true;
            afterimage.growthRate = 0.15;
        }
        if (variable_struct_exists(arg1.buffs, "Coexistence"))
        {
            if (arg1.buffs.Coexistence.config.stacks >= arg1.buffs.Coexistence.config.maxStacks)
            {
                obj_PlayerManager.Dank(300);
                arg1.savedMode = arg1.haatoMode;
                arg1.haatoMode = 2;
                arg0.damage *= 3;
                arg0.knockback.speed = 10;
                arg0.knockback.duration = 10;
                var newBuffConfig = ds_map_find_value(obj_AttackController.Buffs, "FinalHaato");
                if (global.screenshake)
                {
                    obj_Cam.ExecuteShake(60, 7);
                }
                newBuffConfig.timer = arg1.scripts.Coexistence.config.buffDuration;
                obj_AttackController.ApplyBuff(arg1, "FinalHaato", newBuffConfig, 
                {
                    buffIcon: 1397
                });
                obj_AttackController.RemoveBuff(arg1, "Coexistence");
                var horror = instance_create_depth(arg1.x, arg1.y, arg1.depth + 50, obj_eldrich);
                horror.creator = arg1;
            }
        }
        arg1.OnSpecial(arg1);
    }
    arg0.image_xscale = 1.5 * logn(1.5, arg0.lifetime + 1);
    arg0.image_yscale = 1.5 * logn(1.5, arg0.lifetime + 1);
    arg0.image_alpha -= 0.04;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "ChangeOfHeart", new Attack("ChangeOfHeart", defaultConfig, 
{
    sprite_index: spr_HaatoRedHeart,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0.9,
    collides: false,
    damage: 1,
    isMain: true,
    stayOnCreator: false,
    attackTime: 120,
    hitLimit: -1,
    hitCD: 30,
    duration: 25,
    collides: false,
    transparent: true,
    drawBehind: true,
    stayOnCreator: false,
    script: ChangeOfHeart,
    lifetime: 0,
    knockback: 
    {
        duration: 10,
        speed: 10,
        immunityBypass: true
    }
}));

Banpire = function(arg0, arg1)
{
    var lifetime;
    with (obj_Enemy)
    {
        Freeze(30);
    }
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(240);
        obj_AttackController.ApplyBuff(arg1, "Banpire", ds_map_find_value(obj_AttackController.Buffs, "Banpire"), 
        {
            buffIcon: 1511
        });
    }
    if (arg0.lifetime < 10)
    {
        arg0.image_xscale -= 0.31;
        arg0.image_yscale -= 0.31;
        arg0.image_alpha += 0.1;
    }
    else
    {
        arg0.collides = true;
        arg0.image_xscale = 1.5;
        arg0.image_yscale = 1.5;
        arg0.image_alpha = 1;
    }
    arg0.depth = arg1.depth - 50;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Banpire", new Attack("Banpire", defaultConfig, 
{
    stayOnCreator: false,
    faceCreatorDirection: false,
    attackTime: 90,
    hitLimit: -1,
    damage: 2,
    hitCD: 30,
    collides: false,
    sprite_index: spr_MelBanned,
    playSound: [249],
    image_xscale: 4.5,
    image_yscale: 4.5,
    image_alpha: 0,
    drawBehind: false,
    stayOnCreator: true,
    lifetime: 0,
    duration: 240,
    script: Banpire,
    isMain: true,
    onHitEffects: 
    {
        Banned: {}
    }
}));

Fireworks = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        soundPlay([239], "drums", 5, 40, 0);
        arg0.emitter = part_emitter_create(global.psystem);
    }
    if (arg0.lifetime == 15)
    {
        obj_Cam.ExecuteShake(60, 5);
        soundPlay([13], "drums", 5, 40, 0);
        soundPlay([279], "firewokrs", 5, 40, 0);
        ApplyBuff(arg1, "Wasshoi", ds_map_find_value(Buffs, "Wasshoi"), 
        {
            buffIcon: 661,
            weight1: 0.4,
            weight2: 0.3
        });
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_vfx);
        vfx.sprite_index = bg_spotlight;
        vfx.duration = 60;
        vfx.image_xscale = 0.4;
        vfx.image_yscale = 0.4;
        vfx.image_alpha = 0.9;
        vfx.add = true;
        vfx.alarm[0] = 1;
        vfx.growthRate = 0.001;
        vfx.alarm[1] = 10;
        part_emitter_region(global.psystem, arg0.emitter, arg0.x, arg0.x, arg0.y, arg0.y, 0, 0);
        part_emitter_burst(global.psystem, arg0.emitter, global.partType15, 100);
        part_emitter_burst(global.psystem, arg0.emitter, global.partType16, 120);
        part_emitter_burst(global.psystem, arg0.emitter, global.partType17, 140);
        arg0.sprite_index = spr_Ame_bubbabark;
        arg0.image_index = 0;
        arg0.image_alpha = 0.1;
        arg0.collides = true;
        arg0.image_xscale = 5;
        arg0.image_yscale = 5;
        arg0.duration = 15;
        arg0.speed = 0;
        arg0.gravity = 0;
    }
    if (arg0.lifetime < 15)
    {
        arg0.direction = 90;
        arg0.speed = 7;
        arg0.gravity = 0.5;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Fireworks", new Attack("Fireworks", defaultConfig, 
{
    sprite_index: spr_gachaorb,
    image_alpha: 0.8,
    damage: 5,
    stayOnCreator: false,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    collides: false,
    isMain: true,
    hitCD: 30,
    duration: 90,
    collides: false,
    drawBehind: true,
    script: Fireworks,
    emitter: 0,
    attackDamageID: "MatsuriTaiko",
    lifetime: 0,
    knockback: 
    {
        duration: 15,
        speed: 15,
        immunityBypass: true
    }
}));
ds_map_set(attackIndex, "TaikoBurst", new Attack("TaikoBurst", defaultConfig, 
{
    damage: 2,
    sprite_index: spr_Ame_bubbabark,
    attackTime: 0,
    attackCount: 1,
    image_xscale: 0.5,
    image_yscale: 0.5,
    image_alpha: 0.8,
    attackDelay: 30,
    attackDamageID: "MatsuriTaiko",
    hitLimit: -1,
    drawBehind: true,
    isMain: true,
    knockback: 
    {
        duration: 5,
        speed: 5,
        immunityBypass: true
    }
}));

MatsuriTaiko = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg1.specMustWait = 301;
        obj_PlayerManager.Dank(360);
        obj_PlayerManager.holdLevel = 280;
        var drum = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_Drum);
        drum.creator = arg1;
    }
    arg0.lifetime++;
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    with (obj_Enemy)
    {
        obj_AttackController.ApplyBuff(id, "MatsuriTime", ds_map_find_value(obj_AttackController.Buffs, "MatsuriTime"));
    }
};

ds_map_set(attackIndex, "MatsuriTaiko", new Attack("MatsuriTaiko", defaultConfig, 
{
    sprite_index: spr_MatsuriDrum,
    image_alpha: 0.8,
    damage: 0,
    stayOnCreator: true,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    collides: false,
    isMain: true,
    hitCD: 30,
    duration: 280,
    collides: false,
    drawBehind: true,
    customDrawScriptAbove: MatsuriTaiko,
    lifetime: 0
}));

RosePetal = function(arg0, arg1)
{
    if (arg0.lifetime == 0)
    {
        arg0.horiWidth = 2 + irandom(22);
        arg0.image_index = irandom(4);
        arg0.image_speed = 0;
        arg0.image_alpha = 0.9;
        arg0.collides = true;
        arg0.direction = irandom(1) * 90;
        arg0.projSpeed = 5 + irandom(10);
    }
    arg0.image_angle = 0;
    arg0.y -= arg0.projSpeed;
    arg0.lifetime += 0.1;
    if (arg0.direction == 90)
    {
        arg0.x -= sin(1.5707963267948966 + arg0.lifetime) * arg0.horiWidth;
    }
    else
    {
        arg0.x += sin(1.5707963267948966 + arg0.lifetime) * arg0.horiWidth;
    }
};

ds_map_set(attackIndex, "RosePetal", new Attack("RosePetal", defaultConfig, 
{
    sprite_index: spr_AkiRose,
    attackTime: 150,
    damage: 0.25,
    hitLimit: -1,
    projSpeed: 10,
    isMain: true,
    playSound: [62],
    soundPitch: true,
    duration: 40,
    soundChannel: "rose",
    soundCD: 15,
    targetRandom: true,
    attackDamageID: "Shallys",
    script: RosePetal,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 0,
    horiWidth: 4,
    lifetime: 0,
    collides: false,
    onHitEffects: 
    {
        SlowDown: 
        {
            amount: 0.2,
            chance: 100
        }
    }
}));

Shallys = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(360);
        soundPlay([15], "flurry", 10, 30, 0);
        ApplyBuff(arg1, "Shallys", ds_map_find_value(Buffs, "Shallys"), 
        {
            buffIcon: 235
        });
        if (global.lightFX)
        {
            arg0.emitter = part_emitter_create(global.psystem);
            part_emitter_region(global.psystem, arg0.emitter, arg1.x - 400, arg1.x + 200, arg1.y + 200, arg1.y + 210, 1, 0);
            part_emitter_stream(global.psystem, arg0.emitter, global.partType13, 2);
            part_system_depth(global.psystem, -9999);
        }
        arg1.scripts.Shallys = 
        {
            Script: function(arg0, arg1)
            {
                if (arg0.scripts.Shallys.config.timer > 0)
                {
                    arg0.scripts.Shallys.config.timer--;
                }
                if (arg0.scripts.Shallys.config.timer == 0 && arg0.currentHP > 0)
                {
                    var healVal = max(1, arg1.healAmount * arg0.HP);
                    Heal(arg0, healVal, 1, true, false);
                    arg0.scripts.Shallys.config.timer = arg0.scripts.Shallys.config.maxTimer;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 60,
                healAmount: 0.2
            }
        };
    }
    ExecuteAttack("RosePetal", arg1, 
    {
        x: arg1.x,
        y: arg1.y + 200
    });
    if (part_emitter_exists(global.psystem, arg0.emitter))
    {
        part_emitter_region(global.psystem, arg0.emitter, arg1.x - 400, arg1.x + 300, arg1.y + 200, arg1.y + 210, 1, 0);
    }
    arg0.lifetime++;
    if (arg0.duration <= 1)
    {
        if (variable_struct_exists(arg1.scripts, "Shallys"))
        {
            variable_struct_remove(arg1.scripts, "Shallys");
        }
    }
};

ds_map_set(attackIndex, "Shallys", new Attack("Shallys", defaultConfig, 
{
    sprite_index: spr_IrysLight,
    attackTime: 60,
    hitLimit: -1,
    lifetime: 0,
    isMain: true,
    image_alpha: 0.25,
    playSound: [147],
    duration: 360,
    soundChannel: "holy",
    targetRandom: true,
    stayOnCreator: true,
    script: Shallys,
    emitter: 0,
    collides: false,
    transparent: true
}));

DuckShoutWaves = function(arg0, arg1)
{
    var lifetime;
    arg0.lifetime++;
    arg0.image_xscale += 0.01;
    arg0.image_yscale += 0.04;
    arg0.image_angle = arg0.direction;
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
};

ds_map_set(attackIndex, "DuckShoutWaves", new Attack("DuckShoutWaves", defaultConfig, 
{
    damage: 1.2,
    sprite_index: spr_SubaruASMR,
    attackTime: 0,
    image_xscale: 0.1,
    image_yscale: 0.4,
    image_alpha: 0.8,
    attackDelay: 30,
    playSound: [47],
    soundChannel: "duckwaves",
    soundPitch: true,
    speed: 6,
    lifetime: 0,
    faceCreatorDirection: true,
    hitCD: 10,
    script: DuckShoutWaves,
    hitLimit: -1,
    duration: 60,
    isMain: true,
    attackDamageID: "DuckShout",
    afterImageColor: 65535,
    knockback: 
    {
        duration: 4,
        speed: 4,
        immunityBypass: true
    }
}));

DuckShout = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(300);
        obj_Cam.ExecuteShake(300, 3);
    }
    if ((arg0.lifetime % 10) == 0)
    {
        obj_AttackController.ExecuteAttack("DuckShoutWaves", arg1, {});
    }
    arg0.lifetime++;
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
};

ds_map_set(attackIndex, "DuckShout", new Attack("DuckShout", defaultConfig, 
{
    collides: false,
    sprite_index: spr_animezoom,
    image_alpha: 0.7,
    starty: 0,
    attackTime: 0,
    attackDelay: 30,
    playSound: [49],
    soundChannel: "duckshout",
    speed: 0,
    lifetime: 0,
    stayOnCreator: true,
    hitCD: 10,
    script: DuckShout,
    hitLimit: -1,
    duration: 240,
    isMain: true
}));

DynamiteBodyHearts = function(arg0, arg1)
{
    var lifetime;
    arg0.lifetime++;
    arg0.image_xscale += 0.04;
    arg0.image_yscale += 0.04;
    if (arg0.duration < 20)
    {
        arg0.image_alpha -= 0.05;
    }
};

ds_map_set(attackIndex, "DynamiteBodyHearts", new Attack("DynamiteBodyHearts", defaultConfig, 
{
    damage: 2,
    sprite_index: spr_ChocoSpecialHeart,
    attackTime: 0,
    image_xscale: 0.1,
    image_yscale: 0.1,
    image_alpha: 0.7,
    attackDelay: 30,
    drawBehind: true,
    drawUnderAll: true,
    playSound: [10],
    soundChannel: "duckwaves",
    attackDamageID: "DynamiteBody",
    soundPitch: true,
    lifetime: 0,
    hitCD: 20,
    stayOnCreator: true,
    script: DynamiteBodyHearts,
    hitLimit: -1,
    duration: 50,
    isMain: true,
    onHitEffects: 
    {
        DynamiteBodyConvert: 
        {
            chance: 30
        }
    }
}));

DynamiteBody = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(480);
    }
    if ((arg0.lifetime % 60) == 0)
    {
        obj_AttackController.ExecuteAttack("DynamiteBodyHearts", arg1, {});
    }
    arg0.lifetime++;
    with (obj_Enemy)
    {
        obj_AttackController.ApplyBuff(self, "DyanmiteBody", ds_map_find_value(obj_AttackController.Buffs, "DynamiteBody"));
    }
    if (global.lightFX)
    {
        if ((arg0.lifetime % 10) == 0)
        {
            var vfx = instance_create_depth((arg1.x - 320) + random(640), (arg0.y - 180) + random(360), arg1.depth + 10, obj_vfx);
            vfx.sprite_index = spr_ChocoSpecialHeart;
            vfx.duration = 60;
            vfx.image_xscale = 0.2;
            vfx.image_yscale = 0.2;
            vfx.image_alpha = 0.5;
            vfx.alarm[1] = 1;
            vfx.fadeSpeed = 0.01;
            vfx.vspeed = -2;
        }
    }
};

function DynamiteBodyBG(arg0, arg1)
{
    draw_set_alpha(0.3 * abs(sin(lifetime / 20)));
    draw_set_color(make_color_rgb(255, 88, 150));
    draw_rectangle(arg1.x - 400, arg1.y - 400, arg1.x + 400, arg1.y + 400, false);
    draw_set_alpha(1);
}

ds_map_set(attackIndex, "DynamiteBody", new Attack("DynamiteBody", defaultConfig, 
{
    collides: false,
    image_alpha: 0.7,
    starty: 0,
    attackTime: 0,
    attackDelay: 30,
    playSound: [80],
    soundChannel: "duckshout",
    speed: 0,
    lifetime: 0,
    stayOnCreator: true,
    drawBehind: true,
    drawUnderAll: true,
    hitCD: 10,
    script: DynamiteBody,
    customDrawScriptBelow: DynamiteBodyBG,
    hitLimit: -1,
    duration: 480,
    isMain: true
}));

KusogaKickExplosion = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.damage += (obj_PlayerManager.numberOfOwnedWeapons - 1) * 2;
        var vfx = instance_create_depth(arg0.x, arg0.y, 450, obj_vfx);
        vfx.sprite_index = spr_groundcrack;
        vfx.duration = 80;
        vfx.image_xscale = 1.5;
        vfx.image_yscale = 1.5;
        vfx.image_alpha = 0.8;
        vfx.alarm[1] = 60;
        obj_Cam.ExecuteShake(120, 10);
        for (var i = 0; i < 10; i++)
        {
            vfx = instance_create_depth(arg0.x + lengthdir_x(150, i * 36), arg0.y + lengthdir_y(150, i * 36), arg0.depth - 10, obj_vfx);
            vfx.sprite_index = spr_bombExplode;
            vfx.image_xscale = 3;
            vfx.image_yscale = 3;
            vfx.image_alpha = 0.8;
            vfx.spriteColor = 8388736;
        }
        var targets = ds_list_create();
        if (instance_exists(obj_Enemy))
        {
            collision_ellipse_list(arg0.x - 300, arg0.y - 170, arg0.x + 300, arg0.y + 170, 367, true, true, targets, false);
        }
        for (var i = 0; i < ds_list_size(targets); i++)
        {
            var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), arg1, arg0);
            if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
            {
                ds_list_find_value(targets, i).TakeDamage(dmgObj[0], arg0, dmgObj[1], "KusogaKick");
            }
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "KusogaKickExplosion", new Attack("KusogaKickExplosion", defaultConfig, 
{
    sprite_index: spr_bombExplode,
    damage: 10,
    image_alpha: 0.9,
    isMain: true,
    stayOnCreator: false,
    image_xscale: 3,
    image_yscale: 3,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    attackDamageID: "KusogaKick",
    hitCD: 30,
    collides: false,
    stayOnCreator: false,
    starty: 10,
    script: KusogaKickExplosion,
    lifetime: 0,
    spriteColor: 8388736,
    knockback: 
    {
        duration: 20,
        speed: 15,
        immunityBypass: true
    }
}));

KusogaKick = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        ApplyBuff(arg1, "ShionSpecial", ds_map_find_value(Buffs, "ShionSpecial"), 
        {
            buffIcon: 2155
        });
        obj_Cam.ExecuteShake();
        arg1.specMustWait = 200;
        obj_PlayerManager.Dank(240);
        arg1.invincible = true;
        arg1.invincibilityTimer = 260;
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
        vfx.sprite_index = vfx_smoke;
        vfx.image_xscale = -4;
        vfx.image_yscale = 4;
        vfx.image_alpha = 0.75;
        vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
        vfx.sprite_index = vfx_smoke;
        vfx.image_xscale = 4;
        vfx.image_yscale = 4;
        vfx.image_alpha = 0.75;
        vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 10, obj_vfx);
        vfx.sprite_index = spr_ShionJump;
        vfx.direction = 90;
        vfx.speed = 15;
        vfx.duration = 15;
        vfx.image_alpha = 1;
    }
    arg0.image_alpha = 0.7 + (sin(arg0.lifetime / 2) * 0.1);
    if (arg0.lifetime < 10)
    {
        arg0.image_xscale = 0.2 * logn(1.3, arg0.lifetime + 1);
        arg0.image_yscale = 0.12 * logn(1.3, arg0.lifetime + 1);
    }
    if (arg0.lifetime == 178)
    {
        var vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth - 2000, obj_vfx);
        vfx.sprite_index = spr_ShionBeam;
        vfx.add = true;
        vfx.image_xscale = 2;
        vfx.image_yscale = 2;
        vfx.image_alpha = 0.8;
        vfx.followCharacter = arg1;
        vfx = instance_create_depth(arg0.x, arg0.y, arg0.depth, obj_vfx);
        vfx.sprite_index = spr_GlowStickExplode_Purple;
        vfx.add = true;
        vfx.image_xscale = 6;
        vfx.image_yscale = 4;
        vfx.image_alpha = 0.2;
        vfx.followCharacter = arg1;
        soundPlay([102], "kusogakick", 30, 30);
    }
    if (arg0.lifetime == 199)
    {
        obj_AttackController.ExecuteAttack("KusogaKickExplosion", arg1);
        if (global.lightFX)
        {
            arg0.emitter = part_emitter_create(global.psystem);
            part_system_depth(global.psystem, -9999);
            part_emitter_region(global.psystem, arg0.emitter, arg0.x - 10, arg0.x + 10, arg0.y + 50, arg0.y - 160, 0, 0);
            part_emitter_burst(global.psystem, arg0.emitter, global.partType18, 100);
        }
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "KusogaKick", new Attack("KusogaKick", defaultConfig, 
{
    sprite_index: spr_ShionCircle,
    image_alpha: 0.9,
    isMain: true,
    stayOnCreator: false,
    image_xscale: 0,
    image_yscale: 0,
    attackTime: 120,
    playSound: false,
    hitLimit: -1,
    hitCD: 30,
    playSound: [170],
    duration: 200,
    collides: false,
    stayOnCreator: true,
    starty: 0,
    script: KusogaKick,
    lifetime: 0,
    transparent: true,
    emitter: 0
}));

OniSpiritSlash = function(arg0, arg1)
{
    var lifetime;
    arg0.depth = arg1.depth - 500;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "OniSpiritSlash", new Attack("OniSpiritSlash", defaultConfig, 
{
    damage: 10,
    sprite_index: spr_AyameSpiritSlash,
    attackTime: 0,
    image_alpha: 1,
    attackDelay: 30,
    playSound: [25],
    soundChannel: "onispiritslash",
    lifetime: 0,
    stayOnCreator: true,
    faceCreatorDirection: false,
    hitCD: 60,
    attackDamageID: "OniSpirit",
    script: OniSpiritSlash,
    hitLimit: -1,
    isMain: true
}));

OniSpirit = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(260);
        obj_AttackController.ApplyBuff(arg1, "OniSpirit", ds_map_find_value(obj_AttackController.Buffs, "OniSpirit"), 
        {
            buffIcon: 1452
        });
    }
    if (arg0.lifetime == 240)
    {
        obj_Cam.ExecuteShake(60, 8);
        obj_AttackController.ExecuteAttack("OniSpiritSlash", arg1, {});
    }
    arg0.lifetime++;
    if ((arg0.lifetime % 5) == 0 && global.lightFX)
    {
        var afterimage = instance_create_depth(arg0.x, arg0.y, arg0.depth + 55, obj_afterImage);
        afterimage.sprite_index = arg0.sprite_index;
        afterimage.image_speed = 0;
        afterimage.image_index = arg0.image_index;
        afterimage.image_xscale = arg0.image_xscale;
        afterimage.image_yscale = arg0.image_yscale;
        afterimage.afterimage_color = 8388736;
        afterimage.image_angle = arg0.image_angle;
        afterimage.image_alpha = 0.5;
        afterimage.grow = true;
        afterimage.vspeed = -5;
        afterimage.growthRate = 0.05;
    }
    if (arg0.lifetime < 20)
    {
        arg0.image_alpha += 0.02;
    }
    else
    {
        arg0.image_alpha = 0.6;
        arg0.depth = arg1.depth + 50;
    }
    if (arg0.duration < 20)
    {
        arg0.image_alpha -= 0.02;
    }
};

ds_map_set(attackIndex, "OniSpirit", new Attack("OniSpirit", defaultConfig, 
{
    collides: false,
    sprite_index: spr_AyameSpirit,
    image_alpha: 0,
    starty: 0,
    attackTime: 0,
    attackDelay: 30,
    playSound: [240],
    soundChannel: "duckshout",
    speed: 0,
    lifetime: 0,
    stayOnCreator: true,
    drawBehind: true,
    hitCD: 10,
    script: OniSpirit,
    hitLimit: -1,
    duration: 241,
    isMain: true,
    afterImageColor: 16711680
}));

NekoRun = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_Cam.ExecuteShake(300, 4);
        obj_PlayerManager.Dank(300);
        soundPlay([137], "cat", 30, 50);
        arg0.direction = arg1.direction;
        arg0.image_angle = 0;
        if (arg0.direction <= 90 || arg0.direction >= 270)
        {
            arg0.image_xscale = 2.5;
        }
        else
        {
            arg0.image_xscale = -2.5;
        }
        arg0.x = arg1.x - lengthdir_x(300, arg0.direction);
        arg0.y = arg1.y - lengthdir_y(300, arg0.direction);
        arg0.image_alpha = 1;
    }
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.1;
    }
    if ((arg0.lifetime % 25) == 0)
    {
        soundPlay([296], "stomp", 10, 50, true);
        var vfx = instance_create_depth(arg0.x, arg0.y + 40, arg0.depth + 100, obj_vfx);
        vfx.sprite_index = spr_groundcrack;
        vfx.image_xscale = 0.75;
        vfx.image_yscale = 0.75;
        vfx.image_alpha = 0.9;
        vfx.alarm[1] = 120;
        vfx.duration = 140;
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "Neko", new Attack("Neko", defaultConfig, 
{
    sprite_index: spr_AquaNeko,
    attackTime: 60,
    damage: 4,
    hitLimit: -1,
    lifetime: 0,
    isMain: true,
    hitCD: 25,
    playSound: [148],
    duration: 300,
    soundChannel: "neko",
    stayOnCreator: false,
    script: NekoRun,
    speed: 3,
    image_alpha: 0,
    image_xscale: 2.5,
    image_yscale: 2.5,
    emitter: 0,
    collides: true,
    knockback: 
    {
        duration: 12,
        speed: 12,
        immunityBypass: true
    }
}));

HighTideExplode = function(arg0, arg1)
{
    var lifetime;
    arg0.image_xscale = 0.6 * logn(1.6, arg0.lifetime + 1);
    arg0.image_yscale = 0.6 * logn(1.6, arg0.lifetime + 1) * 0.7;
    arg0.image_alpha -= 0.024;
    arg0.lifetime++;
};

ds_map_set(attackIndex, "HighTideExplode", new Attack("HighTideExplode", defaultConfig, 
{
    damage: 4,
    sprite_index: spr_SubaruASMR,
    attackTime: 120,
    attackCount: 1,
    attackDelay: 30,
    hitLimit: -1,
    speed: 0,
    soundChannel: "tide",
    hitCD: 45,
    duration: 35,
    projSpeed: 0,
    isMain: true,
    lifetime: 0,
    stayOnCreator: false,
    targetRandom: true,
    attackDamageID: "HighTide",
    script: HighTideExplode,
    image_xscale: 1,
    image_yscale: 0.7,
    image_alpha: 0.8,
    knockback: 
    {
        duration: 12,
        speed: 12,
        immunityBypass: true
    }
}));

HighTide = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(720);
        obj_Cam.ExecuteShake(60, 8);
        var vfx = instance_create_depth(arg1.x, arg1.y, arg1.depth + 100, obj_vfx);
        vfx.sprite_index = spr_MoonaHighTide;
        vfx.add = true;
        vfx.alarm[1] = 40;
        vfx.duration = 60;
        vfx.image_xscale = 3;
        vfx.image_yscale = 3;
        vfx.image_alpha = 0.75;
        vfx.followCharacter = arg1;
        var vfx2 = instance_create_depth(arg1.x, arg1.y, arg1.depth - 100, obj_vfx);
        vfx2.sprite_index = spr_MoonaHighTide2;
        vfx2.followCharacter = arg1;
        ExecuteAttack("HighTideExplode", arg1);
        soundPlay([102], "kusogakick", 30, 30);
    }
    if (arg0.lifetime == 4)
    {
        var vfx = instance_create_depth(arg0.x, arg0.y + 40, arg0.depth + 100, obj_vfx);
        vfx.sprite_index = spr_groundcrack;
        vfx.image_xscale = 1;
        vfx.image_yscale = 1;
        vfx.image_alpha = 0.9;
        vfx.alarm[1] = 120;
        vfx.duration = 140;
    }
    if (arg0.lifetime == 15)
    {
        obj_PlayerManager.ExecuteFlash();
        ApplyBuff(arg1, "MoonaSpecial", ds_map_find_value(Buffs, "MoonaSpecial"), 
        {
            buffIcon: 183
        });
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "HighTide", new Attack("HighTide", defaultConfig, 
{
    attackTime: 60,
    damage: -1,
    hitLimit: -1,
    lifetime: 0,
    isMain: true,
    hitCD: 25,
    playSound: [148],
    duration: 300,
    soundChannel: "neko",
    stayOnCreator: false,
    script: HighTide,
    speed: 3,
    image_alpha: 0,
    image_xscale: 2.5,
    image_yscale: 2.5,
    emitter: 0,
    collides: false
}));

ChargeRifle = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        obj_PlayerManager.Dank(300);
    }
    if (arg0.lifetime <= 240)
    {
        var directionDifference = angle_difference(arg0.direction, arg1.direction);
        arg0.direction -= min(abs(directionDifference), 5) * sign(directionDifference);
        arg0.image_angle = arg0.direction;
    }
    if (arg0.lifetime >= 12 && arg0.lifetime <= 230)
    {
        soundPlay([180], "laserloop", 12, 10);
    }
    if (arg0.lifetime == 230)
    {
        audio_stop_sound(snd_laserloop);
        arg0.sprite_index = spr_empty;
        arg0.collides = false;
    }
    if (arg0.lifetime == 240)
    {
        obj_Cam.ExecuteShake(60, 5);
        audio_play_sound(snd_laserbeamBig, 0, false);
        arg0.damage = min(8, 2 + (arg0.charge * 0.03));
        arg0.hitCD = 60;
        arg0.sprite_index = spr_OllieChargeRifle2;
        arg0.image_xscale = 2;
        arg0.image_alpha = 0.9;
        arg0.image_yscale = min(5, 0.5 + (arg0.charge * 0.03));
        arg0.knockback = 
        {
            duration: floor(min(15, 1 + (arg0.charge * 0.1))),
            speed: floor(min(15, 1 + (arg0.charge * 0.1))),
            immunityBypass: true
        };
        arg0.collides = true;
    }
    arg0.lifetime++;
};

IofiPaint = function(arg0, arg1)
{
    if (arg0.duration < 20)
    {
        arg0.image_alpha -= 0.05;
    }
};

ds_map_set(attackIndex, "IofiPaint", new Attack("IofiPaint", defaultConfig, 
{
    sprite_index: spr_IofiPaint,
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 1,
    damage: 0.75,
    drawBehind: true,
    attackTime: 120,
    hitLimit: -1,
    script: IofiPaint,
    collides: true,
    duration: 1200,
    hitCD: 1200,
    lifetime: 0,
    isMain: true
}));

function Draw(arg0, arg1)
{
    arg1.specMustWait = 1201;
    instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_Painter);
}

ds_map_set(attackIndex, "Draw", new Attack("Draw", defaultConfig, 
{
    image_xscale: 1,
    image_yscale: 1,
    image_alpha: 0,
    damage: 0,
    transparent: true,
    drawBehind: true,
    stayOnCreator: true,
    attackTime: 120,
    playSound: [245],
    hitLimit: -1,
    collides: false,
    onCreate: Draw,
    duration: 60,
    lifetime: 0,
    range: 300,
    initial: 1
}));
ds_map_set(attackIndex, "BigNutExplode", new Attack("BigNutExplode", defaultConfig, 
{
    damage: 4,
    sprite_index: spr_Explosion,
    attackTime: 0,
    attackCount: 1,
    hitCD: 30,
    image_xscale: 3,
    playSound: [288],
    image_yscale: 3,
    image_alpha: 0.8,
    isMain: true,
    attackDelay: 30,
    hitLimit: -1,
    attackDamageID: "BigNut"
}));

BigNutSpawn = function(arg0, arg1)
{
    arg0.groundY = arg0.y;
    arg0.y -= 300;
};

BigNutAcorn = function(arg0, arg1)
{
    if (arg0.y < arg0.groundY)
    {
        arg0.y += 31;
    }
    else if (arg0.y != arg0.groundY)
    {
        arg0.image_index = 1;
        arg0.image_speed = 1;
        arg0.y = arg0.groundY;
        soundPlay([138], "bignutground", 10, 0);
        obj_Cam.ExecuteShake(60, 5);
    }
    else if (arg0.y == arg0.groundY && arg0.image_index == 2)
    {
        arg0.image_speed = 0;
    }
    if (arg0.duration == 5)
    {
        ExecuteAttack("BigNutExplode", arg1, 
        {
            x: arg0.x,
            y: arg0.y - 16
        });
        for (var i = 0; i < 20; i++)
        {
            obj_AttackController.ExecuteAttack("NonstopNuts", arg1, 
            {
                damage: global.SkillData.NonstopNuts.damage[2],
                image_xscale: 1,
                image_yscale: 1,
                direction: i * 18,
                speed: 10,
                x: arg0.x,
                y: arg0.y
            });
        }
    }
};

ds_map_set(attackIndex, "BigNutAcorn", new Attack("BigNutAcorn", defaultConfig, 
{
    sprite_index: spr_RisuBigNut,
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 1,
    image_speed: 0,
    damage: 1,
    attackTime: 120,
    hitLimit: -1,
    groundY: 0,
    script: BigNutAcorn,
    attackDamageID: "BigNut",
    collides: true,
    duration: 90,
    hitCD: 60,
    lifetime: 0,
    isMain: true,
    onCreate: BigNutSpawn
}));

BigNut = function(arg0, arg1)
{
    var index, lifetime;
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
        arg0.collides = false;
    }
    if (arg0.lifetime > 50 && (arg0.lifetime % 10) == 0)
    {
        var dist = 150;
        ExecuteAttack("BigNutAcorn", arg1, 
        {
            x: arg1.x + lengthdir_x(dist, arg0.index * 72),
            y: arg1.y + lengthdir_y(dist, arg0.index * 72)
        });
        arg0.index++;
    }
    arg0.lifetime++;
    arg0.image_xscale += (0.15 * (30 - arg0.lifetime)) / 30;
    arg0.image_yscale += (0.15 * (30 - arg0.lifetime)) / 30;
};

ds_map_set(attackIndex, "BigNut", new Attack("BigNut", defaultConfig, 
{
    damage: 2,
    collides: false,
    sprite_index: spr_GravityRing,
    attackTime: 300,
    attackCount: 1,
    attackDelay: 300,
    hitLimit: -1,
    duration: 105,
    playSound: [11],
    soundChannel: "BigNut",
    index: 0,
    lifetime: 0,
    image_alpha: 0,
    script: BigNut,
    onHitEffects: 
    {
        TimeFreeze: 
        {
            freezeTime: 180
        }
    },
    isMain: true
}));
ds_map_set(attackIndex, "ChargeRifle", new Attack("ChargeRifle", defaultConfig, 
{
    faceCreatorDirection: true,
    attackTime: 90,
    hitLimit: -1,
    damage: 0.3,
    hitCD: 10,
    collides: true,
    sprite_index: spr_OllieChargeRifle1,
    playSound: [225],
    image_xscale: 2,
    image_yscale: 2,
    image_alpha: 1,
    stayOnCreator: true,
    lifetime: 0,
    duration: 270,
    script: ChargeRifle,
    isMain: true,
    charge: 0,
    onHitEffects: 
    {
        RifleCharge: {}
    },
    knockback: 
    {
        duration: 2,
        speed: 1
    }
}));

Tonjok = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg0.direction += -30 * random(60);
    }
    if (arg0.lifetime == 10)
    {
        arg0.collides = true;
        obj_Cam.ExecuteShake(60, 8);
        soundPlay([224], "tonjok", 10, 30, true);
    }
    arg0.lifetime++;
};

ds_map_set(attackIndex, "TonjokPunch", new Attack("TonjokPunch", defaultConfig, 
{
    collides: false,
    sprite_index: spr_Tonjok,
    image_alpha: 1,
    damage: 3,
    attackTime: 0,
    attackDelay: 30,
    playSound: [175],
    soundChannel: "5xTonjok",
    speed: 0,
    lifetime: 0,
    stayOnCreator: true,
    drawBehind: true,
    faceCreatorDirection: true,
    hitCD: 10,
    script: Tonjok,
    hitLimit: -1,
    image_xscale: 1.5,
    image_yscale: 1.5,
    duration: -1,
    isMain: true,
    onHitEffects: 
    {
        MoneyHit: 
        {
            chance: 40
        }
    },
    afterImageColor: 32768
}));

TonjokCharge = function(arg0, arg1)
{
    arg1.specMustWait = 999999;
    obj_PlayerManager.Dank(60);
    obj_AttackController.ApplyBuff(arg1, "Tonjok", ds_map_find_value(obj_AttackController.Buffs, "Tonjok"), 
    {
        buffIcon: 919,
        stacks: 5
    });
    for (var i = 0; i < 5; i++)
    {
        var xPos = lengthdir_x(60, i * 72);
        var yPos = lengthdir_y(60, i * 72) - 16;
        var tonjokenergy = instance_create_depth(arg1.x + xPos, arg1.y + yPos, arg1.depth, obj_TonjokEnergy);
        tonjokenergy.offset_x = xPos;
        tonjokenergy.offset_y = yPos;
        tonjokenergy.followCharacterID = arg1;
    }
};

TonjokExecute = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime >= 10)
    {
        if (variable_struct_exists(arg1.buffs, "Tonjok"))
        {
            if (obj_InputManager.actionTwoPressed || mouse_check_button_pressed(mb_right))
            {
                if (arg1.buffs.Tonjok.config.stacks > 1)
                {
                    arg0.lifetime = 0;
                    obj_AttackController.ExecuteAttack("TonjokPunch", arg1);
                    arg1.buffs.Tonjok.config.stacks--;
                }
                else
                {
                    arg0.lifetime = 0;
                    obj_AttackController.ExecuteAttack("TonjokPunch", arg1);
                    arg1.buffs.Tonjok.config.stacks--;
                    arg1.specMustWait = 10;
                    obj_AttackController.RemoveBuff(arg1, "Tonjok");
                    arg0.duration = 1;
                }
            }
        }
    }
    else
    {
        arg0.lifetime++;
    }
};

ds_map_set(attackIndex, "5xTonjok", new Attack("5xTonjok", defaultConfig, 
{
    collides: false,
    image_alpha: 0,
    attackTime: 0,
    attackDelay: 30,
    lifetime: 0,
    stayOnCreator: true,
    playSound: [252],
    soundChannel: "tonjokpower",
    drawBehind: true,
    faceCreatorDirection: true,
    onCreate: TonjokCharge,
    hitLimit: -1,
    duration: 999999,
    script: TonjokExecute,
    isMain: true
}));

BladeForm = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
        arg1.invincible = true;
        arg1.invincibilityTimer = 480;
        soundPlay([160], "bladeform", 30, 30);
        obj_PlayerManager.Dank(480);
        obj_AttackController.ApplyBuff(arg1, "BladeForm", ds_map_find_value(obj_AttackController.Buffs, "BladeForm"), 
        {
            buffIcon: 2433
        });
        obj_PlayerManager.ExecuteFlash(1);
    }
    if (arg0.lifetime > 30 && arg0.lifetime % floor((60 - floor(arg0.spinSpeed)) / 1.25))
    {
        soundPlay([31], "bladeform", floor((60 - floor(arg0.spinSpeed)) / 1.25), 30, true);
    }
    if (arg0.spinSpeed < 50)
    {
        arg0.spinSpeed += 0.2;
    }
    if (arg0.spinSpeed > 10)
    {
        arg0.collides = true;
        arg0.sprite_index = spr_AnyaBlade2;
    }
    arg0.image_angle -= arg0.spinSpeed;
    obj_Cam.ExecuteShake(30, 1);
    arg0.lifetime++;
};

ds_map_set(attackIndex, "BladeForm", new Attack("BladeForm", defaultConfig, 
{
    sprite_index: spr_AnyaBlade,
    image_xscale: 1,
    image_yscale: 1,
    damage: 1,
    collides: false,
    isMain: true,
    stayOnCreator: true,
    attackTime: 120,
    playSound: [149],
    soundChannel: "special",
    soundPrio: 30,
    hitCD: 10,
    hitLimit: -1,
    lifetime: 0,
    weaponType: "Melee",
    afterImageColor: 65535,
    duration: room_speed * 8,
    spinSpeed: 0,
    script: BladeForm
}));

RarestMetalBurst = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime == 0)
    {
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
    arg0.image_xscale += (0.2 * (30 - arg0.lifetime)) / 30;
    arg0.image_yscale += (0.2 * (30 - arg0.lifetime)) / 30;
};

RarestMaterial = function(arg0, arg1)
{
    var rock = instance_create_depth(arg1.x, arg1.y, arg1.depth, obj_OreDeposit);
    rock.image_xscale = 3;
    rock.image_yscale = 3;
    rock.sprite_index = spr_KaelaRarestMetal;
    rock.rarest = true;
    rock.image_speed = 0;
    rock.image_index = 0;
    rock.HP = 5;
};

ds_map_set(attackIndex, "RarestMaterial", new Attack("RarestMaterial", defaultConfig, 
{
    collides: false,
    image_alpha: 0,
    attackTime: 0,
    attackDelay: 30,
    lifetime: 0,
    stayOnCreator: true,
    playSound: [195],
    soundChannel: "rarestmetal",
    faceCreatorDirection: true,
    onCreate: RarestMaterial,
    hitLimit: -1,
    duration: 30,
    isMain: true
}));
ds_map_set(attackIndex, "RarestMetalBurst", new Attack("RarestMetalBurst", defaultConfig, 
{
    damage: 2.5,
    collides: false,
    sprite_index: spr_GravityRing,
    attackTime: 300,
    attackCount: 1,
    attackDelay: 300,
    playSound: [288],
    soundChannel: "rockexplosion",
    hitLimit: -1,
    duration: 30,
    lifetime: 0,
    isMain: true,
    image_alpha: 0,
    knockback: 
    {
        duration: 10,
        speed: 5
    },
    script: RarestMetalBurst
}));

StealthMode = function(arg0, arg1)
{
    obj_PlayerManager.Dank(480);
    var buff = {};
    variable_struct_copy(ds_map_find_value(obj_AttackController.Buffs, "Invisible"), buff);
    obj_PlayerManager.blackFlash = 1;
    variable_struct_set(buff, "timer", 480);
    obj_AttackController.ApplyBuff(arg1, "Invisible", buff, 
    {
        buffIcon: 2166
    });
    arg1.invincible = true;
    arg1.invincibilityTimer = max(480, arg1.invincibilityTimer);
};

StealthModeConfuse = function(arg0, arg1)
{
    var lifetime;
    if (arg0.lifetime < 478)
    {
        with (obj_Enemy)
        {
            followTarget = -4;
        }
    }
    else
    {
        with (obj_Enemy)
        {
            followTarget = instance_find(obj_Player, 0);
        }
    }
    arg0.lifetime++;
};

StealthModeDarkness = function(arg0)
{
    draw_set_color(c_black);
    draw_set_alpha(0.25);
    draw_rectangle(arg0.x - 400, arg0.y - 300, arg0.x + 400, arg0.y + 300, false);
    draw_set_alpha(1);
};

ds_map_set(attackIndex, "StealthMode", new Attack("StealthMode", defaultConfig, 
{
    collides: false,
    image_alpha: 0,
    attackTime: 0,
    attackDelay: 30,
    lifetime: 0,
    stayOnCreator: true,
    playSound: [111],
    soundChannel: "stealth",
    drawUnderAll: true,
    faceCreatorDirection: true,
    onCreate: StealthMode,
    hitLimit: -1,
    customDrawScriptBelow: StealthModeDarkness,
    lifetime: 0,
    script: StealthModeConfuse,
    duration: 480,
    isMain: true
}));

Underwater = function(arg0, arg1)
{
    var lifetime, healCD;
    if (arg0.lifetime == 0)
    {
        arg1.specMustWait = 601;
    }
    if (arg0.lifetime == 10)
    {
        obj_PlayerManager.Dank(590);
        obj_AttackController.ApplyBuff(arg1, "Underwater", ds_map_find_value(obj_AttackController.Buffs, "Underwater"), 
        {
            buffIcon: 1661
        });
    }
    if (arg0.lifetime == 15)
    {
        var _lowpass = audio_effect_create(AudioEffectType.LPF2);
        audio_bus_main.effects[0] = _lowpass;
    }
    arg0.lifetime++;
    if ((arg0.lifetime % 20) == 0 && global.lightFX)
    {
        var randSize = 0.5 + random(0.5);
        var vfx = instance_create_depth((arg0.x - 320) + irandom(640), arg1.y + 200, arg0.depth + 55, obj_vfx);
        vfx.sprite_index = spr_KoboBubbles;
        vfx.image_speed = 0;
        vfx.image_xscale = randSize;
        vfx.image_yscale = randSize;
        vfx.image_alpha = 0.8;
        vfx.bubble = true;
        vfx.duration = 180;
        vfx.add = true;
        vfx.vspeed = -0.5 - random(1);
    }
    if (arg0.healCD == 0)
    {
        Heal(arg1, arg1.HP * 0.05, 0);
        arg0.healCD = 60;
    }
    else
    {
        arg0.healCD--;
    }
    if (arg0.offsetY > -210)
    {
        arg0.offsetY -= 10;
    }
    arg0.y = arg1.y + arg0.offsetY;
    arg0.x = arg1.x;
    arg0.depth = -5000;
    if (arg0.duration < 10)
    {
        arg0.image_alpha -= 0.05;
        audio_bus_main.effects[0].bypass = true;
        with (obj_vfx)
        {
            if (variable_instance_exists(self, "bubble"))
            {
                instance_destroy();
            }
        }
    }
};

ds_map_set(attackIndex, "Underwater", new Attack("Underwater", defaultConfig, 
{
    collides: true,
    sprite_index: spr_KoboUnderwater,
    image_alpha: 0.6,
    starty: 0,
    attackTime: 0,
    attackDelay: 30,
    playSound: [162],
    soundChannel: "underwater",
    speed: 0,
    lifetime: 0,
    image_xscale: 2,
    image_yscale: 2,
    damage: 0.75,
    stayOnCreator: false,
    hitCD: 30,
    script: Underwater,
    offsetY: 200,
    healCD: 10,
    starty: -200,
    onHitEffects: 
    {
        UnderwaterDebuff: {}
    },
    hitLimit: -1,
    duration: 600,
    isMain: true,
    transparent: true
}));

enum AudioEffectType
{
    Bitcrusher,
    Delay,
    Gain,
    HPF2,
    LPF2,
    Reverb1,
    Tremolo,
    PeakEQ,
    HiShelf,
    LoShelf,
    EQ,
    Compressor
}
