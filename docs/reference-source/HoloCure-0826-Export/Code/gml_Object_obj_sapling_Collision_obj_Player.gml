var minHeal = max(1, round(other.HP * buffConfig.healVal));
Heal(other, minHeal, 1);
obj_PlayerManager.UpdateBuffIfExists("Sapling", buffConfig);
obj_AttackController.ApplyBuff(other, "Sapling", ds_map_find_value(obj_AttackController.Buffs, "Sapling"), buffConfig);
instance_destroy();
