isFishing = false;
fishCheckCD = 600;
var roll = irandom(99);
if (roll < 75 && instance_number(obj_FishDrop) < 20)
{
    var fishDrop = instance_create_depth(x, y - 16, depth - 20, obj_FishDrop);
    var theFish = obj_FishingMiniGame.ChooseFish(min(3, ds_map_find_value(global.PlayerSave, "fishRod")));
    fishDrop.theFish = theFish;
    fishDrop.sprite_index = theFish.inventoryIcon;
    fishDrop.catchNumber = 1 + irandom(2);
    soundPlay([205], "npcFish", 10, 0);
    var getChar = ds_map_find_value(global.characterData, charID).charName;
    var textMessage = 
    {
        eng: "[c_holoblue]" + string(getChar) + "[/color]" + " fished up [c_yellow]" + string(fishDrop.catchNumber) + " " + string(theFish.inventoryName) + "[/color].",
        jp: "[c_holoblue]" + string(getChar) + "[/color]" + "이(가) " + "[c_yellow]" + string(theFish.inventoryName) + "을(를) " + string(fishDrop.catchNumber) + "[/color]" + "마리 낚았습니다!",
        Id: "[c_holoblue]" + string(getChar) + "[/color]" + " menangkap [c_yellow]" + string(fishDrop.catchNumber) + " " + string(theFish.inventoryName) + "[/color]."
    };
    var selectedLanguage = global.CurrentLanguage;
    obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
}
