function CalculateScore()
{
    var baseScore = (global.enemyDefeated * 75) + (global.miniBossDefeated * 428) + (global.bossDefeated * 2251) + (max(0, global.time[UnknownEnum.Value_1] - 30) * 20126) + (min(59, global.time[UnknownEnum.Value_1]) * 126) + (min(59, global.time[UnknownEnum.Value_2]) * 10) + (global.PLAYERLEVEL * 1219);
    if ((baseScore + (ds_map_find_value(global.PlayerSave, "challenge") * floor(baseScore * ((global.time[UnknownEnum.Value_1] * 0.02) + (global.time[UnknownEnum.Value_0] * 1.2))))) >= 1000000)
    {
        DoAchievement("millionaire");
    }
    return floor(baseScore + (ds_map_find_value(global.PlayerSave, "challenge") * floor(baseScore * ((global.time[UnknownEnum.Value_1] * 0.01) + (global.time[UnknownEnum.Value_0] * 1.2)))));
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
