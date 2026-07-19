event_inherited();
isEnemy = false;
stopAttacks = false;
attacks = ds_map_create();
var ac = 114;
ATK = 0.75;
directionMoving = direction;
directionChangeTime = 0;
followPlayerID = instance_find(obj_Player, 0);
isInView = false;
xPos = 0;
yPos = 0;
arrowDir = 0;
var keys = variable_struct_get_names(initialAttacks);
for (var i = 0; i < array_length(keys); i++)
{
    variable_struct_get(initialAttacks, keys[i]);
    ds_map_set(attacks, array_get(keys, i), new ac.Attack(keys[i], ds_map_find_value(ac.attackIndex, array_get(keys, i)).config, {}));
    var attack = ds_map_find_value(attacks, array_get(keys, i));
    attack.timer = ds_map_find_value(ac.attackIndex, array_get(keys, i)).config.attackTime;
    attack.attackDelay = 0;
    attack.resetTimer = ds_map_find_value(ac.attackIndex, array_get(keys, i)).config.attackTime;
    attack.attackCount = ds_map_find_value(ac.attackIndex, array_get(keys, i)).config.attackCount;
}

function Die()
{
    part_emitter_destroy_all(global.psystem);
}
