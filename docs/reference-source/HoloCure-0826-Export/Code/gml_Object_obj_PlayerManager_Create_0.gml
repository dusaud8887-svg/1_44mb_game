commandsOnUnpause = {};
audio_stop_sound(bgm_SSS);
pauseOption = 0;
if (!variable_global_exists("resetLevel"))
{
    global.resetLevel = false;
}
glr_clear_all();
global.lightingExists = false;
controlsFree = false;
paused = false;
paused_screen_sprite = -1;
paused_screen = -1;
reviving = false;
gotBox = false;
charPortrait = -1;
charWeapon = -1;
charSpecial = -1;
charName = "";
depth = -9999;
playerGotMoney = false;
superDank = 0;
superDankTime = 0;
specialIconPulseTime = 0;
specialColorTime = 0;
hurtTime = 0;
global.PLAYERLEVEL = 1;
specialMeter = 0;
canSpecial = false;
toNextLevel = 78.79324245;
lvlrate1 = 4;
lvlexponent = 2.1;
dontTouchTriggered = false;
leveled = false;
levelOptionSelect = 0;
leftcontainer[0] = -100;
leftcontainer[1] = 130;
middlecontainer[0] = 200;
middlecontainer[1] = 400;
rightcontainer[0] = 740;
rightcontainer[1] = 53;
textPage = 0;
blackFlash = 1;
itemBoxContainer[0] = 220;
itemBoxContainer[1] = -500;
boxAnimState = 0;
boxBounceTime = 0;
boxOpenTime = 0;
boxOpenned = false;
superLit = 0;
itemBoxTakeOption = 0;
boxItemAmount = 0;
currentBoxItem = 0;
listOfWeaponsToPush = [];
boxCoinGain = 0;
boxCoinTime = 0;
boxCoinRate = 0;
superBox = false;
skillSelect = 0;
hudcontainer[0] = 4;
hudcontainer[1] = 20;
attacksCopy = 0;
pauseContainer[0] = 320;
pauseContainer[1] = 70;
pauseCurrentMenu = 0;
perksMenu = false;
gameOvered = false;
dankTime = 0;
gameOverTextContainer = [320, -110];
gameOverTime = 0;
gameWon = false;
hpSus = 1;
gotAnvil = false;
anvilContainer = [700, 100];
anvilOption = 0;
loadOutList = array_create(12, -1);
validLevelOptions = array_create(12, false);
currentAttackList = -1;
anvilOptionSelected = false;
anvilID = -1;
enhancing = false;
enhancingTime = 0;
enhanceDone = false;
enhanceResult = false;
usedAnvil = false;
upgradeOption = 0;
upgradeActionSelected = false;
global.goldAnvilCanDrop = false;
gotGoldenAnvil = false;
anvilOption = 0;
loadOutList = array_create(12, -1);
validCollabOptions = array_create(6, false);
currentAttackList = -1;
bigstuffs = [0, 0, 0, 0, 0, 0, 0];
lastCheck = 5;
goldenAnvilOption = 0;
goldenAnvilOptionSelected1 = false;
goldenAnvilOptionSelected2 = false;
goldenOptionSelected = false;
collabingWeapon = -1;
anvilID = -1;
collabing = false;
collabingTime = 0;
collabDone = false;
collabResult = false;
livesGained = 0;
timesRevived = 0;
collabsMenu = false;
collabsStartingIndex = 0;
gameSpeedCheck = 0;
realTimeCheck = 0;
superCollabs = 0;
superCollabShow = false;
gotSticker = false;
stickerOption = 0;
stickerSelected = false;
stickerAction = 0;
stickerActionSelected = false;
stickerLineTime = 0;
stickerContainer = [700, 103];
usedSticker = false;
stickerID = -1;
stickerPauseMenu = false;
eliminatedThisLevel = false;
winBonus = 0;
gameDone = false;
submitScoreError = false;
currentOutfit = 0;
holdLevel = 0;
overwriteDaily = false;
postingScore = false;
quitConfirm = false;
quitOption = 0;
hideAllUI = false;
global.maxHP = 0;
global.currentHP = 0;
global.psystem = part_system_create_layer("instances", true);
initialize_particles();
darkening = false;
global.freeAnvil = false;
selectingSkill = {};
playerFlags = 
{
    moved: false,
    usedSpecial: false,
    strafed: false,
    aimed: false
};
tankHP = false;
choseOtherOptions = false;
timeModeStart = 4000;
customDrawScript = {};
showDamageData = false;
collabListSelected = false;
collabListShowing = false;
collabListWindow = [630, 60];
collabListOption = 0;
collabListStartingPosition = 0;
damageData = [];
global.time = [0, 0, 0, 0, 0];
global.camera_scale = 1;
global.new_camera_scale = 1;
global.coinAutoPick = false;
global.enemyDefeated = 0;
global.yagoosDefeated = 0;
global.miniBossDefeated = 0;
global.bossDefeated = 0;
global.enhancementBuff = 0;
global.foodDropChanceBuff = 0;
global.moneyDropChanceBuff = 0;
global.anvilDropChanceBuff = 0;
global.enhanceCostMultiplier = 1;
global.anvilUses = 0;
global.moneyMultiplier = 1;
global.additionalSpawn = 0;
global.reducedSpawn = 1;
global.rainbowEXPDrop = 0;
if (!variable_global_exists("playingStage"))
{
    global.playingStage = -1;
}
global.returningRoom = -1;
global.moneyHeal = false;
global.currentRunMoneyGained = 0;
global.haluBuff = 0;
global.poltatoNerf = 0;
global.haluLevel = 0;
haluBonusCoins = 0;
global.timePause = false;
global.preHaluDefeated = 0;
global.stageCoinBonus = 1;
global.fruitFoodBuff = 1;
global.collectedSticker = -1;
global.currentStickers = [-1, -1, -1];
global.removeStickers = [];
global.availableStickers = [];
global.goldenHammer = 0;
global.goldenHammerPieces = 0;
global.canGoldenHammer = true;
global.goldFlag = false;
global.rerolled = 0;
global.eliminated = 0;
global.totalDamage = 0;
global.noEXP = false;
global.reflection = false;
if (room == rm_ConcertStage && global.lightFX)
{
    global.reflection = true;
}
global.negativeEffects = 1;
global.positiveEffects = 1;
switch (global.playingStage)
{
    case 7:
        global.stageCoinBonus = 1;
        break;
    case 10:
        global.stageCoinBonus = 1.2;
        break;
    case 13:
        global.stageCoinBonus = 1.4;
        break;
    case 17:
        global.stageCoinBonus = 1.6;
        break;
    case 16:
        global.stageCoinBonus = 1.3;
        break;
    case 21:
        global.stageCoinBonus = 1.7;
        break;
}
if (global.gameMode < 2)
{
    global.rerollTimes = min(10, ds_map_find_value(global.PlayerSave, "reroll"));
    global.eliminateTimes = min(10, ds_map_find_value(global.PlayerSave, "eliminate"));
}
else
{
    global.rerollTimes = 10;
    global.eliminateTimes = 10;
}
eliminateMode = false;
tempOption1 = 
{
    optionIcon: 0,
    optionType: "",
    optionName: "",
    optionDescription: ""
};
options = [tempOption1, tempOption1, tempOption1, tempOption1];
rerollContainer = {};
whiteFlash = 0;
localScoreResult = UnknownEnum.Value_0;
sussy = false;
disconnectWarning = false;
global.timesDodged = 0;
global.burgersEaten = 0;
canControl = true;
part_emitter_destroy_all(global.psystem);
display_set_gui_size(640, 360);

function SeparateName(arg0)
{
    var splitBy = " ";
    var slot = 0;
    separatedName = "";
    var str2 = "";
    for (var i = 1; i < (string_length(arg0) + 1); i++)
    {
        var currStr = string_copy(arg0, i, 1);
        if (currStr == splitBy)
        {
            separatedName[slot] = str2;
            slot++;
            str2 = "";
        }
        else
        {
            str2 = str2 + currStr;
            separatedName[slot] = str2;
        }
    }
}

function GameOver()
{
    if (!gameOvered && !gameWon)
    {
        paused = true;
        gameOvered = true;
        gameDone = true;
        dankTime = 0;
        pauseOption = 0;
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
        audio_play_sound(bgm_gameover, 100, false);
        gameOverTextContainer = [320, -100];
        gameOverTime = 0;
        haluBonusCoins = 0;
        if (global.haluLevel > 0)
        {
            haluBonusCoins = floor((global.enemyDefeated - global.preHaluDefeated) / global.haluLevel) * global.stageCoinBonus;
        }
        ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + floor(global.currentRunMoneyGained + haluBonusCoins));
        if (global.enemyDefeated >= 5000)
        {
            DoAchievement("delusional");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Halu", "ITEM");
        }
        if (ds_map_find_value(global.PlayerSave, "holoCoins") >= 5000)
        {
            DoAchievement("SCT");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "SuperChattoTime", "ITEM");
        }
        if (global.time[UnknownEnum.Value_1] >= 10)
        {
            DoAchievement("fleshWound");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Bandaid", "ITEM");
        }
        if (HadItem(items, "Halu"))
        {
            DoAchievement("toohalu");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "GWSPill", "ITEM");
        }
        localScoreResult = UnknownEnum.Value_0;
        if (CanSubmitScore())
        {
            localScoreResult = SaveLocalScore(false);
            overwriteDaily = false;
        }
        SavePlayerSave();
    }
}

function GameWin(arg0 = 60)
{
    if (!gameOvered)
    {
        gameDone = true;
        if (instance_exists(playerCharacter) && (playerCharacter.currentHP > 0 || playerCharacter.canNotDie))
        {
            part_emitter_destroy_all(global.psystem);
            alarm[0] = arg0;
        }
    }
}

function ExecuteFlash(arg0 = 1)
{
    whiteFlash = arg0;
    alarm[5] = 1;
}

function Dank(arg0 = 80)
{
    superDankTime = max(arg0, superDankTime);
    darkening = true;
}

function EndDank()
{
    superDankTime = 0;
    darkening = false;
}

function LevelUp(arg0 = true)
{
    if (instance_exists(playerCharacter))
    {
        if (!gameWon && !gameOvered && !gameDone && (playerCharacter.currentHP > 0 || playerCharacter.canNotDie))
        {
            if (arg0)
            {
                GenerateOptions();
            }
            audio_group_set_gain(1, global.musicVolume / 3, 500);
            Pause();
        }
    }
}

function Reroll()
{
    GenerateOptions();
    rightcontainer[0] = 740;
}

function PlayerManagerSnapshotPlayer()
{
    var keys = variable_instance_get_names(playerCharacter);
    playerSnapshot = {};
    for (var i = 0; i < array_length(keys); i++)
    {
        variable_struct_set(playerSnapshot, keys[i], variable_instance_get(playerCharacter, keys[i]));
    }
}

function Pause()
{
    paused_screen_sprite = sprite_create_from_surface(application_surface, 0, 0, global.screen_resolution_x, global.screen_resolution_y, false, false, 0, 0);
    audio_group_set_gain(1, global.musicVolume / 3, 500);
    PlayerManagerSnapshotPlayer();
    room_goto(rm_PauseRoom);
    if (audio_is_playing(snd_rain))
    {
        audio_stop_sound(snd_rain);
    }
    if (audio_is_playing(snd_snowqueenwind))
    {
        audio_stop_sound(snd_snowqueenwind);
    }
}

function Unpause()
{
    room_goto(global.playingStage);
    alarm[9] = 1;
    if (disconnectWarning)
    {
        disconnectWarning = false;
    }
}

function SelectUp()
{
    if (canControl)
    {
        if (paused && leveled)
        {
            if (!collabListShowing && !collabListSelected)
            {
                textPage = 0;
                if (levelOptionSelect > 0 && levelOptionSelect < 5)
                {
                    levelOptionSelect -= 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (levelOptionSelect == 5)
                {
                    levelOptionSelect = 3;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (collabListShowing && collabListStartingPosition > 0)
            {
                collabListStartingPosition--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (perksMenu && array_length(variable_struct_get_names(perks)) > 0)
        {
            if (skillSelect == 0)
            {
                skillSelect = array_length(variable_struct_get_names(perks)) - 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else
            {
                skillSelect--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            textPage = 0;
        }
        else if (paused && !leveled && !gotBox && !gotGoldenAnvil && !gotSticker && !perksMenu && !gotAnvil && !collabsMenu && !reviving && !quitConfirm)
        {
            if (pauseOption > 0)
            {
                if ((gameWon && gameOverTime >= 120) || (gameOvered && gameOverTime >= 330) || !gameOvered)
                {
                    pauseOption -= 1;
                }
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && quitConfirm)
        {
            if (quitOption > 0)
            {
                quitOption = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotBox)
        {
            if (boxOpenned && itemBoxTakeOption == 1)
            {
                itemBoxTakeOption--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotAnvil)
        {
            if (!anvilOptionSelected)
            {
                if (anvilOption < 6)
                {
                    anvilOption += 6;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (anvilOption > 5)
                {
                    anvilOption -= 6;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (!upgradeActionSelected)
            {
                if (upgradeOption == 1)
                {
                    upgradeOption = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (paused && gotGoldenAnvil)
        {
            if (superCollabShow && !goldenOptionSelected)
            {
                if (anvilOption < 5)
                {
                    anvilOption += 5;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    anvilOption -= (5 + (anvilOption == 10));
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectDown()
{
    if (canControl)
    {
        if (paused && leveled)
        {
            if (!collabListShowing && !collabListSelected)
            {
                if (levelOptionSelect < 3 || ((levelOptionSelect == 3 && ds_map_find_value(global.PlayerSave, "reroll") > 0) || ds_map_find_value(global.PlayerSave, "eliminate") > 0))
                {
                    if (levelOptionSelect < 4)
                    {
                        if (ds_map_find_value(global.PlayerSave, "reroll") > 0)
                        {
                            levelOptionSelect += 1;
                        }
                        else if (levelOptionSelect == 3)
                        {
                            levelOptionSelect = 5;
                        }
                        else
                        {
                            levelOptionSelect++;
                        }
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                textPage = 0;
            }
            else if (collabListShowing && (collabListStartingPosition + 5) < array_length(global.seenCollabs))
            {
                collabListStartingPosition++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (perksMenu && skillSelect < array_length(variable_struct_get_names(perks)) && array_length(variable_struct_get_names(perks)) > 0)
        {
            if (skillSelect == (array_length(variable_struct_get_names(perks)) - 1))
            {
                skillSelect = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else
            {
                skillSelect++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            textPage = 0;
        }
        else if (paused && !leveled && !gotBox && !gotAnvil && !gotSticker && !gotGoldenAnvil && !perksMenu && !collabsMenu && !gameOvered && !gameWon && !reviving && !quitConfirm)
        {
            if (pauseOption < 5)
            {
                pauseOption += 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && quitConfirm)
        {
            if (quitOption == 0)
            {
                quitOption = 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotBox)
        {
            if (boxOpenned && itemBoxTakeOption == 0)
            {
                itemBoxTakeOption++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && ((gameOvered && gameOverTime >= 330) || (gameWon && gameOverTime >= 120)))
        {
            var canSubmitScore = CanSubmitScore();
            var totalGameOverOptions = canSubmitScore ? UnknownEnum.Value_4 : 3;
            if (pauseOption < (totalGameOverOptions - 1))
            {
                pauseOption += 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotAnvil)
        {
            if (!anvilOptionSelected)
            {
                if (anvilOption < 6)
                {
                    anvilOption += 6;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (anvilOption > 5)
                {
                    anvilOption -= 6;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (!upgradeActionSelected)
            {
                if (upgradeOption == 0 && anvilOption > 0 && anvilOption < 6 && (ds_map_find_value(global.PlayerSave, "enchantments") > 0 || global.gameMode == 2))
                {
                    upgradeOption = 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (paused && gotGoldenAnvil)
        {
            if (superCollabShow && !goldenOptionSelected)
            {
                if (anvilOption < 5)
                {
                    anvilOption += (5 + (anvilOption == 10));
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    anvilOption -= (5 + (anvilOption == 10));
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectLeft()
{
    if (canControl)
    {
        if (paused && leveled)
        {
            if (!collabListShowing)
            {
                if (!collabListSelected)
                {
                    if (levelOptionSelect == 5)
                    {
                        levelOptionSelect = 4;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else if (levelOptionSelect < 4 && is_array(options[levelOptionSelect].optionDescription))
                    {
                        if (textPage > 0)
                        {
                            textPage--;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                    }
                }
                else
                {
                    collabListSelected = false;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (perksMenu && array_length(variable_struct_get_names(perks)) > 0)
        {
            if (is_array(selectingSkill.optionDescription))
            {
                if (textPage > 0)
                {
                    textPage--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (gotBox && boxOpenned)
        {
            if (gotBox && is_array(randomWeapon[currentBoxItem].optionDescription))
            {
                if (textPage > 0)
                {
                    textPage--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (collabing && collabingTime > 80)
        {
            if (is_array(collabingWeapon.optionDescription))
            {
                if (textPage > 0)
                {
                    textPage--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (paused && collabsMenu)
        {
            if (collabsStartingIndex > 0)
            {
                collabsStartingIndex--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotAnvil && anvilOptionSelected)
        {
            if (is_array(loadOutList[anvilOption].optionDescription))
            {
                if (textPage > 0)
                {
                    textPage--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (paused && gotAnvil && !anvilOptionSelected)
        {
            if (anvilOption == 0)
            {
                anvilOption = 5;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption == 6)
            {
                anvilOption = 11;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption > 0)
            {
                anvilOption -= 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotGoldenAnvil && !goldenOptionSelected)
        {
            if (anvilOption == 0)
            {
                anvilOption = 4;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption == 5 && superCollabShow)
            {
                anvilOption = 10;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption > 0)
            {
                anvilOption -= 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotSticker)
        {
            if (!stickerSelected)
            {
                if (stickerOption > 0)
                {
                    stickerOption -= 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (!stickerActionSelected)
            {
                if (stickerOption > 0)
                {
                    if (global.currentStickers[stickerOption - 1] != -1)
                    {
                        if ((stickerAction > 0 && global.currentStickers[stickerOption - 1].level < (global.currentStickers[stickerOption - 1].maxLevel - 1) && global.collectedSticker != -1) || (stickerAction > 1 && global.collectedSticker == -1) || stickerAction == 2)
                        {
                            stickerAction--;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                    }
                }
                else if (((stickerOption == 0 && array_exists(global.currentStickers, -1)) || stickerOption > 0) && stickerAction == 2)
                {
                    stickerAction = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectRight()
{
    if (canControl)
    {
        if (paused && leveled && controlsFree)
        {
            if (!collabListShowing)
            {
                if (levelOptionSelect == 4 && ds_map_find_value(global.PlayerSave, "eliminate") > 0)
                {
                    levelOptionSelect = 5;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                if (levelOptionSelect < 4 && is_array(options[levelOptionSelect].optionDescription))
                {
                    if (textPage < (array_length(options[levelOptionSelect].optionDescription) - 1))
                    {
                        textPage++;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else if (!collabListSelected && array_length(global.seenCollabs) > 0)
                    {
                        collabListSelected = true;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                else if (levelOptionSelect < 4 && array_length(global.seenCollabs) > 0)
                {
                    collabListSelected = true;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (perksMenu && array_length(variable_struct_get_names(perks)) > 0)
        {
            if (is_array(selectingSkill.optionDescription))
            {
                if (textPage < (array_length(selectingSkill.optionDescription) - 1))
                {
                    textPage++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (gotBox && boxOpenned)
        {
            if (gotBox && is_array(randomWeapon[currentBoxItem].optionDescription))
            {
                if (textPage < (array_length(randomWeapon[currentBoxItem].optionDescription) - 1))
                {
                    textPage++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (collabing && collabingTime > 80)
        {
            if (is_array(collabingWeapon.optionDescription))
            {
                if (textPage < (array_length(collabingWeapon.optionDescription) - 1))
                {
                    textPage++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (paused && collabsMenu)
        {
            if (array_length(global.seenCollabs) > ((collabsStartingIndex + 1) * 4) && array_length(global.seenCollabs) > 4)
            {
                collabsStartingIndex++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotAnvil && anvilOptionSelected)
        {
            if (is_array(loadOutList[anvilOption].optionDescription))
            {
                if (textPage < (array_length(loadOutList[anvilOption].optionDescription) - 1))
                {
                    textPage++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        else if (paused && gotAnvil && !anvilOptionSelected)
        {
            if (anvilOption == 5)
            {
                anvilOption = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption == 11)
            {
                anvilOption = 6;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption >= 0)
            {
                anvilOption += 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotGoldenAnvil && !goldenOptionSelected)
        {
            if (anvilOption == 4)
            {
                anvilOption = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption == 10 && superCollabShow)
            {
                anvilOption = 5;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (anvilOption >= 0)
            {
                anvilOption += 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (paused && gotSticker)
        {
            if (!stickerSelected)
            {
                if (stickerOption < 4)
                {
                    stickerOption += 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (!stickerActionSelected)
            {
                if (stickerAction < 2)
                {
                    if (stickerOption > 0 && global.currentStickers[stickerOption - 1] != -1)
                    {
                        stickerAction++;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else if (stickerOption == 0 && global.collectedSticker != -1)
                    {
                        stickerAction = 2;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
            }
        }
    }
}

function PlayerPause()
{
    if (!leveled && !gotBox && !gameOvered && !gotAnvil && !gotSticker && !gotGoldenAnvil && !gameWon && !gameDone && !reviving)
    {
        paused = !paused;
        if (paused == false)
        {
            perksMenu = false;
            collabsMenu = false;
            sprite_delete(paused_screen_sprite);
            audio_group_set_gain(1, global.musicVolume, 500);
            Unpause();
        }
        else
        {
            leftcontainer[0] = -100;
            middlecontainer[1] = 400;
            rightcontainer[0] = 740;
            pauseCurrentMenu = 0;
            Pause();
        }
    }
}

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
}

function Confirmed()
{
    if (canControl)
    {
        if (paused && leveled && controlsFree)
        {
            if (collabListShowing)
            {
                exit;
            }
            if (collabListSelected)
            {
                collabListShowing = true;
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
            else if (levelOptionSelect < 4)
            {
                if (!eliminateMode)
                {
                    if (options[levelOptionSelect].optionName != "")
                    {
                        if (levelOptionSelect > 0)
                        {
                            choseOtherOptions = true;
                        }
                        leveled = false;
                        paused = false;
                        textPage = 0;
                        sprite_delete(paused_screen_sprite);
                        Unpause();
                        ParseAndPushCommandType(options[levelOptionSelect]);
                        eliminatedThisLevel = false;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        audio_group_set_gain(1, global.musicVolume, 500);
                    }
                }
                else if (options[levelOptionSelect].optionType != "Consumable" && options[levelOptionSelect].optionType != "StatUp")
                {
                    textPage = 0;
                    alarm[6] = 2;
                    eliminateMode = false;
                    eliminatedThisLevel = true;
                    sprite_delete(paused_screen_sprite);
                    var newOption = {};
                    global.eliminateTimes--;
                    global.eliminated++;
                    variable_struct_copy(options[levelOptionSelect], newOption);
                    newOption.optionType = "Remove" + options[levelOptionSelect].optionType;
                    options[levelOptionSelect] = 
                    {
                        optionName: "",
                        optionIcon: 717,
                        optionDescription: "",
                        optionType: ""
                    };
                    Unpause();
                    ParseAndPushCommandType(newOption);
                    audio_play_sound(snd_eliminated, 10, false);
                    audio_group_set_gain(1, global.musicVolume, 500);
                }
            }
            else if (levelOptionSelect == 4)
            {
                if (global.rerollTimes > 0 || global.debug)
                {
                    choseOtherOptions = true;
                    textPage = 0;
                    sprite_delete(paused_screen_sprite);
                    Unpause();
                    rightcontainer[0] = 740;
                    eliminateMode = false;
                    audio_play_sound(snd_reroll, 10, false);
                    alarm[11] = 2;
                    controlsFree = false;
                    canControl = false;
                    alarm[1] = 20;
                    alarm[10] = 20;
                    for (var i = 0; i < array_length(options); i++)
                    {
                        var optionType = options[i].optionType;
                        if (optionType == "Weapon" || optionType == "Item" || optionType == "Skill")
                        {
                            if (!variable_struct_exists(rerollContainer, options[i].optionID))
                            {
                                variable_struct_set(rerollContainer, options[i].optionID, 1);
                            }
                            else
                            {
                                variable_struct_set(rerollContainer, options[i].optionID, variable_struct_get(rerollContainer, options[i].optionID) + 1);
                            }
                        }
                    }
                    global.rerollTimes--;
                    global.rerolled++;
                }
            }
            else if (levelOptionSelect == 5)
            {
                if (!eliminateMode && !eliminatedThisLevel)
                {
                    if (global.eliminateTimes > 0 || global.debug)
                    {
                        textPage = 0;
                        controlsFree = false;
                        alarm[10] = 20;
                        audio_play_sound(snd_eliminatemode, 10, false);
                        eliminateMode = true;
                        levelOptionSelect = 0;
                    }
                }
                else
                {
                    controlsFree = false;
                    alarm[10] = 10;
                    eliminateMode = false;
                }
            }
        }
        else if (paused && !gotBox && !gotAnvil && !gotSticker && !leveled && !gameOvered && !gameWon && !gotGoldenAnvil && !reviving && !quitConfirm)
        {
            if (pauseCurrentMenu == 0)
            {
                switch (pauseOption)
                {
                    case 0:
                        if (!perksMenu)
                        {
                            perksMenu = true;
                            skillSelect = 0;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                            canControl = false;
                            alarm[1] = 5;
                        }
                        break;
                    case 1:
                        if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
                        {
                            gotSticker = true;
                            gotSticker = true;
                            stickerOption = 0;
                            stickerSelected = false;
                            stickerAction = 0;
                            stickerActionSelected = false;
                            stickerPauseMenu = true;
                            usedSticker = true;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                        canControl = false;
                        alarm[1] = 5;
                        break;
                    case 2:
                        if (array_length(global.seenCollabs) > 0)
                        {
                            collabsMenu = true;
                            collabsStartingIndex = 0;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                        canControl = false;
                        alarm[1] = 5;
                        break;
                    case 3:
                        paused = false;
                        Unpause();
                        canControl = false;
                        alarm[1] = 5;
                        audio_group_set_gain(1, global.musicVolume, 500);
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case 4:
                        pauseCurrentMenu = -1;
                        canControl = false;
                        var optionsMan = instance_create_depth(x, y, depth - 50, obj_Options);
                        optionsMan.playerMan = id;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case 5:
                        quitConfirm = true;
                        quitOption = 0;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                }
            }
        }
        else if (paused && quitConfirm)
        {
            if (quitOption == 0)
            {
                if (global.unlockedNew && array_length(global.unlockedThings) > 0)
                {
                    global.returningRoom = global.playingStage;
                    global.resetLevel = true;
                    audio_stop_sound(global.bgmPlay);
                    room_goto(rm_UnlockRoom);
                    global.returningRoom = 3;
                    audio_group_set_gain(1, global.musicVolume, 500);
                    instance_destroy();
                }
                else
                {
                    global.resetLevel = true;
                    room_goto(rm_Title);
                    part_emitter_destroy_all(global.psystem);
                    instance_destroy();
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    audio_group_set_gain(1, global.musicVolume, 500);
                    audio_stop_sound(global.bgmPlay);
                    if (audio_is_playing(snd_rain))
                    {
                        audio_stop_sound(snd_rain);
                    }
                    if (audio_is_playing(snd_snowqueenwind))
                    {
                        audio_stop_sound(snd_snowqueenwind);
                    }
                    if (!is_undefined(audio_bus_main.effects[0]))
                    {
                        audio_bus_main.effects[0].bypass = true;
                    }
                }
            }
            else
            {
                quitConfirm = false;
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
        }
        else if (paused && (gameOvered || gameWon))
        {
            if (gameOvered && gameOverTime < 330)
            {
                gameOverTime = 330;
            }
            else if (gameWon && gameOverTime < 120)
            {
                gameOverTime = 120;
            }
            else
            {
                switch (pauseOption)
                {
                    case UnknownEnum.Value_0:
                        if (global.unlockedNew && array_length(global.unlockedThings) > 0)
                        {
                            global.returningRoom = global.playingStage;
                            global.resetLevel = true;
                            audio_stop_sound(bgm_gameover);
                            room_goto(rm_UnlockRoom);
                        }
                        else
                        {
                            room_goto(global.playingStage);
                            audio_stop_sound(bgm_gameover);
                            global.resetLevel = true;
                        }
                        instance_destroy();
                        break;
                    case UnknownEnum.Value_1:
                        if (global.unlockedNew && array_length(global.unlockedThings) > 0)
                        {
                            global.returningRoom = 4;
                            audio_stop_sound(bgm_gameover);
                            global.resetLevel = true;
                            room_goto(rm_UnlockRoom);
                        }
                        else
                        {
                            global.resetLevel = true;
                            audio_stop_sound(bgm_gameover);
                            room_goto(rm_CharSelect);
                        }
                        instance_destroy();
                        break;
                    case UnknownEnum.Value_2:
                        if (global.unlockedNew && array_length(global.unlockedThings) > 0)
                        {
                            global.returningRoom = 3;
                            audio_stop_sound(bgm_gameover);
                            global.resetLevel = true;
                            room_goto(rm_UnlockRoom);
                        }
                        else
                        {
                            global.resetLevel = true;
                            audio_stop_sound(bgm_gameover);
                            room_goto(rm_Title);
                        }
                        instance_destroy();
                        break;
                    case UnknownEnum.Value_3:
                        submitScoreError = false;
                        if (!overwriteDaily && localScoreResult == UnknownEnum.Value_0)
                        {
                            overwriteDaily = true;
                        }
                        else
                        {
                            if (overwriteDaily)
                            {
                                SaveLocalScore(true);
                            }
                            global.resetLevel = true;
                            var hiscore = instance_create_depth(x, y, depth, obj_HiScores);
                            canControl = false;
                            show_debug_message("Posting score...");
                            hiscore.PostScore(localScoreResult, false);
                            postingScore = true;
                        }
                        break;
                }
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
        }
        else if (paused && gotBox)
        {
            if (boxAnimState == 0)
            {
                audio_group_set_gain(1, global.musicVolume, 10);
                switch (boxItemAmount)
                {
                    case 1:
                        if (!superBox)
                        {
                            audio_play_sound(bgm_chestopen1, 50, 0);
                        }
                        else
                        {
                            audio_play_sound(bgm_chestopen3, 50, 0);
                        }
                        break;
                    case 3:
                        audio_play_sound(bgm_chestopen2, 50, 0);
                        break;
                }
                image_index = 0;
                boxAnimState = 1;
                boxBounceTime = 0;
            }
            else if (boxAnimState == 1 && boxBounceTime > 15)
            {
                if (boxItemAmount == 1 && !superBox)
                {
                    audio_stop_sound(bgm_chestopen1);
                    audio_play_sound(bgm_chestopen1_short, 50, 0);
                    var skippedTime = 301 - boxBounceTime;
                    var skippedCoins = skippedTime div boxCoinRate;
                    boxCoinGain += (skippedCoins * (1 + playerSnapshot.moneyGain) * global.stageCoinBonus);
                }
                else if (boxItemAmount == 3)
                {
                    audio_stop_sound(bgm_chestopen2);
                    audio_play_sound(bgm_chestopen2_short, 50, 0);
                    var skippedTime = 399 - boxBounceTime;
                    var skippedCoins = skippedTime div boxCoinRate;
                    boxCoinGain += (skippedCoins * (1 + playerSnapshot.moneyGain) * global.stageCoinBonus);
                }
                else if (superBox)
                {
                    audio_stop_sound(bgm_chestopen3);
                    audio_play_sound(bgm_chestopen3_short, 50, 0);
                    var skippedTime = 399 - boxBounceTime;
                    var skippedCoins = skippedTime div boxCoinRate;
                    boxCoinGain += (skippedCoins * (1 + playerSnapshot.moneyGain) * global.stageCoinBonus);
                }
                boxAnimState = 2;
                image_index = 0;
                boxBounceTime = 0;
                boxOpenTime = 0;
            }
            else if (boxOpenned)
            {
                audio_play_sound(snd_menu_confirm, 30, 0);
                if (itemBoxTakeOption == 0)
                {
                    array_push(listOfWeaponsToPush, randomWeapon[currentBoxItem]);
                    textPage = 0;
                }
                if (itemBoxTakeOption == 1 && superBox)
                {
                    DoAchievement("painPeko");
                    randomWeapon[currentBoxItem].becomeSuper = false;
                    randomWeapon[currentBoxItem].optionIcon = randomWeapon[currentBoxItem].optionIcon_Normal;
                    var descContainer = variable_struct_get(global.TextContainer, randomWeapon[currentBoxItem].id + "Description");
                    if (typeof(descContainer.selectedLanguage) == "array")
                    {
                        randomWeapon[currentBoxItem].optionDescription = descContainer.selectedLanguage[0];
                    }
                }
                if (currentBoxItem < boxItemAmount)
                {
                    currentBoxItem++;
                }
                if (boxItemAmount == 1 || currentBoxItem == boxItemAmount)
                {
                    paused = false;
                    Unpause();
                    gotBox = false;
                    global.currentRunMoneyGained += floor(boxCoinGain);
                    playerGotMoney = true;
                    for (var i = 0; i < array_length(listOfWeaponsToPush); i++)
                    {
                        ParseAndPushCommandType(listOfWeaponsToPush[i]);
                    }
                    if (global.bgmPlay > 0)
                    {
                        audio_resume_sound(global.bgmPlay);
                        audio_group_set_gain(1, global.musicVolume, 500);
                    }
                }
            }
        }
        else if (paused && gotAnvil)
        {
            if (loadOutList[anvilOption] != -1)
            {
                if (validLevelOptions[anvilOption])
                {
                    if (anvilOptionSelected)
                    {
                        if (upgradeActionSelected)
                        {
                            if (upgradeOption == 0)
                            {
                                if (!enhancing && loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel)
                                {
                                    if (global.currentRunMoneyGained >= floor(global.enhanceCostMultiplier * loadOutList[anvilOption].enhancements * 50 * (loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel)))
                                    {
                                        enhancing = true;
                                        enhancingTime = 0;
                                        audio_play_sound(snd_charging, 30, 0);
                                        global.currentRunMoneyGained -= floor(global.enhanceCostMultiplier * loadOutList[anvilOption].enhancements * 50 * (loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel));
                                    }
                                }
                                else if (!enhancing || (enhancing && enhanceDone))
                                {
                                    paused = false;
                                    gotAnvil = false;
                                    usedAnvil = true;
                                    Unpause();
                                    if (!enhancing)
                                    {
                                        audio_play_sound(snd_anvil, 30, 0);
                                    }
                                    if ((enhancing && enhanceDone && enhanceResult) || !enhancing)
                                    {
                                        audio_play_sound(snd_menu_confirm, 30, 0);
                                        ParseAndPushCommandType(loadOutList[anvilOption]);
                                    }
                                    if (global.bgmPlay > 0)
                                    {
                                        audio_group_set_gain(1, global.musicVolume, 500);
                                    }
                                }
                            }
                            else if (upgradeOption == 1)
                            {
                                if (!enhancing)
                                {
                                    if (global.currentRunMoneyGained >= floor(global.enhanceCostMultiplier * 250))
                                    {
                                        enhancing = true;
                                        enhancingTime = 0;
                                        audio_play_sound(snd_enchanting, 30, 0);
                                        global.currentRunMoneyGained -= floor(global.enhanceCostMultiplier * 250);
                                        if (array_length(loadOutList[anvilOption].gainedMods) == 0)
                                        {
                                            var attackMod = RollMod(loadOutList[anvilOption]);
                                            if (attackMod != -1)
                                            {
                                                array_push(loadOutList[anvilOption].gainedMods, attackMod);
                                            }
                                        }
                                        else
                                        {
                                            for (var i = 0; i < array_length(loadOutList[anvilOption].gainedMods); i++)
                                            {
                                                var attackMod = RollMod(loadOutList[anvilOption]);
                                                loadOutList[anvilOption].gainedMods[i] = attackMod;
                                            }
                                        }
                                    }
                                }
                                else if (!enhancing || (enhancing && enhanceDone))
                                {
                                    paused = false;
                                    gotAnvil = false;
                                    usedAnvil = true;
                                    Unpause();
                                    if ((enhancing && enhanceDone && enhanceResult) || !enhancing)
                                    {
                                        audio_play_sound(snd_menu_confirm, 30, 0);
                                        loadOutList[anvilOption].optionType = "Enchant";
                                        ParseAndPushCommandType(loadOutList[anvilOption]);
                                    }
                                    if (global.bgmPlay > 0)
                                    {
                                        audio_group_set_gain(1, global.musicVolume, 500);
                                    }
                                }
                            }
                        }
                        else if (upgradeOption == 0 || (upgradeOption == 1 && anvilOption > 0 && anvilOption < 6))
                        {
                            upgradeActionSelected = true;
                            canControl = false;
                            alarm[1] = 3;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                    }
                    else
                    {
                        anvilOptionSelected = true;
                        textPage = 0;
                        canControl = false;
                        alarm[1] = 3;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
            }
        }
        else if (paused && gotGoldenAnvil)
        {
            if (goldenAnvilOptionSelected1 != -1 && goldenAnvilOptionSelected2 != -1 && goldenOptionSelected)
            {
                if (!collabing)
                {
                    if ((goldenAnvilOptionSelected1.optionType == "Collab" && (global.goldenHammer > 0 || global.debug)) || goldenAnvilOptionSelected1.optionType != "Collab")
                    {
                        collabing = true;
                        collabingTime = 0;
                        audio_play_sound(snd_charging, 30, 0);
                    }
                }
                else if (collabDone)
                {
                    paused = false;
                    gotGoldenAnvil = false;
                    collabing = false;
                    collabingTime = 0;
                    global.goldAnvilCanDrop = false;
                    usedAnvil = true;
                    Unpause();
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    ParseAndPushCommandType(collabingWeapon);
                    if (collabingWeapon.optionType == "SuperCollab")
                    {
                        DoAchievement("hammertime");
                        global.goldenHammer = 0;
                    }
                    var alreadySeen = false;
                    for (var i = 0; i < array_length(global.seenCollabs); i++)
                    {
                        if (collabingWeapon.attackID == global.seenCollabs[i].attackID)
                        {
                            alreadySeen = true;
                            break;
                        }
                    }
                    if (!alreadySeen)
                    {
                        array_push(global.seenCollabs, collabingWeapon);
                        array_push(ds_map_find_value(global.PlayerSave, "seenCollabs"), collabingWeapon.attackID);
                        SavePlayerSave();
                    }
                    if (global.bgmPlay > 0)
                    {
                        audio_group_set_gain(1, global.musicVolume, 500);
                    }
                }
            }
            if (loadOutList[anvilOption] != -1)
            {
                if (validLevelOptions[anvilOption] && !goldenOptionSelected)
                {
                    if (goldenAnvilOptionSelected1 < 0)
                    {
                        goldenAnvilOptionSelected1 = loadOutList[anvilOption];
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        if (goldenAnvilOptionSelected1.optionType == "Collab")
                        {
                            superCollabShow = true;
                        }
                    }
                    else if (goldenAnvilOptionSelected2 < 0 && validLevelOptions[anvilOption] != goldenAnvilOptionSelected1)
                    {
                        goldenAnvilOptionSelected2 = loadOutList[anvilOption];
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
            }
        }
        else if (paused && gotSticker)
        {
            if (stickerOption != 4 && !stickerSelected && (global.collectedSticker != -1 || (stickerOption > 0 && global.currentStickers[stickerOption - 1] != -1)))
            {
                stickerSelected = true;
                audio_play_sound(snd_menu_confirm, 30, 0);
                if (stickerOption == 0)
                {
                    if (!array_exists(global.currentStickers, -1))
                    {
                        stickerAction = 2;
                    }
                    else
                    {
                        stickerAction = 0;
                    }
                }
                else if (global.currentStickers[stickerOption - 1] == -1)
                {
                    stickerAction = 0;
                }
                else if (global.currentStickers[stickerOption - 1] != -1)
                {
                    if (global.collectedSticker == -1 || global.currentStickers[stickerOption - 1].level == (global.currentStickers[stickerOption - 1].maxLevel - 1))
                    {
                        stickerAction = 1;
                    }
                    else
                    {
                        stickerAction = 0;
                    }
                }
            }
            else if (stickerOption == 4)
            {
                if (!stickerPauseMenu)
                {
                    paused = false;
                    gotSticker = false;
                    usedSticker = true;
                    Unpause();
                    alarm[10] = 1;
                    audio_play_sound(snd_stickerDone, 30, 0);
                    if (global.bgmPlay > 0)
                    {
                        audio_group_set_gain(1, global.musicVolume, 500);
                    }
                }
                else
                {
                    stickerPauseMenu = false;
                    gotSticker = false;
                    audio_play_sound(snd_stickerDone, 30, 0);
                }
            }
            else if (stickerSelected && !stickerActionSelected)
            {
                if (!(stickerOption > 0 && stickerOption < 4 && stickerAction == 0 && global.collectedSticker != -1 && global.currentStickers[stickerOption - 1] != -1 && global.currentStickers[stickerOption - 1].level == (global.currentStickers[stickerOption - 1].maxLevel - 1)))
                {
                    stickerActionSelected = true;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
            }
            else if (stickerActionSelected)
            {
                stickerSelected = false;
                stickerActionSelected = false;
                audio_play_sound(snd_menu_confirm, 30, 0);
                switch (stickerAction)
                {
                    case 0:
                        if (global.collectedSticker != -1)
                        {
                            if (stickerOption > 0)
                            {
                                if (global.currentStickers[stickerOption - 1] == -1)
                                {
                                    global.currentStickers[stickerOption - 1] = global.collectedSticker;
                                    global.collectedSticker = -1;
                                }
                                else
                                {
                                    global.currentStickers[stickerOption - 1].LevelUp();
                                    global.collectedSticker = -1;
                                }
                            }
                            else if (array_exists(global.currentStickers, -1))
                            {
                                var firstEmpty = 0;
                                for (var i = 0; i < 3; i++)
                                {
                                    if (global.currentStickers[i] == -1)
                                    {
                                        firstEmpty = i;
                                        break;
                                    }
                                }
                                global.currentStickers[firstEmpty] = global.collectedSticker;
                                global.collectedSticker = -1;
                            }
                            audio_play_sound(snd_shopBuy, 30, 0);
                        }
                        break;
                    case 1:
                        if (global.collectedSticker == -1)
                        {
                            global.collectedSticker = global.currentStickers[stickerOption - 1];
                            array_push(global.removeStickers, global.currentStickers[stickerOption - 1]);
                            global.currentStickers[stickerOption - 1] = -1;
                            audio_play_sound(snd_stickerremove, 30, 0);
                        }
                        else
                        {
                            var tempSticker = global.collectedSticker;
                            global.collectedSticker = global.currentStickers[stickerOption - 1];
                            array_push(global.removeStickers, global.currentStickers[stickerOption - 1]);
                            global.currentStickers[stickerOption - 1] = tempSticker;
                            audio_play_sound(snd_stickerSwap, 30, 0);
                        }
                        break;
                    case 2:
                        var theLevel = 0;
                        if (stickerOption == 0)
                        {
                            theLevel = global.collectedSticker.level + 1;
                        }
                        else
                        {
                            theLevel = global.currentStickers[max(0, stickerOption - 1)].level + 1;
                        }
                        global.currentRunMoneyGained += (floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain)) * theLevel);
                        playerGotMoney = true;
                        if (stickerOption == 0)
                        {
                            global.collectedSticker = -1;
                        }
                        else
                        {
                            array_push(global.removeStickers, global.currentStickers[stickerOption - 1]);
                            global.currentStickers[stickerOption - 1] = -1;
                        }
                        audio_play_sound(snd_stickersell, 30, 0);
                        break;
                }
            }
        }
        else if (paused && reviving)
        {
            paused = false;
            reviving = false;
            Unpause();
            audio_group_set_gain(1, global.musicVolume, 10);
            audio_play_sound(snd_menu_confirm, 30, 0);
            audio_play_sound(snd_revive, 50, 0);
            whiteFlash = 1;
            alarm[5] = 1;
        }
    }
}

postScoreNetworkStatusOK = false;

function OnPostScoreFail(arg0)
{
    postScoreNetworkStatusOK = arg0;
    canControl = true;
    submitScoreError = true;
    overwriteDaily = false;
    postingScore = false;
    audio_play_sound(snd_menu_back, 30, 0);
    if (342 != undefined && true)
    {
        with (obj_HiScores)
        {
            instance_destroy();
        }
    }
}

function ReturnMenu()
{
    if (canControl && !gameDone)
    {
        if (paused && leveled)
        {
            if (eliminateMode)
            {
                eliminateMode = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else if (collabListShowing)
            {
                collabListShowing = false;
                collabListSelected = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
        }
        if (paused && !leveled && !gotSticker && !gotBox && !gameOvered && !gotAnvil && !gotGoldenAnvil && !reviving && !quitConfirm)
        {
            if (perksMenu)
            {
                perksMenu = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else if (collabsMenu)
            {
                collabsMenu = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else if (instance_exists(obj_Options))
            {
                instance_find(obj_Options, 0).Destroy();
                pauseCurrentMenu = 0;
                pauseOption = 1;
            }
            else
            {
                audio_play_sound(snd_menu_back, 30, 0);
                PlayerPause();
            }
        }
        else if (paused && quitConfirm)
        {
            quitConfirm = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else if (paused && gotAnvil && !enhancing)
        {
            if (anvilOptionSelected)
            {
                if (!upgradeActionSelected)
                {
                    anvilOptionSelected = false;
                    upgradeOption = 0;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                else
                {
                    upgradeActionSelected = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
            }
            else
            {
                paused = false;
                gotAnvil = false;
                Unpause();
                audio_play_sound(snd_menu_back, 30, 0);
                if (global.bgmPlay > 0)
                {
                    audio_group_set_gain(1, global.musicVolume, 500);
                }
            }
        }
        else if (paused && gotGoldenAnvil && !collabing)
        {
            if (goldenAnvilOptionSelected2 != -1)
            {
                goldenAnvilOptionSelected2 = -1;
                goldenOptionSelected = false;
                collabingWeapon = -1;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else if (goldenAnvilOptionSelected1 != -1)
            {
                if (anvilOption > 4)
                {
                    anvilOption -= 5;
                }
                goldenAnvilOptionSelected1 = -1;
                superCollabShow = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else
            {
                paused = false;
                gotGoldenAnvil = false;
                Unpause();
                audio_play_sound(snd_menu_back, 30, 0);
                if (global.bgmPlay > 0)
                {
                    audio_group_set_gain(1, global.musicVolume, 500);
                }
            }
        }
        else if (paused && gotSticker)
        {
            if (stickerActionSelected)
            {
                stickerActionSelected = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else if (stickerSelected)
            {
                stickerSelected = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
            else if (!stickerPauseMenu)
            {
                paused = false;
                gotSticker = false;
                usedSticker = true;
                Unpause();
                alarm[10] = 1;
                audio_play_sound(snd_stickerDone, 30, 0);
                if (global.bgmPlay > 0)
                {
                    audio_group_set_gain(1, global.musicVolume, 500);
                }
            }
            else
            {
                stickerPauseMenu = false;
                gotSticker = false;
                audio_play_sound(snd_menu_back, 30, 0);
            }
        }
    }
}

function EnterKey()
{
    if (canControl)
    {
        if (paused || leveled || gotBox || gameOvered || gameWon || gotAnvil || gotGoldenAnvil || reviving || quitConfirm || gotSticker)
        {
            Confirmed();
        }
    }
}

function EscKey()
{
    if (canControl)
    {
        if (pauseCurrentMenu > -1)
        {
            if (paused && pauseCurrentMenu > -1)
            {
                ReturnMenu();
            }
            else if (pauseCurrentMenu > -1 && !leveled && !gotSticker && !gotBox && !gameOvered && !gameWon && !gotAnvil && !gotGoldenAnvil && !reviving && !quitConfirm)
            {
                PlayerPause();
            }
        }
    }
}

function InitializeCharacter()
{
    charData = selectedCharacter;
    global.playingStage = room;
    if (global.charSelected)
    {
        charData = global.charSelected;
    }
    createdChar = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Player);
    charPortrait = charData.port;
    charWeapon = charData.attackIcon;
    charSpecial = charData.specIcon;
    charName = charData.charName;
    global.maxHP = charData.HP;
    global.currentHP = global.maxHP;
    instance_create_depth(x, y, depth, obj_Pepeloni);
    createdChar.charName = charData.charName;
    createdChar.idleSprite = charData.sprite1;
    createdChar.runSprite = charData.sprite2;
    if (variable_struct_exists(charData, "sprite3"))
    {
        createdChar.sprite3 = charData.sprite3;
    }
    if (variable_struct_exists(charData, "sprites"))
    {
        createdChar.sprites = charData.sprites;
    }
    else
    {
        createdChar.sprites = [
        {
            sprite1: createdChar.idleSprite,
            sprite2: createdChar.runSprite
        }];
    }
    ApplyProgressionStats();
    createdChar.HP = baseStats.HP;
    global.lives = 1;
    createdChar.currentHP = baseStats.HP;
    createdChar.ATK = baseStats.ATK;
    createdChar.SPD = baseStats.SPD;
    createdChar.crit = baseStats.crit;
    createdChar.haste = baseStats.haste;
    createdChar.pickupRange = baseStats.pickupRange;
    variable_struct_copy(baseStats, createdChar.prebuffStats);
    createdChar.SnapshotPrebuffStats();
    AddAttack(charData.attackID);
    createdChar.specialid = charData.specID;
    createdChar.specCD = charData.specCD;
    currentOutfit = global.outfitSelected;
    if (currentOutfit != "default")
    {
        if (variable_struct_exists(charData, "outfits") && variable_struct_exists(charData.outfits, currentOutfit))
        {
            createdChar.sprites = variable_struct_get(charData.outfits, currentOutfit).sprites;
            createdChar.idleSprite = createdChar.sprites[0].sprite1;
            createdChar.runSprite = createdChar.sprites[0].sprite2;
            if (variable_struct_exists(charData, "sprite3"))
            {
                createdChar.sprite3 = createdChar.sprites[0].sprite3;
            }
        }
    }
    attacksCopy = playerCharacter.attacks;
    playerCharacter = createdChar;
    playerCharacter.baseStats = 
    {
        HP: baseStats.HP,
        ATK: baseStats.ATK,
        SPD: baseStats.SPD,
        crit: baseStats.crit,
        pickupRange: baseStats.pickupRange,
        haste: baseStats.haste
    };
    if (variable_struct_exists(charData, "onCreate"))
    {
        charData.onCreate(playerCharacter);
    }
    if (ds_map_find_value(global.PlayerSave, "fandom") && global.gameMode < 2)
    {
        var charIndex = -1;
        for (var i = 0; i < array_length(global.characterFollowings); i++)
        {
            if (global.characterFollowings[i][0] == charData.id)
            {
                charIndex = i;
            }
        }
        if (charIndex > -1)
        {
            var followingStatus = global.characterFollowings[charIndex][1];
            GeneratePossibleOptions();
            if (followingStatus == 1)
            {
                ParseAndPushCommandType(RandomPerk());
            }
            else if (followingStatus == 2)
            {
                ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 0)));
                ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 1)));
                ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 2)));
            }
            else if (followingStatus == 3)
            {
                for (var i = 0; i < 3; i++)
                {
                    ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 0)));
                    ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 1)));
                    ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 2)));
                }
            }
        }
    }
    else if (global.gameMode == 2)
    {
        GeneratePossibleOptions();
        ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 0)));
        ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 1)));
        ParseAndPushCommandType(ds_map_find_value(PERKS, array_get(perksContainer, 2)));
    }
    if (!global.resetLevel)
    {
        SetCooking();
    }
    SnapshotStats();
    PlayerManagerSnapshotPlayer();
    hpSus = playerCharacter.currentHP - 1;
}

function InitializeStageBasedAchievements()
{
    couchPotatoFlag = true;
    dontNeedFlag = false;
    barebonesFlag = true;
    skillissueFlag = true;
    bullethellFlag = true;
    rawstrengthFlag = true;
    if (!AchievementIsUnlocked("donttouch"))
    {
        donttouchCount = 0;
    }
    else
    {
        donttouchCount = -1;
    }
    if (!AchievementIsUnlocked("oraora"))
    {
        oraoraCount = 0;
    }
    else
    {
        oraoraCount = -1;
    }
    if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0)
    {
        dontNeedFlag = true;
    }
    playerDamageTaken = 0;
    collabCount = 0;
    mobAchievementCounters = {};
    trueRNGcounter = 0;
    if (ds_map_find_value(global.PlayerSave, "challenge"))
    {
        hardcoreGamerFlag = true;
    }
    else
    {
        hardcoreGamerFlag = false;
    }
    
    playerCharacter.onDeath.fired = function(arg0, arg1, arg2)
    {
        if (instance_exists(arg1))
        {
            if (!variable_instance_exists(arg1, "name"))
            {
                exit;
            }
            if (string_count("Yagoo", arg1.name) > 0)
            {
                DoAchievement("fired");
            }
        }
    };
}

function CheckStageBasedAchievements()
{
    if (hardcoreGamerFlag)
    {
        DoAchievement("hardcoreGamer");
    }
    if (barebonesFlag)
    {
        DoAchievement("barebones");
    }
    if (skillissueFlag)
    {
        DoAchievement("skillissue");
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Beetle", "ITEM");
    }
    if (couchPotatoFlag)
    {
        DoAchievement("couchPotato");
    }
    if (dontNeedFlag)
    {
        DoAchievement("dontNeed");
    }
    if (global.haluLevel == 1)
    {
        DoAchievement("hallucinated");
    }
    if (ds_map_find_value(attacksCopy, charData.attackID).config.level == 1)
    {
        DoAchievement("nomain");
    }
}

function CheckHardModeAchievements()
{
    if (bullethellFlag)
    {
        DoAchievement("bullethell");
    }
    if (rawstrengthFlag)
    {
        DoAchievement("rawstrength");
    }
}

function DrawOption(arg0, arg1, arg2, arg3 = false, arg4 = false, arg5 = 0, arg6 = false)
{
    if (arg2.optionName == "")
    {
        exit;
    }
    var isNew = false;
    var iconType = 1149;
    var optionAlpha = 1;
    draw_set_font(Galmuri9);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    if (eliminateMode && (arg2.optionType == "StatUp" || arg2.optionType == "Consumable"))
    {
        optionAlpha = 0.5;
    }
    var optionName = arg2.optionName;
    if (arg2.optionType == "Item" && arg2.becomeSuper)
    {
        optionName = global.TextContainer.superTag.selectedLanguage + optionName;
    }
    var levelPart = "";
    if (variable_struct_exists(arg2, "level") && variable_struct_exists(arg2, "maxLevel") && arg4)
    {
        if (arg2.level < arg2.maxLevel)
        {
            if (arg2.optionType != "Item")
            {
                if (string_pos(global.TextContainer.awakenedTag.selectedLanguage, arg2.optionName) != 0)
                {
                    optionName = string_delete(arg2.optionName, string_pos(global.TextContainer.awakenedTag.selectedLanguage, arg2.optionName), string_length(arg2.optionName));
                    levelPart = " LV 6 >> " + global.TextContainer.awakenedTag.selectedLanguage;
                }
                else
                {
                    optionName = string_delete(arg2.optionName, string_pos(" LV", arg2.optionName), string_length(arg2.optionName));
                    if ((arg2.level + 1) == arg2.maxLevel)
                    {
                        levelPart = " LV " + string(arg2.level) + " >> LV MAX";
                    }
                    else
                    {
                        levelPart = " LV " + string(arg2.level) + " >> LV " + string(arg2.level + 1);
                    }
                }
            }
            else
            {
                optionName = string_delete(arg2.optionName, string_pos(" LV", arg2.optionName), string_length(arg2.optionName));
                levelPart = " LV " + string(arg2.level + 1) + " >> LV " + string(arg2.level + 2);
            }
        }
    }
    var nameColor = 16777215;
    if (arg2.optionType == "Weapon" || arg2.optionType == "Collab")
    {
        if ((variable_instance_exists(arg2, "offeredMod") && arg2.offeredMod != -1) || (variable_instance_exists(arg2, "gainedMods") && array_length(arg2.gainedMods) > 0) || (ds_map_exists(attacksCopy, arg2.attackID) && array_length(ds_map_find_value(attacksCopy, arg2.attackID).config.gainedMods) > 0))
        {
            nameColor = make_color_rgb(49, 224, 255);
        }
    }
    draw_set_color(nameColor);
    draw_text_scribble_ext(arg0 + 19, arg1 + 3, optionName, 500, 10, undefined, optionAlpha);
    draw_set_color(c_white);
    draw_text_color(arg0 + 19 + string_width(optionName), arg1 + 3, levelPart, c_yellow, c_yellow, c_yellow, c_yellow, optionAlpha);
    if (variable_struct_exists(arg2, "enhancements") && arg2.enhancements > 0)
    {
        var nameWidth = string_width(arg2.optionName);
        var enhancedAdd = "";
        if (arg3)
        {
            enhancedAdd = "+" + string(arg2.enhancements - 1) + "  >>  ";
        }
        draw_text_color(arg0 + 19 + nameWidth, arg1 + 3, " " + enhancedAdd + "+" + string(arg2.enhancements), c_yellow, c_yellow, c_yellow, c_yellow, optionAlpha);
    }
    if (variable_struct_exists(arg2, "strengthening"))
    {
        var nameWidth = string_width(arg2.optionName);
        var nextLevel = "LV 2";
        if (string_pos("LV 2", arg2.optionName) > 0)
        {
            nextLevel = "LV MAX";
        }
        draw_text_color(arg0 + 19 + nameWidth, arg1 + 3, " >> " + nextLevel, c_yellow, c_yellow, c_yellow, c_yellow, optionAlpha);
    }
    draw_set_alpha(0.8);
    draw_set_halign(fa_right);
    draw_text_scribble_ext(arg0 + 365, arg1 + 3, ">> " + arg2.optionType, 300, 30, undefined, optionAlpha);
    draw_set_alpha(optionAlpha);
    if (arg2.optionType == "Weapon")
    {
        switch (arg2.weaponType)
        {
            case "Melee":
                draw_sprite(spr_weaponTypes, 0, arg0 + 375, arg1 + 9);
                break;
            case "Ranged":
                draw_sprite(spr_weaponTypes, 1, arg0 + 375, arg1 + 9);
                break;
            case "MultiShot":
                draw_sprite(spr_weaponTypes, 2, arg0 + 375, arg1 + 9);
                break;
        }
    }
    else if (arg2.optionType == "Item")
    {
        switch (arg2.itemType)
        {
            case "Healing":
                draw_sprite(spr_itemTypes, 0, arg0 + 375, arg1 + 9);
                break;
            case "Stat":
                draw_sprite(spr_itemTypes, 1, arg0 + 375, arg1 + 9);
                break;
            case "Utility":
                draw_sprite(spr_itemTypes, 2, arg0 + 375, arg1 + 9);
                break;
        }
    }
    if (arg2.optionIcon > 0)
    {
        if (arg2.optionType == "Item" && arg2.becomeSuper)
        {
            draw_sprite(arg2.optionIcon_Super, 0, arg0 + 34, arg1 + 39);
        }
        else
        {
            draw_sprite(arg2.optionIcon, 0, arg0 + 34, arg1 + 39);
        }
    }
    switch (arg2.optionType)
    {
        case "Weapon":
            isNew = !ds_map_exists(attacksCopy, arg2.optionID);
            iconType = 1046;
            break;
        case "Item":
            isNew = !variable_instance_exists(items, arg2.optionID);
            iconType = 182;
            break;
        case "Skill":
            isNew = !variable_instance_exists(perks, arg2.optionID);
            iconType = 1986;
            break;
        case "Collab":
            isNew = !ds_map_exists(attacksCopy, arg2.optionID);
            iconType = 2219;
            break;
        case "SuperCollab":
            isNew = !ds_map_exists(attacksCopy, arg2.optionID);
            iconType = 1223;
            break;
        case "Stamp":
            iconType = 996;
            break;
    }
    draw_sprite(iconType, 0, arg0 + 35, arg1 + 40);
    draw_set_alpha(optionAlpha);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    var desc = arg2.optionDescription;
    if (arg6)
    {
        desc = global.TextContainer.enchantDesc.selectedLanguage;
    }
    else if (variable_struct_exists(arg2, "strengthening"))
    {
        if (global.currentStickers[stickerOption - 1].level < (global.currentStickers[stickerOption - 1].maxLevel - 1))
        {
            desc = arg2.allDescription[global.currentStickers[stickerOption - 1].level + 1];
        }
    }
    if (is_array(desc))
    {
        if (gotBox)
        {
            draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc[textPage], 300, 13);
        }
        else if (leveled && arg5 == levelOptionSelect)
        {
            draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc[textPage], 300, 13);
        }
        else if (collabing && collabingTime > 80)
        {
            draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc[textPage], 300, 13);
        }
        else if (perksMenu && arg5 == skillSelect)
        {
            draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc[textPage], 300, 13);
        }
        else if (gotAnvil && anvilOptionSelected)
        {
            draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc[textPage], 300, 13);
        }
        else
        {
            draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc[0], 300, 13);
        }
        if (levelOptionSelect < 4 && options[levelOptionSelect] == arg2)
        {
            if (textPage < (array_length(desc) - 1))
            {
                draw_sprite_ext(ui_nextPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
            else
            {
                draw_sprite_ext(ui_prevPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
        }
        else if (gotBox && boxOpenned)
        {
            if (textPage < (array_length(desc) - 1))
            {
                draw_sprite_ext(ui_nextPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
            else
            {
                draw_sprite_ext(ui_prevPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
        }
        else if (collabing && collabingTime > 80)
        {
            if (textPage < (array_length(desc) - 1))
            {
                draw_sprite_ext(ui_nextPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
            else
            {
                draw_sprite_ext(ui_prevPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
        }
        else if (gotAnvil && anvilOptionSelected)
        {
            if (textPage < (array_length(desc) - 1))
            {
                draw_sprite_ext(ui_nextPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
            else
            {
                draw_sprite_ext(ui_prevPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
        }
        else if (perksMenu)
        {
            if (textPage < (array_length(desc) - 1))
            {
                draw_sprite_ext(ui_nextPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
            else
            {
                draw_sprite_ext(ui_prevPage, image_index / 30, arg0 + 373, arg1 + 53, 2, 2, 0, c_white, optionAlpha);
            }
        }
    }
    else
    {
        draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc, 300, 13, undefined, optionAlpha);
    }
    if (isNew)
    {
        draw_text_color(arg0 + 245, arg1 + 3, global.TextContainer.newText.selectedLanguage, c_yellow, c_yellow, c_yellow, c_yellow, optionAlpha);
    }
    if (variable_instance_exists(arg2, "gainedMods") && array_length(arg2.gainedMods) > 0)
    {
        var modDesc = "";
        for (var i = 0; i < array_length(arg2.gainedMods); i++)
        {
            draw_set_halign(fa_right);
            var theMod = ds_map_find_value(global.AttackModifiers, arg2.gainedMods[i]);
            modDesc += ("  > " + theMod.optionDescription);
        }
        draw_text_color(arg0 + 360, arg1 + 49, modDesc, make_color_rgb(49, 224, 255), make_color_rgb(49, 224, 255), make_color_rgb(49, 224, 255), make_color_rgb(49, 224, 255), optionAlpha);
    }
    else if (variable_instance_exists(arg2, "offeredMod") && arg2.offeredMod != -1)
    {
        draw_set_halign(fa_right);
        var theMod = ds_map_find_value(global.AttackModifiers, arg2.offeredMod);
        draw_text_color(arg0 + 360, arg1 + 49, "> " + theMod.optionDescription, make_color_rgb(49, 224, 255), make_color_rgb(49, 224, 255), make_color_rgb(49, 224, 255), make_color_rgb(49, 224, 255), optionAlpha);
    }
    draw_set_alpha(1);
}

function GetCurrentAttackIndex()
{
    if (instance_exists(obj_AttackController))
    {
        if (currentAttackList != -1)
        {
            ds_map_destroy(currentAttackList);
            currentAttackList = -1;
        }
        currentAttackList = ds_map_create();
        ds_map_copy(currentAttackList, obj_AttackController.attackIndex);
    }
}

function getBox()
{
    if (!gotSticker && !gotAnvil && !gameOvered && !gameWon && !gameDone && !leveled && !paused)
    {
        superBox = false;
        boxOpenned = false;
        gotBox = true;
        paused = true;
        boxAnimState = 0;
        image_index = 0;
        boxOpenTime = 0;
        boxBounceTime = 0;
        superLit = 0;
        itemBoxContainer[1] = -500;
        itemBoxTakeOption = 0;
        currentBoxItem = 0;
        listOfWeaponsToPush = [];
        boxCoinGain = 0;
        boxCoinTime = 0;
        boxCoinRate = 3 + irandom(2);
        textPage = 0;
        GeneratePossibleOptions();
        var roll = irandom(99);
        if ((roll > 94 && !ds_map_find_value(global.PlayerSave, "noSupers")) && global.gameMode < 2)
        {
            boxItemAmount = 1;
            var possibleSupers = [];
            var key = ds_map_find_first(ITEMS);
            var size = ds_map_size(ITEMS);
            for (var i = 0; i < size; i++)
            {
                if (ds_map_find_value(ITEMS, key).hasSuper && ds_map_find_value(ITEMS, key).level < 0 && !ds_map_find_value(ITEMS, key).becomeSuper && array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), key))
                {
                    array_push(possibleSupers, ds_map_find_value(ITEMS, key));
                }
                key = ds_map_find_next(ITEMS, key);
            }
            if (numberOfOwnedItems < itemLimit && array_length(possibleSupers) > 0)
            {
                var randomSuper = irandom(array_length(possibleSupers) - 1);
                randomWeapon = [possibleSupers[randomSuper]];
                superBox = true;
                randomWeapon[0].becomeSuper = true;
                randomWeapon[0].optionIcon = randomWeapon[0].optionIcon_Super;
                var descContainer = variable_struct_get(global.TextContainer, randomWeapon[0].id + "Description");
                if (typeof(descContainer.selectedLanguage) == "array")
                {
                    randomWeapon[0].optionDescription = descContainer.selectedLanguage[randomWeapon[0].maxLevel];
                }
            }
            else
            {
                randomWeapon = [OptionBox(1)];
            }
        }
        else if (roll > 85)
        {
            boxItemAmount = 3;
            randomWeapon = [OptionBox(1), OptionBox(1, 1), OptionBox(1, 2)];
        }
        else
        {
            boxItemAmount = 1;
            randomWeapon = [OptionBox(1)];
        }
        Pause();
        audio_play_sound(snd_delivery, 30, 0);
    }
}

function getAnvil(arg0)
{
    if (!gotSticker && !gotBox && !gameOvered && !gameWon && !gameDone && !leveled && !paused)
    {
        anvilID = arg0;
        loadOutList[0] = -1;
        validLevelOptions[0] = false;
        loadOutList[1] = -1;
        validLevelOptions[1] = false;
        loadOutList[2] = -1;
        validLevelOptions[2] = false;
        loadOutList[3] = -1;
        validLevelOptions[3] = false;
        loadOutList[4] = -1;
        validLevelOptions[4] = false;
        loadOutList[5] = -1;
        validLevelOptions[5] = false;
        anvilContainer = [700, 100];
        loadOutList[6] = -1;
        loadOutList[7] = -1;
        loadOutList[8] = -1;
        loadOutList[9] = -1;
        loadOutList[10] = -1;
        loadOutList[11] = -1;
        GetCurrentAttackIndex();
        gotAnvil = true;
        upgradeOption = 0;
        upgradeActionSelected = false;
        paused = true;
        superLit = 0;
        anvilOption = 0;
        anvilOptionSelected = false;
        enhancing = false;
        enhancingTime = 0;
        enhanceDone = false;
        enhanceResult = false;
        Pause();
        audio_play_sound(snd_delivery, 30, 0);
    }
}

function getGoldenAnvil(arg0)
{
    if (!gotSticker && !gotBox && !gotAnvil && !gameOvered && !gameWon && !gameDone && !leveled && !paused)
    {
        anvilID = arg0;
        loadOutList[0] = -1;
        validLevelOptions[0] = false;
        loadOutList[1] = -1;
        validLevelOptions[1] = false;
        loadOutList[2] = -1;
        validLevelOptions[2] = false;
        loadOutList[3] = -1;
        validLevelOptions[3] = false;
        loadOutList[4] = -1;
        validLevelOptions[4] = false;
        loadOutList[5] = -1;
        validLevelOptions[5] = false;
        loadOutList[6] = -1;
        validLevelOptions[5] = false;
        loadOutList[7] = -1;
        validLevelOptions[5] = false;
        loadOutList[8] = -1;
        validLevelOptions[5] = false;
        loadOutList[9] = -1;
        validLevelOptions[5] = false;
        loadOutList[10] = -1;
        validLevelOptions[5] = false;
        loadOutList[11] = -1;
        validLevelOptions[5] = false;
        GetCurrentAttackIndex();
        gotGoldenAnvil = true;
        paused = true;
        superLit = 0;
        anvilOption = 0;
        goldenAnvilOptionSelected1 = -1;
        goldenAnvilOptionSelected2 = -1;
        goldenOptionSelected = false;
        superCollabShow = false;
        collabing = false;
        collabingTime = 0;
        collabingWeapon = -1;
        collabDone = false;
        collabResult = false;
        Pause();
        audio_play_sound(snd_delivery, 30, 0);
    }
}

function getSticker(arg0)
{
    if (!gotBox && !gotAnvil && !gameOvered && !gameWon && !gameDone && !leveled && !paused)
    {
        stickerID = arg0;
        GetCurrentAttackIndex();
        gotSticker = true;
        paused = true;
        superLit = 0;
        stickerOption = 0;
        stickerSelected = false;
        stickerAction = 0;
        stickerActionSelected = false;
        audio_play_sound(snd_delivery, 30, 0);
        Pause();
    }
}

function SetCooking()
{
    if (ds_map_find_value(global.PlayerSave, "cookingOn"))
    {
        if (array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 0) != "")
        {
            if (array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 1) > 0)
            {
                var getFood = ds_map_find_value(global.FOOD, array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 0));
                if (!is_undefined(getFood))
                {
                    getFood.OnApply(playerCharacter);
                    array_set_post(ds_map_find_value(global.PlayerSave, "currentFood"), 1, array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 1) - 1);
                    SavePlayerSave();
                }
            }
            if (array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 1) == 0 && ds_map_find_value(global.PlayerSave, "autoCook") != "")
            {
                var getFood = ds_map_find_value(global.FOOD, ds_map_find_value(global.PlayerSave, "autoCook"));
                var canCook = CanCook(getFood);
                if (canCook)
                {
                    var ingredients = variable_struct_get_names(getFood.recipe);
                    for (var i = 0; i < array_length(ingredients); i++)
                    {
                        inventory_remove(ingredients[i], variable_struct_get(getFood.recipe, ingredients[i]));
                    }
                    ds_map_set(global.PlayerSave, "currentFood", [getFood.optionID, getFood.useNumber]);
                    SavePlayerSave();
                }
            }
        }
    }
}

function Init()
{
    event_user(14);
    event_user(13);
    event_user(15);
    InitializeCharacter();
    InitializeStageBasedAchievements();
    global.availableStickers = ds_map_keys_to_array(obj_PlayerManager.STICKERS);
    randomize();
    if (room == Room1)
    {
        global.bgmPlay = 266;
    }
    else if (room == rm_HoloOffice)
    {
        global.bgmPlay = 261;
    }
    else if (room == rm_GrassPlains_Night)
    {
        global.bgmPlay = 101;
    }
    else if (room == rm_Castle)
    {
        global.bgmPlay = 43;
    }
    else if (room == rm_ConcertStage)
    {
        global.bgmPlay = 74;
    }
    else if (room == rm_HoloOffice_SunSet)
    {
        global.bgmPlay = 268;
    }
    else if (room == rm_IDArena)
    {
        global.bgmPlay = 44;
    }
    else if (room == rm_CastleMyth)
    {
        global.bgmPlay = 237;
    }
    if (!audio_is_playing(global.bgmPlay))
    {
        audio_play_sound(global.bgmPlay, 0, 1);
    }
}

function getSign(arg0)
{
    if (arg0 >= 0)
    {
        return "+";
    }
    else
    {
        return "";
    }
}

function CanSubmitScore()
{
    return global.gameMode == 1 || (global.gameMode == 2 && gameWon);
}

Init();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
