if (instance_number(obj_Player) == 0 && room == global.playingStage)
{
    Init();
}
if (global.mobsSpawned > 10 && global.enemyDefeated >= (global.mobsSpawned * 1.2))
{
    sussy = true;
}
if (global.time[UnknownEnum.Value_0] > 10)
{
    sussy = true;
}
if (global.timesDodged >= 1000)
{
    sussy = true;
}
if (global.rerolled > 15)
{
    sussy = true;
}
if (global.eliminated > 15)
{
    sussy = true;
}
if (timesRevived > livesGained)
{
    sussy = true;
}
if (instance_exists(playerCharacter))
{
    if (playerCharacter.currentHP > 30 && hpSus != (playerCharacter.currentHP - 1))
    {
        sussy = true;
    }
}
if (instance_exists(playerCharacter))
{
    if (playerCharacter.invincibilityTimer >= 2000)
    {
        sussy = true;
    }
    if (playerCharacter.ATK >= 3392)
    {
        sussy = true;
    }
    if (playerCharacter.SPD >= 3267)
    {
        sussy = true;
    }
    if (playerCharacter.crit >= 3127)
    {
        sussy = true;
    }
    if (playerCharacter.pickupRange >= 3187)
    {
        sussy = true;
    }
    if (playerCharacter.haste >= 3032)
    {
        sussy = true;
    }
    if (playerCharacter.HP >= 4631)
    {
        sussy = true;
    }
    if (playerCharacter.DR <= 0)
    {
        sussy = true;
    }
    if (!tankHP && playerCharacter.HP >= 500)
    {
        tankHP = true;
        DoAchievement("tankclass");
    }
}
if (!paused)
{
    if (window_has_focus() && playerCharacter.mouseFollowMode)
    {
        display_mouse_lock(window_get_x(), window_get_y(), window_get_width(), window_get_height());
    }
    if (holdLevel > 0)
    {
        holdLevel--;
    }
    if (superDankTime > 0)
    {
        superDankTime--;
        if (superDankTime == 0)
        {
            darkening = false;
        }
    }
    if (darkening && superDank < 0.4)
    {
        if (!paused)
        {
            superDank += 0.1;
        }
    }
    if (!darkening && superDank > 0)
    {
        if (!paused)
        {
            superDank -= 0.1;
        }
    }
    if (!global.timePause)
    {
        global.time[UnknownEnum.Value_3] += 1;
        global.time[UnknownEnum.Value_4] += delta_time;
        if (global.time[UnknownEnum.Value_3] > (room_speed - 1))
        {
            if (instance_exists(obj_StageManager))
            {
                if (obj_StageManager.enabledTimeline)
                {
                    obj_StageManager.CheckTimeForEvent(global.time[UnknownEnum.Value_0], global.time[UnknownEnum.Value_1], global.time[UnknownEnum.Value_2]);
                }
            }
            global.time[UnknownEnum.Value_3] = 0;
            global.time[UnknownEnum.Value_4] = 0;
            global.time[UnknownEnum.Value_2]++;
        }
        if (global.time[UnknownEnum.Value_2] > 59)
        {
            global.time[UnknownEnum.Value_2] = 0;
            global.time[UnknownEnum.Value_1]++;
        }
        if (global.time[UnknownEnum.Value_1] > 59)
        {
            global.time[UnknownEnum.Value_1] = 0;
            global.time[UnknownEnum.Value_0]++;
        }
    }
    if (global.time[UnknownEnum.Value_0] == 0 && global.time[UnknownEnum.Value_1] == 1 && global.time[UnknownEnum.Value_2] == 0 && ds_map_find_value(global.PlayerSave, "firstTime"))
    {
        ds_map_set(global.PlayerSave, "firstTime", false);
        SavePlayerSave();
    }
    if (global.time[UnknownEnum.Value_0] == 0 && global.time[UnknownEnum.Value_1] == 10 && global.time[UnknownEnum.Value_2] == 0)
    {
        if (global.charSelected.id == "calli")
        {
            DoAchievement("calli10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "EnergyDrink", "ITEM");
        }
        else if (global.charSelected.id == "ina")
        {
            DoAchievement("ina10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "CuttingBoard", "WEAPON");
        }
        else if (global.charSelected.id == "irys")
        {
            DoAchievement("irys10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "IdolSong", "WEAPON");
        }
        else if (global.charSelected.id == "bae")
        {
            DoAchievement("bae10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Plushie", "ITEM");
        }
        else if (global.charSelected.id == "kiara")
        {
            DoAchievement("kiara10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "ChickensFeather", "ITEM");
        }
        else if (global.charSelected.id == "sana")
        {
            DoAchievement("sana10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Limiter", "ITEM");
        }
        else if (global.charSelected.id == "korone")
        {
            DoAchievement("korone10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "XPotato", "WEAPON");
        }
        else if (global.charSelected.id == "shion")
        {
            DoAchievement("shion10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Shacklesss", "ITEM");
        }
        else if (global.charSelected.id == "zeta")
        {
            DoAchievement("zeta10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "FocusShades", "ITEM");
        }
        else if (global.charSelected.id == "ollie")
        {
            DoAchievement("ollie10");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "NinjaHeadband", "ITEM");
        }
        if ((HadWeapon(playerSnapshot.attacks, "CuttingBoard") || HadWeapon(playerSnapshot.attacks, "FlatBoard") || HadWeapon(playerSnapshot.attacks, "BoneBros") || HadWeapon(playerSnapshot.attacks, "AbsoluteWall")) && variable_instance_exists(global.charSelected, "flat"))
        {
            DoAchievement("boing");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), "BounceBall", "WEAPON");
        }
    }
    if (global.time[UnknownEnum.Value_0] == 0 && global.time[UnknownEnum.Value_1] == 30 && global.time[UnknownEnum.Value_2] == 0 && global.time[3] == 0)
    {
        if (HadItem(items, "Halu") && ds_map_find_value(ITEMS, "Halu").level >= 4)
        {
            DoAchievement("iDidIt");
        }
        if (global.gameMode == 1)
        {
            var stage = GetCurrentStageData();
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
            if (!array_exists(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), stageIndex), 1), global.charSelected.id))
            {
                if (isHard)
                {
                    AddFandomEXP(global.charSelected.id, 20);
                }
                else
                {
                    AddFandomEXP(global.charSelected.id, 15);
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
        }
    }
    if (!instance_exists(obj_Player))
    {
        global.camera_scale = 1;
    }
    if (usedAnvil && instance_exists(anvilID))
    {
        anvilID.used = true;
        anvilID = -1;
        usedAnvil = false;
    }
    if (usedSticker)
    {
        if (stickerID > 0 && instance_exists(stickerID))
        {
            if (global.collectedSticker == -1)
            {
                stickerID.used = true;
            }
            else
            {
                stickerID.stickerData = global.collectedSticker;
                stickerID.sprite_index = global.collectedSticker.optionIcon;
            }
        }
        else if (global.collectedSticker != -1)
        {
            var stickerDrop = instance_create_depth(playerCharacter.x, playerCharacter.y, playerCharacter.depth, obj_Sticker);
            stickerDrop.stickerData = global.collectedSticker;
            stickerDrop.sprite_index = global.collectedSticker.optionIcon;
        }
        if (instance_exists(playerCharacter))
        {
            UpdatePlayer();
        }
        stickerID = -1;
        global.collectedSticker = -1;
        usedSticker = false;
    }
    if (global.gameMode == 2)
    {
        if (global.enemyDefeated >= timeModeStart && !gameDone)
        {
            GameWin(1);
            DoAchievement("speedrunner");
        }
    }
    if (disconnectWarning)
    {
        disconnectWarning = false;
    }
}
if (paused || (!paused && !playerCharacter.mouseFollowMode))
{
    display_mouse_unlock();
}
if (!gameDone && !gotBox && !gotAnvil && !gotGoldenAnvil && !leveled && !paused && holdLevel < 1 && global.experience > round(power(lvlrate1 * (global.PLAYERLEVEL + 1), lvlexponent)))
{
    if (instance_exists(playerCharacter) && (playerCharacter.currentHP > 0 || playerCharacter.canNotDie))
    {
        global.PLAYERLEVEL += 1;
        playerCharacter.OnLevelUp(playerCharacter);
        playerCharacter.invincible = true;
        rerollContainer = {};
        if (playerCharacter.invincibilityTimer < 30 && playerCharacter.invincibilityTimer >= 0)
        {
            playerCharacter.invincibilityTimer = 30;
        }
        toNextLevel = round(power(lvlrate1 * (global.PLAYERLEVEL + 1), lvlexponent)) - round(power(lvlrate1 * global.PLAYERLEVEL, lvlexponent));
        paused = true;
        collabListWindow = [630, 60];
        leveled = true;
        eliminateMode = false;
        collabListSelected = false;
        collabListShowing = false;
        collabListOption = 0;
        collabListStartingPosition = 0;
        levelOptionSelect = 0;
        leftcontainer[0] = -100;
        middlecontainer[1] = 400;
        rightcontainer[0] = 740;
        audio_play_sound(snd_lvlup, 10, false);
        alarm[11] = 1;
        controlsFree = false;
        alarm[10] = 30;
        if (global.PLAYERLEVEL >= 50)
        {
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "StudyGlasses", "ITEM");
            DoAchievement("lv50");
            if (global.PLAYERLEVEL >= 100)
            {
                DoAchievement("lv100");
            }
        }
    }
}
if (!paused && global.wrappingStage)
{
    if (playerCharacter.x > (room_width - camera_get_view_width(view_camera[0])))
    {
        with (all)
        {
            if (!variable_instance_exists(id, "noWarp") || !noWarp)
            {
                x -= (room_width - (2 * camera_get_view_width(view_camera[0])));
            }
            if (variable_instance_exists(self, "origin_x") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                origin_x -= (room_width - (2 * camera_get_view_width(view_camera[0])));
            }
            if (variable_instance_exists(self, "lockedX") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                lockedX -= (room_width - (2 * camera_get_view_width(view_camera[0])));
            }
            if (object_index == obj_holoAnvil || object_index == obj_holoBox || object_index == obj_goldenAnvil || object_index == obj_ItemCrate)
            {
                part_emitter_region(global.psystem, emitter, x - 15, x + 20, y, y - 30, 0, 0);
            }
        }
    }
    if (playerCharacter.x < camera_get_view_width(view_camera[0]))
    {
        with (all)
        {
            if (!variable_instance_exists(id, "noWarp") || !noWarp)
            {
                x += (room_width - (2 * camera_get_view_width(view_camera[0])));
            }
            if (variable_instance_exists(self, "origin_x") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                origin_x += (room_width - (2 * camera_get_view_width(view_camera[0])));
            }
            if (variable_instance_exists(self, "lockedX") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                lockedX += (room_width - (2 * camera_get_view_width(view_camera[0])));
            }
            if (object_index == obj_holoAnvil || object_index == obj_holoBox || object_index == obj_goldenAnvil || object_index == obj_ItemCrate)
            {
                part_emitter_region(global.psystem, emitter, x - 15, x + 20, y, y - 30, 0, 0);
            }
        }
    }
    if (playerCharacter.y > (room_height - 640))
    {
        with (all)
        {
            if (!variable_instance_exists(id, "noWarp") || !noWarp)
            {
                y -= (room_height - 1280);
            }
            if (variable_instance_exists(self, "origin_y") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                origin_y -= (room_height - 1280);
            }
            if (variable_instance_exists(self, "lockedY") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                lockedY -= (room_height - 1280);
            }
            if (object_index == obj_holoAnvil || object_index == obj_holoBox || object_index == obj_goldenAnvil || object_index == obj_ItemCrate)
            {
                part_emitter_region(global.psystem, emitter, x - 15, x + 20, y, y - 30, 0, 0);
            }
        }
    }
    if (playerCharacter.y < 640)
    {
        with (all)
        {
            if (!variable_instance_exists(id, "noWarp") || !noWarp)
            {
                y += (room_height - 1280);
            }
            if (variable_instance_exists(self, "origin_y") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                origin_y += (room_height - 1280);
            }
            if (variable_instance_exists(self, "lockedY") && (!variable_instance_exists(id, "noWarp") || !noWarp))
            {
                lockedY += (room_height - 1280);
            }
            if (object_index == obj_holoAnvil || object_index == obj_holoBox || object_index == obj_goldenAnvil || object_index == obj_ItemCrate)
            {
                part_emitter_region(global.psystem, emitter, x - 15, x + 20, y, y - 30, 0, 0);
            }
        }
    }
}
if (!paused)
{
    if (lastCheck > 0)
    {
        lastCheck--;
    }
    else
    {
        lastCheck = 5;
        var dastats = [playerCharacter.HP, playerCharacter.ATK, playerCharacter.SPD, playerCharacter.crit, playerCharacter.pickupRange, playerCharacter.haste, playerCharacter.CritMod];
        for (var i = 0; i < array_length(bigstuffs); i++)
        {
            if (dastats[i] > 150)
            {
                if (dastats[i] > (2 * bigstuffs[i]))
                {
                    if (!(i == 5 && variable_struct_exists(playerCharacter.buffs, "BaeSpecial")))
                    {
                        sussy = true;
                    }
                }
            }
        }
    }
}
if (!paused)
{
    for (var i = 0; i < array_length(damageData); i++)
    {
        damageData[i][2]++;
    }
}
if (paused)
{
    part_particles_clear(global.psystem);
}
if (blackFlash > 0)
{
    blackFlash -= 0.1;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
