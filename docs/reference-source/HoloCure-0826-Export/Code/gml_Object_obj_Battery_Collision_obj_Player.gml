global.experience += (expVal * (other.expMultiplier + other.EXP));
soundPlay([106], "getEXP", 5, 3);
instance_destroy();
var targets = ds_list_create();
if (instance_exists(obj_Enemy))
{
    collision_circle_list(other.x, other.y, 120, obj_Enemy, true, true, targets, false);
}
for (var i = 0; i < ds_list_size(targets); i++)
{
    var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), other, 
    {
        damage: damage
    });
    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
    {
        ds_list_find_value(targets, i).Freeze(30);
        ds_list_find_value(targets, i).TakeDamage(dmgObj[0], other, dmgObj[1], "BatteryCharged");
    }
}
var vfx = instance_create_depth(x, y, depth - 100, obj_vfx);
vfx.sprite_index = spr_RobocoShock;
vfx.image_speed = 0;
vfx.image_index = irandom(sprite_get_number(spr_RobocoShock));
vfx.alarm[1] = 1;
vfx.image_alpha = 0.8;
vfx.add = true;
instance_destroy();
