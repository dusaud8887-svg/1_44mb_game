if (enabledSpawner && !global.timePause)
{
    while (enemyAmount < enemyLimit && timer <= 0)
    {
        timer = spawnRate;
        timeSinceLastSpawn = 0;
        var stepSpawnAmount = max(1, round((spawnAmount + global.additionalSpawn + (ds_map_find_value(global.PlayerSave, "mobUp") * (global.gameMode < 2))) / global.reducedSpawn) + ((global.gameMode == 2) * global.timeModeSpawnScale));
        while (stepSpawnAmount > 0)
        {
            SpawnEnemyFromChoices(false);
            stepSpawnAmount--;
        }
    }
    if (timer > 0)
    {
        timer--;
    }
}
if (global.gameMode == 2)
{
    global.timeModeSpawnScale = global.enemyDefeated div 500;
    global.timeModeRateScale = global.enemyDefeated div 250;
}
timeSinceLastSpawn++;
if (variable_global_exists("resetLevel"))
{
    if (global.resetLevel)
    {
        global.resetLevel = false;
        room_persistent = false;
        room_restart();
        with (obj_PlayerManager)
        {
            instance_destroy();
        }
        show_debug_message("resetting Level");
    }
}
if (sequenceSpawn)
{
    if (sequenceSpawnTimer > 0)
    {
        sequenceSpawnTimer--;
    }
    else
    {
        sequenceSpawnTimer = sequenceSpawnTime;
        var pos = {};
        pos.x = sequenceConfig.setPosition.x + lengthdir_x(sequenceConfig.dropDistance, sequenceConfig.circleDir * sequenceIndex);
        pos.y = sequenceConfig.setPosition.y + lengthdir_y(sequenceConfig.dropDistance, sequenceConfig.circleDir * sequenceIndex);
        obj_MobManager.SpawnMob(sequenceConfig.mobId, pos, sequenceConfig.level, sequenceConfig.spawnOverride, sequenceConfig.warnTime, sequenceConfig.warnRadius);
        sequenceIndex++;
        if (sequenceIndex >= sequenceConfig.amount)
        {
            sequenceIndex = 0;
            sequenceSpawn = false;
            sequenceTimer = 0;
            sequenceTime = 0;
            sequenceConfig = {};
        }
    }
}
