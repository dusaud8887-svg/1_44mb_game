function RemoveFriendly(arg0)
{
    var listSize = ds_list_size(arg0);
    for (var i = 0; i < listSize; i++)
    {
        if (!ds_list_find_value(arg0, i).isEnemy)
        {
            ds_list_delete(arg0, i);
            i -= 1;
            listSize -= 1;
        }
    }
    return arg0;
}

TargettedProjectile = function(arg0, arg1)
{
    if (!variable_instance_exists(arg0, "target"))
    {
        targets = ds_list_create();
        numTargets = collision_circle_list(arg1.x, arg1.y, arg0.range, obj_Enemy, false, true, targets, true);
        targets = RemoveFriendly(targets);
        numTargets = ds_list_size(targets);
        if (numTargets == 0)
        {
            arg0.target = "noTarget";
            arg0.direction = arg1.direction;
            arg0.speed = arg0.projSpeed;
        }
        else if (arg0.targetRandom)
        {
            randomIndex = floor(random(numTargets));
            if (variable_instance_exists(arg0, "ignoreTarget"))
            {
                arg0.target = ds_list_find_value(targets, randomIndex);
                while (array_length(numTargets) > 1 && arg0.target == arg0.ignoreTarget)
                {
                    randomIndex = floor(random(numTargets));
                    arg0.target = ds_list_find_value(targets, randomIndex);
                }
            }
            else
            {
                arg0.target = ds_list_find_value(targets, randomIndex);
            }
        }
        else
        {
            arg0.target = ds_list_find_value(targets, 0);
        }
        ds_list_destroy(targets);
        targets = -1;
    }
    if (!arg0.updatedDirection && arg0.target != "noTarget" && instance_exists(arg0.target))
    {
        arg0.direction = point_direction(arg1.x, arg1.y, arg0.target.x, arg0.target.y);
        arg0.speed = arg0.projSpeed;
        arg0.image_angle = arg0.direction;
    }
    if (!arg0.homing)
    {
        arg0.updatedDirection = true;
    }
};

TimelineCustomAttack = function(arg0, arg1)
{
    var counter;
    if (!variable_instance_exists(arg0, "counter"))
    {
        arg0.counter = 0;
    }
    arg0.counter++;
    for (var i = 0; i < array_length(arg0.timeline); i++)
    {
        var action = arg0.timeline[i];
        if (arg0.counter == action.frame)
        {
            switch (action.type)
            {
                case "attack":
                    var attack = action.object;
                    var overrideConfig = action.config;
                    overrideConfig.x = arg0.x;
                    overrideConfig.y = arg0.y;
                    overrideConfig.attackObj = arg0;
                    ExecuteAttack(attack, arg1, overrideConfig);
                    break;
                case "sound":
                    arg0.PlaySound(action.object);
                    break;
                case "shake":
                    obj_Cam.ExecuteShake();
                    break;
                case "function":
                    action.object(arg1);
                    break;
            }
        }
    }
    if (arg0.counter >= arg0.duration && arg0.duration != 0)
    {
        instance_destroy(arg0);
    }
};

function ExecuteAttack(arg0, arg1, arg2 = {}, arg3 = false)
{
    with (instance_create_depth(0, 0, -10000, obj_PreCreate))
    {
        attackID = arg0;
        creator = arg1;
        if (!instance_exists(creator))
        {
            return -4;
        }
        isEnemy = creator.isEnemy;
        stayOn = creator;
        config = {};
        config.summonSource = false;
        var _config = ds_map_find_value(obj_AttackController.attackIndex, attackID).config;
        var keys = variable_struct_get_names(_config);
        for (var i = 0; i < array_length(keys); i++)
        {
            if (keys[i] == "StampVars")
            {
                var StampVarsCopy = {};
                variable_struct_copy(variable_struct_get(_config, keys[i]), StampVarsCopy);
                variable_struct_set(config, keys[i], StampVarsCopy);
            }
            else
            {
                variable_struct_set(config, keys[i], variable_struct_get(_config, keys[i]));
            }
        }
        if (arg2)
        {
            keys = variable_struct_get_names(arg2);
            for (var i = 0; i < array_length(keys); i++)
            {
                if (keys[i] == "StampVars")
                {
                    var StampVarsCopy = {};
                    variable_struct_copy(variable_struct_get(arg2, keys[i]), StampVarsCopy);
                    variable_struct_set(config, keys[i], StampVarsCopy);
                }
                else
                {
                    variable_struct_set(config, keys[i], variable_struct_get(arg2, keys[i]));
                }
            }
        }
        var newKnockback = {};
        variable_struct_copy(config.knockback, newKnockback);
        config.knockback = newKnockback;
        if (variable_struct_exists(newKnockback, "speed") && variable_instance_exists(creator, "knockbackMultiplier"))
        {
            newKnockback.speed *= creator.knockbackMultiplier;
        }
        if (arg3)
        {
            for (var i = 0; i < array_length(config.gainedMods); i++)
            {
                var modLookup = ds_map_find_value(global.AttackModifiers, config.gainedMods[i]);
                modLookup.Apply(config);
            }
        }
        if (config.noMultiples)
        {
            var currentConfig = config;
            with (obj_Attack)
            {
                if (attackID == arg0 && config.summonSource == currentConfig.summonSource)
                {
                    instance_destroy();
                    if (global.debug)
                    {
                        show_debug_message("No Multiples called on attack " + string(arg0));
                    }
                }
            }
        }
        if (variable_struct_exists(arg1, "onAttackCreate"))
        {
            arg1.OnAttackCreate(arg1, self);
        }
        else if (variable_struct_exists(arg1, "creator") && variable_struct_exists(arg1.creator, "onAttackCreate"))
        {
            arg1.creator.OnAttackCreate(arg1.creator, self);
        }
        instance_change(obj_Attack, true);
        return self;
    }
}

function CalculateDamage(arg0, arg1, arg2)
{
    if (!instance_exists(arg0))
    {
        return [0, false];
    }
    if (!variable_instance_exists(arg2, "enhancements"))
    {
        arg2.enhancements = 0;
    }
    if (!variable_instance_exists(arg2, "CritMod"))
    {
        arg2.CritMod = 0;
    }
    var _weaponBonus = 0;
    if (!is_undefined(arg1) && instance_exists(arg1) && variable_instance_exists(arg1, "weaponBonus"))
    {
        _weaponBonus = arg1.weaponBonus;
    }
    var damageMultiplier = 0;
    if (!is_undefined(arg1) && instance_exists(arg1))
    {
        arg2 = arg1.BeforeDamageCalculation(arg0, arg1, arg2);
    }
    if (variable_instance_exists(arg2, "damageMultiplier"))
    {
        damageMultiplier = arg2.damageMultiplier;
    }
    var bonusCrit = 0;
    if (variable_instance_exists(arg2, "bonusCrit"))
    {
        bonusCrit = arg2.bonusCrit;
    }
    var rollCrit = 0.1 + random(100);
    var critted = (arg1.crit + arg0.CritVuln + bonusCrit) > rollCrit;
    if (variable_instance_exists(arg2, "sureCrit"))
    {
        critted = true;
    }
    if (variable_instance_exists(arg2, "sureCritOnce") && arg2.sureCritOnce)
    {
        critted = true;
        arg2.sureCritOnce = false;
    }
    var charLevelDamage = 0;
    var aID = "";
    if (variable_instance_exists(arg2, "attackDamageID"))
    {
        aID = arg2.attackDamageID;
    }
    else if (variable_instance_exists(arg2, "attackID"))
    {
        aID = arg2.attackID;
    }
    var split = 1;
    if (!is_undefined(ds_map_find_value(obj_PlayerManager.playerCharacter.attacks, aID)))
    {
        if (variable_instance_exists(ds_map_find_value(obj_PlayerManager.playerCharacter.attacks, aID).config, "splitCount"))
        {
            split = ds_map_find_value(obj_PlayerManager.playerCharacter.attacks, aID).config.splitCount;
        }
        else
        {
            split = max(1, ds_map_find_value(obj_PlayerManager.playerCharacter.attacks, aID).config.attackCount);
        }
    }
    split += obj_Player.bonusProjectiles;
    var enhancementPer = 0.2 + global.enhancementBuff;
    var growthPer = 1;
    if (arg2.enhancements > 0)
    {
        enhancementPer = (0.2 + global.enhancementBuff) / split;
    }
    if (variable_instance_exists(arg2, "hitCD") && arg2.hitCD < 20)
    {
        growthPer = max(4, arg2.hitCD) / 20;
    }
    if (variable_instance_exists(arg2, "isMain") && arg2.isMain)
    {
        charLevelDamage = (global.PLAYERLEVEL * 0.01 * ds_map_find_value(global.PlayerSave, "growth")) / split;
    }
    var totalDamage = arg1.ATK * (arg2.damage + (arg2.damage * _weaponBonus) + (arg2.enhancements * enhancementPer) + (charLevelDamage * growthPer)) * global.damage;
    if (totalDamage > 2 && !global.debug)
    {
        totalDamage = (totalDamage - max(totalDamage * 0.1, 2)) + random(max(totalDamage * 0.2, 4));
    }
    if (critted)
    {
        if (instance_exists(arg0))
        {
            totalDamage = arg1.OnCriticalHit(arg2, arg0, totalDamage);
        }
    }
    var totalCritMod = arg2.CritMod + arg1.CritMod;
    if (totalDamage > 0)
    {
        totalDamage += (totalCritMod * totalDamage * critted);
        if ((variable_instance_exists(arg2, "isSkill") && arg2.isSkill) || (variable_instance_exists(arg2, "optionType") && arg2.optionType == "Skill"))
        {
            totalDamage *= arg1.skillDamage;
        }
        totalDamage *= (1 + arg1.DB);
        totalDamage *= max(0.01, arg0.DR);
        totalDamage *= (1 + (arg0.BonusDamageTaken / 100));
        totalDamage *= (1 + damageMultiplier);
        totalDamage = max(1, round(totalDamage));
    }
    if (critted)
    {
        if (instance_exists(arg0))
        {
            totalDamage = arg1.AfterCriticalHit(arg2, arg0, totalDamage);
        }
    }
    return [totalDamage, critted];
}

function DebuffVFX(arg0)
{
    if (global.lightFX)
    {
        if (instance_number(obj_vfx) < 30)
        {
            var debuff = instance_create_depth(arg0.x, arg0.y, arg0.depth - 1, obj_vfx);
            debuff.sprite_index = spr_debuffFX;
            debuff.image_alpha = 0.7;
            debuff.image_xscale = arg0.image_xscale;
            debuff.image_yscale = arg0.image_yscale;
            debuff.followCharacter = arg0.id;
        }
    }
}

function OnDebuffApply(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (variable_instance_exists(arg2, "creator"))
    {
        arg2.creator.OnDebuff(arg0, arg1, arg2, arg3, arg4, arg5);
    }
    else
    {
        arg2.OnDebuff(arg0, arg1, arg2, arg3, arg4, arg5);
    }
}

event_user(0);
event_user(1);
event_user(2);
