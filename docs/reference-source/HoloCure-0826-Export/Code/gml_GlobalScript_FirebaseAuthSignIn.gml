function FirebaseAuthSignInWithCallback(arg0, arg1)
{
    global.FirebaseSignInSuccessCallback = arg0;
    global.FirebaseSignInFailCallback = arg1;
    var loginManager = instance_find(obj_FirebaseLoginManager, 0);
    if (loginManager != -4)
    {
        loginManager.SignIn();
    }
}

function FirebaseAuthSignInSuccess()
{
    if (!variable_global_exists("FirebaseSignInSuccessCallback"))
    {
        global.FirebaseSignInSuccessCallback = undefined;
        global.FirebaseSignInFailCallback = undefined;
        exit;
    }
    show_debug_message("Sign In Success!");
    switch (global.FirebaseSignInSuccessCallback)
    {
        case UnknownEnum.Value_0:
            show_debug_message("Sign In Success! Post Score!");
            var playerMan = instance_find(obj_PlayerManager, 0);
            var hiScores = instance_find(obj_HiScores, 0);
            if (playerMan != -4 && hiScores != -4)
            {
                hiScores.PostScore(playerMan.localScoreResult, true);
            }
            break;
        case UnknownEnum.Value_3:
            show_debug_message("Sign In Success! Fetch Scores!");
            var hiScores = instance_find(obj_HiScores, 0);
            if (hiScores != -4)
            {
                hiScores.FetchScores(hiScores.selectedStage, true);
            }
            break;
    }
    global.FirebaseSignInSuccessCallback = undefined;
    global.FirebaseSignInFailCallback = undefined;
}

function FirebaseAuthSignInFail()
{
    if (!variable_global_exists("FirebaseSignInFailCallback"))
    {
        global.FirebaseSignInSuccessCallback = undefined;
        global.FirebaseSignInFailCallback = undefined;
        exit;
    }
    show_debug_message("Sign In Fail!");
    switch (global.FirebaseSignInFailCallback)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
            show_debug_message("Sign In Fail! Post Score Fail!");
            var playerMan = instance_find(obj_PlayerManager, 0);
            if (playerMan != -4)
            {
                playerMan.OnPostScoreFail(global.FirebaseSignInFailCallback != UnknownEnum.Value_2);
            }
            break;
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
            show_debug_message("Sign In Fail! Fetch Score Fail!");
            var hiScores = instance_find(obj_HiScores, 0);
            if (hiScores != -4)
            {
                hiScores.OnFetchScoreFail(global.FirebaseSignInFailCallback != UnknownEnum.Value_5);
            }
    }
    global.FirebaseSignInSuccessCallback = undefined;
    global.FirebaseSignInFailCallback = undefined;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5
}
