function Heal(arg0, arg1, arg2, arg3 = true, arg4 = false, arg5 = false)
{
    if (instance_exists(arg0) && (arg0.currentHP > 0 || arg0.canNotDie))
    {
        var critted = false;
        arg1 *= arg0.healMultiplier;
        arg1 = max(1, arg0.OnHeal(arg1, arg4, arg5));
        if (arg0.canCritHeal)
        {
            var roll = irandom(99);
            if (roll < arg0.crit)
            {
                critted = true;
                arg1 = max(1, arg0.OnCritHeal(arg1, arg4, arg5));
            }
        }
        arg1 = floor(arg1);
        var healSound = [107, 248];
        if ((arg0.currentHP + arg1) > arg0.HP)
        {
            arg0.currentHP = arg0.HP;
        }
        else
        {
            arg0.currentHP += arg1;
        }
        if (arg0.isPlayer)
        {
            obj_PlayerManager.hpSus = arg0.currentHP - 1;
        }
        if (arg3)
        {
            soundPlay([healSound[arg2]], "Heal", 10, 4);
        }
        if (global.showDamageText && instance_number(obj_damageText) < 100)
        {
            var heal = instance_create_depth(arg0.x, arg0.y - 30, arg0.depth - 10, obj_damageText);
            heal.damageValue = arg1;
            heal.heal = true;
            heal.critted = critted;
            heal.hspeed = (-1 + irandom(2)) * random(0.75);
            heal.vspeed = -2 * (0.7 + random(0.5));
        }
    }
    else
    {
        exit;
    }
}
