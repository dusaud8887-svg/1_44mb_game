if (instance_number(obj_Player) == 0 && room == global.playingStage)
{
    Init();
}
if (paused || (!paused && !playerCharacter.mouseFollowMode))
{
    display_mouse_unlock();
}
if (variable_global_exists("resetLevel"))
{
    if (global.resetLevel)
    {
        global.resetLevel = false;
        room_persistent = false;
        room_restart();
        with (obj_PlayerManager)
        {
            instance_destroy();
        }
    }
}
cursorTime++;
if (cursorTime >= 10000)
{
    cursorTime = 0;
}
if (room == rm_HoloHouse_Interior)
{
    if (!buildingMode && !fullroom)
    {
        global.new_camera_scale = 2;
    }
    else
    {
        global.new_camera_scale = 1;
    }
}
if (room == rm_HoloHouse_Entrance)
{
    if (autoSaveTimer == 0)
    {
        SaveThings();
        autoSaveTimer = 1800;
    }
    else
    {
        autoSaveTimer--;
    }
}
if (instance_exists(obj_Player) && instance_exists(obj_InputManager) && room != rm_HoloHouse_Interior)
{
    if (obj_InputManager.actionOneDown)
    {
        if (!(obj_Player.interactNear && !variable_struct_exists(obj_Player.buffs, "Sprint")))
        {
            obj_AttackController.ApplyBuff(playerCharacter, "Sprint", ds_map_find_value(obj_AttackController.Buffs, "Sprint"), 
            {
                noDisplay: true
            });
        }
    }
    else
    {
        obj_AttackController.RemoveBuff(playerCharacter, "Sprint");
    }
}
if (blackFlash > 0)
{
    blackFlash -= 0.1;
}
for (var i = 0; i < array_length(HoloHouseMessages); i++)
{
    if (HoloHouseMessages[i][1] > 0)
    {
        HoloHouseMessages[i][1]--;
    }
    else
    {
        array_delete(HoloHouseMessages, i, 1);
    }
}
if (array_length(HoloHouseMessages) == 0)
{
    messagesContainer[0] = -640;
}
else
{
    if (messagesContainer[0] < 5)
    {
        messagesContainer[0] += (5 - messagesContainer[0]) * 0.8;
    }
    if (messagesContainer[1] > 270)
    {
        messagesContainer[1] += (270 - messagesContainer[1]) * 0.8;
    }
}
