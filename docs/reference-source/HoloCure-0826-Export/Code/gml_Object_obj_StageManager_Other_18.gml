global.topBorder = -1;
global.bottomBorder = -1;
global.leftBorder = -1;
global.rightBorder = -1;
global.wrappingStage = false;
AddTimeEvent(0, 0, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 90;
    spawnAmount = 4;
    AddMobChoice("Moonafic", 1, 1);
});
var randDir = irandom(3) * 90;
AddTimeEvent(0, 0, 10, "EventSpawnClumpedDirection", EventSpawnClumpedDirection, 
{
    id: "Moonafic",
    level: "1",
    dir: string(randDir),
    amount: 15,
    size: 40,
    spawnOverride: 
    {
        expvalue: 3
    }
});
AddTimeEvent(0, 0, 20, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "MoonaficDasher",
    level: "1",
    dir: "random",
    amount: 3
});
AddTimeEvent(0, 0, 45, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "Moonafic",
    level: "1",
    amount: 40,
    dir: "evenSurround",
    spawnOverride: 
    {
        expvalue: 2
    }
});
AddTimeEvent(0, 1, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 80;
    spawnAmount = 4;
    AddMobChoice("Risuner", 1, 1);
});
CallAlert("right", [0, 1, 14]);
AddTimeEvent(0, 1, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("left", [0, 1, 17]);
AddTimeEvent(0, 1, 18, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 1, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 1, 30, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Risuner",
    level: "1",
    speed: 3,
    dir: 0,
    dirMoving: 180,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        ignoreWalls: true,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true,
        canFreeze: false
    }
});
AddTimeEvent(0, 1, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 1, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 80;
    spawnAmount = 6;
    AddMobChoice("Ioforia", 1, 1);
});
AddTimeEvent(0, 1, 30, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Moonafic",
    level: "1",
    speed: 3,
    dir: 180,
    dirMoving: 0,
    amount: 15,
    spacing: 70,
    offset: 45,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 500,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        canFreeze: false
    }
});
AddTimeEvent(0, 1, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "RisunerDasher",
    level: "1",
    dir: 90,
    amount: 5,
    spacing: 30,
    spawnOverride: 
    {
        HP: 800,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 1, 47, "EventSpawnWall1", EventSpawnWall, 
{
    id: "RisunerDasher",
    level: "1",
    dir: 270,
    amount: 5,
    spacing: 30,
    spawnOverride: 
    {
        HP: 800,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 2, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "MoonabitoMiniBoss",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 2, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 90;
    spawnAmount = 8;
    RemoveMobChoice("Moonafic");
    AddMobChoice("Moonafic", 1, 2);
});
AddTimeEvent(0, 2, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "RisunerDasher",
    level: "1",
    dir: 270,
    amount: 5,
    spacing: 30,
    spawnOverride: 
    {
        HP: 500,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 2, 45, "EventSpawnWall2", EventSpawnWall, 
{
    id: "RisunerDasher",
    level: "1",
    dir: 0,
    amount: 5,
    spacing: 30,
    spawnOverride: 
    {
        HP: 500,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 3, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 60,
    warnTime: 150
});
if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
{
    AddTimeEvent(0, 3, 15, "SilverYagoo", EventSpawnDirection, 
    {
        id: "SilverYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 30
    });
}
AddTimeEvent(0, 3, 15, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "MoonaficWall",
    dir: "evenSurround",
    amount: 120,
    spawnOverride: 
    {
        expvalue: 1
    }
});
AddTimeEvent(0, 3, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Ioforia",
    level: "2",
    amount: 5,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 3, 40, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 4, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 90;
    spawnAmount = 5;
    RemoveMobChoice("Risuner");
    AddMobChoice("Risuner", 1, 2);
});
AddTimeEvent(0, 4, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "RiscotMiniBoss",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 4, 1, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 4, 20, "EventSpawnWall1", EventSpawnWall, 
{
    id: "RisunerDasher",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        HP: 1000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 4, 20, "EventSpawnWall2", EventSpawnWall, 
{
    id: "RisunerDasher",
    level: "1",
    dir: 90,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        HP: 1000,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 5, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 90;
    spawnAmount = 8;
    RemoveMobChoice("Ioforia");
    AddMobChoice("Ioforia", 1, 2);
});
AddTimeEvent(0, 5, 0, "GoldenYagoo", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "evenSurround",
    chance: 20
});
AddTimeEvent(0, 5, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Moonafic",
    level: "2",
    amount: 20,
    dropType: "surround",
    dropDistance: 160,
    warnRadius: 50,
    warnTime: 150
});
AddTimeEvent(0, 5, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 100;
    spawnAmount = 10;
    RemoveMobChoice("Moonafic");
});
AddTimeEvent(0, 6, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "IoforiaMiniBoss",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 6, 9, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 6, 10 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Ioforia",
        level: "2",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 15,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 1000,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 6, 14, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 6, 15 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Ioforia",
        level: "2",
        speed: 2,
        dir: 90,
        dirMoving: 270,
        amount: 15,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 1000,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 6, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 70;
    spawnAmount = 8;
    RemoveMobChoice("Risuner");
    RemoveMobChoice("Ioforia");
    AddMobChoice("Zomerade", 1, 1);
});
AddTimeEvent(0, 6, 30, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "ZomeradeHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "random"),
    amount: 40
});
AddTimeEvent(0, 6, 35, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "ZomeradeHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "random"),
    amount: 40
});
AddTimeEvent(0, 6, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 6, 45, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "ZomeradeHorde",
    level: "3",
    dir: 0,
    amount: 200
});
AddTimeEvent(0, 7, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 80;
    spawnAmount = 7;
    AddMobChoice("Merakyat", 1, 1);
});
AddTimeEvent(0, 7, 2, "GoldenYagoo", EventSpawnDirection, 
{
    id: "MerakyatDasher",
    level: "1",
    amount: 1,
    dir: "evenSurround"
});
AddTimeEvent(0, 7, 4, "GoldenYagoo", EventSpawnDirection, 
{
    id: "MerakyatDasher",
    level: "1",
    amount: 2,
    dir: "evenSurround"
});
AddTimeEvent(0, 7, 6, "GoldenYagoo", EventSpawnDirection, 
{
    id: "MerakyatDasher",
    level: "1",
    amount: 3,
    dir: "evenSurround"
});
AddTimeEvent(0, 7, 10, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SPDOtakuID",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 7, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 0,
    amount: 7,
    spacing: 30,
    spawnOverride: 
    {
        HP: 2000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 7, 18, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 0,
    amount: 7,
    spacing: 30,
    offsetY: 140,
    spawnOverride: 
    {
        HP: 2000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 7, 18, "EventSpawnWall2", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 180,
    amount: 7,
    spacing: 30,
    offsetY: -140,
    spawnOverride: 
    {
        HP: 2000,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 7, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "2",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 7, 45, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Merakyat",
    level: "1",
    amount: 10,
    dropType: "wall",
    wallDir: 0,
    spacing: 120,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 7, 45, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Merakyat",
    level: "1",
    amount: 10,
    dropType: "wall",
    wallDir: 90,
    spacing: 120,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 8, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "MerakyatMiniBoss",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 8, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 70;
    spawnAmount = 6;
    AddMobChoice("Melfriend", 1, 1);
    RemoveMobChoice("Zomerade");
});
CallAlert("all", [0, 8, 14]);
AddTimeEvent(0, 8, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 8, 15, "EventSpawnWall2", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 90,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 8, 15, "EventSpawnWall3", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 8, 15, "EventSpawnWall4", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 270,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 8, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 8, 30 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Melfriend",
        level: "1",
        speed: 3,
        dir: 0,
        dirMoving: 180,
        amount: 15,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            ignoreWalls: true,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 8, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 8, 30 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Melfriend",
        level: "1",
        speed: 3,
        dir: 270,
        dirMoving: 90,
        amount: 15,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            ignoreWalls: true,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 9, 0, "EventSpawnDropInA", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "1",
    amount: 1,
    dropType: "surround",
    dropDistance: 50,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 9, 0, "EventSpawnDropInB", EventSpawnDropIn, 
{
    id: "ATKOtakuID",
    level: "1",
    amount: 1,
    dropType: "surround",
    dropDistance: 50,
    warnRadius: 60,
    warnTime: 150
});
if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
{
    AddTimeEvent(0, 9, 0, "SilverYagoo", EventSpawnDirection, 
    {
        id: "SilverYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 30
    });
}
AddTimeEvent(0, 9, 0, "EventSpawnDropInC", EventSpawnDropIn, 
{
    id: "SPDOtakuID",
    level: "1",
    amount: 1,
    dropType: "surround",
    dropDistance: 50,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 9, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 8;
    currentSpawnPattern = "horizontalSurround";
    RemoveMobChoice("Melfriend");
    RemoveMobChoice("Merakyat");
    AddMobChoice("Merakyat", 1, 1, 
    {
        dir: 0,
        pattern: "directionalSurround"
    });
    AddMobChoice("Melfriend", 1, 1, 
    {
        dir: 180,
        pattern: "directionalSurround"
    });
});
AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 110;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("Melfriend");
    RemoveMobChoice("Merakyat");
    AddMobChoice("Zomerade", 1, 2);
});
AddTimeEvent(0, 10, 0, "EventSpawnDropInC", EventSpawnDropIn, 
{
    id: "Udin",
    level: "1",
    amount: 1,
    dropType: "surround",
    warnRadius: 50,
    warnTime: 150
});
CallAlert("horizontal", [0, 10, 14]);
AddTimeEvent(0, 10, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 10, 15, "EventSpawnWall2", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("vertical", [0, 10, 29]);
AddTimeEvent(0, 10, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 90,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 10, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "1",
    dir: 270,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("all", [0, 10, 44]);
for (var i = 0; i < 6; i++)
{
    AddTimeEvent(0, 10, 45, "EventSpawnHorde" + string(i), EventSpawnHorde, 
    {
        id: "ZomeradeHorde",
        level: "1",
        dir: ParseSpawnDirection(i * 60, "evenSurround"),
        amount: 5
    });
}
AddTimeEvent(0, 11, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 9;
    currentSpawnPattern = "evenSurround";
    AddMobChoice("Merakyat", 1, 2);
});
AddTimeEvent(0, 11, 9, "SetPosition", EventLockPosition);
CallAlert("right", [0, 11, 9]);
CallAlert("left", [0, 11, 10]);
AddTimeEvent(0, 11, 10, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 0,
    amount: 10,
    setPosition: true,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        ATK: 18,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 11, 11, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 180,
    amount: 10,
    setPosition: true,
    offsetY: 35,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        ATK: 18,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 11, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SPDOtakuID",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 60,
    warnTime: 150,
    spawnOverride: 
    {
        HP: 2000
    }
});
AddTimeEvent(0, 11, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "1",
    dir: 90,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        HP: 4000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 11, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "1",
    dir: 270,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        HP: 4000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 12, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MelfriendMiniBoss",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 150
});
AddTimeEvent(0, 12, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
    AddMobChoice("Melfriend", 1, 2);
    RemoveMobChoice("Zomerade");
});
AddTimeEvent(0, 12, 5, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "2",
    dir: "random",
    amount: 2
});
AddTimeEvent(0, 12, 29, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 0,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        direction: 180,
        HP: 3000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 12, 29, "EventSpawnWall2", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 270,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 12, 30, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "MerakyatDasher",
    dir: "evenSurround",
    amount: 10,
    spawnOverride: 
    {
        expvalue: 10
    }
});
CallAlert("horizontal", [0, 12, 44]);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 12, 45, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "KobokerWave",
        level: "2",
        dir: 45,
        amount: 10,
        spacing: 70,
        spawnOverride: 
        {
            direction: 225,
            lockFacing: false,
            tangible: false
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "KobokerWave",
        level: "2",
        dir: 135,
        amount: 10,
        spacing: 70,
        spawnOverride: 
        {
            direction: 315,
            lockFacing: false,
            tangible: false
        }
    });
}
CallAlert("up", [0, 12, 59]);
CallAlert("right", [0, 12, 59]);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 13, 0, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Melfriend",
        level: "2",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 15,
        spacing: 70,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            ignoreWalls: true,
            HP: 3000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 13, 0, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Melfriend",
        level: "2",
        speed: 2,
        dir: 90,
        dirMoving: 270,
        amount: 15,
        spacing: 70,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            ignoreWalls: true,
            HP: 3000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 13, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "3",
    amount: 1,
    dropType: "random",
    warnRadius: 60,
    warnTime: 130
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 13, 45 + i, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "ZomeradeHorde",
        level: "4",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
}
AddTimeEvent(0, 14, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
    AddMobChoice("Koboker", 1, 1);
    RemoveMobChoice("Merakyat");
    RemoveMobChoice("Melfriend");
});
AddTimeEvent(0, 14, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Cilus",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 14, 10, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "2",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        HP: 6000
    }
});
AddTimeEvent(0, 14, 40, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "Koboker",
    level: "2",
    dir: "evenSurround",
    amount: 20,
    spawnOverride: 
    {
        HP: 8000,
        ATK: 18,
        knockbackImmune: true,
        SPD: 0,
        expvalue: 4
    }
});
AddTimeEvent(0, 15, 0, "GoldenYagoo", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "evenSurround",
    chance: 20
});
if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
{
    AddTimeEvent(0, 17, 0, "SilverYagoo", EventSpawnDirection, 
    {
        id: "SilverYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 30
    });
}
AddTimeEvent(0, 15, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 0,
    amount: 10,
    spacing: 30,
    offsetY: 160,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 15,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 15, 16, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 90,
    amount: 10,
    spacing: 30,
    offsetX: 160,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 15,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 15, 17, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 180,
    amount: 10,
    spacing: 30,
    offsetY: -160,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 15,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 15, 18, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "2",
    dir: 270,
    amount: 10,
    spacing: 30,
    offsetX: -160,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 15,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 15, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 70;
    spawnAmount = 8;
    currentSpawnPattern = "evenSurround";
    AddMobChoice("Zecretary", 1, 3);
    RemoveMobChoice("Koboker");
});
AddTimeEvent(0, 15, 40, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("Zecretary");
    AddMobChoice("Zecretary", 2, 1);
});
AddTimeEvent(0, 16, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Bazo",
    level: "1",
    dir: "random",
    amount: 1
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 16, 10 + i, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "MerakyatDasher",
        level: "1",
        amount: 2,
        dropType: "random",
        warnRadius: 60,
        warnTime: 150,
        spawnOverride: 
        {
            image_xscale: 1.25,
            image_yscale: 1.25,
            ATK: 20,
            HP: 5000
        }
    });
}
AddTimeEvent(0, 16, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 8;
    currentSpawnPattern = "evenSurround";
    AddMobChoice("Pemaloe", 3, 1);
});
AddTimeEvent(0, 16, 39, "SetPosition", EventLockPosition);
AddTimeEvent(0, 16, 40, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "3",
    dir: 0,
    amount: 15,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        HP: 5000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 16, 42, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "3",
    dir: 180,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    setPosition: true,
    spawnOverride: 
    {
        HP: 5000,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 16, 41, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "3",
    dir: 90,
    amount: 15,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        HP: 5000,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 16, 43, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "3",
    dir: 270,
    amount: 15,
    spacing: 70,
    offsetX: 35,
    setPosition: true,
    spawnOverride: 
    {
        HP: 5000,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 17, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
    AddMobChoice("Koboker", 1, 2);
});
CallAlert("left", [0, 17, 4]);
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 17, 5 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Zecretary",
        level: "2",
        speed: 1,
        dir: 180,
        dirMoving: 0,
        amount: 35,
        spacing: 20,
        spawnOverride: 
        {
            lifeTime: 600,
            expvalue: 2,
            ignoreWalls: true,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
CallAlert("right", [0, 17, 14]);
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 17, 15 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Zecretary",
        level: "2",
        speed: 1,
        dir: 0,
        dirMoving: 180,
        amount: 35,
        spacing: 20,
        spawnOverride: 
        {
            lifeTime: 600,
            expvalue: 2,
            ignoreWalls: true,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 17, 30, "EventSpawnHordeA", EventSpawnHorde, 
{
    id: "PemaloeHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "random"),
    amount: 15
});
AddTimeEvent(0, 17, 31, "EventSpawnHordeB", EventSpawnHorde, 
{
    id: "PemaloeHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "random"),
    amount: 15
});
AddTimeEvent(0, 17, 32, "EventSpawnHordeC", EventSpawnHorde, 
{
    id: "PemaloeHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "random"),
    amount: 15
});
AddTimeEvent(0, 17, 45, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Zecretary",
    level: "2",
    amount: 40,
    spacing: 20,
    dropType: "wall",
    dropDistance: 150,
    wallDir: 0,
    warnRadius: 60,
    warnTime: 30,
    spawnOverride: 
    {
        expvalue: 2,
        SPD: 0.1,
        knockbackImmune: true,
        lifeTime: 600,
        tangible: false
    }
});
AddTimeEvent(0, 17, 45, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "Zecretary",
    level: "2",
    amount: 40,
    spacing: 20,
    dropType: "wall",
    dropDistance: 150,
    wallDir: 180,
    warnRadius: 60,
    warnTime: 30,
    spawnOverride: 
    {
        expvalue: 2,
        SPD: 0.1,
        knockbackImmune: true,
        lifeTime: 600,
        tangible: false
    }
});
AddTimeEvent(0, 18, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 9;
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("Pemaloe");
    AddMobChoice("Zecretary", 3, 2);
    AddMobChoice("Pemaloe", 3, 2);
});
AddTimeEvent(0, 18, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "PemaloeMiniBoss",
    level: "1",
    dir: "random",
    amount: 1
});
CallAlert("up", [0, 18, 14]);
AddTimeEvent(0, 18, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "2",
    dir: 90,
    amount: 12,
    spacing: 70,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("left", [0, 18, 15]);
AddTimeEvent(0, 18, 16, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "2",
    dir: 180,
    amount: 12,
    spacing: 70,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("down", [0, 18, 16]);
AddTimeEvent(0, 18, 17, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "2",
    dir: 270,
    amount: 12,
    spacing: 70,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("right", [0, 18, 17]);
AddTimeEvent(0, 18, 18, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KobokerWave",
    level: "2",
    dir: 0,
    amount: 12,
    spacing: 70,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 18, 46, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "1",
    dir: 0,
    amount: 5,
    spacing: 80,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        tangible: false,
        HP: 2000,
        ATK: 15,
        SPD: 25,
        expvalue: 4
    }
});
AddTimeEvent(0, 18, 47, "EventSpawnWall2", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "1",
    dir: 90,
    amount: 5,
    spacing: 80,
    spawnOverride: 
    {
        lockFacing: false,
        tangible: false,
        HP: 2000,
        ATK: 15,
        SPD: 25,
        expvalue: 4
    }
});
AddTimeEvent(0, 18, 48, "EventSpawnWall3", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "1",
    dir: 180,
    amount: 5,
    spacing: 80,
    spawnOverride: 
    {
        lockFacing: false,
        tangible: false,
        HP: 2000,
        ATK: 15,
        SPD: 25,
        expvalue: 4
    }
});
AddTimeEvent(0, 18, 49, "EventSpawnWall4", EventSpawnWall, 
{
    id: "MerakyatDasher",
    level: "1",
    dir: 270,
    amount: 5,
    spacing: 80,
    spawnOverride: 
    {
        lockFacing: false,
        tangible: false,
        HP: 2000,
        ATK: 15,
        SPD: 25,
        expvalue: 4
    }
});
AddTimeEvent(0, 19, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 400;
    spawnRate = 75;
    spawnAmount = 10;
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("Koboker");
    AddMobChoice("Zomerade", 2, 3);
    AddMobChoice("Merakyat", 2, 3);
    AddMobChoice("Melfriend", 2, 3);
});
AddTimeEvent(0, 19, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MerakyatDasher",
    level: "1",
    amount: 6,
    dropDistance: 150,
    dropType: "surround",
    warnRadius: 60,
    warnTime: 30,
    spawnOverride: 
    {
        HP: 3000
    }
});
AddTimeEvent(0, 19, 20, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SPDOtakuID",
    level: "2",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        HP: 5000
    }
});
AddTimeEvent(0, 19, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "2",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        HP: 6000
    }
});
CallAlert("horizontal", [0, 19, 44]);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 19, 45 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Pemaloe",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 15,
        spacing: 70,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 5,
            HP: 10000,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 19, 45 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Pemaloe",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 15,
        spacing: 70,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 5,
            HP: 10000,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 20, 0, "NewMob", function()
{
    RemoveMobChoice("Zomerade");
    RemoveMobChoice("Merakyat");
    RemoveMobChoice("Melfriend");
    RemoveMobChoice("Koboker");
    RemoveMobChoice("Zecretary");
    RemoveMobChoice("Pemaloe");
    AddMobChoice("Moonafic", 2, 3);
    AddMobChoice("Ioforia", 2, 3);
    AddMobChoice("Risuner", 2, 3);
    spawnRate = 120;
    spawnAmount = 5;
    with (obj_Enemy)
    {
        if (!isBoss && isEnemy)
        {
            Die(true);
        }
    }
});
AddTimeEvent(0, 20, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Moontato",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 70,
    warnTime: 180
});
AddTimeEvent(0, 20, 3, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "Risusaurus",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 3, "EventSpawnDirectionB", EventSpawnDirection, 
{
    id: "IoUFO",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 3, "EventSpawnDirectionC", EventSpawnDirection, 
{
    id: "Area15",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 21, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 5;
});
AddTimeEvent(0, 22, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 5;
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("Moonafic");
    RemoveMobChoice("Risuner");
    RemoveMobChoice("Ioforia");
    AddMobChoice("Moonafic", 3, 4);
    AddMobChoice("Risuner", 3, 4);
    AddMobChoice("RisunerDasher", 1, 3);
    AddMobChoice("Ioforia", 3, 4);
    AddMobChoice("Zomerade", 3, 4);
    AddMobChoice("Merakyat", 3, 4);
    AddMobChoice("Melfriend", 3, 3);
    AddMobChoice("Koboker", 2, 3);
    AddMobChoice("Zecretary", 3, 4);
    AddMobChoice("Pemaloe", 3, 3);
});
AddTimeEvent(0, 24, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 25, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 7;
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 26, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 8;
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 27, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 55;
    spawnAmount = 8;
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 28, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 50;
    spawnAmount = 9;
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 29, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 45;
    spawnAmount = 9;
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 30, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 6;
    with (obj_Enemy)
    {
        if (!isBoss && isEnemy)
        {
            Die(true);
        }
    }
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("Moonafic");
    RemoveMobChoice("Risuner");
    RemoveMobChoice("RisunerDasher");
    RemoveMobChoice("Ioforia");
    RemoveMobChoice("Zomerade");
    RemoveMobChoice("Melfriend");
    RemoveMobChoice("Merakyat");
    RemoveMobChoice("Koboker");
    RemoveMobChoice("Zecretary");
    RemoveMobChoice("Pemaloe");
    AddMobChoice("Yagoos", 1, 3);
});
