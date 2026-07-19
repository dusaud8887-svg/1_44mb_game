global.topBorder = 920;
global.bottomBorder = 1405;
global.leftBorder = -1;
global.rightBorder = -1;
global.wrappingStage = true;
AddTimeEvent(0, 0, 0, "ChangeSpawnPattern", ChangeSpawnPattern, 
{
    id: "stage2_evenSurround"
});
AddTimeEvent(0, 0, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 100;
    spawnAmount = 5;
    AddMobChoice("SukonbuH", 1, 1);
});
AddTimeEvent(0, 0, 5, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SukonbuH",
    level: "1",
    amount: 10,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 30,
    warnTime: 120
});
CallAlert("left", [0, 0, 29]);
AddTimeEvent(0, 0, 30, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "SukonbuH",
    level: "1",
    speed: 4,
    dir: 180,
    dirMoving: 0,
    amount: 15,
    spacing: 50,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 600,
        lockFacing: false,
        knockbackImmune: true
    }
});
CallAlert("right", [0, 0, 31]);
AddTimeEvent(0, 0, 32, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "SukonbuH",
    level: "1",
    speed: 4,
    dir: 0,
    dirMoving: 180,
    amount: 15,
    spacing: 50,
    offset: 25,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 600,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 0, 45, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SukonbuH",
    level: "1",
    dir: "horizontalSurround",
    amount: 6,
    spawnOverride: 
    {
        SPD: 25,
        ignoreWalls: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 60
                }
            }
        }
    }
});
AddTimeEvent(0, 0, 50, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "Oruyanke",
    level: "1",
    dir: "horizontalSurround",
    amount: 3
});
AddTimeEvent(0, 1, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 1, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 90;
    spawnAmount = 5;
    AddMobChoice("MiofaH", 2, 1);
});
AddTimeEvent(0, 1, 10, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "SSRBH2",
    level: "1",
    dir: "horizontalSurround",
    amount: 2
});
AddTimeEvent(0, 1, 15, "EventSpawnCircle", EventSpawnCircle, 
{
    id: "MiofaH",
    level: "1",
    dir: "evenSurround",
    amount: 20,
    spawnOverride: 
    {
        SPD: 0.4
    }
});
AddTimeEvent(0, 1, 30, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MiofaH",
    level: "1",
    amount: 3,
    dropType: "surround",
    dropDistance: 175,
    warnRadius: 30,
    warnTime: 150,
    spawnOverride: 
    {
        HP: 300,
        SPD: 25,
        ignoreWalls: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargePlayer: 
            {
                config: 
                {
                    waitTime: 30,
                    warnTime: 60
                }
            }
        }
    }
});
AddTimeEvent(0, 1, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 30,
    warnRadius: 50,
    warnTime: 60,
    spawnOverride: 
    {
        HP: 100
    }
});
AddTimeEvent(0, 1, 42, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 30,
    warnRadius: 50,
    warnTime: 60,
    spawnOverride: 
    {
        HP: 100
    }
});
AddTimeEvent(0, 1, 44, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 30,
    warnRadius: 50,
    warnTime: 60,
    spawnOverride: 
    {
        HP: 100
    }
});
AddTimeEvent(0, 2, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SukonbuMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 30,
    warnTime: 90
});
CallAlert("right", [0, 2, 9]);
AddTimeEvent(0, 2, 10, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 0,
    amount: 7,
    spacing: 80,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false
    }
});
CallAlert("left", [0, 2, 10]);
AddTimeEvent(0, 2, 11, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 180,
    amount: 7,
    spacing: 80,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false
    }
});
CallAlert("up", [0, 2, 11]);
AddTimeEvent(0, 2, 12, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 90,
    amount: 7,
    spacing: 80,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false
    }
});
CallAlert("down", [0, 2, 12]);
AddTimeEvent(0, 2, 13, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 270,
    amount: 7,
    spacing: 80,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false
    }
});
AddTimeEvent(0, 2, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 100;
    spawnAmount = 6;
    RemoveMobChoice("SukonbuH");
    RemoveMobChoice("MiofaH");
    AddMobChoice("OnigiriyaH", 1, 1);
    AddMobChoice("KoronesukiH", 1, 1);
});
AddTimeEvent(0, 2, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "OnigiriyaH",
    level: "1",
    speed: 0.3,
    dir: 0,
    dirMoving: 180,
    amount: 40,
    spacing: 30,
    spawnOverride: 
    {
        lifeTime: 780,
        expvalue: 7,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 2, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "KoronesukiH",
    level: "1",
    speed: 0.3,
    dir: 180,
    dirMoving: 0,
    amount: 40,
    spacing: 30,
    spawnOverride: 
    {
        lifeTime: 780,
        expvalue: 7,
        HP: 500,
        lockFacing: false,
        knockbackImmune: true
    }
});
if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
{
    AddTimeEvent(0, 3, 0, "SilverYagoo", EventSpawnDirection, 
    {
        id: "SilverYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 30
    });
}
AddTimeEvent(0, 3, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 50;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_rightSurround";
});
CallAlert("left", [0, 3, 9]);
AddTimeEvent(0, 3, 10, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false
    }
});
AddTimeEvent(0, 3, 11, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false
    }
});
AddTimeEvent(0, 3, 12, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 70,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false
    }
});
AddTimeEvent(0, 3, 15, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 90;
    spawnAmount = 6;
    currentSpawnPattern = "horizontalSurround";
});
AddTimeEvent(0, 3, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "1",
    amount: 5,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 50,
    warnTime: 150,
    spawnOverride: 
    {
        HP: 100
    }
});
AddTimeEvent(0, 3, 25, "ChangeSpawnRate", function()
{
    spawnRate = 150;
    spawnAmount = 2;
});
DropInBox("MiofaH", [0, 3, 30], 
{
    lifeTime: 500,
    expvalue: 8,
    SPD: 0.05,
    HP: 1000,
    lockFacing: false,
    knockbackImmune: true,
    sprite_index: spr_Miofa_A_Shielded,
    tangible: false
}, 20, 30, 200, 30, 60, "1");
CallAlert("horizontal", [0, 3, 34]);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 3, 35 + i, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "FububirdH",
        level: "1",
        dir: 120 + irandom(60),
        amount: 1,
        spawnOverride: 
        {
            HP: 300,
            SPD: 25,
            ignoreWalls: true,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 60
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 3, 35 + i, "EventSpawnDirectionB", EventSpawnDirection, 
    {
        id: "FububirdH",
        level: "1",
        dir: -30 + irandom(60),
        amount: 1,
        spawnOverride: 
        {
            HP: 300,
            SPD: 25,
            ignoreWalls: true,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 60
                    }
                }
            }
        }
    });
}
CallAlert("horizontal", [0, 3, 49]);
AddTimeEvent(0, 3, 50, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Miofa",
    level: "1",
    speed: 5,
    dir: 0,
    dirMoving: 180,
    amount: 15,
    spacing: 60,
    spawnOverride: 
    {
        sprite_index: spr_Miofa_A_Shielded,
        lifeTime: 1200,
        expvalue: 8,
        HP: 600,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 3, 50, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Miofa",
    level: "1",
    speed: 5,
    dir: 180,
    dirMoving: 0,
    amount: 15,
    spacing: 60,
    offset: 30,
    spawnOverride: 
    {
        sprite_index: spr_Miofa_B_Shielded,
        lifeTime: 1200,
        expvalue: 8,
        ATK: 7,
        HP: 600,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 3, 50, "ChangeSpawnRate", function()
{
    spawnRate = 90;
    spawnAmount = 6;
});
AddTimeEvent(0, 4, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MiofaMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 30,
    warnTime: 90
});
AddTimeEvent(0, 4, 15, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRBH2",
    level: "2",
    amount: 10,
    dropType: "wall",
    dropDistance: 300,
    spacing: 40,
    wallDir: 0,
    warnRadius: 50,
    warnTime: 90
});
AddTimeEvent(0, 4, 18, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRBH2",
    level: "2",
    amount: 10,
    dropType: "wall",
    wallDir: 180,
    spacing: 40,
    dropDistance: 300,
    warnRadius: 50,
    warnTime: 90
});
AddTimeEvent(0, 4, 30, "ChangeSpawnRate", function()
{
    AddMobChoice("FububirdH", 2, 2);
    RemoveMobChoice("KoronesukiH");
    RemoveMobChoice("OnigiriyaH");
    enemyLimit = 200;
    spawnRate = 70;
    spawnAmount = 5;
});
AddTimeEvent(0, 4, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 4, 49, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 4, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 0,
    amount: 8,
    spacing: 100,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        HP: 100,
        ATK: 8
    }
});
AddTimeEvent(0, 4, 50, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdH",
    level: "1",
    dir: 180,
    amount: 8,
    spacing: 100,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 100,
        ATK: 8
    }
});
AddTimeEvent(0, 4, 55, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
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
AddTimeEvent(0, 4, 58, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 5, 0, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "horizontalSurround",
    chance: 20
});
AddTimeEvent(0, 5, 5, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHordeH",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 40
});
AddTimeEvent(0, 5, 7, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHordeH",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 40
});
AddTimeEvent(0, 5, 9, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHordeH",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 40
});
AddTimeEvent(0, 5, 11, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHordeH",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 40
});
AddTimeEvent(0, 5, 25, "ChangeSpawnRate", function()
{
    AddMobChoice("SukonbuH", 2, 2);
    enemyLimit = 300;
    spawnRate = 180;
    spawnAmount = 3;
});
AddTimeEvent(0, 5, 29, "SetPosition", EventLockPosition);
DropInBox("KoronesukiH", [0, 5, 30], 
{
    lifeTime: 900,
    expvalue: 8,
    SPD: 0.05,
    HP: 1500,
    lockFacing: false,
    knockbackImmune: true,
    tangible: false
}, 20, 35, 250, 30, 60, "1", true);
AddTimeEvent(0, 5, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SukonbuH",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 60
});
AddTimeEvent(0, 5, 41, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SukonbuH",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 60
});
AddTimeEvent(0, 5, 42, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SukonbuH",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 60
});
AddTimeEvent(0, 5, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    offsetX: 35,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false
    }
});
AddTimeEvent(0, 5, 45, "ChangeSpawnRate", function()
{
    AddMobChoice("SukonbuH", 2, 2);
    enemyLimit = 300;
    spawnRate = 130;
    spawnAmount = 7;
});
AddTimeEvent(0, 5, 45, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false
    }
});
AddTimeEvent(0, 6, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 4;
    RemoveMobChoice("FububirdH");
    AddMobChoice("MiofaH", 2, 2);
});
AddTimeEvent(0, 6, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "KoronesukiMiniBossH",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 6, 0, "EventSpawnDirection2", EventSpawnDirection, 
{
    id: "OnigiriyaMiniBossH",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 6, 0, "EventSpawnDirection3", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "2",
    dir: "horizontalSurround",
    amount: 2
});
CallAlert("horizontal", [0, 6, 44]);
AddTimeEvent(0, 6, 44, "SetPosition", EventStagePosition);
for (var i = 0; i < 6; i++)
{
    AddTimeEvent(0, 6, 45 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "OnigiriyaH",
        level: "1",
        speed: 3,
        dir: 0,
        dirMoving: 180,
        amount: 12,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 1500,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 6, 45 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "KoronesukiH",
        level: "1",
        speed: 3,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        offset: 35,
        spacing: 70,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 1500,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 7, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 6;
    RemoveMobChoice("SukonbuH");
    RemoveMobChoice("MiofaH");
    AddMobChoice("FububirdH", 2, 2);
    currentSpawnPattern = "evenSurround";
});
AddTimeEvent(0, 8, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 90;
    spawnAmount = 4;
    RemoveMobChoice("FububirdH");
    AddMobChoice("KoronesukiH", 1, 2);
    AddMobChoice("OnigiriyaH", 1, 2);
    currentSpawnPattern = "horizontalSurround";
});
AddTimeEvent(0, 8, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "OruyankeMiniBoss",
    level: "2",
    amount: 1,
    dropType: "random",
    warnRadius: 20,
    warnTime: 90
});
CallAlert("vertical", [0, 8, 44]);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 8, 45 + i, "EventSpawnHordeA", EventSpawnHorde, 
    {
        id: "FububirdHordeH",
        level: "1",
        dir: ParseSpawnDirection(30 + irandom(120), "verticalSurround"),
        amount: 30
    });
    AddTimeEvent(0, 8, 45 + i, "EventSpawnHordeB", EventSpawnHorde, 
    {
        id: "FububirdHordeH",
        level: "1",
        dir: ParseSpawnDirection(210 + irandom(120), "verticalSurround"),
        amount: 30
    });
}
AddTimeEvent(0, 8, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 90;
    spawnAmount = 7;
    currentSpawnPattern = "horizontalSurround";
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
AddTimeEvent(0, 9, 4, "ChangeSpawnRate", function()
{
    enabledSpawner = false;
});
DropInBoxInstant("35PH", [0, 9, 10], 
{
    lifeTime: 480,
    expvalue: 6,
    SPD: 0.01,
    HP: 3000,
    lockFacing: false,
    knockbackImmune: true,
    sprite_index: spr_35p_shielded,
    tangible: false
}, 20, 30, 150, 30, 60, "1");
AddTimeEvent(0, 9, 11, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    offsetX: 35,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false
    }
});
AddTimeEvent(0, 9, 13, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 180,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false
    }
});
AddTimeEvent(0, 9, 15, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    offsetX: 35,
    spawnOverride: 
    {
        direction: 90,
        SPD: 25,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 9, 15, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    spawnOverride: 
    {
        direction: 180,
        ignoreWalls: true,
        SPD: 25,
        lockFacing: false,
        knockbackImmune: true,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 9, 16, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "MiteiruH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 120
});
AddTimeEvent(0, 9, 18, "ChangeSpawnRate", function()
{
    enabledSpawner = true;
});
CallAlert("right", [0, 9, 24]);
for (var i = 0; i < 10; i++)
{
    AddTimeEvent(0, 9, 25 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "35PH",
        level: "1",
        speed: 3,
        dir: 0,
        dirMoving: 180,
        amount: 14,
        spacing: 70,
        spawnOverride: 
        {
            sprite_index: spr_35p_shielded,
            lifeTime: 1200,
            expvalue: 8,
            HP: 700,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 9, 25 + i, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "35PDasherH",
        level: "1",
        dir: "horizontalSurround",
        amount: 1
    });
}
AddTimeEvent(0, 10, 0, "EventSpawnDropIn1", EventSpawnDropIn, 
{
    id: "AChanBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 10, 0, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "MikodanyeH",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 3;
    AddMobChoice("35PH", 1, 1);
    RemoveMobChoice("OnigiriyaH");
    RemoveMobChoice("KoronesukiH");
});
AddTimeEvent(0, 10, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "35PDasherH",
    level: "1",
    dir: "horizontalSurround",
    amount: 5
});
AddTimeEvent(0, 11, 14, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 11, 14, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 11, 15 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "FububirdH",
        level: "1",
        dir: 0,
        amount: 8,
        spacing: 100,
        spawnOverride: 
        {
            direction: 180,
            lockFacing: false,
            HP: 4000,
            ATK: 20
        }
    });
    AddTimeEvent(0, 11, 15 + i, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "FububirdH",
        level: "1",
        dir: 180,
        amount: 8,
        spacing: 100,
        spawnOverride: 
        {
            direction: 0,
            lockFacing: false,
            HP: 4000,
            ATK: 20
        }
    });
}
AddTimeEvent(0, 11, 12, "EventSpawnWall1", EventSpawnWall, 
{
    id: "35PH",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 270,
        SPD: 25,
        ignoreWalls: true,
        knockbackImmune: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }
});
AddTimeEvent(0, 11, 14, "EventSpawnWall1", EventSpawnWall, 
{
    id: "35PH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 180,
        ignoreWalls: true,
        SPD: 25,
        knockbackImmune: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }
});
AddTimeEvent(0, 11, 30, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "ATKOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 11, 40, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "SPDOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 12, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 7;
    AddMobChoice("SoratomoH", 1, 1);
    RemoveMobChoice("35PH");
});
AddTimeEvent(0, 12, 0, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "SoratomoMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 20,
    warnTime: 120
});
AddTimeEvent(0, 12, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "HealerOtaku",
    level: "2",
    dir: "horizontalSurround",
    amount: 2
});
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 12, 14 + i, "SetPosition", EventStagePosition, {});
    AddTimeEvent(0, 12, 15 + i, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "SoratomoDasherH",
        level: "1",
        amount: 5,
        dropType: "wall",
        spacing: 80,
        wallDir: 90,
        dropDistance: 100,
        warnRadius: 30,
        warnTime: 30,
        setPosition: true
    });
    AddTimeEvent(0, 12, 15 + i, "EventSpawnDropInB", EventSpawnDropIn, 
    {
        id: "SoratomoDasherH",
        level: "1",
        amount: 5,
        dropType: "wall",
        spacing: 80,
        wallDir: 270,
        dropDistance: 100,
        warnRadius: 30,
        warnTime: 30,
        setPosition: true
    });
}
AddTimeEvent(0, 12, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 12, 33, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 12, 30, "EventSpawnWall1", EventSpawnWall, 
{
    id: "SoratomoH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    spawnOverride: 
    {
        direction: 180,
        ignoreWalls: true,
        SPD: 25,
        knockbackImmune: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
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
AddTimeEvent(0, 12, 34, "EventSpawnWall1", EventSpawnWall, 
{
    id: "SoratomoH",
    level: "1",
    dir: 180,
    amount: 15,
    spacing: 70,
    offsetY: 35,
    spawnOverride: 
    {
        direction: 0,
        ignoreWalls: true,
        SPD: 25,
        knockbackImmune: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
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
AddTimeEvent(0, 12, 45, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 110;
    spawnAmount = 5;
    RemoveMobChoice("SoratomoH");
    AddMobChoice("PioneersH", 2, 1);
});
AddTimeEvent(0, 12, 55, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 180;
    spawnAmount = 2;
});
CallAlert("horizontal", [0, 12, 59]);
AddTimeEvent(0, 13, 0, "SetPosition", EventLockPosition);
for (var i = 0; i < 6; i++)
{
    AddTimeEvent(0, 13, 0 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "PioneersH",
        level: "1",
        speed: 3,
        dir: 0,
        dirMoving: 180,
        amount: 15,
        spacing: 90,
        lockY: true,
        offset: 45 * ((i % 2) == 0),
        spawnOverride: 
        {
            sprite_index: spr_Pioneers,
            lifeTime: 1200,
            expvalue: 8,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 13, 0 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "PioneersH",
        level: "1",
        speed: 3,
        dir: 180,
        dirMoving: 0,
        amount: 15,
        spacing: 90,
        lockY: true,
        offset: 45 * ((i % 2) > 0),
        spawnOverride: 
        {
            sprite_index: spr_Pioneers,
            lifeTime: 1200,
            expvalue: 8,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 13, 2, "EventSpawnWall1", EventSpawnWall, 
{
    id: "PioneersH",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 270,
        SPD: 25,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }
});
AddTimeEvent(0, 13, 4, "EventSpawnWall1", EventSpawnWall, 
{
    id: "PioneersH",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 90,
        SPD: 25,
        ignoreWalls: true,
        knockbackImmune: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }
});
AddTimeEvent(0, 13, 6, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "3",
    amount: 1,
    dropType: "random",
    wallDir: 0,
    dropDistance: 0,
    warnRadius: 60,
    warnTime: 80
});
AddTimeEvent(0, 13, 6, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 70;
    spawnAmount = 12;
    RemoveMobChoice("PioneersH");
    AddMobChoice("PioneersH", 5, 2);
});
AddTimeEvent(0, 13, 15, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "3",
    amount: 1,
    dropType: "random",
    wallDir: 0,
    dropDistance: 0,
    warnRadius: 30,
    warnTime: 80
});
AddTimeEvent(0, 13, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 100;
    spawnAmount = 6;
});
AddTimeEvent(0, 13, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "PioneersDasherH",
    level: "1",
    amount: 3,
    dropType: "random",
    wallDir: 0,
    dropDistance: 100,
    warnRadius: 30,
    warnTime: 70
});
AddTimeEvent(0, 13, 42, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "PioneersDasherH",
    level: "1",
    amount: 6,
    dropType: "random",
    wallDir: 0,
    dropDistance: 150,
    warnRadius: 30,
    warnTime: 70
});
AddTimeEvent(0, 13, 44, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "PioneersDasherH",
    level: "1",
    amount: 9,
    dropType: "random",
    wallDir: 0,
    dropDistance: 200,
    warnRadius: 30,
    warnTime: 70
});
AddTimeEvent(0, 14, 0, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "PioneersMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 40,
    warnTime: 120
});
AddTimeEvent(0, 14, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SPDOtaku",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 14, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 7;
    RemoveMobChoice("PioneersH");
    AddMobChoice("HoshiyomiH", 2, 1);
});
AddTimeEvent(0, 14, 25, "ChangeSpawnRate", function()
{
    enabledSpawner = false;
});
DropInBoxInstant("HoshiyomiH", [0, 14, 30], 
{
    lifeTime: 1200,
    expvalue: 8,
    SPD: 0.05,
    HP: 2000,
    lockFacing: false,
    knockbackImmune: true,
    tangible: false
}, 20, 30, 300, 30, 60, "1");
CallAlert("horizontal", [0, 14, 31]);
AddTimeEvent(0, 14, 31, "SetPosition", EventStagePosition);
for (var i = 0; i < 7; i++)
{
    AddTimeEvent(0, 14, 32 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "HoshiyomiH",
        level: "1",
        speed: 3,
        dir: 45,
        dirMoving: 225,
        amount: 15,
        spacing: 80,
        offset: (i % 2) * 35,
        ignoreWallSpawn: true,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 600,
            ATK: 16,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
for (var i = 0; i < 7; i++)
{
    AddTimeEvent(0, 14, 32 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "HoshiyomiH",
        level: "1",
        speed: 3,
        dir: 135,
        dirMoving: 315,
        amount: 15,
        offset: (i % 2) * 35,
        spacing: 80,
        ignoreWallSpawn: true,
        setPosition: true,
        spawnOverride: 
        {
            lifeTime: 600,
            ATK: 16,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
AddTimeEvent(0, 14, 55, "ChangeSpawnRate", function()
{
    enabledSpawner = true;
});
CallAlert("right", [0, 14, 44]);
AddTimeEvent(0, 14, 45, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "HoshiyomiHordeH",
    level: "1",
    dir: ParseSpawnDirection(45 - irandom(90), "horizontalSurround"),
    amount: 20
});
CallAlert("left", [0, 14, 46]);
AddTimeEvent(0, 14, 47, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "HoshiyomiHordeH",
    level: "1",
    dir: ParseSpawnDirection(135 + irandom(90), "horizontalSurround"),
    amount: 20
});
CallAlert("right", [0, 14, 48]);
AddTimeEvent(0, 14, 49, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "HoshiyomiHordeH",
    level: "1",
    dir: ParseSpawnDirection(45 - irandom(90), "horizontalSurround"),
    amount: 20
});
CallAlert("left", [0, 14, 50]);
AddTimeEvent(0, 14, 51, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "HoshiyomiHordeH",
    level: "1",
    dir: ParseSpawnDirection(135 + irandom(90), "horizontalSurround"),
    amount: 20
});
CallAlert("vertical", [0, 14, 52]);
AddTimeEvent(0, 14, 53, "EventSpawnWall1", EventSpawnWall, 
{
    id: "HoshiyomiWave",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        HP: 6000,
        ATK: 15,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
AddTimeEvent(0, 14, 53, "EventSpawnWall2", EventSpawnWall, 
{
    id: "HoshiyomiWave",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 70,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        HP: 6000,
        ATK: 15,
        knockbackImmune: true,
        ignoreWalls: true
    }
});
CallAlert("all", [0, 14, 59]);
for (var i = 0; i < 8; i++)
{
    AddTimeEvent(0, 15, 0, "EventSpawnHorde" + string(i), EventSpawnHorde, 
    {
        id: "HoshiyomiHordeH",
        level: "1",
        dir: ParseSpawnDirection(i * 45, "evenSurround"),
        amount: 8
    });
}
AddTimeEvent(0, 15, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SPDOtaku",
    level: "2",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 15, 1, "EventSpawnWall1", EventSpawnWall, 
{
    id: "PioneersDasherH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 80,
    spawnOverride: 
    {
        direction: 180,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }
});
AddTimeEvent(0, 15, 1, "EventSpawnWall2", EventSpawnWall, 
{
    id: "PioneersDasherH",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 80,
    spawnOverride: 
    {
        direction: 270,
        ignoreWalls: true,
        lockFacing: false,
        knockbackImmune: true,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 90
                }
            }
        }
    }
});
AddTimeEvent(0, 15, 15, "GoldenYagoo", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "evenSurround",
    chance: 20
});
AddTimeEvent(0, 15, 10, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 110;
    spawnAmount = 3;
    RemoveMobChoice("PioneersH");
    AddMobChoice("HoshiyomiH", 2, 1);
});
CallAlert("down", [0, 15, 19]);
CallAlert("left", [0, 15, 20]);
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 15, 21 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "HoshiyomiWave",
        level: "1",
        dir: 180,
        amount: 15,
        spacing: 80,
        spawnOverride: 
        {
            direction: 0,
            lockFacing: false,
            HP: 2000,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
    AddTimeEvent(0, 15, 20 + i, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "HoshiyomiWave",
        level: "1",
        dir: 270,
        amount: 15,
        spacing: 80,
        spawnOverride: 
        {
            direction: 90,
            lockFacing: false,
            HP: 2000,
            knockbackImmune: true,
            ignoreWalls: true
        }
    });
}
AddTimeEvent(0, 15, 28, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Oruyanke",
    level: "3",
    amount: 1,
    dropType: "random",
    warnRadius: 30,
    warnTime: 80
});
AddTimeEvent(0, 15, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 60;
    spawnAmount = 7;
});
AddTimeEvent(0, 15, 50, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 90;
    spawnAmount = 6;
});
AddTimeEvent(0, 16, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "HoshiyomiMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 30,
    warnTime: 90
});
AddTimeEvent(0, 16, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 80;
    spawnAmount = 5;
    RemoveMobChoice("HoshiyomiH");
    AddMobChoice("RobosaH", 2, 1);
});
AddTimeEvent(0, 16, 30, "EventSpawnDropIn1", EventSpawnDropIn, 
{
    id: "HealerOtaku",
    level: "3",
    amount: 1,
    dropType: "random",
    dropDistance: 30,
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 16, 20, "EventSpawnDropIn1", EventSpawnDropIn, 
{
    id: "ATKOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 30,
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 16, 20, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "SPDOtaku",
    level: "1",
    amount: 1,
    dropType: "random",
    dropDistance: 30,
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 16, 50, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 180;
    spawnAmount = 2;
});
CallAlert("horizontal", [0, 16, 59]);
AddTimeEvent(0, 17, 0, "EventSpawnDropIn1", EventSpawnDropIn, 
{
    id: "RobosaShooterH",
    level: "1",
    amount: 25,
    dropType: "wall",
    dropDistance: 250,
    wallDir: 0,
    warnRadius: 50,
    spacing: 30,
    warnTime: 120,
    spawnOverride: 
    {
        SPD: 0,
        lifeTime: 700,
        HP: 5000,
        knockbackImmune: true,
        tangible: false
    }
});
AddTimeEvent(0, 16, 55, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SPDOtaku",
    level: "2",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 17, 0, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "RobosaShooterH",
    level: "1",
    amount: 25,
    dropType: "wall",
    wallDir: 180,
    dropDistance: 250,
    spacing: 30,
    warnRadius: 50,
    warnTime: 120,
    spawnOverride: 
    {
        SPD: 0,
        lifeTime: 700,
        HP: 5000,
        knockbackImmune: true,
        tangible: false
    }
});
AddTimeEvent(0, 17, 3, "EventSpawnWall1", EventSpawnWall, 
{
    id: "HoshiyomiH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 80,
    offsetY: 40,
    spawnOverride: 
    {
        direction: 180,
        image_xscale: 1,
        image_yscale: 1,
        SPD: 25,
        ignoreWalls: true,
        knockbackImmune: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
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
AddTimeEvent(0, 17, 4, "EventSpawnWall2", EventSpawnWall, 
{
    id: "HoshiyomiH",
    level: "1",
    dir: 180,
    amount: 15,
    spacing: 80,
    offsetY: 40,
    spawnOverride: 
    {
        direction: 0,
        image_xscale: 1,
        image_yscale: 1,
        lockFacing: false,
        ignoreWalls: true,
        SPD: 25,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
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
AddTimeEvent(0, 17, 6, "EventSpawnWall1", EventSpawnWall, 
{
    id: "HoshiyomiH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 80,
    offsetY: 40,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        image_xscale: 1,
        image_yscale: 1,
        ignoreWalls: true,
        SPD: 25,
        ignoreWalls: true,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
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
AddTimeEvent(0, 17, 6, "EventSpawnWall2", EventSpawnWall, 
{
    id: "HoshiyomiH",
    level: "1",
    dir: 90,
    amount: 15,
    spacing: 80,
    offset: 40,
    ignoreWallSpawn: true,
    spawnOverride: 
    {
        direction: 270,
        image_xscale: 1,
        image_yscale: 1,
        ignoreWalls: true,
        SPD: 25,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
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
CallAlert("all", [0, 17, 9]);
AddTimeEvent(0, 17, 10, "EventSpawnWall1", EventSpawnWall, 
{
    id: "HoshiyomiWave",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 60,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 1500,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 17, 10, "EventSpawnWall2", EventSpawnWall, 
{
    id: "HoshiyomiWave",
    level: "1",
    dir: 90,
    amount: 10,
    spacing: 60,
    ignoreWallSpawn: true,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        HP: 1500,
        SPD: 3,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 17, 10, "EventSpawnWall3", EventSpawnWall, 
{
    id: "HoshiyomiWave",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 60,
    offset: 40,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        HP: 3000,
        SPD: 3,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 17, 10, "EventSpawnWall4", EventSpawnWall, 
{
    id: "HoshiyomiWave",
    level: "1",
    dir: 270,
    amount: 10,
    spacing: 60,
    offset: 40,
    ignoreWallSpawn: true,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        HP: 3000,
        SPD: 3,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 17, 10, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 80;
    spawnAmount = 6;
});
if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
{
    AddTimeEvent(0, 17, 15, "SilverYagoo", EventSpawnDirection, 
    {
        id: "SilverYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 30
    });
}
AddTimeEvent(0, 17, 15, "ChangeSpawnRate", function()
{
    enemyLimit = 250;
    spawnRate = 90;
    spawnAmount = 7;
    AddMobChoice("RobosaShooterH", 1, 1);
});
AddTimeEvent(0, 17, 30, "ChangeSpawnRate", function()
{
    enabledSpawner = false;
});
AddTimeEvent(0, 17, 39, "SetPosition", EventStagePosition);
AddTimeEvent(0, 17, 40, "EventSpawnDropInGrid", EventSpawnDropInGrid, 
{
    id: "SSRBH3",
    altId: "SSRBH4",
    level: "1",
    amount: 5,
    dropType: "wall",
    spacing: 150,
    warnRadius: 25,
    warnTime: 150,
    setPosition: true
});
AddTimeEvent(0, 17, 39, "EventSpawnWallA", EventSpawnWall, 
{
    id: "35PH",
    level: "1",
    dir: 0,
    amount: 20,
    spacing: 40,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        image_xscale: 3,
        image_yscale: 3,
        HP: 9999,
        ATK: 50,
        SPD: 0,
        knockbackImmune: true,
        tangible: false,
        lifeTime: 600
    }
});
AddTimeEvent(0, 17, 39, "EventSpawnWallB", EventSpawnWall, 
{
    id: "35PH",
    level: "1",
    dir: 180,
    amount: 20,
    spacing: 40,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        image_xscale: 3,
        image_yscale: 3,
        HP: 9999,
        ATK: 30,
        SPD: 0,
        knockbackImmune: true,
        tangible: false,
        lifeTime: 600
    }
});
AddTimeEvent(0, 17, 50, "ChangeSpawnRate", function()
{
    enabledSpawner = true;
});
AddTimeEvent(0, 18, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "RobosaMiniBossH",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 30,
    warnTime: 90
});
AddTimeEvent(0, 18, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "ATKOtaku",
    level: "2",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 18, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 120;
    spawnAmount = 5;
    AddMobChoice("35PH", 2, 3);
    AddMobChoice("SoratomoH", 2, 2);
    AddMobChoice("HoshiyomiH", 2, 2);
    AddMobChoice("PioneersH", 2, 3);
});
AddTimeEvent(0, 18, 45, "ChangeSpawnRate", function()
{
    enemyLimit = 150;
    spawnRate = 70;
    spawnAmount = 8;
    RemoveMobChoice("35PH");
    RemoveMobChoice("PioneersH");
    RemoveMobChoice("HoshiyomiH");
    RemoveMobChoice("SoratomoH");
    RemoveMobChoice("RobosaH");
    RemoveMobChoice("RobosaShooterH");
    AddMobChoice("HoloStaffH", 7, 1);
    AddMobChoice("PioneersDasherH", 1, 1);
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 19, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 0;
    spawnRate = 15;
    enabledSpawner = false;
    spawnAmount = -100;
    RemoveMobChoice("HoloStaffH");
    RemoveMobChoice("PioneersDasherH");
    currentSpawnPattern = "evenSurround";
    with (obj_Enemy)
    {
        if (!isBoss && isEnemy)
        {
            Die(true);
        }
    }
});
CallAlert("horizontal", [0, 19, 31]);
for (var i = 0; i < 10; i++)
{
    AddTimeEvent(0, 19, 32 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "FububirdH",
        level: "1",
        dir: 0,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            direction: 180,
            HP: 10000,
            lockFacing: false
        }
    });
    AddTimeEvent(0, 19, 32 + i, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "FububirdH",
        level: "1",
        dir: 180,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            direction: 0,
            HP: 10000,
            lockFacing: false
        }
    });
}
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 19, 37 + i, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "PioneersDasherH",
        level: "1",
        dir: "stage2_leftSurround",
        amount: 1
    });
    AddTimeEvent(0, 19, 37 + i, "EventSpawnDirection2", EventSpawnDirection, 
    {
        id: "PioneersDasherH",
        level: "1",
        dir: "stage2_rightSurround",
        amount: 1
    });
}
AddTimeEvent(0, 19, 41, "SetPosition", EventStagePosition);
AddTimeEvent(0, 19, 42, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    ignoreWallSpawn: true,
    offsetX: 35,
    setPosition: true,
    spawnOverride: 
    {
        ATK: 25,
        direction: 90,
        HP: 30000,
        SPD: 25,
        ignoreWalls: true,
        tangible: false,
        lockFacing: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            chargeStraight: 
            {
                config: 
                {
                    waitTime: 1,
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 43, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 90,
    amount: 15,
    ignoreWallSpawn: true,
    spacing: 70,
    setPosition: true,
    spawnOverride: 
    {
        ATK: 25,
        direction: 270,
        HP: 30000,
        SPD: 25,
        ignoreWalls: true,
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
                    warnTime: 120
                }
            }
        }
    }
});
AddTimeEvent(0, 19, 44, "EventSpawnWall1", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 0,
    amount: 15,
    spacing: 70,
    ignoreWallSpawn: true,
    setPosition: true,
    spawnOverride: 
    {
        ATK: 25,
        direction: 180,
        HP: 30000,
        SPD: 25,
        ignoreWalls: true,
        tangible: false,
        lockFacing: false,
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
AddTimeEvent(0, 19, 45, "EventSpawnWall2", EventSpawnWall, 
{
    id: "FububirdDasherH",
    level: "1",
    dir: 270,
    amount: 15,
    spacing: 70,
    ignoreWallSpawn: true,
    setPosition: true,
    spawnOverride: 
    {
        ATK: 25,
        HP: 30000,
        direction: 90,
        SPD: 25,
        ignoreWalls: true,
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
AddTimeEvent(0, 19, 45, "SetPosition", EventStagePosition);
AddTimeEvent(0, 19, 46, "EventSpawnDropInGrid", EventSpawnDropInGrid, 
{
    id: "SSRBH4",
    altId: "SSRBH4",
    level: "1",
    amount: 5,
    dropType: "wall",
    spacing: 150,
    warnRadius: 75,
    warnTime: 150,
    setPosition: true,
    spawnOverride: 
    {
        image_xscale: 1,
        image_yscale: 1,
        lifeTime: 1
    }
});
AddTimeEvent(0, 19, 46, "SetPosition", EventStagePosition);
AddTimeEvent(0, 19, 47, "EventSpawnDropIn1", EventSpawnDropIn, 
{
    id: "RobosaShooterH",
    level: "1",
    amount: 15,
    wallDir: 180,
    dropType: "wall",
    dropDistance: 250,
    warnRadius: 50,
    spacing: 50,
    setPosition: true,
    warnTime: 60,
    spawnOverride: 
    {
        SPD: 0,
        lifeTime: 360,
        image_xscale: 2,
        image_yscale: 2,
        invincible: true,
        invincibilityTimer: 600,
        HP: 10000,
        knockbackImmune: true,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackRapid: obj_MobManager.behaviours.projectileAttackRapid,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }
});
AddTimeEvent(0, 19, 47, "EventSpawnDropIn2", EventSpawnDropIn, 
{
    id: "RobosaShooterH",
    level: "1",
    amount: 15,
    wallDir: 0,
    dropType: "wall",
    dropDistance: 250,
    warnRadius: 50,
    spacing: 50,
    setPosition: true,
    warnTime: 60,
    spawnOverride: 
    {
        SPD: 0,
        lifeTime: 360,
        image_xscale: 2,
        image_yscale: 2,
        invincible: true,
        invincibilityTimer: 600,
        HP: 10000,
        knockbackImmune: true,
        tangible: false,
        behaviours: 
        {
            collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
            projectileAttackRapid: obj_MobManager.behaviours.projectileAttackRapid,
            followPlayer: obj_MobManager.behaviours.followPlayer
        }
    }
});
AddTimeEvent(0, 19, 53, "SetPosition", EventStagePosition);
AddTimeEvent(0, 19, 54, "EventSequenceSpawn", EventSequenceSpawn, 
{
    id: "PioneersDasherH",
    level: "1",
    amount: 50,
    dropType: "surround",
    warnRadius: 30,
    dropDistance: 300,
    warnTime: 60,
    setPosition: true,
    sequenceTime: 2,
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
AddTimeEvent(0, 20, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 180;
    spawnAmount = 4;
    enabledSpawner = true;
    AddMobChoice("HoloStaffH", 1, 2);
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
    id: "NodokaBoss",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 200,
    warnTime: 150
});
AddTimeEvent(0, 21, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 120;
    spawnAmount = 7;
});
AddTimeEvent(0, 23, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 200;
    spawnRate = 80;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
    RemoveMobChoice("HoloStaffH");
    AddMobChoice("SukonbuH", 3, 3);
    AddMobChoice("PioneersDasherH", 1, 1);
    AddMobChoice("MiofaH", 3, 3);
    AddMobChoice("OnigiriyaH", 3, 3);
    AddMobChoice("KoronesukiH", 3, 3);
    AddMobChoice("SSRBH2", 1, 8);
    AddMobChoice("35PH", 3, 4);
    AddMobChoice("SoratomoH", 3, 3);
    AddMobChoice("PioneersH", 3, 4);
    AddMobChoice("HoshiyomiH", 3, 3);
    AddMobChoice("RobosaH", 3, 2);
    AddMobChoice("RobosaShooterH", 2, 2);
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
    RemoveMobChoice("SukonbuH");
    RemoveMobChoice("MiofaH");
    RemoveMobChoice("OnigiriyaH");
    RemoveMobChoice("KoronesukiH");
    RemoveMobChoice("SSRBH2");
    RemoveMobChoice("PioneersDasherH");
    RemoveMobChoice("35PH");
    RemoveMobChoice("SoratomoH");
    RemoveMobChoice("PioneersH");
    RemoveMobChoice("HoshiyomiH");
    RemoveMobChoice("RobosaH");
    RemoveMobChoice("RobosaShooterH");
    AddMobChoice("Yagoos", 1, 1);
});
