function RollMod(arg0)
{
    if (array_length(arg0.availableMods) > 0)
    {
        var alreadyHasMod = "";
        if (array_length(arg0.gainedMods) == 1)
        {
            alreadyHasMod = arg0.gainedMods[0];
        }
        var weightedRoll = [];
        for (var i = 0; i < array_length(arg0.availableMods); i++)
        {
            var theMod = ds_map_find_value(global.AttackModifiers, arg0.availableMods[i]);
            for (var j = 0; j < theMod.weight; j++)
            {
                if (theMod.optionID != alreadyHasMod)
                {
                    array_push(weightedRoll, theMod.optionID);
                }
            }
        }
        var modRoll = irandom(array_length(weightedRoll) - 1);
        var selectedMod = weightedRoll[modRoll];
        return selectedMod;
    }
    else if (variable_instance_exists(arg0, "combos"))
    {
        var weapon1 = ds_map_find_value(global.attacksLibrary, arg0.combos[0]).config;
        if (weapon1.optionType == "Collab")
        {
            var subWeapon1 = ds_map_find_value(global.attacksLibrary, weapon1.combos[0]).config;
            var subWeapon2 = ds_map_find_value(global.attacksLibrary, weapon1.combos[1]).config;
            weapon1.availableMods = array_concat(subWeapon1.availableMods, subWeapon2.availableMods);
        }
        var weapon2 = 
        {
            availableMods: []
        };
        if (!is_undefined(ds_map_find_value(global.attacksLibrary, arg0.combos[1])))
        {
            weapon2 = ds_map_find_value(global.attacksLibrary, arg0.combos[1]).config;
        }
        var comboAvailableMods = array_concat(weapon1.availableMods, weapon2.availableMods);
        var weightedRoll = [];
        for (var i = 0; i < array_length(comboAvailableMods); i++)
        {
            var theMod = ds_map_find_value(global.AttackModifiers, array_get(comboAvailableMods, i));
            for (var j = 0; j < theMod.weight; j++)
            {
                if (!array_exists(weightedRoll, comboAvailableMods[i]))
                {
                    array_push(weightedRoll, theMod.optionID);
                }
            }
        }
        var modRoll = irandom(array_length(weightedRoll) - 1);
        var selectedMod = weightedRoll[modRoll];
        return selectedMod;
    }
    else
    {
        return -1;
    }
}
