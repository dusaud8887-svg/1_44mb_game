var targets = ds_list_create();
if (global.lightFX)
{
    part_emitter_region(global.psystem, emitter, x - radius, x + radius, y - radius, y + radius, 1, 0);
    part_emitter_burst(global.psystem, emitter, global.partType1, 30);
}
if (instance_exists(obj_Enemy))
{
    collision_circle_list(x, y, radius, obj_Enemy, true, true, targets, false);
}
show_debug_message(creator);
for (var i = 0; i < ds_list_size(targets); i++)
{
    var totalDam = 1;
    var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), creator, 
    {
        damage: totalDam
    });
    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
    {
        if (instance_exists(ds_list_find_value(targets, i)))
        {
            obj_AttackController.ApplyBuff(ds_list_find_value(targets, i), "MelMelCooking", ds_map_find_value(obj_AttackController.Buffs, "MelMelCooking"), 
            {
                cookingTarget: id
            });
        }
        ds_list_find_value(targets, i).TakeDamage(dmgObj[0], creator, dmgObj[1], "MelMelCooking", undefined, undefined, undefined, true);
    }
}
var vfx = instance_create_depth(x, y, depth + 50, obj_vfx);
vfx.sprite_index = spr_MelCookingPulse;
vfx.image_speed = 0;
vfx.image_alpha = 0.5;
vfx.image_xscale = 0.8;
vfx.image_yscale = 0.8;
vfx.alarm[1] = 1;
vfx.alarm[0] = 1;
vfx.fadeSpeed = 0.02;
vfx.growthSpeed = 0.03;
alarm[1] = 90;
