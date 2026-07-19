var keys = variable_struct_get_names(global.charSelected.perks);
charPerks = {};
for (var i = 0; i < array_length(keys); i++)
{
    variable_struct_set(charPerks, keys[i], 0);
}
var attacks = obj_AttackController.attackIndex;
var charAttackId = global.charSelected.attackID;
ds_map_find_value(attacks, charAttackId).config.optionType = "Weapon";
weapons = {};
maxedWeapons = {};
weaponCollabs = {};
availableWeaponCollabs = {};
numberOfOwnedWeapons = 0;
numberOfMaxedWeapons = 0;
weaponLimit = max(1, 6 - ((global.gameMode < 2) * ds_map_find_value(global.PlayerSave, "weaponLimit")));
numberOfOwnedItems = 0;
numberOfMaxedItems = 0;
itemLimit = max(0, 6 - ((global.gameMode < 2) * ds_map_find_value(global.PlayerSave, "itemLimit")));
removedItems = [];

function RemoveItems(arg0)
{
    for (var i = 0; i < array_length(removedItems); i++)
    {
        for (var j = 0; j < array_length(arg0); j++)
        {
            if (arg0[j] == removedItems[i])
            {
                array_delete(arg0, j, 1);
            }
        }
    }
}

var unlockedWeapons = ds_map_find_value(global.PlayerSave, "unlockedWeapons");
var attackObj;
for (var i = 0; i < array_length(unlockedWeapons); i++)
{
    key = unlockedWeapons[i];
    attackObj = ds_map_find_value(attacks, key);
    if (!variable_struct_exists(weapons, key))
    {
        variable_struct_set(weapons, key, 
        {
            id: key,
            level: 0,
            weight: attackObj.config.weight,
            maxLevel: attackObj.config.maxLevel,
            combos: {}
        });
    }
}
var unlockArray = ds_map_find_value(global.PlayerSave, "unlockedItems");
unlockedItems = [];
for (var i = 0; i < array_length(unlockArray); i++)
{
    if (!array_exists(unlockedItems, unlockArray[i]))
    {
        if (!(unlockArray[i] == "Halu" && global.gameMode == 2))
        {
            array_push(unlockedItems, unlockArray[i]);
        }
    }
}
var key = global.charSelected.attackID;
variable_struct_set(weapons, key, 
{
    id: key,
    level: 0,
    weight: attackObj.config.weight,
    maxLevel: attackObj.config.maxLevel,
    combos: {}
});
key = ds_map_find_first(attacks);
while (!is_undefined(key))
{
    attackObj = ds_map_find_value(attacks, key);
    if (attackObj.config.optionType == "Collab")
    {
        variable_struct_set(weaponCollabs, key, 
        {
            id: key,
            level: 0,
            config: attackObj.config
        });
        var combos = attackObj.config.combos;
        if (variable_struct_exists(weapons, combos[0]) && variable_struct_exists(weapons, combos[1]))
        {
            var weapon1 = variable_struct_get(weapons, combos[0]);
            var weapon2 = variable_struct_get(weapons, combos[1]);
            variable_struct_set(weapon1.combos, combos[1], attackObj.attackID);
            variable_struct_set(weapon2.combos, combos[0], attackObj.attackID);
        }
    }
    key = ds_map_find_next(attacks, key);
}
key = ds_map_find_first(attacks);
while (!is_undefined(key))
{
    attackObj = ds_map_find_value(attacks, key);
    if (attackObj.config.optionType == "SuperCollab")
    {
        variable_struct_set(weaponCollabs, key, 
        {
            id: key,
            level: 0,
            config: attackObj.config
        });
        var combos = attackObj.config.combos;
        if (variable_struct_exists(weaponCollabs, combos[0]) && array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), combos[1]))
        {
            var weapon1 = variable_struct_get(weaponCollabs, combos[0]);
            var item = ds_map_find_value(ITEMS, array_get(combos, 1));
            variable_instance_set(weapon1, "supercombos", {});
            variable_struct_set(weapon1.supercombos, combos[1], attackObj.attackID);
            variable_instance_set(item, "supercombos", {});
            variable_struct_set(item.supercombos, combos[0], attackObj.attackID);
        }
    }
    key = ds_map_find_next(attacks, key);
}

function OnWeaponMaxLevel(arg0)
{
    if (ds_map_find_value(obj_AttackController.attackIndex, arg0.id).config.optionType == "Skill")
    {
        exit;
    }
    var keys = variable_struct_get_names(arg0.combos);
    variable_struct_set(maxedWeapons, arg0.id, true);
    for (var i = 0; i < array_length(keys); i++)
    {
        if (variable_struct_exists(maxedWeapons, keys[i]) && global.gameMode != 2 && !ds_map_find_value(global.PlayerSave, "noCollabs"))
        {
            var combo = variable_struct_get(arg0.combos, keys[i]);
            variable_struct_set(availableWeaponCollabs, combo, [arg0.id, keys[i]]);
            global.goldAnvilCanDrop = true;
        }
    }
}

function GeneratePossibleOptions()
{
    perksContainer = variable_struct_get_names(charPerks);
    itemsContainer = [];
    newItemsContainer = [];
    numberOfOwnedItems = 0;
    numberOfMaxedItems = 0;
    TempUnlock();
    RemoveItems(unlockedItems);
    for (var i = 0; i < array_length(unlockedItems); i++)
    {
        var key = unlockedItems[i];
        var item = ds_map_find_value(ITEMS, key);
        if (item.level == -1 && !item.becomeSuper)
        {
            var found = false;
            for (var j = 0; j < array_length(newItemsContainer); j++)
            {
                if (newItemsContainer[j].id == item.id)
                {
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                array_push(newItemsContainer, 
                {
                    id: item.id,
                    weight: item.weight
                });
            }
        }
        else if (item.level < (item.maxLevel - 1) && !item.becomeSuper && !item.collabed)
        {
            array_push(itemsContainer, 
            {
                id: item.id,
                weight: item.weight
            });
        }
        else if (!item.collabed)
        {
            numberOfMaxedItems++;
        }
    }
    var itemsList = variable_struct_get_names(items);
    numberOfOwnedItems = min(6, array_length(itemsList));
    var keys = variable_struct_get_names(weapons);
    weaponsContainer = [];
    newWeaponsContainer = [];
    numberOfOwnedWeapons = 0;
    numberOfMaxedWeapons = 0;
    for (var i = 0; i < array_length(keys); i++)
    {
        var weapon = variable_struct_get(weapons, keys[i]);
        if (ds_map_find_value(obj_AttackController.attackIndex, weapon.id).config.optionType == "Skill")
        {
            continue;
        }
        if (weapon.level > 0)
        {
            if (weapon.level < weapon.maxLevel && !array_contains(eliminatedAttacks, weapon.id))
            {
                array_push(weaponsContainer, weapon);
            }
        }
        else if (!array_contains(eliminatedAttacks, weapon.id))
        {
            array_push(newWeaponsContainer, weapon);
        }
    }
    var daPlayer = -1;
    if (instance_exists(playerCharacter))
    {
        daPlayer = playerCharacter;
    }
    else
    {
        daPlayer = playerSnapshot;
    }
    var keys2 = ds_map_find_first(daPlayer.attacks);
    var ownedWeaponsArray = [];
    for (var i = 0; i < ds_map_size(daPlayer.attacks); i++)
    {
        var weapon = ds_map_find_value(daPlayer.attacks, keys2);
        if (weapon.config.optionType == "Skill")
        {
            keys2 = ds_map_find_next(daPlayer.attacks, keys2);
        }
        else
        {
            if (array_length(ownedWeaponsArray) == 0)
            {
                array_push(ownedWeaponsArray, weapon);
            }
            else
            {
                var found;
                for (var j = 0; j < array_length(ownedWeaponsArray); j++)
                {
                    found = false;
                    if (ownedWeaponsArray[j].attackID == weapon.attackID)
                    {
                        found = true;
                    }
                }
                if (!found)
                {
                    array_push(ownedWeaponsArray, weapon);
                }
            }
            keys2 = ds_map_find_next(daPlayer.attacks, keys2);
        }
    }
    for (var i = 0; i < array_length(ownedWeaponsArray); i++)
    {
        var weapon = ownedWeaponsArray[i];
        if (weapon.config.level >= 0)
        {
            if (weapon.config.level == weapon.config.maxLevel)
            {
                numberOfMaxedWeapons++;
            }
            numberOfOwnedWeapons++;
        }
    }
    for (var i = 0; i < array_length(weaponsContainer); i++)
    {
        var weapon = ds_map_find_value(obj_AttackController.attackIndex, weaponsContainer[i].id);
        var weaponLevel = variable_struct_get(weapons, weaponsContainer[i].id).level;
        if (weapon.config.optionType == "Skill" || weaponLevel == weapon.config.maxLevel)
        {
            array_delete(weaponsContainer, i, 1);
        }
    }
    keys = variable_struct_get_names(statUps);
    statUpContainer = [];
    for (var i = 0; i < array_length(keys); i++)
    {
        var statUp = variable_struct_get(statUps, keys[i]);
        array_push(statUpContainer, 
        {
            id: keys[i],
            weight: statUp.weight
        });
    }
}

function GenerateOptions()
{
    GeneratePossibleOptions();
    options[0] = OptionOne();
    options[1] = OptionTwo();
    options[2] = OptionThree();
    options[3] = OptionFour();
}

function OptionOne()
{
    var roll = random(10);
    if (array_length(perksContainer) != 0 && roll > 6.5)
    {
        return RandomPerk();
    }
    else if (roll > 3 && ((numberOfMaxedWeapons < weaponLimit && (numberOfOwnedWeapons < weaponLimit && array_length(newWeaponsContainer) > 0)) || (numberOfOwnedWeapons == weaponLimit && array_length(weaponsContainer) > 0)))
    {
        return RandomWeapon();
    }
    else if (roll > 0.5 && (((numberOfOwnedItems < itemLimit && array_length(newItemsContainer) > 0) && numberOfMaxedItems < itemLimit) || (numberOfOwnedItems == itemLimit && array_length(itemsContainer) > 0)))
    {
        return RandomItem();
    }
    else
    {
        return RandomStatup();
    }
}

function OptionTwo()
{
    return OptionOne();
}

function OptionThree(arg0 = 5)
{
    var roll = irandom(9);
    if (roll > 4 && ((numberOfMaxedWeapons < weaponLimit && (numberOfOwnedWeapons < weaponLimit && array_length(newWeaponsContainer) > 0)) || (numberOfOwnedWeapons == weaponLimit && array_length(weaponsContainer) > 0)))
    {
        return RandomWeapon();
    }
    else if (roll > 0 && (((numberOfOwnedItems < itemLimit && array_length(newItemsContainer) > 0) && numberOfMaxedItems < itemLimit) || (numberOfOwnedItems == itemLimit && array_length(itemsContainer) > 0)))
    {
        return RandomItem();
    }
    else if (array_length(perksContainer) != 0)
    {
        return RandomPerk();
    }
    else if (arg0 > 0 && ((numberOfOwnedWeapons < weaponLimit && array_length(newWeaponsContainer) > 0) || (numberOfOwnedItems < itemLimit && array_length(newItemsContainer) > 0) || (numberOfOwnedWeapons == weaponLimit && array_length(weaponsContainer) > 0) || (numberOfOwnedItems == itemLimit && array_length(itemsContainer) > 0)))
    {
        arg0--;
        return OptionThree(arg0);
    }
    else
    {
        return Food();
    }
}

function OptionFour(arg0 = 5)
{
    var roll = irandom(1);
    if (roll && ((numberOfMaxedWeapons < weaponLimit && (numberOfOwnedWeapons < weaponLimit && array_length(newWeaponsContainer) > 0)) || (numberOfOwnedWeapons == weaponLimit && array_length(weaponsContainer) > 0)))
    {
        return RandomWeapon();
    }
    else if (((numberOfOwnedItems < itemLimit && array_length(newItemsContainer) > 0) && numberOfMaxedItems < itemLimit) || (numberOfOwnedItems == itemLimit && array_length(itemsContainer) > 0))
    {
        return RandomItem();
    }
    else
    {
        if (arg0 > 0 && ((numberOfOwnedWeapons < weaponLimit && array_length(newWeaponsContainer) > 0) || (numberOfOwnedItems < itemLimit && array_length(newItemsContainer) > 0) || (numberOfOwnedWeapons == weaponLimit && array_length(weaponsContainer) > 0) || (numberOfOwnedItems == itemLimit && array_length(itemsContainer) > 0)))
        {
            arg0--;
            return OptionFour(arg0);
        }
        return Money();
    }
}

function OptionBox(arg0 = 3, arg1 = 0, arg2 = 5)
{
    var roll = irandom(9);
    if (roll > 2 && ((numberOfMaxedWeapons < weaponLimit && ((numberOfOwnedWeapons + arg1) < weaponLimit && array_length(newWeaponsContainer) > 0)) || (numberOfOwnedWeapons <= weaponLimit && array_length(weaponsContainer) > 0)))
    {
        return RandomWeapon(arg0, arg1, 99);
    }
    else if ((((numberOfOwnedItems + arg1) < itemLimit && array_length(newItemsContainer) > 0) && numberOfMaxedItems < itemLimit) || (numberOfOwnedItems <= itemLimit && array_length(itemsContainer) > 0))
    {
        return RandomItem(arg0, arg1);
    }
    else if (arg2 > 0 && ((numberOfOwnedWeapons < weaponLimit && array_length(newWeaponsContainer) > 0) || (numberOfOwnedItems < itemLimit && array_length(newItemsContainer) > 0) || (numberOfOwnedWeapons == weaponLimit && array_length(weaponsContainer) > 0) || (numberOfOwnedItems == itemLimit && array_length(itemsContainer) > 0)))
    {
        arg2--;
        return OptionBox(arg0, arg1, arg2);
    }
    else
    {
        return Money();
    }
}

function RandomStatup()
{
    var i = PickRandomWithWeight(statUpContainer);
    if (i == "error")
    {
        return 
        {
            optionName: global.TextContainer.levelMoneyOption.selectedLanguage[0],
            optionType: "Consumable",
            optionID: "money",
            optionDescription: array_get(variable_struct_get(levelMoneyOption, selectedLanguage), 1),
            optionIcon: 2408
        };
    }
    var choice = statUpContainer[i].id;
    array_delete(statUpContainer, i, 1);
    return variable_struct_get(statUps, choice);
}

function RandomPerk()
{
    var randomIndex = irandom(array_length(perksContainer) - 1);
    var returnId = perksContainer[randomIndex];
    array_delete(perksContainer, randomIndex, 1);
    return ds_map_find_value(PERKS, returnId);
}

function RandomItem(arg0 = 4, arg1 = 0)
{
    var roll = irandom(9);
    var i, choice;
    if ((roll < arg0 || array_length(itemsContainer) == 0) && (numberOfOwnedItems + arg1) < itemLimit)
    {
        i = PickRandomWithWeight(newItemsContainer);
        choice = newItemsContainer[i];
        array_delete(newItemsContainer, i, 1);
    }
    else
    {
        i = PickRandomWithWeight(itemsContainer);
        choice = itemsContainer[i];
        array_delete(itemsContainer, i, 1);
    }
    if (i == "error")
    {
        return 
        {
            optionName: global.TextContainer.levelMoneyOption.selectedLanguage[0],
            optionType: "Consumable",
            optionID: "money",
            optionDescription: array_get(variable_struct_get(levelMoneyOption, selectedLanguage), 1),
            optionIcon: 2408
        };
    }
    var theItem = ds_map_find_value(ITEMS, choice.id);
    var itemCopy = {};
    variable_struct_copy(theItem, itemCopy);
    var currentLevel = theItem.level;
    var maxLevel = theItem.maxLevel;
    if (currentLevel > -1 && currentLevel < (maxLevel - 1))
    {
        itemCopy.optionName = itemCopy.name + " LV " + string(itemCopy.level + 2);
        itemCopy.optionDescription = itemCopy.alloptionDescription[itemCopy.level + 1];
    }
    return itemCopy;
}

function RandomWeapon(arg0 = 3, arg1 = 0, arg2 = 20)
{
    var roll = irandom(9);
    var levelMoneyOption = 
    {
        eng: ["HoloCoin", "Gain " + string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain))) + " HoloCoins."],
        jp: ["ホロコイン", string(obj_TextController.JPNumbers(string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain))))) + "홀로코인 획득"]
    };
    var selectedLanguage = global.CurrentLanguage;
    var choice;
    if ((roll < arg0 || array_length(weaponsContainer) == 0) && (numberOfOwnedWeapons + arg1) < weaponLimit)
    {
        var i = PickRandomWithWeight(newWeaponsContainer);
        if (i == "error")
        {
            return 
            {
                optionName: global.TextContainer.levelMoneyOption.selectedLanguage[0],
                optionType: "Consumable",
                optionID: "money",
                optionDescription: array_get(variable_struct_get(levelMoneyOption, selectedLanguage), 1),
                optionIcon: 2408
            };
        }
        choice = newWeaponsContainer[i];
        choiceObj = ds_map_find_value(obj_AttackController.attackIndex, choice.id);
        array_delete(newWeaponsContainer, i, 1);
        var modRoll = irandom(array_length(choiceObj.config.availableMods) - 1);
        if (array_length(choiceObj.config.availableMods) > 1)
        {
            var selectedMod = choiceObj.config.availableMods[modRoll];
        }
    }
    else
    {
        var i = PickRandomWithWeight(weaponsContainer);
        choice = weaponsContainer[i];
        array_delete(weaponsContainer, i, 1);
    }
    var attack = ds_map_find_value(obj_AttackController.attackIndex, choice.id);
    var attackCopy = {};
    variable_struct_copy(attack, attackCopy);
    if (ds_map_exists(attacksCopy, ds_map_find_value(obj_AttackController.attackIndex, choice.id).attackID))
    {
        var currentLevel = ds_map_find_value(attacksCopy, choice.id).config.level;
        var maxLevel = ds_map_find_value(attacksCopy, choice.id).config.maxLevel;
        if (currentLevel > 0 && currentLevel < maxLevel)
        {
            var newTooltips = attack.config.levels[currentLevel - 1].config;
            if (variable_struct_exists(newTooltips, "optionIcon"))
            {
                attack.config.optionIcon = newTooltips.optionIcon;
                attackCopy.config.optionIcon = newTooltips.optionIcon;
            }
            attackCopy.config.optionName = newTooltips.optionName;
            attackCopy.config.optionDescription = newTooltips.optionDescription;
        }
    }
    else if (ds_map_find_value(global.PlayerSave, "enchantments") > 0 || global.gameMode == 2)
    {
        if (array_length(attack.config.availableMods) > 0)
        {
            var dropRoll = irandom(99);
            if (dropRoll < arg2)
            {
                attack.config.offeredMod = RollMod(attack.config);
                attackCopy.config.offeredMod = attack.config.offeredMod;
            }
            else
            {
                attack.config.offeredMod = -1;
                attackCopy.config.offeredMod = attack.config.offeredMod;
            }
        }
    }
    return attackCopy.config;
}

function ParseAndPushCommandType(arg0)
{
    var optionType = arg0.optionType;
    switch (optionType)
    {
        case "StatUp":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddStat,
                amount: 1
            });
            break;
        case "Weapon":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddAttack,
                amount: 1
            });
            break;
        case "RemoveWeapon":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: EliminateAttack,
                amount: 1
            });
            break;
        case "RemoveItem":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: RemoveItem,
                amount: 1
            });
            break;
        case "RemoveSkill":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: RemovePerk,
                amount: 1
            });
            break;
        case "Enchant":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddEnchant,
                amount: 1,
                extraArgs: arg0.gainedMods
            });
            break;
        case "Collab":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddCollab,
                amount: 1
            });
            break;
        case "SuperCollab":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddSuperCollab,
                amount: 1
            });
            break;
        case "Skill":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddPerk,
                amount: 1
            });
            break;
        case "Item":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddItem,
                amount: 1
            });
            break;
        case "Consumable":
            if (variable_struct_exists(commandsOnUnpause, arg0.optionID))
            {
                var command = variable_struct_get(commandsOnUnpause, arg0.optionID);
                variable_struct_set(command, "amount", command.amount + 1);
                break;
            }
            variable_struct_set(commandsOnUnpause, arg0.optionID, 
            {
                func: AddConsumable,
                amount: 1
            });
    }
    alarm[9] = 1;
}

function PickRandomWithWeight(arg0)
{
    if (array_length(arg0) == 0)
    {
        if (global.debug)
        {
            throw "Empty container passed into PickRandomWithWeight";
        }
        return "error";
    }
    var start = 0;
    var endR = 0;
    var range = [];
    for (var i = 0; i < array_length(arg0); i++)
    {
        choice = arg0[i];
        var weight = choice.weight;
        var isRerolled = 0;
        weight *= (global.rerolled + 1);
        var rerollKeys = variable_struct_get_names(rerollContainer);
        for (var j = 0; j < array_length(rerollKeys); j++)
        {
            if (rerollKeys[j] == choice.id)
            {
                isRerolled = variable_struct_get(rerollContainer, rerollKeys[j]);
            }
        }
        if (isRerolled)
        {
            weight = weight / (isRerolled + 1);
        }
        endR = weight + start;
        array_push(range, [start, endR, arg0[i].id]);
        start = endR;
    }
    var roll = irandom(endR - 1);
    var choice = "broken";
    for (var i = 0; i < array_length(range); i++)
    {
        start = range[i][0];
        endR = range[i][1];
        if (roll >= start && roll < endR)
        {
            choice = i;
        }
    }
    show_debug_message("Choice is: " + range[choice][2]);
    return choice;
}

function Food()
{
    var option = 
    {
        optionName: global.TextContainer.levelFoodOption.selectedLanguage[0],
        optionType: "Consumable",
        optionID: "food",
        optionDescription: global.TextContainer.levelFoodOption.selectedLanguage[1],
        optionIcon: 1330
    };
    return option;
}

function Money()
{
    var levelMoneyOption = 
    {
        eng: ["HoloCoin", "Gain " + string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain))) + " HoloCoins."],
        jp: ["ホロコイン", string(obj_TextController.JPNumbers(string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain))))) + "홀로코인 획득"],
        Id: ["HoloCoin", "Mendapatkan " + string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain))) + " HoloCoins."]
    };
    var selectedLanguage = global.CurrentLanguage;
    var option = 
    {
        optionName: global.TextContainer.levelMoneyOption.selectedLanguage[0],
        optionType: "Consumable",
        optionID: "money",
        optionDescription: array_get(variable_struct_get(levelMoneyOption, selectedLanguage), 1),
        optionIcon: 2408
    };
    return option;
}

function AddConsumable(arg0)
{
    switch (arg0)
    {
        case "food":
            var amountVal = round((obj_Player.HP * obj_Player.foodMultiplier) / 100);
            Heal(227, amountVal, 0);
            exit;
    }
    switch (arg0)
    {
        case "money":
            global.currentRunMoneyGained += (100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain));
            playerGotMoney = true;
            exit;
    }
}
