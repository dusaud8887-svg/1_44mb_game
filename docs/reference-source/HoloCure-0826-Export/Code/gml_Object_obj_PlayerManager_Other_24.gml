function AddAttack(arg0)
{
    var weapon = variable_struct_get(weapons, arg0);
    var baseAttackConfig = ds_map_find_value(obj_AttackController.attackIndex, arg0).config;
    if (is_undefined(weapon))
    {
        exit;
    }
    if (weapon.level == 0)
    {
        var attacksContainer = playerCharacter.attacks;
        ds_map_set(attacksContainer, arg0, new obj_AttackController.Attack(arg0, baseAttackConfig, {}));
        if (variable_instance_exists(baseAttackConfig, "offeredMod") && baseAttackConfig.offeredMod != -1)
        {
            array_push(baseAttackConfig.gainedMods, ds_map_find_value(attacksContainer, arg0).config.offeredMod);
        }
        InitializeAttack(ds_map_find_value(attacksContainer, arg0));
        ds_map_find_value(attacksContainer, arg0).config.level = 1;
        weapon.level = 1;
    }
    else
    {
        LevelAttack(arg0);
    }
    UpdateAttacks();
    if (baseAttackConfig.optionType != "Skill")
    {
        UpdatePlayer();
    }
}

function AddEnchant(arg0, arg1)
{
    var attack = ds_map_find_value(playerCharacter.attacks, arg0);
    var weapon = variable_struct_get(weapons, arg0);
    attack.config.gainedMods = arg1;
    attack.config.offeredMod = arg1;
    ds_map_find_value(obj_AttackController.attackIndex, arg0).config.gainedMods = arg1;
    UpdateAttacks();
}

function AddCollab(arg0)
{
    var weapon = variable_struct_get(weaponCollabs, arg0);
    var baseAttackConfig = ds_map_find_value(obj_AttackController.attackIndex, arg0).config;
    if (is_undefined(weapon))
    {
        exit;
    }
    if (weapon.level == 0)
    {
        if (collabCount != 3)
        {
            collabCount++;
        }
        else
        {
            DoAchievement("fullCollab");
        }
        var attacksContainer = playerCharacter.attacks;
        ds_map_set(attacksContainer, arg0, new obj_AttackController.Attack(arg0, baseAttackConfig, {}));
        InitializeAttack(ds_map_find_value(attacksContainer, arg0));
        ds_map_find_value(attacksContainer, arg0).config.level = 1;
        weapon.level = 1;
        variable_struct_remove(availableWeaponCollabs, arg0);
        variable_struct_set(weapons, arg0, 
        {
            id: arg0,
            level: 1,
            maxLevel: 1,
            combos: {},
            weight: 0
        });
        if (variable_struct_exists(weapon, "supercombos"))
        {
            global.goldFlag = true;
            var keys = variable_struct_get_names(weapon.supercombos);
            for (var i = 0; i < array_length(keys); i++)
            {
                if (variable_struct_exists(items, keys[i]))
                {
                    if (ds_map_find_value(ITEMS, array_get(keys, i)).level >= (ds_map_find_value(ITEMS, array_get(keys, i)).maxLevel - 1))
                    {
                        var combo = variable_struct_get(weapon.supercombos, keys[i]);
                        variable_struct_set(availableWeaponCollabs, combo, [weapon.id, keys[i]]);
                        if (global.goldenHammer > 0 && !global.goldAnvilCanDrop && global.gameMode != 2 && !ds_map_find_value(global.PlayerSave, "noCollabs"))
                        {
                            global.goldAnvilCanDrop = true;
                        }
                    }
                }
            }
        }
        attacksContainer = playerCharacter.attacks;
        if (array_length(ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods) > 0)
        {
            array_push(baseAttackConfig.gainedMods, ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods[0]);
        }
        if (array_length(ds_map_find_value(attacksContainer, weapon.config.combos[1]).config.gainedMods) > 0)
        {
            array_push(baseAttackConfig.gainedMods, ds_map_find_value(attacksContainer, weapon.config.combos[1]).config.gainedMods[0]);
        }
        RemoveAttack(weapon.config.combos[0], true);
        RemoveAttack(weapon.config.combos[1], true);
        if (global.canGoldenHammer)
        {
            if (global.goldenHammerPieces < 3)
            {
                global.goldenHammerPieces++;
            }
            if (global.goldenHammerPieces >= 3)
            {
                global.goldenHammer = 1;
                global.canGoldenHammer = false;
            }
        }
    }
    else
    {
        LevelCollab(arg0);
    }
    RemoveUnavailableCollabs();
    if (variable_struct_names_count(availableWeaponCollabs) > 0)
    {
        var normalCollabs = false;
        var superCollab = false;
        var collabNames = variable_struct_get_names(availableWeaponCollabs);
        for (var i = 0; i < variable_struct_names_count(availableWeaponCollabs); i++)
        {
            var getWeapon = ds_map_find_value(obj_AttackController.attackIndex, array_get(collabNames, i));
            if (getWeapon.config.optionType == "Collab")
            {
                normalCollabs = true;
            }
            else if (getWeapon.config.optionType == "SuperCollab" && global.goldenHammer > 0)
            {
                superCollab = true;
            }
        }
        if ((normalCollabs || superCollab) && global.gameMode != 2 && !ds_map_find_value(global.PlayerSave, "noCollabs"))
        {
            global.goldAnvilCanDrop = true;
        }
    }
    UpdateAttacks();
    if (baseAttackConfig.optionType != "Skill")
    {
        UpdatePlayer();
    }
}

function AddSuperCollab(arg0)
{
    var weapon = variable_struct_get(weaponCollabs, arg0);
    var baseAttackConfig = ds_map_find_value(obj_AttackController.attackIndex, arg0).config;
    if (is_undefined(weapon))
    {
        exit;
    }
    if (weapon.level == 0)
    {
        var attacksContainer = playerCharacter.attacks;
        ds_map_set(attacksContainer, arg0, new obj_AttackController.Attack(arg0, baseAttackConfig, {}));
        InitializeAttack(ds_map_find_value(attacksContainer, arg0));
        ds_map_find_value(attacksContainer, arg0).config.level = 1;
        weapon.level = 1;
        variable_struct_remove(availableWeaponCollabs, arg0);
        variable_struct_set(weapons, arg0, 
        {
            id: arg0,
            level: 1,
            maxLevel: 1,
            combos: {},
            weight: 0
        });
        attacksContainer = playerCharacter.attacks;
        if (array_length(ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods) == 1)
        {
            array_push(baseAttackConfig.gainedMods, ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods[0]);
        }
        if (array_length(ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods) == 2)
        {
            array_push(baseAttackConfig.gainedMods, ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods[0]);
            array_push(baseAttackConfig.gainedMods, ds_map_find_value(attacksContainer, weapon.config.combos[0]).config.gainedMods[1]);
        }
        RemoveAttack(weapon.config.combos[0], true);
        RemoveOwnedItem(weapon.config.combos[1]);
        ds_map_find_value(ITEMS, weapon.config.combos[1]).collabed = true;
        superCollabs++;
        if (variable_struct_exists(weapon.config, "superCollabEffect"))
        {
            weapon.config.superCollabEffect(playerCharacter);
        }
    }
    else
    {
        LevelCollab(arg0);
    }
    RemoveUnavailableCollabs();
    if (variable_struct_names_count(availableWeaponCollabs) > 0)
    {
        var normalCollabs = false;
        var collabNames = variable_struct_get_names(availableWeaponCollabs);
        for (var i = 0; i < variable_struct_names_count(availableWeaponCollabs); i++)
        {
            var getWeapon = ds_map_find_value(obj_AttackController.attackIndex, array_get(collabNames, i));
            if (getWeapon.config.optionType == "Collab")
            {
                normalCollabs = true;
            }
        }
        if (normalCollabs && global.gameMode != 2 && !ds_map_find_value(global.PlayerSave, "noCollabs"))
        {
            global.goldAnvilCanDrop = true;
        }
    }
    global.goldenHammerPieces = 0;
    UpdateAttacks();
    if (baseAttackConfig.optionType != "Skill")
    {
        UpdatePlayer();
    }
}

function RemoveUnavailableCollabs()
{
    var keys = variable_struct_get_names(availableWeaponCollabs);
    for (var i = 0; i < array_length(keys); i++)
    {
        var collab = variable_struct_get(availableWeaponCollabs, keys[i]);
        for (var k = 0; k < array_length(collab); k++)
        {
            if (!variable_struct_exists(weapons, collab[k]) && !variable_struct_exists(items, collab[k]))
            {
                variable_struct_remove(availableWeaponCollabs, keys[i]);
            }
            else
            {
            }
        }
    }
}

function InitializeAttack(arg0)
{
    arg0.timer = 0;
    arg0.attackDelay = 0;
    arg0.resetTimer = arg0.config.attackTime;
    arg0.attackCount = arg0.config.attackCount + playerCharacter.attackCount;
    arg0.countID = 0;
    arg0.hitLimit = arg0.config.hitLimit + playerCharacter.hitLimit;
    arg0.config.image_xscale = arg0.config.image_xscale * playerCharacter.weaponSizeMultiplier;
    arg0.config.image_yscale = arg0.config.image_yscale * playerCharacter.weaponSizeMultiplier;
    if (variable_struct_exists(arg0.config, "sizeUp"))
    {
        arg0.config.sizeUp = arg0.config.sizeUp * playerCharacter.weaponSizeMultiplier;
    }
    if (variable_struct_exists(arg0.config, "radius"))
    {
        arg0.config.radius = arg0.config.radius * playerCharacter.weaponSizeMultiplier;
    }
}

function LevelAttack(arg0)
{
    var attack = ds_map_find_value(playerCharacter.attacks, arg0);
    var weapon = variable_struct_get(weapons, arg0);
    if (weapon.level < attack.config.maxLevel)
    {
        weapon.level++;
        attack.Level(weapon.level);
        if (weapon.level == attack.config.maxLevel)
        {
            OnWeaponMaxLevel(weapon);
        }
    }
    else
    {
        attack.config.enhancements += 1;
        UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "BlacksmithsGear", "ITEM");
        DoAchievement("dontFail");
    }
}

function LevelCollab(arg0)
{
    var attack = ds_map_find_value(playerCharacter.attacks, arg0);
    attack.config.enhancements += 1;
    UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "BlacksmithsGear", "ITEM");
    DoAchievement("dontFail");
}

eliminatedAttacks = [];

function EliminateAttack(arg0)
{
    array_push(eliminatedAttacks, arg0);
}

function RemoveAttack(arg0, arg1 = false)
{
    if (arg1 == true)
    {
        var attacksContainer = playerCharacter.attacks;
        ds_map_delete(attacksContainer, arg0);
    }
    if (variable_struct_exists(weapons, arg0))
    {
        variable_struct_remove(weapons, arg0);
    }
    if (variable_struct_exists(maxedWeapons, arg0))
    {
        variable_struct_remove(maxedWeapons, arg0);
    }
}

function UpdateAttacks()
{
    var attacks = playerCharacter.attacks;
    var controller = 114;
    attacksCopy = playerCharacter.attacks;
    var key = ds_map_find_first(attacks);
    while (!is_undefined(key))
    {
        if (variable_struct_exists(weapons, key))
        {
            var baseAttack = ds_map_find_value(controller.attackIndex, key);
            var newConfig = {};
            variable_struct_copy(baseAttack.config, newConfig);
            var newAttack = new controller.Attack(key, newConfig);
            newAttack.config.level = variable_struct_get(weapons, key).level;
            if (variable_struct_get(weapons, key).level >= 2)
            {
                newAttack.Level(variable_struct_get(weapons, key).level);
            }
            for (var i = 0; i < array_length(newAttack.config.gainedMods); i++)
            {
                var modLookup = ds_map_find_value(global.AttackModifiers, newAttack.config.gainedMods[i]);
                modLookup.Apply(newAttack.config);
            }
            if (key == global.charSelected.attackID)
            {
                for (var i = 0; i < 3; i++)
                {
                    if (global.currentStickers[i] != -1)
                    {
                        global.currentStickers[i].Apply(newAttack.config);
                    }
                }
            }
            InitializeAttack(newAttack);
            newAttack.timer = ds_map_find_value(attacks, key).timer;
            newAttack.config.enhancements = ds_map_find_value(attacks, key).config.enhancements;
            newAttack.attackCount = ds_map_find_value(attacks, key).attackCount;
            newAttack.countID = ds_map_find_value(attacks, key).countID;
            ds_map_set(attacks, key, newAttack);
        }
        key = ds_map_find_next(attacks, key);
    }
}

Perk = function(arg0, arg1, arg2) constructor
{
    id = arg0;
    level = -1;
    OnApply = arg2;
    name = arg1.optionName;
    if (arg1)
    {
        optionIcon = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
        optionType = "Skill";
        optionName = arg1.optionName;
        optionDescription = variable_struct_exists(arg1, "optionDescription") ? arg1.optionDescription : global.TextContainer.stockTooltip.selectedLanguage;
        optionID = arg0;
    }
    
    function Apply()
    {
        if (OnApply != undefined)
        {
            if (typeof(OnApply) == "array")
            {
                self.OnApply[level]();
            }
            else
            {
                self.OnApply();
            }
        }
    }
    
    function LevelUp()
    {
        if (level >= 2)
        {
            show_debug_message("ERROR, TRYING TO LEVEL PERK " + optionName + " BEYOND 3");
            exit;
        }
        level++;
        if (level < 2)
        {
            optionName = name + " LV " + string(level + 2);
            show_debug_message("tooltip set to: " + optionName);
        }
        else
        {
            variable_struct_remove(obj_PlayerManager.charPerks, id);
        }
        exit;
    }
};

function ApplyPerks()
{
    var keys = variable_struct_get_names(perks);
    for (var i = 0; i < array_length(keys); i++)
    {
        var perk = ds_map_find_value(PERKS, array_get(keys, i));
        perk.Apply();
    }
}

function AddPerk(arg0)
{
    skillissueFlag = false;
    if (ds_map_find_value(PERKS, arg0).level == -1)
    {
        variable_struct_set(perks, arg0, 
        {
            level: 0,
            optionName: ds_map_find_value(PERKS, arg0).name + " LV 1",
            optionIcon: ds_map_find_value(PERKS, arg0).optionIcon,
            optionDescription: ds_map_find_value(PERKS, arg0).optionDescription,
            optionType: ds_map_find_value(PERKS, arg0).optionType,
            optionID: ds_map_find_value(PERKS, arg0).id
        });
        ds_map_find_value(PERKS, arg0).level = 0;
        ds_map_find_value(PERKS, arg0).optionName = ds_map_find_value(PERKS, arg0).name + " LV 2";
        ds_map_find_value(PERKS, arg0).Apply();
    }
    else
    {
        LevelPerk(arg0);
    }
    if (ds_map_find_value(PERKS, arg0).level < 2)
    {
        var descContainer = variable_struct_get(global.TextContainer, ds_map_find_value(PERKS, arg0).id + "Description");
        if (typeof(descContainer.selectedLanguage) == "array")
        {
            ds_map_find_value(PERKS, arg0).optionDescription = array_get(descContainer.selectedLanguage, ds_map_find_value(PERKS, arg0).level + 1);
        }
    }
    UpdatePlayer();
}

function RemovePerk(arg0)
{
    variable_struct_remove(charPerks, arg0);
}

function LevelPerk(arg0)
{
    var level = variable_struct_get(perks, arg0).level;
    if (level == 2)
    {
        exit;
    }
    level++;
    variable_struct_set(perks, arg0, 
    {
        level: level,
        optionName: ds_map_find_value(PERKS, arg0).name + " LV " + string(level + 1),
        optionIcon: ds_map_find_value(PERKS, arg0).optionIcon,
        optionDescription: ds_map_find_value(PERKS, arg0).optionDescription,
        optionType: ds_map_find_value(PERKS, arg0).optionType,
        optionID: ds_map_find_value(PERKS, arg0).id
    });
    ds_map_find_value(PERKS, arg0).LevelUp();
    if (level == 2)
    {
        variable_struct_remove(charPerks, arg0);
    }
}

Item = function(arg0, arg1, arg2 = 5, arg3, arg4, arg5 = false) constructor
{
    id = arg0;
    level = -1;
    maxLevel = arg2;
    OnApply = arg3;
    combos = {};
    OnRemove = arg4;
    name = arg1.optionName;
    optionIcon = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
    optionIcon_Normal = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
    optionIcon_Super = variable_struct_exists(arg1, "optionIcon_Super") ? arg1.optionIcon_Super : 2173;
    optionType = "Item";
    collabed = false;
    optionName = arg1.optionName;
    itemType = arg1.itemType;
    alloptionDescription = variable_struct_exists(arg1, "optionDescription") ? arg1.optionDescription : global.TextContainer.stockTooltip.selectedLanguage;
    optionDescription = alloptionDescription[0];
    optionID = arg0;
    weight = variable_struct_exists(arg1, "weight") ? arg1.weight : 1;
    hasSuper = arg5;
    becomeSuper = false;
    
    function Apply()
    {
        if (OnApply != undefined)
        {
            if (typeof(OnApply) == "array")
            {
                self.OnApply[level]();
            }
            else
            {
                self.OnApply();
            }
        }
    }
    
    function LevelUp()
    {
        if (level >= (maxLevel - 1))
        {
            show_debug_message("ERROR, TRYING TO LEVEL ITEM " + name + " BEYOND MAX LEVEL: " + string(maxLevel));
            exit;
        }
        level++;
        optionDescription = self.alloptionDescription[level];
        optionName = name + " LV " + string(level + 1);
    }
};

function ApplyItems()
{
    var keys = variable_struct_get_names(items);
    for (var i = 0; i < array_length(keys); i++)
    {
        var item = ds_map_find_value(ITEMS, array_get(keys, i));
        item.Apply();
    }
}

function AddItem(arg0)
{
    var item = ds_map_find_value(ITEMS, arg0);
    if (item.itemType == "Healing")
    {
        rawstrengthFlag = false;
    }
    barebonesFlag = false;
    if (item.level == -1)
    {
        variable_struct_set(items, arg0, 0);
        if (item.becomeSuper)
        {
            ds_map_find_value(ITEMS, arg0).level = ds_map_find_value(ITEMS, arg0).maxLevel;
            DoAchievement("luckyDay");
        }
        else
        {
            ds_map_find_value(ITEMS, arg0).level = 0;
        }
        ds_map_find_value(ITEMS, arg0).Apply();
    }
    else
    {
        LevelItem(arg0);
    }
    UpdatePlayer();
}

function LevelItem(arg0)
{
    var level = variable_struct_get(items, arg0);
    ds_map_find_value(ITEMS, arg0).LevelUp();
    variable_struct_set(items, arg0, level++);
    if (variable_struct_exists(ds_map_find_value(ITEMS, arg0), "supercombos"))
    {
        var keys = variable_struct_get_names(ds_map_find_value(ITEMS, arg0).supercombos);
        for (var i = 0; i < array_length(keys); i++)
        {
            if (variable_struct_exists(weapons, keys[i]))
            {
                if (ds_map_find_value(ITEMS, arg0).level >= (ds_map_find_value(ITEMS, arg0).maxLevel - 1))
                {
                    var combo = variable_struct_get(ds_map_find_value(ITEMS, arg0).supercombos, keys[i]);
                    variable_struct_set(availableWeaponCollabs, combo, [keys[i], arg0]);
                    if (global.goldenHammer > 0 && !global.goldAnvilCanDrop && global.gameMode != 2 && !ds_map_find_value(global.PlayerSave, "noCollabs"))
                    {
                        global.goldAnvilCanDrop = true;
                    }
                }
            }
        }
    }
}

function RemoveItem(arg0)
{
    array_push(removedItems, arg0);
}

function RemoveOwnedItem(arg0)
{
    if (variable_struct_exists(items, arg0))
    {
        variable_struct_remove(items, arg0);
    }
}

Sticker = function(arg0, arg1, arg2, arg3, arg4 = 3) constructor
{
    id = arg0;
    level = 0;
    maxLevel = arg4;
    name = arg1.optionName;
    OnApply = arg2;
    OnRemove = arg3;
    optionIcon = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
    optionIcon_Normal = variable_struct_exists(arg1, "optionIcon") ? arg1.optionIcon : 2173;
    optionType = "Stamp";
    optionName = arg1.optionName + " LV 1";
    allDescription = variable_struct_exists(arg1, "optionDescription") ? arg1.optionDescription : global.TextContainer.stockTooltip.selectedLanguage;
    optionDescription = allDescription[0];
    optionID = arg0;
    weight = variable_struct_exists(arg1, "weight") ? arg1.weight : 1;
    
    function Apply(arg0)
    {
        if (OnApply != undefined)
        {
            if (typeof(OnApply) == "array")
            {
                self.OnApply[level](arg0);
            }
            else
            {
                self.OnApply(arg0);
            }
        }
    }
    
    function LevelUp()
    {
        if (level >= (maxLevel - 1))
        {
            show_debug_message("ERROR, TRYING TO LEVEL STAMP  " + name + " BEYOND MAX LEVEL: " + string(maxLevel));
            exit;
        }
        level++;
        if (level < (maxLevel - 1))
        {
            optionName = name + " LV " + string(level + 1);
        }
        else
        {
            optionName = name + " LV MAX";
        }
        optionDescription = self.allDescription[level];
    }
};

function AddStat(arg0)
{
    var currentStat = variable_struct_get(playerStatUps, arg0);
    variable_struct_set(playerStatUps, arg0, currentStat + 1);
    UpdatePlayer();
    if (arg0 == "HP")
    {
        playerCharacter.currentHP += statUpMultipliers.HP;
        obj_PlayerManager.hpSus = playerCharacter.currentHP - 1;
    }
    if (arg0 == "haste")
    {
        oraoraCount++;
        if (oraoraCount >= 10)
        {
            DoAchievement("oraora");
            UnlockThing(ds_map_find_value(global.PlayerSave, "unlockedItems"), "Candy", "ITEM");
        }
    }
}

function ResetPlayer()
{
    playerCharacter.DB = 0;
    playerCharacter.DR = 1;
    playerCharacter.weaponSizeMultiplier = 1;
    playerCharacter.knockbackMultiplier = 1;
    playerCharacter.healMultiplier = 1;
    playerCharacter.BonusDamageTaken = 0;
    playerCharacter.CritVuln = 0;
    playerCharacter.CritMod = 0.5;
    playerCharacter.specMod = 1;
    playerCharacter.bonusProjectiles = 0;
    playerCharacter.expMultiplier = 1;
    global.moneyMultiplier = 1;
    playerCharacter.weaponBonus = 0;
    playerCharacter.skillDamage = 1;
}

function UpdateStats()
{
    var keys = variable_struct_get_names(baseStats);
    for (var i = 0; i < array_length(keys); i++)
    {
        var newStat = variable_struct_get(baseStats, keys[i]);
        variable_instance_set(playerCharacter, keys[i], newStat);
    }
    keys = variable_struct_get_names(playerStatUps);
    for (var i = 0; i < array_length(keys); i++)
    {
        var baseStat = variable_struct_get(baseStats, keys[i]);
        var multiplier = variable_struct_get(statUpMultipliers, keys[i]);
        var amount = variable_struct_get(playerStatUps, keys[i]);
        var newStat;
        if (keys[i] != "HP")
        {
            newStat = baseStat + (amount * multiplier);
        }
        else if (global.charSelected.id == "aqua" && amount == 0)
        {
            newStat = baseStat + ((baseStat * (amount * multiplier)) / 100);
        }
        else
        {
            newStat = floor(baseStat + ((baseStat * (amount * multiplier)) / 100));
        }
        if (keys[i] == "HP")
        {
            if (ds_map_find_value(global.PlayerSave, "challenge") && global.gameMode < 2)
            {
                variable_struct_set(playerCharacter, keys[i], 1);
            }
            else
            {
                variable_struct_set(playerCharacter, keys[i], newStat);
            }
        }
        else
        {
            variable_instance_set(playerCharacter, keys[i], newStat);
        }
    }
}

playerStatUps = 
{
    HP: 0,
    ATK: 0,
    SPD: 0,
    crit: 0,
    pickupRange: 0,
    haste: 0
};
statUpMultipliers = 
{
    HP: 10,
    ATK: 0.08,
    SPD: 0.12,
    crit: 3,
    pickupRange: 20,
    haste: 5
};
statUps = 
{
    HP: 
    {
        optionIcon: 998,
        optionType: "StatUp",
        optionName: global.TextContainer.HPName.selectedLanguage,
        optionDescription: global.TextContainer.HPDescription.selectedLanguage,
        optionID: "HP",
        weight: 2
    },
    ATK: 
    {
        optionIcon: 712,
        optionType: "StatUp",
        optionName: global.TextContainer.ATKName.selectedLanguage,
        optionDescription: global.TextContainer.ATKDescription.selectedLanguage,
        optionID: "ATK",
        weight: 3
    },
    SPD: 
    {
        optionIcon: 1894,
        optionType: "StatUp",
        optionName: global.TextContainer.SPDName.selectedLanguage,
        optionDescription: global.TextContainer.SPDDescription.selectedLanguage,
        optionID: "SPD",
        weight: 4
    },
    crit: 
    {
        optionIcon: 351,
        optionType: "StatUp",
        optionName: global.TextContainer.critName.selectedLanguage,
        optionDescription: global.TextContainer.critDescription.selectedLanguage,
        optionID: "crit",
        weight: 3
    },
    pickupRange: 
    {
        optionIcon: 1614,
        optionType: "StatUp",
        optionName: global.TextContainer.pickupRangeName.selectedLanguage,
        optionDescription: global.TextContainer.pickupRangeDescription.selectedLanguage,
        optionID: "pickupRange",
        weight: 4
    },
    haste: 
    {
        optionIcon: 821,
        optionType: "StatUp",
        optionName: global.TextContainer.hasteName.selectedLanguage,
        optionDescription: global.TextContainer.hasteDescription.selectedLanguage,
        optionID: "haste",
        weight: 2
    }
};
global.basedamage = 10;
perks = {};
items = {};
if (ds_map_find_value(global.PlayerSave, "challenge") > 0)
{
    statUps.HP.weight = 0;
}

function UpdatePlayer()
{
    ResetPlayer();
    UpdateStats();
    ApplyPerks();
    ApplyItems();
    UpdateAttacks();
    ApplyBuffs();
    SnapshotStats();
}

function SnapshotStats()
{
    playerCharacter.prebuffStats = 
    {
        HP: playerCharacter.HP,
        ATK: playerCharacter.ATK,
        SPD: playerCharacter.SPD,
        crit: playerCharacter.crit,
        DB: playerCharacter.DB,
        DR: playerCharacter.DR,
        pickupRange: playerCharacter.pickupRange,
        haste: playerCharacter.haste,
        bonusProjectiles: playerCharacter.bonusProjectiles,
        weaponBonus: playerCharacter.weaponBonus,
        skillDamage: playerCharacter.skillDamage,
        CritMod: playerCharacter.CritMod
    };
    if (!sussy)
    {
        bigstuffs = [playerCharacter.HP, playerCharacter.ATK, playerCharacter.SPD, playerCharacter.crit, playerCharacter.pickupRange, playerCharacter.haste, playerCharacter.CritMod];
    }
}

function ApplyBuffs()
{
    var buffs = playerCharacter.buffs;
    var keys = variable_struct_get_names(buffs);
    for (var i = 0; i < array_length(keys); i++)
    {
        var buff = variable_struct_get(buffs, keys[i]);
        var buffTimer = buff.timer;
        buff.Apply(playerCharacter, buff.config);
        var newBuff = variable_struct_get(buffs, keys[i]);
        newBuff.timer = buffTimer;
    }
}

function UpdateBuffIfExists(arg0, arg1)
{
    if (!variable_struct_exists(playerCharacter.buffs, arg0))
    {
        exit;
    }
    var keys = variable_struct_get_names(arg1);
    for (var i = 0; i < array_length(keys); i++)
    {
        var buff = variable_struct_get(playerCharacter.buffs, arg0);
        if (keys[i] != "stacks")
        {
            variable_struct_set(buff.config, keys[i], variable_struct_get(arg1, keys[i]));
        }
    }
}

event_user(12);
event_user(11);
