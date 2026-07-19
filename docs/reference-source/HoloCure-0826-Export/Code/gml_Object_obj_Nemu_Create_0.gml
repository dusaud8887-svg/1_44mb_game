pauseOption = 0;
pauseMenu = -1;
interactIcon = 2040;
menuContainer = [110, 50];
highlighted = false;
inventoryMenu = [200, 50];
displayingInventory = [];
sellingInventory = [];
startingPosition = 0;
inventorySelect = 0;
sellConfirm = false;
itemArray = [];
interactIconY = 35;
interactRange = 25;
spriteColor = 16777215;
interactable = true;
interacting = false;
canControl = true;
pauseItems = 4;
cursorTime = 0;
menuItems = 0;
itemBuySelect = 0;
itemBuyConfirm = false;

function InitSoilAndSeeds()
{
    var soilArrayOrder = ["standardsoil", "expeditedsoil", "enhancedsoil"];
    itemArray = [-1, -1, -1];
    var key = ds_map_find_first(global.InventoryLibrary);
    while (!is_undefined(key))
    {
        if (ds_map_find_value(global.InventoryLibrary, key).inventoryType == "soil")
        {
            for (var j = 0; j < array_length(soilArrayOrder); j++)
            {
                if (ds_map_find_value(global.InventoryLibrary, key).inventoryID == soilArrayOrder[j])
                {
                    array_set(itemArray, j, ds_map_find_value(global.InventoryLibrary, key));
                }
            }
        }
        key = ds_map_find_next(global.InventoryLibrary, key);
    }
    var seedArray = [];
    key = ds_map_find_first(global.InventoryLibrary);
    while (!is_undefined(key))
    {
        if (ds_map_find_value(global.InventoryLibrary, key).inventoryType == "seed")
        {
            array_push(seedArray, ds_map_find_value(global.InventoryLibrary, key));
        }
        key = ds_map_find_next(global.InventoryLibrary, key);
    }
    var orderedSeeds = [];
    var size = array_length(seedArray);
    var index = 0;
    var first = 0;
    while (index < size)
    {
        first = 0;
        for (var i = 0; i < array_length(seedArray); i++)
        {
            if (seedArray[first].inventoryNumber > seedArray[i].inventoryNumber)
            {
                first = i;
            }
        }
        if (array_length(seedArray) > 0)
        {
            array_push(orderedSeeds, seedArray[first]);
            array_delete(seedArray, first, 1);
        }
        index++;
    }
    itemArray = array_concat(itemArray, orderedSeeds);
}

InitSoilAndSeeds();

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
                        menuItems = 5;
                        displayingInventory = itemArray;
                        sellingInventory = array_create(array_length(displayingInventory), 0);
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        startingPosition = 0;
                        inventorySelect = 0;
                        inventoryMenu = [800, 50];
                        break;
                    case UnknownEnum.Value_1:
                        startingPosition = 0;
                        inventorySelect = 0;
                        displayingInventory = obj_HoloHouseManager.CropInventory();
                        menuItems = 5;
                        sellingInventory = array_create(array_length(displayingInventory), 0);
                        pauseMenu = 1;
                        inventoryMenu = [800, 50];
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case UnknownEnum.Value_2:
                        if (global.charSelected.id == "fauna")
                        {
                            obj_DialogueController.BeginDialogue(global.TextContainer.nemuDialogue2.selectedLanguage, id);
                        }
                        else
                        {
                            obj_DialogueController.BeginDialogue(global.TextContainer.nemuDialogue.selectedLanguage, id);
                        }
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case UnknownEnum.Value_3:
                        Return();
                        break;
                }
                break;
            case UnknownEnum.Value_0:
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
                            if (ds_map_find_value(global.PlayerSave, "holoCoins") >= totalSale)
                            {
                                ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") - totalSale);
                                for (var i = 0; i < array_length(displayingInventory); i++)
                                {
                                    inventory_add(displayingInventory[i].id, sellingInventory[i]);
                                    sellingInventory[i] = 0;
                                }
                                audio_play_sound(snd_fishSold, 30, 0);
                                sellConfirm = false;
                                SavePlayerSave();
                            }
                        }
                        else
                        {
                            sellConfirm = true;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                    }
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
                            ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + totalSale);
                            for (var i = 0; i < array_length(displayingInventory); i++)
                            {
                                inventory_remove(displayingInventory[i].id, sellingInventory[i]);
                                sellingInventory[i] = 0;
                            }
                            displayingInventory = obj_HoloHouseManager.CropInventory();
                            SavePlayerSave();
                            audio_play_sound(snd_fishSold, 30, 0);
                            sellConfirm = false;
                        }
                        else
                        {
                            sellConfirm = true;
                            audio_play_sound(snd_menu_confirm, 30, 0);
                        }
                    }
                }
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
                interacting = false;
                obj_Player.canControl = true;
                obj_HoloHouseManager.alarm[1] = 5;
                audio_play_sound(snd_menu_back, 30, 0);
                pauseMenu = -1;
                pauseOption = 0;
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
        }
    }
}

function SelectLeft()
{
    if (!canControl)
    {
        exit;
    }
    if (pauseMenu == 0 && itemBuyConfirm)
    {
        itemBuySelect = !itemBuySelect;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    if (pauseMenu == 0 && !sellConfirm && !itemBuyConfirm)
    {
        if (array_length(displayingInventory) > 0)
        {
            if (item_get(displayingInventory[inventorySelect + startingPosition].inventoryID) != 99)
            {
                if (sellingInventory[inventorySelect + startingPosition] > 0)
                {
                    sellingInventory[inventorySelect + startingPosition]--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    var itemHas = item_get(displayingInventory[inventorySelect + startingPosition].inventoryID);
                    if (is_undefined(itemHas))
                    {
                        itemHas = 0;
                    }
                    sellingInventory[inventorySelect + startingPosition] = 99 - itemHas;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
    else if (pauseMenu == 1 && !sellConfirm && !itemBuyConfirm)
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
}

function SelectRight()
{
    if (!canControl)
    {
        exit;
    }
    if (pauseMenu == 0 && itemBuyConfirm)
    {
        itemBuySelect = !itemBuySelect;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (pauseMenu == 0 && !sellConfirm && !itemBuyConfirm)
    {
        if (array_length(displayingInventory) > 0)
        {
            var itemHas = item_get(displayingInventory[inventorySelect + startingPosition].inventoryID);
            if (is_undefined(itemHas))
            {
                itemHas = 0;
            }
            if (itemHas != 99)
            {
                if ((sellingInventory[inventorySelect + startingPosition] + itemHas) < 99)
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
    else if (pauseMenu == 1 && !sellConfirm && !itemBuyConfirm)
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
    else if (pauseMenu < 2)
    {
        if (array_length(displayingInventory) > 0 && !sellConfirm && !itemBuyConfirm)
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
    else if (pauseMenu < 2)
    {
        if (array_length(displayingInventory) > 0 && !sellConfirm && !itemBuyConfirm)
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
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
