if (room == rm_ConcertStage)
{
    global.topBorder = -1;
    global.bottomBorder = -1;
    global.leftBorder = -1;
    global.rightBorder = -1;
    global.wrappingStage = true;
    AddTimeEvent(0, 0, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 120;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("TimeMob1", 14, 1);
    });
    AddTimeEvent(0, 0, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 110;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 1, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 110;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 1, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 110;
        spawnAmount = 6;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 2, 30, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 100;
        spawnAmount = 7;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("TimeMobBomber", 1, 1);
    });
    AddTimeEvent(0, 5, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 120;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
        AddMobChoice("TimeMobShooter", 1, 1);
    });
    AddTimeEvent(0, 10, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 100;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
        RemoveMobChoice("TimeMobShooter");
        AddMobChoice("TimeMobShooter", 1, 1);
    });
    AddTimeEvent(0, 15, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 90;
        spawnAmount = 8;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 20, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 90;
        spawnAmount = 9;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 25, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 90;
        spawnAmount = 10;
        currentSpawnPattern = "evenSurround";
    });
    AddTimeEvent(0, 30, 0, "ChangeSpawnRate", function()
    {
        enemyLimit = 150;
        spawnRate = 90;
        spawnAmount = 11;
        currentSpawnPattern = "evenSurround";
    });
    for (var i = 0; i < 30; i++)
    {
        AddTimeEvent(0, 1 + i, 0, "EventSpawnDropIn", EventSpawnDropIn, 
        {
            id: "TimeMobBoss",
            level: "1",
            amount: 1,
            dropType: "random",
            warnRadius: 20,
            warnTime: 120
        });
    }
}
