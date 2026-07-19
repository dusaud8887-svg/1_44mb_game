function sh_toggle_debug()
{
    global.debug = !global.debug;
    var message = global.debug ? "on." : "off.";
    return "Debug mode is now " + message;
}

function meta_toggle_debug()
{
    return 
    {
        description: "Toggles debug mode of game."
    };
}

function sh_givemoney()
{
    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + 99999999);
}

function sh_show_player_stats()
{
    if (!instance_exists(obj_DebugManager))
    {
        return "Error: debug manager does not exist.";
    }
    var debugManager = 192;
    if (variable_struct_exists(debugManager.drawScripts, "ShowPlayerStats"))
    {
        variable_struct_remove(debugManager.drawScripts, "ShowPlayerStats");
        return "Disabled show player stats.";
    }
    debugManager.drawScripts.ShowPlayerStats = debugManager.ShowPlayerStats;
    return "Showing player stats.";
}

function sh_debug_showmonsterspeed()
{
    if (!instance_exists(obj_DebugManager))
    {
        exit;
    }
    var debugManager = 192;
    debugManager.showMonsterSpeed = !debugManager.showMonsterSpeed;
    with (obj_Enemy)
    {
        if (debugManager.showMonsterSpeed)
        {
            customDrawScriptAbove.ShowMonsterSpeed = debugManager.ShowMonsterSpeed;
        }
        else if (variable_struct_exists(customDrawScriptAbove, "ShowMonsterSpeed"))
        {
            variable_struct_remove(customDrawScriptAbove, "ShowMonsterSpeed");
        }
    }
    if (debugManager.showMonsterSpeed)
    {
        return "Showing monster speed.";
    }
    else
    {
        return "Disabled showing monster speed.";
    }
}

function meta_show_player_staats()
{
    return 
    {
        description: "Enables player debug overlay if debug mode is on."
    };
}

function sh_spawn_mob_near_player(arg0)
{
    with (obj_StageManager)
    {
        var pos = {};
        var dir = GrabDirection();
        pos.x = obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 3, dir);
        pos.y = obj_Player.y + lengthdir_y(camera_get_view_width(view_camera[0]) / 3, dir);
        obj_MobManager.SpawnMob(arg0[1], pos);
    }
}

function meta_spawn_mob_near_player()
{
    return 
    {
        description: "Spawns a mob to the bottom right of the player, close by.",
        arguments: ["id"],
        argumentDescriptions: ["The ID of the mob that you want to spawn (defined in MobManager)."]
    };
}

function sh_spawn_mob(arg0)
{
    with (obj_StageManager)
    {
        for (var i = 0; i < arg0[2]; i++)
        {
            var pos = {};
            var dir = GrabDirection();
            pos.x = obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.5, dir);
            pos.y = obj_Player.y + lengthdir_y(camera_get_view_width(view_camera[0]) / 1.5, dir);
            obj_MobManager.SpawnMob(arg0[1], pos);
        }
    }
}

function meta_spawn_mob()
{
    return 
    {
        description: "Spawns a mob.",
        arguments: ["id", "numberOfMobs"],
        argumentDescriptions: ["The ID of the mob that you want to spawn (defined in MobManager).", "Number of mobs you want to spawn."]
    };
}

function sh_spawn_circle_of_mobs(arg0)
{
    with (obj_StageManager)
    {
        for (var i = 0; i < 37; i++)
        {
            var pos = {};
            var dir = GrabDirection();
            pos.x = obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.5, dir);
            pos.y = obj_Player.y + lengthdir_y(camera_get_view_width(view_camera[0]) / 1.5, dir);
            obj_MobManager.SpawnMob(arg0[1], pos);
        }
    }
}

function sh_toggle_spawner()
{
    obj_StageManager.enabledSpawner = !obj_StageManager.enabledSpawner;
}

function sh_sm_addmobchoice(arg0)
{
    if (array_length(arg0) > 3)
    {
        obj_StageManager.AddMobChoice(arg0[1], int64(arg0[2]), arg0[3]);
    }
    else
    {
        obj_StageManager.AddMobChoice(arg0[1], int64(arg0[2]));
    }
}

function meta_sm_addmobchoice()
{
    return 
    {
        description: "Spawns a mob.",
        arguments: ["id", "weight", "level"],
        argumentDescriptions: ["The ID of the mob that you want to spawn (defined in MobManager). (required)", "Number of mobs you want to spawn. (required)", "Level of mobs you want to spawn. (optional)"]
    };
}

function sh_sm_removemobchoice(arg0)
{
    var keys = variable_struct_get_names(obj_StageManager.mobSpawnChoices);
    if (array_length(arg0) == 1)
    {
        if (array_length(keys) > 0)
        {
            arg0[1] = keys[0];
        }
        else
        {
            return "Spawning mob choices already empty.";
        }
    }
    obj_StageManager.RemoveMobChoice(arg0[1]);
}

function meta_sm_removemobchoice(arg0)
{
    return 
    {
        description: "Removes a mob from possible spawn pool.",
        arguments: ["id"],
        argumentDescriptions: ["The ID of the mob that you want to remove. If not specified, will remove first option."]
    };
}

function sh_sm_settime(arg0)
{
    global.time[UnknownEnum.Value_1] = int64(arg0[1]);
    global.time[UnknownEnum.Value_2] = int64(arg0[2]);
}

function meta_sm_settime(arg0)
{
    return 
    {
        description: "Sets the current timer to specified time",
        arguments: ["minute", "second"],
        argumentDescriptions: ["Minute you want to set it to", "Second you want to set it to"]
    };
}

function sh_pm_addperk(arg0)
{
    if (array_length(arg0) != 2)
    {
        return "Not enough or too many arguments for command.";
    }
    if (!instance_exists(obj_PlayerManager))
    {
        return "Player manager does not exist.";
    }
    obj_PlayerManager.AddPerk(arg0[1]);
}

function sh_pm_addattack(arg0)
{
    if (array_length(arg0) != 2)
    {
        return "Not enough or too many arguments for command.";
    }
    if (!instance_exists(obj_PlayerManager))
    {
        return "Player manager does not exist.";
    }
    obj_PlayerManager.AddAttack(arg0[1]);
}

function sh_pm_addcollab(arg0)
{
    if (array_length(arg0) != 2)
    {
        return "Not enough or too many arguments for command.";
    }
    if (!instance_exists(obj_PlayerManager))
    {
        return "Player manager does not exist.";
    }
    obj_PlayerManager.AddCollab(arg0[1]);
}

function sh_pm_additem(arg0)
{
    if (array_length(arg0) != 2)
    {
        return "Not enough or too many arguments for command.";
    }
    if (!instance_exists(obj_PlayerManager))
    {
        return "Player manager does not exist.";
    }
    obj_PlayerManager.AddItem(arg0[1]);
}

function sh_sm_eventspawnclumpeddirection(arg0)
{
    var config = 
    {
        id: arg0[1],
        amount: arg0[2],
        dir: arg0[3],
        level: (array_length(arg0) > 4) ? arg0[4] : 1
    };
    obj_StageManager.EventSpawnClumpedDirection(config);
}

function sh_pm_showplayerweapons()
{
    var weapons = obj_PlayerManager.weapons;
    var keys = variable_struct_get_names(weapons);
    var container = [];
    var newWeaponsContainer = [];
    show_debug_message("WEAPONS CONTAINER");
    for (var i = 0; i < array_length(keys); i++)
    {
        var weapon = variable_struct_get(weapons, keys[i]);
        show_debug_message(weapon);
        if (weapon.level > 0)
        {
            array_push(container, weapon);
        }
        if (weapon.level == 0)
        {
            array_push(newWeaponsContainer, weapon);
        }
    }
    show_debug_message("OWNED WEAPONS");
    for (var i = 0; i < array_length(container); i++)
    {
        show_debug_message(container[i]);
    }
    show_debug_message("NOT OWNED WEAPONS");
    for (var i = 0; i < array_length(newWeaponsContainer); i++)
    {
        show_debug_message(newWeaponsContainer[i]);
    }
    show_debug_message("AVAILABLE WEAPON COLLABS");
    show_debug_message(obj_PlayerManager.availableWeaponCollabs);
}

function sh_levelplayer(arg0)
{
    var lvlrate1 = obj_PlayerManager.lvlrate1;
    var lvlexponent = obj_PlayerManager.lvlexponent;
    if (array_length(arg0) > 1 && is_numeric(arg0[1]))
    {
        while (arg0[1] > 0)
        {
            global.experience = round(power(lvlrate1 * (global.PLAYERLEVEL + 1), lvlexponent)) + 1;
            args[1]--;
        }
    }
    else
    {
        global.experience = round(power(lvlrate1 * (global.PLAYERLEVEL + 1), lvlexponent)) + 1;
    }
}

function sh_pm_setatk(arg0)
{
    obj_Player.SetStats(
    {
        ATK: int64(arg0[1])
    });
}

function sh_pm_setcrit(arg0)
{
    obj_Player.SetStats(
    {
        crit: int64(arg0[1])
    });
}

function sh_pm_sethaste(arg0)
{
    obj_Player.SetStats(
    {
        haste: int64(arg0[1])
    });
}

function sh_addavailableperk()
{
    with (obj_PlayerManager)
    {
        var keys = variable_struct_get_names(charPerks);
        AddPerk(keys[0]);
    }
}

function sh_stopattacks()
{
    with (obj_Player)
    {
        stopAttacks = !stopAttacks;
    }
}

function sh_sethp(arg0)
{
    obj_Player.currentHP = int64(arg0[1]);
}

function sh_maxyubistacks()
{
    var Buffs = obj_AttackController.Buffs;
    ds_map_find_value(Buffs, "Yubi").currentConfig.stacks = 30;
    ds_map_find_value(Buffs, "Yubi").timer = -1;
}

function sh_sm_togglespawns()
{
    obj_StageManager.enabledSpawner = !obj_StageManager.enabledSpawner;
}

function sh_debug_message()
{
    show_debug_message(global.lives);
    var cornerDirections = 
    {
        i: 29.36,
        i2: 150.64,
        i3: 209.36,
        i4: 330.64
    };
    var edgePoint = instance_create_depth(0, 0, -10000, directional_test);
    edgePoint.image_xscale = 2.5;
    edgePoint.image_yscale = 4;
    var centerPoint = {};
    centerPoint.x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2);
    centerPoint.y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2);
    var borderPoint = {};
    borderPoint.x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]);
    borderPoint.y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);
    var directionToBorder = point_direction(centerPoint.x, centerPoint.y, borderPoint.x, borderPoint.y);
    show_debug_message("-------------------------");
    show_debug_message("TESTING FINDEDGESPAWN");
    var edge = obj_StageManager._FindEdgeSpawnCoordinate(45, 
    {
        width: 0,
        height: 0
    });
    show_debug_message("x: " + string(edge.x) + " y: " + string(edge.y));
    var loggingIndicator = instance_create_depth(edge.x, edge.y, -10000, directional_test2);
    loggingIndicator.dir = 45;
    var directionalIndicator = instance_create_depth(0, 0, -10000, directional_test3);
    var directionalIndicator2 = instance_create_depth(0, 0, -10000, directional_test4);
}

var i = 29.36;
var i2 = 150.64;
var i3 = 209.36;
var i4 = 330.64;

function sh_testdirection(arg0)
{
    var sm = 26;
    sm.EventSpawnDirectionLocked(
    {
        id: arg0[1],
        dir: int64(arg0[2]),
        dirMoving: int64(arg0[3])
    });
}

function sh_testhorde()
{
    obj_StageManager.EventSpawnHorde(
    {
        id: "KFPHorde",
        level: 1,
        amount: 100,
        dir: obj_StageManager.ParseSpawnDirection(irandom(360), "random")
    });
}

function sh_sm_showspawnpattern()
{
    show_debug_message(obj_StageManager.currentSpawnPattern);
}

function sh_setgodmode()
{
    obj_Player.invincible = true;
    obj_Player.invincibilityTimer = -1;
}

function sh_sm_stage2eventspawnwall()
{
    obj_StageManager.Stage2_EventSpawnWall(
    {
        id: "Takodachi",
        spacing: 32,
        dir: 270
    });
}

function sh_isgoldenanvilavailable()
{
    show_debug_message(global.goldAnvilCanDrop);
}

function sh_testelimination()
{
    var randomIndex = irandom(variable_struct_names_count(obj_PlayerManager.weapons) - 1);
    var randomKey = array_get(variable_struct_get_names(obj_PlayerManager.weapons), randomIndex);
    var randomWeapon = variable_struct_get(obj_PlayerManager.weapons, randomKey);
    var option = 
    {
        optionID: randomKey,
        optionType: "RemoveWeapon"
    };
    show_debug_message("Removing " + randomKey);
    obj_PlayerManager.ParseAndPushCommandType(option);
    show_debug_message(obj_PlayerManager.weapons);
}

function sh_testitemelimination()
{
    var keys = ds_map_keys_to_array(obj_PlayerManager.ITEMS);
    var randomKey = irandom(array_length(keys) - 1);
    while (array_exists(obj_PlayerManager.removedItems, keys[randomKey]) && array_length(obj_PlayerManager.removedItems) < array_length(keys))
    {
        randomKey = irandom(array_length(keys) - 1);
    }
    randomKey = keys[randomKey];
    var option = 
    {
        optionID: randomKey,
        optionType: "RemoveItem"
    };
    show_debug_message("Removing " + randomKey);
    obj_PlayerManager.ParseAndPushCommandType(option);
    show_debug_message(obj_PlayerManager.items);
}

function sh_testperkelimination()
{
    var randomIndex = irandom(variable_struct_names_count(obj_PlayerManager.charPerks) - 1);
    var randomKey = array_get(variable_struct_get_names(obj_PlayerManager.charPerks), randomIndex);
    var randomPerk = variable_struct_get(obj_PlayerManager.charPerks, randomKey);
    var option = 
    {
        optionID: randomKey,
        optionType: "RemoveSkill"
    };
    show_debug_message("Removing " + randomKey);
    obj_PlayerManager.ParseAndPushCommandType(option);
    show_debug_message(obj_PlayerManager.charPerks);
}

function sh_clearstage()
{
    obj_PlayerManager.GameWin();
}

function sh_testarmoryunlocks()
{
    CheckArmouryMaxed();
}

function sh_testweaponunlock()
{
    show_debug_message("Unlocking HoloLaser");
    DoAchievement("midboss");
    UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "HoloLaser", "WEAPON");
    show_debug_message("\n Available weapons: " + obj_PlayerManager.weapons);
}

function sh_testitemunlock()
{
    show_debug_message("Unlocking Halu");
    DoAchievement("delusional");
    UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Halu", "ITEM");
    var output = "";
    for (var i = 0; i < array_length(obj_PlayerManager.unlockedItems); i++)
    {
        output += (obj_PlayerManager.unlockedItems[i] + ", ");
    }
    show_debug_message("\n Available items: " + output);
}

function sh_resetplayersave()
{
    ResetPlayerSave();
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
