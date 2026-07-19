var targets = ds_list_create();
if (instance_exists(obj_Enemy))
{
    collision_circle_list(obj_Player.x, obj_Player.y, 320, obj_Enemy, true, true, targets, false);
}
for (var i = 0; i < ds_list_size(targets); i++)
{
    var dmgObj = obj_AttackController.CalculateDamage(ds_list_find_value(targets, i), 227, 
    {
        damage: 1.25
    });
    if (ds_list_find_value(targets, i).isEnemy && ds_list_find_value(targets, i).currentHP > 0)
    {
        ds_list_find_value(targets, i).TakeDamage(dmgObj[0], 227, dmgObj[1], "Coexistence");
        obj_AttackController.ApplyBuff(ds_list_find_value(targets, i), "OnigiriSlow", ds_map_find_value(obj_AttackController.Buffs, "OnigiriSlow"));
    }
}
alarm[1] = 30;
