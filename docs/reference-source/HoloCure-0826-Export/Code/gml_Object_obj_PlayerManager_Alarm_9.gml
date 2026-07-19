var keys = variable_struct_get_names(commandsOnUnpause);
for (var i = 0; i < array_length(keys); i++)
{
    var command = variable_struct_get(commandsOnUnpause, keys[i]);
    var func = command.func;
    var amount = command.amount;
    for (var i2 = 0; i2 < amount; i2++)
    {
        if (variable_struct_exists(command, "extraArgs"))
        {
            func(keys[i], command.extraArgs);
        }
        else
        {
            func(keys[i]);
        }
    }
    variable_struct_remove(commandsOnUnpause, keys[i]);
}
if (playerGotMoney)
{
    playerGotMoney = false;
    playerCharacter.OnPickUp(playerCharacter, "HoloCoin", false);
}
