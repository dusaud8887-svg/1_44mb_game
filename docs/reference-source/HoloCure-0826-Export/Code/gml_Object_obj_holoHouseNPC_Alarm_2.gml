if (image_alpha < 1)
{
    if (image_alpha == 0 && !spawnCheck)
    {
        var getChar = ds_map_find_value(global.characterData, charID).charName;
        var textMessage = 
        {
            eng: "[c_holoblue]" + string(getChar) + "[/color]" + " has arrived!",
            jp: "[c_holoblue]" + string(getChar) + "[/color]" + "이(가) 놀러왔습니다!",
            Id: "[c_holoblue]" + string(getChar) + "[/color]" + " telah tiba!"
        };
        var selectedLanguage = global.CurrentLanguage;
        obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
    }
    if (!spawnCheck)
    {
        image_alpha += 0.02;
    }
    alarm[2] = 1;
}
