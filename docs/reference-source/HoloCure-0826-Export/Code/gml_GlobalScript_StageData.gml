function StageDataSetStages()
{
    if (variable_global_exists("stages"))
    {
        exit;
    }
    global.stageIDNames = array_create(UnknownEnum.Value_9);
    global.stageIDNames[UnknownEnum.Value_0] = "STAGE 1";
    global.stageIDNames[UnknownEnum.Value_1] = "STAGE 2";
    global.stageIDNames[UnknownEnum.Value_2] = "STAGE 3";
    global.stageIDNames[UnknownEnum.Value_3] = "STAGE 4";
    global.stageIDNames[UnknownEnum.Value_4] = "STAGE 1 (HARD)";
    global.stageIDNames[UnknownEnum.Value_5] = "STAGE 2 (HARD)";
    global.stageIDNames[UnknownEnum.Value_6] = "STAGE 3 (HARD)";
    global.stageIDNames[UnknownEnum.Value_7] = "TIME STAGE 1";
    global.stageIDNames[UnknownEnum.Value_8] = "HOLO HOUSE";
    var stageID = UnknownEnum.Value_0;
    stage1 = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_0,
        room: Room1,
        stageSprite: 1372,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[0]);
        },
        
        coinMultiplier: 1,
        coinRewardOnClear: 2000,
        recommendedStats: {}
    };
    stageID = UnknownEnum.Value_1;
    stage2 = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_0,
        room: rm_HoloOffice,
        stageSprite: 29,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[1]);
        },
        
        coinMultiplier: 1.2,
        coinRewardOnClear: 3000,
        recommendedStats: 
        {
            ATK: 2,
            SPD: 2
        }
    };
    stageID = UnknownEnum.Value_2;
    stage3 = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_0,
        room: rm_Castle,
        stageSprite: 1444,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[3]);
        },
        
        coinMultiplier: 1.3,
        coinRewardOnClear: 4000,
        recommendedStats: 
        {
            ATK: 3,
            SPD: 3
        }
    };
    stageID = UnknownEnum.Value_3;
    stage4 = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_0,
        room: rm_IDArena,
        stageSprite: 2193,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[6]);
        },
        
        coinMultiplier: 1.4,
        coinRewardOnClear: 5000,
        recommendedStats: 
        {
            ATK: 4,
            SPD: 4
        }
    };
    stageID = UnknownEnum.Value_4;
    stage1Hard = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_0,
        room: rm_GrassPlains_Night,
        stageSprite: 645,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[2]);
        },
        
        coinMultiplier: 1.4,
        coinRewardOnClear: 5000,
        recommendedStats: 
        {
            ATK: 5,
            SPD: 5
        }
    };
    stageID = UnknownEnum.Value_5;
    stage2Hard = 
    {
        stageID: UnknownEnum.Value_5,
        stageType: UnknownEnum.Value_0,
        room: rm_HoloOffice_SunSet,
        stageSprite: 541,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[4]);
        },
        
        coinMultiplier: 1.6,
        coinRewardOnClear: 10000,
        recommendedStats: 
        {
            ATK: 6,
            SPD: 6
        }
    };
    stageID = UnknownEnum.Value_6;
    stage3Hard = 
    {
        stageID: UnknownEnum.Value_6,
        stageType: UnknownEnum.Value_0,
        room: rm_CastleMyth,
        stageSprite: 1254,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[7]);
        },
        
        coinMultiplier: 1.8,
        coinRewardOnClear: 20000,
        recommendedStats: 
        {
            ATK: 7,
            SPD: 7
        }
    };
    stageID = UnknownEnum.Value_7;
    timeStage1 = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_1,
        room: rm_ConcertStage,
        stageSprite: 686,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.timestageNames.selectedLanguage[0]);
        },
        
        coinMultiplier: 1,
        recommendedStats: {}
    };
    stageID = UnknownEnum.Value_8;
    holoHouse = 
    {
        stageID: stageID,
        stageType: UnknownEnum.Value_2,
        room: rm_HoloHouse_Entrance,
        stageSprite: 1134,
        stageIDName: global.stageIDNames[stageID],
        
        stageName: function()
        {
            return string(global.TextContainer.stageNames.selectedLanguage[5]);
        },
        
        coinMultiplier: 1,
        recommendedStats: {}
    };
    global.stages = ds_map_create();
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_0], stage1);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_1], stage2);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_2], stage3);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_3], stage4);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_4], stage1Hard);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_5], stage2Hard);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_6], stage3Hard);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_7], timeStage1);
    ds_map_add(global.stages, global.stageIDNames[UnknownEnum.Value_8], holoHouse);
    if (global.debug)
    {
        global.stageIDNamesDebug = array_create(UnknownEnum.Value_1);
        global.stageIDNamesDebug[UnknownEnum.Value_0] = "STAGE 1 DEBUG";
        stageID = UnknownEnum.Value_0;
        stage1Debug = 
        {
            stageID: stageID,
            stageType: UnknownEnum.Value_3,
            room: Room1_debug,
            stageSprite: 1372,
            stageIDName: global.stageIDNamesDebug[stageID],
            
            stageName: function()
            {
                return string(global.TextContainer.stageNames.selectedLanguage[0]);
            },
            
            coinMultiplier: 1,
            coinRewardOnClear: 0,
            recommendedStats: {}
        };
        ds_map_add(global.stages, global.stageIDNamesDebug[UnknownEnum.Value_0], stage1Debug);
    }
}

function GetCurrentStageData()
{
    if (!variable_global_exists("playingStage") || !variable_global_exists("stages"))
    {
        return undefined;
    }
    var stageKey = ds_map_find_first(global.stages);
    while (!is_undefined(stageKey))
    {
        var stage = ds_map_find_value(global.stages, stageKey);
        if (stage.room == global.playingStage && stage.room != rm_HoloHouse_Entrance)
        {
            return stage;
        }
        stageKey = ds_map_find_next(global.stages, stageKey);
    }
    return undefined;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9
}
