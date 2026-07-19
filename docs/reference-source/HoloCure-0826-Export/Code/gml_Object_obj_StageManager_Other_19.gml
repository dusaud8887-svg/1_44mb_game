global.topBorder = 715;
global.bottomBorder = 1694;
global.leftBorder = 731;
global.rightBorder = 2266;
global.wrappingStage = true;
AddTimeEvent(0, 0, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 90;
    spawnAmount = 5;
    AddMobChoice("Matsurisu", 1, 5);
});
AddTimeEvent(0, 0, 10, "EventSpawnClumpedDirection1", EventSpawnClumpedDirection, 
{
    id: "Matsurisu",
    level: "5",
    dir: "0",
    amount: 10,
    size: 40,
    spawnOverride: 
    {
        expvalue: 2
    }
});
AddTimeEvent(0, 0, 10, "EventSpawnClumpedDirection2", EventSpawnClumpedDirection, 
{
    id: "Matsurisu",
    level: "5",
    dir: "180",
    amount: 10,
    size: 40,
    spawnOverride: 
    {
        expvalue: 2
    }
});
AddTimeEvent(0, 0, 10, "EventSpawnClumpedDirection3", EventSpawnClumpedDirection, 
{
    id: "Matsurisu",
    level: "5",
    dir: "90",
    amount: 10,
    size: 40,
    spawnOverride: 
    {
        expvalue: 2
    }
});
AddTimeEvent(0, 0, 10, "EventSpawnClumpedDirection4", EventSpawnClumpedDirection, 
{
    id: "Matsurisu",
    level: "5",
    dir: "270",
    amount: 10,
    size: 40,
    spawnOverride: 
    {
        expvalue: 2
    }
});
AddTimeEvent(0, 0, 20, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MatsurisuDasher",
    level: "2",
    dir: 45,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 225,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 0, 20, "EventSpawnWall2", EventSpawnWall, 
{
    id: "MatsurisuDasher",
    level: "2",
    dir: 135,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 315,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 0, 21, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 75,
    warnTime: 80,
    spawnOverride: 
    {
        HP: 150,
        expvalue: 5,
        ATK: 15
    }
});
AddTimeEvent(0, 0, 40, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 80;
    spawnAmount = 7;
    AddMobChoice("Haaton", 1, 6);
});
AddTimeEvent(0, 0, 40, "EventSpawnWall1", EventSpawnWall, 
{
    id: "MatsurisuDasher",
    level: "2",
    dir: 90,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 0, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Matsurisu",
    level: "1",
    amount: 10,
    dropType: "surround",
    warnRadius: 80,
    dropDistance: 150,
    warnTime: 60,
    spawnOverride: 
    {
        lifeTime: 1,
        ATK: 10
    }
});
AddTimeEvent(0, 1, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 80,
    warnTime: 120,
    spawnOverride: 
    {
        HP: 500,
        expvalue: 5
    }
});
CallAlert("right", [0, 1, 13]);
AddTimeEvent(0, 1, 14, "SetPosition", EventLockPosition);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 1, 15 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "SSRB",
        level: "1",
        speed: 0.9,
        dir: 0,
        dirMoving: 180,
        offset: ((i % 2) == 0) * 40,
        amount: 20,
        spacing: 80,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 1500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                followPlayer: obj_MobManager.behaviours.followPlayer,
                selfDestruct: 
                {
                    config: 
                    {
                        warnTime: 80,
                        radius: 80
                    }
                }
            }
        }
    });
}
AddTimeEvent(0, 1, 30, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "3",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 1, 45 + i, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "MatsurisuDasher",
        level: "1",
        dir: "random",
        amount: 1,
        spawnOverride: 
        {
            ATK: 15,
            image_xscale: 2,
            image_yscale: 2,
            SPD: 30,
            lifeTime: 1200,
            expvalue: 4,
            HP: 1500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: true
        }
    });
}
AddTimeEvent(0, 2, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MatsurisuMiniBoss",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 90
});
AddTimeEvent(0, 2, 20, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 85;
    spawnAmount = 7;
    RemoveMobChoice("Matsurisu");
    AddMobChoice("SukonbuH", 1, 4);
});
AddTimeEvent(0, 2, 10, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 5,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1,
        expvalue: 10,
        HP: 1500
    }
});
CallAlert("vertical", [0, 2, 29]);
AddTimeEvent(0, 2, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        tangible: false,
        HP: 1500,
        ATK: 14
    }
});
AddTimeEvent(0, 2, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    offset: 35,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        tangible: false,
        HP: 1500,
        ATK: 14
    }
});
AddTimeEvent(0, 3, 5, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "3",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 3, 6, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "3",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 3, 7, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "3",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 3, 8, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "3",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 3, 9, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "KapuminHorde",
    level: "3",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 3, 10, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 15;
    RemoveMobChoice("Matsurisu");
    RemoveMobChoice("Haaton");
    RemoveMobChoice("SukonbuH");
    AddMobChoice("Kapumin", 1, 6);
});
AddTimeEvent(0, 3, 15, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 5,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1,
        expvalue: 10,
        HP: 1800
    }
});
AddTimeEvent(0, 3, 35, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 7;
    RemoveMobChoice("Kapumin");
    AddMobChoice("Kapumin", 1, 5);
});
AddTimeEvent(0, 3, 40, "SetPosition", EventLockPosition);
AddTimeEvent(0, 3, 41, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KapuminDasher",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 3, 42, "EventSpawnWall1", EventSpawnWall, 
{
    id: "KapuminDasher",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    offset: 35,
    setPosition: true,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 4, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "ObakeMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 90
});
AddTimeEvent(0, 4, 10, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "SPDOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 10,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1.2,
        expvalue: 10,
        HP: 2000
    }
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 4, 15 + i, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "Oruyanke",
        level: "1",
        amount: 2,
        dropType: "random",
        warnRadius: 40,
        warnTime: 60,
        spawnOverride: 
        {
            HP: 350,
            SPD: 0.8
        }
    });
}
AddTimeEvent(0, 4, 40, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 8;
    RemoveMobChoice("Kapumin");
    AddMobChoice("Rosetai", 1, 5);
});
AddTimeEvent(0, 5, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "RosetaiCharger",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 90,
    spawnOverride: 
    {
        HP: 1200,
        image_xscale: 1.5,
        image_yscale: 1.5
    }
});
AddTimeEvent(0, 5, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 9;
    AddMobChoice("Subatomo", 1, 4);
});
CallAlert("all", [0, 5, 44]);
AddTimeEvent(0, 5, 44, "SetPosition", EventLockPosition);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 5, 45 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "1",
        speed: 1,
        dir: 0,
        dirMoving: 180,
        offset: 175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 1500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 45 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "1",
        speed: 1,
        dir: 180,
        dirMoving: 0,
        offset: -175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 1500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 45 + i, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "1",
        speed: 1,
        dir: 90,
        dirMoving: 270,
        offset: -175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 1500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 45 + i, "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: "Subatomo",
        level: "1",
        speed: 1,
        dir: 270,
        dirMoving: 90,
        offset: -175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 1500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 6, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "ChocomateMiniBoss",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 90
});
AddTimeEvent(0, 6, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 9;
    RemoveMobChoice("Rosetai");
    AddMobChoice("Chocomate", 1, 4);
});
AddTimeEvent(0, 6, 20, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "RosetaiCharger",
    level: "1",
    dir: "random",
    amount: 3
});
AddTimeEvent(0, 6, 25, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "SPDOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 5,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1,
        expvalue: 10,
        HP: 2500
    }
});
AddTimeEvent(0, 6, 45, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "ChocomateHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 6, 46, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "ChocomateHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 6, 47, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "ChocomateHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(359), "evenSurround"),
    amount: 30
});
AddTimeEvent(0, 7, 0, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Subatomo",
    level: "1",
    speed: 0.1,
    dir: 0,
    dirMoving: 180,
    offset: 175,
    amount: 25,
    spacing: 30,
    spawnOverride: 
    {
        lifeTime: 600,
        SPD: 0.1,
        expvalue: 3,
        HP: 3000,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 7, 0, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Subatomo",
    level: "1",
    speed: 0.1,
    dir: 180,
    dirMoving: 0,
    offset: -175,
    amount: 5,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        lifeTime: 600,
        SPD: 0.1,
        expvalue: 3,
        HP: 3000,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 7, 2, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 90,
    warnTime: 80,
    spawnOverride: 
    {
        HP: 1000,
        expvalue: 5,
        ATK: 15
    }
});
AddTimeEvent(0, 7, 4, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 90,
    warnTime: 80,
    spawnOverride: 
    {
        HP: 1000,
        expvalue: 5,
        ATK: 15
    }
});
AddTimeEvent(0, 7, 6, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 90,
    warnTime: 80,
    spawnOverride: 
    {
        HP: 1000,
        expvalue: 5,
        ATK: 15
    }
});
AddTimeEvent(0, 7, 8, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 90,
    warnTime: 80,
    spawnOverride: 
    {
        HP: 1000,
        expvalue: 5,
        ATK: 15
    }
});
AddTimeEvent(0, 7, 3, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: "random",
    amount: 5
});
AddTimeEvent(0, 7, 5, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: "random",
    amount: 5
});
AddTimeEvent(0, 7, 7, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: "random",
    amount: 5
});
AddTimeEvent(0, 7, 9, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: "random",
    amount: 5
});
AddTimeEvent(0, 7, 30, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "ATKOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 10,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1.2,
        expvalue: 10,
        HP: 3000
    }
});
AddTimeEvent(0, 7, 30, "EventSpawnDirection2", EventSpawnDirection, 
{
    id: "SPDOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 10,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1.2,
        expvalue: 10,
        HP: 3000
    }
});
AddTimeEvent(0, 7, 50, "EventSpawnDirection2", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 10,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1,
        expvalue: 10,
        HP: 3000
    }
});
AddTimeEvent(0, 8, 0, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "ShiokkoMiniBoss",
    level: "2",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 8, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 9;
    RemoveMobChoice("Subatomo");
    RemoveMobChoice("Chocomate");
    AddMobChoice("Shiokko", 1, 4);
    AddMobChoice("AquaCrew", 1, 4);
});
AddTimeEvent(0, 8, 40, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "Shiokko",
    level: "5",
    amount: 60,
    dir: "evenSurround",
    spawnOverride: 
    {
        HP: 400,
        lockFacing: false,
        tangible: false,
        ATK: 16
    }
});
CallAlert("verticals", [0, 8, 44]);
AddTimeEvent(0, 8, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        HP: 5000,
        direction: 270,
        lockFacing: false,
        tangible: false,
        ATK: 16
    }
});
AddTimeEvent(0, 8, 45, "EventSpawnWall2", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    offset: 35,
    spawnOverride: 
    {
        HP: 5000,
        direction: 90,
        lockFacing: false,
        tangible: false,
        ATK: 16
    }
});
AddTimeEvent(0, 9, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 9;
    AddMobChoice("Nakirigumi", 1, 4);
});
AddTimeEvent(0, 9, 10, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "RosetaiCharger",
    level: "1",
    dir: "random",
    amount: 5,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 20
    }
});
AddTimeEvent(0, 9, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "2",
    dir: 0,
    amount: 7,
    spacing: 30,
    offsetY: 140,
    spawnOverride: 
    {
        HP: 5000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 9, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "2",
    dir: 180,
    amount: 7,
    spacing: 30,
    offsetY: -140,
    spawnOverride: 
    {
        HP: 5000,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 9, 32, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "2",
    dir: 90,
    amount: 7,
    spacing: 30,
    offsetX: 140,
    spawnOverride: 
    {
        HP: 5000,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 9, 32, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "2",
    dir: 270,
    amount: 7,
    spacing: 30,
    offsetX: -140,
    spawnOverride: 
    {
        HP: 5000,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 10, 0, "EventSpawnDropInA", EventSpawnDropIn, 
{
    id: "Shubangelion",
    level: "2",
    amount: 1,
    dropDistance: 100,
    dropType: "random",
    warnRadius: 40,
    warnTime: 80
});
AddTimeEvent(0, 10, 0, "EventSpawnDropInB", EventSpawnDropIn, 
{
    id: "EldrichHaachamaH",
    level: "1",
    amount: 1,
    dropDistance: 100,
    dropType: "random",
    warnRadius: 30,
    warnTime: 80
});
AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 5;
    RemoveMobChoice("Nakirigumi");
    RemoveMobChoice("Shiokko");
    RemoveMobChoice("AquaCrew");
    AddMobChoice("BabySpiders", 1, 1);
});
AddTimeEvent(0, 10, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Oruyanke",
    level: "1",
    dir: "random",
    amount: 3,
    spawnOverride: 
    {
        ATK: 15,
        SPD: 1,
        expvalue: 3,
        HP: 900
    }
});
AddTimeEvent(0, 11, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 7;
    RemoveMobChoice("BabySpiders");
    AddMobChoice("ShrimpGang", 3, 5);
});
AddTimeEvent(0, 11, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "2",
    dir: 0,
    amount: 7,
    spacing: 30,
    spawnOverride: 
    {
        HP: 5000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 11, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "2",
    dir: 90,
    amount: 7,
    spacing: 30,
    spawnOverride: 
    {
        HP: 5000,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 11, 31, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "ShrimpGang",
    level: "5",
    amount: 8,
    dropDistance: 150,
    dropType: "surround",
    warnRadius: 30,
    warnTime: 60
});
AddTimeEvent(0, 12, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "DeadbeatGangMiniBoss",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 20,
    warnTime: 80
});
AddTimeEvent(0, 12, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 7;
    AddMobChoice("DeadbeatGang", 1, 5);
});
CallAlert("horizontal", [0, 12, 39]);
AddTimeEvent(0, 12, 40, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 12, 40, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 12, 50, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 0;
});
AddTimeEvent(0, 13, 0, "SetPosition", EventLockPosition);
DropInBox("ShrimpGang", [0, 13, 0], 
{
    lifeTime: 1200,
    expvalue: 3,
    SPD: 0.05,
    HP: 6000,
    image_xscale: 2,
    image_yscale: 2,
    lockFacing: false,
    knockbackImmune: true,
    tangible: false
}, 20, 40, 250, 30, 60, "5", true);
CallAlert("all", [0, 13, 4]);
AddTimeEvent(0, 13, 5, "SetPosition", EventLockPosition);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 13, 5 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "5",
        speed: 1,
        dir: 0,
        dirMoving: 180,
        offset: 175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 4500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 13, 5 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "5",
        speed: 1,
        dir: 180,
        dirMoving: 0,
        offset: -175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 4500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 13, 5 + i, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "5",
        speed: 1,
        dir: 90,
        dirMoving: 270,
        offset: -175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 4500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 13, 5 + i, "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "5",
        speed: 1,
        dir: 270,
        dirMoving: 90,
        offset: -175,
        amount: 5,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 4500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
}
AddTimeEvent(0, 13, 7, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: 180,
    amount: 4,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 13, 10, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: 90,
    amount: 4,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 13, 10, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: 0,
    amount: 4,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 13, 11, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "3",
    dir: 270,
    amount: 4,
    spacing: 70,
    spawnOverride: 
    {
        HP: 3000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 13, 12, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 8;
});
AddTimeEvent(0, 13, 30, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 80,
    warnTime: 90,
    spawnOverride: 
    {
        HP: 3000,
        expvalue: 5
    }
});
AddTimeEvent(0, 13, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "ATKOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 80,
    warnTime: 90,
    spawnOverride: 
    {
        HP: 3000,
        expvalue: 5
    }
});
AddTimeEvent(0, 14, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 7;
    RemoveMobChoice("ShrimpGang");
    AddMobChoice("Takodachi", 4, 6);
});
AddTimeEvent(0, 14, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "TakodachiMiniBoss",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 20,
    warnTime: 90
});
AddTimeEvent(0, 14, 40, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Takodachi",
    level: "7",
    dir: "random",
    amount: 3
});
AddTimeEvent(0, 15, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 7;
    RemoveMobChoice("DeadbeatGang");
});
AddTimeEvent(0, 15, 9, "SetPosition", EventLockPosition);
AddTimeEvent(0, 15, 10, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Takodachi",
    level: "7",
    dir: 0,
    amount: 15,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        direction: 180,
        image_xscale: 1,
        image_yscale: 1,
        SPD: 20,
        lockFacing: false,
        tangible: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 240
                }
            }
        }
    }
});
AddTimeEvent(0, 15, 11, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Takodachi",
    level: "7",
    dir: 180,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    setPosition: true,
    spawnOverride: 
    {
        direction: 0,
        image_xscale: 1,
        image_yscale: 1,
        SPD: 20,
        lockFacing: false,
        tangible: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 240
                }
            }
        }
    }
});
AddTimeEvent(0, 15, 12, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Takodachi",
    level: "7",
    dir: 270,
    amount: 15,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        direction: 90,
        image_xscale: 1,
        image_yscale: 1,
        SPD: 20,
        lockFacing: false,
        tangible: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 240
                }
            }
        }
    }
});
AddTimeEvent(0, 15, 13, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Takodachi",
    level: "7",
    dir: 90,
    amount: 15,
    spacing: 70,
    offsetX: 35,
    setPosition: true,
    spawnOverride: 
    {
        direction: 270,
        image_xscale: 1,
        image_yscale: 1,
        SPD: 20,
        lockFacing: false,
        tangible: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 240
                }
            }
        }
    }
});
AddTimeEvent(0, 15, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 6;
    RemoveMobChoice("DeadbeatGang");
    AddMobChoice("KFP", 2, 5);
});
CallAlert("all", [0, 15, 44]);
for (var i = 0; i < 6; i++)
{
    AddTimeEvent(0, 15, 45, "EventSpawnHorde" + string(i), EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "3",
        dir: ParseSpawnDirection(i * 60, "evenSurround"),
        amount: 10
    });
}
AddTimeEvent(0, 16, 0, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "KFPMiniBoss",
    level: "2",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 16, 45, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "BubbaCharger",
    level: "1",
    dir: "random",
    amount: 4
});
for (var i = 0; i < 4; i++)
{
    AddTimeEvent(0, 16, 20 + i, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "3",
        dir: ParseSpawnDirection(irandom(359), "evenSurround"),
        amount: 30
    });
}
AddTimeEvent(0, 16, 45, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 7;
    AddMobChoice("BigBubba", 4, 7);
});
CallAlert("horizontals", [0, 17, 0]);
for (var i = 0; i < 10; i++)
{
    AddTimeEvent(0, 17, i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "BigBubba",
        level: "7",
        speed: 1.2,
        dir: 0,
        dirMoving: 180,
        amount: 15,
        spacing: 70,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 3,
            HP: 5000,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 17, i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "BigBubba",
        level: "7",
        speed: 1.2,
        dir: 180,
        dirMoving: 0,
        amount: 15,
        offset: 35,
        spacing: 70,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 3,
            HP: 5000,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 17, i + 1, "EventSpawnDirection1", EventSpawnDirection, 
    {
        id: "FububirdDasherH",
        level: "3",
        dir: "random",
        amount: 1
    });
}
AddTimeEvent(0, 17, 30, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "BubbaCharger",
    level: "1",
    dir: "random",
    amount: 7
});
AddTimeEvent(0, 17, 45, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "SPDOtakuID",
    level: "1",
    dir: "random",
    amount: 1,
    spawnOverride: 
    {
        ATK: 15,
        image_xscale: 1.5,
        image_yscale: 1.5,
        SPD: 1.2,
        expvalue: 10,
        HP: 4000
    }
});
AddTimeEvent(0, 18, 0, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "BubbaChargerMiniBoss",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 18, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 7;
    RemoveMobChoice("KFP");
});
AddTimeEvent(0, 18, 29, "SetPosition", EventLockPosition);
AddTimeEvent(0, 18, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 5,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 18, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 5,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 18, 31, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 5,
    offsetX: 150,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 18, 31, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 90,
    amount: 5,
    offsetX: -200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 270,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 18, 31, "EventSpawnWall3", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 5,
    offsetY: 200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 180,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 18, 31, "EventSpawnWall4", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 180,
    amount: 5,
    offsetY: -200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 0,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 19, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 15;
    RemoveMobChoice("Takodachi");
    RemoveMobChoice("BigBubba");
    AddMobChoice("S3HFinalMob", 1, 1);
});
AddTimeEvent(0, 19, 29, "ChangeSpawnRate", function()
{
    enemyLimit = 0;
    spawnRate = 15;
    enabledSpawner = false;
    spawnAmount = -100;
    RemoveMobChoice("BigBubba");
    currentSpawnPattern = "evenSurround";
    with (obj_Enemy)
    {
        if (!isBoss && isEnemy)
        {
            Die(true);
        }
    }
});
AddTimeEvent(0, 19, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 45,
    amount: 5,
    spacing: 30,
    spawnOverride: 
    {
        HP: 3000,
        direction: 225,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 19, 30, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 135,
    amount: 5,
    spacing: 30,
    spawnOverride: 
    {
        HP: 3000,
        direction: 315,
        lockFacing: false,
        tangible: false
    }
});
CallAlert("vertical", [0, 19, 31]);
for (var i = 0; i < 4; i++)
{
    AddTimeEvent(0, 19, 32 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "FububirdH",
        level: "1",
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
    AddTimeEvent(0, 19, 32 + i, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "FububirdH",
        level: "1",
        dir: 90,
        amount: 10,
        spacing: 70,
        spawnOverride: 
        {
            HP: 3000,
            direction: 270,
            lockFacing: false,
            tangible: false
        }
    });
}
CallAlert("horizontals", [0, 19, 32]);
AddTimeEvent(0, 19, 32, "SetPosition", EventLockPosition);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 19, 33 + i, "EventSpawnDirectionLocked" + string(i), EventSpawnDirectionLocked, 
    {
        id: "SSRB",
        level: "1",
        speed: 1.5,
        dir: 0,
        dirMoving: 180,
        offset: ((i % 2) == 0) * 40,
        amount: 20,
        spacing: 80,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 2000,
            expvalue: 5,
            HP: 3500,
            ignoreWalls: true,
            lockFacing: false,
            knockbackImmune: true,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                selfDestruct: 
                {
                    config: 
                    {
                        warnTime: 60,
                        radius: 100
                    }
                }
            }
        }
    });
}
AddTimeEvent(0, 19, 38, "SetPosition", EventLockPosition);
AddTimeEvent(0, 19, 39, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "SSRB",
    level: "1",
    speed: 0.1,
    dir: 0,
    dirMoving: 180,
    amount: 20,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        lifeTime: 540,
        expvalue: 5,
        HP: 5500,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 30,
                    radius: 100
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 39, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "SSRB",
    level: "1",
    speed: 0.1,
    dir: 180,
    dirMoving: 0,
    amount: 20,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        lifeTime: 540,
        expvalue: 5,
        HP: 5500,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 30,
                    radius: 100
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 39, "EventSpawnDropInC", EventSpawnDropIn, 
{
    id: "Takodachi",
    level: "8",
    amount: 15,
    dropType: "wall",
    dropDistance: 170,
    spacing: 60,
    wallDir: 90,
    warnRadius: 30,
    warnTime: 60,
    spawnOverride: 
    {
        image_xscale: 3,
        image_yscale: 3
    }
});
AddTimeEvent(0, 19, 39, "EventSpawnDropInD", EventSpawnDropIn, 
{
    id: "Takodachi",
    level: "8",
    amount: 15,
    dropType: "wall",
    dropDistance: 170,
    spacing: 60,
    wallDir: 270,
    warnRadius: 30,
    warnTime: 60,
    spawnOverride: 
    {
        image_xscale: 3,
        image_yscale: 3
    }
});
AddTimeEvent(0, 19, 43, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "BubbaCharger",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 30,
    warnTime: 90,
    spawnOverride: 
    {
        HP: 1500,
        expvalue: 5,
        ATK: 15,
        lifeTime: 380
    }
});
AddTimeEvent(0, 19, 47, "SetPosition", EventLockPosition);
AddTimeEvent(0, 19, 48, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 9,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 90,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 48, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 9,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 180,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 49, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 5,
    offsetX: 200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 90,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 49, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 90,
    amount: 5,
    offsetX: -200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 270,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 49, "EventSpawnWall3", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 5,
    offsetY: 200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 180,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 49, "EventSpawnWall4", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 180,
    amount: 5,
    offsetY: -200,
    spacing: 30,
    setPosition: true,
    spawnOverride: 
    {
        HP: 3000,
        direction: 0,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 150
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 50, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 20,
    warnTime: 90,
    setPosition: true,
    spawnOverride: 
    {
        HP: 5000,
        image_xscale: 3,
        image_yscale: 3,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            followPlayer: obj_MobManager.behaviours.followPlayer,
            selfDestruct: 
            {
                config: 
                {
                    warnTime: 120,
                    radius: 200
                }
            }
        }
    }
});
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 19, 52 + i, "EventSpawnDirection" + string(i), EventSpawnDirection, 
    {
        id: "FububirdDasherH",
        level: "3",
        dir: "random",
        amount: 1,
        spawnOverride: 
        {
            HP: 5000,
            ATK: 30,
            image_xscale: 2,
            image_yscale: 2,
            lockFacing: false,
            tangible: false,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 1,
                        warnTime: 60
                    }
                }
            }
        }
    });
}
AddTimeEvent(0, 19, 55, "EventSequenceSpawn", EventSequenceSpawn, 
{
    id: "FububirdDasherH",
    level: "3",
    amount: 4,
    dropType: "surround",
    warnRadius: 1,
    dropDistance: 300,
    warnTime: 1,
    sequenceTime: 30,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 30,
        image_xscale: 2,
        image_yscale: 2
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 0,
                warnTime: 30
            }
        }
    }
});
AddTimeEvent(0, 19, 57, "EventSequenceSpawn", EventSequenceSpawn, 
{
    id: "FububirdDasherH",
    level: "3",
    amount: 8,
    dropType: "surround",
    warnRadius: 1,
    dropDistance: 300,
    warnTime: 1,
    sequenceTime: 15,
    spawnOverride: 
    {
        HP: 5000,
        ATK: 30,
        image_xscale: 2,
        image_yscale: 2
    },
    behaviours: 
    {
        collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
        chargePlayer: 
        {
            config: 
            {
                waitTime: 0,
                warnTime: 15
            }
        }
    }
});
AddTimeEvent(0, 19, 59, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "FububirdDasherH",
    level: "3",
    amount: 10,
    dir: "evenSurround",
    spawnOverride: 
    {
        HP: 5000,
        image_xscale: 2,
        image_yscale: 2,
        lockFacing: false,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 0,
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 20, 1, "EventSpawnDirection1", EventSpawnDirection, 
{
    id: "MoTAme",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 1, "EventSpawnDirection2", EventSpawnDirection, 
{
    id: "MoTGura",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 1, "EventSpawnDirection3", EventSpawnDirection, 
{
    id: "MoTCalli",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 1, "EventSpawnDirection4", EventSpawnDirection, 
{
    id: "MoTIna",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 1, "EventSpawnDirection5", EventSpawnDirection, 
{
    id: "MoTKiara",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 1, "EventSpawnDirection6", EventSpawnDirection, 
{
    id: "MythOrTreat",
    level: "1",
    dir: "random",
    amount: 1
});
AddTimeEvent(0, 20, 1, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    enabledSpawner = true;
    spawnAmount = 3;
    currentSpawnPattern = "evenSurround";
    with (obj_Enemy)
    {
        if (!isBoss && isEnemy)
        {
            Die(true);
        }
    }
    AddMobChoice("S3HFinalMob", 1, 2);
});
AddTimeEvent(0, 21, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 120;
    spawnAmount = 6;
});
AddTimeEvent(0, 23, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 6;
    currentSpawnPattern = "evenSurround";
    RemoveMobChoice("S3HFinalMob");
    AddMobChoice("Matsurisu", 5, 6);
    AddMobChoice("Haaton", 5, 7);
    AddMobChoice("Kapumin", 5, 7);
    AddMobChoice("Oruyanke", 1, 4);
    AddMobChoice("Rosetai", 5, 6);
    AddMobChoice("Subatomo", 5, 5);
    AddMobChoice("Chocomate", 5, 5);
    AddMobChoice("Shiokko", 1, 6);
    AddMobChoice("AquaCrew", 5, 5);
    AddMobChoice("Nakirigumi", 5, 5);
    AddMobChoice("ShrimpGang", 5, 5);
    AddMobChoice("DeadbeatGang", 5, 5);
    AddMobChoice("Takodachi", 5, 9);
    AddMobChoice("KFP", 5, 6);
    AddMobChoice("BigBubba", 5, 8);
    AddMobChoice("FububirdDasherH", 1, 4);
});
AddTimeEvent(0, 24, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 25, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 26, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 27, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 55;
    spawnAmount = 7;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 28, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 50;
    spawnAmount = 7;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 29, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 45;
    spawnAmount = 7;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 30, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 8;
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
    RemoveMobChoice("ShrimpGang");
    RemoveMobChoice("DeadbeatGang");
    RemoveMobChoice("Takodachi");
    RemoveMobChoice("KFP");
    RemoveMobChoice("BigBubba");
    RemoveMobChoice("FububirdDasherH");
    AddMobChoice("Yagoos", 1, 3);
});
