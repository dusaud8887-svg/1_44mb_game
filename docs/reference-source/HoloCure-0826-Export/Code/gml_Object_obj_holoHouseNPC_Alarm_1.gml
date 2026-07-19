image_alpha -= 0.02;
if (image_alpha < 0)
{
    array_push(obj_HoloHouseManager.availableNPCs, charID);
    var getChar = ds_map_find_value(global.characterData, charID).charName;
    var textMessage = 
    {
        eng: "[c_holoblue]" + string(getChar) + "[/color]" + " has left.",
        jp: "[c_holoblue]" + string(getChar) + "[/color]" + "이(가) 돌아갔습니다.",
        Id: "[c_holoblue]" + string(getChar) + "[/color]" + " telah pergi."
    };
    var selectedLanguage = global.CurrentLanguage;
    obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
    instance_destroy();
}
alarm[1] = 1;
