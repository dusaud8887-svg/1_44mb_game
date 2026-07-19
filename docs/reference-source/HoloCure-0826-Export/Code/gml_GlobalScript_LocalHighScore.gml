function GetLocalScore(arg0, arg1)
{
    if (!ds_map_exists(global.PlayerSave, "LocalScores"))
    {
        return undefined;
    }
    var localScores = ds_map_find_value(global.PlayerSave, "LocalScores");
    var stageIDName = global.stageIDNames[arg0];
    if (!variable_struct_exists(localScores, stageIDName))
    {
        return undefined;
    }
    var stageScores = variable_struct_get(localScores, stageIDName);
    if (!variable_struct_exists(stageScores, arg1))
    {
        return undefined;
    }
    return variable_struct_get(stageScores, arg1);
}

function SaveLocalScore(arg0)
{
    if (!ds_map_exists(global.PlayerSave, "LocalScores"))
    {
        ds_map_add(global.PlayerSave, "LocalScores", {});
    }
    var localScores = ds_map_find_value(global.PlayerSave, "LocalScores");
    var currentStageData = GetCurrentStageData();
    if (currentStageData == undefined)
    {
        return UnknownEnum.Value_0;
    }
    if (!variable_struct_exists(localScores, currentStageData.stageIDName))
    {
        variable_struct_set(localScores, currentStageData.stageIDName, {});
    }
    var stageScores = variable_struct_get(localScores, currentStageData.stageIDName);
    var stageDuration = global.time[UnknownEnum.Value_2] + (global.time[UnknownEnum.Value_1] * 60) + (global.time[UnknownEnum.Value_0] * 3600);
    var newScore = 
    {
        duration: stageDuration,
        score: CalculateScore(),
        level: global.PLAYERLEVEL
    };
    var scoreResult = UnknownEnum.Value_0;
    if (variable_struct_exists(stageScores, global.charSelected.id))
    {
        var existingScore = variable_struct_get(stageScores, global.charSelected.id);
        var allTimeScore = existingScore.allTime;
        var dailyScore = existingScore.daily;
        var currentDateTime = CurrentScoreDate();
        var dailyIsValid = DailyScoreIsValid(existingScore);
        var beatsAllTimeScore = BeatsScore(allTimeScore, newScore, currentStageData.stageType);
        var beatsDailyScore = arg0;
        beatsDailyScore = BeatsScore(dailyScore.score, newScore, currentStageData.stageType);
        if (beatsAllTimeScore)
        {
            allTimeScore = newScore;
            dailyScore = 
            {
                timestamp: currentDateTime,
                score: newScore
            };
            scoreResult = UnknownEnum.Value_1;
        }
        else if (!dailyIsValid || beatsDailyScore || arg0)
        {
            dailyScore = 
            {
                timestamp: currentDateTime,
                score: newScore
            };
            if (beatsDailyScore || !dailyIsValid)
            {
                if (!dailyIsValid)
                {
                }
                else
                {
                }
                scoreResult = UnknownEnum.Value_2;
            }
            else
            {
                scoreResult = UnknownEnum.Value_0;
            }
        }
        variable_struct_set(stageScores, global.charSelected.id, 
        {
            allTime: allTimeScore,
            daily: dailyScore
        });
    }
    else
    {
        variable_struct_set(stageScores, global.charSelected.id, 
        {
            allTime: newScore,
            daily: 
            {
                timestamp: CurrentScoreDate(),
                score: newScore
            }
        });
        scoreResult = UnknownEnum.Value_1;
    }
    variable_struct_set(localScores, currentStageData.stageIDName, stageScores);
    ds_map_set(global.PlayerSave, "LocalScores", localScores);
    return scoreResult;
}

function DailyScoreIsValid(arg0)
{
    var currentScoreDate = CurrentScoreDate();
    if (date_get_year(currentScoreDate) != date_get_year(arg0.daily.timestamp))
    {
        return false;
    }
    return date_get_day_of_year(currentScoreDate) == date_get_day_of_year(arg0.daily.timestamp);
}

function CurrentScoreDate()
{
    if (date_get_timezone() != 1)
    {
        date_set_timezone(1);
    }
    var currentDateTime = date_current_datetime();
    return date_inc_hour(currentDateTime, -15);
}

function BeatsScore(arg0, arg1, arg2)
{
    switch (arg2)
    {
        case UnknownEnum.Value_0:
            if (arg0.score >= arg1.score)
            {
                return false;
            }
            break;
        case UnknownEnum.Value_1:
            if (arg0.duration < arg1.duration)
            {
                return false;
            }
            else if (arg0.duration == arg1.duration)
            {
                if (arg0.score >= arg1.score)
                {
                    return false;
                }
            }
            break;
    }
    return true;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
