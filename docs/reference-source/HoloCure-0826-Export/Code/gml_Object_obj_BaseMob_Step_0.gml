if (completeStop)
{
    exit;
}
effectHappened = false;
if (speed < 0)
{
    speed = 0;
}
if (speed > 640)
{
    speed = 640;
}
if (canBeHit > 0)
{
    canBeHit--;
}
if (mentalTimer > 0)
{
    mentalTimer--;
}
if (currentHP <= 0 && !canNotDie)
{
    if (isAlive)
    {
        isAlive = false;
        Die();
    }
}
if (!isEnemy)
{
    if (direction < 90 || direction > 270)
    {
        image_xscale = abs(image_xscale);
    }
    if (direction > 90 && direction < 270)
    {
        image_xscale = -abs(image_xscale);
    }
}
if (frozenTime == 0)
{
    canAttack = true;
    canSpecial = true;
    canMove = true;
    spriteColor = 16777215;
    frozenTime = -1;
    image_speed = savedImageSpeed;
}
if (knockbackResetTime > 0)
{
    knockbackResetTime--;
}
else if (knockbackResetTime < 1)
{
    knockbackResist = 1;
}
if (frozenTime > 0)
{
    frozenTime--;
}
if (checkEffects > 0 && variable_struct_names_count(scripts) > 0)
{
    effectHappened = true;
    var keys = variable_struct_get_names(scripts);
    for (var i = 0; i < array_length(keys); i++)
    {
        var scriptObject = variable_struct_get(scripts, keys[i]);
        if (scriptObject != undefined)
        {
            var Script = scriptObject.Script;
            var config = scriptObject.config;
            Script(id, config);
        }
    }
}
if (checkEffects > 0 && variable_struct_names_count(hasStatusEffects) > 0)
{
    effectHappened = true;
    var keys = variable_struct_get_names(hasStatusEffects);
    for (var i = 0; i < array_length(keys); i++)
    {
        var config = variable_struct_get(hasStatusEffects, keys[i]);
        obj_AttackController.PerformTick(id, config, keys[i]);
    }
}
if (object_index == obj_Player)
{
    ResetStatsToPreStepBuff();
}
if (checkEffects > 0 && variable_struct_names_count(buffs) > 0 && isAlive)
{
    effectHappened = true;
    var keys = variable_struct_get_names(buffs);
    for (var i = 0; i < array_length(keys); i++)
    {
        var buff = variable_struct_get(buffs, keys[i]);
        if (!is_undefined(buff))
        {
            if (buff.timer == 0)
            {
                obj_AttackController.RemoveBuff(id, keys[i]);
            }
            else if (buff.timer > 0)
            {
                buff.timer--;
            }
        }
    }
}
if (checkEffects > 0 && variable_struct_names_count(resists) > 0)
{
    effectHappened = true;
    var keys = variable_struct_get_names(resists);
    for (var i = 0; i < array_length(keys); i++)
    {
        var buff = variable_struct_get(resists, keys[i]);
        if (buff.timer == 0)
        {
            variable_struct_remove(resists, keys[i]);
        }
        else if (buff.timer > 0)
        {
            buff.timer--;
        }
    }
}
if (checkEffects > 0 && variable_struct_names_count(stepBuffs) > 0)
{
    effectHappened = true;
    var keys = variable_struct_get_names(stepBuffs);
    for (var i = 0; i < array_length(keys); i++)
    {
        var stepBuff = variable_struct_get(stepBuffs, keys[i]);
        stepBuff.Apply(id, stepBuff.config);
    }
}
if (invincibilityTimer == 0)
{
    if (isPlayer)
    {
        global.timesDodged = 0;
    }
    invincible = false;
}
else if (invincibilityTimer > 0)
{
    invincibilityTimer--;
}
if (isKnockback.duration > 0)
{
    var potentialX = x + lengthdir_x(isKnockback.speed, isKnockback.direction);
    var potentialY = y + lengthdir_y(isKnockback.speed, isKnockback.direction);
    var collideObject = instance_place(potentialX, potentialY, obj_Enemy);
    if (collideObject && tangible && collideObject.tangible)
    {
        var dir = point_direction(x, y, collideObject.x, collideObject.y);
        collideObject.ApplyKnockback(
        {
            knockback: 
            {
                speed: variable_struct_get(isKnockback, "speed") / 2,
                direction: isKnockback.direction,
                duration: round(variable_struct_get(isKnockback, "duration") / 2)
            }
        });
        speed = 0;
        isKnockback.duration = 0;
        isKnockback.timer = 0;
    }
    else
    {
        if (isKnockback.timer == 0)
        {
            isKnockback.timer = isKnockback.duration;
            direction = isKnockback.direction;
        }
        speed = (isKnockback.speed * isKnockback.timer) / isKnockback.duration;
        if (isKnockback.timer > 0)
        {
            isKnockback.timer--;
        }
        if (isKnockback.timer == 0)
        {
            speed = 0;
            isKnockback.speed = 0;
            isKnockback.duration = 0;
        }
    }
}
if (checkEffects > 0 && variable_struct_names_count(delayedCallbacks) > 0)
{
    effectHappened = true;
    var keys = variable_struct_get_names(delayedCallbacks);
    for (var i = 0; i < array_length(keys); i++)
    {
        var call = variable_struct_get(delayedCallbacks, keys[i]);
        if (call.timer == 0 && call.amount > 0)
        {
            call.Func(self, call.config);
            call.timer = call.maxTimer;
            if (call.amount == 0)
            {
                variable_struct_remove(delayedCallbacks, keys[i]);
            }
            else
            {
                call.amount--;
            }
        }
        else
        {
            call.timer--;
        }
    }
}
depth = -y;
if (checkEffects > 0 && !effectHappened && object_index != obj_Player)
{
    checkEffects--;
}
effectHappened = false;
