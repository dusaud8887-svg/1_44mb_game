function IsCharacterUnlocked(arg0)
{
    var characters = ds_map_find_value(global.PlayerSave, "characters");
    if (characters == undefined)
    {
        return false;
    }
    var charactersLength = array_length(characters);
    var targetCharacter = -1;
    for (var i = 0; i < charactersLength; i++)
    {
        if (characters[i][0] == arg0 && characters[i][0] != "random")
        {
            targetCharacter = i;
            break;
        }
    }
    if (targetCharacter == -1)
    {
        return false;
    }
    return characters[targetCharacter][1] > 0;
}
