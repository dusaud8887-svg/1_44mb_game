global.topBorder = 715;
global.bottomBorder = 1694;
global.leftBorder = 731;
global.rightBorder = 2266;
global.wrappingStage = true;
AddTimeEvent(0, 0, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 90;
    spawnAmount = 4;
    AddMobChoice("Matsurisu", 1, 1);
});
AddTimeEvent(0, 0, 5, "EventSpawnClumpedDirectionRight", EventSpawnClumpedDirection, 
{
    id: "Matsurisu",
    level: "1",
    dir: "0",
    amount: 8,
    size: 40
});
AddTimeEvent(0, 0, 5, "EventSpawnClumpedDirectionLeft", EventSpawnClumpedDirection, 
{
    id: "Matsurisu",
    level: "1",
    dir: "180",
    amount: 8,
    size: 40
});
AddTimeEvent(0, 0, 30, "NewMob", function()
{
    AddMobChoice("Haaton", 1, 1);
    spawnRate = 90;
});
AddTimeEvent(0, 0, 50, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "HaatonWall",
    dir: "evenSurround",
    amount: 60
});
AddTimeEvent(0, 1, 5, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "1",
    dir: ParseSpawnDirection(0 + (irandom(1) * 180), "horizontalSurround"),
    amount: 30
});
AddTimeEvent(0, 1, 8, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "1",
    dir: ParseSpawnDirection(0 + (irandom(1) * 180), "horizontalSurround"),
    amount: 30
});
AddTimeEvent(0, 1, 11, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "1",
    dir: ParseSpawnDirection(90 + (irandom(1) * 180), "verticalSurround"),
    amount: 30
});
AddTimeEvent(0, 1, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Oruyanke",
    level: "1",
    dir: "evenSurround",
    amount: 5
});
AddTimeEvent(0, 1, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 1, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 1, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "HaatonWall",
    level: "1",
    speed: 2.75,
    dir: 180,
    dirMoving: 0,
    amount: 20,
    spacing: 90,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 1, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "HaatonWall",
    level: "1",
    speed: 2.75,
    dir: 0,
    dirMoving: 180,
    amount: 20,
    spacing: 90,
    offset: 45,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 1, 49, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 1, 50, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "HaatonWall",
    level: "1",
    speed: 2.75,
    dir: 90,
    dirMoving: 270,
    amount: 20,
    spacing: 90,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 1, 49, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
AddTimeEvent(0, 1, 50, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "HaatonWall",
    level: "1",
    speed: 2.75,
    dir: 270,
    dirMoving: 90,
    amount: 20,
    spacing: 90,
    offset: 45,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 2, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuMiniBoss",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 2, 30, "NewMob", function()
{
    RemoveMobChoice("Matsurisu");
    AddMobChoice("Kapumin", 1, 1);
    spawnRate = 80;
});
AddTimeEvent(0, 2, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 2, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 2, 44, "AlertC", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 2, 44, "AlertD", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
for (var i = 0; i < 8; i++)
{
    AddTimeEvent(0, 2, 45, "EventSpawnHorde" + string(i), EventSpawnHorde, 
    {
        id: "KapuminHorde",
        level: "1",
        dir: ParseSpawnDirection(i * 45, "evenSurround"),
        amount: 8
    });
}
if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
{
    AddTimeEvent(0, 3, 30, "SilverYagoo", EventSpawnDirection, 
    {
        id: "SilverYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 30
    });
}
AddTimeEvent(0, 3, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 3, 30, "NewMob", function()
{
    RemoveMobChoice("Haaton");
    AddMobChoice("Rosetai", 1, 1);
    spawnRate = 80;
});
AddTimeEvent(0, 3, 30, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 3,
    dropType: "random",
    dropDistance: 60,
    warnRadius: 30,
    warnTime: 180
});
AddTimeEvent(0, 3, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 3, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 3, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Oruyanke",
    level: "1",
    speed: 0.4,
    dir: 0,
    dirMoving: 180,
    amount: 50,
    spacing: 30,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        lifeTime: 900,
        expvalue: 6,
        HP: 200,
        ATK: 3,
        SPD: 0.4,
        knockbackImmune: true,
        ignoreWalls: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 40,
                    radius: 60
                }
            }
        }
    }
});
AddTimeEvent(0, 3, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Oruyanke",
    level: "1",
    speed: 0.4,
    dir: 180,
    dirMoving: 0,
    amount: 50,
    spacing: 30,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        lifeTime: 900,
        expvalue: 6,
        HP: 200,
        ATK: 3,
        SPD: 0.4,
        knockbackImmune: true,
        ignoreWalls: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 40,
                    radius: 60
                }
            }
        }
    }
});
AddTimeEvent(0, 4, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HaatonMiniBoss",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 25,
    warnTime: 180
});
AddTimeEvent(0, 4, 15, "EventSpawnDropInA", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 5,
    dropType: "wall",
    wallDir: 0,
    dropDistance: 150,
    warnRadius: 30,
    spacing: 40,
    warnTime: 60
});
AddTimeEvent(0, 4, 15, "EventSpawnDropInB", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 5,
    dropType: "wall",
    wallDir: 180,
    dropDistance: 150,
    warnRadius: 30,
    spacing: 40,
    warnTime: 60
});
AddTimeEvent(0, 4, 18, "EventSpawnDropInA", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 5,
    dropType: "wall",
    dropDistance: 150,
    wallDir: 90,
    warnRadius: 30,
    spacing: 40,
    warnTime: 60
});
AddTimeEvent(0, 4, 18, "EventSpawnDropInB", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 5,
    dropType: "wall",
    dropDistance: 150,
    wallDir: 270,
    warnRadius: 30,
    spacing: 40,
    warnTime: 60
});
AddTimeEvent(0, 4, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Oruyanke",
    level: "1",
    dir: "evenSurround",
    amount: 9
});
AddTimeEvent(0, 4, 45, "NewMob", function()
{
    RemoveMobChoice("Kapumin");
    RemoveMobChoice("Rosetai");
    AddMobChoice("Matsurisu", 1, 2);
    AddMobChoice("Haaton", 1, 2);
    spawnRate = 80;
});
AddTimeEvent(0, 5, 0, "GoldenYagoo", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "evenSurround",
    chance: 20
});
for (var i = 0; i < 8; i++)
{
    AddTimeEvent(0, 5, 10 + i, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KapuminHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(359), "evenSurround"),
        amount: 30
    });
}
FourWayDirectionLocked("Rosetai", [0, 5, 20], 
{
    lifeTime: 660,
    expvalue: 5,
    HP: 1000,
    lockFacing: false,
    knockbackImmune: true,
    ignoreWalls: true
}, 20, 90, 3, "1", 40);
AddTimeEvent(0, 6, 0, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "ObakeMiniBoss",
    level: "1",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 6, 0, "EventSpawnDirection2", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "1",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 6, 30, "NewMob", function()
{
    RemoveMobChoice("Matsurisu");
    RemoveMobChoice("Haaton");
    RemoveMobChoice("Kapumin");
    AddMobChoice("Kapumin", 1, 2);
    spawnRate = 20;
    spawnAmount = 9;
});
AddTimeEvent(0, 6, 50, "NewMob", function()
{
    AddMobChoice("Matsurisu", 1, 2);
    AddMobChoice("Haaton", 1, 2);
    spawnRate = 80;
    spawnAmount = 5;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 6, 45 + i, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "Haaton",
        level: "2",
        amount: 1,
        dropType: "random",
        warnRadius: 75,
        warnTime: 150
    });
}
AddTimeEvent(0, 7, 0, "NewMob", function()
{
    AddMobChoice("Rosetai", 2, 2);
    spawnRate = 90;
    spawnAmount = 6;
    enemyLimit = 500;
});
AddTimeEvent(0, 7, 9, "SetPosition", EventLockPosition);
DropInBox("Rosetai", [0, 7, 10], 
{
    lifeTime: 1200,
    expvalue: 8,
    SPD: 0.05,
    HP: 1500,
    lockFacing: false,
    knockbackImmune: true,
    tangible: false
}, 20, 40, 250, 30, 60, "2", true);
AddTimeEvent(0, 7, 15, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropDistance: 30,
    dropType: "random",
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 7, 16, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 2,
    dropType: "random",
    dropDistance: 40,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 7, 17, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 3,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 7, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 7, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Kapumin",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 80,
    spawnOverride: 
    {
        direction: 180,
        HP: 150,
        ATK: 7,
        SPD: 2,
        expvalue: 6,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            waveMovement: 
            {
                config: 
                {
                    travelWidth: 40,
                    waveSpeed: 15
                }
            }
        }
    }
});
AddTimeEvent(0, 7, 31, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 7, 32, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Kapumin",
    level: "1",
    dir: 180,
    amount: 15,
    spacing: 80,
    spawnOverride: 
    {
        direction: 0,
        HP: 150,
        ATK: 7,
        SPD: 2,
        expvalue: 6,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            waveMovement: 
            {
                config: 
                {
                    travelWidth: 40,
                    waveSpeed: 15
                }
            }
        }
    }
});
AddTimeEvent(0, 7, 33, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 7, 33, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
AddTimeEvent(0, 7, 34, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Kapumin",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 80,
    spawnOverride: 
    {
        direction: 270,
        HP: 150,
        ATK: 7,
        SPD: 2,
        expvalue: 6,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            waveMovement: 
            {
                config: 
                {
                    travelWidth: 40,
                    waveSpeed: 15
                }
            }
        }
    }
});
AddTimeEvent(0, 7, 34, "EventSpawnWall2", EventSpawnWall, 
{
    id: "Kapumin",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 80,
    spawnOverride: 
    {
        direction: 90,
        HP: 150,
        ATK: 7,
        SPD: 2,
        expvalue: 6,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            waveMovement: 
            {
                config: 
                {
                    travelWidth: 40,
                    waveSpeed: 15
                }
            }
        }
    }
});
AddTimeEvent(0, 7, 45, "NewMob", function()
{
    spawnRate = 80;
    spawnAmount = 5;
});
AddTimeEvent(0, 7, 45, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "1",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 8, 0, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "RosetaiMiniBoss",
    level: "1",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 8, 0, "NewMob", function()
{
    spawnRate = 100;
    spawnAmount = 4;
});
AddTimeEvent(0, 8, 15, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "Rosetai",
    level: "3",
    dir: "evenSurround",
    amount: 70
});
AddTimeEvent(0, 8, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 200,
    warnRadius: 30,
    warnTime: 60
});
AddTimeEvent(0, 8, 22, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 200,
    warnRadius: 30,
    warnTime: 60
});
AddTimeEvent(0, 8, 24, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 200,
    warnRadius: 30,
    warnTime: 60
});
AddTimeEvent(0, 8, 26, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 200,
    warnRadius: 30,
    warnTime: 60
});
AddTimeEvent(0, 8, 28, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuDasher",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 200,
    warnRadius: 30,
    warnTime: 60
});
AddTimeEvent(0, 8, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 8, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 8, 45 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Haaton",
        level: "3",
        speed: 1.5,
        dir: 0,
        dirMoving: 180,
        amount: 20,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2500,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 8, 45 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Haaton",
        level: "3",
        speed: 1.2,
        dir: 90,
        dirMoving: 270,
        amount: 20,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2500,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
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
AddTimeEvent(0, 9, 0, "NewMob", function()
{
    AddMobChoice("Kapumin", 2, 3);
    AddMobChoice("Matsurisu", 2, 3);
    AddMobChoice("Haaton", 2, 3);
    spawnRate = 80;
    spawnAmount = 6;
});
AddTimeEvent(0, 10, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Shubangelion",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 10, 0, "NewMob", function()
{
    RemoveMobChoice("Kapumin");
    RemoveMobChoice("Matsurisu");
    RemoveMobChoice("Rosetai");
    RemoveMobChoice("Haaton");
    AddMobChoice("Subatomo", 1, 1);
    spawnRate = 90;
    spawnAmount = 5;
});
AddTimeEvent(0, 10, 15, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "SubatomoHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 20
});
AddTimeEvent(0, 10, 17, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "SubatomoHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 20
});
AddTimeEvent(0, 10, 19, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "SubatomoHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 20
});
AddTimeEvent(0, 10, 39, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 10, 39, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
for (var i = 0; i < 7; i++)
{
    AddTimeEvent(0, 10, 40 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "1",
        speed: 1,
        dir: 0,
        dirMoving: 180,
        amount: 12,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 9,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 10, 40 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "1",
        speed: 1,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 90,
        offset: 45,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 9,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 11, 0, "NewMob", function()
{
    AddMobChoice("Chocomate", 1, 1);
    spawnRate = 80;
    spawnAmount = 6;
});
AddTimeEvent(0, 11, 15, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ChocomateDasher",
    dir: "verticalSurround",
    amount: 2
});
AddTimeEvent(0, 11, 45, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "HealerOtaku",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 12, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ChocomateMiniBoss",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 12, 39, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 12, 39, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
for (var i = 0; i < 7; i++)
{
    AddTimeEvent(0, 12, 40 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Chocomate",
        level: "1",
        speed: 1,
        dir: 270,
        dirMoving: 90,
        amount: 2,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 9,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 12, 40 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Chocomate",
        level: "1",
        speed: 1,
        dir: 90,
        dirMoving: 270,
        amount: 12,
        spacing: 90,
        offset: 45,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 9,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 12, 43 + i, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "Oruyanke",
        level: "2",
        amount: 1,
        dropType: "random",
        warnRadius: 30,
        warnTime: 60
    });
}
AddTimeEvent(0, 13, 0, "NewMob", function()
{
    RemoveMobChoice("Subatomo");
    RemoveMobChoice("Chocomate");
    AddMobChoice("AquaCrew", 1, 1);
    spawnRate = 70;
    spawnAmount = 7;
});
AddTimeEvent(0, 13, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 13, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 13, 30, "NewMob", function()
{
    RemoveMobChoice("AquaCrew");
    AddMobChoice("Shiokko", 1, 1, 
    {
        dir: 0,
        pattern: "directionalSurround"
    });
    AddMobChoice("AquaCrew", 1, 1, 
    {
        dir: 180,
        pattern: "directionalSurround"
    });
    spawnRate = 45;
    spawnAmount = 8;
});
AddTimeEvent(0, 13, 40, "NewMob", function()
{
    RemoveMobChoice("Shiokko");
    RemoveMobChoice("Chocomate");
    AddMobChoice("AquaCrew", 1, 1);
    AddMobChoice("Shiokko", 1, 1);
    spawnRate = 80;
    spawnAmount = 5;
});
AddTimeEvent(0, 13, 34, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 13, 34, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
AddTimeEvent(0, 13, 35, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "ChocomateDasher",
    dir: "verticalSurround",
    amount: 3
});
AddTimeEvent(0, 13, 35, "EventSpawnDirectionB", EventSpawnDirection, 
{
    id: "ChocomateDasher",
    dir: "verticalSurround",
    amount: 3
});
AddTimeEvent(0, 14, 0, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "ShiokkoMiniBoss",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 14, 0, "EventSpawnDirectionB", EventSpawnDirection, 
{
    id: "AquaCrewMiniBoss",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 14, 0, "EventSpawnDirectionC", EventSpawnDirection, 
{
    id: "HealerOtaku",
    dir: "evenSurround",
    amount: 1
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 14, 10 + i, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "AquaCrewHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(359), "evenSurround"),
        amount: 30
    });
}
DropInBox("Oruyanke", [0, 14, 30], 
{
    lifeTime: 600,
    expvalue: 8,
    SPD: 0.05,
    HP: 500,
    lockFacing: false,
    knockbackImmune: true,
    tangible: false
}, 30, 40, 200, 30, 60, "2");
AddTimeEvent(0, 15, 0, "GoldenYagoo", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "evenSurround",
    chance: 20
});
AddTimeEvent(0, 15, 0, "NewMob", function()
{
    RemoveMobChoice("Shiokko");
    RemoveMobChoice("AquaCrew");
    AddMobChoice("Nakirigumi", 1, 1);
    spawnRate = 100;
    spawnAmount = 6;
});
AddTimeEvent(0, 15, 9, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 15, 9, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 15, 10, "EventSpawnWall1", EventSpawnWall, 
{
    id: "NakirigumiWave",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        HP: 1500,
        ATK: 12,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 15, 10, "EventSpawnWall2", EventSpawnWall, 
{
    id: "NakirigumiWave",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 1500,
        ATK: 12,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 15, 12, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 15, 12, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
AddTimeEvent(0, 15, 13, "EventSpawnWall1", EventSpawnWall, 
{
    id: "NakirigumiWave",
    level: "1",
    dir: 90,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        HP: 1500,
        ATK: 12,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 15, 13, "EventSpawnWall2", EventSpawnWall, 
{
    id: "NakirigumiWave",
    level: "1",
    dir: 270,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        HP: 1500,
        ATK: 12,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 15, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "HealerOtaku",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 16, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "NakirigumiMiniBoss",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 16, 0, "NewMob", function()
{
    spawnRate = 90;
    spawnAmount = 4;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 16, 5 + i, "EventSpawnHordeA", EventSpawnHorde, 
    {
        id: "AquaCrewHorde",
        level: "1",
        dir: ParseSpawnDirection(90 + irandom(180), "horizontalSurround"),
        amount: 20
    });
    AddTimeEvent(0, 16, 5 + i, "EventSpawnHordeB", EventSpawnHorde, 
    {
        id: "AquaCrewHorde",
        level: "1",
        dir: ParseSpawnDirection(90 - irandom(180), "horizontalSurround"),
        amount: 20
    });
    AddTimeEvent(0, 16, 5 + i, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "ChocomateDasher",
        dir: "verticalSurround",
        amount: 5
    });
}
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 16, 20 + i, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "Oruyanke",
        level: "3",
        amount: 1,
        dropType: "random",
        warnRadius: 50,
        warnTime: 120
    });
}
AddTimeEvent(0, 16, 45, "NewMob", function()
{
    RemoveMobChoice("Nakirigumi");
    AddMobChoice("Shiokko", 1, 2);
    spawnRate = 120;
    spawnAmount = 5;
});
AddTimeEvent(0, 17, 0, "NewMob", function()
{
    AddMobChoice("Chocomate", 2, 2);
    spawnRate = 75;
    spawnAmount = 5;
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
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 17, 0 + i, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "ChocomateDasher",
        dir: "evenSurround",
        amount: 3
    });
}
AddTimeEvent(0, 17, 15, "NewMob", function()
{
    AddMobChoice("Subatomo", 2, 2);
    spawnRate = 110;
    spawnAmount = 5;
});
AddTimeEvent(0, 17, 14, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 17, 19, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 17, 15 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "2",
        speed: 2,
        dir: 45,
        dirMoving: 225,
        amount: 12,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 9,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 17, 20 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "2",
        speed: 2,
        dir: 135,
        dirMoving: 315,
        amount: 12,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 9,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
AddTimeEvent(0, 17, 30, "NewMob", function()
{
    AddMobChoice("AquaCrew", 2, 2);
    spawnRate = 100;
    spawnAmount = 6;
});
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 17, 30 + i, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "AquaCrewHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(359), "evenSurround"),
        amount: 20
    });
}
AddTimeEvent(0, 17, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 17, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
for (var i = 0; i < 1; i++)
{
    AddTimeEvent(0, 17, 45 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 0,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            direction: 180,
            lockFacing: false,
            HP: 2000,
            ATK: 15,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 17, 45 + i, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 180,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            direction: 0,
            lockFacing: false,
            HP: 2000,
            ATK: 15,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
AddTimeEvent(0, 18, 0, "NewMob", function()
{
    AddMobChoice("Nakirigumi", 2, 2);
    spawnRate = 90;
    spawnAmount = 7;
});
AddTimeEvent(0, 18, 0, "EventSpawnDirectionC", EventSpawnDirection, 
{
    id: "HealerOtaku",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 18, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "PoyoyoMiniBoss",
    dir: "evenSurround",
    amount: 1
});
AddTimeEvent(0, 18, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 18, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 18, 29, "AlertC", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 18, 29, "AlertD", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
for (var i = 0; i < 4; i++)
{
    AddTimeEvent(0, 18, 30 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 0,
        amount: 10,
        spacing: 100,
        spawnOverride: 
        {
            direction: 180,
            lockFacing: false,
            HP: 2000,
            ATK: 10,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 18, 30 + i, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 180,
        amount: 10,
        spacing: 100,
        spawnOverride: 
        {
            direction: 0,
            lockFacing: false,
            HP: 2000,
            ATK: 10,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 18, 30 + i, "EventSpawnWall3", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 90,
        amount: 10,
        spacing: 100,
        spawnOverride: 
        {
            direction: 270,
            lockFacing: false,
            HP: 2000,
            ATK: 10,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 18, 30 + i, "EventSpawnWall4", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 270,
        amount: 10,
        spacing: 100,
        spawnOverride: 
        {
            direction: 90,
            lockFacing: false,
            HP: 2000,
            ATK: 10,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
AddTimeEvent(0, 18, 41, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 18, 42, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 18, 43, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 18, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
for (var i = 0; i < 8; i++)
{
    AddTimeEvent(0, 18, 45 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "NakirigumiWave",
        level: "1",
        dir: 0 + (i * 45),
        amount: 10,
        spacing: 100,
        spawnOverride: 
        {
            direction: 180 + (i * 45),
            lockFacing: false,
            HP: 2000,
            ATK: 15,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
AddTimeEvent(0, 19, 30, "NewMob", function()
{
    RemoveMobChoice("Nakirigumi");
    RemoveMobChoice("Subatomo");
    RemoveMobChoice("Chocomate");
    RemoveMobChoice("AquaCrew");
    RemoveMobChoice("Shiokko");
    AddMobChoice("Haaton", 2, 4);
    spawnRate = 80;
    spawnAmount = 9;
});
AddTimeEvent(0, 20, 0, "NewMob", function()
{
    RemoveMobChoice("Haaton");
    AddMobChoice("BabySpiders", 2, 1);
    spawnRate = 150;
    spawnAmount = 4;
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
    id: "EldrichHaachama",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 100,
    warnTime: 300
});
AddTimeEvent(0, 21, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 120;
    spawnAmount = 6;
});
AddTimeEvent(0, 22, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
    RemoveMobChoice("BabySpiders");
    AddMobChoice("Matsurisu", 1, 4);
    AddMobChoice("Haaton", 1, 5);
    AddMobChoice("Kapumin", 1, 4);
    AddMobChoice("Oruyanke", 1, 4);
    AddMobChoice("Rosetai", 1, 4);
    AddMobChoice("Subatomo", 1, 3);
    AddMobChoice("Chocomate", 1, 3);
    AddMobChoice("Shiokko", 1, 3);
    AddMobChoice("AquaCrew", 1, 3);
    AddMobChoice("Nakirigumi", 1, 3);
});
AddTimeEvent(0, 24, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 25, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 26, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 27, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 55;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 28, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 50;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 29, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 45;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 30, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 5;
    with (obj_Enemy)
    {
        if (!isBoss && isEnemy)
        {
            Die(true);
        }
    }
    currentSpawnPattern = "stage2_evenSurround";
    RemoveMobChoice("Matsurisu");
    RemoveMobChoice("Haaton");
    RemoveMobChoice("Rosetai");
    RemoveMobChoice("Kapumin");
    RemoveMobChoice("Oruyanke");
    RemoveMobChoice("Subatomo");
    RemoveMobChoice("Chocomate");
    RemoveMobChoice("Shiokko");
    RemoveMobChoice("Nakirigumi");
    RemoveMobChoice("AquaCrew");
    AddMobChoice("Yagoos", 1, 1);
});
