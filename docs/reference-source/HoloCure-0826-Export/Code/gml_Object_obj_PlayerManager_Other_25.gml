baseStats = {};
ProgressionStatWeights = 
{
    HP: 4,
    ATK: 0.06,
    SPD: 0.06,
    crit: 2,
    pickupRange: 10,
    haste: 4,
    regen: 1,
    specCDR: 3,
    EXP: 0.04,
    food: 0.04,
    moneyGain: 0.2,
    DR: 0.03,
    skillDamage: 0.04
};
fandomBonuses = [
{
    ATK: 0,
    SPD: 0,
    HP: 0,
    crit: 0
}, 
{
    HP: 5,
    ATK: 0.05,
    SPD: 0.05,
    crit: 0
}, 
{
    HP: 10,
    ATK: 0.1,
    SPD: 0.1,
    crit: 0
}, 
{
    HP: 20,
    ATK: 0.25,
    SPD: 0.25,
    crit: 5
}];
progressionFlags = 
{
    specUnlock: 0,
    challenge: 0
};
statCaps = 
{
    HP: 10,
    ATK: 10,
    SPD: 10,
    crit: 5,
    pickupRange: 10,
    haste: 5,
    regen: 5,
    specCDR: 5,
    EXP: 5,
    food: 5,
    moneyGain: 10,
    DR: 5,
    skillDamage: 10
};
timeModePresets = 
{
    HP: 0,
    ATK: 5,
    SPD: 5,
    crit: 0,
    pickupRange: 0,
    haste: 0,
    regen: 2,
    specCDR: 0,
    EXP: 0,
    food: 0,
    moneyGain: 0,
    DR: 0,
    skillDamage: 0
};

function ApplyProgressionStats()
{
    show_debug_message("APPLYING PROGRESSION STATS");
    baseStats = {};
    var keys = variable_struct_get_names(ProgressionStatWeights);
    if (global.gameMode < 2)
    {
        for (var i = 0; i < array_length(keys); i++)
        {
            var stat = min(variable_struct_get(statCaps, keys[i]), ds_map_find_value(global.PlayerSave, array_get(keys, i)));
            var statWeight = variable_struct_get(ProgressionStatWeights, keys[i]);
            var base = variable_struct_exists(charData, keys[i]) ? variable_struct_get(charData, keys[i]) : 0;
            var charVal = 0;
            var charIndex = -1;
            for (var j = 0; j < array_length(global.characterFollowings); j++)
            {
                if (global.characterFollowings[j][0] == global.charSelected.id)
                {
                    charIndex = j;
                    break;
                }
            }
            if (!ds_map_find_value(global.PlayerSave, "GROff"))
            {
                for (var j = 0; j < array_length(ds_map_find_value(global.PlayerSave, "characters")); j++)
                {
                    if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), j), 0) == global.charSelected.id)
                    {
                        charVal = array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), j), 1);
                    }
                }
            }
            var boosts = min(20, max(0, charVal - 1));
            if (keys[i] == "HP")
            {
                if (ds_map_find_value(global.PlayerSave, "challenge"))
                {
                    variable_struct_set(baseStats, keys[i], 1);
                }
                else
                {
                    variable_struct_set(baseStats, keys[i], base + (stat * statWeight) + boosts + (fandomBonuses[global.characterFollowings[charIndex][1]].HP * ds_map_find_value(global.PlayerSave, "fandom")));
                }
            }
            else if (keys[i] == "ATK")
            {
                variable_struct_set(baseStats, keys[i], base + (stat * statWeight) + (boosts * 0.01) + (fandomBonuses[global.characterFollowings[charIndex][1]].ATK * ds_map_find_value(global.PlayerSave, "fandom")));
            }
            else if (keys[i] == "SPD")
            {
                variable_struct_set(baseStats, keys[i], base + (stat * statWeight) + (boosts * 0.01) + (fandomBonuses[global.characterFollowings[charIndex][1]].SPD * ds_map_find_value(global.PlayerSave, "fandom")));
            }
            else if (keys[i] == "crit")
            {
                variable_struct_set(baseStats, keys[i], base + (stat * statWeight) + (fandomBonuses[global.characterFollowings[charIndex][1]].crit * ds_map_find_value(global.PlayerSave, "fandom")));
            }
            else if (keys[i] == "skillDamage")
            {
                variable_struct_set(baseStats, keys[i], 1 + (stat * statWeight));
            }
            else if (keys[i] == "DR")
            {
                variable_struct_set(baseStats, keys[i], 1 - (stat * statWeight));
            }
            else
            {
                variable_struct_set(baseStats, keys[i], base + (stat * statWeight));
            }
        }
    }
    else
    {
        for (var i = 0; i < array_length(keys); i++)
        {
            var stat = variable_struct_get(timeModePresets, keys[i]);
            var statWeight = variable_struct_get(ProgressionStatWeights, keys[i]);
            var base = variable_struct_exists(charData, keys[i]) ? variable_struct_get(charData, keys[i]) : 0;
            if (keys[i] == "DR")
            {
                variable_struct_set(baseStats, keys[i], 1 - (stat * statWeight));
            }
            else if (keys[i] == "skillDamage")
            {
                variable_struct_set(baseStats, keys[i], 1);
            }
            else
            {
                variable_struct_set(baseStats, keys[i], base + (stat * statWeight));
            }
        }
    }
    keys = variable_struct_get_names(progressionFlags);
    for (var i = 0; i < array_length(keys); i++)
    {
        var flag = ds_map_find_value(global.PlayerSave, array_get(keys, i));
        variable_instance_set(227, keys[i], flag);
    }
}
