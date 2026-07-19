paused = true;
gameWon = true;
pauseOption = 0;
dankTime = 0;
part_emitter_destroy_all(global.psystem);
Pause();
if (!is_undefined(audio_bus_main.effects[0]))
{
    audio_bus_main.effects[0].bypass = true;
}
audio_stop_sound(global.bgmPlay);
audio_stop_sound(snd_rain);
audio_stop_sound(snd_snowqueenwind);
audio_group_set_gain(1, global.musicVolume, 500);
global.bgmPlay = 208;
audio_play_sound(global.bgmPlay, 100, false);
gameOverTextContainer = [320, -100];
gameOverTime = 0;
if (global.gameMode < 2)
{
    haluBonusCoins = 0;
    if (global.haluLevel > 0)
    {
        haluBonusCoins = floor((global.enemyDefeated - global.preHaluDefeated) / global.haluLevel) * global.stageCoinBonus;
    }
    var stage = GetCurrentStageData();
    var clearAmount = stage.coinRewardOnClear;
    winBonus = floor(((haluBonusCoins + global.enemyDefeated) * 0.25) + clearAmount);
    CheckStageBasedAchievements();
    if (string_pos("HARD", stage.stageIDName) != 0)
    {
        CheckHardModeAchievements();
    }
    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + floor(global.currentRunMoneyGained + haluBonusCoins + winBonus));
    if (ds_map_find_value(global.PlayerSave, "holoCoins") >= 5000)
    {
        DoAchievement("SCT");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "SuperChattoTime", "ITEM");
    }
    if (ds_map_find_value(global.PlayerSave, "holoCoins") >= 1000000)
    {
        DoAchievement("grind");
    }
    if (global.enemyDefeated >= 5000)
    {
        DoAchievement("delusional");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Halu", "ITEM");
    }
    if (variable_struct_exists(playerSnapshot, "attacks"))
    {
        if (HadWeapon(playerSnapshot.attacks, ["Tailplug", "BreatheInAsacoco"]))
        {
            DoAchievement("safeISwear");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "InjectionAsacoco", "ITEM");
        }
    }
    if (HadItem(items, "SuperChattoTime"))
    {
        DoAchievement("buyingPower");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Membership", "ITEM");
    }
    if (HadItem(items, "Sake"))
    {
        DoAchievement("wamy");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "WamyWater", "WEAPON");
    }
    if (global.playingStage == 10)
    {
        DoAchievement("secondboss");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "CEOTears", "WEAPON");
    }
    if (global.playingStage == 7)
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2", "STAGE");
    }
    if (global.playingStage == 10)
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 1 (HARD)", "STAGE");
    }
    if (global.playingStage == 10)
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3", "STAGE");
    }
    if (global.playingStage == 13)
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 2 (HARD)", "STAGE");
    }
    if (global.playingStage == 17)
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 3 (HARD)", "STAGE");
    }
    if (global.playingStage == 16)
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "STAGE 4", "STAGE");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedStages"), "TIME STAGE 1", "STAGE");
        ds_map_set(global.PlayerSave, "timeModeUnlocked", true);
    }
    var getStage = "";
    var stageFound = false;
    var stageIndex = -1;
    var isHard = false;
    if (stage != undefined)
    {
        getStage = stage.stageIDName;
    }
    if (string_pos("(HARD)", getStage) != 0)
    {
        isHard = true;
    }
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "completedStages")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == getStage)
        {
            stageIndex = i;
            stageFound = true;
        }
    }
    if (!stageFound)
    {
        array_push(ds_map_find_value(global.PlayerSave, "completedStages"), [getStage, [global.charSelected.id]]);
    }
    else if (!array_exists(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), stageIndex), 1), global.charSelected.id))
    {
        array_push(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), stageIndex), 1), global.charSelected.id);
        if (isHard)
        {
            AddFandomEXP(global.charSelected.id, 20);
        }
        else
        {
            AddFandomEXP(global.charSelected.id, 10);
        }
    }
    else if (isHard)
    {
        AddFandomEXP(global.charSelected.id, 10);
    }
    else
    {
        AddFandomEXP(global.charSelected.id, 7);
    }
    if (array_length(ds_map_find_value(global.PlayerSave, "characterClears")) == 0)
    {
        array_push(ds_map_find_value(global.PlayerSave, "characterClears"), [global.charSelected.id, 1]);
    }
    else
    {
        var found = -1;
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characterClears")); i++)
        {
            if (array_exists(array_get(ds_map_find_value(global.PlayerSave, "characterClears"), i), global.charSelected.id))
            {
                found = i;
            }
        }
        if (found >= 0)
        {
            array_set_post(array_get(ds_map_find_value(global.PlayerSave, "characterClears"), found), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "characterClears"), found), 1) + 1);
        }
        else
        {
            array_push(ds_map_find_value(global.PlayerSave, "characterClears"), [global.charSelected.id, 1]);
        }
    }
    if (numberOfOwnedWeapons == 1)
    {
        DoAchievement("soloBeater");
    }
    if (global.charSelected.id == "irys")
    {
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "HopeSoda", "ITEM");
    }
    DoAchievement("firstclear");
    var clearAchievement = global.charSelected.id + "Clear";
    DoAchievement(clearAchievement);
}
else
{
    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + floor(global.currentRunMoneyGained));
}
localScoreResult = UnknownEnum.Value_0;
if (CanSubmitScore())
{
    localScoreResult = SaveLocalScore(false);
    overwriteDaily = false;
}
if (!choseOtherOptions)
{
    DoAchievement("nothoughts");
}
SavePlayerSave();
DetermineFollowings();

enum UnknownEnum
{
    Value_0
}
