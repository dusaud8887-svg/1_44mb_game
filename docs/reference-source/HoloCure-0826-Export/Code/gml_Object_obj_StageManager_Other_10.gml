function GenerateDirections()
{
    if ((slices % 4) != 0)
    {
        slices -= (slices % 4);
    }
    quadrantSize = slices / 4;
    center = 360 / slices / 2;
    sliceSize = 360 / slices;
    directions = [];
    directionsContainer = [];
    if (global.topBorder != -1 && global.bottomBorder != -1)
    {
        topBorder = global.topBorder;
        stageHeight = global.bottomBorder - global.topBorder;
        verticalSliceHeight = stageHeight / (slices / 2);
    }
    else
    {
        topBorder = NaN;
        stageHeight = NaN;
        verticalSliceHeight = NaN;
    }
    for (var i = 0; i < slices; i++)
    {
        if ((i % quadrantSize) == 0)
        {
            array_push(directions, []);
            array_push(directionsContainer, []);
        }
        array_push(directions[floor(i / quadrantSize)], center + (i * sliceSize));
        array_push(directionsContainer[floor(i / quadrantSize)], center + (i * sliceSize));
    }
    selectableQuadrants = [0, 1, 2, 3];
    selectableQuadrantsContainer = [0, 1, 2, 3];
}

function GrabDirection()
{
    var amountOfQuadrants = array_length(selectableQuadrants);
    if (amountOfQuadrants == 0)
    {
        array_copy(selectableQuadrants, 0, selectableQuadrantsContainer, 0, 4);
        amountOfQuadrants = array_length(selectableQuadrants);
    }
    var randomQuadrant = irandom(amountOfQuadrants - 1);
    var randomQuadrantIndex = selectableQuadrants[randomQuadrant];
    array_delete(selectableQuadrants, randomQuadrant, 1);
    var amountOfSlices = array_length(directions[randomQuadrantIndex]);
    if (amountOfSlices == 0)
    {
        array_copy(directions[randomQuadrantIndex], 0, directionsContainer[randomQuadrantIndex], 0, quadrantSize);
        amountOfSlices = array_length(directions[randomQuadrantIndex]);
    }
    var randomSliceIndex = irandom(amountOfSlices - 1);
    var randomSlice = directions[randomQuadrantIndex][randomSliceIndex];
    array_delete(directions[randomQuadrantIndex], randomSliceIndex, 1);
    return randomSlice;
}

function SpawnEnemyFromChoices(arg0 = false)
{
    if (arg0 || enemyAmount < enemyLimit)
    {
        var keys = variable_struct_get_names(mobSpawnChoices);
        if (array_length(keys) == 0)
        {
            return false;
        }
        var range = [];
        var start = 0;
        var endR = 0;
        for (var i = 0; i < array_length(keys); i++)
        {
            var mobSpawnChoice = variable_struct_get(mobSpawnChoices, keys[i]);
            endR = mobSpawnChoice.weight + start;
            array_push(range, [start, endR, keys[i]]);
            start = endR;
        }
        var roll = irandom(endR - 1);
        var choice = "broken";
        var level = 1;
        for (var i = 0; i < array_length(range); i++)
        {
            start = range[i][0];
            endR = range[i][1];
            if (roll >= start && roll < endR)
            {
                choice = range[i][2];
                level = variable_struct_get(mobSpawnChoices, range[i][2]).level;
            }
        }
        var mobWeightData = variable_struct_get(mobSpawnChoices, choice);
        var pos = {};
        var dir = GrabDirection();
        if (mobWeightData.spawnDirection != false)
        {
            dir = ParseSpawnDirection(dir, mobWeightData.spawnDirection.pattern, mobWeightData.spawnDirection.dir);
        }
        else
        {
            dir = ParseSpawnDirection(dir);
        }
        if (instance_exists(obj_Player))
        {
            pos.x = obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.5, dir);
            pos.y = obj_Player.y + lengthdir_y(camera_get_view_height(view_camera[0]) / 1.5, dir);
            if (string_count("stage2_", currentSpawnPattern) > 0)
            {
                pos = _Stage2GetPosition(dir);
            }
            obj_MobManager.SpawnMob(choice, pos, level);
        }
    }
}

function ParseSpawnDirection(arg0, arg1 = currentSpawnPattern, arg2 = 0)
{
    switch (arg1)
    {
        case "evenSurround":
            return arg0;
        case "horizontalSurround":
            if ((arg0 >= 225 && arg0 <= 315) || (arg0 >= 45 && arg0 <= 135))
            {
                return arg0 + 90;
            }
            else
            {
                return arg0;
            }
        case "verticalSurround":
            if ((arg0 >= 315 && arg0 <= 360) || (arg0 >= 0 && arg0 <= 45) || (arg0 >= 135 && arg0 <= 225))
            {
                return arg0 + 90;
            }
            else
            {
                return arg0;
            }
        case "directionalSurround":
            var targetDir = arg2;
            return (targetDir - 45) + round(arg0 / 4);
        case "stage2_evenSurround":
            return arg0;
        case "stage2_leftSurround":
            return arg0 / 2;
        case "stage2_rightSurround":
            return (arg0 / 2) + 180;
        case "random":
            return irandom(360);
    }
}

function _Stage2GetPosition(arg0)
{
    var pos = {};
    var side = 0;
    arg0 = floor(arg0 / sliceSize);
    if (arg0 > floor(slices / 2))
    {
        side = 1;
        arg0 -= floor(slices / 2);
    }
    var yOffset = floor(arg0 * verticalSliceHeight);
    pos.y = topBorder + yOffset;
    pos.x = (camera_get_view_x(view_camera[0]) - 64) + (side * (camera_get_view_width(view_camera[0]) + 64));
    return pos;
}

function ChangeSpawnPattern(arg0)
{
    _id = arg0.id;
    dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    if (variable_struct_exists(spawnPatterns, _id))
    {
        currentSpawnPattern = _id;
        currentSpawnDirection = dir;
        return true;
    }
    else
    {
        return "No pattern named " + id + " exists in spawnPatterns.";
    }
}

function AddMobChoice(arg0, arg1 = 1, arg2 = 1, arg3 = false)
{
    if (ds_map_exists(obj_MobManager.Mobs, arg0))
    {
        variable_struct_set(mobSpawnChoices, arg0, 
        {
            weight: arg1,
            level: arg2,
            spawnDirection: arg3
        });
        show_debug_message(arg0 + " LVL " + string(arg2) + " has been added to choice pool with weight " + string(arg1));
        return true;
    }
    else
    {
        return "No mob named " + string(arg0) + " exists in obj_MobManager.Mobs";
    }
}

function RemoveMobChoice(arg0)
{
    if (variable_struct_exists(mobSpawnChoices, arg0))
    {
        variable_struct_remove(mobSpawnChoices, arg0);
    }
}

function AddTimeEvent(arg0, arg1, arg2, arg3, arg4, arg5 = {})
{
    if (arg1 < 0 || arg1 > 59 || arg2 < 0 || arg2 > 59)
    {
        return "Invalid time inputted.";
    }
    if (!variable_struct_exists(timelineCommands, arg0))
    {
        variable_struct_set(timelineCommands, arg0, {});
    }
    var timelineHour = variable_struct_get(timelineCommands, arg0);
    if (!variable_struct_exists(timelineHour, arg1))
    {
        variable_struct_set(timelineHour, arg1, {});
    }
    var timelineMinute = variable_struct_get(timelineHour, arg1);
    if (!variable_struct_exists(timelineMinute, arg2))
    {
        variable_struct_set(timelineMinute, arg2, {});
    }
    var timelineSecond = variable_struct_get(timelineMinute, arg2);
    variable_struct_set(timelineSecond, arg3, 
    {
        Script: arg4,
        config: arg5
    });
}

function RemoveTimeEvent(arg0, arg1, arg2, arg3 = false)
{
    if (arg1 < 0 || arg1 > 59 || arg2 < 0 || arg2 > 59)
    {
        return "Invalid time inputted.";
    }
    if (!variable_struct_exists(timelineCommands, arg0))
    {
        return "No event with specified hour/min/second/name.";
    }
    var timelineHour = variable_struct_get(timelineCommands, arg0);
    if (!variable_struct_exists(timelineHour, arg1))
    {
        return "No event with specified hour/min/second/name.";
    }
    var timelineMinute = variable_struct_get(timelineHour, arg1);
    if (!variable_struct_exists(timelineSecond, arg2))
    {
        return "No event with specified hour/min/second/name.";
    }
    var timelineSecond = variable_struct_get(timelineMinute, arg2);
    if (arg3)
    {
        variable_struct_remove(timelineSecond, arg3);
    }
    else
    {
        variable_struct_remove(timelineMinute, arg2);
    }
}

function CheckTimeForEvent(arg0, arg1, arg2)
{
    if (arg1 < 0 || arg1 > 59 || arg2 < 0 || arg2 > 59)
    {
        return "Invalid time inputted.";
    }
    if (!variable_struct_exists(timelineCommands, arg0))
    {
        return "No event with specified hour/min/second/name.";
    }
    var timelineHour = variable_struct_get(timelineCommands, arg0);
    if (!variable_struct_exists(timelineHour, arg1))
    {
        return "No event with specified hour/min/second/name.";
    }
    var timelineMinute = variable_struct_get(timelineHour, arg1);
    if (!variable_struct_exists(timelineMinute, arg2))
    {
        return "No event with specified hour/min/second/name.";
    }
    var timelineSecond = variable_struct_get(timelineMinute, arg2);
    var keys = variable_struct_get_names(timelineSecond);
    for (var i = 0; i < array_length(keys); i++)
    {
        var Script = variable_struct_get(timelineSecond, keys[i]).Script;
        var args = variable_struct_get(timelineSecond, keys[i]).config;
        Script(args);
    }
}
