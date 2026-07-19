if (canGet)
{
    var statEffect = instance_create_depth(other.x, other.y - 8, other.depth - 1, obj_statEffect);
    statEffect.sprite_index = spr_StatUpEffect;
    statEffect.image_index = stat;
    soundPlay([89], "statUp", 10, 10);
    if (other.scripts.Polyglot.config.currentStat != stat)
    {
        obj_AttackController.ExecuteAttack("Polyglot", 227, 
        {
            x: x,
            y: y,
            damage: global.SkillData.Polyglot.damage
        });
    }
    other.scripts.Polyglot.config.currentStat = stat;
    obj_AttackController.RemoveBuff(other, "Polyglot");
    obj_AttackController.ApplyBuff(other, "Polyglot", ds_map_find_value(obj_AttackController.Buffs, "Polyglot"), buffConfig);
    instance_destroy();
}
