if (room == rm_GrassPlains_Night)
{
    global.topBorder = -1;
    global.bottomBorder = -1;
    global.leftBorder = -1;
    global.rightBorder = -1;
    global.wrappingStage = true;
    AddTimeEvent(0, 0, 5, "ChangeSpawnRate", function()
    {
        enemyLimit = 100;
        spawnRate = 100;
        spawnAmount = 4;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 0, 15, "EventSpawnCircle", EventSpawnCircle, 
    {
        id: "Shrimp",
        level: "3",
        amount: 25,
        dir: "evenSurround",
        canReduce: true
    });
    AddTimeEvent(0, 0, 30, "NewMob", function()
    {
        AddMobChoice("Deadbeat", 2, 4);
    });
    AddTimeEvent(0, 0, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 200;
        spawnRate = 90;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 0, 45, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "1",
        amount: 8,
        dropType: "random",
        dropDistance: 100,
        warnRadius: 60,
        warnTime: 90,
        spawnOverride: 
        {
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                followPlayer: obj_MobManager.behaviours.followPlayer,
                selfDestruct: 
                {
                    config: 
                    {
                        warnTime: 80,
                        radius: 70
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 0, 55, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        spawnAmount = 1;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 1, 0, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "4",
        speed: 0.73,
        dir: 0,
        dirMoving: 180,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 430,
            expvalue: 8,
            HP: 600,
            ignoreHalu: true,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 1, 0, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "4",
        speed: 0.73,
        dir: 180,
        dirMoving: 0,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 430,
            expvalue: 8,
            HP: 600,
            ignoreHalu: true,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 1, 0, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "4",
        speed: 0.4,
        dir: 270,
        dirMoving: 90,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 430,
            expvalue: 8,
            ignoreHalu: true,
            HP: 600,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 1, 0, "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: "Deadbeat",
        level: "4",
        speed: 0.4,
        dir: 90,
        dirMoving: 270,
        amount: 70,
        spacing: 30,
        spawnOverride: 
        {
            lifeTime: 430,
            expvalue: 8,
            ignoreHalu: true,
            HP: 900,
            sprite_index: spr_DeadbeatGangShielded,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 1, 6, "NewMob", function()
    {
        AddMobChoice("Takodachi", 1, 4);
        enemyLimit = 200;
        spawnRate = 100;
        spawnAmount = 6;
    });
    AddTimeEvent(0, 1, 30, "EventSpawnHorde", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 75,
        spawnOverride: 
        {
            SPD: 1.75
        }
    });
    AddTimeEvent(0, 1, 30, "EventSpawnHorde2", EventSpawnHorde, 
    {
        id: "KFPHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 75,
        spawnOverride: 
        {
            SPD: 1.75
        }
    });
    AddTimeEvent(0, 1, 45, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 1,
        dropType: "random",
        dropDistance: 100,
        warnRadius: 75,
        warnTime: 120
    });
    AddTimeEvent(0, 1, 49, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 2,
        dropType: "random",
        dropDistance: 100,
        warnRadius: 75,
        warnTime: 120
    });
    AddTimeEvent(0, 1, 53, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 3,
        dropType: "random",
        dropDistance: 100,
        warnRadius: 75,
        warnTime: 120
    });
    AddTimeEvent(0, 2, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "ShrimpMiniBoss",
        level: "3",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 2, 14, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 2, 14, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 2, 15, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "HoomansH",
        level: "1",
        dir: 0,
        amount: 7,
        spacing: 100,
        spawnOverride: 
        {
            direction: 180,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 2, 15, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "HoomansH",
        level: "1",
        dir: 180,
        amount: 7,
        spacing: 100,
        spawnOverride: 
        {
            direction: 0,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    var i;
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 2, 30 + i, "EventSpawnCircle", EventSpawnCircle, 
        {
            id: "Shrimp",
            level: "3",
            amount: 20,
            canReduce: true,
            dir: "evenSurround",
            spawnOverride: 
            {
                HP: 75,
                expvalue: 4
            }
        });
    }
    AddTimeEvent(0, 2, 59, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 2, 59, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
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
    for (i = 0; i < 7; i++)
    {
        AddTimeEvent(0, 3, 0 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
        {
            id: "Takodachi",
            level: "1",
            speed: 1.6,
            dir: 90,
            dirMoving: 270,
            amount: 10,
            spacing: 100,
            spawnOverride: 
            {
                ATK: 9,
                lifeTime: 1200,
                expvalue: 8,
                HP: 500,
                lockFacing: false,
                sprite_index: spr_TakodachiArmored,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 3, 0 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
        {
            id: "Takodachi",
            level: "1",
            speed: 1.6,
            dir: 270,
            dirMoving: 90,
            amount: 10,
            spacing: 100,
            offset: 50,
            spawnOverride: 
            {
                ATK: 9,
                lifeTime: 1200,
                expvalue: 8,
                HP: 500,
                lockFacing: false,
                sprite_index: spr_TakodachiArmored,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 3, 30, "EventSpawnCircle", EventSpawnCircle, 
    {
        id: "Takodachi",
        level: "4",
        amount: 80,
        canReduce: true,
        dir: "horizontalSurround",
        spawnOverride: 
        {
            expvalue: 4
        }
    });
    AddTimeEvent(0, 3, 45, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 20,
        dropType: "wall",
        wallDir: 90,
        spacing: 30,
        dropDistance: 150,
        warnRadius: 75,
        warnTime: 60,
        spawnOverride: 
        {
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 90
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 3, 45, "EventSpawnDropInB", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 15,
        dropType: "wall",
        wallDir: 270,
        spacing: 40,
        dropDistance: 150,
        warnRadius: 75,
        warnTime: 60,
        spawnOverride: 
        {
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 90
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 4, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "KFPMiniBoss",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 4, 0, "NewMob", function()
    {
        enemyLimit = 300;
        spawnRate = 150;
        spawnAmount = 9;
        AddMobChoice("BigBubba", 2, 4);
        RemoveMobChoice("Shrimp");
    });
    AddTimeEvent(0, 4, 14, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 4, 14, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 4, 15 + i, "EventSpawnHorde", EventSpawnHorde, 
        {
            id: "KFPHorde",
            level: "2",
            dir: 45 - irandom(89),
            amount: 50,
            spawnOverride: 
            {
                SPD: 1.5,
                lifeTime: 250
            }
        });
        AddTimeEvent(0, 4, 15 + i, "EventSpawnHorde2", EventSpawnHorde, 
        {
            id: "KFPHorde",
            level: "2",
            dir: 135 + irandom(89),
            amount: 50,
            spawnOverride: 
            {
                SPD: 1.5,
                lifeTime: 250
            }
        });
    }
    AddTimeEvent(0, 4, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 150;
        spawnAmount = 9;
    });
    AddTimeEvent(0, 4, 40, "ChangeSpawnRate", function()
    {
        enemyLimit = 400;
        spawnRate = 150;
        spawnAmount = 8;
    });
    AddTimeEvent(0, 4, 44, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 4, 44, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 4, 45 + i, "EventSpawnWall1", EventSpawnWall, 
        {
            id: "HoomansH",
            level: "1",
            dir: 0,
            amount: 7,
            spacing: 100,
            spawnOverride: 
            {
                SPD: 3,
                direction: 180,
                lockFacing: false,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 4, 45 + i, "EventSpawnWall2", EventSpawnWall, 
        {
            id: "HoomansH",
            level: "1",
            dir: 180,
            amount: 7,
            spacing: 100,
            spawnOverride: 
            {
                SPD: 3,
                direction: 0,
                lockFacing: false,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 5, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "GoldenYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 20
    });
    for (i = 0; i < 7; i++)
    {
        AddTimeEvent(0, 5, 0 + i, "EventSpawnDropIn", EventSpawnDropIn, 
        {
            id: "KFPH",
            level: "1",
            amount: 1,
            dropType: "random",
            dropDistance: 0,
            warnRadius: 30,
            warnTime: 60,
            spawnOverride: 
            {
                HP: 1000,
                image_xscale: 2,
                image_yscale: 2,
                lifeTime: 300,
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
    AddTimeEvent(0, 5, 27, "SpawnRates", function()
    {
        enemyLimit = 300;
        spawnRate = 120;
        enabledSpawner = false;
        spawnAmount = 2;
    });
    for (i = 0; i < 2; i++)
    {
        AddTimeEvent(0, 5, 30, "EventSpawnDropIn" + string(i), EventSpawnDropIn, 
        {
            id: "Deadbeat",
            level: "5",
            amount: 30,
            dropType: "wall",
            wallDir: i * 180,
            dropDistance: 240,
            spacing: 40,
            warnRadius: 30,
            warnTime: 30,
            spawnOverride: 
            {
                SPD: 0.01,
                ATK: 20,
                image_xscale: 2,
                image_yscale: 2,
                HP: 1500,
                lifeTime: 720,
                knockbackImmune: false,
                tangible: false,
                behaviours: 
                {
                    collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                    powerScaling: obj_MobManager.behaviours.powerScaling
                }
            }
        });
    }
    for (i = 0; i < 2; i++)
    {
        AddTimeEvent(0, 5, 30, "EventSpawnDropIn2" + string(i), EventSpawnDropIn, 
        {
            id: "Deadbeat",
            level: "5",
            amount: 30,
            dropType: "wall",
            wallDir: 90 + (i * 180),
            dropDistance: 180,
            spacing: 40,
            warnRadius: 30,
            warnTime: 30,
            spawnOverride: 
            {
                SPD: 0.01,
                ATK: 20,
                image_xscale: 2,
                image_yscale: 2,
                HP: 1500,
                lifeTime: 720,
                knockbackImmune: false,
                tangible: false,
                behaviours: 
                {
                    collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                    powerScaling: obj_MobManager.behaviours.powerScaling
                }
            }
        });
    }
    for (i = 0; i < 8; i++)
    {
        AddTimeEvent(0, 5, 33 + i, "EventSpawnDropIn", EventSpawnDropIn, 
        {
            id: "KFPH",
            level: "1",
            amount: 3,
            spacing: 50,
            dropType: "wall",
            wallDir: (i % 4) * 90,
            dropDistance: 275,
            warnRadius: 30,
            warnTime: 30
        });
    }
    AddTimeEvent(0, 5, 40, "SpawnRates", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        enabledSpawner = true;
        spawnAmount = 8;
    });
    AddTimeEvent(0, 6, 0, "SpawnRates", function()
    {
        enemyLimit = 300;
        spawnRate = 90;
        spawnAmount = 6;
        AddMobChoice("GuyRys", 2, 1);
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("Deadbeat");
        RemoveMobChoice("Shrimp");
    });
    AddTimeEvent(0, 6, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "Bloom",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 6, 0, "EventSpawnDirectionB", EventSpawnDirection, 
    {
        id: "Gloom",
        level: "1",
        dir: "random",
        amount: 1
    });
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 6, 10 + i, "EventSpawnHorde", EventSpawnHorde, 
        {
            id: "RatHordeH",
            level: "1",
            dir: ParseSpawnDirection(irandom(360), "random"),
            amount: 80
        });
    }
    AddTimeEvent(0, 6, 45, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 6,
        dropDistance: 180,
        dropType: "surround",
        warnRadius: 50,
        warnTime: 60,
        spawnOverride: 
        {
            HP: 500,
            image_xscale: 1.5,
            image_yscale: 1.5,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
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
    AddTimeEvent(0, 7, 7, "SpawnRates", function()
    {
        enemyLimit = 300;
        spawnRate = 120;
        enabledSpawner = false;
        spawnAmount = 2;
        RemoveMobChoice("GuyRys");
        AddMobChoice("ShrimpGang", 1, 3);
        AddMobChoice("DeadbeatGang", 1, 3);
    });
    var BombDir = irandom(3) * 90;
    for (i = 0; i < 4; i++)
    {
        if ((i * 90) != BombDir)
        {
            AddTimeEvent(0, 7, 10, "EventSpawnDirectionLocked" + string(i), EventSpawnDirectionLocked, 
            {
                id: "Takodachi",
                level: "4",
                speed: 0.15,
                dir: 0 + (i * 90),
                dirMoving: ((abs(-(i * 90) - 180) / 90) % 4) * 90,
                amount: 25,
                spacing: 40,
                spawnOverride: 
                {
                    image_xscale: 2,
                    image_yscale: 2,
                    ATK: 35,
                    lifeTime: 900,
                    expvalue: 5,
                    HP: 9000,
                    lockFacing: false,
                    knockbackImmune: true
                }
            });
        }
        else
        {
            AddTimeEvent(0, 7, 10, "EventSpawnDirectionLocked" + string(i), EventSpawnDirectionLocked, 
            {
                id: "SSRBH",
                level: "4",
                speed: 0.15,
                dir: 0 + (i * 90),
                dirMoving: ((abs(-(i * 90) - 180) / 90) % 4) * 90,
                amount: 25,
                spacing: 30,
                offset: (i % 4) * 20,
                spawnOverride: 
                {
                    ATK: 7,
                    lifeTime: 900,
                    image_xscale: 1.5,
                    image_yscale: 1.5,
                    expvalue: 5,
                    HP: 5000,
                    lockFacing: false,
                    knockbackImmune: true
                }
            });
        }
    }
    var directions = [0, 90, 180, 270];
    var randomSequence = [];
    for (i = 0; i < 4; i++)
    {
        var ranNum = irandom(array_length(directions) - 1);
        array_push(randomSequence, directions[ranNum]);
        array_delete(directions, ranNum, 1);
    }
    for (i = 0; i < 4; i++)
    {
        switch (randomSequence[i])
        {
            case 0:
                AddTimeEvent(0, 7, 29 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 0;
                });
                break;
            case 90:
                AddTimeEvent(0, 7, 29 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 90;
                });
                break;
            case 180:
                AddTimeEvent(0, 7, 29 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 180;
                });
                break;
            case 270:
                AddTimeEvent(0, 7, 29 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 270;
                });
                break;
        }
        AddTimeEvent(0, 7, 33 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
        {
            id: "BigBubba",
            level: "4",
            speed: 5,
            dir: 0 + randomSequence[i],
            dirMoving: ((abs(-randomSequence[i] - 180) / 90) % 4) * 90,
            amount: 15,
            spacing: 80,
            spawnOverride: 
            {
                lifeTime: 1200,
                expvalue: 10,
                HP: 1500,
                ATK: 20,
                lockFacing: false,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 7, 19, "SpawnRates", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        enabledSpawner = true;
        spawnAmount = 8;
    });
    AddTimeEvent(0, 8, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "InvestigatorsMiniBoss",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 8, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 800;
        spawnRate = 120;
        spawnAmount = 25;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("DeadbeatGang");
        AddMobChoice("GuyRys", 8, 2);
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("ShrimpGang");
        RemoveMobChoice("Shrimp");
    });
    AddTimeEvent(0, 8, 33, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 8, 34, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 8, 35, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 8, 36, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 8, 37, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 8, 38, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 8, 39, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 8, 40, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    for (i = 0; i < 8; i++)
    {
        AddTimeEvent(0, 8, 34 + i, "EventSpawnWall", EventSpawnWall, 
        {
            id: "Irysocrats",
            level: "1",
            dir: 0 + ((i % 4) * 90),
            amount: 10,
            spacing: 100,
            spawnOverride: 
            {
                HP: 2000,
                direction: ((abs(-(i * 90) - 180) / 90) % 4) * 90,
                lockFacing: false,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 8, 42, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 120;
        spawnAmount = 7;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("BigBubba", 1, 5);
        RemoveMobChoice("GuyRys");
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
    AddTimeEvent(0, 9, 0, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "BigBubba",
        level: "4",
        amount: 8,
        dropDistance: 0,
        wallDir: 0,
        spacing: 140,
        dropType: "wall",
        warnRadius: 70,
        warnTime: 90,
        spawnOverride: 
        {
            HP: 800
        }
    });
    AddTimeEvent(0, 9, 0, "EventSpawnDropInB", EventSpawnDropIn, 
    {
        id: "BigBubba",
        level: "4",
        amount: 8,
        dropDistance: 0,
        wallDir: 90,
        spacing: 140,
        dropType: "wall",
        warnRadius: 70,
        warnTime: 90,
        spawnOverride: 
        {
            HP: 800
        }
    });
    AddTimeEvent(0, 9, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        spawnAmount = 9;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 130;
        spawnAmount = 4;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 10, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "FuburaH",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 10, 0, "EventSpawnDirectionB", EventSpawnDirection, 
    {
        id: "SmollAmeH",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 11, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 90;
        spawnAmount = 9;
        RemoveMobChoice("BigBubba");
        AddMobChoice("Rats", 4, 4);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 11, 15, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "Rats",
        level: "5",
        amount: 5,
        dropDistance: 120,
        dropType: "random",
        warnRadius: 75,
        warnTime: 100
    });
    AddTimeEvent(0, 11, 18, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "Rats",
        level: "5",
        amount: 5,
        dropDistance: 120,
        dropType: "random",
        warnRadius: 75,
        warnTime: 100
    });
    AddTimeEvent(0, 11, 21, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "Rats",
        level: "5",
        amount: 5,
        dropDistance: 120,
        dropType: "random",
        warnRadius: 75,
        warnTime: 100
    });
    AddTimeEvent(0, 11, 30, "EventSpawnHordeA", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 75
    });
    AddTimeEvent(0, 11, 30, "EventSpawnHordeB", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 75
    });
    AddTimeEvent(0, 11, 30, "EventSpawnHordeC", EventSpawnHorde, 
    {
        id: "RatHorde",
        level: "2",
        dir: ParseSpawnDirection(irandom(360), "random"),
        amount: 75
    });
    AddTimeEvent(0, 11, 45, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 90;
        spawnAmount = 10;
        AddMobChoice("SSRBH", 1, 2);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 12, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "KromieKing",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 12, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 90;
        spawnAmount = 7;
        AddMobChoice("Kromies", 3, 4);
        RemoveMobChoice("SSRBH");
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 12, 29, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    for (i = 0; i < 8; i++)
    {
        AddTimeEvent(0, 12, 30 + i, "EventSpawnDirectionLocked" + string(i), EventSpawnDirectionLocked, 
        {
            id: "Kromies",
            level: "4",
            speed: 2,
            dir: 0,
            dirMoving: 180,
            amount: 12,
            spacing: 80,
            spawnOverride: 
            {
                ATK: 25,
                image_xscale: 1,
                image_yscale: 1,
                lifeTime: 600,
                expvalue: 5,
                HP: 9000,
                lockFacing: false,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 12, 32 + i, "EventSpawnDirectionA", EventSpawnDirection, 
        {
            id: "Rats",
            level: "5",
            amount: 1,
            dir: "evenSurround",
            spawnOverride: 
            {
                ATK: 25,
                image_xscale: 2,
                image_yscale: 2
            }
        });
    }
    AddTimeEvent(0, 12, 40, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        enabledSpawner = false;
        spawnAmount = 3;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 12, 44, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 12, 44, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 12, 44, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 12, 44, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "4",
        speed: 0.1,
        dir: 0,
        dirMoving: 180,
        amount: 18,
        spacing: 40,
        spawnOverride: 
        {
            image_xscale: 2,
            image_yscale: 2,
            lifeTime: 600,
            expvalue: 10,
            ATK: 40,
            HP: 5000,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "4",
        speed: 0.1,
        dir: 90,
        dirMoving: 270,
        amount: 18,
        spacing: 40,
        spawnOverride: 
        {
            image_xscale: 2,
            image_yscale: 2,
            lifeTime: 600,
            expvalue: 10,
            ATK: 40,
            HP: 5000,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDirectionLockedC", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "4",
        speed: 0.1,
        dir: 180,
        dirMoving: 0,
        amount: 18,
        spacing: 40,
        spawnOverride: 
        {
            image_xscale: 2,
            image_yscale: 2,
            lifeTime: 600,
            expvalue: 10,
            ATK: 40,
            HP: 5000,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDirectionLockedD", EventSpawnDirectionLocked, 
    {
        id: "Kromies",
        level: "4",
        speed: 0.1,
        dir: 270,
        dirMoving: 90,
        amount: 18,
        spacing: 40,
        spawnOverride: 
        {
            image_xscale: 2,
            image_yscale: 2,
            lifeTime: 600,
            expvalue: 10,
            ATK: 40,
            HP: 5000,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "5",
        amount: 1,
        dropType: "wall",
        wallDir: 0,
        spacing: 30,
        dropDistance: 170,
        warnRadius: 30,
        warnTime: 30,
        spawnOverride: 
        {
            tangible: false,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDropInB", EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "5",
        amount: 1,
        dropType: "wall",
        wallDir: 90,
        spacing: 30,
        dropDistance: 170,
        warnRadius: 30,
        warnTime: 30,
        spawnOverride: 
        {
            tangible: false,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDropInC", EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "5",
        amount: 1,
        dropType: "wall",
        wallDir: 180,
        spacing: 30,
        dropDistance: 170,
        warnRadius: 30,
        warnTime: 30,
        spawnOverride: 
        {
            tangible: false,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 12, 45, "EventSpawnDropInD", EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "5",
        amount: 1,
        dropType: "wall",
        wallDir: 270,
        spacing: 30,
        dropDistance: 170,
        warnRadius: 30,
        warnTime: 30,
        spawnOverride: 
        {
            tangible: false,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 12, 50, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 150;
        enabledSpawner = true;
        spawnAmount = 3;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 12, 59, "SetPosition", EventLockPosition);
    for (i = 0; i < 6; i++)
    {
        AddTimeEvent(0, 13, 0, "EventSpawnDropInA" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 10,
            dropType: "wall",
            wallDir: 0,
            spacing: 200,
            dropDistance: 0 + (i * 200),
            warnRadius: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 20,
                HP: 1,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 13, 0, "EventSpawnDropInB" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 10,
            dropType: "wall",
            wallDir: 180,
            spacing: 200,
            dropDistance: 200 + (i * 200),
            warnRadius: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 20,
                HP: 1,
                knockbackImmune: true
            }
        });
    }
    for (i = 0; i < 6; i++)
    {
        AddTimeEvent(0, 13, 2, "EventSpawnDropInA" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 10,
            dropType: "wall",
            wallDir: 0,
            spacing: 200,
            dropDistance: 100 + (i * 200),
            warnRadius: 100,
            offset: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 20,
                HP: 1,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 13, 2, "EventSpawnDropInB" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 10,
            dropType: "wall",
            wallDir: 180,
            spacing: 200,
            offset: 100,
            dropDistance: 100 + (i * 200),
            warnRadius: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 20,
                HP: 1,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 13, 10, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 100;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 13, 29, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 13, 29, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    for (i = 0; i < 6; i++)
    {
        AddTimeEvent(0, 13, 30 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
        {
            id: "Kromies",
            level: "5",
            speed: 2,
            dir: 0,
            dirMoving: 180,
            amount: 8,
            spacing: 100,
            offset: 50,
            spawnOverride: 
            {
                lifeTime: 600,
                expvalue: 8,
                HP: 2500,
                ATK: 12,
                image_xscale: 1,
                image_yscale: 1,
                lockFacing: false,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 13, 30 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
        {
            id: "Kromies",
            level: "5",
            speed: 2,
            dir: 90,
            dirMoving: 270,
            amount: 8,
            spacing: 100,
            spawnOverride: 
            {
                lifeTime: 600,
                expvalue: 8,
                HP: 2500,
                ATK: 12,
                image_xscale: 1,
                image_yscale: 1,
                lockFacing: false,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 13, 32, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "Rats",
        level: "5",
        amount: 1,
        dir: "evenSurround",
        spawnOverride: 
        {
            ATK: 25,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 13, 33, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "Rats",
        level: "5",
        amount: 1,
        dir: "evenSurround",
        spawnOverride: 
        {
            ATK: 25,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 13, 34, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "Rats",
        level: "5",
        amount: 1,
        dir: "evenSurround",
        spawnOverride: 
        {
            ATK: 25,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 13, 35, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "Rats",
        level: "5",
        amount: 1,
        dir: "evenSurround",
        spawnOverride: 
        {
            ATK: 25,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 13, 36, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "Rats",
        level: "5",
        amount: 1,
        dir: "evenSurround",
        spawnOverride: 
        {
            ATK: 25,
            image_xscale: 2,
            image_yscale: 2
        }
    });
    AddTimeEvent(0, 14, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "HoomansMiniBoss",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 14, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 90;
        spawnAmount = 5;
        RemoveMobChoice("Kromies");
        RemoveMobChoice("Rats");
        AddMobChoice("HoomansH", 3, 2);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 14, 14, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 14, 14, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    AddTimeEvent(0, 14, 15, "EventSpawnWall1", EventSpawnWall, 
    {
        id: "HoomansH",
        level: "1",
        dir: 90,
        amount: 10,
        spacing: 80,
        spawnOverride: 
        {
            HP: 3000,
            SPD: 3,
            direction: 270,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 15, "EventSpawnWall2", EventSpawnWall, 
    {
        id: "HoomansH",
        level: "1",
        dir: 270,
        amount: 10,
        spacing: 80,
        offset: 40,
        spawnOverride: 
        {
            HP: 3000,
            SPD: 3,
            direction: 90,
            lockFacing: false,
            knockbackImmune: true
        }
    });
    AddTimeEvent(0, 14, 30, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dir: "verticalSurround",
        spawnOverride: {}
    });
    AddTimeEvent(0, 14, 31, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dir: "verticalSurround",
        spawnOverride: {}
    });
    AddTimeEvent(0, 14, 32, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dir: "verticalSurround",
        spawnOverride: {}
    });
    AddTimeEvent(0, 14, 33, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dir: "verticalSurround",
        spawnOverride: {}
    });
    AddTimeEvent(0, 14, 34, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dir: "verticalSurround",
        spawnOverride: {}
    });
    AddTimeEvent(0, 14, 35, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dir: "verticalSurround",
        spawnOverride: {}
    });
    AddTimeEvent(0, 14, 59, "SetPosition", EventLockPosition);
    AddTimeEvent(0, 15, 0, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "3",
        amount: 10,
        dropType: "surround",
        dropDistance: 50,
        warnRadius: 40,
        warnTime: 100,
        setPosition: true,
        spawnOverride: {}
    });
    AddTimeEvent(0, 15, 2, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "3",
        amount: 10,
        dropType: "surround",
        dropDistance: 100,
        warnRadius: 40,
        warnTime: 100,
        setPosition: true,
        spawnOverride: {}
    });
    AddTimeEvent(0, 15, 4, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "3",
        amount: 10,
        dropType: "surround",
        dropDistance: 150,
        warnRadius: 40,
        warnTime: 100,
        setPosition: true,
        spawnOverride: {}
    });
    AddTimeEvent(0, 15, 7, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "2",
        amount: 10,
        dropType: "random",
        dropDistance: 150,
        warnRadius: 40,
        warnTime: 100,
        spawnOverride: {}
    });
    AddTimeEvent(0, 15, 15, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 80;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 15, 19, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 15, 19, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    for (i = 0; i < 4; i++)
    {
        AddTimeEvent(0, 15, 20 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
        {
            id: "HoomansH",
            level: "1",
            speed: 3,
            dir: 0,
            dirMoving: 180,
            amount: 10,
            spacing: 100,
            spawnOverride: 
            {
                lifeTime: 490,
                expvalue: 8,
                HP: 6000,
                lockFacing: false,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 15, 20 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
        {
            id: "Saplings",
            level: "5",
            speed: 3,
            dir: 180,
            dirMoving: 0,
            amount: 8,
            spacing: 100,
            spawnOverride: 
            {
                lifeTime: 490,
                expvalue: 8,
                HP: 6000,
                lockFacing: false,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 15, 45, "EventSpawnDropInA", EventSpawnDropIn, 
    {
        id: "Saplings",
        level: "5",
        amount: 30,
        dropType: "wall",
        wallDir: 0,
        spacing: 40,
        dropDistance: 100,
        warnRadius: 40,
        warnTime: 30,
        spawnOverride: 
        {
            SPD: 0.1,
            knockbackImmune: true,
            HP: 6000,
            lifeTime: 600
        }
    });
    AddTimeEvent(0, 15, 45, "EventSpawnDropInB", EventSpawnDropIn, 
    {
        id: "Saplings",
        level: "5",
        amount: 30,
        dropType: "wall",
        wallDir: 180,
        spacing: 40,
        dropDistance: 100,
        warnRadius: 40,
        warnTime: 30,
        spawnOverride: 
        {
            SPD: 0.1,
            knockbackImmune: true,
            HP: 6000,
            lifeTime: 600
        }
    });
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 15, 47 + i, "EventSpawnDropInA", EventSpawnDropIn, 
        {
            id: "SSRBH",
            level: "2",
            amount: 1,
            dropType: "random",
            dropDistance: 0,
            warnRadius: 70,
            warnTime: 90,
            spawnOverride: 
            {
                SPD: 0.2,
                HP: 1000
            }
        });
    }
    AddTimeEvent(0, 16, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 250;
        spawnRate = 90;
        spawnAmount = 8;
        AddMobChoice("Saplings", 4, 4);
        RemoveMobChoice("HoomansH");
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 16, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "SaplingMiniBoss",
        level: "2",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 16, 0, "EventSpawnDirectionA", EventSpawnDirection, 
    {
        id: "GoldenYagoo",
        level: "1",
        amount: 1,
        dir: "evenSurround",
        chance: 20
    });
    AddTimeEvent(0, 16, 29, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 16, 29, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 270;
    });
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 16, 30 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
        {
            id: "HoomansH",
            level: "1",
            speed: 2.5,
            dir: 90,
            dirMoving: 270,
            amount: 10,
            spacing: 90,
            spawnOverride: 
            {
                lifeTime: 60,
                expvalue: 8,
                HP: 6000,
                ATK: 8,
                lockFacing: false,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 16, 30 + i, "EventSpawnDirectionLockedB", EventSpawnDirectionLocked, 
        {
            id: "HoomansH",
            level: "1",
            speed: 2.5,
            dir: 270,
            dirMoving: 90,
            amount: 8,
            spacing: 90,
            spawnOverride: 
            {
                lifeTime: 60,
                expvalue: 8,
                HP: 6000,
                ATK: 8,
                lockFacing: false,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 16, 30 + i, "EventSpawnDirectionA", EventSpawnDirection, 
        {
            id: "Rats",
            level: "5",
            amount: 4,
            dir: "horizontalSurround",
            spawnOverride: 
            {
                ATK: 25,
                image_xscale: 1,
                image_yscale: 1
            }
        });
    }
    AddTimeEvent(0, 16, 45, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 90;
        spawnAmount = 10;
        AddMobChoice("SaplingTree", 1, 1);
        currentSpawnPattern = "evenSurround";
    });
    for (i = 0; i < 5; i++)
    {
        AddTimeEvent(0, 17, 0 + i, "EventSpawnDirectionA", EventSpawnDirection, 
        {
            id: "Rats",
            level: "5",
            amount: 8,
            dir: "evenSurround",
            spawnOverride: 
            {
                ATK: 25,
                image_xscale: 1.5,
                image_yscale: 1.5,
                behaviours: 
                {
                    collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                    chargePlayer: 
                    {
                        config: 
                        {
                            waitTime: 30,
                            warnTime: 80
                        }
                    }
                }
            }
        });
    }
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
    AddTimeEvent(0, 17, 6, "EventSpawnDropInA" + string(i), EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "6",
        amount: 1,
        dropType: "random",
        dropDistance: 0,
        warnRadius: 100,
        warnTime: 120,
        spawnOverride: {}
    });
    AddTimeEvent(0, 18, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 250;
        spawnRate = 120;
        spawnAmount = 10;
        RemoveMobChoice("SaplingTree");
        RemoveMobChoice("Saplings");
        AddMobChoice("Sanalites", 8, 3);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 18, 0, "EventSpawnDirection", EventSpawnDirection, 
    {
        id: "Yatagarasu",
        level: "1",
        dir: "random",
        amount: 1
    });
    AddTimeEvent(0, 19, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 250;
        spawnRate = 100;
        spawnAmount = 10;
        AddMobChoice("SSRBH", 1, 6);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 19, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 0;
        spawnRate = 150;
        enabledSpawner = false;
        spawnAmount = -100;
        RemoveMobChoice("Sanalites");
        RemoveMobChoice("SSRBH");
        currentSpawnPattern = "evenSurround";
        with (obj_Enemy)
        {
            if (!isBoss && isEnemy)
            {
                Die(true);
            }
        }
    });
    directions = [0, 90, 180, 270, 0, 90, 180, 270];
    randomSequence = [];
    for (i = 0; i < 6; i++)
    {
        var ranNum = irandom(array_length(directions) - 1);
        array_push(randomSequence, directions[ranNum]);
        array_delete(directions, ranNum, 1);
    }
    for (i = 0; i < 6; i++)
    {
        switch (randomSequence[i])
        {
            case 0:
                AddTimeEvent(0, 19, 31 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 0;
                });
                break;
            case 90:
                AddTimeEvent(0, 19, 31 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 90;
                });
                break;
            case 180:
                AddTimeEvent(0, 19, 31 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 180;
                });
                break;
            case 270:
                AddTimeEvent(0, 19, 31 + i, "AlertA", function()
                {
                    var alert = instance_create_depth(x, y, depth, obj_caution);
                    alert.dir = 270;
                });
                break;
        }
        AddTimeEvent(0, 19, 37 + i, "EventSpawnDirectionLockedA", EventSpawnDirectionLocked, 
        {
            id: "ShrimpGang",
            level: "1",
            speed: 5,
            dir: 0 + randomSequence[i],
            dirMoving: ((abs(-randomSequence[i] - 180) / 90) % 4) * 90,
            amount: 15,
            spacing: 80,
            offset: (i % 2) * 40,
            spawnOverride: 
            {
                lifeTime: 1200,
                expvalue: 10,
                HP: 10000,
                ATK: 20,
                lockFacing: false,
                knockbackImmune: true
            }
        });
    }
    for (i = 0; i < 6; i++)
    {
        AddTimeEvent(0, 19, 39 + i, "EventSpawnDirectionA", EventSpawnDirection, 
        {
            id: "Rats",
            level: "5",
            amount: 1,
            dir: "evenSurround",
            spawnOverride: 
            {
                ATK: 25,
                image_xscale: 2,
                image_yscale: 2
            }
        });
    }
    AddTimeEvent(0, 19, 44, "SetPosition", EventLockPosition);
    for (i = 0; i < 6; i++)
    {
        AddTimeEvent(0, 19, 45, "EventSpawnDropInA" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 15,
            dropType: "wall",
            wallDir: 0,
            spacing: 200,
            dropDistance: 0 + (i * 200),
            warnRadius: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 25,
                HP: 1,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 19, 45, "EventSpawnDropInB" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 15,
            dropType: "wall",
            wallDir: 180,
            spacing: 200,
            dropDistance: 200 + (i * 200),
            warnRadius: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 25,
                HP: 1,
                knockbackImmune: true
            }
        });
    }
    for (i = 0; i < 6; i++)
    {
        AddTimeEvent(0, 19, 47, "EventSpawnDropInA" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 15,
            dropType: "wall",
            wallDir: 0,
            spacing: 200,
            dropDistance: 100 + (i * 200),
            warnRadius: 100,
            offset: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 25,
                HP: 1,
                knockbackImmune: true
            }
        });
        AddTimeEvent(0, 19, 47, "EventSpawnDropInB" + string(i), EventSpawnDropIn, 
        {
            id: "Shrimp",
            level: "4",
            amount: 15,
            dropType: "wall",
            wallDir: 180,
            spacing: 200,
            offset: 100,
            dropDistance: 100 + (i * 200),
            warnRadius: 100,
            warnTime: 240,
            setPosition: true,
            spawnOverride: 
            {
                expvalue: 5,
                ATK: 25,
                HP: 1,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 19, 46, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 6,
        dropDistance: 180,
        dropType: "surround",
        warnRadius: 50,
        warnTime: 5,
        spawnOverride: 
        {
            ATK: 20,
            HP: 5000,
            knockbackImmune: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 45,
                        warnTime: 75
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 19, 48, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 6,
        dropDistance: 200,
        dropType: "wall",
        wallDir: 180,
        warnRadius: 50,
        spacing: 40,
        warnTime: 5,
        spawnOverride: 
        {
            ATK: 20,
            HP: 5000,
            knockbackImmune: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
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
    AddTimeEvent(0, 19, 49, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "KFPH",
        level: "1",
        amount: 6,
        dropDistance: 200,
        dropType: "wall",
        wallDir: 0,
        spacing: 40,
        warnRadius: 50,
        warnTime: 5,
        spawnOverride: 
        {
            ATK: 20,
            HP: 5000,
            knockbackImmune: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
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
    AddTimeEvent(0, 19, 49, "SetPosition", EventLockPosition);
    AddTimeEvent(0, 19, 50, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "3",
        amount: 1,
        dropDistance: 0,
        dropType: "surround",
        warnRadius: 50,
        warnTime: 80,
        setPosition: true,
        spawnOverride: 
        {
            HP: 5000,
            knockbackImmune: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 80
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 19, 51, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "3",
        amount: 10,
        dropDistance: 100,
        dropType: "surround",
        warnRadius: 50,
        warnTime: 80,
        setPosition: true,
        spawnOverride: 
        {
            HP: 5000,
            knockbackImmune: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 80
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 19, 52, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "HoomansH",
        level: "3",
        amount: 20,
        dropDistance: 150,
        dropType: "surround",
        warnRadius: 50,
        warnTime: 80,
        setPosition: true,
        spawnOverride: 
        {
            HP: 5000,
            knockbackImmune: true,
            image_xscale: 1.5,
            image_yscale: 1.5,
            behaviours: 
            {
                collideWithPlayer: obj_MobManager.behaviours.collideWithPlayer,
                chargePlayer: 
                {
                    config: 
                    {
                        waitTime: 30,
                        warnTime: 80
                    }
                }
            }
        }
    });
    AddTimeEvent(0, 19, 53, "SetPosition", EventLockPosition);
    AddTimeEvent(0, 19, 53, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 0;
    });
    AddTimeEvent(0, 19, 53, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 90;
    });
    AddTimeEvent(0, 19, 53, "AlertC", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 180;
    });
    AddTimeEvent(0, 19, 53, "AlertD", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 27;
    });
    for (i = 0; i < 4; i++)
    {
        AddTimeEvent(0, 19, 54, "EventSpawnDirectionLockedA" + string(i), EventSpawnDirectionLocked, 
        {
            id: "DeadbeatGang",
            level: "3",
            speed: 0.01,
            dir: 0 + (i * 90),
            dirMoving: ((abs(-(i * 90) - 180) / 90) % 4) * 90,
            amount: 20,
            spacing: 35,
            spawnOverride: 
            {
                ATK: 50,
                image_xscale: 2,
                image_yscale: 2,
                lifeTime: 360,
                expvalue: 5,
                HP: 50000,
                knockbackImmune: true
            }
        });
    }
    AddTimeEvent(0, 19, 55, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "SSRBH",
        level: "7",
        amount: 1,
        dropDistance: 0,
        dropType: "surround",
        warnRadius: 30,
        warnTime: 90,
        spawnOverride: 
        {
            tangible: false
        }
    });
    AddTimeEvent(0, 19, 55, "AlertA", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 27;
    });
    AddTimeEvent(0, 19, 55, "AlertB", function()
    {
        var alert = instance_create_depth(x, y, depth, obj_caution);
        alert.dir = 27;
    });
    for (i = 0; i < 4; i++)
    {
        AddTimeEvent(0, 19, 56 + i, "EventSpawnWall1", EventSpawnWall, 
        {
            id: "HoomansH",
            level: "1",
            dir: 0,
            amount: 10,
            spacing: 70,
            offset: (i % 2) * 35,
            spawnOverride: 
            {
                HP: 10000,
                ATK: 15,
                direction: 180,
                lockFacing: false,
                knockbackImmune: true,
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
        AddTimeEvent(0, 19, 56 + i, "EventSpawnWall2", EventSpawnWall, 
        {
            id: "HoomansH",
            level: "1",
            dir: 180,
            amount: 10,
            spacing: 70,
            offset: 35 + ((i % 2) * 35),
            spawnOverride: 
            {
                HP: 10000,
                ATK: 15,
                direction: 0,
                lockFacing: false,
                knockbackImmune: true,
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
    }
    AddTimeEvent(0, 20, 2, "ChangeSpawnRate", function()
    {
        enemyLimit = 400;
        spawnRate = 100;
        spawnAmount = 5;
        enabledSpawner = true;
        RemoveMobChoice("Hoomans");
        AddMobChoice("Rats", 1, 6);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 20, 2, "EventSpawnDropIn", EventSpawnDropIn, 
    {
        id: "Bae3D",
        level: "1",
        amount: 1,
        dropType: "random",
        warnRadius: 100,
        warnTime: 300
    });
    AddTimeEvent(0, 22, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 400;
        spawnRate = 100;
        spawnAmount = 8;
        RemoveMobChoice("Hoomans");
        AddMobChoice("GuyRys", 2, 3);
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 23, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 300;
        spawnRate = 60;
        spawnAmount = 5;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("GuyRys");
        AddMobChoice("ShrimpGang", 5, 4);
        AddMobChoice("DeadbeatGang", 5, 4);
        AddMobChoice("Takodachi", 5, 5);
        AddMobChoice("KFPH", 1, 2);
        AddMobChoice("BigBubba", 5, 6);
        AddMobChoice("GuyRys", 5, 4);
        AddMobChoice("Rats", 1, 7);
        AddMobChoice("Kromies", 5, 6);
        AddMobChoice("Hoomans", 1, 3);
        AddMobChoice("Saplings", 5, 6);
        AddMobChoice("Sanalites", 5, 4);
        AddMobChoice("SSRBH", 3, 8);
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
        RemoveMobChoice("Shrimp");
        RemoveMobChoice("DeadbeatGang");
        RemoveMobChoice("Takodachi");
        RemoveMobChoice("BigBubba");
        RemoveMobChoice("ShrimpGang");
        RemoveMobChoice("KFPH");
        RemoveMobChoice("GuyRys");
        RemoveMobChoice("Kromies");
        RemoveMobChoice("Saplings");
        RemoveMobChoice("Sanalites");
        RemoveMobChoice("Hoomans");
        RemoveMobChoice("Rats");
        RemoveMobChoice("SSRBH");
        AddMobChoice("Yagoos", 1, 2);
    });
}
