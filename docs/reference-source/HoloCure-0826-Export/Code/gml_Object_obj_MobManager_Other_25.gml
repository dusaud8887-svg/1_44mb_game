global.allNormalEnemySprites = [];
var key = ds_map_find_first(Mobs);
while (!is_undefined(key))
{
    if (!ds_map_find_value(Mobs, key).config.isBoss && !ds_map_find_value(Mobs, key).config.miniboss && !ds_map_find_value(Mobs, key).config.shooter && !ds_map_find_value(Mobs, key).config.bomber && !ds_map_find_value(Mobs, key).config.ignoreThis)
    {
        var theSprites = [ds_map_find_value(Mobs, key).config.sprite_index, ds_map_find_value(Mobs, key).config.mask_index];
        array_push(global.allNormalEnemySprites, theSprites);
    }
    key = ds_map_find_next(Mobs, key);
}
global.allShooterEnemySprites = [];
key = ds_map_find_first(Mobs);
while (!is_undefined(key))
{
    if (!ds_map_find_value(Mobs, key).config.isBoss && !ds_map_find_value(Mobs, key).config.miniboss && ds_map_find_value(Mobs, key).config.shooter && !ds_map_find_value(Mobs, key).config.ignoreThis)
    {
        var theSprites = [ds_map_find_value(Mobs, key).config.sprite_index, ds_map_find_value(Mobs, key).config.mask_index];
        array_push(global.allShooterEnemySprites, theSprites);
    }
    key = ds_map_find_next(Mobs, key);
}
global.allBomberEnemySprites = [];
key = ds_map_find_first(Mobs);
while (!is_undefined(key))
{
    if (!ds_map_find_value(Mobs, key).config.isBoss && !ds_map_find_value(Mobs, key).config.miniboss && ds_map_find_value(Mobs, key).config.bomber && !ds_map_find_value(Mobs, key).config.ignoreThis)
    {
        var theSprites = [ds_map_find_value(Mobs, key).config.sprite_index, ds_map_find_value(Mobs, key).config.mask_index];
        array_push(global.allBomberEnemySprites, theSprites);
    }
    key = ds_map_find_next(Mobs, key);
}
global.allBossEnemySprites = [];
key = ds_map_find_first(Mobs);
while (!is_undefined(key))
{
    if (ds_map_find_value(Mobs, key).config.miniboss && !ds_map_find_value(Mobs, key).config.ignoreThis)
    {
        var theSprites = [ds_map_find_value(Mobs, key).config.sprite_index, ds_map_find_value(Mobs, key).config.mask_index];
        array_push(global.allBossEnemySprites, theSprites);
    }
    key = ds_map_find_next(Mobs, key);
}
ds_map_set(Mobs, "TimeMob1", new Mob("TimeMob1", 
{
    HP: 30,
    ATK: 2,
    SPD: 0.8,
    expvalue: 5,
    sprite_index: spr_Shrimp,
    mask_index: spr_ShrimpMask,
    timeSubtract: 10,
    lifeTime: 1800,
    image_xscale: 1.25,
    image_yscale: 1.25,
    levels: [],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        timeScaling: obj_MobManager.behaviours.timeScaling,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 1
}));
ds_map_set(Mobs, "TimeMobShooter", new Mob("TimeMobShooter", 
{
    HP: 30,
    ATK: 2,
    SPD: 0.8,
    expvalue: 5,
    shooter: true,
    sprite_index: spr_Shrimp,
    mask_index: spr_ShrimpMask,
    timeSubtract: 10,
    lifeTime: 1800,
    image_xscale: 1.25,
    image_yscale: 1.25,
    levels: [],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        timeScaling: obj_MobManager.behaviours.timeScaling,
        projectileAttackSlow: obj_MobManager.behaviours.projectileAttack,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 1
}));
ds_map_set(Mobs, "TimeMobBomber", new Mob("TimeMobBomber", 
{
    HP: 30,
    ATK: 2,
    SPD: 0.8,
    expvalue: 5,
    bomber: true,
    lifeTime: 1800,
    sprite_index: spr_Shrimp,
    mask_index: spr_ShrimpMask,
    image_xscale: 1.25,
    timeSubtract: 10,
    image_yscale: 1.25,
    levels: [],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        timeScaling: obj_MobManager.behaviours.timeScaling,
        selfDestruct: 
        {
            config: 
            {
                warnTime: 120,
                radius: 80
            }
        },
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 1
}));
ds_map_set(Mobs, "TimeMobBoss", new Mob("TimeMobBoss", 
{
    HP: 1000,
    ATK: 3,
    SPD: 0.7,
    expvalue: 1000,
    sprite_index: spr_Shrimp,
    mask_index: spr_ShrimpMask,
    image_xscale: 5,
    image_yscale: 5,
    lifeTime: 99999,
    timeSubtract: 100,
    expvalue: 1000,
    isBoss: true,
    attackTime: 0,
    tangible: false,
    attackTime: 180,
    canSpecial: true,
    knockbackImmune: true,
    levels: [],
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        timeScaling: obj_MobManager.behaviours.timeScaling,
        projectileAttackBoss: obj_MobManager.behaviours.projectileAttackBoss,
        followPlayer: obj_MobManager.behaviours.followPlayer
    },
    maxLevel: 1
}));
