pauseOption = 0;
pauseMenu = -1;
interactIcon = 212;
menuContainer = [110, 50];
highlighted = false;
inventoryMenu = [200, 50];
startingPosition = 0;
inventorySelect = 0;
itemArray = [];
interactIconY = 60;
interactRange = 40;
manageNextEXP = floor(50 + (50 * (ds_map_find_value(global.PlayerSave, "manageLevel") - 1) * 2 * (ds_map_find_value(global.PlayerSave, "manageLevel") - 0.5)));
removeConfirm = false;
canType = false;
renameString = "";
spriteColor = 16777215;
interactable = true;
interacting = false;
canControl = true;
pauseItems = 5;
cursorTime = 0;
menuItems = 0;
manageSelect = 0;
manageConfirm = false;
managePage = 0;
hireCost = 500;
hireConfirm = 0;
hireSelect = 0;
workers = [];
recruits = [];
recruiting = false;
workerOption = 0;
feedSelect = 0;
feedAmount = 0;
feedConfirm = false;
levelUpConfirm = false;
levelUpTimer = 0;
waitTime = 15;
resultsContainer = [320, 110];
storedTime = 0;
manageLevelConfirm = false;
manageLevelTimer = 0;
removeOption = 0;
pauseContainer[0] = 320;
pauseContainer[1] = 70;
delete_timer = 0;
rectVis = true;
rectTime = 0;
renameOption = -1;
animationTime = 0;
event_user(0);

function CollectCoin(arg0, arg1 = -4)
{
    var roll = irandom(99);
    if (roll < 40)
    {
        arg0.currentCoin += arg0.efficiency;
        arg0.totalCollected += arg0.efficiency;
        if (instance_exists(arg1))
        {
            var coin = instance_create_depth(arg1.x, arg1.y - 16, arg1.depth - 10, obj_GetFish);
            coin.sprite_index = spr_holoCoin;
            coin.image_speed = 0;
            coin.waitTime = 20;
        }
    }
}

function CalculateStoredTime(arg0)
{
    var currentStamina;
    var secondsPassed = storedTime div 60;
    var staminaLost = storedTime div 600;
    staminaLost = floor(staminaLost + (staminaLost * random_range(-0.1, 0.1)));
    var timesCollected = 0;
    if (secondsPassed > (staminaLost * 10))
    {
        secondsPassed = secondsPassed - (staminaLost * 10);
    }
    if (arg0.currentStamina > 0)
    {
        arg0.currentStamina--;
    }
    while (arg0.currentStamina > 0 && (staminaLost > 0 || secondsPassed > 0))
    {
        if (staminaLost > 0)
        {
            for (var i = 0; i < 10; i++)
            {
                CollectCoin(arg0);
                timesCollected++;
            }
            arg0.currentStamina--;
            staminaLost--;
        }
        else
        {
            CollectCoin(arg0);
            timesCollected++;
            secondsPassed--;
        }
    }
}

function SaveWorkers()
{
    var workerData = [];
    for (var i = 0; i < array_length(workers); i++)
    {
        var eachWorker;
        if (workers[i][0] != -1)
        {
            eachWorker = [workers[i][0].fanID, workers[i][0].sprite, workers[i][0].recruitName, workers[i][0].efficiency, workers[i][0].exprate, workers[i][0].maxStamina, workers[i][0].maxLevel, workers[i][0].nextEXP, workers[i][0].tier, workers[i][0].currentFeed, workers[i][0].currentStamina, workers[i][0].currentLevel, workers[i][0].currentEXP, workers[i][0].currentCoin, workers[i][0].totalCollected];
        }
        array_push(workerData, eachWorker);
    }
    ds_map_set(global.PlayerSave, "manageWorkers", workerData);
    SavePlayerSave();
}

function LoadWorkers()
{
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "manageWorkers")); i++)
    {
        var loadedWorker = [{}, -1];
        if (!is_undefined(variable_struct_get(fandomIDs, array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 0))))
        {
            loadedWorker[0].fanID = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 0);
            loadedWorker[0].sprite = variable_struct_get(fandomIDs, array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 0)).sprite;
            loadedWorker[0].recruitName = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 2);
            loadedWorker[0].efficiency = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 3);
            loadedWorker[0].exprate = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 4);
            loadedWorker[0].maxStamina = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 5);
            loadedWorker[0].maxLevel = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 6);
            loadedWorker[0].nextEXP = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 7);
            loadedWorker[0].tier = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 8);
            loadedWorker[0].currentFeed = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 9);
            loadedWorker[0].currentStamina = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 10);
            loadedWorker[0].currentLevel = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 11);
            loadedWorker[0].currentEXP = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 12);
            loadedWorker[0].currentCoin = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 13);
            loadedWorker[0].totalCollected = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 14);
            CalculateStoredTime(loadedWorker[0]);
            workers[i] = loadedWorker;
        }
        else if (array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 0) == "zomerade")
        {
            loadedWorker[0].fanID = "zomrade";
            loadedWorker[0].sprite = variable_struct_get(fandomIDs, "zomrade").sprite;
            loadedWorker[0].recruitName = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 2);
            loadedWorker[0].efficiency = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 3);
            loadedWorker[0].exprate = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 4);
            loadedWorker[0].maxStamina = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 5);
            loadedWorker[0].maxLevel = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 6);
            loadedWorker[0].nextEXP = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 7);
            loadedWorker[0].tier = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 8);
            loadedWorker[0].currentFeed = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 9);
            loadedWorker[0].currentStamina = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 10);
            loadedWorker[0].currentLevel = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 11);
            loadedWorker[0].currentEXP = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 12);
            loadedWorker[0].currentCoin = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 13);
            loadedWorker[0].totalCollected = array_get(array_get(ds_map_find_value(global.PlayerSave, "manageWorkers"), i), 14);
            CalculateStoredTime(loadedWorker[0]);
            workers[i] = loadedWorker;
        }
    }
    manageNextEXP = floor(50 + (50 * (ds_map_find_value(global.PlayerSave, "manageLevel") - 1) * 2 * (ds_map_find_value(global.PlayerSave, "manageLevel") - 0.5)));
    storedTime = 0;
}

function InitRecruits()
{
    recruits = [];
    var exampleRecruit = 
    {
        fanID: "shrimp",
        sprite: 1833,
        recruitName: "Test Name",
        efficiency: 3,
        exprate: -1,
        maxStamina: 40,
        maxLevel: 10,
        tier: 0
    };
    var lastPosition = 
    {
        fanID: -1,
        sprite: -1,
        recruitName: "BuyRecruits",
        efficiency: -1,
        exprate: -1,
        maxStamina: -1,
        maxLevel: -1,
        tier: -1
    };
    array_push(recruits, lastPosition);
}

function LevelWorker(arg0)
{
    if (workers[arg0][0].currentLevel < workers[arg0][0].maxLevel)
    {
        resultsContainer[1] = -120;
        levelUpConfirm = true;
        workers[arg0][0].currentLevel++;
        if (workers[arg0][0].currentLevel != workers[arg0][0].maxLevel)
        {
            workers[arg0][0].currentEXP = workers[arg0][0].currentEXP - workers[arg0][0].nextEXP;
            workers[arg0][0].nextEXP += 1;
        }
        else
        {
            DoAchievement("employee");
            workers[arg0][0].currentEXP = 0;
        }
        workers[arg0][0].efficiency++;
        workers[arg0][1].efficiency++;
        workers[arg0][0].maxStamina += 2;
        workers[arg0][1].maxStamina += 2;
        audio_play_sound(snd_workerlevel, 0, false);
        workers[arg0][0].currentFeed = obj_HoloHouseManager.GetRandomFeed(workers[arg0][0].tier);
        if (ds_map_find_value(global.PlayerSave, "manageLevel") < 4)
        {
            ds_map_set(global.PlayerSave, "manageEXP", ds_map_find_value(global.PlayerSave, "manageEXP") + (workers[arg0][0].currentLevel * 0.5));
            if (ds_map_find_value(global.PlayerSave, "manageEXP") >= manageNextEXP)
            {
                ds_map_set(global.PlayerSave, "manageEXP", ds_map_find_value(global.PlayerSave, "manageEXP") - manageNextEXP);
                ds_map_set_post(global.PlayerSave, "manageLevel", ds_map_find_value(global.PlayerSave, "manageLevel") + 1);
                manageNextEXP = floor(50 + (50 * (ds_map_find_value(global.PlayerSave, "manageLevel") - 1) * 2 * (ds_map_find_value(global.PlayerSave, "manageLevel") - 0.5)));
                manageLevelConfirm = true;
                manageLevelTimer = 0;
            }
        }
        if (ds_map_find_value(global.PlayerSave, "manageLevel") >= 4)
        {
            DoAchievement("welltrained");
            if (ds_map_find_value(global.PlayerSave, "manageEXP") > 0)
            {
                ds_map_set(global.PlayerSave, "manageEXP", 0);
            }
        }
        SaveWorkers();
    }
}

function FeedWorker(arg0, arg1, arg2)
{
    audio_play_sound(snd_feed, 5, false);
    var getFood = ds_map_find_value(global.InventoryLibrary, arg1);
    var staminaHeal = arg2 * floor(workers[arg0][0].maxStamina * 0.2);
    workers[arg0][1].currentStamina += staminaHeal;
    if (workers[arg0][1].currentStamina >= workers[arg0][1].maxStamina)
    {
        workers[arg0][1].currentStamina = workers[arg0][1].maxStamina;
    }
    workers[arg0][0].currentStamina = workers[arg0][1].currentStamina;
    if (workers[arg0][0].currentLevel != workers[arg0][0].maxLevel)
    {
        var expGain = arg2 * workers[arg0][0].exprate * (1 + getFood.config.tier);
        workers[arg0][0].currentEXP += expGain;
    }
    inventory_remove(arg1, arg2);
    SaveWorkers();
}

function RollRecruits()
{
    recruits = [];
    startingPosition = 0;
    inventorySelect = 0;
    var unlockedFans = [];
    var allfans = variable_struct_get_names(fandomIDs);
    for (var i = 0; i < array_length(allfans); i++)
    {
        if (IsCharacterUnlocked(variable_struct_get(fandomIDs, allfans[i]).char))
        {
            array_push(unlockedFans, allfans[i]);
        }
    }
    array_push(unlockedFans, "ssrb");
    for (var i = 0; i < 6; i++)
    {
        var randomFan = irandom(array_length(unlockedFans) - 1);
        if (i == 0)
        {
            for (var j = 0; j < array_length(unlockedFans); j++)
            {
                if (variable_struct_get(fandomIDs, unlockedFans[j]).char == global.charSelected.id)
                {
                    randomFan = j;
                }
            }
        }
        var _tier = 0 + max(0, irandom(ds_map_find_value(global.PlayerSave, "manageLevel") - 1));
        var nameArray = variable_struct_get(fanNames, unlockedFans[randomFan]);
        var theName = "";
        if (!global.hhCustomNames || is_undefined(nameArray))
        {
            theName = RollRecruitName();
        }
        else
        {
            theName = nameArray[irandom(array_length(nameArray) - 1)];
        }
        var exampleRecruit = 
        {
            fanID: unlockedFans[randomFan],
            sprite: variable_struct_get(fandomIDs, unlockedFans[randomFan]).sprite,
            recruitName: theName,
            efficiency: 1 + irandom(3) + (_tier * 2),
            exprate: 1 + (_tier * 0.05) + random(0.2) + random(_tier * 0.05),
            maxStamina: floor(30 + (irandom(20) * ((1 + _tier) * 0.5)) + (5 * _tier)),
            maxLevel: 10 + (5 * _tier) + irandom(10 + (5 * _tier)),
            tier: _tier
        };
        array_push(recruits, exampleRecruit);
    }
    var lastPosition = 
    {
        fanID: -1,
        sprite: -1,
        recruitName: "BuyRecruits",
        efficiency: -1,
        exprate: -1,
        maxStamina: -1,
        maxLevel: -1,
        tier: -1
    };
    array_push(recruits, lastPosition);
}

function SendAwayWorker()
{
    with (workers[inventorySelect + startingPosition][1])
    {
        instance_destroy();
    }
    array_delete(workers, inventorySelect + startingPosition, 1);
    for (var i = 0; i < array_length(workers); i++)
    {
        workers[i][1].index = i;
    }
    DoAchievement("howcouldyou");
    SaveWorkers();
}

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirm();
        if (canControl)
        {
            canControl = false;
            alarm[0] = 5;
        }
    }
}

function Confirm()
{
    if (highlighted && !interacting && obj_Player.canControl)
    {
        interacting = true;
        if (obj_Player.x > x)
        {
            obj_Player.direction = 180;
        }
        else
        {
            obj_Player.direction = 0;
        }
        audio_play_sound(snd_boardinteract, 30, 0);
        menuContainer = [-210, 50];
        pauseMenu = -1;
        obj_Player.canControl = false;
        obj_HoloHouseManager.canControl = false;
    }
    else if (interacting && canControl)
    {
        switch (pauseMenu)
        {
            case -1:
                switch (pauseOption)
                {
                    case UnknownEnum.Value_0:
                        pauseMenu = 0;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        startingPosition = 0;
                        inventorySelect = 0;
                        inventoryMenu = [800, 50];
                        break;
                    case UnknownEnum.Value_1:
                        pauseMenu = 1;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        startingPosition = 0;
                        inventorySelect = 0;
                        inventoryMenu = [800, 50];
                        break;
                    case UnknownEnum.Value_2:
                        pauseMenu = 2;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        startingPosition = 0;
                        inventorySelect = 0;
                        inventoryMenu = [800, 50];
                        break;
                    case UnknownEnum.Value_3:
                        canControl = false;
                        obj_DialogueController.BeginDialogue(global.TextContainer.workerDialogue.selectedLanguage, id);
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        show_debug_message(canControl);
                        break;
                    case UnknownEnum.Value_4:
                        Return();
                        break;
                }
                break;
            case UnknownEnum.Value_0:
                if (array_length(workers) > 0)
                {
                    if (manageConfirm)
                    {
                        switch (workerOption)
                        {
                            case UnknownEnum.Value_0:
                                pauseMenu = 5;
                                audio_play_sound(snd_menu_confirm, 30, 0);
                                break;
                            case UnknownEnum.Value_1:
                                pauseMenu = 6;
                                feedAmount = 0;
                                feedSelect = 0;
                                audio_play_sound(snd_menu_confirm, 30, 0);
                                break;
                            case UnknownEnum.Value_2:
                                if (!canType)
                                {
                                    canType = true;
                                    keyboard_string = "";
                                    renameOption = -1;
                                    renameString = workers[inventorySelect + startingPosition][0].recruitName;
                                    audio_play_sound(snd_menu_confirm, 30, 0);
                                }
                                else if (renameOption == 0)
                                {
                                    workers[inventorySelect + startingPosition][0].recruitName = renameString;
                                    workers[inventorySelect + startingPosition][1].recruitName = renameString;
                                    workers[inventorySelect + startingPosition][1].ResetName();
                                    canType = false;
                                    audio_play_sound(snd_menu_confirm, 30, 0);
                                    SaveWorkers();
                                }
                                else if (renameOption == 1)
                                {
                                    Return();
                                }
                                break;
                            case UnknownEnum.Value_3:
                                if (removeConfirm)
                                {
                                    if (removeOption == 0)
                                    {
                                        SendAwayWorker();
                                        removeConfirm = false;
                                        manageConfirm = false;
                                        audio_play_sound(snd_stickersell, 30, 0);
                                        startingPosition = 0;
                                        inventorySelect = 0;
                                    }
                                    else
                                    {
                                        removeConfirm = false;
                                        audio_play_sound(snd_menu_back, 30, 0);
                                    }
                                }
                                else
                                {
                                    removeOption = 0;
                                    audio_play_sound(snd_menu_confirm, 30, 0);
                                    removeConfirm = true;
                                }
                                break;
                        }
                    }
                    else
                    {
                        manageConfirm = true;
                        workerOption = 0;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_1:
                if ((inventorySelect + startingPosition) == (array_length(recruits) - 1))
                {
                    if (hireConfirm)
                    {
                        if (hireSelect == 0 && ds_map_find_value(global.PlayerSave, "holoCoins") >= hireCost)
                        {
                            recruiting = true;
                            hireConfirm = false;
                            ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") - hireCost);
                            audio_play_sound(snd_menu_confirm, 30, 0);
                            audio_play_sound(snd_boardinteract, 30, 0);
                            RollRecruits();
                        }
                        else if (hireSelect == 1)
                        {
                            Return();
                        }
                    }
                    else if (array_length(workers) < 10)
                    {
                        hireConfirm = true;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                else if (hireConfirm)
                {
                    if (hireSelect == 0)
                    {
                        recruiting = false;
                        hireConfirm = false;
                        audio_play_sound(snd_buyworker, 30, 0);
                        var hiredRecruit = recruits[inventorySelect + startingPosition];
                        var worker = 
                        {
                            fanID: hiredRecruit.fanID,
                            sprite: hiredRecruit.sprite,
                            recruitName: hiredRecruit.recruitName,
                            efficiency: hiredRecruit.efficiency,
                            exprate: hiredRecruit.exprate,
                            maxStamina: hiredRecruit.maxStamina,
                            maxLevel: hiredRecruit.maxLevel,
                            nextEXP: 3,
                            tier: hiredRecruit.tier,
                            currentFeed: -1,
                            currentStamina: hiredRecruit.maxStamina,
                            currentLevel: 1,
                            currentEXP: 0,
                            currentCoin: 0,
                            totalCollected: 0
                        };
                        array_push(workers, [worker, -1]);
                        InitRecruits();
                        SaveWorkers();
                        startingPosition = 0;
                        inventorySelect = 0;
                    }
                    else if (hireSelect == 1)
                    {
                        Return();
                    }
                }
                else
                {
                    hireConfirm = true;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
                break;
            case UnknownEnum.Value_2:
                if (array_length(workers) > 0)
                {
                    var getTotal = 0;
                    for (var i = 0; i < array_length(workers); i++)
                    {
                        getTotal += workers[i][0].currentCoin;
                        workers[i][0].currentCoin = 0;
                    }
                    if (getTotal > 0)
                    {
                        if (getTotal >= 100000)
                        {
                            DoAchievement("highwayrobbery");
                        }
                        ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + getTotal);
                        SaveWorkers();
                        audio_play_sound(snd_getmoney, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_6:
                if (levelUpConfirm && levelUpTimer >= waitTime)
                {
                    levelUpConfirm = false;
                    levelUpTimer = 0;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    if (manageLevelConfirm)
                    {
                        resultsContainer[1] = -120;
                    }
                }
                else if (manageLevelConfirm && manageLevelTimer >= waitTime)
                {
                    manageLevelConfirm = false;
                    manageLevelTimer = 0;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
                else if (!feedConfirm)
                {
                    if (feedAmount > 0)
                    {
                        feedConfirm = true;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        var getFeed = ds_map_find_value(global.InventoryLibrary, workers[inventorySelect + startingPosition][0].currentFeed);
                        var expGain = feedAmount * workers[inventorySelect + startingPosition][0].exprate * (1 + getFeed.config.tier);
                    }
                }
                else if (feedSelect == 0)
                {
                    feedConfirm = false;
                    FeedWorker(inventorySelect + startingPosition, workers[inventorySelect + startingPosition][0].currentFeed, feedAmount);
                    feedAmount = 0;
                }
                else
                {
                    feedConfirm = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                break;
        }
    }
}

function Return()
{
    if (interacting)
    {
        if (levelUpConfirm)
        {
            exit;
        }
        if (manageLevelConfirm)
        {
            exit;
        }
        if (!canControl)
        {
            exit;
        }
        switch (pauseMenu)
        {
            case -1:
                interacting = false;
                obj_Player.canControl = true;
                obj_HoloHouseManager.alarm[1] = 5;
                audio_play_sound(snd_menu_back, 30, 0);
                pauseMenu = -1;
                pauseOption = 0;
                break;
            case UnknownEnum.Value_0:
                if (manageConfirm)
                {
                    if (removeConfirm)
                    {
                        removeConfirm = false;
                        audio_play_sound(snd_menu_back, 30, 0);
                    }
                    else if (canType)
                    {
                        if (renameOption != -1)
                        {
                            canType = false;
                            audio_play_sound(snd_menu_back, 30, 0);
                        }
                    }
                    else
                    {
                        manageConfirm = false;
                        audio_play_sound(snd_menu_back, 30, 0);
                    }
                }
                else
                {
                    pauseMenu = -1;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                break;
            case UnknownEnum.Value_1:
                if (hireConfirm)
                {
                    hireConfirm = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                else
                {
                    pauseMenu = -1;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                break;
            case UnknownEnum.Value_2:
                pauseMenu = -1;
                audio_play_sound(snd_menu_back, 30, 0);
                break;
            case UnknownEnum.Value_5:
                pauseMenu = UnknownEnum.Value_0;
                audio_play_sound(snd_menu_back, 30, 0);
                break;
            case UnknownEnum.Value_6:
                if (feedConfirm)
                {
                    feedConfirm = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                else
                {
                    feedAmount = 0;
                    pauseMenu = UnknownEnum.Value_0;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                break;
        }
    }
}

function SelectLeft()
{
    if (interacting)
    {
        if (levelUpConfirm)
        {
            exit;
        }
        if (manageLevelConfirm)
        {
            exit;
        }
        if (removeConfirm)
        {
            exit;
        }
        switch (pauseMenu)
        {
            case UnknownEnum.Value_0:
                if (manageConfirm)
                {
                    if (canType)
                    {
                        if (renameOption > -1)
                        {
                            renameOption = -1;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                    }
                    else if (workerOption == 0 || workerOption == 1)
                    {
                        workerOption += 2;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else
                    {
                        workerOption -= 2;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_1:
                if (hireConfirm)
                {
                    hireSelect = !hireSelect;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
            case UnknownEnum.Value_6:
                if (!feedConfirm)
                {
                    var getFeed = ds_map_find_value(global.InventoryLibrary, workers[inventorySelect + startingPosition][0].currentFeed);
                    var inventoryAmount = item_get(getFeed.inventoryID);
                    if (!is_undefined(inventoryAmount) && inventoryAmount > 0)
                    {
                        if (feedAmount > 0)
                        {
                            feedAmount--;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                    }
                }
                else
                {
                    feedSelect = !feedSelect;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
        }
    }
}

function SelectRight()
{
    if (interacting)
    {
        if (levelUpConfirm)
        {
            exit;
        }
        if (manageLevelConfirm)
        {
            exit;
        }
        if (removeConfirm)
        {
            exit;
        }
        switch (pauseMenu)
        {
            case UnknownEnum.Value_0:
                if (manageConfirm)
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
                    else if (workerOption == 0 || workerOption == 1)
                    {
                        workerOption += 2;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else
                    {
                        workerOption -= 2;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_1:
                if (hireConfirm)
                {
                    hireSelect = !hireSelect;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
            case UnknownEnum.Value_6:
                if (!feedConfirm)
                {
                    var getFeed = ds_map_find_value(global.InventoryLibrary, workers[inventorySelect + startingPosition][0].currentFeed);
                    var inventoryAmount = item_get(getFeed.inventoryID);
                    var staminaHeal = feedAmount * floor(workers[inventorySelect + startingPosition][0].maxStamina * 0.2);
                    var expGain = feedAmount * workers[inventorySelect + startingPosition][0].exprate * (1 + getFeed.config.tier);
                    if (!is_undefined(inventoryAmount) && inventoryAmount > 0)
                    {
                        if (feedAmount < inventoryAmount)
                        {
                            if (!((workers[inventorySelect + startingPosition][0].currentStamina + staminaHeal) >= workers[inventorySelect + startingPosition][0].maxStamina && (workers[inventorySelect + startingPosition][0].currentEXP + expGain) >= workers[inventorySelect + startingPosition][0].nextEXP))
                            {
                                if (!(workers[inventorySelect + startingPosition][0].currentLevel == workers[inventorySelect + startingPosition][0].maxLevel && (workers[inventorySelect + startingPosition][0].currentStamina + staminaHeal) >= workers[inventorySelect + startingPosition][0].maxStamina))
                                {
                                    feedAmount++;
                                    audio_play_sound(snd_menu_select, 30, 0);
                                }
                            }
                        }
                    }
                }
                else
                {
                    feedSelect = !feedSelect;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
        }
    }
}

function SelectUp()
{
    if (interacting)
    {
        if (levelUpConfirm)
        {
            exit;
        }
        if (manageLevelConfirm)
        {
            exit;
        }
        if (!canControl)
        {
            exit;
        }
        if (feedConfirm)
        {
            exit;
        }
        if (pauseMenu == -1)
        {
            if (pauseOption > 0)
            {
                pauseOption--;
            }
            else
            {
                pauseOption = pauseItems - 1;
            }
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (pauseMenu == UnknownEnum.Value_0)
        {
            if (!manageConfirm && array_length(workers) > 1)
            {
                if (inventorySelect > 0)
                {
                    inventorySelect--;
                }
                else if (array_length(workers) > (inventorySelect + 1))
                {
                    if ((inventorySelect + startingPosition) > 0)
                    {
                        startingPosition--;
                    }
                    else
                    {
                        startingPosition = max(0, array_length(workers) - 3);
                        inventorySelect = array_length(workers) - startingPosition - 1;
                    }
                }
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (manageConfirm)
            {
                if (removeConfirm)
                {
                    removeOption = !removeOption;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (canType)
                {
                    if (renameOption != -1)
                    {
                        renameOption = !renameOption;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                else if (workerOption == 0 || workerOption == 2)
                {
                    workerOption++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    workerOption--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (pauseMenu == UnknownEnum.Value_5 || pauseMenu == UnknownEnum.Value_6)
        {
            feedAmount = 0;
            if (array_length(workers) > 1)
            {
                if (inventorySelect > 0)
                {
                    inventorySelect--;
                }
                else if (array_length(workers) > (inventorySelect + 1))
                {
                    if ((inventorySelect + startingPosition) > 0)
                    {
                        startingPosition--;
                    }
                    else
                    {
                        startingPosition = max(0, array_length(workers) - 3);
                        inventorySelect = array_length(workers) - startingPosition - 1;
                    }
                }
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (pauseMenu == UnknownEnum.Value_1)
        {
            if (!hireConfirm)
            {
                if (inventorySelect > 0)
                {
                    inventorySelect--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (array_length(recruits) > (inventorySelect + 1))
                {
                    if ((inventorySelect + startingPosition) > 0)
                    {
                        startingPosition--;
                    }
                    else
                    {
                        startingPosition = max(0, array_length(recruits) - 3);
                        inventorySelect = array_length(recruits) - startingPosition - 1;
                    }
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectDown()
{
    if (interacting)
    {
        if (levelUpConfirm)
        {
            exit;
        }
        if (manageLevelConfirm)
        {
            exit;
        }
        if (!canControl)
        {
            exit;
        }
        if (feedConfirm)
        {
            exit;
        }
        if (pauseMenu == -1)
        {
            if (pauseOption < (pauseItems - 1))
            {
                pauseOption++;
            }
            else
            {
                pauseOption = 0;
            }
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (pauseMenu == UnknownEnum.Value_0)
        {
            if (!manageConfirm && array_length(workers) > 1)
            {
                if (inventorySelect < 2 && array_length(workers) > (inventorySelect + 1))
                {
                    inventorySelect++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    if ((inventorySelect + startingPosition) < (array_length(workers) - 1))
                    {
                        startingPosition++;
                    }
                    else
                    {
                        inventorySelect = 0;
                        startingPosition = 0;
                    }
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (manageConfirm)
            {
                if (removeConfirm)
                {
                    removeOption = !removeOption;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (canType)
                {
                    if (renameOption != -1)
                    {
                        renameOption = !renameOption;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                else if (workerOption == 0 || workerOption == 2)
                {
                    workerOption++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    workerOption--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (pauseMenu == UnknownEnum.Value_5 || pauseMenu == UnknownEnum.Value_6)
        {
            feedAmount = 0;
            if (array_length(workers) > 1)
            {
                if (inventorySelect < 2 && array_length(workers) > (inventorySelect + 1))
                {
                    inventorySelect++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    if ((inventorySelect + startingPosition) < (array_length(workers) - 1))
                    {
                        startingPosition++;
                    }
                    else
                    {
                        inventorySelect = 0;
                        startingPosition = 0;
                    }
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (pauseMenu == UnknownEnum.Value_1)
        {
            if (!hireConfirm && array_length(recruits) > 1)
            {
                if (inventorySelect < 2 && array_length(recruits) > (inventorySelect + 1))
                {
                    inventorySelect++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    if ((inventorySelect + startingPosition) < (array_length(recruits) - 1))
                    {
                        startingPosition++;
                    }
                    else
                    {
                        inventorySelect = 0;
                        startingPosition = 0;
                    }
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

InitRecruits();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
