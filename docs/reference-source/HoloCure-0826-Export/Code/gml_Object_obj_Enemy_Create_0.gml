event_inherited();
playerMesh = glr_mesh_create(x, y, false);
glr_mesh_submesh_add_json(playerMesh, "[[-6,-4],[5,-4],[5,-15],[-6,-15]]", 0, 0);
glr_mesh_update(playerMesh);
glr_mesh_set_layer(playerMesh, 1);
glr_mesh_set_depth(playerMesh, 100);
glr_mesh_set_shadow_strength(playerMesh, 0.2);
image_index = irandom(image_number - 1);
directionMoving = direction;
isDead = false;
moveOutsideCD = 0;
collidedCD = 0;
turnTimer = 0;
isEnemy = true;
normalMovement = false;
directionChangeTime = 0;
followTarget = -1;
teleportingWall = 0;
charging = false;
behaviourList = [];

function DropExp()
{
    if (expvalue > 0)
    {
        if (!isBoss)
        {
            var dropexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
            dropexp.expVal = expvalue * global.reducedSpawn;
            dropexp.direction = floor(random(360));
            dropexp.speed = 2 + random(3);
            with (dropexp)
            {
                instance_change(obj_EXP, true);
            }
        }
        else
        {
            var expPer = expvalue / 50;
            for (var i = 0; i < 50; i++)
            {
                var dropexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
                dropexp.expVal = expPer;
                dropexp.direction = floor(random(360));
                dropexp.speed = 4 + random(3);
                with (dropexp)
                {
                    instance_change(obj_EXP, true);
                }
            }
        }
    }
    global.totalPossibleEXP += expvalue;
    var playerDropChance = 0;
    var player = instance_find(obj_Player, 0);
    if (instance_exists(player))
    {
        playerDropChance = player.food;
    }
    var rollChance = (200 - (200 * (global.foodDropChanceBuff + playerDropChance))) / global.fruitFoodBuff;
    var rand = random(rollChance);
    if (rand < 1)
    {
        instance_create_depth(x, y - 20, depth, obj_Hamburger);
    }
    rollChance = 90 - (90 * global.moneyDropChanceBuff);
    rand = random(rollChance);
    if (rand < 1)
    {
        var money = instance_create_depth(x, y - 20, depth, obj_HoloCoinDrop);
        money.amountVal = 10;
    }
    rand = random(3000 - (3000 * global.rainbowEXPDrop));
    if (rand < 1)
    {
        var droppedexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
        droppedexp.expVal = expvalue * global.reducedSpawn;
        with (droppedexp)
        {
            instance_change(obj_EXPAbsorb, true);
        }
    }
    var procChance = floor(1300 - (1300 * global.anvilDropChanceBuff));
    rand = irandom(procChance);
    if (rand < 1 || global.freeAnvil)
    {
        global.freeAnvil = false;
        if (instance_exists(obj_Player))
        {
            if (variable_struct_exists(obj_Player.scripts, "CreditCard"))
            {
                if (!obj_Player.scripts.CreditCard.config.super)
                {
                    obj_Player.scripts.CreditCard.config.spawnCD = obj_Player.scripts.CreditCard.config.minTime + irandom(obj_Player.scripts.CreditCard.config.maxTime);
                }
            }
        }
        instance_create_depth((x - 10) + irandom(20), (y - 10) + irandom(20), depth, obj_holoAnvil);
        soundPlay([257], "anvil", 10, 75);
    }
    rand = random(800);
    if (global.goldAnvilCanDrop)
    {
        if (!instance_exists(obj_goldenAnvil))
        {
            rand = random(100 * (1 / (1 + (global.time[1] / 20))));
            if (rand < 1)
            {
                instance_create_depth((x - 10) + irandom(20), (y - 10) + irandom(20), depth, obj_goldenAnvil);
                soundPlay([181], "anvil", 10, 75);
                global.goldAnvilCanDrop = false;
            }
        }
    }
    rand = random(800);
    if (global.canGoldenHammer && global.goldFlag && global.PLAYERLEVEL >= 50)
    {
        rand = random(200 * (1 / (1 + (global.time[1] / 20))));
        if (rand < 1)
        {
            instance_create_depth((x - 10) + irandom(20), (y - 10) + irandom(20), depth, obj_GoldenHammer);
            soundPlay([210], "goldhammer", 10, 75);
            global.canGoldenHammer = false;
        }
    }
    if (array_length(global.availableStickers) > 0 && (ds_map_find_value(global.PlayerSave, "stamps") > 0 || global.gameMode == 2))
    {
        rand = random(780);
        if (rand < 1)
        {
            var droppedsticker = instance_create_depth(x, y - 20, depth, obj_Sticker);
            droppedsticker.RollSticker();
        }
    }
}

function ResetStatsToPreStepBuff()
{
    var keys = variable_struct_get_names(prebuffStats);
    for (var i = 0; i < array_length(keys); i++)
    {
        variable_instance_set(self, keys[i], variable_struct_get(prebuffStats, keys[i]));
    }
    if (haluBuffed)
    {
        haluBuffed = false;
    }
    if (poltatoNerfed)
    {
        poltatoNerfed = false;
    }
}

function Die(arg0 = false, arg1 = true, arg2 = undefined, arg3 = false, arg4 = false)
{
    if (!isDead)
    {
        isDead = true;
        obj_StageManager.enemyAmount--;
        if (global.gameMode == 2)
        {
            if (variable_instance_exists(self, "timeSubtract"))
            {
                if (isBoss)
                {
                    obj_StageManager.timer -= max(0, floor((max(0, 900 - max(0, aliveFor - 120)) / 900) * timeSubtract));
                }
                else
                {
                    obj_StageManager.timer -= max(0, floor((max(0, 360 - max(0, aliveFor - 120)) / 360) * timeSubtract));
                }
            }
        }
        OnDeath(-1, id, arg0);
        if (!is_undefined(arg2))
        {
            if (arg2.object_index == obj_Player)
            {
                arg2.OnKill(arg2, id, arg2);
            }
            if (variable_instance_exists(arg2, "creator") && !arg3)
            {
                arg2.creator.OnKill(arg2.creator, id, arg2);
            }
        }
        var ghost = instance_create_depth(x, y, depth - 1, obj_EnemyDead);
        if (!arg0)
        {
            if (arg1)
            {
                DropExp();
            }
            setForDeath = true;
            if (!arg4)
            {
                global.enemyDefeated++;
            }
        }
        else
        {
            ghost.moving = false;
        }
        if (isBoss && !arg0)
        {
            obj_Cam.ExecuteShake(90, 8);
            if (!noDeathSound)
            {
                audio_play_sound(snd_bossdefeated, 50, 0);
            }
        }
        if (!arg0 && !variable_instance_exists(self, "noBox") && (miniboss || isBoss))
        {
            instance_create_depth((x - 10) + irandom(20), (y - 10) + irandom(20), depth, obj_holoBox);
        }
        if (isBoss)
        {
            global.bossDefeated++;
        }
        if (miniboss)
        {
            global.miniBossDefeated++;
        }
        ghost.sprite_index = sprite_index;
        ghost.image_index = image_index;
        ghost.image_speed = 0;
        ghost.image_xscale = image_xscale;
        ghost.image_yscale = image_yscale;
        instance_create_depth(x, y - 20, depth - 50, obj_saved);
        var keys = variable_instance_get_names(self);
        for (var i = 0; i < array_length(keys); i++)
        {
            var obj = variable_struct_get(self, keys[i]);
            obj = undefined;
        }
        if (ds_exists(playerMesh, ds_type_list))
        {
            glr_mesh_destroy(playerMesh);
        }
        setForDeath = true;
    }
}

function UpdateBehaviorKeys()
{
    behaviourKeys = variable_struct_get_names(behaviours);
}

UpdateBehaviorKeys();
if (instance_exists(obj_Player))
{
    followTarget = instance_find(obj_Player, 0);
}
