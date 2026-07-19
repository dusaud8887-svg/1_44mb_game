pauseOption = 0;
pauseMenu = -1;
interactIcon = 2232;
menuContainer = [110, 50];
highlighted = false;
inventoryMenu = [200, 50];
exchangeMenu = [250, 120];
displayingInventory = [];
sellingInventory = [];
startingPosition = 0;
inventorySelect = 0;
sellConfirm = false;
rodArray = [];
interactIconY = 65;
interactRange = 30;
exchangeArray = [];
currentSand = 0;
currentExchangeIndex = 0;
exchangeOption = true;
spriteColor = 16777215;
interactable = true;
interacting = false;
canControl = true;
pauseItems = 5;
cursorTime = 0;
menuItems = 0;
rodBuySelect = 0;
rodBuyConfirm = false;

function InitRods()
{
    var rodArrayOrder = ["beginnersRod", "dadsRod", "blacksmithRod", "atlanticRod", "turkeyRod", "goldenRod"];
    rodArray = [-1, -1, -1, -1, -1, -1];
    var key = ds_map_find_first(global.InventoryLibrary);
    while (!is_undefined(key))
    {
        if (ds_map_find_value(global.InventoryLibrary, key).inventoryType == "rod")
        {
            for (var j = 0; j < array_length(rodArrayOrder); j++)
            {
                if (ds_map_find_value(global.InventoryLibrary, key).inventoryID == rodArrayOrder[j])
                {
                    array_set(rodArray, j, ds_map_find_value(global.InventoryLibrary, key));
                }
            }
        }
        key = ds_map_find_next(global.InventoryLibrary, key);
    }
}

InitRods();

function CheckExchangeLimit()
{
    var totalExchange = 0;
    for (var i = 0; i < array_length(exchangeArray); i++)
    {
        totalExchange += (exchangeArray[i] * power(10, i));
    }
    var tempSand = currentSand;
    if (totalExchange > currentSand)
    {
        for (var i = 0; i < array_length(exchangeArray); i++)
        {
            exchangeArray[i] = tempSand % 10;
            tempSand = tempSand div 10;
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
                        menuItems = 3;
                        displayingInventory = rodArray;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        startingPosition = 0;
                        inventorySelect = 0;
                        inventoryMenu = [800, 50];
                        break;
                    case UnknownEnum.Value_1:
                        startingPosition = 0;
                        inventorySelect = 0;
                        displayingInventory = obj_HoloHouseManager.FishInventory();
                        menuItems = 5;
                        sellingInventory = array_create(array_length(displayingInventory), 0);
                        pauseMenu = 1;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        inventoryMenu = [800, 50];
                        break;
                    case UnknownEnum.Value_2:
                        currentSand = ds_map_find_value(global.PlayerSave, "fishSand");
                        var digits = 1;
                        var endDigit = false;
                        while (!endDigit)
                        {
                            if ((ds_map_find_value(global.PlayerSave, "fishSand") div (1 * power(10, digits))) > 0)
                            {
                                digits++;
                            }
                            else
                            {
                                endDigit = true;
                            }
                        }
                        exchangeOption = 0;
                        currentExchangeIndex = 0;
                        exchangeArray = array_create(digits, 0);
                        pauseMenu = 2;
                        sellConfirm = false;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        exchangeMenu = [750, 105];
                        break;
                    case UnknownEnum.Value_3:
                        if (global.charSelected.id == "gura")
                        {
                            obj_DialogueController.BeginDialogue(global.TextContainer.bloopDialogue2.selectedLanguage, id);
                        }
                        else
                        {
                            obj_DialogueController.BeginDialogue(global.TextContainer.bloopDialogue.selectedLanguage, id);
                        }
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case UnknownEnum.Value_4:
                        Return();
                        break;
                }
                break;
            case UnknownEnum.Value_0:
                if (array_get(ds_map_find_value(global.PlayerSave, "rodUnlock"), inventorySelect + startingPosition) == 0)
                {
                    if (!rodBuyConfirm)
                    {
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        rodBuyConfirm = true;
                    }
                    else if (rodBuyConfirm)
                    {
                        if (rodBuySelect == 0)
                        {
                            var cost = rodArray[inventorySelect + startingPosition].inventoryValue;
                            if (ds_map_find_value(global.PlayerSave, "fishSand") >= cost)
                            {
                                rodBuyConfirm = false;
                                ds_map_set(global.PlayerSave, "fishSand", ds_map_find_value(global.PlayerSave, "fishSand") - cost);
                                array_set(ds_map_find_value(global.PlayerSave, "rodUnlock"), inventorySelect + startingPosition, 1);
                                ds_map_set(global.PlayerSave, "fishRod", inventorySelect + startingPosition);
                                obj_FishingMiniGame.ChainReset();
                                audio_play_sound(snd_shopBuy, 30, 0);
                                SavePlayerSave();
                            }
                        }
                        else
                        {
                            Return();
                        }
                    }
                }
                else
                {
                    ds_map_set(global.PlayerSave, "fishRod", inventorySelect + startingPosition);
                    obj_FishingMiniGame.ChainReset();
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    SavePlayerSave();
                }
                break;
            case UnknownEnum.Value_1:
                if (array_length(sellingInventory) > 0)
                {
                    var sellingAnything = false;
                    for (var i = 0; i < array_length(sellingInventory); i++)
                    {
                        if (sellingInventory[i] > 0)
                        {
                            sellingAnything = true;
                            break;
                        }
                    }
                    if (sellingAnything)
                    {
                        if (sellConfirm)
                        {
                            var totalSale = 0;
                            for (var i = 0; i < array_length(sellingInventory); i++)
                            {
                                totalSale += (displayingInventory[i].inventoryValue * sellingInventory[i]);
                            }
                            ds_map_set(global.PlayerSave, "fishSand", ds_map_find_value(global.PlayerSave, "fishSand") + totalSale);
                            for (var i = 0; i < array_length(displayingInventory); i++)
                            {
                                inventory_remove(displayingInventory[i].id, sellingInventory[i]);
                                sellingInventory[i] = 0;
                            }
                            displayingInventory = obj_HoloHouseManager.FishInventory();
                            audio_play_sound(snd_fishSold, 30, 0);
                            sellConfirm = false;
                            SavePlayerSave();
                        }
                        else
                        {
                            sellConfirm = true;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                    }
                }
                break;
            case UnknownEnum.Value_2:
                if (sellConfirm)
                {
                    if (exchangeOption == 0)
                    {
                        var newExchange = 0;
                        for (var i = 0; i < array_length(exchangeArray); i++)
                        {
                            newExchange += (exchangeArray[i] * power(10, i));
                        }
                        ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + newExchange);
                        ds_map_set(global.PlayerSave, "fishSand", ds_map_find_value(global.PlayerSave, "fishSand") - newExchange);
                        sellConfirm = false;
                        currentSand = ds_map_find_value(global.PlayerSave, "fishSand");
                        var digits = 1;
                        var endDigit = false;
                        while (!endDigit)
                        {
                            if ((ds_map_find_value(global.PlayerSave, "fishSand") div (1 * power(10, digits))) > 0)
                            {
                                digits++;
                            }
                            else
                            {
                                endDigit = true;
                            }
                        }
                        exchangeOption = 0;
                        currentExchangeIndex = 0;
                        exchangeArray = array_create(digits, 0);
                        audio_play_sound(snd_fishSold, 30, 0);
                        SavePlayerSave();
                    }
                    else
                    {
                        sellConfirm = false;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                else
                {
                    var newExchange = 0;
                    for (var i = 0; i < array_length(exchangeArray); i++)
                    {
                        newExchange += (exchangeArray[i] * power(10, i));
                    }
                    if (newExchange > 0)
                    {
                        sellConfirm = true;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                    }
                }
                break;
        }
    }
}

function Return()
{
    if (interacting)
    {
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
                if (rodBuyConfirm)
                {
                    rodBuyConfirm = false;
                    rodBuySelect = 0;
                }
                else
                {
                    pauseMenu = -1;
                }
                audio_play_sound(snd_menu_back, 30, 0);
                break;
            case UnknownEnum.Value_1:
                if (sellConfirm)
                {
                    sellConfirm = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                else
                {
                    pauseMenu = -1;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                break;
            case UnknownEnum.Value_2:
                if (sellConfirm)
                {
                    sellConfirm = false;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                else
                {
                    pauseMenu = -1;
                    audio_play_sound(snd_menu_back, 30, 0);
                }
                break;
        }
    }
}

function SelectLeft()
{
    if (pauseMenu == 0 && rodBuyConfirm)
    {
        rodBuySelect = !rodBuySelect;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu == 1 && !sellConfirm && !rodBuyConfirm)
    {
        if (array_length(displayingInventory) > 0)
        {
            if (item_get(displayingInventory[inventorySelect + startingPosition].id) > 0)
            {
                if (sellingInventory[inventorySelect + startingPosition] > 0)
                {
                    sellingInventory[inventorySelect + startingPosition]--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    sellingInventory[inventorySelect + startingPosition] = item_get(displayingInventory[inventorySelect + startingPosition].id);
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
    else if (pauseMenu == 2)
    {
        if (!sellConfirm)
        {
            if (currentExchangeIndex == (array_length(exchangeArray) - 1))
            {
                currentExchangeIndex = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else
            {
                currentExchangeIndex++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else
        {
            exchangeOption = !exchangeOption;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectRight()
{
    if (pauseMenu == 0 && rodBuyConfirm)
    {
        rodBuySelect = !rodBuySelect;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu == 1 && !sellConfirm && !rodBuyConfirm)
    {
        if (array_length(displayingInventory) > 0)
        {
            if (item_get(displayingInventory[inventorySelect + startingPosition].id) > 0)
            {
                if (sellingInventory[inventorySelect + startingPosition] < item_get(displayingInventory[inventorySelect + startingPosition].id))
                {
                    sellingInventory[inventorySelect + startingPosition]++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    sellingInventory[inventorySelect + startingPosition] = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
    else if (pauseMenu == 2)
    {
        if (!sellConfirm)
        {
            if (currentExchangeIndex == 0)
            {
                currentExchangeIndex = array_length(exchangeArray) - 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else
            {
                currentExchangeIndex--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else
        {
            exchangeOption = !exchangeOption;
            audio_play_sound(snd_menu_select, 30, 0);
        }
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
            pauseOption = 4;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu < 2)
    {
        if (array_length(displayingInventory) > 0 && !sellConfirm && !rodBuyConfirm)
        {
            if (inventorySelect > 0)
            {
                inventorySelect--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (inventorySelect == 0)
            {
                if (array_length(displayingInventory) < menuItems)
                {
                    inventorySelect = array_length(displayingInventory) - 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (((inventorySelect + startingPosition) - 1) >= 0)
                {
                    startingPosition--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    startingPosition = array_length(displayingInventory) - menuItems;
                    inventorySelect = menuItems - 1;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
    else if (pauseMenu == 2 && !sellConfirm)
    {
        if (exchangeArray[currentExchangeIndex] < 9)
        {
            var newExchange = 0;
            for (var i = 0; i < array_length(exchangeArray); i++)
            {
                newExchange += (exchangeArray[i] * power(10, i));
            }
            if ((newExchange + power(10, currentExchangeIndex)) > currentSand && newExchange == currentSand)
            {
                exchangeArray[currentExchangeIndex] = 0;
            }
            else
            {
                exchangeArray[currentExchangeIndex]++;
            }
            audio_play_sound(snd_menu_select, 30, 0);
            CheckExchangeLimit();
        }
        else
        {
            exchangeArray[currentExchangeIndex] = 0;
            audio_play_sound(snd_menu_select, 30, 0);
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
        if (pauseOption < 4)
        {
            pauseOption++;
        }
        else
        {
            pauseOption = 0;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu < 2)
    {
        if (array_length(displayingInventory) > 0 && !sellConfirm && !rodBuyConfirm)
        {
            if (inventorySelect < min(menuItems - 1, array_length(displayingInventory) - 1))
            {
                inventorySelect++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (inventorySelect == (array_length(displayingInventory) - 1))
            {
                inventorySelect = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (inventorySelect == (menuItems - 1))
            {
                if ((inventorySelect + startingPosition) == (array_length(displayingInventory) - 1))
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
    else if (pauseMenu == 2 && !sellConfirm)
    {
        if (exchangeArray[currentExchangeIndex] > 0)
        {
            exchangeArray[currentExchangeIndex]--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else
        {
            exchangeArray[currentExchangeIndex] = 9;
            audio_play_sound(snd_menu_select, 30, 0);
            CheckExchangeLimit();
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
