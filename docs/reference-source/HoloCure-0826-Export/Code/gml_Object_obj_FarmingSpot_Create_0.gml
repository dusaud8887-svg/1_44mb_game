add = 0;
addDuration = 0;
uni_add = shader_get_uniform(shdrMob, "add");
transparent = false;
highlighted = false;
glowTime = 0;
player = instance_find(obj_Player, 0);
interactable = true;
interacting = false;
cursorTime = 0;
menuContainer = [110, 50];
rightContainer1 = [110, 50];
rightContainer2 = [110, 50];
rightContainer3 = [110, 50];
pauseOption = 0;
currentPlant = -1;
canControl = true;
displayingInventory1 = [];
displayingInventory2 = [];
startingPosition = 0;
startingPosition2 = 0;
inventorySelect1 = global.soilSelect;
inventorySelect2 = global.plantSelect;
farmConfirmSelect = 0;
farmID = -1;
seedID = -1;
cropID = -1;
lifetime = 0;
soilID = -1;
waterCD = 0;
growthState = 0;
growTime = 0;
grown = false;
removeOption = 0;
removeConfirm = false;
cropsResults = 0;
cropsResultsTimer = 0;
waitTime = 30;
resultsContainer = [320, 110];
lightTime = 0;
yieldNumber = 1;
emitter = part_emitter_create(global.psystem);
currentMenu = UnknownEnum.Value_0;

function ResetParticles()
{
    emitter = part_emitter_create(global.psystem);
    if (grown)
    {
        part_emitter_region(global.psystem, emitter, x - 17, x + 17, y + 5, y - 30, 0, 0);
        part_system_depth(global.psystem, -9999);
        part_emitter_stream(global.psystem, emitter, global.partType3, 3);
    }
}

function Water(arg0 = true)
{
    if (waterCD == 0)
    {
        waterCD = 3600;
        lifetime += 3600;
        if (interacting)
        {
            audio_play_sound(snd_watering, 30, 0);
            if (arg0)
            {
                var vfx = instance_create_depth(x - 30, y, depth - 50, obj_vfx);
                vfx.sprite_index = spr_watering;
            }
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
        menuContainer = [-210, 50];
        pauseOption = 0;
        currentMenu = UnknownEnum.Value_0;
        audio_play_sound(snd_plantinteract, 30, 0);
        global.new_camera_scale = 2;
        global.cameraXOffset = x - obj_Player.x;
        obj_Player.canControl = false;
        obj_HoloHouseManager.canControl = false;
        inventorySelect1 = global.soilSelect;
        inventorySelect2 = global.plantSelect;
        startingPosition2 = global.plantStartingPosition;
    }
    else if (highlighted && interacting && canControl)
    {
        switch (currentMenu)
        {
            case UnknownEnum.Value_0:
                if (pauseOption == 0)
                {
                    if (seedID == -1)
                    {
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        currentMenu = UnknownEnum.Value_1;
                        rightContainer1 = [667, 50];
                        rightContainer2 = [720, 50];
                        displayingInventory1 = obj_HoloHouseManager.SoilInventory();
                    }
                    else if (grown)
                    {
                        if (cropsResults && cropsResultsTimer >= waitTime)
                        {
                            DoAchievement("harvest");
                            var allFound = true;
                            for (var i = 0; i < array_length(obj_HoloHouseManager.categorizedItems[1]); i++)
                            {
                                if (is_undefined(item_get(obj_HoloHouseManager.categorizedItems[1][i].inventoryID)))
                                {
                                    allFound = false;
                                }
                            }
                            if (allFound)
                            {
                                DoAchievement("lovenature");
                            }
                            cropsResults = false;
                            obj_Player.canControl = true;
                            obj_HoloHouseManager.canControl = true;
                            var crop = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
                            crop.sprite_index = ds_map_find_value(global.InventoryLibrary, cropID).inventoryIcon;
                            audio_play_sound(snd_fishGet, 0, 0);
                            inventory_add(cropID, yieldNumber);
                            with (obj_itemLightBeam)
                            {
                                instance_destroy();
                            }
                            seedID = -1;
                            soilID = -1;
                            cropID = -1;
                            growTime = 0;
                            lifetime = 0;
                            growthState = 0;
                            grown = false;
                            waterCD = 0;
                            obj_PlantManager.SavePlants();
                            cropsResultsTimer = 0;
                            Return();
                        }
                        else if (!cropsResults)
                        {
                            part_emitter_stream(global.psystem, emitter, global.partType3, 0);
                            part_emitter_clear(global.psystem, emitter);
                            resultsContainer[1] = -120;
                            audio_play_sound(snd_cropGet, 30, 0);
                            global.new_camera_scale = 1;
                            global.cameraXOffset = 0;
                            global.cameraYOffset = 0;
                            cropsResults = true;
                            yieldNumber = 1 + irandom(2);
                            if (soilID.id == "enhancedsoil")
                            {
                                yieldNumber = (yieldNumber * 2) + irandom(yieldNumber);
                            }
                        }
                    }
                    else
                    {
                        Water();
                    }
                }
                else if (pauseOption == 1)
                {
                    if (removeConfirm && !grown && removeOption == 0)
                    {
                        removeConfirm = false;
                        seedID = -1;
                        soilID = -1;
                        cropID = -1;
                        growTime = 0;
                        lifetime = 0;
                        growthState = 0;
                        grown = false;
                        waterCD = 0;
                        audio_play_sound(snd_removeplant, 30, 0);
                    }
                    else if (seedID != -1 && !grown && removeOption == 0)
                    {
                        removeConfirm = true;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                    else if (seedID != -1 && !grown && removeOption == 1)
                    {
                        audio_play_sound(snd_menu_back, 30, 0);
                        Return();
                    }
                }
                else
                {
                    audio_play_sound(snd_menu_back, 30, 0);
                    Return();
                }
                break;
            case UnknownEnum.Value_1:
                if (array_length(displayingInventory1) > 0)
                {
                    if (item_get(displayingInventory1[inventorySelect1 + startingPosition].id) > 0)
                    {
                        currentMenu = UnknownEnum.Value_2;
                        rightContainer2 = [720, 50];
                        displayingInventory2 = obj_HoloHouseManager.SeedInventory();
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_2:
                if (array_length(displayingInventory2) > 0)
                {
                    if (item_get(displayingInventory2[inventorySelect2 + startingPosition2].id) > 0)
                    {
                        currentMenu = UnknownEnum.Value_3;
                        farmConfirmSelect = 0;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_3:
                if (farmConfirmSelect == 0)
                {
                    currentMenu = -1;
                    farmConfirmSelect = 0;
                    audio_play_sound(snd_plant, 30, 0);
                    inventory_remove(displayingInventory2[inventorySelect2 + startingPosition2].id);
                    inventory_remove(displayingInventory1[inventorySelect1 + startingPosition].id);
                    seedID = displayingInventory2[inventorySelect2 + startingPosition2];
                    soilID = displayingInventory1[inventorySelect1 + startingPosition];
                    cropID = seedID.config.cropID;
                    growTime = seedID.config.growthTime;
                    if (soilID.id == "expeditedsoil")
                    {
                        growTime = floor(growTime * 0.6);
                    }
                    lifetime = 0;
                    growthState = 0;
                    waterCD = 0;
                    interacting = false;
                    obj_Player.canControl = true;
                    obj_HoloHouseManager.canControl = true;
                    global.new_camera_scale = 1;
                    global.cameraXOffset = 0;
                    global.cameraYOffset = 0;
                }
                else
                {
                    Return();
                }
                break;
        }
    }
}

function Return()
{
    if (interacting)
    {
        switch (currentMenu)
        {
            case UnknownEnum.Value_0:
                if (!cropsResults)
                {
                    if (removeConfirm)
                    {
                        removeConfirm = false;
                    }
                    else
                    {
                        interacting = false;
                        obj_Player.canControl = true;
                        obj_HoloHouseManager.alarm[1] = 5;
                        global.new_camera_scale = 1;
                        global.cameraXOffset = 0;
                        global.cameraYOffset = 0;
                    }
                }
                break;
            case UnknownEnum.Value_1:
                currentMenu = UnknownEnum.Value_0;
                audio_play_sound(snd_menu_back, 30, 0);
                break;
            case UnknownEnum.Value_2:
                currentMenu = UnknownEnum.Value_1;
                rightContainer2 = [667, 50];
                audio_play_sound(snd_menu_back, 30, 0);
                break;
            case UnknownEnum.Value_3:
                currentMenu = UnknownEnum.Value_2;
                audio_play_sound(snd_menu_back, 30, 0);
                break;
        }
    }
}

function SelectLeft()
{
    if (currentMenu == UnknownEnum.Value_0 && removeConfirm)
    {
        removeOption = !removeOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (currentMenu == UnknownEnum.Value_3)
    {
        farmConfirmSelect = !farmConfirmSelect;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectRight()
{
    if (currentMenu == UnknownEnum.Value_0 && removeConfirm)
    {
        removeOption = !removeOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (currentMenu == UnknownEnum.Value_3)
    {
        farmConfirmSelect = !farmConfirmSelect;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectUp()
{
    if (currentMenu == UnknownEnum.Value_0 && !cropsResults)
    {
        if (pauseOption > 0)
        {
            pauseOption--;
        }
        else
        {
            pauseOption = 2;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (currentMenu == UnknownEnum.Value_1)
    {
        if (array_length(displayingInventory1) > 0)
        {
            if (inventorySelect1 > 0)
            {
                inventorySelect1--;
            }
            else
            {
                inventorySelect1 = array_length(displayingInventory1) - 1;
            }
            global.soilSelect = inventorySelect1;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (currentMenu == UnknownEnum.Value_2)
    {
        if (array_length(displayingInventory2) > 0)
        {
            if ((inventorySelect2 + startingPosition2) > 0)
            {
                if (inventorySelect2 == 0)
                {
                    startingPosition2--;
                }
                else
                {
                    inventorySelect2--;
                }
            }
            else
            {
                inventorySelect2 = 5;
                startingPosition2 = array_length(displayingInventory2) - 1 - 5;
            }
            global.plantStartingPosition = startingPosition2;
            global.plantSelect = inventorySelect2;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectDown()
{
    if (currentMenu == UnknownEnum.Value_0 && !cropsResults)
    {
        if (pauseOption < 2)
        {
            pauseOption++;
        }
        else
        {
            pauseOption = 0;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (currentMenu == UnknownEnum.Value_1)
    {
        if (array_length(displayingInventory1) > 0)
        {
            if (inventorySelect1 < (array_length(displayingInventory1) - 1))
            {
                inventorySelect1++;
            }
            else
            {
                inventorySelect1 = 0;
            }
            global.soilSelect = inventorySelect1;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (currentMenu == UnknownEnum.Value_2)
    {
        if (array_length(displayingInventory2) > 0)
        {
            if ((inventorySelect2 + startingPosition2) < (array_length(displayingInventory2) - 1))
            {
                if (inventorySelect2 == 5)
                {
                    startingPosition2++;
                }
                else
                {
                    inventorySelect2++;
                }
            }
            else
            {
                inventorySelect2 = 0;
                startingPosition2 = 0;
            }
            audio_play_sound(snd_menu_select, 30, 0);
            global.plantStartingPosition = startingPosition2;
            global.plantSelect = inventorySelect2;
        }
    }
}

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirm();
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
