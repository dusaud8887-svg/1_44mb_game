event_inherited();
HP = 5 + random(5);
SPD = 0;
ATK = -1;
haste = 0;
depth = -y;
if (!variable_instance_exists(id, "noWarp"))
{
    noWarp = true;
}
breakable = false;
broken = false;
isEnemy = false;
isBoss = false;
isSolid = true;
miniboss = false;
hitShake = 0;
isObstacle = true;
shakeDisplacement = 2;
totalDamageTaken = 0;
timeStartedAttacking = -1;
image_speed = 0;
brokenPieces = -1;
foodChance = 40;
moneyChance = 40;
if (!variable_instance_exists(id, "clones"))
{
    clones = true;
}
if (variable_instance_exists(id, "meshJson"))
{
    if (!variable_instance_exists(id, "meshDepth"))
    {
        meshDepth = 200;
    }
    if (!variable_instance_exists(id, "shadowStrength"))
    {
        shadowStrength = 0.2;
    }
    mesh = glr_mesh_create(x, y, true);
    glr_mesh_submesh_add_json(mesh, meshJson, 0, 0);
    glr_mesh_update(mesh);
    glr_mesh_set_rotation(mesh, image_angle);
    glr_mesh_set_depth(mesh, meshDepth);
    glr_mesh_set_shadow_strength(mesh, shadowStrength);
}
if (clones && global.wrappingStage)
{
    if (x <= 1280)
    {
        var clone = instance_copy(false);
        clone.x += room_width - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (x >= (room_width - 1280))
    {
        var clone = instance_copy(false);
        clone.x -= room_width - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (y <= 1280)
    {
        var clone = instance_copy(false);
        clone.y += room_height - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (y >= (room_height - 1280))
    {
        var clone = instance_copy(false);
        clone.y -= room_height - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (x <= 1280 && y <= 1280)
    {
        var clone = instance_copy(false);
        clone.x += room_width - 1280;
        clone.y += room_height - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (x <= 1280 && y >= (room_height - 1280))
    {
        var clone = instance_copy(false);
        clone.x += room_width - 1280;
        clone.y -= room_height - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (x >= (room_width - 1280) && y <= 1280)
    {
        var clone = instance_copy(false);
        clone.x -= room_width - 1280;
        clone.y += room_height - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
    if (x >= (room_width - 1280) && y >= (room_height - 1280))
    {
        var clone = instance_copy(false);
        clone.x -= room_width - 1280;
        clone.y -= room_height - 1280;
        clone.depth = -y;
        clone.breakable = breakable;
        clone.broken = false;
        clone.brokenPieces = brokenPieces;
        clone.foodChance = foodChance;
        clone.moneyChance = moneyChance;
    }
}

function Die()
{
    if (!global.debug && !broken)
    {
        broken = true;
        audio_play_sound(snd_break, 30, 0);
        if (object_index == obj_YagooPillar)
        {
            DoAchievement("yagoostatue");
        }
        if (global.lightFX)
        {
            if (brokenPieces != -1)
            {
                for (var i = 0; i < 25; i++)
                {
                    var debris = instance_create_depth(x, y - irandom(spriteHeight), depth - 1, obj_vfx);
                    debris.sprite_index = brokenPieces;
                    debris.image_speed = 0;
                    debris.image_index = irandom(sprite_get_number(brokenPieces));
                    debris.duration = 90;
                    debris.gravity = 0.25;
                    debris.hspeed = -5 + irandom(10);
                    debris.vspeed = -2 - irandom(4);
                }
            }
        }
        var roll = irandom(99);
        if (roll < foodChance)
        {
            var drop = instance_create_depth(x, y - 20, depth, obj_Hamburger);
            drop.direction = floor(random(360));
            drop.speed = 4 + random(3);
        }
        else if (roll < moneyChance)
        {
            var drop = instance_create_depth(x, y - 20, depth, obj_HoloCoinDrop);
            drop.amountVal = 10 * global.moneyMultiplier;
            drop.direction = floor(random(360));
            drop.speed = 4 + random(3);
        }
    }
}

function TakeDamage(arg0, arg1, arg2)
{
    if (!broken)
    {
        arg0 = OnTakeDamage(arg0, arg1, arg2);
        arg0 = ApplyOnHitEffects(arg0, arg1, arg2);
        ApplyStatusEffects(arg0, arg1, arg2);
        if (invincible)
        {
            arg0 = 0;
        }
        ApplyDamage(arg0, arg1, arg2);
    }
}

function HitNumber(arg0, arg1, arg2, arg3 = true, arg4 = false)
{
    if (arg0 >= 0)
    {
        if (global.showDamageText && !noShowHit && instance_number(obj_damageText) < 100)
        {
            var hit = instance_create_depth(x, y - 30, depth - 1, obj_damageText);
            hit.critted = arg2;
            hit.shield = arg4;
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
            hit.isEnemy = true;
        }
    }
}

function ApplyDamage(arg0, arg1, arg2, arg3 = true)
{
    var damageAfterShield = arg0;
    if (arg0 >= 0)
    {
        if (shieldHP > 0)
        {
            if (damageAfterShield >= shieldHP)
            {
                HitNumber(shieldHP, arg1, arg2, arg3, true);
            }
            else
            {
                HitNumber(damageAfterShield, arg1, arg2, arg3, true);
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
            HitNumber(damageAfterShield, arg1, arg2, arg3);
        }
        if (!(object_index == obj_YagooPillar && global.debug))
        {
            currentHP -= 1;
        }
        hitShake = 4;
        totalDamageTaken += damageAfterShield;
        if (timeStartedAttacking == -1)
        {
            timeStartedAttacking = 0;
        }
    }
    if (arg3 && arg0 > 0)
    {
        soundPlay([212, 126], "HitSounds", 5, 1, true);
    }
    if (currentHP < 1)
    {
        if (is_undefined(arg1))
        {
            Die();
            exit;
        }
        Die(false, true, arg1);
    }
}
