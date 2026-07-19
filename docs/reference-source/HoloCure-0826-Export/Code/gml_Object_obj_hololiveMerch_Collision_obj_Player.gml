if (pickable)
{
    var damage = 5;
    if (other.currentHP <= 5)
    {
        damage = other.currentHP - 1;
    }
    other.ApplyDamage(max(0, floor(damage)), undefined, false, true);
    if (other.currentHP < 1)
    {
        other.currentHP = 1;
    }
    obj_PlayerManager.hpSus = other.currentHP - 1;
    array_push(other.scripts.SimpOfAllTime.config.healArray, 120);
    obj_PlayerManager.UpdateBuffIfExists("SimpOfAllTime", buffConfig);
    obj_AttackController.ApplyBuff(other, "SimpOfAllTime", ds_map_find_value(obj_AttackController.Buffs, "SimpOfAllTime"), buffConfig);
    instance_destroy();
}
