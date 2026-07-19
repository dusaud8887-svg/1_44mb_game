currentOption = 0;
shopOption = 0;
shopItem = 0;
canControl = false;
buyingOption = 0;
itemSelected = false;
shopMode = -1;
alarm[0] = 5;
gachaing = false;
gachaConfirm = false;
gachaCompleted = false;
whiteFlash = false;
flashTime = 0;
armorySelect = 0;
startingPosition = 0;
readyToDebut = false;
gachatime = 0;
blinkRestTime = 30 + irandom(240);
display_set_gui_size(640, 360);
AChanSprite = 2314;
gachaGroupOption = 0;
totalThings = 40;
currentTears = 0;
redeemCharacterSelect = 0;
redeemOption = 0;
redeemSelected = false;
outfitSelect = 0;
redeemCharOutfits = 0;
pageTimer = -1;
currentPage = 0;
currentArrayLength = 0;
cursorlifetime = 0;
grayscale = shader_get_uniform(grayScale, "Relative Luminance");
gachaQuantity = 1;
gachaTearsQuantity = 1;
animPlayingSpeed = 0;
shopCategory = 0;
separatedShop = [[], [], []];
categorySelect = false;
gachaPulls = array_create(0);
initItems();
if (global.debug)
{
}
tempOption = 
{
    optionIcon: 2173,
    optionDescription: "This is temp.",
    optionName: "Temp",
    optionID: "BulletTemp"
};
gachaItems = [
{
    optionName: "홀로미스",
    optionSprite: 1406,
    gachaCharacters: ["ame", "ina", "gura", "calli", "kiara"],
    gachaID: "myth",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "홀로카운슬 + PROJECT HOPE",
    optionSprite: 499,
    gachaCharacters: ["irys", "bae", "sana", "fauna", "mumei", "kronii"],
    gachaID: "councilHope",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "게이머즈",
    optionSprite: 1745,
    gachaCharacters: ["fubuki", "mio", "korone", "okayu"],
    gachaID: "gamers",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "JP 0기생",
    optionSprite: 807,
    gachaCharacters: ["sora", "azki", "roboco", "suisei", "miko"],
    gachaID: "gen0",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "JP 1기생",
    optionSprite: 631,
    gachaCharacters: ["haato", "aki", "matsuri", "mel"],
    gachaID: "gen1",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "JP 2기생",
    optionSprite: 1855,
    gachaCharacters: ["subaru", "choco", "shion", "ayame", "aqua"],
    gachaID: "gen2",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "AREA 15",
    optionSprite: 984,
    gachaCharacters: ["moona", "risu", "iofi"],
    gachaID: "id1",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "HOLORO",
    optionSprite: 490,
    gachaCharacters: ["ollie", "reine", "anya"],
    gachaID: "id2",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}, 
{
    optionName: "HOLOH3RO",
    optionSprite: 318,
    gachaCharacters: ["kobo", "kaela", "zeta"],
    gachaID: "id3",
    optionDescription: global.TextContainer.gachaDescription.selectedLanguage,
    cost: 1000
}];
showTeaser = false;
shopItems = [
{
    optionName: "Max HP Up",
    optionIcon: 998,
    optionDescription: "",
    optionID: "HP",
    cost: [200, 500, 1200, 2750, 6000, 12000, 18000, 24000, 30000, 36000],
    shopType: "stat"
}, 
{
    optionName: "ATK Up",
    optionIcon: 712,
    optionDescription: "",
    optionID: "ATK",
    cost: [300, 750, 1800, 4100, 9100, 18000, 25000, 31000, 37000, 43000],
    shopType: "stat"
}, 
{
    optionName: "SPD Up",
    optionIcon: 1894,
    optionDescription: "",
    optionID: "SPD",
    cost: [200, 500, 1200, 2750, 6000, 12000, 18000, 24000, 30000, 36000],
    shopType: "stat"
}, 
{
    optionName: "Crit Up",
    optionIcon: 351,
    optionDescription: "",
    optionID: "crit",
    cost: [300, 750, 1800, 4100, 9100],
    shopType: "stat"
}, 
{
    optionName: "PickUp Range Up",
    optionIcon: 1614,
    optionDescription: "",
    optionID: "pickupRange",
    cost: [200, 500, 1200, 2750, 6000, 12000, 18000, 24000, 30000, 36000],
    shopType: "stat"
}, 
{
    optionName: "Haste Up",
    optionIcon: 821,
    optionDescription: "",
    optionID: "haste",
    cost: [400, 1000, 2400, 5500, 12000],
    shopType: "stat"
}, 
{
    optionName: "Regeneration",
    optionIcon: 650,
    optionDescription: "",
    optionID: "regen",
    cost: [200, 500, 1200, 2750, 6000],
    shopType: "stat"
}, 
{
    optionName: "Defense Up",
    optionIcon: 266,
    optionDescription: "",
    optionID: "DR",
    cost: [500, 1250, 3000, 6900, 15000],
    shopType: "stat"
}, 
{
    optionName: "Special Attack",
    optionIcon: 1104,
    optionDescription: "",
    optionID: "specUnlock",
    cost: [500],
    shopType: "power"
}, 
{
    optionName: "Special Cooldown Reduction",
    optionIcon: 96,
    optionDescription: "",
    optionID: "specCDR",
    cost: [500, 1250, 3000, 6900, 15000],
    shopType: "stat"
}, 
{
    optionName: "Growth",
    optionIcon: 988,
    optionDescription: "",
    optionID: "growth",
    cost: [500, 10000, 50000],
    shopType: "power"
}, 
{
    optionName: "Skill Up",
    optionIcon: 598,
    optionDescription: "",
    optionID: "skillDamage",
    cost: [500, 1250, 3000, 6900, 15000, 20000, 30000, 40000, 50000, 60000],
    shopType: "stat"
}, 
{
    optionName: "EXP Gain Up",
    optionIcon: 1177,
    optionDescription: "",
    optionID: "EXP",
    cost: [300, 750, 1800, 4100, 9100],
    shopType: "stat"
}, 
{
    optionName: "Food Drops Up",
    optionIcon: 1330,
    optionDescription: "",
    optionID: "food",
    cost: [150, 375, 900, 2000, 4500],
    shopType: "stat"
}, 
{
    optionName: "Money Gain Up",
    optionIcon: 2408,
    optionDescription: "",
    optionID: "moneyGain",
    cost: [400, 1000, 2400, 5500, 12000, 20000, 30000, 40000, 50000, 60000],
    shopType: "stat"
}, 
{
    optionName: "Reroll",
    optionIcon: 907,
    optionDescription: "",
    optionID: "reroll",
    cost: [2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000, 22500, 25000],
    shopType: "power"
}, 
{
    optionName: "Eliminate",
    optionIcon: 2281,
    optionDescription: "",
    optionID: "eliminate",
    cost: [2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000, 22500, 25000],
    shopType: "power"
}, 
{
    optionName: "Enhancement Rate Up",
    optionIcon: 1985,
    optionDescription: "",
    optionID: "enhanceUp",
    cost: [300, 750, 1800, 4100, 9100],
    shopType: "stat"
}, 
{
    optionName: "Marketing",
    optionIcon: 823,
    optionDescription: "",
    optionID: "mobUp",
    cost: [2000, 4000, 6000, 8000, 10000],
    shopType: "other"
}, 
{
    optionName: "Stamps",
    optionIcon: 1938,
    optionDescription: "",
    optionID: "stamps",
    cost: [500],
    shopType: "power"
}, 
{
    optionName: "Enchantments",
    optionIcon: 69,
    optionDescription: "",
    optionID: "enchantments",
    cost: [1000],
    shopType: "power"
}, 
{
    optionName: "Fandom",
    optionIcon: 2300,
    optionDescription: "",
    optionID: "fandom",
    cost: [2000],
    shopType: "power"
}, 
{
    optionName: "Weapon Limit",
    optionIcon: 2384,
    optionDescription: "",
    optionID: "weaponLimit",
    cost: [0, 0, 0, 0, 0],
    shopType: "other"
}, 
{
    optionName: "Item Limit",
    optionIcon: 398,
    optionDescription: "",
    optionID: "itemLimit",
    cost: [0, 0, 0, 0, 0, 0],
    shopType: "other"
}, 
{
    optionName: "Collab Ban",
    optionIcon: 2123,
    optionDescription: "",
    optionID: "noCollabs",
    cost: [0],
    shopType: "other"
}, 
{
    optionName: "Supers Ban",
    optionIcon: 339,
    optionDescription: "",
    optionID: "noSupers",
    cost: [0],
    shopType: "other"
}, 
{
    optionName: "Gacha Rank Off",
    optionIcon: 479,
    optionDescription: "",
    optionID: "GROff",
    cost: [0],
    shopType: "other"
}, 
{
    optionName: "Challenge Mode",
    optionIcon: 528,
    optionDescription: "",
    optionID: "challenge",
    cost: [0],
    shopType: "other"
}, 
{
    optionName: "Refund All",
    optionIcon: 626,
    optionDescription: "",
    optionID: "refund",
    cost: [0],
    shopType: "other"
}];
for (var i = 0; i < array_length(shopItems); i++)
{
    shopItems[i].optionName = global.TextContainer.shopItemTexts.selectedLanguage[i][0];
    shopItems[i].optionDescription = global.TextContainer.shopItemTexts.selectedLanguage[i][1];
    switch (shopItems[i].shopType)
    {
        case "power":
            array_push(separatedShop[0], shopItems[i]);
            break;
        case "stat":
            array_push(separatedShop[1], shopItems[i]);
            break;
        case "other":
            array_push(separatedShop[2], shopItems[i]);
            break;
    }
}
for (var i = 0; i < array_length(shopItems); i++)
{
    if (is_undefined(ds_map_find_value(global.PlayerSave, shopItems[i].optionID)))
    {
        ds_map_set(global.PlayerSave, shopItems[i].optionID, 0);
        SavePlayerSave();
    }
}

function LevelPlayerStatUp(arg0, arg1)
{
    if (arg0 != "refund")
    {
        ds_map_set_post(global.PlayerSave, arg0, ds_map_find_value(global.PlayerSave, arg0) + 1);
        ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") - arg1);
    }
    else
    {
        TotalRefund();
    }
    SavePlayerSave();
    if (CheckStoreItemsMaxed())
    {
        DoAchievement("partTimeJob");
    }
}

function RefundPlayerStatUp(arg0, arg1)
{
    ds_map_set(global.PlayerSave, arg0, 0);
    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + arg1);
    SavePlayerSave();
}

function TotalRefund()
{
    var total = 0;
    for (var i = 0; i < array_length(shopItems); i++)
    {
        if (!is_undefined(ds_map_find_value(global.PlayerSave, shopItems[i].optionID)))
        {
            for (var j = 0; j < array_length(shopItems[i].cost); j++)
            {
                if (ds_map_find_value(global.PlayerSave, shopItems[i].optionID) > j)
                {
                    var itemLevelCost = shopItems[i].cost[j];
                    total += itemLevelCost;
                }
            }
            ds_map_set(global.PlayerSave, shopItems[i].optionID, 0);
        }
    }
    show_debug_message(total);
    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") + total);
}

function Confirmed()
{
    if (canControl)
    {
        if (shopMode == -1)
        {
            switch (currentOption)
            {
                case 0:
                    shopMode = 0;
                    break;
                case 1:
                    shopMode = 1;
                    startingPosition = 0;
                    break;
                case 2:
                    shopMode = 2;
                    startingPosition = 0;
                    break;
                case 3:
                    room_goto(rm_Title);
                    break;
            }
            audio_play_sound(snd_menu_confirm, 30, 0);
        }
        else if (shopMode == 0)
        {
            if (itemSelected)
            {
                if (buyingOption == 1)
                {
                    shopMode = 3;
                    redeemCharacterSelect = 0;
                    redeemOption = 0;
                    outfitSelect = 0;
                    redeemCharOutfits = 0;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
                if (buyingOption == 0 && !gachaConfirm && !gachaing && !readyToDebut && ds_map_find_value(global.PlayerSave, "holoCoins") >= (1000 * gachaQuantity))
                {
                    ds_map_set(global.PlayerSave, "holoCoins", ds_map_find_value(global.PlayerSave, "holoCoins") - (1000 * gachaQuantity));
                    whiteFlash = false;
                    flashTime = 0;
                    gachaing = true;
                    gachatime = 0;
                    gachaCompleted = false;
                    gachaConfirm = true;
                    gachaPulls = array_create(0);
                    for (var j = 0; j < gachaQuantity; j++)
                    {
                        var roll = irandom(array_length(gachaItems[gachaGroupOption].gachaCharacters) - 1);
                        var gachaCharacterGot = gachaItems[gachaGroupOption].gachaCharacters[roll];
                        var isNewCharacter = false;
                        var gachaChosenOutfit = "";
                        if (variable_struct_exists(ds_map_find_value(global.characterData, gachaCharacterGot), "outfits"))
                        {
                            var roll2 = irandom(99);
                            if (roll2 < 10)
                            {
                                var outfitNames = variable_struct_get_names(ds_map_find_value(global.characterData, gachaCharacterGot).outfits);
                                var outfitRoll = irandom(array_length(outfitNames) - 1);
                                gachaChosenOutfit = outfitNames[outfitRoll];
                            }
                        }
                        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
                        {
                            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == gachaCharacterGot)
                            {
                                array_set_post(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) + 1);
                                if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) < 21)
                                {
                                    AddFandomEXP(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0), 2);
                                }
                                if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) == 1)
                                {
                                    isNewCharacter = true;
                                }
                                else
                                {
                                    array_set_post(array_get(ds_map_find_value(global.PlayerSave, "tears"), gachaGroupOption), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "tears"), gachaGroupOption), 1) + 1);
                                }
                            }
                        }
                        if (gachaChosenOutfit != "")
                        {
                            if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), gachaChosenOutfit))
                            {
                                array_push(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), gachaChosenOutfit);
                            }
                        }
                        var result = 
                        {
                            characterGot: gachaCharacterGot,
                            chosenOutfit: gachaChosenOutfit,
                            isNew: isNewCharacter
                        };
                        array_push(gachaPulls, result);
                    }
                    SavePlayerSave();
                }
                else if (gachaConfirm)
                {
                    gachaConfirm = false;
                    readyToDebut = true;
                }
                else if (gachaCompleted)
                {
                    DoAchievement("idolgroup");
                    gachaing = false;
                    readyToDebut = false;
                    gachaCompleted = false;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                    with (obj_idollights)
                    {
                        instance_destroy();
                    }
                    itemSelected = false;
                }
                else if (gachaing && gachatime < 160)
                {
                    gachatime = 160;
                    audio_stop_sound(snd_gachaopening);
                }
            }
            else if (!itemSelected)
            {
                if (gachaGroupOption != (array_length(gachaItems) - showTeaser))
                {
                    itemSelected = true;
                    gachaing = false;
                    gachaConfirm = false;
                    buyingOption = 0;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
            }
        }
        else if (shopMode == 1)
        {
            if (itemSelected)
            {
                if (buyingOption == 0)
                {
                    if (ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) < array_length(separatedShop[shopCategory][shopOption + startingPosition].cost))
                    {
                        var theCost = array_get(separatedShop[shopCategory][shopOption + startingPosition].cost, ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID));
                        if (ds_map_find_value(global.PlayerSave, "holoCoins") >= theCost)
                        {
                            LevelPlayerStatUp(separatedShop[shopCategory][shopOption + startingPosition].optionID, theCost);
                            audio_play_sound(snd_shopBuy, 30, 0);
                            itemSelected = false;
                        }
                    }
                }
                else if (buyingOption == 1)
                {
                    if (ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) > 0)
                    {
                        var totalRefund = 0;
                        for (var i = 0; i < ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID); i++)
                        {
                            totalRefund += separatedShop[shopCategory][shopOption + startingPosition].cost[i];
                        }
                        audio_play_sound(snd_shoprefund, 30, 0);
                        RefundPlayerStatUp(separatedShop[shopCategory][shopOption + startingPosition].optionID, totalRefund);
                        itemSelected = false;
                    }
                }
            }
            else if (!itemSelected && !categorySelect)
            {
                itemSelected = true;
                buyingOption = 0;
                if (ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) == array_length(separatedShop[shopCategory][shopOption + startingPosition].cost))
                {
                    buyingOption = 1;
                }
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
        }
        else if (shopMode == 3)
        {
            if (!redeemSelected)
            {
                redeemSelected = true;
                audio_play_sound(snd_menu_confirm, 30, 0);
                redeemOption = 0;
            }
            else if (!gachaConfirm && !gachaing && !readyToDebut && currentTears >= ((7 + ((outfitSelect > 0) * 8)) * gachaTearsQuantity))
            {
                array_set(array_get(ds_map_find_value(global.PlayerSave, "tears"), gachaGroupOption), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "tears"), gachaGroupOption), 1) - ((7 + ((outfitSelect > 0) * 8)) * gachaTearsQuantity));
                whiteFlash = false;
                flashTime = 0;
                gachaing = true;
                gachatime = 0;
                gachaCompleted = false;
                gachaConfirm = true;
                gachaPulls = array_create(0);
                for (var j = 0; j < gachaTearsQuantity; j++)
                {
                    var gachaCharacterGot = gachaItems[gachaGroupOption].gachaCharacters[redeemCharacterSelect];
                    var gachaChosenOutfit = "";
                    var isNewCharacter = false;
                    show_debug_message(gachaCharacterGot);
                    if (outfitSelect > 0)
                    {
                        var char = ds_map_find_value(global.characterData, gachaItems[gachaGroupOption].gachaCharacters[redeemCharacterSelect]);
                        var theOutfits = variable_struct_get_names(char.outfits);
                        gachaChosenOutfit = theOutfits[outfitSelect - 1];
                    }
                    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
                    {
                        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == gachaCharacterGot)
                        {
                            array_set_post(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1, array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) + 1);
                            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) < 21)
                            {
                                AddFandomEXP(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0), 2);
                            }
                            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) == 1)
                            {
                                isNewCharacter = true;
                            }
                        }
                    }
                    if (gachaChosenOutfit != "")
                    {
                        if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), gachaChosenOutfit))
                        {
                            array_push(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), gachaChosenOutfit);
                        }
                    }
                    var result = 
                    {
                        characterGot: gachaCharacterGot,
                        chosenOutfit: gachaChosenOutfit,
                        isNew: isNewCharacter
                    };
                    array_push(gachaPulls, result);
                }
                SavePlayerSave();
            }
            else if (gachaConfirm)
            {
                gachaConfirm = false;
                readyToDebut = true;
            }
            else if (gachaCompleted)
            {
                DoAchievement("idolgroup");
                gachaing = false;
                readyToDebut = false;
                gachaCompleted = false;
                audio_play_sound(snd_menu_confirm, 30, 0);
                with (obj_idollights)
                {
                    instance_destroy();
                }
                itemSelected = false;
                redeemSelected = false;
            }
            else if (gachaing && gachatime < 160)
            {
                gachatime = 160;
                audio_stop_sound(snd_gachaopening);
            }
        }
    }
}

function ReturnMenu()
{
    if (shopMode == -1)
    {
        audio_play_sound(snd_menu_back, 30, 0);
        room_goto(rm_Title);
    }
    else if (shopMode == 0 && !gachaing)
    {
        if (itemSelected && !gachaConfirm)
        {
            itemSelected = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else if (!itemSelected && !gachaConfirm)
        {
            shopMode = -1;
            audio_play_sound(snd_menu_back, 30, 0);
        }
    }
    else if (shopMode == 1)
    {
        if (itemSelected)
        {
            itemSelected = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else if (!itemSelected)
        {
            shopMode = -1;
            audio_play_sound(snd_menu_back, 30, 0);
        }
    }
    else if (shopMode == 2)
    {
        shopMode = -1;
        audio_play_sound(snd_menu_back, 30, 0);
    }
    else if (shopMode == 3 && !gachaing)
    {
        if (!redeemSelected)
        {
            shopMode = 0;
            itemSelected = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
        else
        {
            redeemSelected = false;
            audio_play_sound(snd_menu_back, 30, 0);
        }
    }
}

function SelectLeft()
{
    if (shopMode == 0 && !gachaing && !itemSelected)
    {
        if (gachaGroupOption == 0)
        {
            gachaGroupOption = array_length(gachaItems) - 1;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (gachaGroupOption > 0)
        {
            gachaGroupOption--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (shopMode == 0 && !gachaing && itemSelected)
    {
        if (gachaQuantity > 1)
        {
            gachaQuantity--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (shopMode == 1)
    {
        if (categorySelect)
        {
            if (shopCategory == 0)
            {
                shopCategory = 2;
            }
            else
            {
                shopCategory--;
            }
            shopOption = 0;
            startingPosition = 0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (shopOption > 0 && (shopOption % 4) != 0 && !itemSelected)
        {
            shopOption--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (itemSelected)
        {
            if (buyingOption == 1 && ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) < array_length(separatedShop[shopCategory][shopOption + startingPosition].cost))
            {
                buyingOption--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
    }
    else if (shopMode == 2)
    {
        if ((armorySelect % 7) == 0)
        {
            armorySelect += 6;
        }
        else if (armorySelect > 0)
        {
            armorySelect--;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (shopMode == 3)
    {
        if (redeemSelected && !gachaing)
        {
            if (gachaTearsQuantity > 1)
            {
                gachaTearsQuantity--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (!redeemSelected)
        {
            if (redeemCharOutfits > 0)
            {
                if (outfitSelect > 0)
                {
                    outfitSelect--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (outfitSelect == 0)
                {
                    var char = ds_map_find_value(global.characterData, gachaItems[gachaGroupOption].gachaCharacters[redeemCharacterSelect]);
                    redeemCharOutfits = 0;
                    if (variable_struct_exists(char, "outfits"))
                    {
                        redeemCharOutfits = variable_struct_names_count(char.outfits);
                    }
                    outfitSelect = redeemCharOutfits;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectRight()
{
    if (shopMode == 0 && !gachaing && !itemSelected)
    {
        if (gachaGroupOption < (array_length(gachaItems) - 1))
        {
            gachaGroupOption++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (gachaGroupOption == (array_length(gachaItems) - 1))
        {
            gachaGroupOption = 0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (shopMode == 0 && !gachaing && itemSelected)
    {
        if (gachaQuantity < 10)
        {
            gachaQuantity++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
    else if (shopMode == 1)
    {
        if (categorySelect)
        {
            if (shopCategory == 2)
            {
                shopCategory = 0;
            }
            else
            {
                shopCategory++;
            }
            shopOption = 0;
            startingPosition = 0;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if ((shopOption + startingPosition) < (array_length(separatedShop[shopCategory]) - 1) && ((shopOption + 1) % 4) != 0 && !itemSelected)
        {
            shopOption++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (itemSelected)
        {
            if (buyingOption == 0 && ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) > 0)
            {
                buyingOption++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
    }
    else if (shopMode == 2)
    {
        if (((armorySelect + 1) % 7) == 0)
        {
            armorySelect -= 6;
        }
        else if ((armorySelect + startingPosition) < (totalThings - 1))
        {
            armorySelect++;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (shopMode == 3)
    {
        if (redeemSelected && !gachaing)
        {
            if (gachaTearsQuantity < 10)
            {
                gachaTearsQuantity++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (!redeemSelected)
        {
            if (redeemCharOutfits > 0)
            {
                if (outfitSelect < redeemCharOutfits)
                {
                    outfitSelect++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else if (outfitSelect == redeemCharOutfits)
                {
                    outfitSelect = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function SelectUp()
{
    if (canControl)
    {
        if (shopMode == -1)
        {
            if (currentOption > 0)
            {
                currentOption--;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (currentOption == 0)
            {
                currentOption = 3;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (shopMode == 0 && !gachaing && itemSelected)
        {
            if (buyingOption == 1)
            {
                buyingOption = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (shopMode == 1)
        {
            if (!itemSelected)
            {
                if (shopOption < 4 && (startingPosition - 4) >= 0)
                {
                    startingPosition -= 4;
                }
                else if ((shopOption - 4) < 0)
                {
                    categorySelect = true;
                }
                else
                {
                    shopOption -= 4;
                }
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (shopMode == 2)
        {
            if (armorySelect < 7 && (startingPosition - 7) >= 0)
            {
                startingPosition -= 7;
            }
            else if ((armorySelect - 7) < 0)
            {
                startingPosition = ((((totalThings div 7) + 1) - ((totalThings % 7) == 0)) * 7) - 35;
                if ((armorySelect + startingPosition + 28) > (totalThings - 1))
                {
                    armorySelect += 21;
                }
                else
                {
                    armorySelect += 28;
                }
            }
            else
            {
                armorySelect -= 7;
            }
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (shopMode == 3)
        {
            if (!redeemSelected)
            {
                if (redeemCharacterSelect > 0)
                {
                    outfitSelect = 0;
                    redeemCharacterSelect--;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    outfitSelect = 0;
                    redeemCharacterSelect = array_length(gachaItems[gachaGroupOption].gachaCharacters) - 1;
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
        if (shopMode == -1)
        {
            if (currentOption < 3)
            {
                currentOption++;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            else if (currentOption == 3)
            {
                currentOption = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (shopMode == 0 && !gachaing && itemSelected)
        {
            if (buyingOption == 0)
            {
                buyingOption = 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (shopMode == 1)
        {
            if (!itemSelected)
            {
                if (categorySelect)
                {
                    categorySelect = false;
                    shopOption = 0;
                }
                else if (shopOption >= 12 && (startingPosition + shopOption + 4) < ((((array_length(separatedShop[shopCategory]) div 4) + 1) - ((array_length(separatedShop[shopCategory]) % 4) == 0)) * 4))
                {
                    startingPosition += 4;
                    if ((shopOption + startingPosition) > (array_length(separatedShop[shopCategory]) - 1))
                    {
                        shopOption -= 4;
                    }
                }
                else if ((shopOption + startingPosition + 4) > (array_length(separatedShop[shopCategory]) - 1) && shopOption >= 12)
                {
                    if ((shopOption - 16) < 0)
                    {
                        shopOption -= 12;
                    }
                    else
                    {
                        shopOption -= 16;
                    }
                    startingPosition = 0;
                }
                else if ((shopOption + startingPosition + 4) < array_length(separatedShop[shopCategory]))
                {
                    shopOption += 4;
                }
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        else if (shopMode == 2)
        {
            if (armorySelect >= 28 && (startingPosition + armorySelect + 7) < ((((totalThings div 7) + 1) - ((totalThings % 7) == 0)) * 7))
            {
                startingPosition += 7;
            }
            else if ((armorySelect + startingPosition + 7) > (totalThings - 1))
            {
                if ((armorySelect - 28) < 0)
                {
                    armorySelect -= 21;
                }
                else
                {
                    armorySelect -= 28;
                }
                startingPosition = 0;
            }
            else
            {
                armorySelect += 7;
            }
            audio_play_sound(snd_menu_select, 30, 0);
        }
        else if (shopMode == 3)
        {
            if (!redeemSelected)
            {
                if (redeemCharacterSelect == (array_length(gachaItems[gachaGroupOption].gachaCharacters) - 1))
                {
                    redeemCharacterSelect = 0;
                    outfitSelect = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                else
                {
                    redeemCharacterSelect++;
                    outfitSelect = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}

function DrawOption(arg0, arg1, arg2, arg3 = false)
{
    draw_set_font(Galmuri9);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_text_color(arg0 + 19, arg1 + 3, arg2.optionName, c_white, c_white, c_white, c_white, 1);
    if (arg2.optionIcon > 0)
    {
        draw_sprite(arg2.optionIcon, 0, arg0 + 34, arg1 + 39);
    }
    draw_sprite(hud_optionIconCase, 0, arg0 + 35, arg1 + 40);
    if (variable_struct_exists(arg2, "optionType"))
    {
        if (arg2.optionType == "Weapon" || arg2.optionType == "Collab")
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
    }
    if (arg3)
    {
        draw_set_alpha(0.8);
        draw_set_halign(fa_right);
        draw_text_scribble(arg0 + 365, arg1 + 3, ">> " + arg2.optionType);
        draw_set_alpha(1);
    }
    draw_set_halign(fa_left);
    var desc = arg2.optionDescription;
    if (is_array(arg2.optionDescription))
    {
        if (pageTimer < 0)
        {
            pageTimer = 120;
            currentArrayLength = array_length(arg2.optionDescription);
            currentPage = 0;
        }
        desc = arg2.optionDescription[currentPage];
    }
    else
    {
        currentPage = 0;
        currentArrayLength = 1;
        pageTimer = -1;
    }
    if (!itemSelected)
    {
        draw_text_scribble_ext(arg0 + 73, arg1 + 21, desc, 300, 13);
    }
}

function DrawGacha(arg0, arg1, arg2)
{
    draw_set_font(Galmuri9);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_text_color(arg0 + 19, arg1 + 3, arg2.optionName, c_white, c_white, c_white, c_white, 1);
    var desc = arg2.optionDescription;
    if (is_array(arg2.optionDescription))
    {
        if (pageTimer < 0)
        {
            pageTimer = 120;
            currentArrayLength = array_length(arg2.optionDescription);
            currentPage = 0;
        }
        desc = arg2.optionDescription[currentPage];
    }
    else
    {
        currentPage = 0;
        currentArrayLength = 1;
        pageTimer = -1;
    }
    draw_text_scribble_ext(arg0 + 33, arg1 + 21, desc, 300, 13);
}

instance_create_depth(x, y, 0, obj_AttackController);
armoryList = [];
var key = ds_map_find_first(global.attacksLibrary);
var size = ds_map_size(global.attacksLibrary);
for (var i = 0; i < size; i++)
{
    var thing = ds_map_find_value(global.attacksLibrary, key);
    if (thing.config.optionType == "Weapon")
    {
        array_push(armoryList, thing.config);
    }
    key = ds_map_find_next(global.attacksLibrary, key);
}
key = ds_map_find_first(global.itemsLibrary);
size = ds_map_size(global.itemsLibrary);
for (var i = 0; i < size; i++)
{
    var thing = ds_map_find_value(global.itemsLibrary, key);
    if (thing.optionType == "Item")
    {
        array_push(armoryList, thing);
    }
    key = ds_map_find_next(global.itemsLibrary, key);
}
key = ds_map_find_first(global.attacksLibrary);
size = ds_map_size(global.attacksLibrary);
for (var i = 0; i < size; i++)
{
    var thing = ds_map_find_value(global.attacksLibrary, key);
    if (thing.config.optionType == "Collab")
    {
        array_push(armoryList, thing.config);
    }
    key = ds_map_find_next(global.attacksLibrary, key);
}
key = ds_map_find_first(global.attacksLibrary);
size = ds_map_size(global.attacksLibrary);
for (var i = 0; i < size; i++)
{
    var thing = ds_map_find_value(global.attacksLibrary, key);
    if (thing.config.optionType == "SuperCollab")
    {
        array_push(armoryList, thing.config);
    }
    key = ds_map_find_next(global.attacksLibrary, key);
}
collabNames = [];
for (var i = 0; i < array_length(global.seenCollabs); i++)
{
    if (!array_exists(collabNames, global.seenCollabs[i].optionID))
    {
        array_push(collabNames, global.seenCollabs[i].optionID);
    }
}
totalThings = array_length(armoryList);
