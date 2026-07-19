global.topBorder = 920;
global.bottomBorder = 1405;
global.leftBorder = -1;
global.rightBorder = -1;
global.wrappingStage = true;
AddTimeEvent(0, 0, 0, "ChangeSpawnPattern", ChangeSpawnPattern, 
{
    id: "stage2_evenSurround"
});
AddTimeEvent(0, 0, 0, "ChangeSpawnPattern", ChangeSpawnPattern, 
{
    id: "stage2_evenSurround"
});
AddTimeEvent(0, 0, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 100;
    spawnAmount = 3;
    AddMobChoice("Sukonbu", 1, 1);
});
AddTimeEvent(0, 0, 10, "EventSpawnClumpedDirection", EventSpawnClumpedDirection, 
{
    id: "Sukonbu",
    level: "1",
    dir: 180,
    size: 10,
    amount: 10
});
AddTimeEvent(0, 0, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 120;
    spawnAmount = 4;
    AddMobChoice("Miofa", 3, 1);
});
AddTimeEvent(0, 0, 45, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Sukonbu",
    level: "1",
    dir: "evenSurround",
    amount: 30,
    canReduce: true
});
AddTimeEvent(0, 1, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SSRB",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 1, 5, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SSRB",
    level: "1",
    dir: "horizontalSurround",
    amount: 4,
    canReduce: true
});
AddTimeEvent(0, 1, 14, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 1, 15, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Sukonbu",
    level: "1",
    speed: 1,
    dir: 0,
    dirMoving: 180,
    amount: 40,
    spacing: 20,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 8,
        HP: 50,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 1, 30, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Onigiriya",
    level: "1",
    speed: 0.2,
    dir: 0,
    dirMoving: 180,
    amount: 30,
    spacing: 30,
    spawnOverride: 
    {
        lifeTime: 900,
        expvalue: 5,
        HP: 300,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 1, 30, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Koronesuki",
    level: "1",
    speed: 0.2,
    dir: 180,
    dirMoving: 0,
    amount: 30,
    spacing: 30,
    spawnOverride: 
    {
        lifeTime: 900,
        expvalue: 5,
        HP: 300,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 2, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 80;
    spawnAmount = 5;
});
AddTimeEvent(0, 2, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SukonbuMiniBoss",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 2, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 100;
    spawnRate = 100;
    spawnAmount = 6;
    RemoveMobChoice("Sukonbu");
    RemoveMobChoice("Miofa");
    AddMobChoice("Onigiriya", 1, 1);
    AddMobChoice("Koronesuki", 1, 1);
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
AddTimeEvent(0, 3, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Koronesuki",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 60,
    warnTime: 150
});
AddTimeEvent(0, 3, 10, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Onigiriya",
    level: "1",
    amount: 5,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 50,
    warnTime: 150
});
AddTimeEvent(0, 3, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 5,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 50,
    warnTime: 150
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
    id: "Miofa",
    level: "1",
    speed: 3,
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
AddTimeEvent(0, 3, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Miofa",
    level: "1",
    speed: 3,
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
        HP: 600,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 4, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "MiofaMiniBoss",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 4, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 4, 54, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 4, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 0,
    amount: 7,
    spacing: 100,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        HP: 100,
        ATK: 8
    }
});
AddTimeEvent(0, 4, 55, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 180,
    amount: 7,
    spacing: 100,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 100,
        ATK: 8
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
AddTimeEvent(0, 5, 15, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 50
});
AddTimeEvent(0, 5, 17, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 50
});
AddTimeEvent(0, 5, 19, "EventSpawnHorde", EventSpawnHorde, 
{
    id: "FububirdHorde",
    level: "1",
    dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
    amount: 50
});
AddTimeEvent(0, 5, 30, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Sukonbu",
    level: "1",
    amount: 10,
    dropType: "surround",
    dropDistance: 120,
    warnRadius: 30,
    warnTime: 90
});
AddTimeEvent(0, 5, 31, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Sukonbu",
    level: "1",
    amount: 15,
    dropType: "surround",
    dropDistance: 170,
    warnRadius: 30,
    warnTime: 90
});
AddTimeEvent(0, 5, 32, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Sukonbu",
    level: "1",
    amount: 20,
    dropType: "surround",
    dropDistance: 220,
    warnRadius: 30,
    warnTime: 90
});
AddTimeEvent(0, 5, 45, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 6;
    RemoveMobChoice("Koronesuki");
    RemoveMobChoice("Onigiriya");
    AddMobChoice("Fububird", 2, 2);
});
AddTimeEvent(0, 5, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 5, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Miofa",
    level: "1",
    speed: 1,
    dir: 180,
    dirMoving: 0,
    amount: 20,
    spacing: 40,
    spawnOverride: 
    {
        sprite_index: spr_Miofa_A_Shielded,
        lifeTime: 1200,
        expvalue: 8,
        image_xscale: 2,
        image_yscale: 2,
        HP: 600,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 6, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 6;
    AddMobChoice("Sukonbu", 2, 2);
});
AddTimeEvent(0, 6, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "KoronesukiMiniBoss",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 6, 14, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 6, 14, "SetPosition", EventLockPosition);
for (var i = 0; i < 7; i++)
{
    AddTimeEvent(0, 6, 15 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Koronesuki",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 30,
        spacing: 80,
        offset: 40 * ((i % 2) > 0),
        spawnOverride: 
        {
            ATK: 6,
            lifeTime: 1200,
            expvalue: 8,
            HP: 500,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 6, 17, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 50,
    warnTime: 90
});
AddTimeEvent(0, 6, 20, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 50,
    warnTime: 90
});
AddTimeEvent(0, 6, 40, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "SSRB",
    level: "2",
    speed: 0.7,
    dir: 180,
    dirMoving: 0,
    amount: 30,
    spacing: 30,
    spawnOverride: 
    {
        ATK: 6,
        lifeTime: 1200,
        expvalue: 8,
        HP: 400,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 7, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Onigiriya",
    level: "2",
    amount: 10,
    dropType: "random",
    dropDistance: 100,
    warnRadius: 50,
    warnTime: 120
});
AddTimeEvent(0, 7, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 600;
    spawnRate = 100;
    spawnAmount = 6;
    AddMobChoice("Onigiriya", 2, 2);
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 7, 15 + i, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "FububirdHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "horizontalSurround"),
        amount: 60
    });
}
AddTimeEvent(0, 7, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 7, 29, "SetPosition", EventStagePosition, 
{
    xOffset: 200
});
for (var i = 0; i < 4; i++)
{
    var offf = irandom(4) * 30;
    AddTimeEvent(0, 7, 30 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Miofa",
        level: "1",
        speed: 1.75,
        dir: 0,
        dirMoving: 180,
        amount: 19,
        spacing: 20,
        setPosition: true,
        offset: 230 + offf,
        spawnOverride: 
        {
            sprite_index: spr_Miofa_A_Shielded,
            ATK: 8,
            lifeTime: 600,
            ignoreHalu: true,
            expvalue: 8,
            HP: 1000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 7, 30 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Miofa",
        level: "1",
        speed: 1.75,
        dir: 0,
        dirMoving: 180,
        amount: 19,
        spacing: 20,
        offset: -230 + offf,
        setPosition: true,
        spawnOverride: 
        {
            sprite_index: spr_Miofa_A_Shielded,
            ATK: 8,
            ignoreHalu: true,
            lifeTime: 600,
            expvalue: 8,
            HP: 1000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 7, 44, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 7, 44, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 7, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 0,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        HP: 200,
        ATK: 10
    }
});
AddTimeEvent(0, 7, 45, "EventSpawnWall2", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 90,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 200,
        ATK: 10
    }
});
AddTimeEvent(0, 7, 37, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 6;
});
AddTimeEvent(0, 8, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 120;
    spawnAmount = 5;
    RemoveMobChoice("Fububird");
    RemoveMobChoice("Sukonbu");
    AddMobChoice("Koronesuki", 1, 2);
});
AddTimeEvent(0, 8, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "OnigiriyaMiniBoss",
    level: "1",
    dir: "horizontalSurround",
    amount: 1
});
var randomEnemies = ["Sukonbu", "Miofa", "Koronesuki", "Onigiriya"];
for (var i = 0; i < 10; i++)
{
    var rand = irandom(3);
    AddTimeEvent(0, 8, 10 + i, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: randomEnemies[rand],
        level: "2",
        amount: 1,
        dropType: "random",
        dropDistance: 50,
        warnRadius: 75,
        warnTime: 90
    });
}
AddTimeEvent(0, 8, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 70;
    spawnAmount = 8;
    RemoveMobChoice("Onigiriya");
    RemoveMobChoice("Koronesuki");
    AddMobChoice("35P", 1, 1);
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
AddTimeEvent(0, 9, 0, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "35P",
    level: "1",
    amount: 15,
    dropType: "surround",
    dropDistance: 70,
    warnRadius: 30,
    warnTime: 120
});
AddTimeEvent(0, 9, 15, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "35P",
    level: "1",
    amount: 40,
    dropType: "surround",
    dropDistance: 250,
    warnRadius: 50,
    warnTime: 60,
    spawnOverride: 
    {
        sprite_index: spr_35p_shielded,
        ATK: 15,
        SPD: 0.1,
        lifeTime: 1200,
        expvalue: 8,
        HP: 500,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 9, 26, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 2;
});
for (var i = 0; i < 4; i++)
{
    AddTimeEvent(0, 9, 30, "EventSpawnDropIn" + string(i), EventSpawnDropIn, 
    {
        id: "35P",
        level: "1",
        amount: 40,
        dropType: "wall",
        wallDir: i * 90,
        spacing: 40,
        dropDistance: 200,
        warnRadius: 50,
        warnTime: 60,
        spawnOverride: 
        {
            sprite_index: spr_35p_shielded,
            ATK: 15,
            SPD: 0.1,
            lifeTime: 900,
            expvalue: 8,
            HP: 1000,
            lockFacing: false,
            tangible: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 9, 33, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 3,
    dropType: "random",
    dropDistance: 70,
    warnRadius: 60,
    warnTime: 90,
    spawnOverride: 
    {
        expvalue: 5,
        HP: 50,
        SPD: 0.1
    }
});
AddTimeEvent(0, 9, 36, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 3,
    dropType: "random",
    dropDistance: 100,
    warnRadius: 50,
    warnTime: 90,
    spawnOverride: 
    {
        expvalue: 5,
        HP: 50,
        SPD: 0.1
    }
});
AddTimeEvent(0, 9, 39, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "1",
    amount: 5,
    dropType: "random",
    dropDistance: 100,
    warnRadius: 60,
    warnTime: 90,
    spawnOverride: 
    {
        expvalue: 5,
        HP: 50,
        SPD: 0.1
    }
});
AddTimeEvent(0, 9, 42, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 6;
});
AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 150;
    spawnAmount = 4;
});
AddTimeEvent(0, 10, 0, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "Mikodanye",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 10, 30, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SSRB",
    level: "2",
    dir: "stage2_rightSurround",
    amount: 10,
    canReduce: true
});
AddTimeEvent(0, 11, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 7;
    AddMobChoice("Soratomo", 1, 1);
    RemoveMobChoice("35P");
});
for (var i = 0; i < 10; i++)
{
    AddTimeEvent(0, 11, 15 + i, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "Soratomo",
        level: "1",
        dir: 180,
        amount: 20,
        spacing: 40
    });
}
AddTimeEvent(0, 11, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 11, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 11, 30, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "35P",
    level: "1",
    speed: 2,
    dir: 0,
    dirMoving: 180,
    amount: 10,
    spacing: 30,
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
AddTimeEvent(0, 11, 30, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "35P",
    level: "1",
    speed: 2,
    dir: 180,
    dirMoving: 0,
    amount: 10,
    spacing: 30,
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
AddTimeEvent(0, 11, 45, "EventSpawnDropInA", EventSpawnDropIn, 
{
    id: "Soratomo",
    level: "1",
    amount: 30,
    spacing: 30,
    dropType: "wall",
    wallDir: 0,
    dropDistance: 200,
    warnRadius: 50,
    warnTime: 60,
    spawnOverride: 
    {
        SPD: 0.5
    }
});
AddTimeEvent(0, 11, 45, "EventSpawnDropInB", EventSpawnDropIn, 
{
    id: "Soratomo",
    level: "1",
    amount: 30,
    spacing: 30,
    dropType: "wall",
    wallDir: 180,
    dropDistance: 200,
    warnRadius: 50,
    warnTime: 60,
    spawnOverride: 
    {
        SPD: 0.5
    }
});
AddTimeEvent(0, 12, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 8;
    AddMobChoice("Pioneers", 2, 1);
});
AddTimeEvent(0, 12, 27, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 120;
    spawnAmount = 3;
});
AddTimeEvent(0, 12, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 12, 29, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 12, 30, "SetPosition", EventLockPosition);
for (var i = 0; i < 4; i++)
{
    AddTimeEvent(0, 12, 30 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Pioneers",
        level: "1",
        speed: 2,
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
            HP: 700,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 30 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Pioneers",
        level: "1",
        speed: 2,
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
            HP: 700,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 12, 31, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 8;
});
AddTimeEvent(0, 12, 45, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Pioneers",
    level: "1",
    amount: 8,
    dropType: "wall",
    spacing: 80,
    wallDir: 0,
    dropDistance: 0,
    warnRadius: 60,
    warnTime: 100
});
AddTimeEvent(0, 12, 46, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Pioneers",
    level: "1",
    amount: 8,
    dropType: "wall",
    spacing: 80,
    wallDir: 0,
    dropDistance: 0,
    warnRadius: 60,
    warnTime: 100
});
AddTimeEvent(0, 12, 47, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Pioneers",
    level: "1",
    amount: 8,
    dropType: "wall",
    spacing: 80,
    wallDir: 0,
    dropDistance: 0,
    warnRadius: 60,
    warnTime: 100
});
AddTimeEvent(0, 12, 48, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Pioneers",
    level: "1",
    amount: 8,
    dropType: "wall",
    spacing: 80,
    wallDir: 0,
    dropDistance: 0,
    warnRadius: 60,
    warnTime: 100
});
AddTimeEvent(0, 13, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 6;
    currentSpawnPattern = "stage2_leftSurround";
    RemoveMobChoice("Soratomo");
    AddMobChoice("Hoshiyomi", 1, 1);
});
for (var i = 0; i < 3; i++)
{
    AddTimeEvent(0, 13, 0 + (i * 2), "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "Hoshiyomi",
        level: "1",
        amount: 2,
        dropType: "random",
        dropDistance: 90,
        warnRadius: 40,
        warnTime: 150
    });
}
AddTimeEvent(0, 13, 30, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Hoshiyomi",
    level: "1",
    amount: 15,
    dropType: "wall",
    spacing: 50,
    wallDir: 90,
    dropDistance: 0,
    warnRadius: 35,
    warnTime: 100,
    spawnOverride: 
    {
        HP: 300
    }
});
AddTimeEvent(0, 13, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 8;
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 14, 0, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "SoratomoMiniBoss",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 14, 0, "EventSpawnDirectionB", EventSpawnDirection, 
{
    id: "PioneersMiniBoss",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 14, 20, "EventSpawnDirection", EventSpawnDirection, 
{
    id: "SSRB",
    level: "3",
    dir: "evenSurround",
    amount: 10,
    canReduce: true
});
AddTimeEvent(0, 14, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Hoshiyomi",
    level: "1",
    amount: 15,
    dropType: "random",
    dropDistance: 250,
    warnRadius: 30,
    warnTime: 120,
    spawnOverride: 
    {
        HP: 300
    }
});
AddTimeEvent(0, 15, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 120;
    spawnAmount = 7;
    RemoveMobChoice("Hoshiyomi");
    RemoveMobChoice("Pioneers");
    AddMobChoice("Robosa", 2, 1);
});
AddTimeEvent(0, 15, 0, "GoldenYagoo", EventSpawnDirection, 
{
    id: "GoldenYagoo",
    level: "1",
    amount: 1,
    dir: "evenSurround",
    chance: 20
});
AddTimeEvent(0, 15, 29, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
for (var i = 0; i < 5; i++)
{
    AddTimeEvent(0, 15, 30 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Robosa",
        level: "1",
        speed: 1,
        dir: 0,
        dirMoving: 180,
        amount: 20,
        spacing: 40,
        spawnOverride: 
        {
            lifeTime: 660,
            expvalue: 5,
            HP: 2500,
            lockFacing: false,
            knockbackImmune: true
        }
    });
}
AddTimeEvent(0, 15, 34, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 15, 35, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Fububird",
    level: "1",
    dir: 180,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 1500,
        ATK: 8,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 15, 37, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 15, 38, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Pioneers",
    level: "1",
    speed: 2,
    dir: 180,
    dirMoving: 0,
    amount: 25,
    spacing: 60,
    spawnOverride: 
    {
        lifeTime: 1200,
        expvalue: 5,
        HP: 1500,
        lockFacing: false,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 15, 40, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 15, 41, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "35P",
    level: "1",
    speed: 2,
    dir: 180,
    dirMoving: 0,
    amount: 6,
    spacing: 30,
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
AddTimeEvent(0, 15, 45, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "Hoshiyomi",
    level: "1",
    amount: 15,
    dropType: "wall",
    spacing: 50,
    wallDir: 180,
    dropDistance: 120,
    warnRadius: 40,
    warnTime: 120
});
AddTimeEvent(0, 15, 45, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 100;
    spawnAmount = 5;
});
AddTimeEvent(0, 16, 0, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "RobosaMiniBoss",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 16, 15, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "35P",
    level: "1",
    speed: 0.3,
    dir: 0,
    dirMoving: 180,
    amount: 23,
    spacing: 30,
    spawnOverride: 
    {
        sprite_index: spr_35p_shielded,
        lifeTime: 600,
        expvalue: 5,
        HP: 1000,
        lockFacing: false
    }
});
AddTimeEvent(0, 16, 15, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "35P",
    level: "1",
    speed: 0.3,
    dir: 180,
    dirMoving: 0,
    amount: 25,
    spacing: 30,
    spawnOverride: 
    {
        sprite_index: spr_35p_shielded,
        lifeTime: 600,
        expvalue: 5,
        HP: 1000,
        lockFacing: false
    }
});
AddTimeEvent(0, 16, 41, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 16, 42, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 90;
});
AddTimeEvent(0, 16, 43, "AlertC", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 16, 44, "AlertD", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 270;
});
AddTimeEvent(0, 16, 45, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Hoshiyomi",
    level: "3",
    dir: 180,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 0,
        lockFacing: false,
        HP: 1500,
        ATK: 15,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 16, 46, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Hoshiyomi",
    level: "3",
    dir: 90,
    amount: 10,
    spacing: 80,
    spawnOverride: 
    {
        direction: 270,
        lockFacing: false,
        HP: 1500,
        ATK: 15,
        SPD: 3,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 16, 47, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Hoshiyomi",
    level: "3",
    dir: 0,
    amount: 10,
    spacing: 80,
    offset: 40,
    spawnOverride: 
    {
        direction: 180,
        lockFacing: false,
        HP: 1500,
        ATK: 15,
        SPD: 3,
        knockbackImmune: true
    }
});
AddTimeEvent(0, 16, 48, "EventSpawnWall1", EventSpawnWall, 
{
    id: "Hoshiyomi",
    level: "3",
    dir: 270,
    amount: 10,
    spacing: 80,
    offset: 40,
    spawnOverride: 
    {
        direction: 90,
        lockFacing: false,
        HP: 1500,
        ATK: 15,
        SPD: 3,
        knockbackImmune: true
    }
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
AddTimeEvent(0, 17, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 90;
    spawnAmount = 9;
    AddMobChoice("35P", 1, 2);
    AddMobChoice("Pioneers", 1, 2);
    AddMobChoice("Hoshiyomi", 1, 1);
    AddMobChoice("Soratomo", 1, 2);
});
AddTimeEvent(0, 17, 30, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "35P",
    level: "1",
    amount: 50,
    dropType: "surround",
    dropDistance: 300,
    warnRadius: 60,
    warnTime: 90,
    spawnOverride: 
    {
        sprite_index: spr_35p_shielded,
        lifeTime: 510,
        expvalue: 5,
        ATK: 15,
        SPD: 0.1,
        HP: 3000,
        lockFacing: false,
        tangible: false
    }
});
AddTimeEvent(0, 17, 33, "AlertA", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 0;
});
AddTimeEvent(0, 17, 33, "AlertB", function()
{
    var alert = instance_create_depth(x, y, depth, obj_caution);
    alert.dir = 180;
});
AddTimeEvent(0, 17, 34, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
{
    id: "Hoshiyomi",
    level: "1",
    speed: 3,
    dir: 0,
    dirMoving: 180,
    amount: 20,
    spacing: 80,
    spawnOverride: 
    {
        lifeTime: 600,
        expvalue: 7,
        ATK: 15,
        HP: 3000,
        lockFacing: false
    }
});
AddTimeEvent(0, 17, 34, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
{
    id: "Hoshiyomi",
    level: "1",
    speed: 3,
    dir: 180,
    dirMoving: 0,
    amount: 20,
    spacing: 80,
    offset: 40,
    spawnOverride: 
    {
        lifeTime: 600,
        expvalue: 7,
        ATK: 15,
        HP: 3000,
        lockFacing: false
    }
});
AddTimeEvent(0, 17, 40, "EventSpawnDropIn", EventSpawnDropIn, 
{
    id: "SSRB",
    level: "3",
    amount: 5,
    dropType: "random",
    dropDistance: 50,
    warnRadius: 60,
    warnTime: 180
});
AddTimeEvent(0, 18, 0, "EventSpawnDirectionA", EventSpawnDirection, 
{
    id: "SSRBMiniBoss",
    dir: "horizontalSurround",
    amount: 1
});
AddTimeEvent(0, 18, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 120;
    spawnAmount = 4;
});
AddTimeEvent(0, 18, 30, "ChangeSpawnRate", function()
{
    enemyLimit = 500;
    spawnRate = 60;
    spawnAmount = 10;
    var roll = irandom(1);
    if (roll == 0)
    {
        currentSpawnPattern = "stage2_leftSurround";
    }
    else
    {
        currentSpawnPattern = "stage2_rightSurround";
    }
});
AddTimeEvent(0, 19, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 80;
    spawnAmount = 8;
    RemoveMobChoice("35P");
    RemoveMobChoice("Pioneers");
    RemoveMobChoice("Hoshiyomi");
    RemoveMobChoice("Soratomo");
    RemoveMobChoice("Robosa");
    AddMobChoice("HoloStaff", 1, 1);
    currentSpawnPattern = "stage2_evenSurround";
});
AddTimeEvent(0, 20, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 200;
    spawnAmount = 5;
    RemoveMobChoice("35P");
    RemoveMobChoice("Pioneers");
    RemoveMobChoice("Hoshiyomi");
    RemoveMobChoice("Soratomo");
    RemoveMobChoice("Robosa");
    RemoveMobChoice("HoloStaff");
    AddMobChoice("Soratomo", 1, 3);
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
    id: "AChanBoss",
    level: "1",
    amount: 1,
    dropType: "random",
    warnRadius: 200,
    warnTime: 300
});
AddTimeEvent(0, 21, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 120;
    spawnAmount = 10;
});
AddTimeEvent(0, 22, 0, "ChangeSpawnRate", function()
{
    enemyLimit = 300;
    spawnRate = 60;
    spawnAmount = 5;
    currentSpawnPattern = "stage2_evenSurround";
    RemoveMobChoice("Soratomo");
    AddMobChoice("Sukonbu", 1, 3);
    AddMobChoice("Miofa", 1, 3);
    AddMobChoice("Onigiriya", 1, 3);
    AddMobChoice("Koronesuki", 1, 3);
    AddMobChoice("SSRB", 1, 4);
    AddMobChoice("Fububird", 1, 4);
    AddMobChoice("35P", 1, 3);
    AddMobChoice("Soratomo", 1, 4);
    AddMobChoice("Pioneers", 1, 3);
    AddMobChoice("Hoshiyomi", 1, 4);
    AddMobChoice("Robosa", 1, 2);
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
    RemoveMobChoice("Sukonbu");
    RemoveMobChoice("Miofa");
    RemoveMobChoice("Onigiriya");
    RemoveMobChoice("Koronesuki");
    RemoveMobChoice("SSRB");
    RemoveMobChoice("Fububird");
    RemoveMobChoice("35P");
    RemoveMobChoice("Soratomo");
    RemoveMobChoice("Pioneers");
    RemoveMobChoice("Hoshiyomi");
    RemoveMobChoice("Robosa");
    AddMobChoice("Yagoos", 1, 1);
});
