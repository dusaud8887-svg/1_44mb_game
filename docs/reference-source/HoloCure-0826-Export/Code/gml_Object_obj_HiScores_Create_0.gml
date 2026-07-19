leaderboardSortings = ["ASCENDING", "DESCENDING"];
leaderboardScorings = ["score", "duration", "timestamp"];
sortOrderStage = [
{
    sorting: UnknownEnum.Value_1,
    scoring: UnknownEnum.Value_0
}, 
{
    sorting: UnknownEnum.Value_0,
    scoring: UnknownEnum.Value_2
}];
sortOrderTimeStage = [
{
    sorting: UnknownEnum.Value_0,
    scoring: UnknownEnum.Value_1
}, 
{
    sorting: UnknownEnum.Value_1,
    scoring: UnknownEnum.Value_0
}, 
{
    sorting: UnknownEnum.Value_0,
    scoring: UnknownEnum.Value_2
}];
if (!variable_global_exists("stageLeaderboards"))
{
    stage1 = 
    {
        stageID: UnknownEnum.Value_0,
        leaderboardName: "stage1",
        leaderboardTop100Name: "sortedLeaderboards/stage1Top100",
        leaderboardTop1000Name: "sortedLeaderboards/stage1Top1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    stage2 = 
    {
        stageID: UnknownEnum.Value_1,
        leaderboardName: "stage2",
        leaderboardTop100Name: "sortedLeaderboards/stage2Top100",
        leaderboardTop1000Name: "sortedLeaderboards/stage2Top1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    stage3 = 
    {
        stageID: UnknownEnum.Value_2,
        leaderboardName: "stage3",
        leaderboardTop100Name: "sortedLeaderboards/stage3Top100",
        leaderboardTop1000Name: "sortedLeaderboards/stage3Top1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    stage4 = 
    {
        stageID: UnknownEnum.Value_3,
        leaderboardName: "stage4",
        leaderboardTop100Name: "sortedLeaderboards/stage4Top100",
        leaderboardTop1000Name: "sortedLeaderboards/stage4Top1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    stage1Hard = 
    {
        stageID: UnknownEnum.Value_4,
        leaderboardName: "stage1Hard",
        leaderboardTop100Name: "sortedLeaderboards/stage1HardTop100",
        leaderboardTop1000Name: "sortedLeaderboards/stage1HardTop1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    stage2Hard = 
    {
        stageID: UnknownEnum.Value_5,
        leaderboardName: "stage2Hard",
        leaderboardTop100Name: "sortedLeaderboards/stage2HardTop100",
        leaderboardTop1000Name: "sortedLeaderboards/stage2HardTop1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    stage3Hard = 
    {
        stageID: UnknownEnum.Value_6,
        leaderboardName: "stage3Hard",
        leaderboardTop100Name: "sortedLeaderboards/stage3HardTop100",
        leaderboardTop1000Name: "sortedLeaderboards/stage3HardTop1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    timeStage1 = 
    {
        stageID: UnknownEnum.Value_7,
        leaderboardName: "timeStage1",
        leaderboardTop100Name: "sortedLeaderboards/timeStage1Top100",
        leaderboardTop1000Name: "sortedLeaderboards/timeStage1Top1000",
        leaderboardTop100: undefined,
        leaderboardTop1000: undefined,
        top100FetchTime: undefined,
        top1000FetchTime: undefined,
        top100LastFetchAttempt: undefined,
        top1000LastFetchAttempt: undefined
    };
    global.stageLeaderboards = [stage1, stage2, stage3, stage4, stage1Hard, stage2Hard, stage3Hard, timeStage1];
}
currentOption = UnknownEnum.Value_0;
currentSettingsOption = UnknownEnum.Value_0;
changingName = false;
canType = false;
editingName = "";
renameOption = 0;
delete_timer = 0;
rectVis = true;
rectTime = 0;
canControl = true;
deleteScoresCounter = 0;
startingPosition = 0;
localScoreStartingPosition = 0;
canUpdate = true;
selectedStage = 0;
selectedCharacter = 0;
hideAll = false;
showingAllCharacter = false;
characterOption = 0;
localScore = undefined;
localScoreRanking = -1;
uidMatchRanking1 = -1;
uidMatchRanking2 = -1;
selectingAlpha = 0;
showOptions = false;
deleteConfirm = false;
deleteSelect = 1;
pauseContainer[0] = 320;
pauseContainer[1] = 80;
var currentStageData = GetCurrentStageData();
if (currentStageData != undefined)
{
    selectedStage = currentStageData.stageID;
}
if (variable_global_exists("charSelected"))
{
    for (var i = 0; i < array_length(global.characterList); i++)
    {
        if (global.charSelected.id == global.characterList[i])
        {
            selectedCharacter = i;
            break;
        }
    }
}
if (!variable_global_exists("hiscoreTimeCategory"))
{
    global.hiscoreTimeCategory = UnknownEnum.Value_0;
}

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirmed();
        canControl = false;
        alarm[1] = 5;
    }
}

function Confirmed()
{
    if (!canControl)
    {
        exit;
    }
    if (showOptions)
    {
        switch (currentSettingsOption)
        {
            case UnknownEnum.Value_0:
                if (!changingName)
                {
                    changingName = true;
                    canType = true;
                    editingName = global.username;
                    renameOption = -1;
                    keyboard_string = "";
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
                else if (renameOption == 0)
                {
                    global.username = editingName;
                    SaveSettings();
                    canType = false;
                    changingName = false;
                    renameOption = -1;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
                else if (renameOption == 1)
                {
                    ReturnMenu();
                }
                break;
            case UnknownEnum.Value_1:
                global.hiscorenames = !global.hiscorenames;
                audio_play_sound(snd_menu_confirm, 30, 0);
                break;
            case UnknownEnum.Value_2:
                SetAnonymousHiscoreName(!global.hiscoreName);
                audio_play_sound(snd_menu_confirm, 30, 0);
                break;
            case UnknownEnum.Value_3:
                audio_play_sound(snd_menu_confirm, 30, 0);
                if (!deleteConfirm)
                {
                    deleteConfirm = true;
                    deleteOption = 1;
                }
                else if (deleteOption == 0)
                {
                    deleteScoresCounter = 2;
                    deleteConfirm = false;
                    DeleteLeaderboardScores();
                    EvaluatePlayerScores();
                }
                else
                {
                    ReturnMenu();
                }
                break;
            case UnknownEnum.Value_4:
                ReturnMenu();
                break;
        }
        exit;
    }
    switch (currentOption)
    {
        case UnknownEnum.Value_0:
            FetchScores(selectedStage, false);
            audio_play_sound(snd_menu_confirm, 30, 0);
            break;
        case UnknownEnum.Value_1:
            if (showingAllCharacter)
            {
                if (characterOption < array_length(global.characterList) && IsCharacterUnlocked(global.characterList[characterOption]))
                {
                    selectedCharacter = characterOption;
                    startingPosition = localScoreStartingPosition;
                    showingAllCharacter = false;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    EvaluatePlayerScores();
                }
            }
            else
            {
                showingAllCharacter = true;
                characterOption = selectedCharacter;
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
            break;
        case UnknownEnum.Value_2:
            SelectRight();
            break;
        case UnknownEnum.Value_3:
            audio_play_sound(snd_menu_confirm, 30, 0);
            var leaderboard = GetCurrentTop100Leaderboard();
            if (leaderboard != undefined)
            {
                if ((startingPosition + 10) < array_length(leaderboard))
                {
                    startingPosition += 10;
                }
            }
            break;
        case UnknownEnum.Value_4:
            audio_play_sound(snd_menu_confirm, 30, 0);
            var leaderboard = GetCurrentTop100Leaderboard();
            if (leaderboard != undefined)
            {
                if ((startingPosition - 10) >= 0)
                {
                    startingPosition -= 10;
                }
            }
            break;
        case UnknownEnum.Value_5:
            audio_play_sound(snd_menu_confirm, 30, 0);
            startingPosition = localScoreStartingPosition;
            break;
        case UnknownEnum.Value_6:
            ReturnMenu();
            break;
        case UnknownEnum.Value_7:
            showOptions = true;
            currentSettingsOption = UnknownEnum.Value_0;
            deleteScoresCounter = 0;
            audio_play_sound(snd_menu_confirm, 30, 0);
            break;
    }
}

function ReturnMenu()
{
    if (!canControl)
    {
        exit;
    }
    canControl = false;
    alarm[1] = 5;
    if (room == rm_HiScores)
    {
        if (deleteConfirm)
        {
            deleteConfirm = false;
        }
        else
        {
            if (changingName)
            {
                if (renameOption > -1)
                {
                    changingName = false;
                    canType = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                exit;
            }
            if (showOptions)
            {
                showOptions = false;
                audio_play_sound(snd_menu_back, 30, 0);
                exit;
            }
            if (showingAllCharacter)
            {
                showingAllCharacter = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else
            {
                audio_play_sound(snd_menu_back, 30, 0);
                if (global.unlockedNew && array_length(global.unlockedThings) > 0)
                {
                    global.returningRoom = 3;
                    global.resetLevel = true;
                    room_goto(rm_UnlockRoom);
                }
                else
                {
                    room_goto(rm_Title);
                }
            }
        }
    }
}

function SelectLeft()
{
    SelectLeftRight(-1);
}

function SelectRight()
{
    SelectLeftRight(1);
}

function SelectLeftRight(arg0)
{
    if (changingName && renameOption != -1)
    {
        if (arg0 == -1)
        {
            renameOption = 0;
        }
        else
        {
            renameOption = 1;
        }
        audio_play_sound(snd_menu_select, 30, 0);
        exit;
    }
    if (showOptions)
    {
        exit;
    }
    var playSelectSound = false;
    if (showingAllCharacter)
    {
        characterOption += arg0;
        if (arg0 > 0 && (characterOption % 6) == 0)
        {
            characterOption -= 6;
        }
        else if (arg0 < 0 && ((characterOption + 1) % 6) == 0)
        {
            characterOption += 6;
        }
        playSelectSound = true;
    }
    else
    {
        switch (currentOption)
        {
            case UnknownEnum.Value_0:
                var stageLeaderboardsLength = array_length(global.stageLeaderboards);
                selectedStage += arg0;
                if (arg0 > 0 && selectedStage >= stageLeaderboardsLength)
                {
                    selectedStage = 0;
                }
                else if (arg0 < 0 && selectedStage < 0)
                {
                    selectedStage = stageLeaderboardsLength - 1;
                }
                FetchScores(selectedStage, false);
                playSelectSound = true;
                break;
            case UnknownEnum.Value_1:
                var characterAmount = array_length(global.characterList);
                do
                {
                    selectedCharacter += arg0;
                    if (arg0 > 0 && selectedCharacter >= characterAmount)
                    {
                        selectedCharacter = 0;
                    }
                    else if (arg0 < 0 && selectedCharacter < 0)
                    {
                        selectedCharacter = characterAmount - 1;
                    }
                }
                until (IsCharacterUnlocked(global.characterList[selectedCharacter]));
                EvaluatePlayerScores();
                playSelectSound = true;
                break;
            case UnknownEnum.Value_2:
                global.hiscoreTimeCategory += arg0;
                if (arg0 > 0 && global.hiscoreTimeCategory >= UnknownEnum.Value_2)
                {
                    global.hiscoreTimeCategory = 0;
                }
                else if (arg0 < 0 && global.hiscoreTimeCategory < 0)
                {
                    global.hiscoreTimeCategory = 1;
                }
                EvaluatePlayerScores();
                playSelectSound = true;
                break;
        }
    }
    if (playSelectSound)
    {
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectUp()
{
    SelectUpDown(-1);
}

function SelectDown()
{
    SelectUpDown(1);
}

function SelectUpDown(arg0)
{
    if (changingName)
    {
        if (canType)
        {
            if (input_profile_get() != "keyboard_and_mouse")
            {
                if (renameOption == -1)
                {
                    renameOption = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        exit;
    }
    if (deleteConfirm)
    {
        deleteOption = !deleteOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else
    {
        if (showOptions)
        {
            if ((arg0 < 0 && currentSettingsOption > 0) || (arg0 > 0 && currentSettingsOption < 4))
            {
                currentSettingsOption += arg0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            exit;
        }
        if (showingAllCharacter)
        {
            characterOption += (arg0 * 6);
            if (arg0 < 0 && characterOption < 0)
            {
                characterOption += 42;
            }
            else if (arg0 > 0 && characterOption > 42)
            {
                characterOption -= 42;
            }
            playSelectSound = true;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if ((arg0 < 0 && currentOption > 0) || (arg0 > 0 && currentOption < 7))
        {
            currentOption += arg0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

postScoreFromFailCallback = false;

function PostScore(arg0, arg1)
{
    postScoreFromFailCallback = arg1;
    if (!variable_global_exists("UID"))
    {
        FirebaseAuthSignInWithCallback(UnknownEnum.Value_0, UnknownEnum.Value_2);
        exit;
    }
    show_debug_message("Post Score with UID: " + global.UID);
    var currentStageData = GetCurrentStageData();
    if (currentStageData == undefined)
    {
        exit;
    }
    var leaderboard = undefined;
    var stageLeaderboardsLength = array_length(global.stageLeaderboards);
    for (var i = 0; i < stageLeaderboardsLength; i++)
    {
        if (currentStageData.stageID == global.stageLeaderboards[i].stageID)
        {
            leaderboard = global.stageLeaderboards[i];
            break;
        }
    }
    var username = global.username;
    if (global.hiscoreName)
    {
        username = TruncateUsernameToMaxLength(username);
    }
    else
    {
        username = "Anonymous";
    }
    var snapshot = obj_PlayerManager.playerSnapshot;
    var scoreSnapShot = 
    {
        version: global.version,
        mobsSpawned: global.mobsSpawned,
        enemyDefeated: global.enemyDefeated,
        timesDodged: global.timesDodged,
        rerolled: global.rerolled,
        eliminated: global.eliminated,
        invincibilityTimer: snapshot.invincibilityTimer,
        ATK: snapshot.ATK,
        SPD: snapshot.SPD,
        crit: snapshot.crit,
        pickupRange: snapshot.pickupRange,
        haste: snapshot.haste,
        HP: snapshot.HP,
        DR: snapshot.DR,
        EXP: snapshot.EXP,
        prebuffStats: snapshot.prebuffStats,
        baseStats: snapshot.baseStats
    };
    var snapshotString = base64_encode(json_stringify(scoreSnapShot, true));
    time = global.time[UnknownEnum.Value_2] + (global.time[UnknownEnum.Value_1] * 60) + (global.time[UnknownEnum.Value_0] * 3600);
    var json = json_stringify(
    {
        character: global.charSelected.id,
        duration: string_replace(string(time), ".0", ""),
        level: string_replace(string(global.PLAYERLEVEL), ".0", ""),
        name: username,
        score: string_replace(string(CalculateScore()), ".0", ""),
        uid: global.UID,
        icon: string_replace(string(255), ".0", ""),
        z_d: snapshotString
    });
    var scoreCategory = "";
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_2:
            scoreCategory = "daily";
            global.hiscoreTimeCategory = UnknownEnum.Value_1;
            break;
        case UnknownEnum.Value_1:
            scoreCategory = "allTime";
            global.hiscoreTimeCategory = UnknownEnum.Value_0;
            break;
        default:
            show_debug_message("ERROR! unhandled localScoreResult: " + string(arg0));
            exit;
    }
    if (!obj_PlayerManager.sussy)
    {
        FirebaseFirestore(leaderboard.leaderboardName + "/" + global.UID + "_" + global.charSelected.id + "_" + scoreCategory).Set(json);
    }
    else
    {
        alarm[0] = 20 + irandom(40);
    }
}

function CanFetchLeaderboard(arg0, arg1)
{
    switch (arg1)
    {
        case true:
            if (arg0.top100LastFetchAttempt != undefined && (!fetchScoreFromFailCallback && (arg0.top100LastFetchAttempt + 5000) > current_time))
            {
                return false;
            }
            else if (arg0.leaderboardTop100 == undefined)
            {
                return true;
            }
            else
            {
                return (arg0.top100FetchTime + 900000) < current_time;
            }
            break;
        case false:
            if (arg0.top1000LastFetchAttempt != undefined && (!fetchScoreFromFailCallback && (arg0.top1000LastFetchAttempt + 5000) > current_time))
            {
                return false;
            }
            else if (arg0.leaderboardTop1000 == undefined)
            {
                return true;
            }
            else
            {
                return (arg0.top1000FetchTime + 900000) < current_time;
            }
            break;
    }
}

fetchScoreFromFailCallback = false;

function FetchScores(arg0, arg1)
{
    fetchScoreFromFailCallback = arg1;
    leaderboard = global.stageLeaderboards[arg0];
    if (!variable_global_exists("UID"))
    {
        FirebaseAuthSignInWithCallback(UnknownEnum.Value_3, UnknownEnum.Value_5);
        exit;
    }
    if (leaderboard == undefined)
    {
        startingPosition = 0;
        exit;
    }
    if (CanFetchLeaderboard(leaderboard, false))
    {
        fetchScoreError = false;
        global.stageLeaderboards[arg0].top1000LastFetchAttempt = current_time;
        global.stageLeaderboards[arg0].leaderboardTop1000 = undefined;
        document = FirebaseFirestore(leaderboard.leaderboardTop1000Name);
        document.Read();
    }
    if (CanFetchLeaderboard(leaderboard, true))
    {
        fetchScoreError = false;
        global.stageLeaderboards[arg0].top100LastFetchAttempt = current_time;
        global.stageLeaderboards[arg0].leaderboardTop100 = undefined;
        document = FirebaseFirestore(leaderboard.leaderboardTop100Name);
        document.Read();
        startingPosition = 0;
        exit;
    }
    EvaluatePlayerScores();
}

fetchScoreNetworkStatusOK = false;
fetchScoreError = false;

function OnFetchScoreFail(arg0)
{
    fetchScoreNetworkStatusOK = arg0;
    fetchScoreError = true;
}

function OnFirebaseFirestoreDocumentAddOrUpdate()
{
    var playerMan = instance_find(obj_PlayerManager, 0);
    with (playerMan)
    {
        instance_destroy();
    }
    room_goto(rm_HiScores);
}

function OnFirebaseFirestoreDocumentRead(arg0, arg1, arg2)
{
    var fetchedLeaderboardIndex = -1;
    var isTop1000 = false;
    show_debug_message("check for path!: " + arg0);
    for (var i = 0; i < array_length(global.stageLeaderboards); i++)
    {
        if (arg0 == global.stageLeaderboards[i].leaderboardTop100Name)
        {
            show_debug_message("is top 100!");
            fetchedLeaderboardIndex = i;
            isTop1000 = false;
            break;
        }
        else if (arg0 == global.stageLeaderboards[i].leaderboardTop1000Name)
        {
            show_debug_message("is top 1000!");
            fetchedLeaderboardIndex = i;
            isTop1000 = true;
            break;
        }
    }
    if (fetchedLeaderboardIndex == -1)
    {
        show_debug_message("ERROR! - fetched document is not in our leaderboard list: " + arg0);
        exit;
    }
    var document = json_parse(arg2);
    if (!variable_struct_exists(document, "fields"))
    {
        show_debug_message("OnFirebaseFirestoreDocumentRead - returned document did not have expected field - [fields]");
        exit;
    }
    if (!variable_struct_exists(document.fields, "allTime"))
    {
        show_debug_message("OnFirebaseFirestoreDocumentRead - returned document did not have expected field - [allTime]");
        exit;
    }
    if (!isTop1000 && !variable_struct_exists(document.fields, "daily"))
    {
        show_debug_message("OnFirebaseFirestoreDocumentRead - returned document did not have expected field - [daily]");
        exit;
    }
    if (!isTop1000 && !variable_struct_exists(document.fields, "hoursLeft"))
    {
        show_debug_message("OnFirebaseFirestoreDocumentRead - returned document did not have expected field - [hoursLeft]");
        exit;
    }
    var allTime = FirestoreDecodeVariableStruct(document.fields.allTime);
    if (isTop1000)
    {
        global.stageLeaderboards[fetchedLeaderboardIndex].top1000FetchTime = current_time;
        global.stageLeaderboards[fetchedLeaderboardIndex].leaderboardTop1000 = 
        {
            allTime: allTime
        };
    }
    else
    {
        var daily = FirestoreDecodeVariableStruct(document.fields.daily);
        var stageType = ds_map_find_value(global.stages, global.stageIDNames[global.stageLeaderboards[fetchedLeaderboardIndex].stageID]).stageType;
        allTime = MergeDailyIntoAllTimeTop100(daily, allTime, stageType);
        var hoursLeft = FirestoreDecodeVariableStruct(document.fields.hoursLeft);
        if (!is_int64(hoursLeft))
        {
            hoursLeft = UnknownEnum.Value_0;
        }
        global.stageLeaderboards[fetchedLeaderboardIndex].top100FetchTime = current_time;
        global.stageLeaderboards[fetchedLeaderboardIndex].leaderboardTop100 = 
        {
            allTime: allTime,
            daily: daily,
            hoursLeft: hoursLeft
        };
    }
    EvaluatePlayerScores();
}

function MergeDailyIntoAllTimeTop100(arg0, arg1, arg2)
{
    var names = ds_map_keys_to_array(arg1);
    for (var i = 0; i < array_length(names); i++)
    {
        ds_map_set(arg1, array_get(names, i), MergeCharacterDailyIntoAllTimeTop100(ds_map_find_value(arg0, array_get(names, i)), ds_map_find_value(arg1, array_get(names, i)), arg2));
    }
    return arg1;
}

function MergeCharacterDailyIntoAllTimeTop100(arg0, arg1, arg2)
{
    var dailyLength = array_length(arg0);
    if (dailyLength == 0)
    {
        return arg1;
    }
    var allTimeIndex = 0;
    for (var i = 0; i < dailyLength; i++)
    {
        allTimeLength = array_length(arg1);
        var dailyEntry = arg0[i];
        var dailyScore = UnknownEnum.Value_0;
        var dailyUID = "";
        var dailyDuration = UnknownEnum.Value_0;
        if (ds_map_exists(dailyEntry, "s") && is_int64(ds_map_find_value(dailyEntry, "s")))
        {
            dailyScore = ds_map_find_value(dailyEntry, "s");
        }
        else
        {
            continue;
        }
        if (ds_map_exists(dailyEntry, "u") && is_string(ds_map_find_value(dailyEntry, "u")))
        {
            dailyUID = ds_map_find_value(dailyEntry, "u");
        }
        else
        {
            continue;
        }
        if (ds_map_exists(dailyEntry, "d") && is_int64(ds_map_find_value(dailyEntry, "d")))
        {
            dailyDuration = ds_map_find_value(dailyEntry, "d");
        }
        else
        {
            continue;
        }
        var appendToAllTime = true;
        while (allTimeIndex < allTimeLength)
        {
            var allTimeEntry = arg1[allTimeIndex];
            var allTimeScore = UnknownEnum.Value_0;
            var allTimeUID = "";
            if (ds_map_exists(allTimeEntry, "s") && is_int64(ds_map_find_value(allTimeEntry, "s")))
            {
                allTimeScore = ds_map_find_value(allTimeEntry, "s");
            }
            else
            {
                allTimeIndex++;
                continue;
            }
            if (ds_map_exists(allTimeEntry, "u") && is_string(ds_map_find_value(allTimeEntry, "u")))
            {
                allTimeUID = ds_map_find_value(allTimeEntry, "u");
            }
            else
            {
                allTimeIndex++;
                continue;
            }
            var exitLoop = false;
            switch (arg2)
            {
                case UnknownEnum.Value_0:
                    if (dailyScore > allTimeScore)
                    {
                        array_insert(arg1, allTimeIndex, dailyEntry);
                        exitLoop = true;
                        appendToAllTime = false;
                    }
                    else if (dailyScore == allTimeScore)
                    {
                        if (dailyUID == allTimeUID)
                        {
                            exitLoop = true;
                            appendToAllTime = false;
                        }
                    }
                    break;
                case UnknownEnum.Value_1:
                    var allTimeDuration = UnknownEnum.Value_0;
                    if (ds_map_exists(allTimeEntry, "d") && is_int64(ds_map_find_value(allTimeEntry, "d")))
                    {
                        allTimeDuration = ds_map_find_value(allTimeEntry, "d");
                    }
                    else
                    {
                        exitLoop = true;
                        break;
                    }
                    if (dailyDuration < allTimeDuration)
                    {
                        array_insert(arg1, allTimeIndex, dailyEntry);
                        exitLoop = true;
                        appendToAllTime = false;
                    }
                    else if (dailyDuration == allTimeDuration)
                    {
                        if (dailyScore > allTimeScore)
                        {
                            array_insert(arg1, allTimeIndex, dailyEntry);
                            exitLoop = true;
                            appendToAllTime = false;
                        }
                        else if (dailyScore == allTimeScore)
                        {
                            if (dailyUID == allTimeUID)
                            {
                                exitLoop = true;
                                appendToAllTime = false;
                            }
                        }
                    }
                    break;
            }
            allTimeIndex++;
            if (exitLoop)
            {
                break;
            }
        }
        if (appendToAllTime && allTimeIndex < 99)
        {
            array_push(arg1, dailyEntry);
        }
    }
    var allTimeLength = array_length(arg1);
    if (allTimeLength > 99)
    {
        array_resize(arg1, 99);
    }
    return arg1;
}

function OnFirebaseFirestoreCollectionQuery(arg0, arg1)
{
}

function GetDailyHoursLeft()
{
    var hasLeaderboard = global.stageLeaderboards[selectedStage].leaderboardTop100 != undefined;
    if (!hasLeaderboard)
    {
        return undefined;
    }
    return global.stageLeaderboards[selectedStage].leaderboardTop100.hoursLeft;
}

function GetCurrentTop100Leaderboard()
{
    var hasLeaderboard = global.stageLeaderboards[selectedStage].leaderboardTop100 != undefined;
    var characterHasLeaderboard = false;
    var leaderboard = undefined;
    if (hasLeaderboard)
    {
        switch (global.hiscoreTimeCategory)
        {
            case UnknownEnum.Value_0:
                leaderboard = global.stageLeaderboards[selectedStage].leaderboardTop100.allTime;
                break;
            case UnknownEnum.Value_1:
                leaderboard = global.stageLeaderboards[selectedStage].leaderboardTop100.daily;
                break;
        }
        characterHasLeaderboard = ds_map_exists(leaderboard, global.characterList[selectedCharacter]);
    }
    return characterHasLeaderboard ? ds_map_find_value(leaderboard, global.characterList[selectedCharacter]) : undefined;
}

function GetCurrentTop1000Leaderboard()
{
    if (global.hiscoreTimeCategory != UnknownEnum.Value_0)
    {
        return undefined;
    }
    var hasLeaderboard = global.stageLeaderboards[selectedStage].leaderboardTop1000 != undefined;
    var characterHasLeaderboard = false;
    var leaderboard = undefined;
    if (hasLeaderboard)
    {
        leaderboard = global.stageLeaderboards[selectedStage].leaderboardTop1000.allTime;
        characterHasLeaderboard = ds_map_exists(leaderboard, global.characterList[selectedCharacter]);
    }
    return characterHasLeaderboard ? ds_map_find_value(leaderboard, global.characterList[selectedCharacter]) : undefined;
}

function GetLocalScoreForSelection()
{
    var localScoreEntry = GetLocalScore(global.stageLeaderboards[selectedStage].stageID, global.characterList[selectedCharacter]);
    var localScore = undefined;
    if (localScoreEntry != undefined)
    {
        switch (global.hiscoreTimeCategory)
        {
            case UnknownEnum.Value_0:
                localScore = localScoreEntry.allTime;
                break;
            case UnknownEnum.Value_1:
                if (DailyScoreIsValid(localScoreEntry))
                {
                    localScore = localScoreEntry.daily.score;
                }
                break;
        }
    }
    return localScore;
}

function LeaderboardOrLocalScoreExists(arg0, arg1)
{
    if (arg0 == undefined)
    {
        return false;
    }
    var leaderboardSize = array_length(arg0);
    if (leaderboardSize <= 0 && arg1 == undefined)
    {
        return false;
    }
    return true;
}

function GetSelectedCharacterData()
{
    return ds_map_find_value(global.characterData, global.characterList[selectedCharacter]);
}

function GetStageType()
{
    return ds_map_find_value(global.stages, global.stageIDNames[global.stageLeaderboards[selectedStage].stageID]).stageType;
}

function EvaluatePlayerScores()
{
    localScoreRanking = -1;
    uidMatchRanking1 = -1;
    uidMatchRanking2 = -1;
    localScore = GetLocalScoreForSelection();
    var leaderboard = GetCurrentTop100Leaderboard();
    var leaderboardTop1000 = GetCurrentTop1000Leaderboard();
    if (!LeaderboardOrLocalScoreExists(leaderboard, localScore))
    {
        exit;
    }
    var leaderboardSize = array_length(leaderboard);
    leaderboardSize = (leaderboardSize > 0) ? leaderboardSize : 0;
    var char = GetSelectedCharacterData();
    var stageType = GetStageType();
    var shortUID = GetShortUID();
    if (localScore != undefined)
    {
        localScoreRanking = (leaderboardSize == 0) ? 0 : -1;
        var UIDMatch = false;
        for (var i = 0; i < leaderboardSize; i++)
        {
            var leaderboardScore = UnknownEnum.Value_0;
            if (ds_map_exists(leaderboard[i], "s") && is_int64(ds_map_find_value(array_get(leaderboard, i), "s")))
            {
                leaderboardScore = ds_map_find_value(array_get(leaderboard, i), "s");
            }
            var leaderboardUID = "";
            if (ds_map_exists(leaderboard[i], "u") && is_string(ds_map_find_value(array_get(leaderboard, i), "u")))
            {
                leaderboardUID = ds_map_find_value(array_get(leaderboard, i), "u");
            }
            var leaderboardDuration = UnknownEnum.Value_0;
            if (ds_map_exists(leaderboard[i], "d") && is_int64(ds_map_find_value(array_get(leaderboard, i), "d")))
            {
                leaderboardDuration = ds_map_find_value(array_get(leaderboard, i), "d");
            }
            var endOfLoop = false;
            switch (stageType)
            {
                case UnknownEnum.Value_0:
                    if (localScore.score > leaderboardScore)
                    {
                        localScoreRanking = i;
                        endOfLoop = true;
                    }
                    else if (localScore.score == leaderboardScore)
                    {
                        if (shortUID == leaderboardUID)
                        {
                            localScore = undefined;
                            UIDMatch = true;
                            endOfLoop = true;
                        }
                        else
                        {
                            localScoreRanking = i + 1;
                        }
                    }
                    break;
                case UnknownEnum.Value_1:
                    if (localScore.duration < leaderboardDuration)
                    {
                        localScoreRanking = i;
                        endOfLoop = true;
                    }
                    else if (localScore.duration == leaderboardDuration)
                    {
                        if (shortUID == leaderboardUID)
                        {
                            localScore = undefined;
                            UIDMatch = true;
                            endOfLoop = true;
                        }
                        else if (localScore.score > leaderboardScore)
                        {
                            localScoreRanking = i;
                            endOfLoop = true;
                        }
                        else if (localScore.score == leaderboardScore)
                        {
                            localScoreRanking = i + 1;
                        }
                    }
                    else
                    {
                        endOfLoop = true;
                    }
                    break;
            }
            if (endOfLoop)
            {
                break;
            }
        }
        if (!UIDMatch && localScoreRanking == -1)
        {
            if (leaderboardTop1000 != undefined)
            {
                var leaderboardTop1000Size = array_length(leaderboardTop1000);
                localScoreRanking = leaderboardSize + leaderboardTop1000Size;
                var endOfLoop = false;
                for (var i = 0; i < leaderboardTop1000Size; i++)
                {
                    switch (stageType)
                    {
                        case UnknownEnum.Value_0:
                            if (localScore.score > leaderboardTop1000[i])
                            {
                                localScoreRanking = i + leaderboardSize;
                                endOfLoop = true;
                            }
                            break;
                        case UnknownEnum.Value_1:
                            if (localScore.duration < leaderboardTop1000[i])
                            {
                                localScoreRanking = i + leaderboardSize;
                                endOfLoop = true;
                            }
                            break;
                    }
                    if (endOfLoop)
                    {
                        break;
                    }
                }
            }
            else
            {
                localScoreRanking = leaderboardSize;
            }
        }
    }
    for (var i = 0; i < leaderboardSize; i++)
    {
        var leaderboardUID = "";
        if (ds_map_exists(leaderboard[i], "u") && is_string(ds_map_find_value(array_get(leaderboard, i), "u")))
        {
            leaderboardUID = ds_map_find_value(array_get(leaderboard, i), "u");
        }
        if (shortUID == leaderboardUID)
        {
            if (uidMatchRanking1 == -1)
            {
                uidMatchRanking1 = i;
            }
            else if (uidMatchRanking2 == -1)
            {
                uidMatchRanking2 = i;
                break;
            }
        }
    }
    var highestScoreRank = -1;
    if (uidMatchRanking1 != -1)
    {
        highestScoreRank = uidMatchRanking1;
    }
    if (localScoreRanking != -1 && (highestScoreRank == -1 || localScoreRanking < highestScoreRank))
    {
        highestScoreRank = localScoreRanking;
    }
    if (highestScoreRank == -1)
    {
        localScoreStartingPosition = 0;
    }
    else
    {
        localScoreStartingPosition = min(highestScoreRank, 99);
        localScoreStartingPosition = 10 * floor(localScoreStartingPosition / 10);
    }
    startingPosition = localScoreStartingPosition;
}

if (room == rm_HiScores)
{
    FetchScores(selectedStage, false);
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
    Value_7
}
