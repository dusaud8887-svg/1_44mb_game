event_inherited();
if (moveOutsideCD > 0)
{
    moveOutsideCD--;
}
if (completeStop)
{
    exit;
}
if (!inView)
{
    if (point_distance(x, y, obj_Player.x, obj_Player.y) > 1500)
    {
        if (!isBoss && !miniboss)
        {
            Die(true);
        }
    }
}
if (!isDead && tangible && collidedCD == 0)
{
    var thing = instance_place(x, y, obj_Enemy);
    if (thing != -4 && thing.tangible && thing.isEnemy && isEnemy)
    {
        var pdir = point_direction(thing.x, thing.y, x, y);
        if (moveOutsideCD == 0)
        {
            if (!inView)
            {
                move_outside_all(pdir, 10);
            }
            else
            {
                move_outside_all(pdir, 3 + SPD);
            }
            moveOutsideCD = 4;
        }
        collidedCD = 5;
    }
}
if (!variable_instance_exists(self, "ignoreWalls") || (variable_instance_exists(self, "ignoreWalls") && !ignoreWalls))
{
    if (global.topBorder != -1)
    {
        if (y < global.topBorder)
        {
            y = global.topBorder;
        }
    }
    if (global.bottomBorder != -1)
    {
        if (y > global.bottomBorder)
        {
            y = global.bottomBorder;
        }
    }
    if (global.leftBorder != -1)
    {
        if (x < global.leftBorder)
        {
            x = global.leftBorder;
        }
    }
    if (global.rightBorder != -1)
    {
        if (x > global.rightBorder)
        {
            x = global.rightBorder;
        }
    }
}
if (speed > 0 && speed != SPD && isKnockback.timer == 0 && !charging)
{
    speed = SPD;
}
if (directionChangeTime > 0)
{
    directionChangeTime--;
}
if (collidedCD > 0)
{
    collidedCD--;
}
var player = instance_find(obj_Player, 0);
if (lockFacing && turnTimer == 0 && canMove)
{
    if (player.x > x)
    {
        image_xscale = abs(image_xscale);
    }
    else
    {
        image_xscale = -abs(image_xscale);
    }
    turnTimer = 15;
}
if (turnTimer > 0)
{
    turnTimer--;
}
if (lifeTime > 0)
{
    lifeTime--;
}
if (lifeTime == 0)
{
    Die(true);
}
if (!isDead && isKnockback.timer == 0)
{
    for (var i = 0; i < array_length(behaviourKeys); i++)
    {
        if (variable_struct_exists(behaviours, behaviourKeys[i]))
        {
            var Script = variable_struct_get(behaviours, behaviourKeys[i]).Script;
            var config = variable_struct_get(behaviours, behaviourKeys[i]).config;
            Script(self, config);
        }
    }
}
if (hitCDTimer > 0)
{
    hitCDTimer--;
}
if (!haluBuffed && global.haluBuff > 0 && !ignoreHalu)
{
    haluBuffed = true;
    var wasFullHP = false;
    if (currentHP == HP)
    {
        wasFullHP = true;
    }
    HP *= (1 + global.haluBuff);
    if (wasFullHP)
    {
        currentHP = HP;
    }
    ATK *= (1 + global.haluBuff);
    SPD *= (1 + global.haluBuff);
}
if (!poltatoNerfed && global.poltatoNerf > 0 && !ignorePoltato)
{
    poltatoNerfed = true;
    if (!isBoss && !miniboss)
    {
        var wasFullHP = false;
        if (currentHP == HP)
        {
            wasFullHP = true;
        }
        HP *= 2.5;
        if (wasFullHP)
        {
            currentHP = HP;
        }
    }
    else
    {
        var wasFullHP = false;
        if (currentHP == HP)
        {
            wasFullHP = true;
        }
        HP *= 1.5;
        if (wasFullHP)
        {
            currentHP = HP;
        }
    }
    obj_AttackController.ApplyBuff(id, "PoltatoPC", ds_map_find_value(obj_AttackController.Buffs, "PoltatoPC"));
    SPD *= 0.75;
}
aliveFor++;
