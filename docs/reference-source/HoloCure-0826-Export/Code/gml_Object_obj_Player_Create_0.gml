event_inherited();
isStrafing = 0;
wlevel = 1;
baseStats.HP = HP;
baseStats.ATK = ATK;
baseStats.SPD = SPD;
baseStats.crit = crit;
baseStats.pickupRange = pickupRange;
baseStats.attackCount = attackCount;
baseStats.hitLimit = hitLimit;
baseStats.CritMod = CritMod;
baseStats.specMod = specMod;
baseStats.healMultiplier = healMultiplier;
expMultiplier = 1;
prebuffStats.crit = crit;
prebuffStats.pickupRange = pickupRange;
prebuffStats.attackCount = attackCount;
prebuffStats.hitLimit = hitLimit;
weaponSizeMultiplier = 1;
knockbackMultiplier = 1;
healMultiplier = 1;
specMod = 1;
foodMultiplier = 20;
isAttacking = false;
isAlive = true;
if (variable_global_exists("playerAttacks") && ds_exists(global.playerAttacks, ds_type_map))
{
    ds_map_destroy(global.playerAttacks);
    global.playerAttacks = -1;
}
attacks = ds_map_create();
global.playerAttacks = attacks;
specialMeter = 0;
specialTimer = 0;
canSpecial = false;
extraSpecial = 0;
instantRefreshSpecial = false;
afterImageOn = false;
stopAttacks = false;
inView = true;
regenTimer = 300;
onCollide = {};
specMustWait = 0;
mouseFollowMode = false;
stopDeath = false;
canControl = true;
global.experience = 0;
petting = false;
playerMesh = glr_mesh_create(x, y, false);
interactNear = false;
isPlayer = true;
glr_mesh_submesh_add_json(playerMesh, "[[-6,-4],[5,-4],[5,-15],[-6,-15]]", 0, 0);
glr_mesh_update(playerMesh);
glr_mesh_set_layer(playerMesh, 1);
glr_mesh_set_depth(playerMesh, 0);
glr_mesh_set_shadow_strength(playerMesh, 0.4);

function UpdateHP()
{
    alarm[2] = 1;
}

function OnCollide(arg0, arg1)
{
    if (variable_struct_names_count(onCollide) > 0)
    {
        var keys = variable_struct_get_names(onCollide);
        for (var i = 0; i < array_length(keys); i++)
        {
            var scriptObject = variable_struct_get(onCollide, keys[i]);
            var Script = scriptObject.Script;
            var config = scriptObject.config;
            arg1 = Script(id, arg1, config, arg0);
        }
    }
    return arg1;
}

function Move()
{
    var gamepadSpeedMultiplier = 1;
    if (canControl)
    {
        if (instance_exists(obj_PlayerManager))
        {
            obj_PlayerManager.couchPotatoFlag = false;
        }
        if (isAlive)
        {
            var moveDir = point_direction(0, 0, obj_InputManager.directionHorizontal, obj_InputManager.directionVertical);
            if (!place_meeting(x + lengthdir_x(SPD * gamepadSpeedMultiplier, moveDir), y, obj_Obstacle))
            {
                x += lengthdir_x(SPD * gamepadSpeedMultiplier, moveDir);
            }
            if (!place_meeting(x, y + lengthdir_y(SPD * gamepadSpeedMultiplier, moveDir), obj_Obstacle))
            {
                y += lengthdir_y(SPD * gamepadSpeedMultiplier, moveDir);
            }
            sprite_index = runSprite;
            if (!mouseFollowMode)
            {
                if (!isStrafing)
                {
                    if (is_undefined(input_direction(undefined, "aim_left", "aim_right", "aim_up", "aim_down")))
                    {
                        direction = obj_InputManager.direction;
                        if (variable_instance_exists(self, "drunkDirection"))
                        {
                            direction += drunkDirection;
                        }
                    }
                }
                else
                {
                    obj_InputManager.direction = direction;
                    if (instance_exists(obj_PlayerManager))
                    {
                        obj_PlayerManager.playerFlags.strafed = true;
                    }
                }
            }
            isMoving = true;
            if (instance_exists(obj_PlayerManager))
            {
                obj_PlayerManager.playerFlags.moved = true;
            }
        }
    }
    if (petting && global.new_camera_scale != 1)
    {
        petting = false;
        stopAttacks = false;
        global.new_camera_scale = 1;
        var pet = instance_find(obj_Summon, 0);
        if (instance_exists(pet))
        {
            pet.stopAttacks = false;
            pet.sprite_index = spr_Ame_bubba;
        }
    }
}

function Stop()
{
    if (sprite_index != spr_Ame_petting && sprite_index != spr_Ame_O1_pet && sprite_index != spr_Ame_O2_pet && sprite_index != spr_Ame_O3_pet)
    {
        sprite_index = idleSprite;
    }
    isMoving = false;
}

function Die(arg0 = false, arg1 = false, arg2 = undefined)
{
    if (isAlive)
    {
        if (arg2 != undefined)
        {
            OnDeath(self, arg2);
        }
        else
        {
            OnDeath(self, -1);
        }
        if (variable_struct_exists(scripts, "Plushie"))
        {
            scripts.Plushie.config.damageDebt = 0;
        }
        if (variable_struct_exists(buffs, "UndeadPenalty"))
        {
            obj_AttackController.RemoveBuff(self, "UndeadPenalty");
        }
        if (variable_struct_exists(buffs, "Undead2"))
        {
            obj_AttackController.RemoveBuff(self, "Undead2");
        }
        if (stopDeath)
        {
            stopDeath = false;
            exit;
        }
        if (global.lives > 1)
        {
            if (canNotDie)
            {
                exit;
            }
            obj_PlayerManager.paused = true;
            obj_PlayerManager.reviving = true;
            obj_PlayerManager.Pause();
            obj_PlayerManager.canControl = false;
            obj_PlayerManager.alarm[1] = 30;
            currentHP = max(1, HP / 2);
            obj_PlayerManager.hpSus = currentHP - 1;
            invincible = true;
            invincibilityTimer = 300;
            with (obj_Enemy)
            {
                if (!miniboss && !isBoss)
                {
                    Die();
                }
            }
            global.lives--;
        }
        else
        {
            part_emitter_destroy_all(global.psystem);
            isAlive = false;
            visible = false;
            for (var i = 0; i < 12; i++)
            {
                var heart = instance_create_depth(x, y - 16, depth - 1, obj_deathHeart);
                heart.direction = (i * 360) / 12;
                heart.speed = 2;
            }
            var playerMan = instance_find(obj_PlayerManager, 0);
            playerMan.gameDone = true;
            alarm[0] = 180;
            mask_index = spr_empty;
        }
    }
}

function SnapshotPrebuffStats()
{
    var keys = variable_struct_get_names(prebuffStats);
    for (var i = 0; i < array_length(keys); i++)
    {
        var stat = variable_instance_get(self, keys[i]);
        variable_struct_set(prebuffStats, keys[i], stat);
    }
}
