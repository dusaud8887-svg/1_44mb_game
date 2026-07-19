spriteColor = 16777215;
SPD = 0.3 + random(0.3);
moving = false;
alarm[0] = 30;
direction = irandom(359);
depth = -y - 10;
changeDirCD = 0;
isWorking = false;
workingTimer = 180;
staminaTimer = 600;
nameTag = -1;

function Init()
{
    nameTag = instance_create_depth(x, y, depth, obj_NameTag);
    nameTag.nameString = recruitName;
    nameTag.followCharacterID = self;
    if (currentStamina == 0)
    {
        var textMessage = 
        {
            eng: "[c_yellow]" + string(recruitName) + "[/color] has become [c_red]EXHAUSTED[/color].",
            jp: "[c_yellow]" + string(recruitName) + "[/color]가 [c_red]기력[/color]이 다했습니다!",
            Id: "[c_yellow]" + string(recruitName) + "[/color] mengalami [c_red]Kelelahan![/color]"
        };
        var selectedLanguage = global.CurrentLanguage;
        obj_HoloHouseManager.PopMessage(variable_struct_get(textMessage, selectedLanguage));
    }
}

function ResetName()
{
    nameTag.nameString = recruitName;
}
