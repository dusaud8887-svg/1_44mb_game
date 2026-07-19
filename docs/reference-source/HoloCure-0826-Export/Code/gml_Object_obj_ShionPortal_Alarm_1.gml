var targets = ds_list_create();
if (instance_exists(obj_Enemy))
{
    collision_circle_list(x, y, radius, obj_Enemy, true, true, targets, false);
}
for (var i = 0; i < ds_list_size(targets); i++)
{
    var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), creator, 
    {
        damage: damage
    });
    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
    {
        ds_list_find_value(targets, i).TakeDamage(dmgObj[0], creator, dmgObj[1], "Black Magic", undefined, undefined, undefined, true);
    }
}
var vfx = instance_create_depth(x, y, depth + 50, obj_vfx);
vfx.sprite_index = spr_ShionMagicPulse;
vfx.image_speed = 0;
vfx.image_alpha = 0.5;
vfx.image_xscale = 0.8;
vfx.image_yscale = 0.8;
vfx.alarm[1] = 1;
vfx.alarm[0] = 1;
vfx.fadeSpeed = 0.02;
vfx.growthSpeed = 0.03;
alarm[1] = 120;
