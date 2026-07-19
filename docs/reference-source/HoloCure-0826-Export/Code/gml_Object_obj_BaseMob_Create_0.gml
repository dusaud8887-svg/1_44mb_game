if (!variable_instance_exists(id, "HP"))
{
    HP = 1;
    currentHP = HP;
    ATK = -1;
    SPD = 0;
    haste = 0;
}
add = 0;
addDuration = 0;
uni_add = shader_get_uniform(shdrMob, "add");
transparent = false;
canNotDie = false;
followPlayerID = instance_find(obj_Player, 0);
framesInvincible = 0;
inView = false;
isMoving = false;
isAlive = true;
isObstacle = false;
canMove = true;
canAttack = true;
dontMove = false;
canCritHeal = false;
FXimage_index = 0;
spriteColor = 16777215;
noShowHit = false;
frozenTime = -1;
canFreeze = true;
isVisible = true;
savedImageSpeed = 1;
debuffIcons = [false, false, false];
customDrawScriptBelow = {};
customDrawScriptAbove = {};
debuffDisplay = [];
scripts = {};
scriptsKeys = [];
aliveFor = 0;
scriptsCD = 0;
completeStop = false;
isPlayer = false;
onTakeDamage = {};
onHitEffects = {};
hasStatusEffects = {};
statusEffects = {};
buffs = {};
buffsKeys = [];
buffsCD = 0;
resists = {};
stepBuffs = {};
isKnockback = 
{
    timer: 0,
    duration: 0,
    speed: 0,
    direction: 0
};
knockbackImmune = false;
knockbackResist = 1;
knockbackResetTime = 0;
invincible = false;
invincibilityTimer = false;
delayedCallbacks = {};
waypoint = {};
shieldHP = 0;
setForDeath = false;
checkEffects = 0;
effectHappened = false;
inAir = false;
shadowX = x;
airY = 0;
shadowY = y;
mentalCD = 180;
mentalTimer = 0;
savedSpeed = 0;
BonusDamageTaken = 0;
CritVuln = 0;
CritMod = 0.5;
specMod = 1;
weaponSizeMultiplier = 1;
knockbackMultiplier = 1;
healMultiplier = 1;
canBeHit = 0;
bonusProjectiles = 0;
expMultiplier = 1;
weaponBonus = 0;
skillDamage = 1;
baseStats = 
{
    HP: HP,
    ATK: ATK,
    SPD: SPD,
    haste: haste,
    DB: DB,
    DR: DR,
    BonusDamageTaken: BonusDamageTaken,
    CritVuln: CritVuln,
    CritMod: CritMod,
    specMod: specMod,
    weaponBonus: weaponBonus,
    healMultiplier: healMultiplier,
    bonusProjectiles: bonusProjectiles,
    expMultiplier: expMultiplier,
    skillDamage: skillDamage
};
currentHP = HP;
prebuffStats = {};
variable_struct_copy(baseStats, prebuffStats);

function ApplyMentalDamage()
{
    mentalTimer = mentalCD;
    mentalCD *= 2;
}

function Freeze(arg0 = 1)
{
    if (canFreeze)
    {
        canMove = false;
        canAttack = false;
        canSpecial = false;
        spriteColor = 16711680;
        frozenTime = max(arg0, frozenTime);
        if (image_speed > 0)
        {
            savedImageSpeed = image_speed;
            image_speed = 0;
        }
    }
}

function CompleteStop()
{
    canMove = false;
    canAttack = false;
    canSpecial = false;
    completeStop = true;
    if (speed > 0)
    {
        savedSpeed = speed;
        speed = 0;
    }
    if (image_speed > 0)
    {
        savedImageSpeed = image_speed;
        image_speed = 0;
    }
}

function EndStop()
{
    completeStop = false;
    canAttack = true;
    canSpecial = true;
    canMove = true;
    image_speed = savedImageSpeed;
    speed = savedSpeed;
}

function SnapshotPrebuffStats()
{
    prebuffStats = 
    {
        HP: HP,
        ATK: ATK,
        SPD: SPD,
        crit: crit,
        haste: haste,
        DB: DB,
        DR: DR,
        pickupRange: pickupRange,
        BonusDamageTaken: BonusDamageTaken,
        CritVuln: CritVuln,
        CritMod: CritMod,
        specMod: specMod,
        weaponSizeMultiplier: weaponSizeMultiplier,
        knockbackMultiplier: knockbackMultiplier,
        healMultiplier: healMultiplier,
        bonusProjectiles: bonusProjectiles,
        expMultiplier: expMultiplier,
        weaponBonus: weaponBonus,
        skillDamage: skillDamage
    };
}

function SetStats(arg0)
{
    var keys = variable_struct_get_names(arg0);
    for (var i = 0; i < array_length(keys); i++)
    {
        var value = variable_struct_get(arg0, keys[i]);
        show_debug_message("SETTING " + keys[i] + " TO " + string(value));
        variable_struct_set(prebuffStats, keys[i], value);
        variable_struct_set(baseStats, keys[i], value);
        variable_instance_set(self, keys[i], value);
    }
}

function ApplyHitEffect(arg0)
{
    if (!global.lightFX)
    {
        exit;
    }
    add = 0.5;
    addDuration = arg0 / 2;
    hitEffectDuration = arg0;
    alarm[11] = 1;
}

function Die(arg0 = false, arg1 = true, arg2 = undefined, arg3 = false)
{
    setForDeath = true;
}

onDebuff = {};

function OnDebuff(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var keys = variable_struct_get_names(onDebuff);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onDebuff, keys[i]);
        func(self, arg0, arg1, arg2, arg3, arg4, arg5);
    }
}

onKillingHit = {};

function OnKillingHit(arg0, arg1, arg2, arg3)
{
    var keys = variable_struct_get_names(onKillingHit);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onKillingHit, keys[i]);
        arg0 = func(arg0, arg1, arg2, self, invincible, arg3);
    }
    return arg0;
}

beforeDamageCalculation = {};

function BeforeDamageCalculation(arg0, arg1, arg2)
{
    var keys = variable_struct_get_names(beforeDamageCalculation);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(beforeDamageCalculation, keys[i]);
        arg2 = func(arg0, arg1, arg2);
    }
    return arg2;
}

onCollide = {};

function OnCollide(arg0, arg1)
{
    return arg1;
}

onAttackCreate = {};

function OnAttackCreate(arg0, arg1)
{
    var keys = variable_struct_get_names(onAttackCreate);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onAttackCreate, keys[i]);
        func(self, arg1);
    }
    exit;
}

onCriticalHit = {};

function OnCriticalHit(arg0, arg1, arg2)
{
    var keys = variable_struct_get_names(onCriticalHit);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onCriticalHit, keys[i]);
        arg2 = func(self, arg0, arg1, arg2);
    }
    return arg2;
}

afterCriticalHit = {};

function AfterCriticalHit(arg0, arg1, arg2)
{
    var keys = variable_struct_get_names(afterCriticalHit);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(afterCriticalHit, keys[i]);
        arg2 = func(self, arg0, arg1, arg2);
    }
    return arg2;
}

onHeal = {};

function OnHeal(arg0, arg1 = false, arg2 = false)
{
    var keys = variable_struct_get_names(onHeal);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onHeal, keys[i]);
        arg0 = func(arg0, self, arg1, arg2);
    }
    return arg0;
}

onCritHeal = {};

function OnCritHeal(arg0, arg1 = false, arg2 = false)
{
    var keys = variable_struct_get_names(onCritHeal);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onCritHeal, keys[i]);
        arg0 = func(arg0, self, arg1, arg2);
    }
    return arg0;
}

onDeath = {};

function OnDeath(arg0 = -1, arg1 = id, arg2 = false)
{
    var keys = variable_struct_get_names(onDeath);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onDeath, keys[i]);
        func(arg0, arg1, arg2);
    }
}

onKill = {};

function OnKill(arg0, arg1, arg2 = undefined)
{
    var keys = variable_struct_get_names(onKill);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onKill, keys[i]);
        func(arg0, arg1, arg2);
    }
}

onSpecial = {};

function OnSpecial(arg0)
{
    var keys = variable_struct_get_names(onSpecial);
    for (var i = 0; i < array_length(keys); i++)
    {
        var scriptObject = variable_struct_get(onSpecial, keys[i]);
        var Script = scriptObject.Script;
        var config = scriptObject.config;
        Script(id, config);
    }
}

onPickUp = {};

function OnPickUp(arg0, arg1, arg2 = false)
{
    var keys = variable_struct_get_names(onPickUp);
    for (var i = 0; i < array_length(keys); i++)
    {
        var scriptObject = variable_struct_get(onPickUp, keys[i]);
        var Script = scriptObject.Script;
        var config = scriptObject.config;
        Script(id, config, arg1, arg2);
    }
}

levelUpAchievementTimers = [];
onLevelUp = {};

function OnLevelUp(arg0)
{
    var keys = variable_struct_get_names(onLevelUp);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onLevelUp, keys[i]);
        func(arg0);
    }
    array_push(levelUpAchievementTimers, 60);
}

function OnTakeDamage(arg0, arg1, arg2, arg3)
{
    var keys = variable_struct_get_names(onTakeDamage);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onTakeDamage, keys[i]);
        arg0 = func(arg0, arg1, arg2, self, invincible, arg3);
    }
    return arg0;
}

onTakeDamageAfter = {};

function OnTakeDamageAfter(arg0, arg1, arg2, arg3)
{
    var keys = variable_struct_get_names(onTakeDamageAfter);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onTakeDamageAfter, keys[i]);
        arg0 = func(arg0, arg1, arg2, self, invincible, arg3);
    }
    return arg0;
}

onDodge = {};

function OnDodge(arg0, arg1, arg2)
{
    var keys = variable_struct_get_names(onDodge);
    for (var i = 0; i < array_length(keys); i++)
    {
        var func = variable_struct_get(onDodge, keys[i]);
        arg0 = func(arg0, arg1, arg2, self);
    }
    return arg0;
}

function TakeDamage(arg0, arg1, arg2, arg3 = "", arg4 = false, arg5 = true, arg6 = false, arg7 = false, arg8 = false)
{
    if (variable_instance_exists(self, "isConvertTako") && isConvertTako)
    {
        exit;
    }
    if (!arg6)
    {
        arg0 = OnTakeDamage(arg0, arg1, arg2, arg7);
        arg0 = ApplyOnHitEffects(arg0, arg1, arg2, arg7);
        ApplyKnockback(arg1);
        ApplyStatusEffects(arg0, arg1, arg2);
        if (invincible && arg0 > 0)
        {
            global.timesDodged++;
            arg0 = 0;
        }
        arg0 = OnTakeDamageAfter(arg0, arg1, arg2, arg7);
        if (arg0 == 0)
        {
            OnDodge(arg0, arg1, arg2);
        }
    }
    ApplyDamage(arg0, arg1, arg2, arg5, arg3, arg4, arg8);
}

function HitNumber(arg0, arg1, arg2, arg3 = true, arg4 = false, arg5 = false, arg6 = false)
{
    if (arg0 >= 0)
    {
        if (global.showDamageText && !noShowHit && instance_number(obj_damageText) < 100)
        {
            var hit = instance_create_depth(x, y - 30, depth - 1, obj_damageText);
            hit.critted = arg2;
            hit.shield = arg4;
            hit.reflected = arg5;
            hit.cringe = arg6;
            if (arg0 > 0)
            {
                hit.damageValue = arg0;
            }
            else
            {
                hit.damageValue = "MISS";
            }
            if (!is_undefined(arg1) && instance_exists(arg1))
            {
                if (variable_instance_exists(arg1, "CritMod"))
                {
                    var thereCreator = -4;
                    if (variable_instance_exists(arg1, "creator"))
                    {
                        thereCreator = arg1.creator;
                    }
                    if (instance_exists(thereCreator))
                    {
                        hit.CritMod = arg1.CritMod + thereCreator.CritMod;
                    }
                    else
                    {
                        hit.CritMod = arg1.CritMod;
                    }
                }
                hit.hspeed = ((x - arg1.x) / abs(arg1.x - x)) * 0.5;
            }
            else
            {
                hit.hspeed = 0.5;
            }
            hit.vspeed = -2;
            hit.isEnemy = isEnemy;
        }
    }
}

function ApplyDamage(arg0, arg1, arg2, arg3 = true, arg4 = "", arg5 = false, arg6 = false)
{
    if (variable_instance_exists(self, "isConvertTako") && isConvertTako)
    {
        exit;
    }
    ApplyHitEffect(5);
    var damageAfterShield = round(arg0);
    if (arg0 >= 0)
    {
        if (shieldHP > 0)
        {
            if (damageAfterShield >= shieldHP)
            {
                HitNumber(shieldHP, arg1, arg2, arg3, true, arg5, arg6);
            }
            else
            {
                HitNumber(damageAfterShield, arg1, arg2, arg3, true, arg5, arg6);
            }
            var _dam = damageAfterShield;
            damageAfterShield -= shieldHP;
            shieldHP -= _dam;
            if (shieldHP < 0)
            {
                shieldHP = 0;
            }
            if (damageAfterShield < 0)
            {
                damageAfterShield = 0;
            }
        }
        if (!(damageAfterShield == 0 && arg0 > 0))
        {
            HitNumber(damageAfterShield, arg1, arg2, arg3, false, arg5, arg6);
        }
        if (damageAfterShield >= 1000 && isEnemy)
        {
            DoAchievement("1000damage");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "DevilHat", "ITEM");
            if (damageAfterShield >= 10000)
            {
                DoAchievement("10000damage");
            }
        }
        if (instance_exists(arg1) && variable_instance_exists(arg1, "isEnemy") && !arg1.isEnemy && isEnemy)
        {
            PushDamageData(arg1, arg0, arg4);
        }
        if ((currentHP - damageAfterShield) < 1)
        {
            arg0 = OnKillingHit(arg0, arg1, arg2);
        }
        currentHP -= damageAfterShield;
        currentHP = floor(currentHP);
    }
    if (isEnemy)
    {
        global.totalDamage += damageAfterShield;
    }
    else
    {
        obj_PlayerManager.playerDamageTaken += damageAfterShield;
        if (obj_PlayerManager.playerDamageTaken >= 500)
        {
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Breastplate", "ITEM");
            DoAchievement("muscle");
        }
    }
    if (arg3 && arg0 > 0)
    {
        if (isEnemy)
        {
            soundPlay([212, 126], "HitSounds", 5, 1, true);
        }
        else if (object_index == obj_Player)
        {
            if (instance_exists(obj_PlayerManager))
            {
                obj_PlayerManager.hurtTime = 20;
            }
            soundPlay([198], "HitSounds", 30, 20);
        }
    }
    if (isPlayer)
    {
        if (damageAfterShield > 0)
        {
            if (obj_PlayerManager.donttouchCount > 0)
            {
                obj_PlayerManager.donttouchCount = 0;
            }
            if (!is_undefined(arg1) && variable_instance_exists(arg1, "attackID") && string_pos("Bullet", arg1.attackID) != 0)
            {
                obj_PlayerManager.bullethellFlag = false;
            }
        }
        obj_PlayerManager.hpSus = currentHP - 1;
    }
    if (currentHP <= 0 && !canNotDie)
    {
        if (is_undefined(arg1))
        {
            Die();
            exit;
        }
        Die(false, true, arg1);
    }
}

function ApplyKnockback(arg0)
{
    if (variable_instance_exists(arg0, "knockback") && variable_instance_exists(arg0.knockback, "duration") && isKnockback.duration == 0 && knockbackImmune == false)
    {
        var knockback = arg0.knockback;
        var dir = variable_struct_exists(arg0.knockback, "direction") ? arg0.knockback.direction : point_direction(arg0.creator.x, arg0.creator.y, x, y - 16);
        if (variable_struct_exists(arg0.knockback, "immunityBypass") && arg0.knockback.immunityBypass)
        {
            isKnockback.speed = variable_struct_get(knockback, "speed");
        }
        else
        {
            isKnockback.speed = variable_struct_get(knockback, "speed") * knockbackResist;
        }
        isKnockback.duration = variable_struct_get(knockback, "duration");
        isKnockback.direction = dir;
        if (!variable_struct_exists(arg0.knockback, "immunityBypass"))
        {
            if (knockbackResist > 0.1)
            {
                knockbackResist -= 0.1;
            }
            else
            {
                isKnockback.duration = floor(isKnockback.duration / 2);
            }
            if (knockbackResetTime == 0)
            {
                knockbackResetTime = 600;
            }
        }
    }
}

function ApplyOnHitEffects(arg0, arg1, arg2, arg3 = false)
{
    var onHitIds = {};
    if (!is_undefined(arg1) && (!variable_instance_exists(arg1, "isEnemy") || (variable_instance_exists(arg1, "creator") && variable_instance_exists(arg1, "isEnemy") && !arg1.isEnemy)))
    {
        variable_struct_copy(arg1.creator.onHitEffects, onHitIds);
        keys = variable_struct_get_names(arg1.onHitEffects);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_set(onHitIds, keys[i], variable_struct_get(arg1.onHitEffects, keys[i]));
        }
    }
    else if (!is_undefined(arg1))
    {
        onHitIds = arg1.onHitEffects;
    }
    var keys = variable_struct_get_names(onHitIds);
    for (var i = 0; i < array_length(keys); i++)
    {
        var script = ds_map_find_value(obj_AttackController.OnHitEffects, array_get(keys, i));
        var config = variable_struct_get(onHitIds, keys[i]);
        arg0 = script(arg0, arg1, arg2, self, config, arg3);
    }
    return arg0;
}

function ResetStatsToPreStepBuff()
{
    var keys = variable_struct_get_names(prebuffStats);
    for (var i = 0; i < array_length(keys); i++)
    {
        variable_instance_set(self, keys[i], variable_struct_get(prebuffStats, keys[i]));
    }
}

function ApplyStatusEffects(arg0, arg1, arg2)
{
    if (!instance_exists(arg1) && !variable_instance_exists(arg1, "creator"))
    {
        exit;
    }
    var statusEffectIds;
    if (!is_undefined(arg1) && !variable_instance_exists(arg1, "isEnemy"))
    {
        statusEffectIds = arg1.creator.statusEffects;
        keys = variable_struct_get_names(arg1.statusEffects);
        for (var i = 0; i < array_length(keys); i++)
        {
            variable_struct_set(statusEffectIds, keys[i], variable_struct_get(arg1.statusEffects, keys[i]));
        }
    }
    else if (!is_undefined(arg1))
    {
        statusEffectIds = arg1.statusEffects;
    }
    else
    {
        statusEffectIds = {};
    }
    var keys = variable_struct_get_names(statusEffectIds);
    for (var i = 0; i < array_length(keys); i++)
    {
        var config = variable_struct_get(statusEffectIds, keys[i]);
        if (!variable_struct_exists(hasStatusEffects, keys[i]))
        {
            var configKeys = variable_struct_get_names(config);
            variable_struct_set(hasStatusEffects, keys[i], {});
            var newStatusEffect = variable_struct_get(hasStatusEffects, keys[i]);
            for (var p = 0; p < array_length(configKeys); p++)
            {
                var configProperty = variable_struct_get(config, configKeys[p]);
                variable_struct_set(newStatusEffect, configKeys[p], configProperty);
            }
        }
        else
        {
            var statusEffect = variable_struct_get(hasStatusEffects, keys[i]);
            statusEffect.duration = config.duration;
        }
    }
}

if (variable_instance_exists(self, "onCreate"))
{
    if (typeof(onCreate) == "array")
    {
        for (var i = 0; i < (array_length(onCreate) - 1); i++)
        {
            onCreate[i](self);
        }
    }
    else
    {
        onCreate(self);
    }
}
