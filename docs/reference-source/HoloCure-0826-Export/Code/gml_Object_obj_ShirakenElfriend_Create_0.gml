pauseOption = 0;
pauseMenu = -1;
interactIcon = 754;
menuContainer = [110, 50];
highlighted = false;
inventoryMenu = [200, 50];
displayingInventory = [];
sellingInventory = [];
startingPosition = 0;
inventorySelect = 0;
sellConfirm = false;
itemArray = [];
interactIconY = 45;
interactRange = 25;
resetConfirm = false;
resetOption = 0;
furnitureCategory = 0;
spriteColor = 16777215;
interactable = true;
interacting = false;
canControl = true;
pauseItems = 4;
cursorTime = 0;
menuItems = 5;
itemBuySelect = 0;
itemBuyConfirm = false;

function ClickButton()
{
    if (mouse_check_button_pressed(mb_left))
    {
        Confirm();
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
        pauseMenu = -1;
        audio_play_sound(snd_interact, 30, 0);
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
                        obj_HoloHouseManager.InitiateFurniture();
                        break;
                    case UnknownEnum.Value_1:
                        if (resetConfirm)
                        {
                            if (resetOption == 0)
                            {
                                ds_map_set(global.PlayerSave, "holoHouseFloor", -1);
                                ds_map_set(global.PlayerSave, "holoHouseWall", -1);
                                ds_map_set(global.PlayerSave, "holoHouseSet", {});
                                resetConfirm = false;
                                audio_play_sound(snd_stickersell, 30, 0);
                                SavePlayerSave();
                            }
                            else
                            {
                                Return();
                            }
                        }
                        else
                        {
                            audio_play_sound(snd_menu_confirm, 30, 0);
                            resetConfirm = true;
                            resetOption = 1;
                            canControl = false;
                            alarm[0] = 20;
                        }
                        break;
                    case UnknownEnum.Value_2:
                        obj_DialogueController.BeginDialogue(global.TextContainer.elfriendDialogue.selectedLanguage, id);
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case UnknownEnum.Value_3:
                        Return();
                        break;
                }
                break;
            case UnknownEnum.Value_0:
                if (itemBuyConfirm && (global.debug || ds_map_find_value(global.PlayerSave, "holoCoins") >= obj_HoloHouseManager.allFurnitureArray[furnitureCategory][inventorySelect + startingPosition].furnitureCost))
                {
                    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") - obj_HoloHouseManager.allFurnitureArray[furnitureCategory][inventorySelect + startingPosition].furnitureCost);
                    itemBuyConfirm = false;
                    audio_play_sound(snd_fishSold, 30, 0);
                    array_push(ds_map_find_value(global.PlayerSave, "unlockedFurniture"), obj_HoloHouseManager.allFurnitureArray[furnitureCategory][inventorySelect + startingPosition].furnitureID);
                    SavePlayerSave();
                }
                else
                {
                    var furnUnlocked = furniture_unlocked(obj_HoloHouseManager.allFurnitureArray[furnitureCategory][inventorySelect + startingPosition].furnitureID);
                    if (!furnUnlocked)
                    {
                        itemBuyConfirm = true;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                break;
            case UnknownEnum.Value_1:
                break;
        }
    }
}

function Return()
{
    if (!canControl)
    {
        exit;
    }
    if (interacting)
    {
        switch (pauseMenu)
        {
            case -1:
                if (resetConfirm)
                {
                    resetConfirm = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                else
                {
                    interacting = false;
                    obj_Player.canControl = true;
                    obj_HoloHouseManager.alarm[1] = 5;
                    audio_play_sound(snd_menu_back, 30, 0);
                    pauseMenu = -1;
                    pauseOption = 0;
                }
                break;
            case UnknownEnum.Value_0:
                if (itemBuyConfirm)
                {
                    itemBuyConfirm = false;
                    itemBuySelect = 0;
                }
                else if (sellConfirm)
                {
                    sellConfirm = false;
                }
                else
                {
                    pauseMenu = -1;
                }
                audio_play_sound(snd_menu_back, 30, 0);
                break;
        }
    }
}

function SelectLeft()
{
    if (!canControl)
    {
        exit;
    }
    if (resetConfirm)
    {
        resetOption = !resetOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu == 0 && !itemBuyConfirm)
    {
        if (furnitureCategory == 0)
        {
            furnitureCategory = 7;
        }
        else
        {
            furnitureCategory--;
        }
        startingPosition = 0;
        inventorySelect = 0;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectRight()
{
    if (!canControl)
    {
        exit;
    }
    if (resetConfirm)
    {
        resetOption = !resetOption;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu == 0 && !itemBuyConfirm)
    {
        if (furnitureCategory == 7)
        {
            furnitureCategory = 0;
        }
        else
        {
            furnitureCategory++;
        }
        startingPosition = 0;
        inventorySelect = 0;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

function SelectUp()
{
    if (!canControl)
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
            pauseOption = 3;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu < 1)
    {
        if (array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) > 0 && !itemBuyConfirm)
        {
            if (inventorySelect > 0)
            {
                inventorySelect--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (inventorySelect == 0)
            {
                if (array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) < menuItems)
                {
                    inventorySelect = array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) - 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (((inventorySelect + startingPosition) - 1) >= 0)
                {
                    startingPosition--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    startingPosition = array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) - menuItems;
                    inventorySelect = menuItems - 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectDown()
{
    if (!canControl)
    {
        exit;
    }
    if (pauseMenu == -1)
    {
        if (pauseOption < 3)
        {
            pauseOption++;
        }
        else
        {
            pauseOption = 0;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu < 1)
    {
        if (array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) > 0 && !itemBuyConfirm)
        {
            if (inventorySelect < min(menuItems - 1, array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) - 1))
            {
                inventorySelect++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (inventorySelect == (array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) - 1))
            {
                inventorySelect = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (inventorySelect == (menuItems - 1))
            {
                if ((inventorySelect + startingPosition) == (array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) - 1))
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
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
