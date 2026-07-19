enemiesInvincMap = {};
extraDepth = 0;
eraseCD = 0;

function PlaySound(arg0)
{
    if (typeof(arg0) == "array")
    {
        randomSoundIndex = floor(random(array_length(arg0)));
        soundPlay(arg0, soundChannel, soundCD, soundPrio, soundPitch);
    }
    else
    {
        soundPlay(arg0, soundChannel, soundCD, soundPrio, soundPitch);
    }
}

onDestroyedByHitLimit = {};

function OnDestroyedByHitLimit()
{
    if (variable_struct_exists(onDestroyedByHitLimit, "Script") && variable_struct_exists(onDestroyedByHitLimit, "config"))
    {
        onDestroyedByHitLimit.Script(id, onDestroyedByHitLimit.config);
    }
}

function OnCollideWithTarget(arg0)
{
    if (collides && arg0.inView)
    {
        arg0.checkEffects = 1;
        HitTarget(arg0);
    }
}

function HitTarget(arg0)
{
    if (instance_exists(creator))
    {
        if (arg0.currentHP > 0)
        {
            if (((creator.isEnemy != arg0.isEnemy && object_get_parent(arg0.object_index) != 248) && arg0.object_index != obj_Summon) || (object_get_parent(arg0.object_index) == 248 && !creator.isEnemy && arg0.breakable && !arg0.broken))
            {
                if (!variable_struct_exists(enemiesInvincMap, string(arg0.id)) && hitLimit != 0)
                {
                    var dmgObj = obj_AttackController.CalculateDamage(arg0, creator, self);
                    var _damage = dmgObj[0];
                    var critted = dmgObj[1];
                    variable_struct_set(enemiesInvincMap, string(arg0.id), hitCD);
                    var _Skill = false;
                    if (variable_instance_exists(id, "isSkill"))
                    {
                        _Skill = isSkill;
                    }
                    else
                    {
                        _Skill = optionType == "Skill";
                    }
                    arg0.TakeDamage(_damage, id, critted, undefined, undefined, undefined, undefined, _Skill);
                    if (hitLimit > 0)
                    {
                        if (arg0.isEnemy || arg0.object_index == obj_Player)
                        {
                            hitLimit--;
                        }
                    }
                }
                if (hitLimit > -1 && hitLimit < 1)
                {
                    if (deflects > 0)
                    {
                        deflects--;
                        if (variable_instance_exists(id, "ogHitLimit"))
                        {
                            hitLimit = ogHitLimit;
                        }
                        else
                        {
                            hitLimit++;
                        }
                        OnDeflection();
                    }
                    else if (destroyOnHitLimit)
                    {
                        OnDestroyedByHitLimit();
                        instance_destroy();
                    }
                }
            }
        }
    }
}

function OnDeflection()
{
    if (variable_struct_exists(onDeflect, "Script") && variable_struct_exists(onDeflect, "config"))
    {
        onDeflect.Script(id, onDeflect.config);
    }
    else
    {
        direction = random(360);
        if (variable_instance_exists(self, "aimedDirection"))
        {
            aimedDirection = random(360);
        }
    }
}

var keys = variable_struct_get_names(config);
for (var i = 0; i < array_length(keys); i++)
{
    variable_instance_set(id, keys[i], variable_struct_get(config, keys[i]));
}
if (variable_instance_exists(creator, "weaponSizeMultiplier") && applyWeaponSize)
{
    image_xscale *= creator.weaponSizeMultiplier;
    image_yscale *= creator.weaponSizeMultiplier;
}
if (instance_exists(creator))
{
    startDirection *= creator.image_xscale;
}
else
{
    instance_destroy();
}
if (faceCreatorDirection)
{
    direction = creator.direction + startDirection;
    image_angle = creator.direction + startDirection;
}
else if (!faceCreatorDirection)
{
    direction += startDirection;
    image_angle += startDirection;
}
if (reverse > 0)
{
    direction += reverse;
    image_angle += reverse;
}
if (horizontalOnly)
{
    if (creator.image_xscale > 0)
    {
        direction = 0 + startDirection;
        image_angle = 0 + startDirection;
    }
    else
    {
        direction = 180 + startDirection;
        image_angle = 180 + startDirection;
    }
}
if (playSound != false)
{
    PlaySound(playSound);
}
if (startDistDirection)
{
    startx = lengthdir_x(startDistDirection, creator.direction);
    starty = lengthdir_y(startDistDirection, creator.direction);
}
x = x ? x : (creator.x + startx);
y = y ? y : (creator.y + starty);
if (afterImageColor != false)
{
    alarm[10] = 2;
    if (variable_instance_exists(self, "afterImageSequence"))
    {
        afterImageSequence = irandom(5);
    }
}
if (onCreate)
{
    if (typeof(onCreate) == "array")
    {
        for (var i = 0; i < (array_length(onCreate) - 1); i++)
        {
            onCreate[i](id, creator);
        }
    }
    else
    {
        onCreate(id, creator);
    }
}
