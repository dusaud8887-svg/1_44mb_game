function EventSpawnClumpedDirection(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    var mobSize = variable_struct_exists(arg0, "size") ? arg0.size : 16;
    var pattern = variable_struct_exists(arg0, "pattern") ? arg0.pattern : "square";
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var mobId = arg0.id;
    var amount = arg0.amount;
    var spawnPos = 
    {
        x: obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.5, dir),
        y: obj_Player.y + lengthdir_y(camera_get_view_height(view_camera[0]) / 1.5, dir)
    };
    var amountSquared = round(floor(sqrt(amount)) / global.reducedSpawn);
    var spawnedMobsContainer = [];
    for (var i = 0; i < (floor(amount / amountSquared) + 1); i++)
    {
        for (var i2 = 0; i2 < amountSquared; i2++)
        {
            var mobSpawnPos = 
            {
                x: spawnPos.x + (i * mobSize),
                y: spawnPos.y + (i * mobSize)
            };
            array_push(spawnedMobsContainer, obj_MobManager.SpawnMob(mobId, mobSpawnPos, level, spawnOverride));
            amount--;
            if (amount == 0)
            {
                return spawnedMobsContainer;
            }
        }
    }
}

function EventSpawnDirection(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var chance = variable_struct_exists(arg0, "chance") ? arg0.chance : 100;
    var canReduce = variable_struct_exists(arg0, "canReduce") ? arg0.canReduce : false;
    var pos = {};
    var mobId = arg0.id;
    var roll = irandom(99);
    if (canReduce)
    {
        amount = max(1, round(amount / global.reducedSpawn));
    }
    if (chance >= roll || global.debug)
    {
        while (amount > 0)
        {
            if (mobId == "GoldenYagoo" || mobId == "SilverYagoo")
            {
                audio_play_sound(snd_goldenyagoo, 75, 0);
            }
            var newDir = 0;
            if (is_string(dir))
            {
                var randDir = irandom(360);
                newDir = ParseSpawnDirection(randDir, dir, 0);
            }
            else
            {
                newDir = dir;
            }
            pos.x = obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.5, newDir);
            pos.y = obj_Player.y + lengthdir_y(camera_get_view_height(view_camera[0]) / 1.5, newDir);
            obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride);
            amount--;
        }
    }
}

function EventSpawnCircle(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var canReduce = variable_struct_exists(arg0, "canReduce") ? arg0.canReduce : false;
    var pos = {};
    var mobId = arg0.id;
    if (canReduce)
    {
        amount = max(1, round(amount / global.reducedSpawn));
    }
    var circleDir = 360 / amount;
    for (var i = 0; i < amount; i++)
    {
        var newDir = ParseSpawnDirection(circleDir * i, dir, 0);
        pos.x = obj_Player.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.5, newDir);
        pos.y = obj_Player.y + lengthdir_y(camera_get_view_height(view_camera[0]) / 1.5, newDir);
        obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride);
    }
}

function EventSpawnWall(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var spacing = variable_struct_exists(arg0, "spacing") ? arg0.spacing : 16;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var ignoreWallSpawn = variable_struct_exists(arg0, "ignoreWallSpawn") ? arg0.ignoreWallSpawn : {};
    var offsetX = variable_struct_exists(arg0, "offsetX") ? arg0.offsetX : 0;
    var offsetY = variable_struct_exists(arg0, "offsetY") ? arg0.offsetY : 0;
    var setPosition = variable_struct_exists(arg0, "setPosition") ? arg0.setPosition : false;
    var pos = {};
    var mobId = arg0.id;
    var startX = 0;
    var startY = 0;
    var xSpacing = 0;
    var ySpacing = 0;
    if (setPosition)
    {
        setPosition = lockPosition;
    }
    else
    {
        setPosition = 227;
    }
    startX = ((setPosition.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.8, dir)) - lengthdir_x((amount * spacing) / 2, dir - 90)) + offsetX;
    startY = ((setPosition.y + lengthdir_y(camera_get_view_height(view_camera[0]) / 1.8, dir)) - lengthdir_y((amount * spacing) / 2, dir - 90)) + offsetY;
    xSpacing = lengthdir_x(spacing, dir - 90);
    ySpacing = lengthdir_y(spacing, dir - 90);
    for (var i = 0; i < amount; i++)
    {
        pos.x = startX + (i * xSpacing);
        pos.y = startY + (i * ySpacing);
        if (!obj_MobManager.IsSpawnBlocked(pos) || ignoreWallSpawn)
        {
            obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride);
        }
    }
}

function EventLockPosition(arg0)
{
    lockPosition.x = obj_Player.x;
    lockPosition.y = obj_Player.y;
}

function EventStagePosition(arg0)
{
    var xOffset = variable_struct_exists(arg0, "xOffset") ? arg0.xOffset : 0;
    var yOffset = variable_struct_exists(arg0, "yOffset") ? arg0.yOffset : 0;
    lockPosition.x = obj_Player.x + xOffset;
    lockPosition.y = (room_height / 2) + yOffset;
}

function EventSpawnDropIn(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dropType = variable_struct_exists(arg0, "dropType") ? arg0.dropType : "random";
    var dropDistance = variable_struct_exists(arg0, "dropDistance") ? arg0.dropDistance : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var warnTime = variable_struct_exists(arg0, "warnTime") ? arg0.warnTime : 120;
    var warnRadius = variable_struct_exists(arg0, "warnRadius") ? arg0.warnRadius : 50;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var setPosition = variable_struct_exists(arg0, "setPosition") ? arg0.setPosition : false;
    var offset = variable_struct_exists(arg0, "offset") ? arg0.offset : 0;
    var wallDir = variable_struct_exists(arg0, "wallDir") ? arg0.wallDir : 0;
    var spacing = variable_struct_exists(arg0, "spacing") ? arg0.spacing : 0;
    var startX = 0;
    var startY = 0;
    var xSpacing = 0;
    var ySpacing = 0;
    var pos = {};
    var mobId = arg0.id;
    if (setPosition)
    {
        setPosition = lockPosition;
    }
    else
    {
        setPosition = 227;
    }
    switch (dropType)
    {
        case "surround":
            var circleDir = 360 / amount;
            for (var i = 0; i < amount; i++)
            {
                pos.x = setPosition.x + lengthdir_x(dropDistance, circleDir * i);
                pos.y = setPosition.y + lengthdir_y(dropDistance, circleDir * i);
                obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride, warnTime, warnRadius);
            }
            break;
        case "random":
            if (instance_exists(obj_Player))
            {
                for (var i = 0; i < amount; i++)
                {
                    var xRandom = -dropDistance + irandom(2 * dropDistance);
                    var yRandom = -dropDistance + irandom(2 * dropDistance);
                    pos.x = setPosition.x + xRandom;
                    pos.y = setPosition.y + yRandom;
                    obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride, warnTime, warnRadius);
                }
            }
            break;
        case "wall":
            switch (wallDir)
            {
                case 0:
                    startX = setPosition.x + dropDistance;
                    startY = (setPosition.y - ((amount * spacing) / 2)) + offset;
                    ySpacing = spacing;
                    break;
                case 90:
                    startY = setPosition.y - dropDistance;
                    startX = (setPosition.x - ((amount * spacing) / 2)) + offset;
                    xSpacing = spacing;
                    break;
                case 180:
                    startX = setPosition.x - dropDistance;
                    startY = (setPosition.y - ((amount * spacing) / 2)) + offset;
                    ySpacing = spacing;
                    break;
                case 270:
                    startY = setPosition.y + dropDistance;
                    startX = (setPosition.x - ((amount * spacing) / 2)) + offset;
                    xSpacing = spacing;
                    break;
            }
            for (var i = 0; i < amount; i++)
            {
                pos.x = startX + (i * xSpacing);
                pos.y = startY + (i * ySpacing);
                obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride, warnTime, warnRadius);
            }
            break;
    }
}

function EventSequenceSpawn(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dropType = variable_struct_exists(arg0, "dropType") ? arg0.dropType : "random";
    var dropDistance = variable_struct_exists(arg0, "dropDistance") ? arg0.dropDistance : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var warnTime = variable_struct_exists(arg0, "warnTime") ? arg0.warnTime : 120;
    var warnRadius = variable_struct_exists(arg0, "warnRadius") ? arg0.warnRadius : 50;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var setPosition = variable_struct_exists(arg0, "setPosition") ? arg0.setPosition : false;
    var offset = variable_struct_exists(arg0, "offset") ? arg0.offset : 0;
    var wallDir = variable_struct_exists(arg0, "wallDir") ? arg0.wallDir : 0;
    var spacing = variable_struct_exists(arg0, "spacing") ? arg0.spacing : 0;
    var sequenceTime = variable_struct_exists(arg0, "sequenceTime") ? arg0.sequenceTime : 0;
    var startX = 0;
    var startY = 0;
    var xSpacing = 0;
    var ySpacing = 0;
    var pos = {};
    var mobId = arg0.id;
    if (setPosition)
    {
        setPosition = lockPosition;
    }
    else
    {
        setPosition = 227;
    }
    switch (dropType)
    {
        case "surround":
            var circleDir = 360 / amount;
            sequenceConfig = 
            {
                circleDir: circleDir,
                setPosition: setPosition,
                amount: amount,
                dropDistance: dropDistance,
                mobId: mobId,
                level: level,
                spawnOverride: spawnOverride,
                warnTime: warnTime,
                warnRadius: warnRadius
            };
            sequenceSpawnTime = sequenceTime;
            sequenceSpawn = true;
            sequenceIndex = 0;
            break;
        case "random":
            if (instance_exists(obj_Player))
            {
                for (var i = 0; i < amount; i++)
                {
                    var xRandom = -dropDistance + irandom(2 * dropDistance);
                    var yRandom = -dropDistance + irandom(2 * dropDistance);
                    pos.x = setPosition.x + xRandom;
                    pos.y = setPosition.y + yRandom;
                    obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride, warnTime, warnRadius);
                }
            }
            break;
        case "wall":
            switch (wallDir)
            {
                case 0:
                    startX = setPosition.x + dropDistance;
                    startY = (setPosition.y - ((amount * spacing) / 2)) + offset;
                    ySpacing = spacing;
                    break;
                case 90:
                    startY = setPosition.y - dropDistance;
                    startX = (setPosition.x - ((amount * spacing) / 2)) + offset;
                    xSpacing = spacing;
                    break;
                case 180:
                    startX = setPosition.x - dropDistance;
                    startY = (setPosition.y - ((amount * spacing) / 2)) + offset;
                    ySpacing = spacing;
                    break;
                case 270:
                    startY = setPosition.y + dropDistance;
                    startX = (setPosition.x - ((amount * spacing) / 2)) + offset;
                    xSpacing = spacing;
                    break;
            }
            for (var i = 0; i < amount; i++)
            {
                pos.x = startX + (i * xSpacing);
                pos.y = startY + (i * ySpacing);
                obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride, warnTime, warnRadius);
            }
            break;
    }
}

function EventSpawnDropInGrid(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dropType = variable_struct_exists(arg0, "dropType") ? arg0.dropType : "random";
    var dropDistance = variable_struct_exists(arg0, "dropDistance") ? arg0.dropDistance : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var warnTime = variable_struct_exists(arg0, "warnTime") ? arg0.warnTime : 120;
    var warnRadius = variable_struct_exists(arg0, "warnRadius") ? arg0.warnRadius : 50;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var setPosition = variable_struct_exists(arg0, "setPosition") ? arg0.setPosition : false;
    var offset = variable_struct_exists(arg0, "offset") ? arg0.offset : 0;
    var wallDir = variable_struct_exists(arg0, "wallDir") ? arg0.wallDir : 0;
    var spacing = variable_struct_exists(arg0, "spacing") ? arg0.spacing : 0;
    var startX = 0;
    var startY = 0;
    var xSpacing = 0;
    var ySpacing = 0;
    var pos = {};
    var mobId = arg0.id;
    var alternateMob = arg0.altId;
    if (setPosition)
    {
        setPosition = lockPosition;
    }
    else
    {
        setPosition = 227;
    }
    startX = setPosition.x - (((amount - 1) * spacing) / 2);
    startY = setPosition.y - (((amount - 1) * spacing) / 2);
    xSpacing = spacing;
    ySpacing = spacing;
    var mobInt = 0;
    var randomMob = [6, 7, 8, 11, 12, 13, 16, 17, 18];
    var randomInt = irandom(array_length(randomMob) - 1);
    for (var i = 0; i < amount; i++)
    {
        for (var j = 0; j < amount; j++)
        {
            mobInt = (i * amount) + j;
            pos.x = startX + (j * xSpacing);
            pos.y = startY + (i * ySpacing);
            if (mobInt != randomMob[randomInt])
            {
                obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride, warnTime, warnRadius);
            }
            else
            {
                obj_MobManager.SpawnMob(alternateMob, pos, level, spawnOverride, warnTime, warnRadius);
            }
        }
    }
}

function Stage2_EventSpawnWall(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var spacing = variable_struct_exists(arg0, "spacing") ? arg0.spacing : 16;
    var setPosition = variable_struct_exists(arg0, "setPosition") ? arg0.setPosition : false;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var pos = {};
    var mobId = arg0.id;
    var startX = 0;
    var startY = 0;
    var xSpacing = 0;
    var ySpacing = 0;
    if (setPosition)
    {
        setPosition = lockPosition;
    }
    else
    {
        setPosition = 227;
    }
    switch (dir)
    {
        case 0:
            startX = setPosition.x + (camera_get_view_width(view_camera[0]) / 1.8);
            startY = topBorder;
            ySpacing = spacing;
            break;
        case 90:
            startY = topBorder;
            startX = setPosition.x - ((amount * spacing) / 2);
            xSpacing = spacing;
            break;
        case 180:
            startX = setPosition.x - (camera_get_view_width(view_camera[0]) / 1.8);
            startY = topBorder;
            ySpacing = spacing;
            break;
        case 270:
            startY = topBorder + stageHeight;
            startX = setPosition.x - ((amount * spacing) / 2);
            xSpacing = spacing;
            break;
    }
    for (var i = 0; i < amount; i++)
    {
        pos.x = startX + (i * xSpacing);
        pos.y = startY + (i * ySpacing);
        obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride);
    }
}

function EventSpawnHorde(arg0)
{
    var mobId = arg0.id;
    var groupNumber;
    if (variable_struct_exists(controlGroups, mobId))
    {
        var group = variable_struct_get(controlGroups, mobId);
        groupNumber = array_length(group);
        var newGroup = array_push(group, {});
    }
    else
    {
        groupNumber = 0;
    }
    arg0.overrideConfig = 
    {
        groupNumber: groupNumber
    };
    var horde = EventSpawnClumpedDirection(arg0);
}

function EventSpawnDirectionLocked(arg0)
{
    var level = variable_struct_exists(arg0, "level") ? arg0.level : 1;
    var dir = variable_struct_exists(arg0, "dir") ? arg0.dir : 0;
    var dirMoving = variable_struct_exists(arg0, "dirMoving") ? arg0.dirMoving : 180;
    var spd = variable_struct_exists(arg0, "speed") ? arg0.speed : 1;
    var spawnOverride = variable_struct_exists(arg0, "spawnOverride") ? arg0.spawnOverride : {};
    var mobId = arg0.id;
    var amount = variable_struct_exists(arg0, "amount") ? arg0.amount : 16;
    var monsterSize = 
    {
        width: ds_map_find_value(obj_MobManager.Mobs, mobId).config.width,
        height: ds_map_find_value(obj_MobManager.Mobs, mobId).config.height
    };
    var pos = _FindEdgeSpawnCoordinate(dir, monsterSize);
    var spacing = variable_struct_exists(arg0, "spacing") ? arg0.spacing : 16;
    var offset = variable_struct_exists(arg0, "offset") ? arg0.offset : 0;
    var offsetX = variable_struct_exists(arg0, "offsetX") ? arg0.offsetX : 0;
    var offsetY = variable_struct_exists(arg0, "offsetY") ? arg0.offsetY : 0;
    var setPosition = variable_struct_exists(arg0, "setPosition") ? arg0.setPosition : false;
    var lockX = variable_struct_exists(arg0, "lockX") ? arg0.lockX : false;
    var lockY = variable_struct_exists(arg0, "lockY") ? arg0.lockY : false;
    var ignoreWallSpawn = variable_struct_exists(arg0, "ignoreWallSpawn") ? arg0.ignoreWallSpawn : {};
    var startX = 0;
    var startY = 0;
    var xSpacing = 0;
    var ySpacing = 0;
    var setPositionCoords = 
    {
        x: 0,
        y: 0
    };
    if (setPosition)
    {
        setPositionCoords.x = lockPosition.x;
        setPositionCoords.y = lockPosition.y;
    }
    else
    {
        setPositionCoords.x = obj_Player.x;
        setPositionCoords.y = obj_Player.y;
    }
    if (lockX)
    {
        setPositionCoords.x = lockPosition.x;
    }
    if (lockY)
    {
        setPositionCoords.y = lockPosition.y;
    }
    startX = ((setPositionCoords.x + lengthdir_x(camera_get_view_width(view_camera[0]) / 1.8, dir)) - lengthdir_x(((amount * spacing) / 2) + offset, dir - 90)) + offsetY;
    startY = ((setPositionCoords.y + lengthdir_y(camera_get_view_height(view_camera[0]) / 1.8, dir)) - lengthdir_y(((amount * spacing) / 2) + offset, dir - 90)) + offsetX;
    xSpacing = lengthdir_x(spacing, dir - 90);
    ySpacing = lengthdir_y(spacing, dir - 90);
    for (var i = 0; i < amount; i++)
    {
        pos.x = startX + (i * xSpacing);
        pos.y = startY + (i * ySpacing);
        if (!obj_MobManager.IsSpawnBlocked(pos) || ignoreWallSpawn)
        {
            var mob = obj_MobManager.SpawnMob(mobId, pos, level, spawnOverride);
            if (variable_struct_exists(mob.behaviours, "followPlayer"))
            {
                variable_struct_remove(mob.behaviours, "followPlayer");
            }
            mob.speed = spd;
            mob.SPD = mob.speed;
            mob.baseStats.SPD = mob.speed;
            mob.prebuffStats.SPD = mob.speed;
            mob.direction = dirMoving;
            if (mob.direction < 90 || mob.direction > 270)
            {
                mob.image_xscale = abs(mob.image_xscale);
            }
            if (mob.direction > 90 && mob.direction < 270)
            {
                mob.image_xscale = -abs(mob.image_xscale);
            }
            mob.knockbackImmune = true;
            mob.canFreeze = false;
            mob.tangible = false;
        }
    }
}

function _FindEdgeSpawnCoordinate(arg0, arg1)
{
    var quadrant = floor(arg0 / 90);
    var inverse = quadrant % 2;
    var slope = inverse ? tan((arg0 * pi) / 180) : (1 / tan((arg0 * pi) / 180));
    slope *= -1;
    var edge = _ParseEdge(arg0, arg1);
    if ((arg0 % 90) == 0 || (edge.x != false && edge.y != false))
    {
        return edge;
    }
    if (edge.x == false)
    {
        if (inverse)
        {
            edge.x = obj_Player.x + (((edge.y - obj_Player.y) / slope) + arg1.width);
        }
        else
        {
            edge.x = obj_Player.x + (((edge.y - obj_Player.y) * slope) + arg1.width);
        }
        edge.y += arg1.height;
        return edge;
    }
    if (edge.y == false)
    {
        if (inverse)
        {
            edge.y = obj_Player.y + (((edge.x - obj_Player.x) * slope) + arg1.height);
        }
        else
        {
            edge.y = obj_Player.y + (((edge.x - obj_Player.x) / slope) + arg1.height);
        }
        edge.x += arg1.width;
        return edge;
    }
}

function _ParseEdge(arg0, arg1)
{
    var cameraPos = {};
    cameraPos.x = camera_get_view_x(view_camera[0]);
    cameraPos.y = camera_get_view_y(view_camera[0]);
    var borderPos = {};
    borderPos.x = cameraPos.x + camera_get_view_width(view_camera[0]);
    borderPos.y = cameraPos.y + camera_get_view_height(view_camera[0]);
    if (arg0 > 360)
    {
        arg0 -= 360;
    }
    if (arg0 < 0)
    {
        arg0 += 360;
    }
    if ((arg0 % 90) == 0)
    {
        arg0 = arg0 / 90;
        switch (arg0)
        {
            case 0:
                return 
                {
                    x: borderPos.x,
                    y: obj_Player.y
                };
            case 1:
                arg1.height *= -1;
                return 
                {
                    x: obj_Player.x,
                    y: cameraPos.y
                };
            case 2:
                arg1.width *= -1;
                return 
                {
                    x: cameraPos.x,
                    y: obj_Player.y
                };
            case 3:
                return 
                {
                    x: obj_Player.x,
                    y: borderPos.y
                };
            case 4:
                return 
                {
                    x: borderPos.x,
                    y: obj_Player.y
                };
        }
    }
    if ((arg0 > 330.64 && arg0 <= 360) || (arg0 >= 0 && arg0 < 29.36))
    {
        return 
        {
            x: borderPos.x,
            y: false
        };
    }
    if (arg0 > 29.36 && arg0 < 150.64)
    {
        arg1.height *= -1;
        return 
        {
            x: false,
            y: cameraPos.y
        };
    }
    if (arg0 > 150.64 && arg0 < 209.36)
    {
        arg1.width *= -1;
        return 
        {
            x: cameraPos.x,
            y: false
        };
    }
    if (arg0 > 209.36 && arg0 < 330.64)
    {
        return 
        {
            x: false,
            y: borderPos.y
        };
    }
    if (arg0 == 29.36)
    {
        return 
        {
            x: borderPos.x + arg1.width,
            y: cameraPos.y - arg1.height
        };
    }
    if (arg0 == 150.64)
    {
        return 
        {
            x: cameraPos.x - arg1.width,
            y: cameraPos.y - arg1.height
        };
    }
    if (arg0 == 209.36)
    {
        return 
        {
            x: cameraPos.x - arg1.width,
            y: borderPos.y + arg1.height
        };
    }
    if (arg0 == 330.64)
    {
        return 
        {
            x: borderPos.x + arg1.width,
            y: borderPos.y + arg1.height
        };
    }
}

function FourWayDirectionLocked(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = "1", arg7 = 0)
{
    AddTimeEvent(arg1[0], arg1[1], arg1[2] - 1, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2] - 1, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2] - 1, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2] - 1, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2], "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: arg0,
        level: arg6,
        speed: arg5,
        dir: 0,
        dirMoving: 180,
        amount: arg3,
        spacing: arg4,
        spawnOverride: arg2
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2], "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: arg0,
        level: arg6,
        speed: arg5,
        dir: 180,
        dirMoving: 0,
        amount: arg3,
        spacing: arg4,
        offset: arg7,
        spawnOverride: arg2
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2], "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: arg0,
        level: arg6,
        speed: arg5 * 0.8,
        dir: 90,
        dirMoving: 270,
        amount: arg3,
        spacing: arg4,
        spawnOverride: arg2
    });
    AddTimeEvent(arg1[0], arg1[1], arg1[2], "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: arg0,
        level: arg6,
        speed: arg5 * 0.8,
        dir: 270,
        dirMoving: 90,
        amount: arg3,
        spacing: arg4,
        offset: arg7,
        spawnOverride: arg2
    });
}

function DropInBox(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = "1", arg9 = false)
{
    for (var i = 0; i < 4; i++)
    {
        AddTimeEvent(arg1[0], arg1[1], arg1[2] + i, "EventSpawnDropIn", EventSpawnDropIn, 
        {
            id: arg0,
            level: arg8,
            amount: arg3,
            dropType: "wall",
            wallDir: i * 90,
            dropDistance: arg5,
            warnRadius: arg6,
            spacing: arg4,
            warnTime: arg7,
            spawnOverride: arg2,
            setPosition: arg9
        });
    }
}

function DropInBoxInstant(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = "1", arg9 = false)
{
    for (var i = 0; i < 4; i++)
    {
        AddTimeEvent(arg1[0], arg1[1], arg1[2], "EventSpawnDropIn" + string(i), EventSpawnDropIn, 
        {
            id: arg0,
            level: arg8,
            amount: arg3,
            dropType: "wall",
            wallDir: i * 90,
            dropDistance: arg5,
            warnRadius: arg6,
            spacing: arg4,
            warnTime: arg7,
            spawnOverride: arg2,
            setPosition: arg9
        });
    }
}

function CallAlert(arg0, arg1)
{
    switch (arg0)
    {
        case "up":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 90;
            });
            break;
        case "down":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 270;
            });
            break;
        case "left":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 180;
            });
            break;
        case "right":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 0;
            });
            break;
        case "vertical":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 90;
            });
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertB", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 270;
            });
            break;
        case "horizontal":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 0;
            });
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertB", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 180;
            });
            break;
        case "all":
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertA", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 0;
            });
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertB", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 90;
            });
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertC", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 180;
            });
            AddTimeEvent(arg1[0], arg1[1], arg1[2], "AlertD", function()
            {
                var alert = instance_create_depth(x, y, depth, obj_caution);
                alert.dir = 270;
            });
            break;
    }
}
