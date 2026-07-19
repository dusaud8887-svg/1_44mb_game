farmCheckCD = 300;
alarm[5] = (1 + irandom(2)) * 30;
if (farmInteract != -1 && farmInteract.waterCD == 0)
{
    audio_play_sound(snd_watering, 0, 0);
    with (farmInteract)
    {
        Water();
        var vfx = instance_create_depth(x - 30, y, depth - 50, obj_vfx);
        vfx.sprite_index = spr_watering;
    }
    var getChar = ds_map_find_value(global.characterData, charID).charName;
    var textMessage = 
    {
        eng: "[c_holoblue]" + string(getChar) + "[/color]" + " watered some crops.",
        jp: "[c_holoblue]" + string(getChar) + "[/color]" + "이(가) 식물에 물을 줬습니다.",
        Id: "[c_holoblue]" + string(getChar) + "[/color]" + " menyirami tanaman."
    };
    var selectedLanguage = global.CurrentLanguage;
    obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
}
farmInteract = -1;
