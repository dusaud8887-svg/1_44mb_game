function SetLanguage(arg0)
{
    global.CurrentLanguage = arg0;
    var keys = variable_struct_get_names(global.TextContainer);
    for (var i = 0; i < array_length(keys); i++)
    {
        var text = variable_struct_get(global.TextContainer, keys[i]);
        var selectedtext = variable_struct_get(text, arg0);
        text.selectedLanguage = selectedtext;
    }
    var ach = instance_find(obj_Achievements, 0);
    if (instance_exists(ach))
    {
        with (ach)
        {
            if (room != rm_InitRoom)
            {
                ResetAchievements();
                LoadAchievements();
            }
        }
    }
    if (!instance_exists(obj_PlayerManager))
    {
        exit;
    }
    var items = obj_PlayerManager.ITEMS;
    var perks = obj_PlayerManager.PERKS;
    var statUps = obj_PlayerManager.statUps;
    var key = ds_map_find_first(items);
    while (!is_undefined(key))
    {
        var item = ds_map_find_value(items, key);
        var itemLevel = (item.level == -1) ? 0 : item.level;
        var optionName = variable_struct_exists(global.TextContainer, item.optionID + "Name") ? variable_struct_get(global.TextContainer, item.optionID + "Name").selectedLanguage : global.TextContainer.stockTooltip.selectedLanguage;
        optionName = optionName + " LV " + string(itemLevel + 1);
        var optionDescription = variable_struct_exists(global.TextContainer, item.optionID + "Description") ? variable_struct_get(global.TextContainer, item.optionID + "Description").selectedLanguage[itemLevel] : global.TextContainer.stockTooltip.selectedLanguage;
        item.optionName = optionName;
        item.optionDescription = optionDescription;
        key = ds_map_find_next(items, key);
    }
    key = ds_map_find_first(perks);
    while (!is_undefined(key))
    {
        var perk = ds_map_find_value(perks, key);
        var perkLevel = (perk.level == -1) ? 0 : perk.level;
        var optionName = variable_struct_exists(global.TextContainer, perk.optionID + "Name") ? variable_struct_get(global.TextContainer, perk.optionID + "Name").selectedLanguage : global.TextContainer.stockTooltip.selectedLanguage;
        optionName = optionName + " LV " + string(perkLevel + 1);
        var optionDescription = variable_struct_exists(global.TextContainer, perk.optionID + "Description") ? variable_struct_get(global.TextContainer, perk.optionID + "Description").selectedLanguage[perkLevel] : global.TextContainer.stockTooltip.selectedLanguage;
        perk.optionName = optionName;
        perk.optionDescription = optionDescription;
        key = ds_map_find_next(perks, key);
    }
    keys = variable_struct_get_names(statUps);
    for (var i = 0; i < array_length(keys); i++)
    {
        var statUp = variable_struct_get(statUps, keys[i]);
        var optionName = variable_struct_exists(global.TextContainer, statUp.optionID + "Name") ? variable_struct_get(global.TextContainer, statUp.optionID + "Name").selectedLanguage : global.TextContainer.stockTooltip.selectedLanguage;
        var optionDescription = variable_struct_exists(global.TextContainer, statUp.optionID + "Description") ? variable_struct_get(global.TextContainer, statUp.optionID + "Description").selectedLanguage : global.TextContainer.stockTooltip.selectedLanguage;
        statUp.optionName = optionName;
        statUp.optionDescription = optionDescription;
    }
    key = ds_map_find_first(global.characterData);
    while (!is_undefined(key))
    {
        if (key == "none" || key == "empty" || key == "random")
        {
        }
        else
        {
            show_debug_message("CHANGING LANGUAGE OF CHARDATA: " + key);
            var character = ds_map_find_value(global.characterData, key);
            character.charName = variable_struct_get(global.TextContainer, character.id + "Name").selectedLanguage;
            character.attack = variable_struct_get(global.TextContainer, character.id + "AttackName").selectedLanguage;
            character.attackDesc = variable_struct_get(global.TextContainer, character.id + "AttackDesc").selectedLanguage;
            character.specName = variable_struct_get(global.TextContainer, character.id + "SpecialAttackName").selectedLanguage;
            character.specDesc = variable_struct_get(global.TextContainer, character.id + "SpecialAttackDesc").selectedLanguage;
        }
        key = ds_map_find_next(global.characterData, key);
    }
    global.charSelected.charName = variable_struct_get(global.TextContainer, global.charSelected.id + "Name").selectedLanguage;
    global.charSelected.attack = variable_struct_get(global.TextContainer, global.charSelected.id + "AttackName").selectedLanguage;
    global.charSelected.attackDesc = variable_struct_get(global.TextContainer, global.charSelected.id + "AttackDesc").selectedLanguage;
    global.charSelected.specName = variable_struct_get(global.TextContainer, global.charSelected.id + "SpecialAttackName").selectedLanguage;
    global.charSelected.specDesc = variable_struct_get(global.TextContainer, global.charSelected.id + "SpecialAttackDesc").selectedLanguage;
    obj_PlayerManager.charName = global.charSelected.charName;
    variable_struct_set(obj_PlayerManager.commandsOnUnpause, "UpdateAttackTooltips", 
    {
        func: UpdateAttackTooltips,
        amount: 1
    });
}

function UpdateAttackTooltips()
{
    var attacks = obj_AttackController.attackIndex;
    var key = ds_map_find_first(attacks);
    while (!is_undefined(key))
    {
        var attack = ds_map_find_value(attacks, key).config;
        var attackLevel = attack.level;
        var optionName = variable_struct_exists(global.TextContainer, attack.optionID + "Name") ? variable_struct_get(global.TextContainer, attack.optionID + "Name").selectedLanguage : global.TextContainer.stockTooltip.selectedLanguage;
        optionName = optionName + " LV " + string(attackLevel + 1);
        var optionDescription = variable_struct_exists(global.TextContainer, attack.optionID + "Description") ? variable_struct_get(global.TextContainer, attack.optionID + "Description").selectedLanguage[attackLevel] : global.TextContainer.stockTooltip.selectedLanguage;
        attack.optionName = optionName;
        attack.optionDescription = optionDescription;
        key = ds_map_find_next(attacks, key);
    }
}
