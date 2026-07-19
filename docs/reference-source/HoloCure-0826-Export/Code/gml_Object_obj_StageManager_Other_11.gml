if (room == Room1 || room == Room1_debug)
{
    global.topBorder = -1;
    global.bottomBorder = -1;
    global.leftBorder = -1;
    global.rightBorder = -1;
    global.wrappingStage = true;
    AddTimeEvent(0, 0, 5, "EventSpawnClumpedDirection", EventSpawnClumpedDirection, 
    {
        id: "Shrimp",
        level: "1",
        dir: "0",
        amount: 15,
        size: 40
    });
    AddTimeEvent(0, 0, 8, "ChangeSpawnRate", function()
    {
        enemyLimit = 100;
        spawnRate = 150;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 0, 30, "NewMob", function()
    {
        AddMobChoice("Deadbeat", 1, 1);
        spawnRate = 130;
    });
    AddTimeEvent(0, 0, 45, "EventSpawnCircle", EventSpawnCircle, 
    {
        id: "Deadbeat",
        level: "1",
        amount: 15,
        dir: "evenSurround",
        canReduce: true
    });
    AddTimeEvent(0, 1, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 1, 5, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "1",
        dir: ParseSpawnDirection(0 + (irandom(1) * 180), "horizontalSurround"),
        amount: 30
    });
    AddTimeEvent(0, 1, 30, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "1",
        speed: 0.6,
        dir: 0,
        dirMoving: 180,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 500,
            expvalue: 4,
            HP: 120,
            ignoreHalu: true,
            sprite_index: spr_DeadbeatShielded,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 1, 30, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "1",
        speed: 0.6,
        dir: 180,
        dirMoving: 0,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 500,
            canFreeze: false,
            expvalue: 4,
            HP: 120,
            ignoreHalu: true,
            sprite_index: spr_DeadbeatShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 1, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 550;
        spawnRate = 80;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 2, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "ShrimpMiniBoss",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 2, 30, "ChangeSpawnRate", function()
    {
        spawnAmount = 3;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 2, 35, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "Deadbeat",
        level: "1",
        dir: "evenSurround",
        amount: 50
    });
    AddTimeEvent(0, 2, 44, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 2, 45, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "1",
        speed: 2.5,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 500,
            lockFacing: false,
            sprite_index: spr_DeadbeatShielded,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 3, 0, "NewMob", function()
    {
        RemoveMobChoice("Shrimp");
        AddMobChoice("Takodachi", 2, 1);
        spawnRate = 120;
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
    AddTimeEvent(0, 3, 18, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "1",
        dir: ParseSpawnDirection(90 + (irandom(1) * 180), "verticalSurround"),
        amount: 30
    });
    AddTimeEvent(0, 3, 15, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "Takodachi",
        level: "1",
        dir: 90,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 500,
            expvalue: 5,
            HP: 200,
            SPD: 0.55,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 3, 15, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "Takodachi",
        level: "1",
        dir: 270,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 500,
            expvalue: 5,
            HP: 200,
            SPD: 0.55,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 3, 39, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 3, 39, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 3, 40, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 1.6,
        dir: 90,
        dirMoving: 270,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 500,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 3, 40, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 90,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 500,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 4, 0, "NewMob", function()
    {
        AddMobChoice("KFP", 1, 1);
        spawnAmount = 3;
    });
    AddTimeEvent(0, 4, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "TakodachiMiniBoss",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 4, 15, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "Takodachi",
        level: "1",
        dir: "evenSurround",
        amount: 50,
        spawnOverride: 
        {
            lifeTime: 1500,
            expvalue: 5,
            HP: 200,
            sprite_index: spr_TakodachiArmored
        }
    });
    AddTimeEvent(0, 4, 20, "ChangeSpawnRate", function()
    {
        spawnRate = 80;
        spawnAmount = 7;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 5, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 400;
        spawnAmount = 6;
    });
    AddTimeEvent(0, 5, 0, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 100
    });
    AddTimeEvent(0, 5, 0, "NewMob", function()
    {
        AddMobChoice("Shrimp", 3, 2);
        AddMobChoice("AngelFairy", 4, 1);
        AddMobChoice("DevilFairy", 4, 1);
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("Deadbeat");
    });
    AddTimeEvent(0, 5, 0, "GoldenYagoo", EventSpawnDirection, 
    {
        id: "GoldenYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 20
    });
    AddTimeEvent(0, 5, 5, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 100
    });
    AddTimeEvent(0, 5, 10, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 100
    });
    AddTimeEvent(0, 5, 29, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 5, 30, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 800,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 31, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 800,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 32, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        offset: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 800,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 33, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        offset: 120,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 800,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 34, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Takodachi",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        offset: 160,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 8,
            HP: 800,
            lockFacing: false,
            sprite_index: spr_TakodachiArmored,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 5, 45, "NewMob", function()
    {
        RemoveMobChoice("KFP");
        spawnAmount = 5;
        AddMobChoice("Deadbeat", 2, 2);
    });
    AddTimeEvent(0, 6, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "ShrimpMiniBoss",
        level: "2",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 6, 30, "NewMob", function()
    {
        AddMobChoice("BigBubba", 4, 1);
        spawnAmount = 5;
    });
    AddTimeEvent(0, 7, 0, "ChangeSpawnRate", function()
    {
        spawnRate = 90;
    });
    AddTimeEvent(0, 7, 0, "EventSpawnCircle", EventSpawnCircle, 
    {
        id: "ShrimpWall",
        dir: "evenSurround",
        amount: 120
    });
    AddTimeEvent(0, 7, 30, "NewMob", function()
    {
        AddMobChoice("Takodachi", 1, 2);
        RemoveMobChoice("AngelFairy");
        RemoveMobChoice("DevilFairy");
    });
    AddTimeEvent(0, 8, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "DeadBeatMiniBoss",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 8, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 800;
        spawnRate = 100;
        spawnAmount = 27;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("Deadbeat");
        AddMobChoice("Deadbeat", 8, 3);
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("Shrimp");
    });
    AddTimeEvent(0, 8, 45, "ChangeSpawnRate", function()
    {
        enemyLimit = 500;
        spawnRate = 120;
        spawnAmount = 4;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("Shrimp", 1, 2);
        AddMobChoice("BigBubba", 5, 1);
        AddMobChoice("Takodachi", 3, 2);
        RemoveMobChoice("Deadbeat");
        AddMobChoice("AngelFairy", 2, 1);
        AddMobChoice("DevilFairy", 2, 1);
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
    AddTimeEvent(0, 9, 0, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 120
    });
    AddTimeEvent(0, 9, 5, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 120
    });
    AddTimeEvent(0, 9, 10, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 120
    });
    AddTimeEvent(0, 9, 15, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 120
    });
    AddTimeEvent(0, 9, 20, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 120
    });
    AddTimeEvent(0, 9, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 1000;
        spawnRate = 90;
        spawnAmount = 7;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("KFP", 1, 2);
    });
    AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 1000;
        spawnRate = 150;
        spawnAmount = 4;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 10, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "Fubura",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 10, 14, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 10, 14, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 10, 14, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 10, 14, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 10, 15, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "BigBubba",
        level: "1",
        speed: 1.6,
        dir: 90,
        dirMoving: 270,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 1000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 10, 15, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "BigBubba",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 1000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 10, 15, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "BigBubba",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 1000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 10, 15, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "BigBubba",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 1000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 10, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 1000;
        spawnRate = 100;
        spawnAmount = 10;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 11, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 1000;
        spawnRate = 60;
        spawnAmount = 10;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("Deadbeat");
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("Shrimp");
        RemoveMobChoice("KFP");
        RemoveMobChoice("AngelFairy");
        RemoveMobChoice("DevilFairy");
        AddMobChoice("Rats", 1, 1);
    });
    AddTimeEvent(0, 11, 20, "ChangeSpawnRate", function()
    {
        enemyLimit = 1000;
        spawnRate = 90;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 11, 30, "EventSpawnCircle", EventSpawnCircle, 
    {
        id: "Rats",
        level: "2",
        dir: "evenSurround",
        amount: 120,
        canReduce: true
    });
    AddTimeEvent(0, 12, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 1000;
        spawnRate = 110;
        spawnAmount = 9;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("Kromies", 1, 1);
    });
    AddTimeEvent(0, 12, 19, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 12, 20, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 3.5,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 12, 19, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 12, 20, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 3.5,
        dir: 180,
        dirMoving: 0,
        amount: 10,
        spacing: 90,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 12, 24, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 12, 25, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 90,
        dirMoving: 270,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 12, 24, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 12, 25, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 3.5,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 90,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 44, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 12, 44, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 12, 46, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 90,
        offset: 45,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 47, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 14,
        spacing: 90,
        offset: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 12, 48, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 16,
        spacing: 90,
        offset: 135,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true,
            canFreeze: false
        }
    });
    AddTimeEvent(0, 12, 49, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 20,
        spacing: 90,
        offset: 180,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 50, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 22,
        spacing: 90,
        offset: 225,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 46, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 90,
        offset: 45,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 47, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 12,
        spacing: 90,
        offset: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 48, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 14,
        spacing: 90,
        offset: 135,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 49, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 16,
        spacing: 90,
        offset: 180,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 50, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 18,
        spacing: 90,
        offset: 225,
        spawnOverride: 
        {
            lifeTime: 1200,
            ATK: 7,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 13, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "KromieKing",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 13, 30, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
    AddTimeEvent(0, 13, 32, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
    AddTimeEvent(0, 13, 34, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
    AddTimeEvent(0, 13, 36, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
    AddTimeEvent(0, 13, 38, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
    AddTimeEvent(0, 13, 40, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "1",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 40
    });
    AddTimeEvent(0, 14, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 75;
        spawnAmount = 10;
        currentSpawnPattern = "horizontalSurround";
        RemoveMobChoice("Rats");
        RemoveMobChoice("Kromies");
        AddMobChoice("ShrimpGang", 1, 1, 
        {
            dir: 0,
            pattern: "directionalSurround"
        });
        AddMobChoice("DeadbeatGang", 1, 1, 
        {
            dir: 180,
            pattern: "directionalSurround"
        });
    });
    AddTimeEvent(0, 14, 19, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 14, 20, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 90,
        dirMoving: 270,
        amount: 10,
        spacing: 75,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 24, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 14, 25, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 75,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 29, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 14, 30, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 75,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 29, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 14, 30, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 90,
        dirMoving: 270,
        amount: 10,
        spacing: 75,
        offset: 37,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 34, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 14, 35, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 36, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 80,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 37, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 38, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 80,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 39, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 12,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 34, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 14, 35, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 36, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 80,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 37, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 38, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 80,
        offset: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 39, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 44, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 14, 44, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 14, 44, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 14, 44, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 14, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 0,
        dirMoving: 180,
        amount: 4,
        spacing: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "ShrimpGang",
        level: "1",
        speed: 2,
        dir: 180,
        dirMoving: 0,
        amount: 4,
        spacing: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_ShrimpGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 45, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 1.6,
        dir: 90,
        dirMoving: 270,
        amount: 4,
        spacing: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 45, "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: "DeadbeatGang",
        level: "1",
        speed: 1.6,
        dir: 270,
        dirMoving: 90,
        amount: 4,
        spacing: 40,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 2000,
            lockFacing: false,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 15, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "ShrimpGangMiniBoss",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 15, 0, "EventSpawnDirectionB", EventSpawnDirection, 
    {
        id: "DeadbeatGangMiniBoss",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 15, 30, "GoldenYagoo", EventSpawnDirection, 
    {
        id: "GoldenYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 20
    });
    AddTimeEvent(0, 15, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        spawnAmount = 7;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 15, 45, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 120;
        spawnAmount = 9;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("ShrimpGang");
        RemoveMobChoice("DeadbeatGang");
        AddMobChoice("Saplings", 4, 1);
        AddMobChoice("Hoomans", 1, 1);
    });
    AddTimeEvent(0, 16, 14, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 16, 14, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 16, 14, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 16, 14, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 16, 15, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 0.2666,
        dir: 0,
        dirMoving: 180,
        amount: 25,
        spacing: 33,
        spawnOverride: 
        {
            lifeTime: 800,
            expvalue: 10,
            HP: 1500,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 16, 15, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 0.15,
        dir: 90,
        dirMoving: 270,
        amount: 25,
        spacing: 33,
        spawnOverride: 
        {
            lifeTime: 800,
            expvalue: 10,
            HP: 1500,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 16, 15, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 0.2666,
        dir: 180,
        dirMoving: 0,
        amount: 25,
        spacing: 33,
        spawnOverride: 
        {
            lifeTime: 800,
            expvalue: 10,
            HP: 1500,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 16, 15, "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "1",
        speed: 0.15,
        dir: 270,
        dirMoving: 90,
        amount: 25,
        spacing: 33,
        spawnOverride: 
        {
            lifeTime: 800,
            expvalue: 10,
            HP: 1500,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 16, 59, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 16, 59, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 16, 59, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 16, 59, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 17, 0, "EventSpawnDirectionLocked", EventSpawnDirectionLocked, 
    {
        id: "Hoomans",
        level: "1",
        speed: 2,
        dir: 90,
        dirMoving: 270,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 17, 0, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Hoomans",
        level: "1",
        speed: 3.5555555554,
        dir: 180,
        dirMoving: 0,
        amount: 10,
        spacing: 90,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 17, 0, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Hoomans",
        level: "1",
        speed: 2,
        dir: 270,
        dirMoving: 90,
        amount: 10,
        spacing: 90,
        offset: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 17, 0, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "Hoomans",
        level: "1",
        speed: 3.5555555554,
        dir: 0,
        dirMoving: 180,
        amount: 10,
        spacing: 90,
        offset: 80,
        spawnOverride: 
        {
            lifeTime: 1200,
            expvalue: 10,
            HP: 5000,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 17, 30, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "SaplingMiniBoss",
        dir: "random",
        amount: 1
    });
    if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
    {
        AddTimeEvent(0, 18, 0, "SilverYagoo", EventSpawnDirection, 
        {
            id: "SilverYagoo",
            level: "1",
            amount: 1,
            dir: "evenSurround",
            chance: 30
        });
    }
    AddTimeEvent(0, 18, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 200;
        spawnRate = 150;
        spawnAmount = 10;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("Rats");
        AddMobChoice("Sanalites", 2, 1);
    });
    AddTimeEvent(0, 19, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 200;
        spawnRate = 80;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("Sanalites");
        RemoveMobChoice("Saplings");
        RemoveMobChoice("Hoomans");
        AddMobChoice("Kromies", 5, 2);
        AddMobChoice("Saplings", 5, 2);
    });
    AddTimeEvent(0, 20, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 200;
        spawnRate = 80;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("Deadbeat");
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("Shrimp");
        RemoveMobChoice("KFP");
        RemoveMobChoice("AngelFairy");
        RemoveMobChoice("DevilFairy");
        RemoveMobChoice("Kromies");
        RemoveMobChoice("Saplings");
        RemoveMobChoice("Hoomans");
        AddMobChoice("BigBubba", 1, 2);
        with (obj_Enemy)
        {
            if (!isBoss && isEnemy)
            {
                Die(true);
            }
        }
    });
    AddTimeEvent(0, 20, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "SmollAme",
        level: "1",
        amount: 1,
        dir: "evenSurround"
    });
    AddTimeEvent(0, 21, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 70;
        spawnAmount = 7;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 22, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 60;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 23, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 60;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("ShrimpGang", 1, 2);
        AddMobChoice("DeadbeatGang", 1, 2);
        AddMobChoice("Takodachi", 1, 3);
        AddMobChoice("KFP", 1, 3);
        AddMobChoice("BigBubba", 1, 3);
        AddMobChoice("AngelFairy", 1, 2);
        AddMobChoice("DevilFairy", 1, 2);
        AddMobChoice("Rats", 1, 3);
        AddMobChoice("Kromies", 1, 3);
        AddMobChoice("Hoomans", 1, 2);
        AddMobChoice("Saplings", 1, 3);
        AddMobChoice("Sanalites", 1, 2);
    });
    AddTimeEvent(0, 24, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 60;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 25, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 60;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 26, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 60;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 27, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 55;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 28, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 50;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 29, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 45;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
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
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("DeadbeatGang");
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("ShrimpGang");
        RemoveMobChoice("KFP");
        RemoveMobChoice("AngelFairy");
        RemoveMobChoice("DevilFairy");
        RemoveMobChoice("Kromies");
        RemoveMobChoice("Saplings");
        RemoveMobChoice("Sanalites");
        RemoveMobChoice("Hoomans");
        RemoveMobChoice("Rats");
        AddMobChoice("Yagoos", 1, 1);
    });
}
