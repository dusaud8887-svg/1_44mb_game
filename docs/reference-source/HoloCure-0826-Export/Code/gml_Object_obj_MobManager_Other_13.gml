function Summon(arg0, arg1 = {}, arg2 = 
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
    isBoss: false,
    mask_index: spr_ShrimpMask,
    BonusDamageTaken: 0,
    CritVuln: 0,
    name: "DefaultSummon",
    level: 1,
    isBoss: false,
    isEnemy: false,
    tangible: false,
    lifeTime: -1,
    initialAttacks: {},
    pickupExp: true,
    attackEfficiency: 1,
    behaviourTimers: {},
    behaviours: {}
}) constructor
{
    config = {};
    variable_struct_copy(arg2, config);
    variable_struct_copy(arg1, config);
    id = arg0;
    name = config.name;
    summonName = config.summonName;
}

if (variable_global_exists("Summons") && ds_exists(global.Summons, ds_type_map))
{
    ds_map_destroy(global.Summons);
    global.Summons = -1;
}
Summons = ds_map_create();
global.Summons = Summons;
ds_map_set(Summons, "Bubba", new Summon("Bubba", 
{
    summonName: "Bubba",
    sprite_index: spr_Ame_bubba,
    behaviours: 
    {
        RunToRandomEnemy: 
        {
            config: {},
            
            Script: function(arg0)
            {
                obj_MobManager.RunToRandomEnemy(arg0);
            }
        }
    },
    initialAttacks: 
    {
        BubbaBark: true
    }
}));
ds_map_set(Summons, "Friend", new Summon("Friend", 
{
    summonName: "Friend",
    sprite_index: spr_MumeiFriend,
    behaviours: 
    {
        MumeiFriend: 
        {
            config: 
            {
                angle: 0,
                radius: 100,
                resetTimer: 300,
                timer: 60
            },
            
            Script: function(arg0, arg1)
            {
                var angle, timer;
                arg1.angle++;
                if (arg1.angle == 360)
                {
                    arg1.angle = 0;
                }
                arg0.x = (arg1.radius * cos((arg1.angle * pi) / 180)) + obj_Player.x;
                arg0.y = (arg1.radius * sin((arg1.angle * pi) / 180)) + obj_Player.y;
                if (arg1.timer == 0)
                {
                    var playerAttacks = obj_Player.attacks;
                    var attacks = arg0.attacks;
                    var keys = [];
                    var ac = 114;
                    ds_map_keys_to_array(playerAttacks, keys);
                    for (var i = 0; i < array_length(keys); i++)
                    {
                        if (!ds_map_exists(playerAttacks, keys[i]))
                        {
                            ds_map_delete(attacks, keys[i]);
                            array_delete(keys, i, 1);
                            i--;
                        }
                    }
                    var numberAttacks = 0;
                    for (var i = 0; i < array_length(global.SkillData.Friend.damage); i++)
                    {
                        if (arg0.attackEfficiency == global.SkillData.Friend.damage[i])
                        {
                            numberAttacks = i;
                        }
                    }
                    while (numberAttacks > 0)
                    {
                        var randomIndex = irandom(array_length(keys) - 1);
                        key = keys[randomIndex];
                        array_delete(keys, randomIndex, 1);
                        if (key != global.charSelected.attackID)
                        {
                            if (!ds_map_exists(attacks, key))
                            {
                                ds_map_set(attacks, key, new ac.Attack(key, ds_map_find_value(playerAttacks, key).config));
                            }
                            ds_map_find_value(attacks, key).config.damage = ds_map_find_value(playerAttacks, key).config.damage * arg0.attackEfficiency;
                            ds_map_find_value(attacks, key).timer = 0;
                            ds_map_find_value(attacks, key).attackDelay = 0;
                            ds_map_find_value(attacks, key).resetTimer = -50;
                            ds_map_find_value(attacks, key).config.attackTime = -50;
                            ds_map_find_value(attacks, key).attackCount = ds_map_find_value(playerAttacks, key).config.attackCount;
                            ds_map_find_value(attacks, key).countID = 0;
                            numberAttacks--;
                        }
                        if (array_length(keys) == 0)
                        {
                            break;
                        }
                    }
                    var key = global.charSelected.attackID;
                    var playerAttack = ds_map_find_value(playerAttacks, key);
                    if (!ds_map_exists(attacks, key))
                    {
                        ds_map_set(attacks, key, new ac.Attack(key, playerAttack.config));
                    }
                    ds_map_find_value(attacks, key).config.damage = ds_map_find_value(playerAttacks, key).config.damage * arg0.attackEfficiency;
                    ds_map_find_value(attacks, key).timer = 0;
                    ds_map_find_value(attacks, key).attackDelay = 0;
                    ds_map_find_value(attacks, key).resetTimer = -50;
                    ds_map_find_value(attacks, key).config.attackTime = -50;
                    ds_map_find_value(attacks, key).attackCount = ds_map_find_value(playerAttacks, key).config.attackCount;
                    ds_map_find_value(attacks, key).countID = 0;
                    arg1.timer = max(ds_map_find_value(arg0.attacks, key).config.minDelay, round(arg1.resetTimer / (1 + (obj_Player.haste / 100))));
                }
                if (arg1.timer == 1)
                {
                }
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            }
        }
    }
}));
ds_map_set(Summons, "Ankimo", new Summon("Ankimo", 
{
    sprite_index: spr_SoraAnkimo,
    mask_index: spr_SoraAnkimo,
    SPD: 1.5,
    summonName: "Ankimo",
    behaviours: 
    {
        RunToRandomEnemy: 
        {
            config: {},
            
            Script: function(arg0)
            {
                obj_MobManager.RunToRandomEnemy(arg0, 367, 
                {
                    range: 200,
                    resetTimer: 300,
                    distanceFromTarget: 0
                }, true);
            }
        }
    },
    initialAttacks: 
    {
        AnkimoTaunt: true
    }
}));
ds_map_set(Summons, "Garlic", new Summon("Garlic", 
{
    sprite_index: spr_ShionGarlic,
    SPD: 1.5,
    summonName: "Garlic",
    behaviours: 
    {
        RunToRandomEnemy: 
        {
            config: {},
            
            Script: function(arg0)
            {
                obj_MobManager.RunToRandomEnemy(arg0, 367, 
                {
                    range: 200,
                    resetTimer: 300,
                    distanceFromTarget: 0
                }, false);
            }
        }
    },
    initialAttacks: 
    {
        GarlicPulse: true
    }
}));
ds_map_set(Summons, "AncientOne", new Summon("AncientOne", 
{
    sprite_index: spr_AncientOneBook,
    SPD: 1.5,
    origin_x: -1,
    origin_y: -1,
    summonName: "AncientOne",
    behaviours: 
    {
        FloatAround: 
        {
            config: 
            {
                lifetime: 0,
                travelWidth: 160,
                travelHeight: 60,
                waveSpeed: 30,
                stop: false
            },
            
            Script: function(arg0)
            {
                if (arg0.origin_x == -1)
                {
                    arg0.origin_x = arg0.x;
                    arg0.origin_y = arg0.y;
                }
                if (!instance_exists(obj_Player))
                {
                    return false;
                }
                if (arg0.origin_x != obj_Player.x)
                {
                    arg0.origin_x += (obj_Player.x - arg0.origin_x) * 0.01;
                }
                if (arg0.origin_y != obj_Player.y)
                {
                    arg0.origin_y += (obj_Player.y - arg0.origin_y) * 0.01;
                }
                arg0.direction = point_direction(arg0.x, arg0.y, obj_Player.x, obj_Player.y);
                if (arg0.direction < 90 || arg0.direction > 270)
                {
                    arg0.image_xscale = abs(arg0.image_xscale);
                }
                if (arg0.direction > 90 && arg0.direction < 270)
                {
                    arg0.image_xscale = -abs(arg0.image_xscale);
                }
                arg0.x = arg0.origin_x + (sin(config.lifetime / (config.waveSpeed * 2)) * config.travelWidth);
                arg0.y = arg0.origin_y + (sin(config.lifetime / config.waveSpeed) * config.travelHeight);
                config.lifetime++;
            }
        }
    }
}));
ds_map_set(Summons, "RisuClone", new Summon("RisuClone", 
{
    sprite_index: spr_ShionGarlic,
    SPD: 1.5,
    summonName: "RisuClone",
    behaviours: 
    {
        RisuClone: 
        {
            config: 
            {
                resetTimer: 60,
                totalTime: 0,
                timer: 60
            },
            
            Script: function(arg0, arg1)
            {
                var totalTime, timer;
                arg0.x = obj_Player.x + arg0.randX;
                arg0.y = obj_Player.y + arg0.randY;
                arg0.image_speed = 0;
                arg0.sprite_index = obj_Player.sprite_index;
                arg0.image_index = obj_Player.image_index;
                arg0.image_xscale = obj_Player.image_xscale;
                arg0.image_yscale = obj_Player.image_yscale;
                arg0.image_alpha = 0.5;
                if (arg1.totalTime < 900)
                {
                    arg1.totalTime++;
                }
                else
                {
                    for (var i = 0; i < array_length(obj_PlayerManager.playerSummon); i++)
                    {
                        if (obj_PlayerManager.playerSummon[i] == arg0.id)
                        {
                            array_delete(obj_PlayerManager.playerSummon, i, 1);
                            obj_Player.onPickUp.DLC.config.clones--;
                            with (arg0)
                            {
                                instance_destroy();
                            }
                        }
                    }
                }
                if (arg1.timer == 0)
                {
                    var playerAttacks = obj_Player.attacks;
                    var attacks = arg0.attacks;
                    var key = "Nuts";
                    arg0.randomAttackKey = key;
                    var randomAttack = ds_map_find_value(playerAttacks, key);
                    ds_map_set(arg0.attacks, key, new obj_AttackController.Attack(key, ds_map_find_value(playerAttacks, key).config));
                    ds_map_find_value(arg0.attacks, key).config.damage = ds_map_find_value(arg0.attacks, key).config.damage * arg0.attackEfficiency;
                    ds_map_find_value(arg0.attacks, key).timer = 0;
                    ds_map_find_value(arg0.attacks, key).attackDelay = 0;
                    ds_map_find_value(arg0.attacks, key).resetTimer = -50;
                    ds_map_find_value(arg0.attacks, key).config.attackTime = -50;
                    ds_map_find_value(arg0.attacks, key).attackCount = ds_map_find_value(playerAttacks, key).config.attackCount;
                    ds_map_find_value(arg0.attacks, key).countID = 0;
                    arg1.timer = max(ds_map_find_value(arg0.attacks, key).config.minDelay, round(arg1.resetTimer / (1 + (obj_Player.haste / 100))));
                }
                if (arg1.timer == 1)
                {
                    if (variable_instance_exists(arg0, "randomAttackKey"))
                    {
                        if (ds_map_exists(arg0.attacks, arg0.randomAttackKey))
                        {
                            ds_map_delete(arg0.attacks, arg0.randomAttackKey);
                        }
                    }
                }
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            }
        }
    }
}));
