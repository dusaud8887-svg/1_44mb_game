var minHeal = max(1, healAmount);
obj_PlayerManager.UpdateBuffIfExists("ChocoCoronet", buffConfig);
obj_AttackController.ApplyBuff(other, "ChocoCoronet", ds_map_find_value(obj_AttackController.Buffs, "ChocoCoronet"), buffConfig);
Heal(other, minHeal, 0, true, true);
instance_destroy();
