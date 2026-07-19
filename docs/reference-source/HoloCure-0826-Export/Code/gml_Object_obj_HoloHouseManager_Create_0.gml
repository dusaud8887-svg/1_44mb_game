audio_stop_sound(bgm_SSS);
if (!variable_global_exists("resetLevel"))
{
    global.resetLevel = false;
}
glr_clear_all();
global.lightingExists = false;
global.timesDodged = 0;
global.reflection = false;
controlsFree = false;
paused = false;
paused_screen_sprite = -1;
paused_screen = -1;
charPortrait = -1;
charWeapon = -1;
charSpecial = -1;
charName = "";
depth = -4000;
buildingMode = false;
currentOutfit = 0;
holdLevel = 0;
quitConfirm = false;
quitOption = 0;
gridCursor = [0, 0];
buildingMode = false;
placingObject = -1;
furnitureArray = [];
currentRotation = 0;
placing = false;
furnitureSelected = false;
pickedUp = false;
pickedUpMenu = false;
pickedUpOption = 0;
savedObject = [];
pickingObject = -1;
pauseContainer[0] = 320;
pauseContainer[1] = 80;
pauseOption = 0;
blackFlash = 1;
pauseItems = 4;
pauseMenu = 0;
inventoryMenu = [200, 50];
inventorying = false;
inventoryTab = 0;
inventorySelect = 0;
inventoryArray = [];
categorizedItems = [];
displayingInventory = [];
startingPosition = 0;
whiteFlash = 0;
fullroom = false;
availableNPCs = [];
rodsInventory = [];
global.topBorder = -1;
global.bottomBorder = -1;
global.leftBorder = -1;
global.rightBorder = -1;
HoloHouseMessages = [];
messagesContainer = [5, 270];
categoryTypes = ["beds", "living", "kitchen", "wash", "decor", "structure", "wall", "interior"];
allFurnitureArray = [];
categoryTypeArray = [];
onlySeed = [];
onlySoil = [];
for (var i = 0; i < array_length(categoryTypes); i++)
{
    array_push(allFurnitureArray, []);
    array_push(categoryTypeArray, []);
}
global.wrappingStage = true;
openCatalog = 0;
catalogPage = 0;
catalogSelected = false;
itemOption = 0;
itemSelected = false;
menuContainer = [110, 80];
startingPosition = 0;
global.psystem = part_system_create_layer("instances", true);
initialize_particles();
playerFlags = 
{
    moved: false,
    usedSpecial: false,
    strafed: false,
    aimed: false
};
quitConfirm = false;
quitOption = 0;
global.camera_scale = 1;
global.new_camera_scale = 1;
if (!variable_global_exists("playingStage"))
{
    global.playingStage = -1;
}
cursorTime = 0;
canControl = true;
part_emitter_destroy_all(global.psystem);
display_set_gui_size(640, 360);
menuMode = false;
autoSaveTimer = 1800;

function ExecuteFlash()
{
    whiteFlash = 1;
    alarm[5] = 1;
}

function PopMessage(arg0, arg1 = 240)
{
    var newMessage = [[obj_TextController.JPAS(arg0), arg1]];
    HoloHouseMessages = array_concat(newMessage, HoloHouseMessages);
    messagesContainer[1] = 295;
}

function InitItemLibrary()
{
    inventoryArray = array_create(ds_map_size(global.InventoryLibrary));
    categorizedItems = [];
    var key = ds_map_find_first(global.InventoryLibrary);
    for (var i = 0; i < ds_map_size(global.InventoryLibrary); i++)
    {
        array_set(inventoryArray, ds_map_find_value(global.InventoryLibrary, key).inventoryNumber, ds_map_find_value(global.InventoryLibrary, key));
        key = ds_map_find_next(global.InventoryLibrary, key);
    }
    var fishArray = [];
    var cropsArray = [];
    var seedArray = [];
    var soilArray = [];
    var rodArray = [];
    for (var i = 0; i < array_length(inventoryArray); i++)
    {
        if (inventoryArray[i].inventoryType == "fish")
        {
            array_push(fishArray, inventoryArray[i]);
        }
        else if (inventoryArray[i].inventoryType == "crop")
        {
            array_push(cropsArray, inventoryArray[i]);
        }
        else if (inventoryArray[i].inventoryType == "soil")
        {
            array_push(soilArray, inventoryArray[i]);
        }
        else if (inventoryArray[i].inventoryType == "seed")
        {
            array_push(seedArray, inventoryArray[i]);
        }
        else if (inventoryArray[i].inventoryType == "rod")
        {
            array_push(rodArray, inventoryArray[i]);
        }
    }
    categorizedItems[0] = fishArray;
    categorizedItems[1] = cropsArray;
    categorizedItems[2] = array_concat(soilArray, seedArray);
    categorizedItems[3] = rodArray;
    onlySoil = soilArray;
    onlySeed = seedArray;
}

function GetRandomFeed(arg0)
{
    var feedArray = [];
    for (var i = 0; i < array_length(categorizedItems[0]); i++)
    {
        if (variable_struct_exists(categorizedItems[0][i].config, "tier") && categorizedItems[0][i].config.tier <= arg0)
        {
            array_push(feedArray, categorizedItems[0][i]);
        }
    }
    for (var i = 0; i < array_length(categorizedItems[1]); i++)
    {
        if (variable_struct_exists(categorizedItems[1][i].config, "tier") && categorizedItems[1][i].config.tier <= arg0)
        {
            array_push(feedArray, categorizedItems[1][i]);
        }
    }
    var randomFeed = irandom(array_length(feedArray) - 1);
    return feedArray[randomFeed].inventoryID;
}

function InitInventory()
{
    displayingInventory = [];
    for (var i = 0; i < array_length(categorizedItems[inventoryTab]); i++)
    {
        var getItem = categorizedItems[inventoryTab][i];
        if (item_exists(getItem.id))
        {
            array_push(displayingInventory, getItem);
        }
    }
}

function FishInventory()
{
    var fishInventory = [];
    for (var i = 0; i < array_length(categorizedItems[0]); i++)
    {
        var getItem = categorizedItems[0][i];
        if (item_exists(getItem.id))
        {
            array_push(fishInventory, getItem);
        }
    }
    return fishInventory;
}

function CropInventory()
{
    var cropsInventory = [];
    for (var i = 0; i < array_length(categorizedItems[1]); i++)
    {
        var getItem = categorizedItems[1][i];
        if (item_exists(getItem.id))
        {
            array_push(cropsInventory, getItem);
        }
    }
    return cropsInventory;
}

function SeedSoilInventory()
{
    var cropsInventory = [];
    for (var i = 0; i < array_length(categorizedItems[2]); i++)
    {
        var getItem = categorizedItems[2][i];
        if (item_exists(getItem.id))
        {
            array_push(cropsInventory, getItem);
        }
    }
    return cropsInventory;
}

function SeedInventory()
{
    var cropsInventory = [];
    for (var i = 0; i < array_length(onlySeed); i++)
    {
        var getItem = onlySeed[i];
        if (item_exists(getItem.id))
        {
            array_push(cropsInventory, getItem);
        }
    }
    return cropsInventory;
}

function SoilInventory()
{
    var cropsInventory = [];
    for (var i = 0; i < array_length(onlySoil); i++)
    {
        var getItem = onlySoil[i];
        if (item_exists(getItem.id))
        {
            array_push(cropsInventory, getItem);
        }
    }
    return cropsInventory;
}

function RodInventory()
{
    rodsInventory = [];
    for (var i = 0; i < array_length(categorizedItems[3]); i++)
    {
        var getItem = categorizedItems[3][i];
        if (array_get(ds_map_find_value(global.PlayerSave, "rodUnlock"), i))
        {
            array_push(rodsInventory, getItem);
        }
    }
    return rodsInventory;
}

function ValidPlacement()
{
    var valid = true;
    var gridCheckFloor = -1;
    var gridCheckWall = -1;
    if (!instance_exists(obj_HoloHouseInterior))
    {
        return false;
    }
    var gridCheck = instance_find(obj_HoloHouseInterior, 0);
    gridCheckFloor = gridCheck.interiorGrid;
    gridCheckWall = gridCheck.interiorWall;
    if (placingObject.furnitureType == "wall")
    {
        if (gridCursor[1] >= 0 || ((gridCursor[0] + placingObject.gridData[0]) - 1) > (gridCheck.gridWidth - 1) || ((gridCursor[1] + placingObject.gridData[1]) - 1) >= 0)
        {
            return false;
        }
        if (gridCursor[1] < 0)
        {
            for (var i = 0; i < placingObject.gridData[1]; i++)
            {
                for (var j = 0; j < placingObject.gridData[0]; j++)
                {
                    if (gridCheckWall[gridCursor[0] + j][gridCursor[1] + i + 5] != -1)
                    {
                        valid = false;
                        break;
                    }
                }
            }
        }
    }
    else
    {
        if (gridCursor[1] < 0 || (((gridCursor[0] + placingObject.gridData[0]) - 1) > (gridCheck.gridWidth - 1) && currentRotation < 2) || (((gridCursor[0] + placingObject.gridData[1]) - 1) > (gridCheck.gridWidth - 1) && currentRotation > 1) || (((gridCursor[1] + placingObject.gridData[1]) - 1) > (gridCheck.gridHeight - 1) && currentRotation < 2) || (((gridCursor[1] + placingObject.gridData[0]) - 1) > (gridCheck.gridHeight - 1) && currentRotation > 1))
        {
            return false;
        }
        if (currentRotation < 2)
        {
            for (var i = 0; i < placingObject.gridData[1]; i++)
            {
                for (var j = 0; j < placingObject.gridData[0]; j++)
                {
                    if (gridCheckFloor[gridCursor[0] + j][gridCursor[1] + i] != -1)
                    {
                        valid = false;
                        break;
                    }
                }
            }
        }
        else
        {
            for (var i = 0; i < placingObject.gridData[0]; i++)
            {
                for (var j = 0; j < placingObject.gridData[1]; j++)
                {
                    if (gridCheckFloor[gridCursor[0] + j][gridCursor[1] + i] != -1)
                    {
                        valid = false;
                        break;
                    }
                }
            }
        }
    }
    return valid;
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
    audio_stop_sound(snd_crickets);
}

function Unpause()
{
    room_goto(global.playingStage);
    alarm[9] = 1;
}

function SelectUp()
{
    if (canControl)
    {
        switch (pauseMenu)
        {
            case UnknownEnum.Value_0:
                if (pauseOption > 0)
                {
                    if (!quitConfirm)
                    {
                        pauseOption--;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else
                    {
                        quitOption = !quitOption;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                else if (!quitConfirm)
                {
                    pauseOption = 3;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
            case UnknownEnum.Value_1:
                if (inventorying)
                {
                    if (array_length(displayingInventory) > 0 || (inventoryTab == 3 && array_length(rodsInventory) > 0))
                    {
                        var theInventory = [];
                        if (inventoryTab == 3)
                        {
                            theInventory = rodsInventory;
                        }
                        else
                        {
                            theInventory = displayingInventory;
                        }
                        if (inventorySelect > 0)
                        {
                            inventorySelect--;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        else if (inventorySelect == 0)
                        {
                            if (array_length(theInventory) < 6)
                            {
                                inventorySelect = array_length(theInventory) - 1;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                            else if ((inventorySelect + startingPosition) > 0)
                            {
                                startingPosition--;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                            else
                            {
                                startingPosition = array_length(theInventory) - 6;
                                inventorySelect = 5;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                        }
                    }
                }
            case UnknownEnum.Value_2:
                if (openCatalog && catalogPage > 0 && !catalogSelected)
                {
                    catalogPage--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
        }
        if (buildingMode)
        {
            if (openCatalog && catalogSelected && !itemSelected)
            {
                if ((itemOption - 8) >= 0)
                {
                    itemOption -= 8;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (placing)
            {
                currentRotation = 1;
            }
            else if (pickedUpMenu)
            {
                if (pickedUpOption == 1)
                {
                    pickedUpOption = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    pickedUpOption = 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (gridCursor[1] > -5 && !openCatalog && !pickedUpMenu)
            {
                gridCursor[1]--;
            }
        }
    }
}

function SelectDown()
{
    if (canControl)
    {
        switch (pauseMenu)
        {
            case UnknownEnum.Value_0:
                if (pauseOption < (pauseItems - 1))
                {
                    if (!quitConfirm)
                    {
                        pauseOption++;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else
                    {
                        quitOption = !quitOption;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                else if (!quitConfirm)
                {
                    pauseOption = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    quitOption = !quitOption;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
            case UnknownEnum.Value_1:
                if (inventorying)
                {
                    if (array_length(displayingInventory) > 0 || (inventoryTab == 3 && array_length(rodsInventory) > 0))
                    {
                        var theInventory = [];
                        if (inventoryTab == 3)
                        {
                            theInventory = rodsInventory;
                        }
                        else
                        {
                            theInventory = displayingInventory;
                        }
                        if (inventorySelect < min(5, array_length(theInventory) - 1))
                        {
                            inventorySelect++;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        else if (inventorySelect == (array_length(theInventory) - 1))
                        {
                            inventorySelect = 0;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        else if (inventorySelect == 5)
                        {
                            if ((inventorySelect + startingPosition) == (array_length(theInventory) - 1))
                            {
                                inventorySelect = 0;
                                startingPosition = 0;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                            else
                            {
                                startingPosition++;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                        }
                    }
                }
                break;
            case UnknownEnum.Value_2:
                if (openCatalog && catalogPage < (array_length(categoryTypes) - 1) && !catalogSelected)
                {
                    catalogPage++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                break;
        }
        if (buildingMode)
        {
            if (openCatalog && catalogSelected && !itemSelected)
            {
                if ((itemOption + 8) < array_length(categoryTypeArray[catalogPage]))
                {
                    itemOption += 8;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (placing)
            {
                currentRotation = 0;
            }
            else if (pickedUpMenu)
            {
                if (pickedUpOption == 1)
                {
                    pickedUpOption = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    pickedUpOption = 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (gridCursor[1] < (obj_HoloHouseInterior.gridHeight - 1) && !openCatalog && !pickedUpMenu)
            {
                gridCursor[1]++;
            }
        }
    }
}

function SelectLeft()
{
    if (canControl)
    {
        if (inventorying)
        {
            if (inventoryTab == 0)
            {
                inventoryTab = 3;
            }
            else
            {
                inventoryTab--;
            }
            InitInventory();
            RodInventory();
            startingPosition = 0;
            inventorySelect = 0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (buildingMode)
        {
            if (openCatalog && catalogSelected && !itemSelected)
            {
                if ((itemOption - 1) >= 0)
                {
                    itemOption--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (placing)
            {
                currentRotation = 3;
            }
            else if (gridCursor[0] > 0 && !openCatalog && !pickedUpMenu)
            {
                gridCursor[0]--;
            }
        }
    }
}

function SelectRight()
{
    if (canControl)
    {
        if (inventorying)
        {
            if (inventoryTab == 3)
            {
                inventoryTab = 0;
            }
            else
            {
                inventoryTab++;
            }
            startingPosition = 0;
            inventorySelect = 0;
            InitInventory();
            RodInventory();
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (buildingMode)
        {
            if (openCatalog && catalogSelected && !itemSelected)
            {
                if ((itemOption + 1) < array_length(categoryTypeArray[catalogPage]))
                {
                    itemOption++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (placing)
            {
                currentRotation = 2;
            }
            else if (gridCursor[0] < (obj_HoloHouseInterior.gridWidth - 1) && !openCatalog && !pickedUpMenu)
            {
                gridCursor[0]++;
            }
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

function SaveThings()
{
    if (instance_exists(obj_PlantManager))
    {
        obj_PlantManager.SavePlants();
    }
    if (instance_exists(obj_HerdingBoard))
    {
        obj_HerdingBoard.SaveWorkers();
    }
}

function Confirmed()
{
    if (canControl)
    {
        if (paused && quitConfirm)
        {
            if (quitOption == 0)
            {
                global.resetLevel = true;
                room_goto(rm_Title);
                part_emitter_destroy_all(global.psystem);
                audio_play_sound(snd_menu_confirm, 30, 0);
                audio_group_set_gain(1, global.musicVolume, 500);
                audio_stop_sound(global.bgmPlay);
                audio_stop_sound(snd_cookingpot);
                audio_stop_sound(snd_lake);
                audio_stop_sound(snd_crickets);
                SaveThings();
                global.new_camera_scale = 1;
                if (audio_is_playing(snd_rain))
                {
                    audio_stop_sound(snd_rain);
                }
            }
            else
            {
                quitConfirm = false;
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
        }
        else
        {
            switch (pauseOption + 1)
            {
                case UnknownEnum.Value_1:
                    if (!inventorying)
                    {
                        inventorying = true;
                        inventoryTab = 0;
                        inventorySelect = 0;
                        startingPosition = 0;
                        pauseMenu = UnknownEnum.Value_1;
                        InitInventory();
                        RodInventory();
                        inventoryMenu = [800, 50];
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                    else if (inventoryTab == 3)
                    {
                        var rodArrayOrder = ["beginnersRod", "dadsRod", "blacksmithRod", "atlanticRod", "turkeyRod", "goldenRod"];
                        var getSelectedRod = rodsInventory[inventorySelect].inventoryID;
                        var rodIndex = 0;
                        for (var i = 0; i < array_length(rodArrayOrder); i++)
                        {
                            if (getSelectedRod == rodArrayOrder[i])
                            {
                                rodIndex = i;
                            }
                        }
                        ds_map_set(global.PlayerSave, "fishRod", rodIndex);
                        obj_FishingMiniGame.ChainReset();
                        audio_play_sound(snd_furniturePlace, 30, 0);
                    }
                    break;
                case UnknownEnum.Value_2:
                    if (instance_exists(obj_HoloHouseInterior))
                    {
                        if (!buildingMode)
                        {
                            pauseMenu = UnknownEnum.Value_2;
                            obj_HoloHouseInterior.buildingMode = true;
                            buildingMode = true;
                            placingObject = -1;
                            currentRotation = 0;
                            placing = false;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                            obj_HoloHouseManager.InitiateFurniture();
                            gridCursor = [(obj_Player.x - 96) div 16, min(12, (obj_Player.y - 112) div 16)];
                        }
                        else if (buildingMode && placingObject == -1 && !openCatalog)
                        {
                            var isEmpty = true;
                            var grid = instance_find(obj_HoloHouseInterior, 0);
                            if (gridCursor[1] < 0)
                            {
                                if (grid.interiorWall[gridCursor[0]][gridCursor[1] + 5] != -1)
                                {
                                    if (!pickedUpMenu)
                                    {
                                        pickedUpMenu = true;
                                        pickingObject = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5];
                                        pickedUpOption = 0;
                                        isEmpty = false;
                                        audio_play_sound(snd_menu_confirm, 30, 0);
                                        pickingObject.highlighted = true;
                                    }
                                    else if (pickedUpMenu && pickedUpOption == 0)
                                    {
                                        isEmpty = false;
                                        pickedUpMenu = false;
                                        placingObject = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].furnitureData;
                                        currentRotation = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].currentRotation;
                                        gridCursor[0] = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].origin[0];
                                        gridCursor[1] = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].origin[1];
                                        pickedUp = true;
                                        with (grid.interiorWall[gridCursor[0]][gridCursor[1] + 5])
                                        {
                                            instance_destroy();
                                        }
                                        savedObject = [placingObject, currentRotation, gridCursor[0], gridCursor[1]];
                                        SetGrid("remove");
                                        ProcessGridData();
                                        audio_play_sound(snd_furnPick, 30, 0);
                                        pickingObject = -1;
                                    }
                                    else if (pickedUpMenu && pickedUpOption == 1)
                                    {
                                        isEmpty = false;
                                        pickedUpMenu = false;
                                        placingObject = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].furnitureData;
                                        currentRotation = pickingObject.currentRotation;
                                        gridCursor[0] = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].origin[0];
                                        gridCursor[1] = grid.interiorWall[gridCursor[0]][gridCursor[1] + 5].origin[1];
                                        with (grid.interiorWall[gridCursor[0]][gridCursor[1] + 5])
                                        {
                                            instance_destroy();
                                        }
                                        SetGrid("remove");
                                        ProcessGridData();
                                        SavePlayerSave();
                                        placingObject = -1;
                                        audio_play_sound(snd_stickersell, 30, 0);
                                        pickingObject = -1;
                                    }
                                }
                            }
                            else if (grid.interiorGrid[gridCursor[0]][gridCursor[1]] != -1)
                            {
                                if (!pickedUpMenu)
                                {
                                    pickedUpMenu = true;
                                    pickingObject = grid.interiorGrid[gridCursor[0]][gridCursor[1]];
                                    pickedUpOption = 0;
                                    isEmpty = false;
                                    audio_play_sound(snd_menu_confirm, 30, 0);
                                    pickingObject.highlighted = true;
                                }
                                else if (pickedUpMenu && pickedUpOption == 0)
                                {
                                    isEmpty = false;
                                    pickedUpMenu = false;
                                    placingObject = grid.interiorGrid[gridCursor[0]][gridCursor[1]].furnitureData;
                                    currentRotation = grid.interiorGrid[gridCursor[0]][gridCursor[1]].currentRotation;
                                    gridCursor[0] = grid.interiorGrid[gridCursor[0]][gridCursor[1]].origin[0];
                                    gridCursor[1] = grid.interiorGrid[gridCursor[0]][gridCursor[1]].origin[1];
                                    pickedUp = true;
                                    with (grid.interiorGrid[gridCursor[0]][gridCursor[1]])
                                    {
                                        instance_destroy();
                                    }
                                    savedObject = [placingObject, currentRotation, gridCursor[0], gridCursor[1]];
                                    SetGrid("remove");
                                    ProcessGridData();
                                    audio_play_sound(snd_furnPick, 30, 0);
                                    pickingObject = -1;
                                }
                                else if (pickedUpMenu && pickedUpOption == 1)
                                {
                                    isEmpty = false;
                                    pickedUpMenu = false;
                                    placingObject = grid.interiorGrid[gridCursor[0]][gridCursor[1]].furnitureData;
                                    currentRotation = pickingObject.currentRotation;
                                    gridCursor[0] = grid.interiorGrid[gridCursor[0]][gridCursor[1]].origin[0];
                                    gridCursor[1] = grid.interiorGrid[gridCursor[0]][gridCursor[1]].origin[1];
                                    with (grid.interiorGrid[gridCursor[0]][gridCursor[1]])
                                    {
                                        instance_destroy();
                                    }
                                    SetGrid("remove");
                                    ProcessGridData();
                                    SavePlayerSave();
                                    placingObject = -1;
                                    audio_play_sound(snd_stickersell, 30, 0);
                                    pickingObject = -1;
                                }
                            }
                            if (isEmpty)
                            {
                                openCatalog = true;
                                pickedUp = false;
                                audio_play_sound(snd_menu_confirm, 30, 0);
                            }
                        }
                        else if (buildingMode && openCatalog && !catalogSelected && array_length(categoryTypeArray[catalogPage]) > 0)
                        {
                            catalogSelected = true;
                            itemOption = 0;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                        else if (buildingMode && openCatalog && catalogSelected)
                        {
                            if (catalogPage < (array_length(categoryTypeArray) - 1))
                            {
                                if (itemOption < array_length(categoryTypeArray[catalogPage]))
                                {
                                    itemSelected = true;
                                    placingObject = categoryTypeArray[catalogPage][itemOption];
                                    catalogSelected = false;
                                    openCatalog = false;
                                    audio_play_sound(snd_menu_confirm, 30, 0);
                                }
                            }
                            else if (itemOption < array_length(categoryTypeArray[catalogPage]))
                            {
                                if (categoryTypeArray[catalogPage][itemOption].gridData == "wall")
                                {
                                    obj_HoloHouse_Walls.SetWall(categoryTypeArray[catalogPage][itemOption].furnitureID);
                                    if (!is_struct(ds_map_find_value(global.PlayerSave, "holoHouseSet")))
                                    {
                                        ds_map_set(global.PlayerSave, "holoHouseSet", {});
                                    }
                                    variable_struct_set(ds_map_find_value(global.PlayerSave, "holoHouseSet"), "wall", categoryTypeArray[catalogPage][itemOption].furnitureID);
                                }
                                if (categoryTypeArray[catalogPage][itemOption].gridData == "floor")
                                {
                                    obj_HoloHouse_Floors.SetFloor(categoryTypeArray[catalogPage][itemOption].furnitureID);
                                    if (!is_struct(ds_map_find_value(global.PlayerSave, "holoHouseSet")))
                                    {
                                        ds_map_set(global.PlayerSave, "holoHouseSet", {});
                                    }
                                    variable_struct_set(ds_map_find_value(global.PlayerSave, "holoHouseSet"), "floor", categoryTypeArray[catalogPage][itemOption].furnitureID);
                                }
                                audio_play_sound(snd_menu_confirm, 30, 0);
                                SavePlayerSave();
                            }
                        }
                        else if (buildingMode && !openCatalog && !catalogSelected && placingObject != -1 && !placing)
                        {
                            if (ValidPlacement())
                            {
                                placing = true;
                                audio_play_sound(snd_menu_confirm, 30, 0);
                            }
                        }
                        else if (buildingMode && placingObject != -1 && placing)
                        {
                            if (ValidPlacement())
                            {
                                var furniture;
                                if (placingObject.isSolid)
                                {
                                    furniture = instance_create_depth(obj_HoloHouseInterior.x + (gridCursor[0] * 16), obj_HoloHouseInterior.y + (gridCursor[1] * 16), depth, obj_Furniture);
                                }
                                else
                                {
                                    furniture = instance_create_depth(obj_HoloHouseInterior.x + (gridCursor[0] * 16), obj_HoloHouseInterior.y + (gridCursor[1] * 16), depth, obj_Furniture2);
                                }
                                furniture.sprite_index = placingObject.sprites[currentRotation];
                                furniture.sprites = placingObject.sprites;
                                furniture.currentRotation = currentRotation;
                                furniture.furnitureData = placingObject;
                                furniture.origin = [gridCursor[0], gridCursor[1]];
                                furniture.spriteWidth = placingObject.spriteWidth;
                                furniture.spriteHeight = placingObject.spriteHeight;
                                furniture.scripts = {};
                                furniture.customDrawScriptAbove = {};
                                variable_struct_copy(placingObject.scripts, furniture.scripts);
                                variable_struct_copy(placingObject.customDrawScriptAbove, furniture.customDrawScriptAbove);
                                SetGrid("place", furniture);
                                audio_play_sound(snd_furniturePlace, 30, 0);
                                placing = false;
                                itemSelected = false;
                                ProcessGridData();
                                SavePlayerSave();
                                if (pickedUp)
                                {
                                    pickedUp = false;
                                    placingObject = -1;
                                }
                            }
                        }
                    }
                    break;
                case UnknownEnum.Value_3:
                    pauseCurrentMenu = -1;
                    canControl = false;
                    var optionsMan = instance_create_depth(x, y, depth, obj_Options);
                    optionsMan.playerMan = id;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    break;
                case UnknownEnum.Value_4:
                    quitConfirm = true;
                    quitOption = 0;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    break;
            }
        }
    }
    canControl = false;
    if (!instance_exists(obj_Options))
    {
        alarm[1] = 5;
    }
}

function ProcessGridData()
{
    var grid = instance_find(obj_HoloHouseInterior, 0);
    var gridFloor = array_create(grid.gridWidth, -1);
    for (var i = 0; i < grid.gridWidth; i++)
    {
        gridFloor[i] = array_create(grid.gridHeight, -1);
    }
    var gridWall = array_create(grid.gridWidth, -1);
    for (var i = 0; i < grid.gridWidth; i++)
    {
        gridWall[i] = array_create(grid.gridWall, -1);
    }
    var itemsAdded = [];
    for (var i = 0; i < grid.gridHeight; i++)
    {
        for (var j = 0; j < grid.gridWidth; j++)
        {
            if (grid.interiorGrid[j][i] != -1)
            {
                if (!array_exists(itemsAdded, grid.interiorGrid[j][i]))
                {
                    array_push(itemsAdded, grid.interiorGrid[j][i]);
                    gridFloor[j][i] = [grid.interiorGrid[j][i].furnitureData, grid.interiorGrid[j][i].currentRotation, grid.interiorGrid[j][i].origin];
                }
            }
        }
    }
    for (var i = 0; i < grid.gridWall; i++)
    {
        for (var j = 0; j < grid.gridWidth; j++)
        {
            if (grid.interiorWall[j][i] != -1)
            {
                if (!array_exists(itemsAdded, grid.interiorWall[j][i]))
                {
                    array_push(itemsAdded, grid.interiorWall[j][i]);
                    gridWall[j][i] = [grid.interiorWall[j][i].furnitureData, grid.interiorWall[j][i].currentRotation, grid.interiorWall[j][i].origin];
                }
            }
        }
    }
    ds_map_set(global.PlayerSave, "holoHouseFloor", gridFloor);
    ds_map_set(global.PlayerSave, "holoHouseWall", gridWall);
}

function SetGrid(arg0 = "place", arg1 = -1, arg2 = false)
{
    var grid = instance_find(obj_HoloHouseInterior, 0);
    var xGrid = 0;
    var yGrid = 0;
    var wallFurn = placingObject.furnitureType == "wall";
    var placingLoc = [-1, -1];
    if (arg2)
    {
        placingLoc = [savedObject[2], savedObject[3]];
    }
    else
    {
        placingLoc = [gridCursor[0], gridCursor[1]];
    }
    if (currentRotation < 2)
    {
        xGrid = placingObject.gridData[0];
        yGrid = placingObject.gridData[1];
    }
    else
    {
        xGrid = placingObject.gridData[1];
        yGrid = placingObject.gridData[0];
    }
    if (!wallFurn)
    {
        for (var i = 0; i < yGrid; i++)
        {
            for (var j = 0; j < xGrid; j++)
            {
                if (arg0 == "place" && arg1 > 0)
                {
                    grid.interiorGrid[placingLoc[0] + j][placingLoc[1] + i] = arg1;
                }
                else if (arg0 == "remove")
                {
                    grid.interiorGrid[placingLoc[0] + j][placingLoc[1] + i] = -1;
                }
            }
        }
    }
    else
    {
        for (var i = 0; i < yGrid; i++)
        {
            for (var j = 0; j < xGrid; j++)
            {
                if (arg0 == "place" && arg1 > 0)
                {
                    grid.interiorWall[placingLoc[0] + j][placingLoc[1] + i + grid.gridWall] = arg1;
                }
                else if (arg0 == "remove")
                {
                    grid.interiorWall[placingLoc[0] + j][placingLoc[1] + i + grid.gridWall] = -1;
                }
            }
        }
    }
}

function ReturnMenu()
{
    if (canControl)
    {
        canControl = false;
        alarm[1] = 3;
        if (!paused && obj_Player.canControl)
        {
            paused = true;
            audio_play_sound(snd_openmenu, 30, 0);
            obj_Player.canControl = false;
            menuContainer = [-210, 80];
        }
        else if (paused && quitConfirm)
        {
            quitConfirm = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else
        {
            switch (pauseMenu)
            {
                case UnknownEnum.Value_0:
                    paused = false;
                    obj_Player.canControl = true;
                    if (instance_exists(obj_HoloHouseInterior))
                    {
                        obj_HoloHouseInterior.buildingMode = false;
                        buildingMode = false;
                    }
                    audio_play_sound(snd_menu_back, 30, 0);
                    break;
                case UnknownEnum.Value_1:
                    inventorying = false;
                    pauseMenu = 0;
                    audio_play_sound(snd_menu_back, 30, 0);
                    break;
                case UnknownEnum.Value_2:
                    if (openCatalog)
                    {
                        if (catalogSelected)
                        {
                            catalogSelected = false;
                        }
                        else
                        {
                            openCatalog = false;
                        }
                        audio_play_sound(snd_menu_back, 30, 0);
                    }
                    else if (!openCatalog)
                    {
                        if (placingObject == -1)
                        {
                            if (pickedUpMenu)
                            {
                                pickedUpMenu = false;
                                pickingObject.highlighted = false;
                                pickingObject = -1;
                            }
                            else
                            {
                                buildingMode = false;
                                obj_HoloHouseInterior.buildingMode = false;
                                pauseMenu = 0;
                            }
                            audio_play_sound(snd_menu_back, 30, 0);
                        }
                        else if (placingObject != -1)
                        {
                            if (placing)
                            {
                                placing = false;
                                audio_play_sound(snd_menu_back, 30, 0);
                            }
                            else if (pickedUp)
                            {
                                placingObject = savedObject[0];
                                var furniture;
                                if (placingObject.isSolid)
                                {
                                    furniture = instance_create_depth(obj_HoloHouseInterior.x + (savedObject[2] * 16), obj_HoloHouseInterior.y + (savedObject[3] * 16), depth, obj_Furniture);
                                }
                                else
                                {
                                    furniture = instance_create_depth(obj_HoloHouseInterior.x + (savedObject[2] * 16), obj_HoloHouseInterior.y + (savedObject[3] * 16), depth, obj_Furniture2);
                                }
                                furniture.sprite_index = savedObject[0].sprites[savedObject[1]];
                                furniture.sprites = savedObject[0].sprites;
                                furniture.currentRotation = savedObject[1];
                                furniture.furnitureData = savedObject[0];
                                furniture.origin = [savedObject[2], savedObject[3]];
                                furniture.spriteWidth = savedObject[0].spriteWidth;
                                furniture.spriteHeight = savedObject[0].spriteHeight;
                                furniture.scripts = {};
                                furniture.customDrawScriptAbove = {};
                                furniture.isSolid = savedObject[0].isSolid;
                                variable_struct_copy(savedObject[0].scripts, furniture.scripts);
                                variable_struct_copy(savedObject[0].customDrawScriptAbove, furniture.customDrawScriptAbove);
                                SetGrid("place", furniture, true);
                                audio_play_sound(snd_furniturePlace, 30, 0);
                                placing = false;
                                itemSelected = false;
                                ProcessGridData();
                                savedObject = [];
                                pickedUp = false;
                                placingObject = -1;
                            }
                            else
                            {
                                placingObject = -1;
                                openCatalog = true;
                                catalogSelected = false;
                                itemSelected = false;
                                audio_play_sound(snd_menu_back, 30, 0);
                            }
                        }
                    }
                    break;
            }
        }
    }
}

function EnterKey()
{
    if (canControl)
    {
    }
}

function EscKey()
{
    if (canControl)
    {
        ReturnMenu();
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
    if (!instance_exists(obj_SpawnPoint))
    {
        createdChar = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Player);
    }
    else
    {
        createdChar = instance_create_layer(obj_SpawnPoint.x, obj_SpawnPoint.x, "Instances", obj_Player);
    }
    charPortrait = charData.port;
    charWeapon = charData.attackIcon;
    charSpecial = charData.specIcon;
    charName = charData.charName;
    global.maxHP = charData.HP;
    global.currentHP = global.maxHP;
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
    global.lives = 1;
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
    playerCharacter = createdChar;
    playerCharacter.specUnlock = 0;
    playerCharacter.stopAttacks = true;
    playerCharacter.regen = 0;
    playerCharacter.SPD = 2;
    playerCharacter.baseStats.SPD = 2;
    playerCharacter.prebuffStats.SPD = 2;
}

function Init()
{
    InitializeCharacter();
    randomize();
    global.bgmPlay = 146;
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

Init();
event_user(0);
event_user(1);

function InitiateFurniture()
{
    furnitureArray = array_create(ds_map_size(global.FurnitureLibrary));
    allFurnitureArray = [];
    categoryTypeArray = [];
    for (var i = 0; i < array_length(categoryTypes); i++)
    {
        array_push(allFurnitureArray, []);
        array_push(categoryTypeArray, []);
    }
    var key = ds_map_find_first(global.FurnitureLibrary);
    for (var i = 0; i < ds_map_size(global.FurnitureLibrary); i++)
    {
        array_set(furnitureArray, ds_map_find_value(global.FurnitureLibrary, key).furnitureNumber, ds_map_find_value(global.FurnitureLibrary, key));
        key = ds_map_find_next(global.FurnitureLibrary, key);
    }
    for (var i = 0; i < array_length(furnitureArray); i++)
    {
        for (var j = 0; j < array_length(categoryTypes); j++)
        {
            if (furnitureArray[i].furnitureType == categoryTypes[j])
            {
                if (furnitureArray[i].furnitureType == "wall" && string_pos("goldenfish", furnitureArray[i].furnitureID) != 0)
                {
                    if (goldfishcheck(furnitureArray[i].furnitureID))
                    {
                        if (furniture_unlocked(furnitureArray[i].furnitureID))
                        {
                            array_push(categoryTypeArray[j], furnitureArray[i]);
                        }
                        array_push(allFurnitureArray[j], furnitureArray[i]);
                    }
                }
                else if (furnitureArray[i].furnitureID == "hardcoretrophy")
                {
                    if (AchievementIsUnlocked("hardcoreGamer"))
                    {
                        if (furniture_unlocked(furnitureArray[i].furnitureID))
                        {
                            array_push(categoryTypeArray[j], furnitureArray[i]);
                        }
                        array_push(allFurnitureArray[j], furnitureArray[i]);
                    }
                }
                else if (furnitureArray[i].furnitureID == "completegrass")
                {
                    if (AchievementIsUnlocked("allcomplete"))
                    {
                        if (furniture_unlocked(furnitureArray[i].furnitureID))
                        {
                            array_push(categoryTypeArray[j], furnitureArray[i]);
                        }
                        array_push(allFurnitureArray[j], furnitureArray[i]);
                    }
                }
                else
                {
                    if (furniture_unlocked(furnitureArray[i].furnitureID))
                    {
                        array_push(categoryTypeArray[j], furnitureArray[i]);
                    }
                    array_push(allFurnitureArray[j], furnitureArray[i]);
                }
            }
        }
    }
}

function CreateRandomNPCs()
{
    var rand = irandom(6);
    availableNPCs = [];
    for (var i = 0; i < array_length(global.characterList); i++)
    {
        if (IsCharacterUnlocked(global.characterList[i]) && global.characterList[i] != global.charSelected.id && global.characterList[i] != "empty" && global.characterList[i] != "random")
        {
            array_push(availableNPCs, global.characterList[i]);
        }
    }
    for (var i = 0; i < rand; i++)
    {
        SpawnNPC();
    }
}

function SpawnNPC(arg0 = false)
{
    if (array_length(availableNPCs) > 0)
    {
        var charInt = irandom(array_length(availableNPCs) - 1);
        var getChar = ds_map_find_value(global.characterData, array_get(availableNPCs, charInt));
        var randomX = 961 + irandom(600);
        var randomY = 1266 + irandom(600);
        if (arg0)
        {
            randomX = obj_Player.x;
            randomY = obj_Player.y;
        }
        var charNPC = instance_create_depth(randomX, randomY, depth, obj_holoHouseNPC);
        charNPC.idleSprite = getChar.sprite1;
        charNPC.moveSprite = getChar.sprite2;
        charNPC.spawnCheck = true;
        charNPC.charID = getChar.id;
        array_delete(availableNPCs, charInt, 1);
    }
}

CreateRandomNPCs();
alarm[2] = 1800;
InitiateFurniture();
InitItemLibrary();
alarm[0] = 3;
DoAchievement("welcomehome");
FoodRecipes();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
