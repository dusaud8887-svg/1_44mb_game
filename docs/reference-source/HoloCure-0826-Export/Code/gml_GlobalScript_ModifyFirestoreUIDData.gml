function SetAnonymousHiscoreName(arg0)
{
    if (variable_global_exists("SetAnonymousHiscoreNameTimeout"))
    {
        if (current_time < (global.SetAnonymousHiscoreNameTimeout + 12000))
        {
            exit;
        }
    }
    if (!variable_global_exists("UID"))
    {
        exit;
    }
    global.hiscoreName = arg0;
    var username = TruncateUsernameToMaxLength(global.username);
    var json = json_stringify(
    {
        name: global.hiscoreName ? username : "Anonymous"
    });
    FirebaseFirestore("uidData/" + global.UID).Set(json);
    global.SetAnonymousHiscoreNameTimeout = current_time;
}

function DeleteLeaderboardScores()
{
    if (variable_global_exists("DeleteLeaderboardScoresTimeout"))
    {
        if (current_time < (global.DeleteLeaderboardScoresTimeout + 12000))
        {
            exit;
        }
    }
    if (!variable_global_exists("UID"))
    {
        exit;
    }
    var json = json_stringify(
    {
        name: "deletingScores",
        deleteScores: true
    });
    FirebaseFirestore("uidData/" + global.UID).Set(json);
    if (ds_map_exists(global.PlayerSave, "LocalScores"))
    {
        ds_map_set(global.PlayerSave, "LocalScores", {});
        SavePlayerSave();
    }
    global.DeleteLeaderboardScoresTimeout = current_time;
}
