pauseOption = 0;
pauseMenu = -1;
interactIcon = 1560;
menuContainer = [110, 50];
highlighted = false;
inventoryMenu = [200, 50];
startingPosition = 0;
inventorySelect = 0;
itemArray = [];
interactIconY = 60;
interactRange = 50;
fullInventory = [];
emitter = part_emitter_create(global.psystem);
part_emitter_region(global.psystem, emitter, x - 18, x + 18, y - 40, y - 25, 1, 0);
part_emitter_stream(global.psystem, emitter, global.partType20, -5);
part_system_depth(global.psystem, -9999);
audio_play_sound(snd_cookingpot, 2, true);
spriteColor = 16777215;
interactable = true;
interacting = false;
canControl = true;
pauseItems = 3;
cursorTime = 0;
menuItems = 0;
cookSelect = 0;
recipeSelected = false;
displayingInventory = [];
canCook = false;
cookPause = 0;
cookTimer = 30;
cookConfirm = false;
beginCooking = false;
ingredientList = [];
currentIngredient = 0;
resultsContainer = [320, 110];
lightTime = 0;
shaking = false;
shakeDisplacement = 1;

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
        audio_play_sound(snd_interactpot, 30, 0);
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
                        fullInventory = array_concat(obj_HoloHouseManager.FishInventory(), obj_HoloHouseManager.CropInventory());
                        DetermineRecipes();
                        canCook = CanCook(displayingInventory[inventorySelect]);
                        break;
                    case UnknownEnum.Value_1:
                        obj_DialogueController.BeginDialogue(global.TextContainer.cookingDialogue.selectedLanguage, id);
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        break;
                    case UnknownEnum.Value_2:
                        Return();
                        break;
                }
                break;
            case UnknownEnum.Value_0:
                if (cookSelect == 0)
                {
                    if (canCook)
                    {
                        pauseMenu = 3;
                        audio_play_sound(snd_menu_confirm, 30, 0);
                        cookPause = 0;
                        cookTimer = 30;
                        cookConfirm = false;
                        alarm[1] = 10;
                        resultsContainer[1] = -120;
                        currentIngredient = 0;
                        ingredientList = variable_struct_get_names(displayingInventory[inventorySelect].recipe);
                    }
                }
                else
                {
                    if (ds_map_find_value(global.PlayerSave, "autoCook") != displayingInventory[inventorySelect].optionID)
                    {
                        ds_map_set(global.PlayerSave, "autoCook", displayingInventory[inventorySelect].optionID);
                    }
                    else
                    {
                        ds_map_set(global.PlayerSave, "autoCook", "");
                    }
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    SavePlayerSave();
                }
                break;
            case 3:
                if (cookConfirm)
                {
                    beginCooking = false;
                    cookConfirm = false;
                    resultsContainer[1] = -120;
                    obj_Player.canControl = true;
                    obj_HoloHouseManager.canControl = true;
                    var crop = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
                    crop.sprite_index = displayingInventory[inventorySelect].optionIcon;
                    DoAchievement("digin");
                    audio_play_sound(snd_eatfood, 0, 0);
                    with (obj_itemLightBeam)
                    {
                        instance_destroy();
                    }
                    pauseMenu = -1;
                    pauseOption = 0;
                    interacting = false;
                    var ingredients = variable_struct_get_names(displayingInventory[inventorySelect].recipe);
                    for (var i = 0; i < array_length(ingredients); i++)
                    {
                        inventory_remove(ingredients[i], variable_struct_get(displayingInventory[inventorySelect].recipe, ingredients[i]));
                    }
                    ds_map_set(global.PlayerSave, "currentFood", [displayingInventory[inventorySelect].optionID, displayingInventory[inventorySelect].useNumber]);
                    SavePlayerSave();
                }
                break;
        }
    }
}

function DetermineRecipes()
{
    displayingInventory = [];
    var foodOrderedArray = array_create(ds_map_size(global.FOOD), -1);
    var key = ds_map_find_first(global.FOOD);
    while (!is_undefined(key))
    {
        for (var j = 0; j < array_length(foodOrderedArray); j++)
        {
            array_set(foodOrderedArray, ds_map_find_value(global.FOOD, key).inventoryNumber, ds_map_find_value(global.FOOD, key));
        }
        key = ds_map_find_next(global.FOOD, key);
    }
    for (var i = 0; i < array_length(foodOrderedArray); i++)
    {
        if (foodOrderedArray[i].optionID == "tempura")
        {
            array_push(displayingInventory, foodOrderedArray[i]);
        }
        else
        {
            var recipeKnown = true;
            if (!item_exists(foodOrderedArray[i].mainIngredient))
            {
                recipeKnown = false;
            }
            if (foodOrderedArray[i].optionID == "strangeseafoodsoup")
            {
                if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Halu"))
                {
                    recipeKnown = false;
                }
            }
            if (recipeKnown)
            {
                array_push(displayingInventory, foodOrderedArray[i]);
            }
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
                if (recipeSelected)
                {
                    recipeSelected = false;
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
    if (interacting)
    {
        if (!canControl)
        {
            exit;
        }
        switch (pauseMenu)
        {
            case UnknownEnum.Value_0:
                if (array_length(displayingInventory) > 1)
                {
                    if (inventorySelect == 0)
                    {
                        inventorySelect = array_length(displayingInventory) - 1;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else
                    {
                        inventorySelect--;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    canCook = CanCook(displayingInventory[inventorySelect]);
                }
                break;
        }
    }
}

function SelectRight()
{
    if (interacting)
    {
        if (!canControl)
        {
            exit;
        }
        switch (pauseMenu)
        {
            case UnknownEnum.Value_0:
                if (array_length(displayingInventory) > 1)
                {
                    if (inventorySelect == (array_length(displayingInventory) - 1))
                    {
                        inventorySelect = 0;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else
                    {
                        inventorySelect++;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    canCook = CanCook(displayingInventory[inventorySelect]);
                }
                break;
        }
    }
}

function SelectUp()
{
    if (interacting)
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
                pauseOption = pauseItems - 1;
            }
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (pauseMenu == UnknownEnum.Value_0)
        {
            cookSelect = !cookSelect;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

function SelectDown()
{
    if (interacting)
    {
        if (!canControl)
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
            cookSelect = !cookSelect;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
